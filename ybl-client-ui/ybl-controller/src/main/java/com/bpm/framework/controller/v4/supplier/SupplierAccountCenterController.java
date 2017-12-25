package com.bpm.framework.controller.v4.supplier;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.controller.v4.supplier.settlement.RePaymentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.PlatformCapitalFlow;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanFailProjectVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanProjectVO;
import cn.sunline.framework.controller.vo.v4.supplier.SubFinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_LOAN_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PAY_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PLATFORM_FREE_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 融资方-账户中心
 * 			账户总览
 *			待收款项目
 *			待还款项目
 *			贷款管理
 * @author xxx
 *
 */
@Controller
@RequestMapping({"/supplierAccountCenterController"})
public class SupplierAccountCenterController extends AbstractController {
  
	private static final long serialVersionUID = 1L;

	/**
     * 待收款项目列表信息
     * @param pageVo 分页
     * @return
     */
    @RequestMapping({"/receivingacount.htm"})
    public String receivingacountIndex(LoanProjectVO loanProjectVO, PageVo pageVo){
    	loanProjectVO.setStatus(E_V4_LOAN_STATE.LOANED_AND_PAYED.getStatus());
		loanProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "queryloanprojectlist");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		PageVo page=null;
		List<LoanProjectVO> list=null;
 		if(isSuccess(result)){
 			JSONObject output = (JSONObject) result.getOutput(); 
			String jsonPage= output.getString("page");
			JSONObject json = (JSONObject) JSONObject.parse(jsonPage);
			String records = json.getString("records");
			page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
			list=JsonUtils.toList(records,LoanProjectVO.class);
			page.setRecords(list);
			getRequest().setAttribute("list", list);
		}else{
			super.log.error("待收款项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "6"); //供查询各阶段详情时，返回按钮使用
 		getRequest().setAttribute("loanProjectVO", loanProjectVO);
        return "ybl4.0/admin/supplier/accountcenter/receivingacount";
    }
    
    /**
     * 还款跳转页面
     */
    @RequestMapping("/suppliereceivingadd")
    public String toSuppliereceivingaddPage(@RequestParam("orderNo") String orderNo, 
    										@RequestParam("id") String id, 
    										@RequestParam(value="overfee",required=false,defaultValue="0") String overfee,
    										@RequestParam("financingAmount") String financingAmount,
    										@RequestParam("type") String type) {
 		LoanApply paramLoanApply = new LoanApply();
    	paramLoanApply.setOrderNo(orderNo);
    	Map<String,Object> mapsLoanApply = new HashMap<String,Object>();
    	mapsLoanApply.put("parameter", paramLoanApply);
    	mapsLoanApply.put("sign", "queryloanReconfirmproject");	//根据放款订单号查询付款批次信息
		ResBody resultparamLoanApply = TradeInvokeUtils.invoke("LoanProjectManagement", mapsLoanApply);
		FactorLoanManagementLoanBatchSettlementVo factorLoanVo=null;
 		if(isSuccess(resultparamLoanApply)){
			JSONObject outputparamLoanApply = (JSONObject) resultparamLoanApply.getOutput(); 
			String recordsparamLoanApply = outputparamLoanApply.getString("result");
			factorLoanVo = JsonUtils.toObject(recordsparamLoanApply,FactorLoanManagementLoanBatchSettlementVo.class);
			if(factorLoanVo.getActualLoanDate() != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
				String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
				factorLoanVo.setActualLoanDate(dateStr);
			}
 		}
 		getRequest().setAttribute("factorLoanVo", factorLoanVo);
 		getRequest().setAttribute("assetsType", type);//资产类型
		getRequest().setAttribute("id", id); // 还款id
		getRequest().setAttribute("overfee", overfee); //逾期费用
		getRequest().setAttribute("orderNo", orderNo); // 放款申请单号
		getRequest().setAttribute("financingAmount", financingAmount);//融资金额
 		return "ybl4.0/admin/supplier/accountcenter/view";  
    }
    
    /**
     * 根据bussinessId查询融资总金额与融资总费用
     * @return
     */
    @RequestMapping("/selectTotalFinancingFeeAndActualAmount")
    public String selectTotalFinancingFeeAndActualAmount() {
    	
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("financier_bussiness_id", ControllerUtils.getCurrentUser().getBusinessId());
    	Map<String,Object> tradeParam = new HashMap<String,Object>();
    	tradeParam.put("parameter", param);
    	tradeParam.put("sign", "selectTotalFinancingFeeAndActualAmount");
		ResBody tradeResult = TradeInvokeUtils.invoke("LoanProjectManagement", tradeParam);
		Map<String, Object> result=null;
 		if(isSuccess(tradeResult)){
			JSONObject totalAmoutoutput = (JSONObject) tradeResult.getOutput(); 
			String totalAmoutrecords = totalAmoutoutput.getString("result");
			if(!StringUtils.isEmpty(totalAmoutrecords)) {
				result = JsonUtils.toObject(totalAmoutrecords,Map.class);
				getRequest().setAttribute("total_actual_amount", result.get("total_actual_amount")); //融资总金额
				getRequest().setAttribute("total_financing_fee", result.get("total_financing_fee")); //融资总费用
			}else {
				getRequest().setAttribute("total_actual_amount", 0);
				getRequest().setAttribute("total_financing_fee", 0);
			}
		}else{
			super.log.error("根据bussinessId查询融资总金额与融资总费用交易返回错误信息: " + tradeResult.getSys().getErortx());
			return null;
		}
    	return "ybl4.0/admin/supplier/accountcenter/accoutindex";
    }
    
    /**
     * 修改还款状态
     * @return
     */
    @RequestMapping({"/updateRepayStatus"})
    @ResponseBody
    public ControllerResponse updateRepayStatus(HttpServletRequest req){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	Map<String, Object> maps = new HashMap<String, Object>();
    	maps.put("repayment", getRePaymentVoFromHttpRequest(req));
    	//获取上传附件信息
    	AttachmentVo attach = JsonUtils.toObject(req.getParameter("repay_attach_upload_info").toString(), AttachmentVo.class);
    	attach.setResourceId((Integer.valueOf(req.getParameter("id"))));//存储的是当前还款计划的主键id
    	attach.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
    	attach.setCreatedBy(ControllerUtils.getCurrentUser().getId());
    	attach.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_PARTY_REPAYMENTS.getStatus());
    	attach.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
    	attach.setRemark(req.getParameter("remark"));
    	attach.setCreatedTime(new Date());
    	attach.setLastUpdateTime(new Date());
    	maps.put("attachment", attach);
		maps.put("sign", "updateRepayMentById");
		ResBody result = TradeInvokeUtils.invoke("RepayMentManagement", maps);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attach);
		map.put("sign", "insertAttachmentInfo");
		TradeInvokeUtils.invoke("AttachmentManagement", map);
		if(isSuccess(result)){
			response.setResponseType(ResponseType.SUCCESS);	
			response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
		}else{
			response.setResponseType(ResponseType.ERROR);
			super.log.error("修改还款状态服务调用信息："+ result.getSys().getErortx());
		}
		return response;
    }
    
    
    /**
     * 从请求报文中获取还款计划相关属性值
     * @param req
     * @return
     */
    private RePaymentVo getRePaymentVoFromHttpRequest(HttpServletRequest req) {
    	RePaymentVo repay = new RePaymentVo();
    	Date repaymentDate = DateUtils.toDate(req.getParameter("repaymentDate"), "yyyy-MM-dd");
    	Date actualRepaymentDate = DateUtils.toDate(req.getParameter("actualRepaymentDate"), "yyyy-MM-dd");
    	long overdays = DateUtils.dayDiff(actualRepaymentDate,repaymentDate);
    	repay.setActual_repayment_date(actualRepaymentDate.getTime());
    	repay.setOverdue_days(overdays > 0 ? ((int)overdays) : 0 );
    	repay.setRepayment_status(E_V4_PAY_STATE.REPLAYED_NOT_CONFIRM.getStatus());
    	repay.setActual_amount(new BigDecimal(req.getParameter("actualAmount")));
    	repay.setTransaction_order_no(req.getParameter("transactionOrderNo"));
    	repay.setRemark(req.getParameter("remark"));
    	repay.setBank_account(req.getParameter("bankAccount"));
    	repay.setBank_account_name(req.getParameter("bankAccountName"));
    	repay.setBank(req.getParameter("bank"));
    	repay.setMember_id(ControllerUtils.getCurrentUser().getId());
    	repay.setId_(Integer.parseInt(req.getParameter("id")));
    	
    	return repay;
    }
    
    /**
     * 跳转至收款确认页面
     */
    @RequestMapping("/receiveconfirm")
    public String toSuppliereceAccoutConfirmPage(HttpServletRequest req ) {
    	String orderNo = req.getParameter("orderNo");
    	LoanApply param = new LoanApply();
    	param.setOrderNo(orderNo);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "queryloanReconfirmproject");	//根据放款订单号查询付款批次信息
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);
		FactorLoanManagementLoanBatchSettlementVo factorLoanVo=null;
 		if(isSuccess(result)){
			JSONObject output = (JSONObject) result.getOutput(); 
			String records = output.getString("result");
			factorLoanVo = JsonUtils.toObject(records,FactorLoanManagementLoanBatchSettlementVo.class);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
			if(factorLoanVo.getActualLoanDate() != null) {
				String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
				factorLoanVo.setActualLoanDate(dateStr);
			}
			//查询放款支付凭证附件
			AttachmentVo attachmentVo = new AttachmentVo();
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
			attachmentVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			attachmentVo.setResourceId(Integer.valueOf(factorLoanVo.getId().toString()));
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.LOAN_SETTLEMENT_PAYMENT_VOUCHER.getStatus());
	 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
	 		getRequest().setAttribute("attch", attachmentList.size() > 0 ? attachmentList.get(0) : null);
	 		
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("factorLoanVo", factorLoanVo);
		getRequest().setAttribute("orderNo", orderNo);//放款订单号
		getRequest().setAttribute("id", req.getParameter("id"));//融资申请的id
		getRequest().setAttribute("financingAmount", req.getParameter("financingAmount")); //融资放款金额
		getRequest().setAttribute("assetsType", req.getParameter("assetsType"));  //资产类型
		
		getRequest().setAttribute("pageFlag", "6"); //标记为第六个tab(收款确认页面)
		return "ybl4.0/admin/supplier/accountcenter/view";
    }
    
    /**
     * 修改收款状态
     * @param id
     * @return
     */
    @RequestMapping({"/updateLoanApplyStatus"})
    @ResponseBody
    public ControllerResponse updateLoanStatus(HttpServletRequest req){
    	//修改放款状态同时 插入资金流水表一条记录  插入附件表信息
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	Map<String, Object> obj = new HashMap<String, Object>();
    	LoanApply loanApply = new LoanApply();
    	loanApply.setId(Long.valueOf(req.getParameter("id")));
    	loanApply.setStatus(E_V4_LOAN_STATE.FINANCER_CONFIRM.getStatus());//已确认收款状态
    	obj.put("loanApply", loanApply);
    	
    	AttachmentVo attach = JsonUtils.toObject(req.getParameter("recevie_confire_attch").toString(), AttachmentVo.class);
    	attach.setResourceId((Integer.valueOf(req.getParameter("id"))));
    	attach.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
    	attach.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_RECEIPT_CONFIRMATION.getStatus());
    	attach.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.MANAGEMENT_MANAGEMENT_FINANCING.getStatus()));
    	attach.setRemark(req.getParameter("receivAmoutRemark"));
    	obj.put("attach", attach);
    	obj.put("platformCapitalFlow", getPlatformCapitalFlowFromHttpRequest(req));
    	
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("parameter", obj);
		maps.put("sign", "updateLoanStatusAndInsertFlow");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);
		if(isSuccess(result)){
			response.setResponseType(ResponseType.SUCCESS);	
			response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
		}else{
			response.setResponseType(ResponseType.ERROR);
			super.log.error("修改收款状态服务调用信息："+result.getSys().getErortx());
		}
		return response;
    }
   
    /**
     *  平台资金流水实体
     * @param req
     * @return
     */
    private PlatformCapitalFlow getPlatformCapitalFlowFromHttpRequest(HttpServletRequest req) {
    	PlatformCapitalFlow platformCapitalFlow = new PlatformCapitalFlow(); //资金流水实体类
    	platformCapitalFlow.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
    	platformCapitalFlow.setPaymentBatchNo(req.getParameter("batch_no"));
    	platformCapitalFlow.setLoanOrderNo(req.getParameter("orderNo"));
    	platformCapitalFlow.setPlatformRate(new BigDecimal(req.getParameter("rate")));
    	platformCapitalFlow.setReductionRate(new BigDecimal(req.getParameter("reductionRate")));
    	platformCapitalFlow.setPaidPlatformFee(new BigDecimal(req.getParameter("paidPlatformFee")));
    	platformCapitalFlow.setStatus(E_V4_PLATFORM_FREE_STATE.PLATFORM_TO_BE_CONFIRM.getStatus());//1-平台费用未确认
    	return platformCapitalFlow;
    }
    
    
    /**
     * 待还款项目列表信息
     * @param pageVo
     * @return
     */
    @RequestMapping("/supplierreceiving.htm")
    public String receivingIndex(LoanProjectVO loanProjectVO, PageVo pageVo) {
    	loanProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
    	loanProjectVO.setRepaymentStatus(E_V4_PAY_STATE.TO_BE_REPAY.getStatus()); //待还款状态
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "selectLoanRepayProjectList");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		PageVo<LoanProjectVO> page=null;
		List<LoanProjectVO> list=null;
 		if(isSuccess(result)){
 			page = tradeResultToPage(result);
 			list = tradeResultToPageResult(result,new LoanProjectVO());
			page.setRecords(list);
		}else{
			super.log.error("待还款项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "8");
 		getRequest().setAttribute("loanProjectVO", loanProjectVO);
    	return "ybl4.0/admin/supplier/accountcenter/pendingrepayment";
    }
    
    /**
     * 逾期项目列表信息
     * @param pageVo
     * @return
     */
    @RequestMapping("/supplieroverdue.htm")
    public String overduegIndex(LoanProjectVO loanProjectVO, PageVo pageVo) {
    	loanProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
    	loanProjectVO.setRepaymentStatus(E_V4_PAY_STATE.PAY_OVER_OFF.getStatus());//还款逾期状态
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "queryPayoffLoanprojectDetailList");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		PageVo<LoanProjectVO> page=null;
		List<LoanProjectVO> list=null;
 		if(isSuccess(result)){
 			page = tradeResultToPage(result);
 			list = tradeResultToPageResult(result,new LoanProjectVO());
			for (int i = 0; i < list.size(); i++) {
				BigDecimal principal = list.get(i).getRepaymentPrincipal();
				long overdays = DateUtils.dayDiff(new Date(),list.get(i).getRepaymentDate());
				if(overdays < 0) {
					list.get(i).setOverdueDays(0);
					list.get(i).setAttribute6("0.00");
				}else {
					list.get(i).setOverdueDays((int)overdays);
					BigDecimal overdays_end = new BigDecimal(overdays); // 逾期天数
					BigDecimal rate = list.get(i).getOverdueInterestRate(); //逾期利率
					list.get(i).setAttribute6(overFee(principal,overdays_end,rate).toString());
				}
			}
			page.setRecords(list);
		}else{
			super.log.error("逾期项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}	
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "2");
 		getRequest().setAttribute("loanProjectVO", loanProjectVO);
    	return "ybl4.0/admin/supplier/accountcenter/overdue";
    }
    
    /**
     * 已还清项目列表信息
     * @param pageVo
     * @return
     */
    @RequestMapping("/supplierpayoff.htm")
    public String payoffIndex(LoanProjectVO loanProjectVO, PageVo pageVo) {
    	loanProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
    	loanProjectVO.setRepaymentStatus(3);// 已还款完成
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "queryPayAllOffloanprojectlist");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		PageVo<LoanProjectVO> page=null;
		List<LoanProjectVO> list=null;
 		if(isSuccess(result)){
 			page = tradeResultToPage(result);
 			list = tradeResultToPageResult(result,new LoanProjectVO());
			for (int i = 0; i < list.size(); i++) {
				BigDecimal principal = list.get(i).getRepaymentPrincipal();
				long overdays = list.get(i).getOverdueDays();
				if(overdays < 0) {
					list.get(i).setOverdueDays(0);
					list.get(i).setAttribute6("0.00");
				}else{
					BigDecimal overdays_end = new BigDecimal(list.get(i).getOverdueDays()); // 逾期天数
					BigDecimal rate = list.get(i).getOverdueInterestRate(); //逾期利率
					list.get(i).setAttribute6(overFee(principal,overdays_end,rate).toString());//暂存逾期费用 ***逾期费用=（逾期金额 * 逾期利率）/360 * 逾期天数
				}
				
			}
			page.setRecords(list);
		}else{
			super.log.error("已还清项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "3");
 		getRequest().setAttribute("loanProjectVO", loanProjectVO);
    	return "ybl4.0/admin/supplier/accountcenter/payoff";
    }
    
    
    /**
     * 跳转至标签页(默认显示第一个标签页面内容)
     * @param req
     * @return
     */
    @RequestMapping("/labelsPage")
    public String gotoLabelPage(HttpServletRequest req) {
    	
    	LoanApply paramLoanApply = new LoanApply();
    	paramLoanApply.setOrderNo(req.getParameter("orderNo"));
    	Map<String,Object> mapsLoanApply = new HashMap<String,Object>();
    	mapsLoanApply.put("parameter", paramLoanApply);
    	mapsLoanApply.put("sign", "queryloanReconfirmproject");	//根据放款订单号查询付款批次信息
		ResBody resultparamLoanApply = TradeInvokeUtils.invoke("LoanProjectManagement", mapsLoanApply);
		FactorLoanManagementLoanBatchSettlementVo factorLoanVo= new FactorLoanManagementLoanBatchSettlementVo();
 		if(isSuccess(resultparamLoanApply)){
			JSONObject outputparamLoanApply = (JSONObject) resultparamLoanApply.getOutput(); 
			String recordsparamLoanApply = outputparamLoanApply.getString("result");
			if(StringUtils.isNotEmpty(recordsparamLoanApply)) {
				factorLoanVo = JsonUtils.toObject(recordsparamLoanApply,FactorLoanManagementLoanBatchSettlementVo.class);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
				String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
				factorLoanVo.setActualLoanDate(dateStr);
			}
 		}
 		if(getRequest().getSession().getAttribute("pageFlag").toString().equalsIgnoreCase("1")) {
 			factorLoanVo.setId(Long.valueOf(req.getParameter("loanapplyid")));
 		}
 		getRequest().setAttribute("factorLoanVo", factorLoanVo);
 		getRequest().setAttribute("orderNo", req.getParameter("orderNo"));//放款订单号
    	getRequest().setAttribute("financingAmount", req.getParameter("financingAmount"));//融资金额
    	getRequest().setAttribute("assetsType", req.getParameter("assetsType"));//资产类型
    	getRequest().setAttribute("financingName", req.getParameter("financingName"));//资金方名称
    	
    	return "ybl4.0/admin/supplier/accountcenter/view";
    }
    
    /**
     * 已还款项目明细列表信息
     * @param pageVo
     * @return
     */
    @RequestMapping("/supplierrepayments.htm")
    public String repayments(LoanProjectVO loanProjectVO, PageVo pageVo) {
    	loanProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
    	loanProjectVO.setRepaymentStatus(E_V4_PAY_STATE.REPLAYED_NOT_CONFIRM.getStatus());//已还款确认状态
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "queryPayoffLoanprojectDetailList");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		PageVo<LoanProjectVO> page=null;
		List<LoanProjectVO> list=null;
 		if(isSuccess(result)){
 			page = tradeResultToPage(result);
 			list = tradeResultToPageResult(result,new LoanProjectVO());
			page.setRecords(list);
			for (int i = 0; i < list.size(); i++) {
				BigDecimal principal = list.get(i).getRepaymentPrincipal();
				long overdays = list.get(i).getOverdueDays();
				if(overdays < 0) {
					list.get(i).setOverdueDays(0);
					list.get(i).setAttribute6("0.00");
				}else {
					BigDecimal overdays_end = new BigDecimal(list.get(i).getOverdueDays()); // 逾期天数
					BigDecimal rate = list.get(i).getOverdueInterestRate(); //逾期利率
					list.get(i).setAttribute6(overFee(principal,overdays_end,rate).toString());
				}
			}
		}else{
			super.log.error("已还清项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}	
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "4");
 		getRequest().setAttribute("loanProjectVO", loanProjectVO);
    	return "ybl4.0/admin/supplier/accountcenter/repayments";
    }
    
    /**
     * 逾期费用 ***逾期费用=（逾期金额 * 逾期利率）/360 * 逾期天数
     * @return
     */
    private BigDecimal overFee(BigDecimal principal, BigDecimal overdays, BigDecimal rate) {
    	return principal.multiply(rate).divide(new BigDecimal(360),2,BigDecimal.ROUND_HALF_UP).multiply(overdays).divide(new BigDecimal(100),2,BigDecimal.ROUND_HALF_UP);
    }
    
    /**
     * 放款失败项目列表信息
     * @param pageVo
     * @return
     */
    @RequestMapping("/supplierloanfail.htm")
    public String loanfail(LoanFailProjectVO loanFailProjectVO, PageVo pageVo) {
    	loanFailProjectVO.setBusinessId(ControllerUtils.getCurrentUser().getBusinessId());
    	loanFailProjectVO.setStatus(E_V4_LOAN_STATE.LOAN_FAILURE.getStatus()); //放款失败状态
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", loanFailProjectVO);
		maps.put("page", pageVo);
		maps.put("sign", "queryloanfailprojectlist");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);	
		PageVo<LoanFailProjectVO> page = null;
		List<LoanFailProjectVO> list = null;
 		if(isSuccess(result)){
 			page = tradeResultToPage(result);
 			list = tradeResultToPageResult(result,new LoanFailProjectVO());
			page.setRecords(list);
		}else{
			super.log.error("放款失败项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("page", page);
 		getRequest().getSession().setAttribute("pageFlag", "1");
 		getRequest().setAttribute("loanFailProjectVO", loanFailProjectVO);
    	return "ybl4.0/admin/supplier/accountcenter/loanfail";
    }
    
    
    /**
     * 融资失败项目列表信息
     * @param pageVo
     * @return
     */
    
    @RequestMapping("/supplierfinancingfail.htm")
    public String financingfail(FinancingApplyVO financingApplyVO, PageVo pageVo) {
    	financingApplyVO.setFinancingStatus(E_V4_FINANCING_STATE.FINANCING_FAILURE.getStatus()); //融资失败状态=99
    	financingApplyVO.setBusinessId(Integer.valueOf(ControllerUtils.getCurrentUser().getBusinessId().toString()));
		PageVo<FinancingApplyVO> page= new PageVo<FinancingApplyVO>();
		List<FinancingApplyVO> list=null;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("financingApply",financingApplyVO);
		map.put("sign", "selectFinancingApplyPage");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
		if (isSuccess(result)) {
			JSONObject output = (JSONObject) result.getOutput();
			String jsonPage=output.getString("page");
			String records = output.getString("result");
			page = JSONObject.parseObject(jsonPage, PageVo.class);
			list=JsonUtils.toList(records,FinancingApplyVO.class);
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("list", list);
		getRequest().setAttribute("financingApplyVO", financingApplyVO);
		return "ybl4.0/admin/supplier/accountcenter/financingfail";
    }
    
    /**
     * 融资详情
     * @param id
     * @param subid
     * @return
     */
    @RequestMapping(value = "/financingApply/getFinancingApply")
    public String getFinancingApply(@RequestParam("id")Long id,Integer subid) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 融资申请实体用于后面查询
        FinancingApplyVO financingApplyVO = new FinancingApplyVO();
        financingApplyVO.setApply_id(id);
        financingApplyVO.setId(id);
        // 融资申请主信息
        FinancingApplyVO financingApply = FinancingApplyCommonApi.getFinancingApply(id);
        // 根据资产类型查找资产列表
        if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
            // 应收账款
            List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financingApplyVO);
            getRequest().setAttribute("receivableList", accountsReceivableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
            // 应付账款
            List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financingApplyVO);
            getRequest().setAttribute("repayableList", accountsPayableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
            // 票据
            List<BillVO> billList = FinancingApplyCommonApi.getBillById(financingApplyVO);
            getRequest().setAttribute("billList", billList);
        }
        // 获取附件列表
        AttachmentVo attachmentVo = new AttachmentVo();
        attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));// 融资申请
        attachmentVo.setEnterpriseId(user.getEnterpriseId());
        attachmentVo.setResourceId(financingApply.getId().intValue());
        List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
        if (null != subid && subid != 0) {
            Map<String,Object> maps = new HashMap<String,Object>();
            SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
            subFinancingApplyVO.setId(subid.longValue());
            maps.put("subFinancingApply", subFinancingApplyVO);
            maps.put("sign", "selectSubFinancingApply");//所调用的服务中的方法        
            ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", maps);
            List<SubFinancingApplyVO> subFinancingApplyVOList =  null;
            if(result.getSys()!=null){
                String status = result.getSys().getStatus();
                String erortx = result.getSys().getErortx();//错误信息  
                if("S".equals(status)){//交易成功
                    log.info("查询子融资查询交易成功====================");
                    JSONObject output = (JSONObject) result.getOutput();
                    String records = output.getString("financingSubApplyList");
                    subFinancingApplyVOList=JsonUtils.toList(records,SubFinancingApplyVO.class);
                    if (subFinancingApplyVOList.size() > 0) {
                        getRequest().setAttribute("subFinancingApply", subFinancingApplyVOList.get(0));
                    }
                }else{
                    super.log.error("查询子融资查询返回失败，信息："+erortx);
                    return null;
                }       
            }
            // 获取附件列表
            attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));
            attachmentVo.setEnterpriseId(user.getEnterpriseId());
            attachmentVo.setResourceId(subid);
            List<AttachmentVo> rejectList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
            getRequest().setAttribute("rejectList", rejectList);
        }
        // 资金方选择
        if (null != financingApply.getInvestorName() && !"".equals(financingApply.getInvestorName().trim())) {
            String[] array = financingApply.getInvestorName().split(",");
            StringBuffer sb = new StringBuffer();
            for(String s : array) {
                String[] sArray = s.split("-");
                sb.append(sArray[0]).append(",");
            }
            V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
            businessAuthVO.setIds(sb.toString().substring(0, sb.length()-1));
            businessAuthVO.setAuthType(E_V4_AUTH_TYPE.FUNDSIDE.getStatus()); // 资金方
            List<V4BusinessAuthVO> factoryList=selectBusinessAuthNameList(businessAuthVO);
            getRequest().setAttribute("factoryList", factoryList);
        }
        // 得到的列表按类型分别放到attribute里
        setAttachmentToAttr(attachmentVoList);
        getRequest().setAttribute("financingApply", financingApply);
        getRequest().setAttribute("operType", "query");
        getRequest().setAttribute("subid", subid);
        return "/ybl4.0/admin/supplier/accountcenter/label/financinfailDetail";
    }
    
    /**
     *  附件列表按类型分别放到attribute里
     */
    public void setAttachmentToAttr(List<AttachmentVo> attachmentVoList) {
        for (AttachmentVo attachment : attachmentVoList) {
            if (E_V4_ATTACHMENT_TYPE.BUSINESS_LICENSE_THIRD.getStatus().equals(attachment.getType())) {
                // 营业执照(三证合一)
                getRequest().setAttribute("file12", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNT_OPENING_PERMIT.getStatus().equals(attachment.getType())) {
                // 开户许可证
                getRequest().setAttribute("file13", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.AGENCY_CREDIT_CODE.getStatus().equals(attachment.getType())) {
                // 机构信用代码证
                getRequest().setAttribute("file14", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LEGAL_REPRESENTATIVE_IDENTITY.getStatus().equals(attachment.getType())) {
                // 法人代表人身份证
                getRequest().setAttribute("file15", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANYS_ARTICLES_ASSOCIATION.getStatus().equals(attachment.getType())) {
                // 公司章程
                getRequest().setAttribute("file16", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.CAPITAL_VERFICATION_REPORT.getStatus().equals(attachment.getType())) {
                // 验资报告
                getRequest().setAttribute("file17", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ENTERPRISE_CREDIT_REPORT.getStatus().equals(attachment.getType())) {
                // 企业信用报告
                getRequest().setAttribute("file18", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.INTRODUCTION_COMPANY_SHAREHOLDERS.getStatus().equals(attachment.getType())) {
                // 公司股东介绍(包含实际控制人、股东关系、股权结构)
                getRequest().setAttribute("file21", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANY_EXECUTIVES.getStatus().equals(attachment.getType())) {
                // 公司高管介绍(包含董事长、总经理、财务总监等)
                getRequest().setAttribute("file22", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANY_BUSINESS_INTRODUCTION.getStatus().equals(attachment.getType())) {
                // 公司业务介绍(说明公司的主要经营业务、营收情况等)
                getRequest().setAttribute("file23", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINANCING_APPLICATION_FORM.getStatus().equals(attachment.getType())) {
                // 融资申请表
                getRequest().setAttribute("file11", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNTS_RECEIVABLE_ACCOUNTS_RECEIVABLE.getStatus().equals(attachment.getType())) {
                // 应收账款总账及明细账
                getRequest().setAttribute("file55", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNTS_PAYABLE_ACCOUNTS_PAYABLE.getStatus().equals(attachment.getType())) {
                // 应付账款总账及明细账
                getRequest().setAttribute("file56", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LOAN_QUERY_AUTHORIZATION.getStatus().equals(attachment.getType())) {
                // 贷款卡、贷款卡查询授权
                getRequest().setAttribute("file19", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LEASE_CONTRACT_PAYMENT_NEARLY_THREE_MONTHS.getStatus().equals(attachment.getType())) {
                // 租赁合同及近三个月缴费单据
                getRequest().setAttribute("file20", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINANCIAL_STATEMENTS_LAST_THREE_YEARS_RECENT_SIX_MONTHS.getStatus().equals(attachment.getType())) {
                // 最近三年经审计的财务报告及最近六个月财务报表
                getRequest().setAttribute("file24", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.BANK_CREDIT_LOAN_DETAILS.getStatus().equals(attachment.getType())) {
                // 银行授信及贷款明细
                getRequest().setAttribute("file25", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.DESCRIPTION_EXTERNAL.getStatus().equals(attachment.getType())) {
                // 对外担保情况说明
                getRequest().setAttribute("file26", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.NEARLY_YEAR_BANK_ACCOUNT_RUNNING_WARTER.getStatus().equals(attachment.getType())) {
                // 近一年的银行账户流水
                getRequest().setAttribute("file27", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.VALUE_ADDED_TAX_NEARLY_SIX_MONTHS.getStatus().equals(attachment.getType())) {
                // 近六个月的增值纳税申报表
                getRequest().setAttribute("file28", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_SALE_CONTRACT.getStatus().equals(attachment.getType())) {
                // 购销合同
                getRequest().setAttribute("file29", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_SALES_INVOICE.getStatus().equals(attachment.getType())) {
                // 销售发票(含清单)
                getRequest().setAttribute("file30", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_STOCK_ORDER.getStatus().equals(attachment.getType())) {
                // 采购订单、出入库清单、库存清单
                getRequest().setAttribute("file31", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING.getStatus().equals(attachment.getType())) {
                // 其他与融资相关的重要材料
                getRequest().setAttribute("file32", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.OTHER_SUPPLEMENTARY_INFORMATION.getStatus().equals(attachment.getType())) {
                // 其他补充资料
                getRequest().setAttribute("file33", attachment);
                continue;
            }
        }
    }
    
    
    public List<V4BusinessAuthVO> selectBusinessAuthNameList(V4BusinessAuthVO businessAuthVO){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("businessAuth",businessAuthVO);
        map.put("sign", "selectBusinessAuthNameList");
        ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
        //获取业务认证企业名称列表
        List<V4BusinessAuthVO> businessAuthList=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("businessAuthList");
                businessAuthList=JsonUtils.toList(records,V4BusinessAuthVO.class);
                log.info("查询业务认证企业名称列表成功====================");
            }
        }
        return businessAuthList;            
    }
    
    /**
	 * 条件查询附件列表
	 */
    public List<AttachmentVo> getFwAttachmentList(AttachmentVo attachmentVo){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter",attachmentVo);
		map.put("sign","queryAttchmentByCondition");
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		List<AttachmentVo> attachmentList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				attachmentList=JsonUtils.toList(records,AttachmentVo.class);
			}
		}
		return attachmentList;			
	}
    
    
    
    /**
     * 从交易报文中获取结果列表信息
     * @param tradeBody  返回报文
     * @param target 目标对象
     * @return
     */
    private <E> List<E> tradeResultToPageResult(ResBody tradeBody, E target){
    	PageVo<E> page = new PageVo<E>();
    	List<E> list = null;
    	JSONObject output = (JSONObject) tradeBody.getOutput();
		String jsonPage = output.getString("page");
		JSONObject json = (JSONObject) JSONObject.parse(jsonPage);
		String records = json.getString("records");
		page = JSONObject.parseObject(jsonPage, PageVo.class);
		list=(List<E>) JsonUtils.toList(records,target.getClass());
		return list;
    }
    
    /**
     * 从交易报文中获取page结果
     * @param tradeBody 返回报文
     * @return
     */
    private <E> PageVo<E> tradeResultToPage(ResBody tradeBody){
    	PageVo<E> page = new PageVo<E>();
    	JSONObject output = (JSONObject) tradeBody.getOutput();
		String jsonPage=output.getString("page");
		page = JSONObject.parseObject(jsonPage, PageVo.class);
		return page;
    }
    
}
