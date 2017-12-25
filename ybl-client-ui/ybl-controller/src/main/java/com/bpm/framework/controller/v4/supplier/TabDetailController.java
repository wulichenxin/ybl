package com.bpm.framework.controller.v4.supplier;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.controller.v4.supplier.settlement.RePaymentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.PlatformConfigFree;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApplyInfo;
import cn.sunline.framework.controller.vo.v4.supplier.SubFinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PAY_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 融资方 各个tab标签controller
 * @author xxx
 *
 */
@Controller
@RequestMapping({"/tabDetailController"})
public class TabDetailController extends AbstractController {
  
	private static final long serialVersionUID = 1L;
	
	/**
	 * 查询保理要素信息
	 *  type(资产类型); 1= 应收  2=应付  3=票据
	 *  loanApplyId 放款申请id
	 */
	@RequestMapping("/selectTotalElemets")
    public String selectTotalElemets(@RequestParam("type") String type, @RequestParam("loanApplyId") String loanApplyId) {
    	
    	Map<String, Object> param = new HashMap<String, Object>();
    	String elementType = type;
    	param.put("elementType", elementType);
    	param.put("loan_apply_id", loanApplyId);
    	Map<String,Object> tradeParam = new HashMap<String,Object>();
    	tradeParam.put("parameter", param);
    	tradeParam.put("sign", "queryElementsByLoanOrderId");
		ResBody tradeResult = TradeInvokeUtils.invoke("LoanProjectManagement", tradeParam);
 		if(isSuccess(tradeResult)){
			JSONObject result = (JSONObject) tradeResult.getOutput(); 
			String obj = result.getString("result");
			if(obj!=null&&!"".equals(obj)){
				if(elementType.equalsIgnoreCase("1")) {
					AccountsReceivableElementsVo receivableElementsResult = JsonUtils.toObject(obj,AccountsReceivableElementsVo.class);
					getRequest().setAttribute("vo", receivableElementsResult);
				}else if(elementType.equalsIgnoreCase("2")) {
					AccountsPayableElementsVo payableElementsResult = JsonUtils.toObject(obj,AccountsPayableElementsVo.class);
					getRequest().setAttribute("vo", payableElementsResult);
				}else if(elementType.equalsIgnoreCase("3")) {
					BillElementsVo billElementsResult = JsonUtils.toObject(obj,BillElementsVo.class);
					getRequest().setAttribute("vo", billElementsResult);
				}
			}else{
				getRequest().setAttribute("recordResult", "noRecords");
			}
		}else{
			super.log.error("根据资产类型与放款申请id查询保理要素信息: " + tradeResult.getSys().getErortx());
			return null;
		}
 		AttachmentVo attachmentVo = new AttachmentVo();
 		int rid = getFinalRiskId(Integer.valueOf(loanApplyId));
		if(type.equalsIgnoreCase("1")) {//跳转至应收账款保理要素页面
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus()));
			attachmentVo.setResourceId(Integer.valueOf(rid));
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
	 		getRequest().setAttribute("Attachmentlist", attachmentList);
	 		getRequest().setAttribute("assetsType", elementType);
			return "ybl4.0/admin/supplier/accountcenter/label/receivableElements";
		}else if(type.equalsIgnoreCase("2")) {//跳转至应付账款保理要素页面
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus()));
			attachmentVo.setResourceId(Integer.valueOf(rid));
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
	 		getRequest().setAttribute("Attachmentlist", attachmentList);
	 		getRequest().setAttribute("assetsType", elementType);
			return "ybl4.0/admin/supplier/accountcenter/label/payableElements";
		}else if(type.equalsIgnoreCase("3")) {
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus()));
			attachmentVo.setResourceId(Integer.valueOf(rid));
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
	 		getRequest().setAttribute("Attachmentlist", attachmentList);
	 		getRequest().setAttribute("assetsType", elementType);
			return "ybl4.0/admin/supplier/accountcenter/label/billElements";
		}
 		return "";
    }
	
	
	/**
	 * 根据放款申请id查询风控终审id
	 */
	public int getFinalRiskId(int lid) {
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("id", lid);
		map.put("paramter",mapinfo);
		map.put("sign", "queryFinalRiskId");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		int rid = 0;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				rid = JsonUtils.toObject(records, int.class);
				super.log.error("查询风控终审id服务返回成功，信息："+rid);
			}else{
				super.log.error("查询风控终审id服务返回失败，信息："+erortx);
			}
		}
		return rid;
	}
	
	
	/**
	 * 根据放款订单号查询还款信息(每一期还款信息)
	 * @param orderNo
	 * @return
	 */
	@RequestMapping(value = "/repaymentInfo")
	public String RepaymentInfo(@RequestParam("orderNo") String orderNo){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order_no", orderNo);
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
					if(repayMent.getOverdue_days() > 0){
						repayment_principal = repayment_principal.add(repayMent.getOverdue_fee());
					}else{
						repayMent.setOverdue_days(0);
					}
					repayMent.setRepayment_count(repayment_principal);
					repayment_wait =  repayment_wait.add(repayment_principal);
				}
				getRequest().setAttribute("noPayMents", noPayMents);
				getRequest().setAttribute("hasPayMents", hasPayMents);
				getRequest().setAttribute("repayment_wait", repayment_wait); //待还款金额 = 所有未还本金+利息+逾期费用
			}
		}
		return "ybl4.0/admin/supplier/accountcenter/label/paymentInfoAndConfirm";
	}
	
	
	/**
	 * orderNo 放款申请订单号
	 * id 还款id
	 * overfee 逾期费用
	 * financingAmout 融资金额
     * 单期还款
	 * @throws UnsupportedEncodingException 
     */
    @RequestMapping("/suppliereceivingadd")
    public String toSuppliereceivingaddPage(@RequestParam("orderNo") String orderNo, 
    										@RequestParam("id") String id, 
    										@RequestParam(value="overfee",required=false,defaultValue="0") String overfee,
    										@RequestParam("financingAmount") String financingAmount) throws UnsupportedEncodingException {
    	//根据放款id本期应还款的信息
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("id", id);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "selectRepayInfoById");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);
		FactorCollectionManagementRepaymentPlanVo repay=null;
 		if(isSuccess(result)){
			JSONObject output = (JSONObject) result.getOutput(); 
			String records = output.getString("result");
			repay = JsonUtils.toObject(records,FactorCollectionManagementRepaymentPlanVo.class);
		}else{
			super.log.error("根据放款id本期应还款交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		getRequest().setAttribute("repay", repay);
		getRequest().setAttribute("id", id); // 还款id
		getRequest().setAttribute("financingName", repay.getFinancingName()); //资金方名称
		getRequest().setAttribute("overfee", overfee); //逾期费用
		getRequest().setAttribute("orderNo", orderNo); // 放款申请单号
		getRequest().setAttribute("financingAmount", financingAmount);//融资金额
		
 		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order_no", orderNo);
		map.put("sign", "selectReypayMentByOrder");
		ResBody totalAmoutParamResult = TradeInvokeUtils.invoke("RepayMentManagement", map);
		BigDecimal repayment_wait = new BigDecimal(0);
		BigDecimal repayedment = new BigDecimal(0);
		if (isSuccess(totalAmoutParamResult)) {
			String retStatus = totalAmoutParamResult.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) totalAmoutParamResult.getOutput();
				String jsonPage = output.getString("noPayMents");
				String hasJsonPage = output.getString("hasPayMents");
				List<RePaymentVo> noPayMents = JSONObject.parseArray(jsonPage, RePaymentVo.class);
				List<RePaymentVo> hasPayMents = JSONObject.parseArray(hasJsonPage, RePaymentVo.class);
				for (RePaymentVo repayMent : noPayMents) {
					repayMent.setOverdue_fee(repayMent.getRepayment_principal().multiply(repayMent.getOverdue_interest_rate())
							.multiply(new BigDecimal(repayMent.getOverdue_days()))
							.divide(new BigDecimal(36000), 2, BigDecimal.ROUND_HALF_UP));
					BigDecimal repayment_principal = repayMent.getRepayment_interest().add(repayMent.getRepayment_principal());
					if(repayMent.getOverdue_days() > 0){//判断逾期天数
						repayment_principal = repayment_principal.add(repayMent.getOverdue_fee());
					}else{
						repayMent.setOverdue_days(0);
					}
					repayMent.setRepayment_principal(repayment_principal);
					repayment_wait =  repayment_wait.add(repayment_principal);
					repayedment = repayedment.add(repayMent.getActual_amount());
				}
				getRequest().setAttribute("noPayMents", noPayMents.size() > 0 ? noPayMents : "0.00");
				getRequest().setAttribute("total_payed_amout", repayedment);
				getRequest().setAttribute("total_repay_amout", repayment_wait); //待还款金额 = 所有未还本金+利息+逾期费用
			}
		}
 		
 		
 		//查询还款附件
 		AttachmentVo attach = new AttachmentVo();
    	attach.setResourceId(Integer.valueOf(repay.getId().toString()));
    	attach.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
    	attach.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_PARTY_REPAYMENTS.getStatus());
    	attach.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
    	List<AttachmentVo> attachmentList = getFwAttachmentList(attach);
    	if(attachmentList != null && attachmentList.size() > 0) {
    		getRequest().setAttribute("repayAttach", attachmentList.get(0));
    	}
    	
 		getRequest().setAttribute("pageFlag", "8");
    	return "ybl4.0/admin/supplier/accountcenter/label/suppliereceivingadd";
    }
    
    
    
    /**
     * 根据放款申请id查询资产转让函附件
     * @param loanApplyId 放款申请id
     * @return
     */
    @RequestMapping("/selectAssetAttach")
    public String selectTotalElemets(@RequestParam("loanApplyId") int loanOrderId) {
 		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachmentVo.setResourceId(loanOrderId);
		attachmentVo.setType(E_V4_ATTACHMENT_TYPE.ASSET_TRANSFER_LETTER.getStatus());
 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
 		getRequest().setAttribute("attch", attachmentList.size() > 0 ? attachmentList.get(0) : null);
    	return "ybl4.0/admin/supplier/accountcenter/label/assettransfer";
    }
    
    
    /**
     * 根据放款订单id查询平台审核结果
     * @param loanApplyId
     * @return
     */
    @RequestMapping("/selectPlatAudiByLoanOrderId")
    public String selectPlatAudiByLoanOrderId(@RequestParam("loanApplyId") String loanApplyId) {
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_id",loanApplyId);
    	Map<String,Object> tradeParam = new HashMap<String,Object>();
    	tradeParam.put("parameter", param);
    	tradeParam.put("sign", "selectFlatformAudiByLoan");
		ResBody tradeResult = TradeInvokeUtils.invoke("LoanProjectManagement", tradeParam);
		Map<String, Object> result = null;
 		if(isSuccess(tradeResult)){
			JSONObject output = (JSONObject) tradeResult.getOutput(); 
			String resultStr = output.getString("result");
			if(!StringUtils.isEmpty(resultStr)) {
				result = JsonUtils.toObject(resultStr,Map.class);
				getRequest().setAttribute("remark", result.get("remark"));
				getRequest().setAttribute("audit_result", result.get("audit_result")); 
			}else{
				getRequest().setAttribute("remark", "");
				getRequest().setAttribute("audit_result", ""); 
			}
			
		}else{
			super.log.error("根据放款订单号查询平台审核结果交易返回错误信息: " + tradeResult.getSys().getErortx());
			return null;
		}
 		
    	return "ybl4.0/admin/supplier/accountcenter/label/platAudit";
    }
    
    /**
     * 根据放款订单号查询结算放款信息
     */
    @RequestMapping("/selectSettleInfoByLoanOrderNo")
    public String selectSettleInfoByOrderNo(@RequestParam("orderNo") String orderNo, @RequestParam("financingAmount") String financingAmount) {
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
			if(factorLoanVo != null && StringUtils.isNotEmpty(factorLoanVo.getActualLoanDate()) ) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
				factorLoanVo.setActualLoanDate(dateStr);
			}
			getRequest().setAttribute("paymentBatch", factorLoanVo);
			getRequest().setAttribute("financingAmount", financingAmount);
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		if(factorLoanVo != null) {
 			AttachmentVo attachment = new AttachmentVo();
 	 		attachment.setType(E_V4_ATTACHMENT_TYPE.LOAN_SETTLEMENT_PAYMENT_VOUCHER.getStatus());
 			attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
 			attachment.setResourceId(Integer.parseInt(factorLoanVo.getAttribute10()));
 			List<AttachmentVo> attachmentList = getFwAttachmentList(attachment);
 			if(null != attachmentList && attachmentList.size() > 0) {
 				getRequest().setAttribute("attachment", attachmentList.get(0));
 			}else {
 				getRequest().setAttribute("attachment", null);
 			}
 		}
 		//查询平台费用
 		Map<String,Object> configFree = new HashMap<String,Object>();
		PlatformConfigFree configFreeEntity = new PlatformConfigFree();
		configFreeEntity.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		configFree.put("parameter", configFreeEntity);
		configFree.put("sign", "queryPlatformConfigFreeByCondition");	
		ResBody configFreeResult = TradeInvokeUtils.invoke("V4PlatformConfigFreeManagement", configFree);
		PlatformConfigFree configFreeReturnPage=null;
		isSuccess(configFreeResult);
		List<PlatformConfigFree> platformConfigFreeList = null;
 		if(isSuccess(result)){
			JSONObject configFreeoutput = (JSONObject) configFreeResult.getOutput();
			String configFreerecords = configFreeoutput.getString("result");
			platformConfigFreeList = JsonUtils.toList(configFreerecords, PlatformConfigFree.class);
			if(platformConfigFreeList.size() > 0) {
				configFreeReturnPage = platformConfigFreeList.get(0);
				getRequest().setAttribute("platformConfigFree", configFreeReturnPage);
				BigDecimal actual_rate = configFreeReturnPage.getRate().subtract(configFreeReturnPage.getReductionRate()); //实际费率
				BigDecimal plat_free = factorLoanVo.getActualLoanAmount().multiply(actual_rate).divide(new BigDecimal(100),2,BigDecimal.ROUND_HALF_UP); //平台实际费用
				getRequest().setAttribute("plat_free", plat_free);//平台费用
			}
		}else{
			super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
			return null;
		}
 		return "ybl4.0/admin/supplier/accountcenter/label/paymentInfo";
    }
    
    /**
     * 收款确认页面
     * @param orderNo 放款申请单号
     * @param financingAmount  融资金额
     * @param loanOrderId 放款申请id
     * @return
     */
    @RequestMapping("/selectReceiveConfirmByOrderNoAndLoanOrderId")
    public String selectReceiveConfirmByOrderNoAndLoanOrderId(@RequestParam("orderNo") String orderNo, 
    														  @RequestParam("financingAmount") String financingAmount,
    														  @RequestParam("loanOrderId") int loanOrderId) {
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
			if(factorLoanVo.getActualLoanDate() != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
				String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
				factorLoanVo.setActualLoanDate(dateStr);
			}
			getRequest().setAttribute("paymentBatch", factorLoanVo);
			getRequest().setAttribute("financingAmount", financingAmount);
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		if(factorLoanVo != null) {
 			//查询放款支付凭证附件
 			AttachmentVo attachment = new AttachmentVo();
 	 		attachment.setType(E_V4_ATTACHMENT_TYPE.LOAN_SETTLEMENT_PAYMENT_VOUCHER.getStatus());
 			attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
 			attachment.setResourceId(Integer.parseInt(factorLoanVo.getAttribute10()));
 			List<AttachmentVo> attachmentList = getFwAttachmentList(attachment);
 			if(null != attachmentList && attachmentList.size() > 0) {
 				getRequest().setAttribute("attachment", attachmentList.get(0));
 			}else {
 				getRequest().setAttribute("attachment", null);
 			}
 		}
 		//查询平台费用
 		Map<String,Object> configFree = new HashMap<String,Object>();
		PlatformConfigFree configFreeEntity = new PlatformConfigFree();
		configFreeEntity.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		configFree.put("parameter", configFreeEntity);
		configFree.put("sign", "queryPlatformConfigFreeByCondition");	
		ResBody configFreeResult = TradeInvokeUtils.invoke("V4PlatformConfigFreeManagement", configFree);
		PlatformConfigFree configFreeReturnPage=null;
		isSuccess(configFreeResult);
		List<PlatformConfigFree> platformConfigFreeList = null;
 		if(isSuccess(result)){
			JSONObject configFreeoutput = (JSONObject) configFreeResult.getOutput();
			String configFreerecords = configFreeoutput.getString("result");
			platformConfigFreeList = JsonUtils.toList(configFreerecords, PlatformConfigFree.class);
			if(platformConfigFreeList.size() > 0) {
				configFreeReturnPage = platformConfigFreeList.get(0);
				getRequest().setAttribute("platformConfigFree", configFreeReturnPage);
				BigDecimal actual_rate = configFreeReturnPage.getRate().subtract(configFreeReturnPage.getReductionRate()); //实际费率
				BigDecimal plat_free = factorLoanVo.getActualLoanAmount().multiply(actual_rate).divide(new BigDecimal(100),2,BigDecimal.ROUND_HALF_UP); //平台实际费用
				getRequest().setAttribute("plat_free", plat_free);//平台费用
			}
		}else{
			super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
			return null;
		}
 		
 		//查询收款确认附件
 		AttachmentVo attach = new AttachmentVo();
    	attach.setResourceId(loanOrderId);
    	attach.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_RECEIPT_CONFIRMATION.getStatus());
    	attach.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.MANAGEMENT_MANAGEMENT_FINANCING.getStatus()));
    	List<AttachmentVo> attachmentList = getFwAttachmentList(attach);
    	if(attachmentList != null && attachmentList.size() > 0) {
    		getRequest().setAttribute("receiveConfirmAttach", attachmentList.get(0));
    	}
 		return "ybl4.0/admin/supplier/accountcenter/label/paymentInfoConfirm";
    }
    
    /**
     * 根据放款订单号查询还款计划
     * @param orderNo 放款订单号
     * @return
     */
    @RequestMapping("selectRepayPlanByLoanOrderNo")
    public String selectRepayPlanByLoanOrderNo(@RequestParam("orderNo") String orderNo) {
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_order_no", orderNo);
    	param.put("confirm_status", 0);
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
				long overdays = DateUtils.dayDiff(new Date(),list.get(i).getRepaymentDate());
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
    	return "ybl4.0/admin/supplier/accountcenter/label/overdue";
    }
    
    
    /*
	 * 查询放款申请项目详情
	 * loanApplyId 放款申请id
	 */

	@RequestMapping(value = "/loanappictionitem")
	public String loanappictionitem(@RequestParam("loanApplyId") String loanApplyId) {
		UserVo user = ControllerUtils.getCurrentUser();
		// 获取放款申请主信息
		LoanApply loanApply = new LoanApply();
		loanApply.setId(Long.valueOf(loanApplyId));
		LoanApply loanApplyVO = new LoanApply();
		List<LoanApply> loanApplyList = selectLoanApplyList(loanApply);
		if (loanApplyList.size() > 0) {
			loanApplyVO = loanApplyList.get(0);
		}
		SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
		subFinancingApplyVO.setId(loanApplyVO.getSubFinancingApplyId().longValue());
		List<SubFinancingApplyVO> subList = getSubList(subFinancingApplyVO);
		if (subList.size() > 0) {
			getRequest().setAttribute("financingApplyId", subList.get(0).getFinancing_apply_id());
		}
		// 获取资料列表
		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachmentVo.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
		// 获取附件列表
		AttachmentVo attachment = new AttachmentVo();
		attachment.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachment.setType(String.valueOf(E_V4_ATTACHMENT_TYPE.LOAN_ASSETS.getStatus()));
		attachment.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> assetList = FinancingApplyCommonApi.getFwAttachmentList(attachment);
		// 根据资产类型查找资产列表
		if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
			// 应收账款
			AccountsReceivableV4VO accountsReceivableV4VO = new AccountsReceivableV4VO();
			accountsReceivableV4VO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsReceivableV4VO> accountsReceivableList = selectAccountsReceivableList(accountsReceivableV4VO);
			getRequest().setAttribute("receivableList", accountsReceivableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
			// 应付账款
			AccountsPayableVO accountsPayableVO = new AccountsPayableVO();
			accountsPayableVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsPayableVO> accountsPayableList = selectAccountsPayableList(accountsPayableVO);
			getRequest().setAttribute("repayableList", accountsPayableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
			// 票据
			BillVO billVO = new BillVO();
			billVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<BillVO> billList = selectBillList(billVO);
			getRequest().setAttribute("billList", billList);
		}
		
		
		// 得到的列表按类型分别放到attribute里
		setAttachmentToAttr(attachmentVoList);
		getRequest().setAttribute("loanApplyVO", loanApplyVO);
		getRequest().setAttribute("assetList", assetList);
		getRequest().setAttribute("operType", "query");
 		
		return "ybl4.0/admin/supplier/accountcenter/label/loanappictionitem";
	}
	
	/**
	 *  附件列表按类型分别放到attribute里
	 */
	public void setAttachmentToAttr(List<AttachmentVo> attachmentVoList) {
		for (AttachmentVo attachment : attachmentVoList) {
			// 这里类型先写死数字,后续更改
			if (E_V4_ATTACHMENT_TYPE.LOAN_PURCHASE_SALE_CONTRACT.getStatus().equals(attachment.getType())) {
				// 购销合同
				getRequest().setAttribute("file41", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_SALES_INVOICE.getStatus().equals(attachment.getType())) {
				// 销售发票(含清单)
				getRequest().setAttribute("file42", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_PURCHASE_STOCK_ORDER.getStatus().equals(attachment.getType())) {
				// 采购订单、出入库清单、库存清单
				getRequest().setAttribute("file43", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING.getStatus().equals(attachment.getType())) {
				// 其他与融资相关的重要材料
				getRequest().setAttribute("file44", attachment);
				continue;
			}
		}
	}
	
	/**
	 * 票据列表
	 */
	public List<BillVO> selectBillList(BillVO billVO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",billVO);
		map.put("sign", "selectBillList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 票据列表信息
		List<BillVO> billList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				billList=JsonUtils.toList(records,BillVO.class);
				log.info("查询出票据列表成功====================");
			}
		}
		return billList;			
	}
	
	/**
	 * 应付账款列表
	 */
	public List<AccountsPayableVO> selectAccountsPayableList(AccountsPayableVO accountsPayableVO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",accountsPayableVO);
		map.put("sign", "selectAccountsPayableList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 应付账款列表信息
		List<AccountsPayableVO> accountsPayableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				accountsPayableList=JsonUtils.toList(records,AccountsPayableVO.class);
				log.info("查询应付账款列表成功====================");
			}
		}
		return accountsPayableList;			
	}
	
	/**
	 * 应收账款
	 */
	public List<AccountsReceivableV4VO> selectAccountsReceivableList(AccountsReceivableV4VO accountsReceivableV4VO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",accountsReceivableV4VO);
		map.put("sign", "selectAccountsReceivableList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 应收账款列表信息
		List<AccountsReceivableV4VO> accountsReceivableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				accountsReceivableList=JsonUtils.toList(records,AccountsReceivableV4VO.class);
				log.info("查询应收账款列表成功====================");
			}
		}
		return accountsReceivableList;			
	}
	
	/**
	 * 查询子融资查询
	 */
	public List<SubFinancingApplyVO> getSubList(SubFinancingApplyVO subFinancingApplyVO){
		Map<String,Object> maps = new HashMap<String,Object>();
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
			}else{
				super.log.error("查询子融资查询返回失败，信息："+erortx);
				return null;
			}			
		}
		return subFinancingApplyVOList;
		
	}
	
	/**
	 * 放款申请列表
	 */
	public List<LoanApply> selectLoanApplyList(LoanApply loanApply){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",loanApply);
		map.put("sign", "selectLoanApplyList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 放款申请列表信息
		List<LoanApply> loanApplyList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				loanApplyList=JsonUtils.toList(records,LoanApply.class);
				log.info("查询出放款申请列表成功====================");
			}
		}
		return loanApplyList;			
	}
    
    /**
     * 逾期费用=（逾期金额 * 逾期利率）/360 * 逾期天数
     * @return
     */
    private BigDecimal overFee(BigDecimal principal, BigDecimal overdays, BigDecimal rate) {
    	return principal.multiply(rate).divide(new BigDecimal(360),2,BigDecimal.ROUND_HALF_UP).multiply(overdays).divide(new BigDecimal(100),2,BigDecimal.ROUND_HALF_UP);
    }
    
    /**
	 * 条件查询附件列表
	 * attachmentVo  附件实体
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
	 * 条件查询保理要素页面相关附件列表
	 */
	public void queryAttachmentList(Map<String, Object> mapInfo) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter",mapInfo);
		map.put("sign", "queryRiskAttachmentInfo");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		
		List<AttachmentVo> Attachmentlist = null;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if(null != records) {
					Attachmentlist = JsonUtils.toList(records,AttachmentVo.class);
				}
				getRequest().setAttribute("Attachmentlist", Attachmentlist);
				super.log.error("查询风控措施附件服务返回成功，信息："+Attachmentlist);
			}else{
				super.log.error("查询风控措施附件服务返回失败，信息："+erortx);
			}
		}
	}
    
	/**
	 * 根据放款申请id与资产类型查询底层资产信息
	 * id 放款申请id
	 * assetsType 资产类型 1=应收账款  2=应付账款  3=票据
	 */
	public void getAssetsById(int id, Integer assetsType) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(1 == assetsType) {//应收账款
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryReceivableById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			
			List<AccountsReceivableV4VO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,AccountsReceivableV4VO.class);
						//转让应收账款金额
						for (AccountsReceivableV4VO rvo : assetslist) {
							if(null != rvo.getAmountsReceivableMoney()) {
								totalAmount = totalAmount.add(rvo.getAmountsReceivableMoney());
							}
						}
					}
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询应收账款服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询应收账款服务返回失败，信息："+erortx);
				}
			}
		}else if(2 == assetsType) {//应付账款
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryPayableById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			
			List<AccountsPayableVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,AccountsPayableVO.class);
						//转让应付账款金额
						for (AccountsPayableVO rvo : assetslist) {
							if(null != rvo.getAmountsPayableMoney()) {
								totalAmount =  totalAmount.add(rvo.getAmountsPayableMoney());
							}
						}
					}
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询应付账款服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询应付账款服务返回失败，信息："+erortx);
				}
			}
		}else if(3 == assetsType) {//票据
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryPayableById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			
			List<BillVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,BillVO.class);
						//票面金额
						for (BillVO bvo : assetslist) {
							if(null != bvo.getBillAmount()) {
								totalAmount =  totalAmount.add(bvo.getBillAmount());
							}
						}
					}
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询票据服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询票据服务返回失败，信息："+erortx);
				}
			}
		}
	}
}
