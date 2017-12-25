package com.bpm.framework.controller.v4.common;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementPaymentBatchVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformAuditRecordVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformConfigFreeVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanapplyChildrenQueryVO;
import cn.sunline.framework.controller.vo.v4.supplier.PlatformConfigFree;
import cn.sunline.framework.controller.vo.v4.supplier.RepaymentPlanVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PAY_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.supplier.settlement.RePaymentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0放款申请公共api
 */
@Controller
@RequestMapping({ "/loanApplyCommonApi" })
public class LoanApplyCommonApi extends AbstractController {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8844465188913291773L;

	/**
	 * 查询放款申请项目详情
	 * @param loanApplyId
	 * @return
	 */
	@ValidateSession(validate = false)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/{loanApplyId}/loanApplyDetail.htm")
	public String loanApplyDetail(@PathVariable("loanApplyId")Integer loanApplyId) {
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("id_", loanApplyId);
		maps.put("sign", "loanapplicationitems");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery", maps);
		isSuccess(result);
		LoanApply resultInfo = new LoanApply() ;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringInfo = output.getString("item");
				resultInfo= JSONObject.parseObject(stringInfo, LoanApply.class);
				getRequest().setAttribute("resultInfo", resultInfo);
				if(resultInfo.getMasterContractNo()!=null&&!"".equals(resultInfo.getMasterContractNo())){
					ContractQuotaV4Vo contract=new ContractQuotaV4Vo();
					ContractQuotaV4Vo contracts=new ContractQuotaV4Vo();
					PageVo<?> page=new PageVo();
					contract.setMasterContractNo(resultInfo.getMasterContractNo());
					contracts=querycontractQuotaByCondition(contract, page);
					getRequest().setAttribute("contracts", contracts);
				}
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息："+stringInfo);
			}else{
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息："+erortx);
			}			
		}	
 		//查询附件列表
		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setResourceId(loanApplyId);
		attachmentVo.setCategory(6L);
		List<AttachmentVo> attachmentList = SelectAttachmentList(attachmentVo);
 		getRequest().setAttribute("attachmentList", attachmentList);
 		//根据资产类型查询不同的底层资产
 		if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(1)){
 			//查询应收账款信息
 			AccountsReceivableV4VO accountsReceivableV4VO =new AccountsReceivableV4VO();
 			accountsReceivableV4VO.setLoanApplyId(loanApplyId);
 			Map<String, Object> mapAccountsReceivable = new HashMap<String, Object>();
 			mapAccountsReceivable.put("parameter", accountsReceivableV4VO);
 			mapAccountsReceivable.put("sign", "selectAccountsReceivableByCondition");// 所调用的服务中的方法
			ResBody resultAccountsReceivable = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapAccountsReceivable);
			List<AccountsReceivableV4VO> accountsReceivableList = new ArrayList<AccountsReceivableV4VO>();
			if (resultAccountsReceivable.getSys() != null) {
				String statusAccountsReceivable = resultAccountsReceivable.getSys().getStatus();
				if ("S".equals(statusAccountsReceivable)) {// 交易成功
					JSONObject outputAccountsReceivable = (JSONObject) resultAccountsReceivable.getOutput();
					String recordsAccountsReceivable = outputAccountsReceivable.getString("result");
					if(recordsAccountsReceivable!=null){		
						accountsReceivableList = JsonUtils.toList(recordsAccountsReceivable, AccountsReceivableV4VO.class);
					}
					getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
				}
			}
 		} else if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(2)){
 			//查询应付账款信息
 			AccountsPayableVO accountsPayableVO=new AccountsPayableVO();
 			accountsPayableVO.setLoanApplyId(Integer.parseInt(resultInfo.getId().toString()));
 			Map<String, Object> mapAccountsPayablee = new HashMap<String, Object>();
 			mapAccountsPayablee.put("parameter", accountsPayableVO);
 			mapAccountsPayablee.put("sign", "selectAccountsPayableByCondition");// 所调用的服务中的方法
			ResBody resultAccountsPayable = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapAccountsPayablee);
			List<AccountsPayableVO> accountsPayableList = new ArrayList<AccountsPayableVO>();
			if (resultAccountsPayable.getSys() != null) {
				String statusAccountsPayable = resultAccountsPayable.getSys().getStatus();
				if ("S".equals(statusAccountsPayable)) {// 交易成功
					JSONObject outputAccountsPayable = (JSONObject) resultAccountsPayable.getOutput();
					String recordsAccountsPayable = outputAccountsPayable.getString("result");
					if(recordsAccountsPayable!=null){
					accountsPayableList = JsonUtils.toList(recordsAccountsPayable, AccountsPayableVO.class);
					}
					getRequest().setAttribute("accountsPayableList", accountsPayableList);
				}
			}
 		} else if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(3)){
 			//查询应付账款信息
 			BillVO billVO=new BillVO();
 			billVO.setLoanApplyId(Integer.parseInt(resultInfo.getId().toString()));
 			Map<String, Object> mapBill = new HashMap<String, Object>();
 			mapBill.put("parameter", billVO);
 			mapBill.put("sign", "selectBillByCondition");// 所调用的服务中的方法
			ResBody resultBill = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapBill);
			List<BillVO> billList = new ArrayList<BillVO>();
			if (resultBill.getSys() != null) {
				String statusBill = resultBill.getSys().getStatus();
				if ("S".equals(statusBill)) {// 交易成功
					JSONObject outputBill = (JSONObject) resultBill.getOutput();
					String recordsBill = outputBill.getString("result");
					if(recordsBill!=null){
					billList = JsonUtils.toList(recordsBill, BillVO.class);
					}
					getRequest().setAttribute("billList", billList);
				}
			}
 		}
 		return "ybl4.0/admin/common/loan_apply_details";
	}
	
	//根据合同号查询合同总额和剩余余额	
	@SuppressWarnings("unchecked")
	private ContractQuotaV4Vo querycontractQuotaByCondition(ContractQuotaV4Vo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("v4ContractQuotaInfo", parameters);
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("V4QueryContractQuotaManagement", map);
		List<ContractQuotaV4Vo> lists = new ArrayList<ContractQuotaV4Vo>();
		ContractQuotaV4Vo cont=new ContractQuotaV4Vo();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String pageJson = output.getString("page");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				if(page.getRecords().size()>0 && null!=page){
					lists=JsonUtils.toList(page.getRecords().toString(),ContractQuotaV4Vo.class);	
					cont.setNewCreditAmount(lists.get(0).getNewCreditAmount());
					cont.setAllAmount(lists.get(0).getAllAmount());
				}				
				super.log.info("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回失败，信息：" + erortx);
				return null;
			}
		}
		return cont;
	}
		
	public List<AttachmentVo> SelectAttachmentList(AttachmentVo  attachment){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		if(!"[]".equals(resultJson)&&resultJson!=null){
			attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		}
		return attachmentList;
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
				getRequest().setAttribute("financingstatus", Integer.valueOf(financingstatus));
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
		
		return "ybl4.0/admin/common/loanapplydetail/view";
		}

/*	*//**
	 * 还款计划表
	 * 
	 *//*

	@RequestMapping("/repaymentlist.htm")
	public String repaymentlist(HttpServletRequest request,@RequestParam(value = "id", required = false) Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id_", id);
		map.put("sign", "repaymentplan");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery",
				map);
		List<RepaymentPlanVO>list = null;
       if(result!=null  &&!"".equals(result)){
    	   if (result.getSys() != null) {
   			String status = result.getSys().getStatus();
   			String erortx = result.getSys().getErortx();// 错误信息
   			if ("S".equals(status)) {// 交易成功
   				JSONObject output = (JSONObject) result.getOutput();
   				String records = output.getString("planlist");
				list=JsonUtils.toList(records, RepaymentPlanVO.class);
				if(list.size()>0){
					for(RepaymentPlanVO re :list ){	
						if(re.getRepayment_status()!= 2) {//已还款的要把逾期天数直接从数据库取出来，不用再计算
							Date date1=re.getRepayment_date();
							Date date2=new Date();
							int overdays=getBetweenDay(date1,date2);
							re.setOverdue_days(overdays<0?0:overdays);
							re.setOver_money(re.getRepayment_principal().multiply(re.getOverdue_interest_rate())
								.multiply(new BigDecimal(re.getOverdue_days()))
								.divide(new BigDecimal(36000), 2, BigDecimal.ROUND_HALF_UP));
						}
					}
					
				}
   				getRequest().setAttribute("record", list);
   				
   			}
   		}
		}
		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/unconfirmed_list";

	}*/
	
	/**
     * 根据放款订单号查询还款计划
     * @param loanProjectVO
     * @return
     */
    @RequestMapping("/repaymentlist.htm")
    public String selectRepayPlanByLoanOrderNo(@RequestParam("orderNo") String orderNo) {
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
    	
    	return "ybl4.0/admin/supplier/loanapplicationQuery/tab/unconfirmed_list";
    }
	
	
	
	
	//计算逾期得天数
	 public static int getBetweenDay(Date date1, Date date2) {  
	        Calendar d1 = new GregorianCalendar();  
	        d1.setTime(date1);  
	        Calendar d2 = new GregorianCalendar();  
	        d2.setTime(date2);  
	        int days = d2.get(Calendar.DAY_OF_YEAR)- d1.get(Calendar.DAY_OF_YEAR);  
	        System.out.println("days="+days);  
	        int y2 = d2.get(Calendar.YEAR);  
	        if (d1.get(Calendar.YEAR) != y2) {  
//	          d1 = (Calendar) d1.clone();  
	            do {  
	                days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);  
	                d1.add(Calendar.YEAR, 1);  
	            } while (d1.get(Calendar.YEAR) != y2);  
	        }  
	        return days; 
	
	 }

	/**
	 * 放款申请平台审核
	 * 
	 */
	
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/platAudit")
	public String platAudit(Long id) {
		/*Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("financing_apply_id", id);
		map.put("category",2);
		map.put("sign", "platformTrial");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",	map);
		List<PlatformAuditRecordVo> audit=new ArrayList<PlatformAuditRecordVo>();

		if(result!=null  &&!"".equals(result)){
	    	   if (result.getSys() != null) {
	   			String status = result.getSys().getStatus();
	   			if ("S".equals(status)) {// 交易成功
	   				
	   				JSONObject output = (JSONObject) result.getOutput();	
	   				String records = output.getString("record");
	   				if(!StringUtils.isEmpty(records)) {
	   				audit  = JsonUtils.toList(records, PlatformAuditRecordVo.class);
	   				if(audit.size()>0){
	   					PlatformAuditRecordVo auditVo=audit.get(0);
	   					getRequest().setAttribute("records", auditVo);
	   				}else{
	   					getRequest().setAttribute("recordResult", "noRecords");
	   				}
	   				}
	   			}
	   		}
		
		}*/
		Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_id",id);
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
				getRequest().setAttribute("recordResult", "noRecords");
				getRequest().setAttribute("remark", "");
				getRequest().setAttribute("audit_result", ""); 
			}
		}else{
			super.log.error("根据放款订单号查询平台审核结果交易返回错误信息: " + tradeResult.getSys().getErortx());
			return null;
		}
		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/platAudit";
	
	}
	public ResBody Settlement(Integer batchId) {
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("batchId", batchId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("batchId", batchId);
		if(user!=null){
			param.put("enterpriseId", user.getEnterpriseId());
		}
			
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getPaymentBatchById");
		ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
		
		return result;
	}

	/**
	 * 资产转让确权
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/assettransfer.html")
	public String assettransfer(Integer id) {
		//根据放款的id查询附件信息
		AttachmentVo attachment = new AttachmentVo();
 		attachment.setType("48");
		attachment.setCategory(6L);
		attachment.setResourceId(id);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		AttachmentVo att = new AttachmentVo();
		if(!"[]".equals(resultJson)&&resultJson!=null){
			
			attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		}
		if(attachmentList != null && attachmentList.size()>=0){
			att = attachmentList.get(0);
			getRequest().setAttribute("attch", att);
		}
		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/assettransfer";

	}
	
	/*
	 * 查询放款申请项目详情
	 * 
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loanappictionitem.html")
	public String loanappictionitem(Integer id) {
		//根据子融资定单的id查询附件信息
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("id_", id);
		maps.put("sign", "loanapplicationitems");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery", maps);
		isSuccess(result);
		LoanApply resultInfo = new LoanApply() ;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringInfo = output.getString("item");
				resultInfo= JSONObject.parseObject(stringInfo, LoanApply.class);
				getRequest().setAttribute("resultInfo", resultInfo);
				if(resultInfo.getMasterContractNo()!=null&&!"".equals(resultInfo.getMasterContractNo())){
					ContractQuotaV4Vo contract=new ContractQuotaV4Vo();
					ContractQuotaV4Vo contracts=new ContractQuotaV4Vo();
					PageVo<?> page=new PageVo();
					contract.setMasterContractNo(resultInfo.getMasterContractNo());
					contracts=querycontractQuotaByCondition(contract, page);
					getRequest().setAttribute("contracts", contracts);
				}
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息："+stringInfo);
			}else{
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息："+erortx);
			}			
		}	
 		
 		//查询附件列表
		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setResourceId(id);
		attachmentVo.setCategory(6L);
		List<AttachmentVo> attachmentList = SelectAttachmentList(attachmentVo);
 		getRequest().setAttribute("attachmentList", attachmentList);
 		
 		//根据资产类型查询不同的底层资产
 		if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(1)){
 			//查询应收账款信息
 			AccountsReceivableV4VO accountsReceivableV4VO =new AccountsReceivableV4VO();
 			accountsReceivableV4VO.setLoanApplyId(id);
 			Map<String, Object> mapAccountsReceivable = new HashMap<String, Object>();
 			mapAccountsReceivable.put("parameter", accountsReceivableV4VO);
 			mapAccountsReceivable.put("sign", "selectAccountsReceivableByCondition");// 所调用的服务中的方法
			ResBody resultAccountsReceivable = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapAccountsReceivable);
			List<AccountsReceivableV4VO> accountsReceivableList = new ArrayList<AccountsReceivableV4VO>();
			if (resultAccountsReceivable.getSys() != null) {
				String statusAccountsReceivable = resultAccountsReceivable.getSys().getStatus();
				if ("S".equals(statusAccountsReceivable)) {// 交易成功
					JSONObject outputAccountsReceivable = (JSONObject) resultAccountsReceivable.getOutput();
					String recordsAccountsReceivable = outputAccountsReceivable.getString("result");
					if(recordsAccountsReceivable!=null){		
						accountsReceivableList = JsonUtils.toList(recordsAccountsReceivable, AccountsReceivableV4VO.class);
					}
					getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
				}
			}
 			
 		}else if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(2)){
 			//查询应付账款信息
 			AccountsPayableVO accountsPayableVO=new AccountsPayableVO();
 			accountsPayableVO.setLoanApplyId(Integer.parseInt(resultInfo.getId().toString()));
 			Map<String, Object> mapAccountsPayablee = new HashMap<String, Object>();
 			mapAccountsPayablee.put("parameter", accountsPayableVO);
 			mapAccountsPayablee.put("sign", "selectAccountsPayableByCondition");// 所调用的服务中的方法
			ResBody resultAccountsPayable = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapAccountsPayablee);
			List<AccountsPayableVO> accountsPayableList = new ArrayList<AccountsPayableVO>();
			if (resultAccountsPayable.getSys() != null) {
				String statusAccountsPayable = resultAccountsPayable.getSys().getStatus();
				if ("S".equals(statusAccountsPayable)) {// 交易成功
					JSONObject outputAccountsPayable = (JSONObject) resultAccountsPayable.getOutput();
					String recordsAccountsPayable = outputAccountsPayable.getString("result");
					if(recordsAccountsPayable!=null){
					accountsPayableList = JsonUtils.toList(recordsAccountsPayable, AccountsPayableVO.class);
					}
					getRequest().setAttribute("accountsPayableList", accountsPayableList);
				}
			}
 		}else if(null!=resultInfo.getAssetsType()&&resultInfo.getAssetsType().equals(3)){
 			//查询应付账款信息
 			BillVO billVO=new BillVO();
 			billVO.setLoanApplyId(Integer.parseInt(resultInfo.getId().toString()));
 			Map<String, Object> mapBill = new HashMap<String, Object>();
 			mapBill.put("parameter", billVO);
 			mapBill.put("sign", "selectBillByCondition");// 所调用的服务中的方法
			ResBody resultBill = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement",mapBill);
			List<BillVO> billList = new ArrayList<BillVO>();
			if (resultBill.getSys() != null) {
				String statusBill = resultBill.getSys().getStatus();
				if ("S".equals(statusBill)) {// 交易成功
					JSONObject outputBill = (JSONObject) resultBill.getOutput();
					String recordsBill = outputBill.getString("result");
					if(recordsBill!=null){
					billList = JsonUtils.toList(recordsBill, BillVO.class);
					}
					getRequest().setAttribute("billList", billList);
				}
			}
 		}

		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/loanappictionitem";

	}

	///	查询附件
	public AttachmentVo SelectAttachment(Integer id,String type,Long category){
		AttachmentVo attachment = new AttachmentVo();
		attachment.setType(type);
		attachment.setCategory(category);
		attachment.setResourceId(id);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		if(!"[]".equals(resultJson)&&resultJson!=null){
		
		attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		}
		if(attachmentList != null && attachmentList.size()>=0){
		attachment = attachmentList.get(0);
		}
		return attachment;
		
		
	}
	
	
	///
	
	
	/**
	 *  查询保理要素信息
	 *  type(资产类型); 1= 应收  2=应付  3=票据
	 *  loanApplyId 放款申请id
	 * @return
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
					getRequest().setAttribute("ReceivableElementsResult", receivableElementsResult);
				}else if(elementType.equalsIgnoreCase("2")) {
					AccountsPayableElementsVo payableElementsResult = JsonUtils.toObject(obj,AccountsPayableElementsVo.class);
					getRequest().setAttribute("payableElementsResult", payableElementsResult);
				}else if(elementType.equalsIgnoreCase("3")) {
					BillElementsVo billElementsResult = JsonUtils.toObject(obj,BillElementsVo.class);
					getRequest().setAttribute("billElementsResult", billElementsResult);
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
			attachmentVo.setResourceId(rid);
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
		}else if(type.equalsIgnoreCase("2")) {//跳转至应付账款保理要素页面
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus()));
			attachmentVo.setResourceId(rid);
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
		}else if(type.equalsIgnoreCase("3")) {
			attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus()));
			attachmentVo.setResourceId(rid);
			attachmentVo.setType(E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
			//查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
		}
		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
 		getRequest().setAttribute("list", attachmentList);
 		getRequest().setAttribute("type", elementType);
    	return "ybl4.0/admin/supplier/loanapplicationQuery/tab/captialhandle";
    }
    
    /**
     * 根据放款订单号查询资产转让函附件
     * @param orderNo 放款申请订单号
     * @return
     */
    @RequestMapping("/selectAssetAttach")
    public String selectTotalElemets(@RequestParam("loanApplyId") String loanApplyId) {
    	
 		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
		attachmentVo.setResourceId(Integer.valueOf(loanApplyId));
		attachmentVo.setType(E_V4_ATTACHMENT_TYPE.ASSET_TRANSFER_LETTER.getStatus());
 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
 		getRequest().setAttribute("attch", attachmentList.size() > 0 ? attachmentList.get(0) : null);
    	return "ybl4.0/admin/integratedQuery/tabLoan/assettransfer";
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
			if(records!=null && !"".equals(records)){
				factorLoanVo = JsonUtils.toObject(records,FactorLoanManagementLoanBatchSettlementVo.class);
				if(factorLoanVo!=null){
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
					String actualLoanDate= factorLoanVo.getActualLoanDate();
					if(actualLoanDate!=null && !"".equals(actualLoanDate)){
						String dateStr = sdf.format(Long.valueOf(actualLoanDate));
						factorLoanVo.setActualLoanDate(dateStr);
					}
				}
				getRequest().setAttribute("paymentBatch", factorLoanVo);
				getRequest().setAttribute("financingAmount", financingAmount);
			}else{
				getRequest().setAttribute("recordResult", "noRecords");
			}
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		if(factorLoanVo != null) {
 			String loanApplyId=factorLoanVo.getAttribute10();
 			if(loanApplyId!=null&&!"".equals(loanApplyId)){
 				AttachmentVo attachment = new AttachmentVo();
 	 	 		attachment.setType(E_V4_ATTACHMENT_TYPE.LOAN_SETTLEMENT_PAYMENT_VOUCHER.getStatus());
 	 			attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
 	 			attachment.setResourceId(Integer.valueOf(loanApplyId));
 	 			List<AttachmentVo> attachmentList = getFwAttachmentList(attachment);
 	 			if(null != attachmentList && attachmentList.size() > 0) {
 	 				getRequest().setAttribute("attachment", attachmentList.get(0));
 	 			}else {
 	 				getRequest().setAttribute("attachment", null);
 	 			}
 			}
 		}
 		//查询平台费用
 		if(factorLoanVo != null) {
 			Long businessId=factorLoanVo.getFunderBusinessId();
 	 		if(businessId!=null&&businessId>0){
 	 			Map<String,Object> configFree = new HashMap<String,Object>();
 	 			PlatformConfigFree configFreeEntity = new PlatformConfigFree();
 	 			configFreeEntity.setBusinessId(businessId);
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
 	 					BigDecimal plat_free = factorLoanVo.getActualLoanAmount().multiply(actual_rate).divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP); //平台实际费用
 	 					getRequest().setAttribute("plat_free", plat_free);//平台费用
 	 				}
 	 			}else{
 	 				super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
 	 				return null;
 	 			}
 	 		}
 		}
 		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/paymentInfo";
    }
    /**
     * 根据放款订单号查询结算放款信息(收款确认)
     */
    @RequestMapping("/selectSettleInfoByLoanOrderNoConfirm")
    public String selectSettleInfoByLoanOrderNoConfirm(@RequestParam("orderNo") String orderNo, @RequestParam("financingAmount") String financingAmount) {
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
			if(records!=null && !"".equals(records)){
				factorLoanVo = JsonUtils.toObject(records,FactorLoanManagementLoanBatchSettlementVo.class);
				if(factorLoanVo!=null){
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
					String actualLoanDate= factorLoanVo.getActualLoanDate();
					if(actualLoanDate!=null && !"".equals(actualLoanDate)){
						String dateStr = sdf.format(Long.valueOf(actualLoanDate));
						factorLoanVo.setActualLoanDate(dateStr);
					}
				}
				getRequest().setAttribute("paymentBatch", factorLoanVo);
				getRequest().setAttribute("financingAmount", financingAmount);
			}else{
				getRequest().setAttribute("recordResult", "noRecords");
			}
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		if(factorLoanVo != null) {
 			AttachmentVo attachment = new AttachmentVo();
 			String loanApplyId=factorLoanVo.getAttribute10();
 			if(loanApplyId!=null&&!"".equals(loanApplyId)){
 				attachment.setType(E_V4_ATTACHMENT_TYPE.LOAN_SETTLEMENT_PAYMENT_VOUCHER.getStatus());
 	 			attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.LENDING_CLEARING.getStatus()));
 				attachment.setResourceId(Integer.valueOf(loanApplyId));
 	 			List<AttachmentVo> attachmentList = getFwAttachmentList(attachment);
 	 			if(null != attachmentList && attachmentList.size() > 0) {
 	 				getRequest().setAttribute("attachment", attachmentList.get(0));
 	 			}else {
 	 				getRequest().setAttribute("attachment", null);
 	 			}
 			}
 			if(factorLoanVo.getId()!=null&&factorLoanVo.getId()>0){
 				attachment.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_RECEIPT_CONFIRMATION.getStatus());
 	 			attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.MANAGEMENT_MANAGEMENT_FINANCING.getStatus()));
 	 			attachment.setResourceId(Integer.valueOf(factorLoanVo.getId().toString()));
 	 			List<AttachmentVo> attachmenConfirmtList = getFwAttachmentList(attachment);
 	 			if(null != attachmenConfirmtList && attachmenConfirmtList.size() > 0) {
 	 				getRequest().setAttribute("attachmentConfirm", attachmenConfirmtList.get(0));
 	 			}else {
 	 				getRequest().setAttribute("attachmentConfirm", null);
 	 			}
 			}
 		}
 		//查询平台费用
 		if(factorLoanVo != null) {
 			Long businessId=factorLoanVo.getFunderBusinessId();
 	 		if(businessId!=null&&businessId>0){
 	 			Map<String,Object> configFree = new HashMap<String,Object>();
 	 			PlatformConfigFree configFreeEntity = new PlatformConfigFree();
 	 			configFreeEntity.setBusinessId(businessId);
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
 	 					BigDecimal plat_free = factorLoanVo.getActualLoanAmount().multiply(actual_rate).divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP); //平台实际费用
 	 					getRequest().setAttribute("plat_free", plat_free);//平台费用
 	 				}
 	 			}else{
 	 				super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
 	 				return null;
 	 			}
 	 		}
 		}
 		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/pre_settlement";
    }
    
    /**
     * 逾期费用=（逾期金额 * 逾期利率）/360 * 逾期天数
     * @return
     */
    private BigDecimal overFee(BigDecimal principal, BigDecimal overdays, BigDecimal rate) {
    	return principal.multiply(rate.divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP)).divide(new BigDecimal(360),4,BigDecimal.ROUND_HALF_UP).multiply(overdays);
    }

    /**
	 * 条件查询附件列表
	 */
    public List<AttachmentVo> getFwAttachmentList(AttachmentVo attachmentVo){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter",attachmentVo);
		map.put("sign","queryAttchmentByCondition");
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		List<AttachmentVo> attachmentList=new ArrayList<AttachmentVo>();
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
	 * 已还款定单信息
	 */
	@RequestMapping(value = "/repaymentInfo")
	public String RepaymentInfo( String orderNo){
		Map<String,Object> map = new HashMap<String,Object>();	
		map.put("order_no",orderNo);
		map.put("sign", "selectReypayMentByOrder");
		ResBody result = TradeInvokeUtils.invoke("RepayMentManagement", map);
		if(isSuccess(result)){
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("noPayMents");
				String hasJsonPage=output.getString("hasPayMents");
				List<RePaymentVo> hasPayMents= JSONObject.parseArray(hasJsonPage, RePaymentVo.class);
				List<RePaymentVo> jsonPages= JSONObject.parseArray(jsonPage, RePaymentVo.class);
				if(hasPayMents.size()>0){
					for (RePaymentVo rePaymentVo : hasPayMents) {
						AttachmentVo attachmentVo = new AttachmentVo();
						attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
						attachmentVo.setResourceId((rePaymentVo.getId_()));
						attachmentVo.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_PARTY_REPAYMENTS.getStatus());
				 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
				 		if(attachmentList.size() > 0){
				 			rePaymentVo.setAttribute1(String.valueOf(attachmentList.get(0).getId()));
				 		}
					}
				}
				BigDecimal totalMoney=new BigDecimal(0);
				if(hasPayMents!=null&&hasPayMents.size()>0){
					for (RePaymentVo rePaymentVo : hasPayMents) {
						BigDecimal repayment_principal=rePaymentVo.getRepayment_principal();//应还本金
						BigDecimal repayment_interest=rePaymentVo.getRepayment_interest();//应还利息
						BigDecimal overdue_days=new BigDecimal(rePaymentVo.getOverdue_days());//逾期天数
						BigDecimal overdue_interest_rate=rePaymentVo.getOverdue_interest_rate();//逾期利率
						totalMoney=totalMoney.add(repayment_principal).add(repayment_interest).add((repayment_principal.multiply(overdue_interest_rate.divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP))).divide(new BigDecimal(360),4,BigDecimal.ROUND_HALF_UP).multiply(overdue_days));
					}
				}
				if(jsonPages!=null&&jsonPages.size()>0){
					for (RePaymentVo rePaymentVoNo : jsonPages) {
						Date odate=new Date(rePaymentVoNo.getRepayment_date());
						long overdays = DateUtils.dayDiff(new Date(),odate);//逾期天数
						if(overdays < 0) {
							rePaymentVoNo.setOverdue_days(0);
						}else {
							if(rePaymentVoNo.getRepayment_status() != E_V4_PAY_STATE.REPLAYED_NOT_CONFIRM.getStatus()) {
								rePaymentVoNo.setOverdue_days((int)overdays);
							}
						}
						BigDecimal repayment_principal=rePaymentVoNo.getRepayment_principal();//应还本金
						BigDecimal repayment_interest=rePaymentVoNo.getRepayment_interest();//应还利息
						BigDecimal overdue_days=new BigDecimal(rePaymentVoNo.getOverdue_days());//逾期天数
						BigDecimal overdue_interest_rate=rePaymentVoNo.getOverdue_interest_rate();//逾期利率
						totalMoney=totalMoney.add(repayment_principal).add(repayment_interest).add((repayment_principal.multiply(overdue_interest_rate.divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP))).divide(new BigDecimal(360),4,BigDecimal.ROUND_HALF_UP).multiply(overdue_days));
					}
				}
				getRequest().setAttribute("totalMoney", totalMoney);
				getRequest().setAttribute("hasPayMents", hasPayMents);
				getRequest().setAttribute("jsonPages", jsonPages);
			}
		}
		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/paymentInfoAndConfirm";
		
	}
	
	/* *//**
     * 根据放款订单号查询还款计划(已确认还款)
     * @param loanProjectVO
     * @return
     *//*
    @RequestMapping("selectRepayPlanByLoanOrderNoAlreadyConfim")
    public String selectRepayPlanByLoanOrderNoAlreadyConfim(@RequestParam("orderNo") String orderNo) {
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_order_no", orderNo);
    	param.put("confirm_status", 2);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "selectRepayInfoByOrderNo");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		List<FactorCollectionManagementRepaymentPlanVo> list = null;
 		if(isSuccess(result)){
 			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if(records!=null){
				list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
				for (int i = 0; i < list.size(); i++) {
					BigDecimal principal = list.get(i).getRepaymentPrincipal(); //逾期金额
					BigDecimal overdays = new BigDecimal(list.get(i).getOverdueDays()); // 逾期天数
					BigDecimal rate = list.get(i).getOverdueInterestRate(); //逾期利率
					list.get(i).setAttribute6(overFee(principal,overdays,rate).toString());
					AttachmentVo attachmentVo = new AttachmentVo();
					attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
					attachmentVo.setResourceId(Integer.valueOf(list.get(i).getId().toString()));
					attachmentVo.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_PARTY_REPAYMENTS.getStatus());
			 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
			 		if(attachmentList.size() > 0){
			 			list.get(i).setAttribute1(String.valueOf(attachmentList.get(0).getId()));
			 		}
			 		attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
					attachmentVo.setResourceId(Integer.parseInt(list.get(i).getId().toString()));
					attachmentVo.setType(E_V4_ATTACHMENT_TYPE.SETTLEMENT_VOUCHER.getStatus());
			 		List<AttachmentVo> attachmentList2 = getFwAttachmentList(attachmentVo);
			 		if(attachmentList2.size() > 0){
			 			list.get(i).setAttribute2(String.valueOf(attachmentList2.get(0).getId()));
			 			list.get(i).setAttribute3((String.valueOf(attachmentList2.get(0).getRemark())));
			 		}
				}
			}
		}else{
			super.log.error("逾期项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}	
 		getRequest().setAttribute("list", list);
    	return "ybl4.0/admin/supplier/loanapplicationQuery/tab/pre_confirme_repayment";
    }*/
	 /**
     * 根据放款订单号查询还款计划(已确认还款)
     * @param loanProjectVO
     * @return
     */
    @RequestMapping("selectRepayPlanByLoanOrderNoAlreadyConfim")
    public String selectRepayPlanByLoanOrderNoAlreadyConfim(@RequestParam("orderNo") String orderNo) {
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_order_no", orderNo);
    	param.put("confirm_status", 2);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "selectRepayInfoByOrderNo");	
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);					
		List<FactorCollectionManagementRepaymentPlanVo> list = null;
 		if(isSuccess(result)){
 			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if(records!=null){
				list=JsonUtils.toList(records,FactorCollectionManagementRepaymentPlanVo.class);
				for (int i = 0; i < list.size(); i++) {
					BigDecimal principal = list.get(i).getRepaymentPrincipal(); //逾期金额
					BigDecimal overdays = new BigDecimal(list.get(i).getOverdueDays()); // 逾期天数
					BigDecimal rate = list.get(i).getOverdueInterestRate(); //逾期利率
					list.get(i).setAttribute6(overFee(principal,overdays,rate).toString());
					AttachmentVo attachmentVo = new AttachmentVo();
					attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
					attachmentVo.setResourceId(Integer.valueOf(list.get(i).getId().toString()));
					attachmentVo.setType(E_V4_ATTACHMENT_TYPE.FINANCIAL_PARTY_REPAYMENTS.getStatus());
			 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
			 		if(attachmentList.size() > 0){
			 			list.get(i).setAttribute1(String.valueOf(attachmentList.get(0).getId()));
			 		}
			 		attachmentVo.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.REPAYMENTS_CATEGORY.getStatus()));
					attachmentVo.setResourceId(Integer.valueOf(list.get(i).getId().toString()));
					attachmentVo.setType(E_V4_ATTACHMENT_TYPE.SETTLEMENT_VOUCHER.getStatus());
			 		List<AttachmentVo> attachmentList2 = getFwAttachmentList(attachmentVo);
			 		if(attachmentList2.size() > 0){
			 			list.get(i).setAttribute2(String.valueOf(attachmentList2.get(0).getId()));
			 			list.get(i).setAttribute3((String.valueOf(attachmentList2.get(0).getRemark())));
			 		}
				}
			}
		}else{
			super.log.error("逾期项目列表查询交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}	
 		getRequest().setAttribute("list", list);
 		return "ybl4.0/admin/supplier/loanapplicationQuery/tab/pre_confirme_repayment";    
 		}
    /**
	 * 根据放款申请id查询底层资产信息
	 * @param id 放款申请id
	 * @param assetsType 底层资产类型
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
					if(assetslist!=null&&assetslist.size()>0){
						Integer rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业businessId
						getRequest().setAttribute("rightBusinessId", rightBusinessId);
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
					if(assetslist!=null&&assetslist.size()>0){
						Integer rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业不businessId
						getRequest().setAttribute("rightBusinessId", rightBusinessId);
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
			map.put("sign", "queryBillById");//所调用的服务中的方法
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
					if(assetslist!=null&&assetslist.size()>0){
						Integer rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业不businessId
						getRequest().setAttribute("rightBusinessId", rightBusinessId);
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
				getRequest().setAttribute("list", Attachmentlist);
				super.log.error("查询风控措施附件服务返回成功，信息："+Attachmentlist);
			}else{
				super.log.error("查询风控措施附件服务返回失败，信息："+erortx);
			}
		}
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
	
	
	
	
	
	
}
