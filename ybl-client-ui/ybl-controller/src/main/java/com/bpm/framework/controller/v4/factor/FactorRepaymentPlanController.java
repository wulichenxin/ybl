package com.bpm.framework.controller.v4.factor;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_REPAYMENT_STATUS;
import cn.sunline.framework.util.Arith;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理4.0用户资金方还款计划管理
 */
@Controller
@RequestMapping({ "/factorRepaymentPlanController" })
public class FactorRepaymentPlanController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 资金方分页查询坏账列表
	 * 登录用户企业的未还款完成的还款计划进行了转坏账操作的还款计划列表
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "null" })
	@RequestMapping(value = "/badDept/list.htm")
	public String list(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,FactorCollectionManagementRepaymentPlanVo vo,@Param("startDate")String startDate,@Param("endDate")String endDate) {
		Map<String,Object> map = new HashMap<String,Object>();
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		//设置查询条件
		repaymentPlanVo.setRepaymentStatus(E_V4_REPAYMENT_STATUS.BAD_DEBT.getStatus());//坏账状态
		if(null != startDate && startDate != ""){
			//开始时间
			repaymentPlanVo.setStartDate(startDate);
		}
		if(null != endDate && endDate != ""){
			//结束时间
			repaymentPlanVo.setEndDate(endDate);
		}
		if(null != vo.getLoanApplyOrderNo() && vo.getLoanApplyOrderNo() != ""){
			//订单号
			repaymentPlanVo.setLoanApplyOrderNo(vo.getLoanApplyOrderNo());
		}
		/*根据登陆资金方ID过滤*/
		HttpSession session = getSession();
		UserVo user = (UserVo)session.getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			repaymentPlanVo.setFactor(user.getEnterpriseId());
		}
		
		map.put("repaymentPlan",repaymentPlanVo);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRepaymentPlanManagement", map);
		PageVo page=null;
		List<FactorCollectionManagementRepaymentPlanVo> list=new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("坏账分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("repaymentPlanList");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				if(records != null){
					list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
					//计算逾期费用和天数
					Date now = new Date();
					if(null != list && list.size() > 0){
						for (int i = 0;i< list.size();i++) {
							FactorCollectionManagementRepaymentPlanVo repayPlan = (FactorCollectionManagementRepaymentPlanVo) list.get(i);
							repayPlan.setOverdueDays(Long.valueOf(DateUtils.dayDiff(repayPlan.getActualRepaymentDate()==null?now:repayPlan.getActualRepaymentDate(),repayPlan.getRepaymentDate())).intValue());
							if(repayPlan.getOverdueDays().intValue() <= 0) {
								repayPlan.setOverdueDays(0);
								repayPlan.setOverdueFee(BigDecimal.ZERO);
							}
							//逾期费用=（逾期金额 * 逾期利率）*逾期天数/360
							repayPlan.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(repayPlan.getRepaymentPrincipal().doubleValue(),Arith.div(repayPlan.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),repayPlan.getOverdueDays()), 2));
						}
					}
				}
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		return "ybl4.0/admin/factor/repaymentPlan/badDebt/list";
	}
	
	/**
	 * 申请代办界面暂时为空
	 */
	@RequestMapping(value = "/agencyApply.htm")
	public String agencyApply() {
		return "ybl4.0/admin/factor/repaymentPlan/badDebt/agencyApply";
	}
	
	/**
	 * 待回款项目分页列表
	 * 资金方登录用户的未还款完成的还款计划列表，即查询未还款和已还款未确认状态的还款计划列表
	 */
	@SuppressWarnings({ "rawtypes", "null" })
	@RequestMapping(value = "/pendingPayment.htm")
	public String pendingPayment(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,FactorCollectionManagementRepaymentPlanVo vo,@Param("startDate")String startDate,@Param("endDate")String endDate) {
		Map<String,Object> map = new HashMap<String,Object>();
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		//设置查询条件
		repaymentPlanVo.setConfirmStatus(1);//未确认
		if(null != vo.getRepaymentStatus()){
			repaymentPlanVo.setRepaymentStatus(vo.getRepaymentStatus());
		}
		if(null != startDate && startDate != ""){
			//开始时间
			repaymentPlanVo.setStartDate(startDate);
		}
		if(null != endDate && endDate != ""){
			//结束时间
			repaymentPlanVo.setEndDate(endDate);
		}
		if(null != vo.getLoanApplyOrderNo() && vo.getLoanApplyOrderNo() != ""){
			//订单号
			repaymentPlanVo.setLoanApplyOrderNo(vo.getLoanApplyOrderNo());
		}
		
		repaymentPlanVo.setAttribute2("1,2");
		
		//根据登陆资金方ID过滤
		HttpSession session = getSession();
		UserVo user = (UserVo)session.getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			repaymentPlanVo.setFactor(user.getEnterpriseId());
		}
		
		map.put("repaymentPlan",repaymentPlanVo);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRepaymentPlanManagement", map);
		PageVo page=null;
		List<FactorCollectionManagementRepaymentPlanVo> list=new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("待回款项目分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("repaymentPlanList");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
				//状态为未还款(1、待还款/2、已还款未确认)的还款记录
				//计算逾期费用和天数
				Date now = new Date();
				if(null != list && list.size() > 0){
					for (int i = 0;i< list.size();i++) {
						FactorCollectionManagementRepaymentPlanVo repayPlan = (FactorCollectionManagementRepaymentPlanVo) list.get(i);
						repayPlan.setOverdueDays(Long.valueOf(DateUtils.dayDiff(repayPlan.getActualRepaymentDate()==null?now:repayPlan.getActualRepaymentDate(),repayPlan.getRepaymentDate())).intValue());
						if(repayPlan.getOverdueDays().intValue() <= 0) {
							repayPlan.setOverdueDays(0);
							repayPlan.setOverdueFee(BigDecimal.ZERO);
						}
						//逾期费用=（逾期金额 * 逾期利率）*逾期天数/360 
						repayPlan.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(repayPlan.getRepaymentPrincipal().doubleValue(),Arith.div(repayPlan.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),repayPlan.getOverdueDays()), 2));
					}
				}
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		return "ybl4.0/admin/factor/repaymentPlan/pendingPayment/list";
	}
	/**
	 * 已逾期还款计划
	 * @param pageVo
	 * @param vo
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/overdue.htm")
	public String overdue(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,FactorCollectionManagementRepaymentPlanVo vo,@Param("startDate")String startDate,@Param("endDate")String endDate) throws ParseException {
		Map<String,Object> map = new HashMap<String,Object>();
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		//设置查询条件
		repaymentPlanVo.setRepaymentStatus(E_V4_REPAYMENT_STATUS.OVERDUE.getStatus());//已逾期状态
		if(null != startDate && startDate != ""){
			//开始时间
			repaymentPlanVo.setStartDate(startDate);
		}
		if(null != endDate && endDate != ""){
			//结束时间
			repaymentPlanVo.setEndDate(endDate);
		}
		if(null != vo.getLoanApplyOrderNo() && vo.getLoanApplyOrderNo() != ""){
			//订单号
			repaymentPlanVo.setLoanApplyOrderNo(vo.getLoanApplyOrderNo());
		}
		//根据登陆资金方ID过滤
		HttpSession session = getSession();
		UserVo user = (UserVo)session.getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			repaymentPlanVo.setFactor(user.getEnterpriseId());
		}
		
		map.put("repaymentPlan",repaymentPlanVo);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRepaymentPlanManagement", map);
		PageVo page=null;
		List<FactorCollectionManagementRepaymentPlanVo> list=new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("待回款项目分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("repaymentPlanList");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<FactorCollectionManagementRepaymentPlanVo> factList = new ArrayList<>();
				if(null != records){
					factList=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
					for(FactorCollectionManagementRepaymentPlanVo repayPlan:factList){
						if(repayPlan.getRepaymentStatus()==E_V4_REPAYMENT_STATUS.OVERDUE.getStatus()){
							list.add(repayPlan);
						}else if(repayPlan.getRepaymentStatus()==E_V4_REPAYMENT_STATUS.PENDING_REPAYMENT.getStatus()){
							//未还款但是实际已逾期还款计划(定时任务失效)
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							String today = sdf.format(new Date());
							Date day = sdf.parse(today);
							if(repayPlan.getRepaymentDate().getTime() < day.getTime()){
								//还款时间已逾期
								list.add(repayPlan);
							}
						}
					}
				}
				//计算逾期费用和天数
				Date now = new Date();
				if(null != list && list.size() > 0){
					for (int i = 0;i< list.size();i++) {
						FactorCollectionManagementRepaymentPlanVo repayPlan = (FactorCollectionManagementRepaymentPlanVo) list.get(i);
						repayPlan.setOverdueDays(Long.valueOf(DateUtils.dayDiff(repayPlan.getActualRepaymentDate()==null?now:repayPlan.getActualRepaymentDate(),repayPlan.getRepaymentDate())).intValue());
						if(repayPlan.getOverdueDays().intValue() <= 0) {
							repayPlan.setOverdueDays(0);
							repayPlan.setOverdueFee(BigDecimal.ZERO);
						}
						//逾期费用=（逾期金额 * 逾期利率）*逾期天数/360 
						repayPlan.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(repayPlan.getRepaymentPrincipal().doubleValue(),Arith.div(repayPlan.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),repayPlan.getOverdueDays()), 2));
					}
				}
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		return "ybl4.0/admin/factor/repaymentPlan/overdue/list";
	}
	
	/**
	 * 已回款明细
	 * @param pageVo
	 * @param vo
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@RequestMapping(value = "/finish.htm")
	public String finish(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,FactorCollectionManagementRepaymentPlanVo vo,@Param("startDate")String startDate,@Param("endDate")String endDate) {
		Map<String,Object> map = new HashMap<String,Object>();
		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		//设置查询条件
		repaymentPlanVo.setConfirmStatus(2);//已确认
		if(null != startDate && startDate != ""){
			//开始时间
			repaymentPlanVo.setStartDate(startDate);
		}
		if(null != endDate && endDate != ""){
			//结束时间
			repaymentPlanVo.setEndDate(endDate);
		}
		if(null != vo.getLoanApplyOrderNo() && vo.getLoanApplyOrderNo() != ""){
			//订单号
			repaymentPlanVo.setLoanApplyOrderNo(vo.getLoanApplyOrderNo());
		}
		/*根据登陆资金方ID过滤*/
		HttpSession session = getSession();
		UserVo user = (UserVo)session.getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			repaymentPlanVo.setFactor(user.getEnterpriseId());
		}
		
		map.put("repaymentPlan",repaymentPlanVo);
		map.put("sign", "selectAllBidPage");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRepaymentPlanManagement", map);
		PageVo page=null;
		List<FactorCollectionManagementRepaymentPlanVo> list=new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("已回款明细分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("repaymentPlanList");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
				//计算逾期费用和天数
				Date now = new Date();
				if(null != list && list.size() > 0){
					for (int i = 0;i< list.size();i++) {
						FactorCollectionManagementRepaymentPlanVo repayPlan = (FactorCollectionManagementRepaymentPlanVo) list.get(i);
						repayPlan.setOverdueDays(Long.valueOf(DateUtils.dayDiff(repayPlan.getActualRepaymentDate()==null?now:repayPlan.getActualRepaymentDate(),repayPlan.getRepaymentDate())).intValue());
						if(repayPlan.getOverdueDays().intValue() <= 0) {
							repayPlan.setOverdueDays(0);
							repayPlan.setOverdueFee(BigDecimal.ZERO);
						}
						//逾期费用=（逾期金额 * 逾期利率）*逾期天数/360 
						repayPlan.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(repayPlan.getRepaymentPrincipal().doubleValue(),Arith.div(repayPlan.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),repayPlan.getOverdueDays()), 2));
					}
				}
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		return "ybl4.0/admin/factor/repaymentPlan/finish/list";
	}
	
}
