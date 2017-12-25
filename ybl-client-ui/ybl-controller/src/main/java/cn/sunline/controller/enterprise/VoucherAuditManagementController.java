package cn.sunline.controller.enterprise;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.FinanceLoanMaterialVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.framework.controller.vo.enterprise.FinanceApplyVoucherInfoVo;
import cn.sunline.framework.controller.vo.enterprise.VoucherAuditInfoVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 凭证审核管理
 * @author guang
 *
 */
@Controller
@RequestMapping({"/voucherAudit"})
public class VoucherAuditManagementController extends AbstractController {

	private static final long serialVersionUID = -97691234985560643L;

	@RequestMapping({ "/voucherConfirm" })
	public String voucherConfirm(String enterpriseName,
			String number, String status, PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,String> paramterMap = new HashMap<String,String>();
		paramterMap.put("enterprise_name", enterpriseName);
		paramterMap.put("number_", number);
		paramterMap.put("status_", status);
		paramterMap.put("enterprise_id", enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramterMap);
		map.put("page",pageVo);
		map.put("sign", "queryVoucherConfrimPage");
		ResBody result = TradeInvokeUtils.invoke("VoucherAuditManagement", map);
		List<VoucherAuditInfoVo> vouchers = null;
		List<FinanceApplyVoucherInfoVo> financeApplyVouchers = null;
		List<FinanceApplyVoucherInfoVo> loanSignVouchers = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				JSONObject resultJson = output.getJSONObject("result");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				vouchers = JsonUtils.toList(resultJson.getString("voucherAudit"), VoucherAuditInfoVo.class);
				financeApplyVouchers = JsonUtils.toList(resultJson.getString("financeApplyVouchers"), FinanceApplyVoucherInfoVo.class);
				loanSignVouchers = JsonUtils.toList(resultJson.getString("loanSignVouchers"), FinanceApplyVoucherInfoVo.class);
			}
		}
		if(vouchers != null && !vouchers.isEmpty()) {
			for (VoucherAuditInfoVo vaiv : vouchers) {
				List<FinanceApplyVoucherInfoVo> favis = new ArrayList<FinanceApplyVoucherInfoVo>();
				if( "loansign".equals(vaiv.getIsLoan()) ){
					favis = getVoucherList(loanSignVouchers, vaiv);
				} else {
					favis = getVoucherList(financeApplyVouchers, vaiv);
				}
				vaiv.setFaVouchers(favis);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("vouchers", vouchers);
		getRequest().setAttribute("enterpriseName", enterpriseName);
		getRequest().setAttribute("number", number);
		getRequest().setAttribute("status", status);
		return "ybl/admin/enterprise/voucherConfirm";
	}

	/**
	 * 融资申请、标的对应凭证列表关联
	 * @param vouchers 凭证列表
	 * @param vaiv 凭证审核信息
	 * @return
	 */
	private List<FinanceApplyVoucherInfoVo> getVoucherList(
			List<FinanceApplyVoucherInfoVo> vouchers,
			VoucherAuditInfoVo vaiv) {
		List<FinanceApplyVoucherInfoVo> favis = new ArrayList<FinanceApplyVoucherInfoVo>();
		if(null == vouchers || vouchers.isEmpty()) {
			return favis;
		}
		for (FinanceApplyVoucherInfoVo faviv : vouchers) {
			if(vaiv.getId() == faviv.getFinanceApplyId()) {
				favis.add(faviv);
			}
		}
		return favis;
	}
	
	@RequestMapping({ "/voucherConfirmSave" })
	@ResponseBody
	public String voucherConfirmSave(String financeApplyIds, String status, String comment) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,String> paramterMap = new HashMap<String,String>();
		paramterMap.put("attribute1_", financeApplyIds);
		paramterMap.put("status_", status);
		paramterMap.put("attribute2_", enterpriseId.toString());
		paramterMap.put("attribute3_", comment);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramterMap);
		map.put("sign", "voucherConfirmSave");
		ResBody result = TradeInvokeUtils.invoke("VoucherAuditManagement", map);
		String retStr = "F";
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				retStr = output.getString("result");
			}
		}
		return retStr;
	}
	
	@RequestMapping({ "/loanStatus" })
	public String loanStatus(String enterpriseName,
			String number, String status, PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,String> paramterMap = new HashMap<String,String>();
		paramterMap.put("enterprise_name", enterpriseName);
		paramterMap.put("number_", number);
		paramterMap.put("status_", status);
		paramterMap.put("enterprise_id", enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramterMap);
		map.put("page",pageVo);
		map.put("sign", "queryFinanceApplyPage");
		ResBody result = TradeInvokeUtils.invoke("VoucherAuditManagement", map);
		List<VoucherAuditInfoVo> vouchers = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				vouchers = JsonUtils.toList(records, VoucherAuditInfoVo.class);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("vouchers", vouchers);
		getRequest().setAttribute("enterpriseName", enterpriseName);
		getRequest().setAttribute("number", number);
		getRequest().setAttribute("status", status);
		return "ybl/admin/enterprise/loanStatus";
	}
	
	@RequestMapping({ "/loanSignDetails"})
	public String loanSignDetails(Long id) {
		return "/ybl/admin/supplier/subject/subjectDetails";
	}
	
	@RequestMapping({ "/financeApplyDetails"})
	public String financeApplyDetails(Long id) {
		return "/ybl/admin/supplier/subject/subjectDetails";
	}
	
	/**
	 * 查看凭证信息
	 */
	@RequestMapping({"/voucherDetails"})
	public String voucherDetails(String id){
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,Object> paramterMap = new HashMap<String,Object>();
		paramterMap.put("id_", Long.valueOf(id));
		paramterMap.put("enterprise_memeber_id", enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramterMap);
		map.put("sign", "selectVoucherDetails");
		ResBody result = TradeInvokeUtils.invoke("VoucherAuditManagement", map);
		List<AttachmentVo> attachmentList = new ArrayList<AttachmentVo>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				JSONObject resultJson = output.getJSONObject("result");
				VoucherVo voucher = JSONObject.parseObject(resultJson.getString("voucher"), VoucherVo.class);
				attachmentList = JsonUtils.toList(resultJson.getString("attachmentList"), AttachmentVo.class);
				getRequest().setAttribute("voucher",voucher);
				getRequest().setAttribute("attachmentList", attachmentList);
			}
		}
		return "ybl/admin/enterprise/voucherDetails";
	}
	
	@RequestMapping("/queryDetail")
	public String queryDetail(HttpServletRequest request, String id, String auditType) {

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

		}

		request.setAttribute("finaceBody", finaceBody);
		request.setAttribute("factorBody", factorBody);
		request.setAttribute("product", product);
		request.setAttribute("financeApply", financeApply);
		request.setAttribute("loanMaterialList", loanMaterialList);
		request.setAttribute("contractList", contractList);
		request.setAttribute("voucherList", voucherList);
		request.setAttribute("maxLoanMoney", getMaxLoanMoney(product, voucherList));
		request.setAttribute("auditType", auditType); // 审核类型
		request.setAttribute("ids", id); // 需要操作的id-审核部分需要
		
		return "ybl/admin/enterprise/loanDetails";
		

	}
	
	/**
	 * 计算最大可贷金额：最大可贷金额=凭证金额 * 融资比例
	 * 
	 * @param product
	 * @param voucherList
	 * @return
	 */
	private BigDecimal getMaxLoanMoney(ProductVo product, List<VoucherVo> voucherList) {
		BigDecimal maxLoanMoney  = new BigDecimal(0);
		if (voucherList == null || product == null || product.getFinance_ratio() == null) {
			return maxLoanMoney;
		}
		for (VoucherVo voucher : voucherList) {
			maxLoanMoney = maxLoanMoney.add(voucher.getAmount());
		}
		return maxLoanMoney.multiply(product.getFinance_ratio());
	}
}
