package com.bpm.framework.controller.v4.enterprise;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 核心企业账户总览
 * 
 * @author pc
 *
 */
@Controller
@RequestMapping("/enterpriseAccountOverviewController")
public class EnterpriseAccountOverviewController extends AbstractController {

	private static final long serialVersionUID = -7770611307544545499L;

	/**
	 * 账户总览 页面跳转与数据展示
	 * 
	 * @return 账户总览页面
	 */
	@RequestMapping("/accountOverview.htm")
	public String accountOverview() {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// (2)获取参数值
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("param", user.getBusinessId());
		maps.put("sign", "queryAccountOverviewInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAccountOverviewManagement", maps);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					// 累计还款与累计保理融资费
					String resultString = output.getString("result");
					Map<String, Object> map = JsonUtils.toMap(resultString);
					ControllerUtils.getRequest().setAttribute("actualAmount", map.get("actualAmount"));
					ControllerUtils.getRequest().setAttribute("repaymentInterest", map.get("repaymentInterest"));
					super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
				} else {
					super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
				}
			}
		} else {
			super.log.error("用户信息参数错误");
		}
		return "ybl4.0/admin/enterprise/accountOverview";
	}

	/**
	 * 核心企业账户总览日历展现数据
	 * 
	 * @param dd
	 *            需要展示的月份
	 * @return 展示数据
	 */
	@RequestMapping(value = "/queryRepaymentPlan")
	@ResponseBody
	@Log(operation = OperationType.Exe, info = "查询当月待还款数据")
	public ControllerResponse queryRepaymentPlan(String dd) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		Date date = null;
		// (1)条件数据
		DateFormat sdf = new SimpleDateFormat("yyyy-MM");
		try {
			date = sdf.parse(dd);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		repaymentPlanVo.setBusinessId(user.getBusinessId());
		repaymentPlanVo.setRepaymentDate(date); // repaymentDate
		Map<String, Object> map = new HashMap<String, Object>();
		// (2)调用服务，进行数据查询
		map.put("param", repaymentPlanVo);
		map.put("sign", "queryRepaymentPlanInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAccountOverviewManagement", map);
		response.setResponseType(ResponseType.SUCCESS);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					// 还款日期
					String repaymentPlanJson = output.getString("repaymentPlan");
					List<FactorCollectionManagementRepaymentPlanVo> repaymentPlan = JsonUtils.toList(repaymentPlanJson,
							FactorCollectionManagementRepaymentPlanVo.class);
					//计算每笔应还账款，a、如果没逾期，取‘应还本金’加‘应还利息’；b、如果逾期，取‘应还本金’加‘应还利息’再加‘逾期费用’， 逾期费用=（逾期金额 * 逾期利率）/360 *逾期天数 ， 逾期金额=应还本金
					for (int i = 0, j = repaymentPlan.size(); i < j; i++) {
						BigDecimal repaymentPrincipal = repaymentPlan.get(i).getRepaymentPrincipal();// 应还本金
						BigDecimal repaymentInterest = repaymentPlan.get(i).getRepaymentInterest();// 应还利息
						BigDecimal amount = repaymentInterest.add(repaymentPrincipal);// 应还本息
						// 逾期计算
						Long repaymentDate = DateUtils.dayDiff(new Date(), repaymentPlan.get(i).getRepaymentDate());//逾期天数
						if (repaymentDate.longValue() > 0) {// 是否逾期 逾期费用=（逾期金额 * 逾期利率）/360 *逾期天数
							BigDecimal overdueInterestRate = repaymentPlan.get(i).getOverdueInterestRate().divide(new BigDecimal(100));//逾期利率
							BigDecimal temp = repaymentPrincipal.multiply(overdueInterestRate);//（逾期金额 * 逾期利率）
							BigDecimal temp1 = temp.divide(new BigDecimal(360),4).multiply(new BigDecimal(repaymentDate));
							amount = amount.add(temp1);// 加上逾期利息
						}
						repaymentPlan.get(i).setRepaymentPrincipal(amount);// 将应还本息存放到应还本金字段中
					}
					response.setObject(repaymentPlan);// 设置返回结果
					response.setInfo("查询成功");
					super.log.info("queryRepaymentPlan服务调用信息：" + erortx);
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo("查询失败");
					super.log.error("queryRepaymentPlan服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("调用服务失败");// 调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}
}
