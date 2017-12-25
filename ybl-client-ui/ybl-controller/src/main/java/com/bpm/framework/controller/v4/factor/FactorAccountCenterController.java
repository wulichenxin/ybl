package com.bpm.framework.controller.v4.factor;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_REPAYMENT_STATUS;
import cn.sunline.framework.util.Arith;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 资金方账户中心控制器
 *
 */
@Controller
@RequestMapping({ "/factorAccountCenterController" })
public class FactorAccountCenterController extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7932423858751280692L;
	/**
	 * 跳转到账户总览
	 * @return
	 */
	@RequestMapping("/myAccount.htm")
	public String toMyAccount(String month) {
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		
		
		FactorCollectionManagementRepaymentPlanVo rp = new FactorCollectionManagementRepaymentPlanVo();
		rp.setPayeeBusinessId(userVo.getBusinessId());
		rp.setAttribute2("1,2,3");//查状态是待还款,已还款,逾期的还款计划
		BigDecimal totalIncome  = new BigDecimal(0);//累计收益=累计逾期费用 +累计已还利息
		BigDecimal totalOverdueFee = new BigDecimal(0);//累计逾期费用
		BigDecimal totalrepaymentInterest = new BigDecimal(0);//累计已还利息
		BigDecimal totalPrincipal  = new BigDecimal(0);//待收本金
		BigDecimal totalUnInterest  = new BigDecimal(0);//待收利息
		BigDecimal allMount  = new BigDecimal(0);//总资产
		//账户总览信息
		List<FactorCollectionManagementRepaymentPlanVo> list = queryUserMoneyByMemberId(rp);
		if(CollectionUtils.isNotEmpty(list)) {
			for (FactorCollectionManagementRepaymentPlanVo frp : list) {
				//状态是2-已还款 时收益
				if(E_V4_REPAYMENT_STATUS.REPAYMENTED.getStatus() == frp.getRepaymentStatus().intValue() ) {
					totalOverdueFee = totalOverdueFee.add(Arith.round(Arith.mul(Arith.div(Arith.mul(frp.getRepaymentPrincipal().doubleValue(),Arith.div(frp.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),frp.getOverdueDays()), 2));

					totalrepaymentInterest = totalrepaymentInterest.add(frp.getRepaymentInterest());
				}
				//状态是1待还款,3逾期时应还本金为待收本金
				if(E_V4_REPAYMENT_STATUS.PENDING_REPAYMENT.getStatus() == frp.getRepaymentStatus().intValue() || E_V4_REPAYMENT_STATUS.OVERDUE.getStatus() == frp.getRepaymentStatus().intValue()) {
					totalPrincipal = totalPrincipal.add(frp.getRepaymentPrincipal());
					//状态是1待还款,3逾期时应还本息为待收利息
					totalUnInterest = totalUnInterest.add(frp.getRepaymentInterest());
				}
				
			}
		}
		allMount = totalPrincipal.add(totalUnInterest);
		totalIncome = totalOverdueFee .add(totalrepaymentInterest);
		getRequest().setAttribute("totalIncome", totalIncome);
		getRequest().setAttribute("totalPrincipal", totalPrincipal);
		getRequest().setAttribute("totalUnInterest", totalUnInterest);
		getRequest().setAttribute("allMount", allMount);
		
		return "ybl4.0/admin/factor/accountCenter/accountMessage";
	}
	
	@RequestMapping(value = "/queryMonthRepaymentPlan")
	@ResponseBody
	@Log(operation=OperationType.Exe,info="查询当月回款数据")
	public ControllerResponse queryRepaymentPlan(String dd) {
		ControllerResponse response = new ControllerResponse(ResponseType.SUCCESS);
		UserVo user = ControllerUtils.getCurrentUser();
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		repaymentPlanVo.setPayeeBusinessId(user.getBusinessId());
		String[] ddl = dd.split("-");
		if(ddl[1].length() == 1) {
			dd = ddl[0] + "-0" + ddl[1]; 
		}
		repaymentPlanVo.setAttribute1(dd); //repaymentDate
		repaymentPlanVo.setAttribute2("1,3");//查待还款和逾期的还款计划
		List<FactorCollectionManagementRepaymentPlanVo> list = queryUserMoneyByMemberId(repaymentPlanVo);
		if(CollectionUtils.isNotEmpty(list)) {
			for(int i = 0 ,j = list.size() ; i < j ; i++){
				BigDecimal repaymentPrincipal = list.get(i).getRepaymentPrincipal();//应还本金 = repaymentPlan.get(i).getRepaymentPrincipal();
				BigDecimal repaymentInterest = list.get(i).getRepaymentInterest();//应还利息
				BigDecimal amount = repaymentInterest.add(repaymentPrincipal);//应还本息
				list.get(i).setRepaymentPrincipal(amount);//将应还本息存放到 应还本金字段中
			}
		}
		response.setObject(list);
		response.setInfo("查询成功");
		return response;
	}
	
	/**
	 * 根据资金方企业查还款计划
	 * @param repayStatus
	 * @return
	 */
	private List<FactorCollectionManagementRepaymentPlanVo> queryUserMoneyByMemberId(FactorCollectionManagementRepaymentPlanVo rp){

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("repaymentPlan", rp);
		ResBody result = TradeInvokeUtils.invoke("V4FactorAllRepaymentPlanManagement", map);
		List<FactorCollectionManagementRepaymentPlanVo> repaymentReturnList=null;
 		if(result!=null && result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("repaymentPlans");
				repaymentReturnList=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
				super.log.info("根据资金方企业查还款计划调用V4FactorAllRepaymentPlanManagement服务成功，信息：" + erortx);
			}			
		}
 		return repaymentReturnList;
	}
}
