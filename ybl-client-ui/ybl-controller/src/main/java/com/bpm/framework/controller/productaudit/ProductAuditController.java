package com.bpm.framework.controller.productaudit;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.DisbursementLineRecordVo;
import cn.sunline.framework.controller.vo.DisbursementRecordVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.FinanceLoanMaterialVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductAuditVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping(value = { "/ProductAuditController" })
public class ProductAuditController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3110015613414465812L;

	/**
	 * 查询风控审核列表
	 * 
	 * @param request
	 * @param user_name
	 *            客户名称
	 * @param status_
	 *            审核状态
	 *            
	 * @param  状态id
	 * 
	 * @param number_
	 *            融资编号
	 * @param pageVo
	 *            分页参数
	 * @return
	 */
	@RequestMapping("/queryRiskList")
	public String queryRiskList(HttpServletRequest request, String user_name, String status_, String operation_,
			String number_, PageVo pageVo,String statusIndex) {

		status_ = StringUtils.isNullOrBlank(status_) ? Constant.FIRST_AUDITING : status_;

		queryList(request, user_name, status_, operation_, number_, pageVo,statusIndex);
		if (Constant.RE_AUDITING.equals(status_)) // 复审
		{
			request.setAttribute("audit_current_index", 1);  //回复到初审或者复审的tab标签状态
		} else {// 初审
			request.setAttribute("audit_current_index", 0);
		}

		return "ybl/admin/factor/risk/loanAudit";
	}

	/**
	 * 查询财务审核列表
	 * 
	 * @param request
	 * @param user_name
	 *            客户名称
	 * @param status_
	 *            审核状态
	 * @param number_
	 *            融资编号
	 * @param pageVo
	 *            分页参数
	 * @return
	 */
	@RequestMapping("/queryFinanceList")
	public String queryFinanceList(HttpServletRequest request, String user_name, String status_, String operation_,
			String number_, PageVo pageVo,String statusIndex) {

		status_ = Constant.FINANCE_AUDIT; // 财务审核
		queryList(request, user_name, status_, operation_, number_, pageVo,statusIndex);
		return "ybl/admin/factor/finance/financeAudit";
	}

	/**
	 * 查询出账审核列表
	 * 
	 * @param request
	 * @param user_name
	 *            客户名称
	 * @param status_
	 *            审核状态
	 * @param number_
	 *            融资编号
	 * @param pageVo
	 *            分页参数
	 * @return
	 */
	@RequestMapping("/queryPayList")
	public String queryPayList(HttpServletRequest request, String user_name, String status_, String operation_,
			String number_, PageVo pageVo,String statusIndex) {

		status_ = Constant.PAY_AUDIT; // 出账审核
		queryList(request, user_name, status_, operation_, number_, pageVo,statusIndex);
		
		return "ybl/admin/factor/finance/payManage";
	}

	/**
	 * 查询审核列表
	 * 
	 * @param request
	 * @param user_name
	 *            客户名称
	 * @param status_
	 *            审核状态
	 * @param number_
	 *            融资编号
	 * @param pageVo
	 *            分页参数
	 * @param statusIndex  当前查询的状态
	 * @return
	 */
	private void queryList(HttpServletRequest request, String user_name, String status_, String operation_,
			String number_, PageVo pageVo,String statusIndex) {
		// 将查询参数回写
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		
		paramter.put("enterprise_name", user_name);  //企业名称
		paramter.put("status_", StringUtils.isNullOrBlank(status_) ? Constant.FIRST_AUDITING : status_);
		paramter.put("operation_", operation_);
		paramter.put("number_", number_);
		paramter.put("enterprise_id", curUser.getEnterpriseId()); 

		input.put("paramter", paramter);
		input.put("sign", "queryList");
		pageVo = pageVo == null ? new PageVo(1, 10) : pageVo;
		input.put("page", pageVo);

		// 调用服务
		PageVo page = null;
		ResBody resBody = TradeInvokeUtils.invoke("ProductAuditManagement", input);

		List<ProductAuditVo> productAuditList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			page = JsonUtils.toObject(output.getString("page"), PageVo.class);
			productAuditList = JsonUtils.toList(output.getString("result"), ProductAuditVo.class);
		}

		request.setAttribute("user_name", user_name);
		request.setAttribute("number_", number_);
		request.setAttribute("statusIndex", StringUtils.isNullOrBlank(statusIndex)?"0":statusIndex);  //返回当前需要查询的状态
		request.setAttribute("page", page!=null?page:pageVo);
		request.setAttribute("productAuditList", productAuditList);
	}
	
	
	
	

	/**
	 * 审核操作
	 * 
	 * @param request
	 * @param ids
	 *            融资申请id
	 * @param status_
	 *            状态
	 * @param operation_
	 *            操作
	 * @param comment_
	 *            评论
	 * @param auditType
	 *            审核类型：0 风控审核 1 风控复审 2 财务审核 3出账管理
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/audit")
	@ResponseBody
	public ControllerResponse audit(HttpServletRequest request, HttpServletResponse respone, String auditType,
			String ids, String status_, String operation_, String comment_) throws IOException {
		ControllerResponse res = new ControllerResponse(ResponseType.FAILURE);

		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();

		String jumpUrl = "/ProductAuditController/queryRiskList";
		String oldStatus = status_;

		if (StringUtils.isNullOrBlank(ids)) {
			String info = I18NUtils.getText("sys.client.pleaseSelectAuditRecord");
			res.setInfo(info);
			res.setObject(jumpUrl);
			res.setResponseType(ResponseType.ERROR);
			return res;
		}

		// 初审
		if (Constant.FIRST_AUDITING.equals(status_)) { // 初审通过后，去到复审
			if (Constant.AUDIT_OPERATION_AREE.equals(operation_)) {
				status_ = Constant.RE_AUDITING;
				operation_ = Constant.AUDIT_OPERATION_WAITING;
			}
		}

		// 复审
		else if (Constant.RE_AUDITING.equals(status_)) {
			if (Constant.AUDIT_OPERATION_AREE.equals(operation_)) {// 通过后到财务审核
				status_ = Constant.FINANCE_AUDIT;
				operation_ = Constant.AUDIT_OPERATION_WAITING;
			} else if (Constant.AUDIT_OPERATION_REJECT.equals(operation_)) {// 驳回到初审中
				status_ = Constant.FIRST_AUDITING;
				operation_ = Constant.AUDIT_OPERATION_WAITING;
			}

		}
		
		// 财务审核
		else if (Constant.FINANCE_AUDIT.equals(status_)) {
			if (Constant.AUDIT_OPERATION_AREE.equals(operation_)) {// 通过后到出账管理
				status_ = Constant.PAY_AUDIT;
				operation_ = Constant.AUDIT_OPERATION_WAITING;;
			} else if (Constant.AUDIT_OPERATION_REJECT.equals(operation_)) {// 驳回到复审中
				status_ = Constant.RE_AUDITING;
				operation_ = Constant.AUDIT_OPERATION_WAITING;
			}
			jumpUrl = "/ProductAuditController/queryFinanceList";
		}

		// 出账管理
		else if (Constant.PAY_AUDIT.equals(status_)) {
			if (Constant.AUDIT_OPERATION_AREE.equals(operation_)) {// 通过后就结束
				status_ = Constant.END_AUDIT;
			} else if (Constant.AUDIT_OPERATION_REJECT.equals(operation_)) {// 驳回财务管理
				status_ = Constant.FINANCE_AUDIT;
				operation_ = Constant.AUDIT_OPERATION_WAITING;
			}
			jumpUrl = "/ProductAuditController/queryPayList";
		}

		jumpUrl += "?status_=" + oldStatus;// 将要查询的状态返回给前端
		
		UserVo user = ControllerUtils.getCurrentUser();

		paramter.put("ids", ids);
		paramter.put("status_", status_);
		paramter.put("operation_", operation_);
		paramter.put("comment_", comment_);
		paramter.put("last_update_by", user.getId());
		paramter.put("enterprise_id", user.getEnterpriseId());

		input.put("paramter", paramter);
		input.put("sign", "updateAudit");

		// 调用服务
		ResBody result = TradeInvokeUtils.invoke("ProductAuditManagement", input);

		if (super.isSuccess(result)) {
			res.setResponseType(ResponseType.SUCCESS);
			res.setObject(jumpUrl);
			res.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
		} else {
			res.setObject(jumpUrl);
			res.setResponseType(ResponseType.ERROR);
			res.setInfo(result.getSys().getErortx());
		}

		return res;
	}

	/**
	 * 查询融资详情
	 * 
	 * @param request
	 * @param auditType
	 *            审核类型：-2不通过 -1 审核完结 0 风控审核 1 风控复审 2 财务审核 3出账管理 4 还款管理 5 逾期管理 6 项目管理
	 * @param step :头部高亮的样式: 3 贷款管理 4 财务管理 5 风控管理
	 * @return
	 */
	@RequestMapping("/queryDetail")
	public String queryDetail(HttpServletRequest request, String id, String auditType,String step) {

		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return "ybl/admin/factor/loan/loanDetails"; // 错误信息
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "queryDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("ProductAuditManagement", input);

		EnterpriseVo finaceBody = new EnterpriseVo();
		EnterpriseVo factorBody = new EnterpriseVo();
		ProductVo product = new ProductVo();
		FinanceApplyVo financeApply = new FinanceApplyVo();
		List<FinanceLoanMaterialVo> loanMaterialList = new ArrayList<FinanceLoanMaterialVo>();
		
		
		
		List<AttachmentVo> contractList = new ArrayList<AttachmentVo>();
		List<VoucherVo> voucherList = null;
		
		List<Map> disbursementLineList = null;  //放款列表
		List<Map> repaymentList = null;  //放款列表
		

		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			// 1 融资主体
			if (StringUtils.isNotEmpty(result.getString("finaceBody"))) {
				finaceBody = JsonUtils.toObject(result.getString("finaceBody"), EnterpriseVo.class);
			}
			// 2 保理商主体
			if (StringUtils.isNotEmpty(result.getString("factorBody"))) {
				factorBody = JsonUtils.toObject(result.getString("factorBody"), EnterpriseVo.class);
			}

			// 3 产品详情
			if (StringUtils.isNotEmpty(result.getString("product"))) {
				product = JsonUtils.toObject(result.getString("product"), ProductVo.class);
			}

			// 4 融资申请
			if (StringUtils.isNotEmpty(result.getString("financeApply"))) {
				financeApply = JsonUtils.toObject(result.getString("financeApply"), FinanceApplyVo.class);
			}

			// 5 贷款材料列表
			if (StringUtils.isNotEmpty(result.getString("loanMaterialList"))) {
				loanMaterialList = JsonUtils.toList(result.getString("loanMaterialList"), FinanceLoanMaterialVo.class);
			}

			// 6 合同信息
			if (StringUtils.isNotEmpty(result.getString("contractList"))) {
				contractList = JsonUtils.toList(result.getString("contractList"), AttachmentVo.class);
			}

			// 7 融资凭证材料
			if (StringUtils.isNotEmpty(result.getString("voucherList"))) {
				voucherList = JsonUtils.toList(result.getString("voucherList"), VoucherVo.class);
			}
			
			// 8 放款列表
			if (StringUtils.isNotEmpty(result.getString("disbursementLineList"))) {
				disbursementLineList = JsonUtils.toList(result.getString("disbursementLineList"), Map.class);
			}
			
			// 9 还款列表
			if (StringUtils.isNotEmpty(result.getString("repaymentList"))) {
				repaymentList = JsonUtils.toList(result.getString("repaymentList"), Map.class);
			}
		}

		request.setAttribute("finaceBody", finaceBody);
		request.setAttribute("factorBody", factorBody);
		request.setAttribute("product", product);
		request.setAttribute("financeApply", financeApply);
		request.setAttribute("loanMaterialList", loanMaterialList);
		request.setAttribute("contractList", contractList);
		request.setAttribute("voucherList", voucherList);
		request.setAttribute("maxLoanMoney", getMaxLoanMoney(financeApply, voucherList));
		request.setAttribute("auditType", auditType); // 审核类型
		request.setAttribute("ids", id); // 需要操作的id-审核部分需要
		
		request.setAttribute("disbursementLineList", disbursementLineList);  //放款列表
		request.setAttribute("repaymentList", repaymentList);  //还款列表
		request.setAttribute("step", step);
		
		return "ybl/admin/factor/loan/loanDetails";
		

	}

	/**
	 * 计算最大可贷金额：最大可贷金额=凭证金额 * 融资比例
	 * 
	 * @param product
	 * @param voucherList
	 * @return
	 */
	private BigDecimal getMaxLoanMoney(FinanceApplyVo product, List<VoucherVo> voucherList) {
		BigDecimal maxLoanMoney  = new BigDecimal(0);
		BigDecimal ratio = product.getFinance_ratio();
		
		if (voucherList == null || product == null || ratio == null) {
			return maxLoanMoney;
		}
		for (VoucherVo voucher : voucherList) {
			maxLoanMoney = maxLoanMoney.add(voucher.getAmount());
		}
		
		maxLoanMoney = maxLoanMoney.multiply(ratio);

		maxLoanMoney = maxLoanMoney.divide(new BigDecimal(100), 4, BigDecimal.ROUND_DOWN);
		
		return maxLoanMoney;
	}

	
	/**
	 * 审核窗口
	 * 
	 * @param request
	 * @param auditType
	 *            ; 审核类型：0 风控审核 1 风控复审 2 财务审核 3出账管理
	 * @return
	 */
	@RequestMapping("/auditWindow")
	public String auditWindow(HttpServletRequest request, String auditType, String ids) {
		String auditTypeHtml = ""; // 提交类型：0 风控审核 1 风控复审 2 财务审核 3出账管理
		String operationHtml = ""; // 操作类型 通过、不通过、驳回（初审不需要驳回）

		operationHtml = "<option value='agree'>" + I18NUtils.getText("sys.client.agree") + "</option> " // 通过
				+ "<option value='disagree'>" + I18NUtils.getText("sys.client.disagree") + "</option>"; // 不通过

		if ("0".equals(auditType)) {// 初审
			auditTypeHtml = "<option value='1000_auditing' >" + I18NUtils.getText("sys.client.riskFirstAudit")
					+ "</option>";
		} else if ("1".equals(auditType)) {// 复审
			auditTypeHtml = "<option value='1020_reauditing' >" + I18NUtils.getText("sys.client.riskReAudit")
					+ "</option>";
		} else if ("2".equals(auditType)) { // 财务审核
			auditTypeHtml = "<option value='1030_finance_audit' >" + I18NUtils.getText("sys.client.financeAudit")
					+ "</option>";
		} else if ("3".equals(auditType)) {// 出账管理
			auditTypeHtml = "<option value='1040_pay_audit' >" + I18NUtils.getText("sys.client.payManagement")
					+ "</option>";
			
			operationHtml = "<option value='agree'>" + I18NUtils.getText("sys.client.pay") + "</option> "; // 支付
		}
		
		if (!"0".equals(auditType)) { // 如果不是初审，就需要驳回状态
			operationHtml += "<option value='reject'>" + I18NUtils.getText("sys.client.rejected") + "</option>"; // 驳回
		}

		request.setAttribute("auditTypeHtml", auditTypeHtml);
		request.setAttribute("operationHtml", operationHtml);
		request.setAttribute("ids", ids);
		request.setAttribute("auditType", auditType);
		return "ybl/admin/factor/audit";
	}
	
	
	
	
	
	
	/**
	 * 查询支付详情
	 * 
	 * @param request
	 * @param id 融资申请id
	 * @return
	 */
	@RequestMapping("/getPayDetail")
	public String getPayDetail(HttpServletRequest request, String id) {

		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return "ybl/admin/factor/loan/getPayDetail"; 
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "getPayDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("ProductAuditManagement", input);

		EnterpriseVo enterprise = new EnterpriseVo();

		FinanceApplyVo financeApply = new FinanceApplyVo();

		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			// 1 融资主体
			if (StringUtils.isNotEmpty(result.getString("enterprise"))) {
				enterprise = JsonUtils.toObject(result.getString("enterprise"), EnterpriseVo.class);
			}

			// 2 融资申请
			if (StringUtils.isNotEmpty(result.getString("financeApply"))) {
				financeApply = JsonUtils.toObject(result.getString("financeApply"), FinanceApplyVo.class);
			}

		}

		request.setAttribute("enterprise", enterprise);
		request.setAttribute("financeApply", financeApply);
		request.setAttribute("now", new Date());
		return "ybl/admin/factor/loan/getPayDetail";

	}
	
	
	//保存放款记录
	@RequestMapping({ "/saveDisbursement" })
	@ResponseBody
	public ControllerResponse saveDisbursement(DisbursementRecordVo disbursementRecordVo,DisbursementLineRecordVo disbursementLineRecordVo,String attachmentArray ) {
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> condition = new HashMap<String, Object>();
		 
		ControllerUtils.setWho(disbursementRecordVo);
		ControllerUtils.setWho(disbursementLineRecordVo);
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			response.setResponseType(ResponseType.FAILURE, "请先登录！");
			return response;
		}
		
		disbursementRecordVo.setEnterpriseId(user.getEnterpriseId());
		disbursementLineRecordVo.setEnterpriseId(user.getEnterpriseId());
		//放款主表需要计算：
		//1) 结算金额
		//2) 贷款费用
		//3) 服务费用
		//4) 放款金额
		//5）融资申请id
		
		//放款行表需要写入：
		//1）支付时间
		//2）备注
		//3）本次付款金额
		
		//附件信息
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] str = attachmentArray.split("#");
			for (int i = 0; i < str.length; i++) {
				AttachmentVo attache = JsonUtils.toObject(str[i], AttachmentVo.class);
				ControllerUtils.setWho(attache);
				attache.setEnterpriseId(user.getEnterpriseId());
				attachList.add(attache);
			}
		}
		
		condition.put("disbursementRecord", disbursementRecordVo);       //主表
		condition.put("disbursementLineRecord", disbursementLineRecordVo);//行表
		condition.put("attachList", attachList);  //附件
		
		Map<String, Object> req = new HashMap<String, Object>();
		req.put("paramter", condition);
		req.put("sign", "saveDisbursement");
		ResBody result = TradeInvokeUtils.invoke("ProductAuditManagement", req);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if ("S".equals(status) && Boolean.parseBoolean(records)) {
				response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
				response.setResponseType(ResponseType.SUCCESS);
			}else{
				response.setResponseType(ResponseType.FAILURE);
			}
		}

		return response;
	}
	
	
	
	
	
	
	
	
	


}
