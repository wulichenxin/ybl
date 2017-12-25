package com.bpm.framework.controller.v4.supplier.settlement;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.axis.utils.NetworkUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.tools.ant.taskdefs.FixCRLF.AddAsisRemove;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_REPAYMENT_STATUS;
import cn.sunline.framework.controller.vo.v4.supplier.LoanapplyChildrenQueryVO;
import cn.sunline.framework.controller.vo.v4.supplier.RepaymentPlanVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PAY_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping(value = "/rePayMentController")
public class RePayMentController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3915436603257988306L;

	/**
	 * 待还款项目
	 */
	@SuppressWarnings({ "rawtypes", "null" })
	@RequestMapping(value = "/pendingPayment.htm")
	public String pendingPayment(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,
			FactorCollectionManagementRepaymentPlanVo vo, @Param("startDate") String startDate,
			@Param("endDate") String endDate, Integer status) {

		FactorCollectionManagementRepaymentPlanVo repaymentPlanVo = new FactorCollectionManagementRepaymentPlanVo();
		if (null != startDate && startDate != "") {
			// 开始时间
			repaymentPlanVo.setStartDate(startDate);
		}
		if (null != endDate && endDate != "") {
			// 结束时间
			repaymentPlanVo.setEndDate(endDate);
		}
		if (null != vo.getLoanApplyOrderNo() && vo.getLoanApplyOrderNo() != "") {
			// 订单号
			repaymentPlanVo.setLoanApplyOrderNo(vo.getLoanApplyOrderNo());
		}
		/* 根据登陆资金方ID过滤 */
		HttpSession session = getSession();
		UserVo user = (UserVo) session.getAttribute(SystemConst.USER_SESSION_KEY);
		if (null != user) {
			// 账户已登录
			repaymentPlanVo.setBusinessId(user.getBusinessId());
		}
		getRequest().setAttribute("startDate", startDate);
		getRequest().setAttribute("endDate", endDate);
		getRequest().setAttribute("parm", vo);
		// 设置查询条件
		if (status != null && status == 3) {
			repaymentPlanVo.setRepaymentStatus(3);
			return this.overduePayment(pageVo, repaymentPlanVo);
		} else {
			status = new Integer(1);
			repaymentPlanVo.setRepaymentStatus(1);
			return this.awaitPayment(pageVo, repaymentPlanVo);

		}

	}

	public String awaitPayment(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,
			FactorCollectionManagementRepaymentPlanVo repaymentPlanVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("repaymentPlan", repaymentPlanVo);
		map.put("sign", "selectAwaitRepayPlanPage");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FinancingRepaymentPlanManagement", map);
		PageVo page = null;
		List<FactorCollectionManagementRepaymentPlanVo> list = new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("待还款项目分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("repaymentPlanList");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<FactorCollectionManagementRepaymentPlanVo> factList = new ArrayList<>();
				factList = JsonUtils.toList(records, FactorCollectionManagementRepaymentPlanVo.class);
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", factList);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		getRequest().setAttribute("status", 1);
		return "ybl4.0/admin/supplier/settlementManagement/pendingList";
	}

	public String overduePayment(PageVo<FactorCollectionManagementRepaymentPlanVo> pageVo,
			FactorCollectionManagementRepaymentPlanVo repaymentPlanVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("repaymentPlan", repaymentPlanVo);
		map.put("sign", "selectOverdueRepayPlanPage");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FinancingRepaymentPlanManagement", map);
		PageVo page = null;
		List<FactorCollectionManagementRepaymentPlanVo> list = new ArrayList<>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("逾期还款项目分页列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("repaymentPlanList");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<FactorCollectionManagementRepaymentPlanVo> factList = new ArrayList<>();
				factList = JsonUtils.toList(records, FactorCollectionManagementRepaymentPlanVo.class);
				for (FactorCollectionManagementRepaymentPlanVo repayMent : factList) {
					repayMent.setOverdueFee(repayMent.getRepaymentPrincipal().multiply(repayMent.getOverdueInterestRate())
							.multiply(new BigDecimal(repayMent.getOverdueDays()))
							.divide(new BigDecimal(36000), 2, BigDecimal.ROUND_HALF_UP));
				}
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", factList);
			}
		}
		getRequest().setAttribute("repaymentPlanVo", repaymentPlanVo);
		getRequest().setAttribute("status", 3);
		return "ybl4.0/admin/supplier/settlementManagement/overdueList";
	}

	/**
	 * 进入还款页面
	 * 
	 * @param id 还款计划主键
	 * @param order_no
	 *            放款申请编号
	 * @return
	 */
	@RequestMapping(value = "/RepaymentInfo.htm")
	public String RepaymentInfo(Integer id, String order_no, String returnPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order_no", order_no);
		map.put("sign", "selectReypayMentByOrder");
		ResBody result = TradeInvokeUtils.invoke("RepayMentManagement", map);
		BigDecimal repayment_wait = new BigDecimal(0);
		if (isSuccess(result)) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("noPayMents");
				String hasJsonPage = output.getString("hasPayMents");
				List<RePaymentVo> noPayMents = JSONObject.parseArray(jsonPage, RePaymentVo.class);
				List<RePaymentVo> hasPayMents = JSONObject.parseArray(hasJsonPage, RePaymentVo.class);
				for (RePaymentVo repayMent : noPayMents) {
					if(repayMent.getOverdue_days() > 0){
						if(repayMent.getRepayment_status() == 1){
							repayMent.setRepayment_status(2);
						}
						repayMent.setOverdue_fee(repayMent.getRepayment_principal().multiply(repayMent.getOverdue_interest_rate())
								.multiply(new BigDecimal(repayMent.getOverdue_days()))
								.divide(new BigDecimal(36000), 2, BigDecimal.ROUND_HALF_UP));
					
					}else{
						repayMent.setOverdue_fee(new BigDecimal(0));
					}
					BigDecimal repayment_principal = repayMent.getRepayment_interest().add(repayMent.getRepayment_principal());
					if(repayMent.getOverdue_days() > 0){//判断逾期天数
						repayment_principal = repayment_principal.add(repayMent.getOverdue_fee());
					}else{
						repayMent.setOverdue_days(0);
					}
					repayMent.setRepayment_count(repayment_principal);
					//repayMent.setRepayment_principal(repayment_principal);
					repayment_wait =  repayment_wait.add(repayment_principal);
					/*getRequest().setAttribute("OverdueFee", repayMent.getOverdue_days());
					getRequest().setAttribute("repaymentAmout", repayment_principal); //应还总数=应还本金+应还利息+逾期费用
*/				}
				getRequest().setAttribute("noPayMents", noPayMents);
				getRequest().setAttribute("hasPayMents", hasPayMents);
				getRequest().setAttribute("id", id);
				getRequest().setAttribute("repayment_wait", repayment_wait); //待还款金额 = 所有未还本金+利息+逾期费用
				if (returnPage != null) {
					getRequest().setAttribute("returnPage", returnPage);
				}
			}
		}
		getRequest().setAttribute("order_no", order_no);
		return "ybl4.0/admin/supplier/settlementManagement/paymentInfoAndConfirm";

	}

	/**
	 * 上传还款数据
	 * 
	 * @param parm
	 * @param attachment
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadRepay")
	public ControllerResponse uploadRepay(RePaymentVo parm, AttachmentVo attachment) {
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE);
		UserVo user = ControllerUtils.getCurrentUser();
		attachment.setType("59");
		attachment.setCategory(8L);
		attachment.setResourceId(parm.getId_());
		attachment.setCreatedTime(new Date());
		attachment.setLastUpdateTime(new Date());
		attachment.setEnable(1);
		attachment.setCreatedBy(user.getId());
		attachment.setLastUpdateBy(user.getId());
		attachment.setEnterpriseId(user.getEnterpriseId());
		attachment.setRemark("还款凭证");
		attachment.setId(null);

		parm.setRepayment_status(2);
		// parm.setActual_repayment_date(new Date().getTime());
		parm.setMember_id(user.getId());
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("repayment", parm);
		maps.put("attachment", attachment);
		maps.put("sign", "updateRepayMentById");// 所调用的服务中的方法

		ResBody result = TradeInvokeUtils.invoke("RepayMentManagement", maps);
		/*
		 * Map<String,Object> map = new HashMap<String,Object>();
		 * map.put("paramter", attachment); map.put("sign",
		 * "insertAttachmentInfo");
		 */
		/* TradeInvokeUtils.invoke("AttachmentManagement", map); */
		if (isSuccess(result)) {
			/*
			 * Map<String,Object> mapLoan = new HashMap<String,Object>();
			 * mapLoan.put("order_no", parm.getLoan_apply_order_no());
			 * mapLoan.put("sign", "updateLoanApplyStatusByReypayNum");//
			 * 所调用的服务中的方法 TradeInvokeUtils.invoke("RepayMentManagement",
			 * mapLoan);
			 */
			responseResult.setResponseType(ResponseType.SUCCESS, "还款成功");
		}
		return responseResult;

	}

	/**
	 * 还款详情
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/repayInfo.htm")
	public String RepaymentInfoById(Integer id) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("id", id);
		maps.put("sign", "selectRepayMentById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("RepayMentManagement", maps);
		if (isSuccess(result)) {
			JSONObject output = (JSONObject) result.getOutput();
			String jsonPage = output.getString("repayMent");
			RePaymentVo repayMent = JSONObject.parseObject(jsonPage, RePaymentVo.class);
			repayMent.setOverdue_fee(repayMent.getRepayment_principal().multiply(repayMent.getOverdue_interest_rate())
					.multiply(new BigDecimal(repayMent.getOverdue_days()))
					.divide(new BigDecimal(36000), 2, BigDecimal.ROUND_HALF_UP));
			getRequest().setAttribute("entity", repayMent);
		}
		return "ybl4.0/admin/supplier/settlementManagement/repayment";

	}

	/**
	 * 获取还款附件url
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appendixRepayment")
	public ControllerResponse getAppendixRepayment(Integer id) {
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE);

		AttachmentVo attachment = new AttachmentVo();
		attachment.setType("59");
		attachment.setCategory(8L);
		attachment.setResourceId(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		if (isSuccess(resultAttachment)) {
			JSONObject output = (JSONObject) resultAttachment.getOutput();
			String resultJson = output.getString("result");
			List<AttachmentVo> attachmentList = null;
			attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
			if (attachmentList != null && attachmentList.size() > 0) {
				attachment = attachmentList.get(0);
				responseResult.setResponseType(ResponseType.SUCCESS, attachment.getUrl());
				responseResult.setObject(attachment);
			}
		}
		return responseResult;

	}

	@RequestMapping(value = "/view.htm")
	public String intoView(Integer id, String iframeChange, String orderNo,String repayMentPlanId) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("loan_id", id);
		maps.put("sign", "selectLoanApplyById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SettlementManagement", maps);
		if (isSuccess(result)) {
			JSONObject output = (JSONObject) result.getOutput();
			String jsonPage = output.getString("loanApply");
			getRequest().setAttribute("loanApply", JSONObject.parse(jsonPage));
		}
		if (iframeChange != null) {
		    getRequest().setAttribute("id", repayMentPlanId);
			getRequest().setAttribute("iframeChange", iframeChange);
			getRequest().setAttribute("orderNo", orderNo);
		}
		return "ybl4.0/admin/supplier/settlementManagement/repayView";
	}

	/**
	 * 还款计划表
	 * 
	 */
	@RequestMapping("/repaymentlist.htm")
	public String repaymentlist(@RequestParam("orderNo") String orderNo) {
		Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_order_no", orderNo);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "selectRepayInfoByOrderNo");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		List<FactorCollectionManagementRepaymentPlanVo> list = null;
		if(isSuccess(result)){
 			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
			for (int i = 0; i < list.size(); i++) {
				BigDecimal principal = list.get(i).getRepaymentPrincipal(); //逾期金额(应还本金)
				long overdays = DateUtils.dayDiff(new Date(),list.get(i).getRepaymentDate());//逾期天数
				if(overdays < 0) {
					list.get(i).setOverdueDays(0);
					list.get(i).setAttribute6("0.00");
				}else {
					if(list.get(i).getRepaymentStatus() != E_V4_PAY_STATE.REPLAYED_NOT_CONFIRM.getStatus()) {
						BigDecimal overdays_end = new BigDecimal(overdays); 
						BigDecimal rate = list.get(i).getOverdueInterestRate();
						list.get(i).setOverdueDays((int)overdays);
						list.get(i).setAttribute6(overFee(principal,overdays_end,rate).toString());
					}else {
						BigDecimal overdays_end = new BigDecimal(list.get(i).getOverdueDays());
						BigDecimal rate = list.get(i).getOverdueInterestRate();
						list.get(i).setAttribute6(overFee(principal,overdays_end,rate).toString());
					}
					
				}
			}
		}else{
			super.log.error("根据放款订单号查询还款计划返回错误信息: " + result.getSys().getErortx());
			return null;
		}	
 		getRequest().setAttribute("list", list);
		return "ybl4.0/admin/supplier/settlementManagement/unconfirmed_list";
	}
	
	//计算逾期得天数
		 public static int getBetweenDay(Date date2, Date date1) {  
		        Calendar d1 = new GregorianCalendar();  
		        d1.setTime(date1);  
		        Calendar d2 = new GregorianCalendar();  
		        d2.setTime(date2);  
		        int days = d2.get(Calendar.DAY_OF_YEAR)- d1.get(Calendar.DAY_OF_YEAR);  
		        System.out.println("days="+days);  
		        int y2 = d2.get(Calendar.YEAR);  
		        if (d1.get(Calendar.YEAR) != y2) {  
//		          d1 = (Calendar) d1.clone();  
		            do {  
		                days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);  
		                d1.add(Calendar.YEAR, 1);  
		            } while (d1.get(Calendar.YEAR) != y2);  
		        }  
		        return days; 
		
		 }
		 
		 	/**
			 * 放款综合查询详情，根据放款id单得id查询
			 * 
			 * @return
			 */
			@ValidateSession(validate = false)
			@SuppressWarnings("rawtypes")
			@RequestMapping(value = "/selectChildrenDetail.htm")
			public String details(@Param("id") Long id,@Param("url") String url) {
				//通过放款定单的id查询详情页面所需得参数
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id_", id);
				map.put("sign", "selectloanApplyById");// 所调用的服务中的方法
				ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery", map);
				LoanapplyChildrenQueryVO loan = new LoanapplyChildrenQueryVO();
				isSuccess(result);
				JSONObject output = (JSONObject) result.getOutput();
				String resultJson = output.getString("loan");
				if(resultJson != null){
					loan = JsonUtils.toObject(resultJson, LoanapplyChildrenQueryVO.class);
					getRequest().setAttribute("id", id);
					getRequest().setAttribute("orderno", loan.getOrder_no());
					getRequest().setAttribute("type", loan.getAssets_type());
					getRequest().setAttribute("financingAmount", loan.getFinancing_amount());
					getRequest().setAttribute("url", url);
					String attribute1=loan.getAttribute1();
					String attribute2=loan.getAttribute2();
					int financingstatus=loan.getStatus();
					if(financingstatus==0){
						getRequest().setAttribute("financingstatus", 0);
					}else{
						getRequest().setAttribute("financingstatus", financingstatus);
					}
					
					if(attribute1==null||attribute1==""){
						getRequest().setAttribute("attribute1", 0);
					}else{
						getRequest().setAttribute("attribute1", Integer.valueOf(attribute1));
					}
					if(attribute2==null||attribute2==""){
						getRequest().setAttribute("attribute2", 0);
					}else{
						getRequest().setAttribute("attribute2", Integer.valueOf(attribute2));
					}
					
				}
				
				return "ybl4.0/admin/supplier/settlementManagement/commonApiView";
				}
			
			 private BigDecimal overFee(BigDecimal principal, BigDecimal overdays, BigDecimal rate) {
			    	return principal.multiply(rate.divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP)).divide(new BigDecimal(360),4,BigDecimal.ROUND_HALF_UP).multiply(overdays);
			    }
}
