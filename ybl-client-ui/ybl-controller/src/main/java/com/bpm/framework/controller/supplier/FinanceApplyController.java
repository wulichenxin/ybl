package com.bpm.framework.controller.supplier;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplySupplierVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.FinanceApplyVoucherVo;
import cn.sunline.framework.controller.vo.FinanceLoanMaterialVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PlatformFeeVo;
import cn.sunline.framework.controller.vo.ProductAuditVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;
@Controller
@RequestMapping({"/financeApplyController"})
public class FinanceApplyController  extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5388625626092669120L;

	
	@RequestMapping({"/loanEdit"})
	public String loanEdit(FinanceApplySupplierVo applyVo,PageVo<?> page){
		
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		applyVo.setEnterpriseId(user.getEnterpriseId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", applyVo);
		map.put("page", page);
		map.put("sign", "queryFinanceApplyByCondition");
		ResBody result = TradeInvokeUtils.invoke("FinanceApplyManagement", map);
		List<FinanceApplySupplierVo> applyList = null;
		PageVo pagevo = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				pagevo =JsonUtils.toObject(jsonPage, PageVo.class);
				applyList = JsonUtils.toList(records, FinanceApplySupplierVo.class);
			}
		}
		
		//查询平台服务百分比
		Map<String,Object> condition = new HashMap<String,Object>();
		PlatformFeeVo feeVo = new PlatformFeeVo();
		feeVo.setCode("rateOfYear");
		condition.put("parameter", feeVo);
		condition.put("sign", "queryFeeItemByCode");
		ResBody resu = TradeInvokeUtils.invoke("PlatformFeeManagement", condition);
		if (result.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String records = output.getString("result");
				feeVo = JsonUtils.toObject(records, PlatformFeeVo.class);
			    getRequest().setAttribute("feeVo", feeVo);
			}
		}
		
		getRequest().setAttribute("page", pagevo);
		getRequest().setAttribute("applyList", applyList);
		getRequest().setAttribute("applyVo", applyVo);
		return "ybl/admin/supplier/finance/loanEdit";
	}
	
	
	/*
	 * 根据融资id查询融资凭证
	 */
	@RequestMapping({"/queryVouceherByApplyId"})
	@ResponseBody
	public ControllerResponse queryVouceherByApplyId(String applyId){
		
		ControllerResponse response  =new ControllerResponse(ResponseType.FAILURE);
		if(StringUtils.isEmpty(applyId)){
			response.setResponseType(ResponseType.FAILURE, "查询参数不符合规范！");
			return response;
		}
		FinanceApplyVoucherVo vo = new FinanceApplyVoucherVo();
		vo.setFinanceApplyId(Long.parseLong(applyId));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", vo);
		map.put("sign", "queryVouceherByApplyId");
		ResBody result = TradeInvokeUtils.invoke("FinanceApplyManagement", map);
		
		List<VoucherVo> voucherList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				voucherList = JsonUtils.toList(records, VoucherVo.class);
				response.setResponseType(ResponseType.SUCCESS);
				response.setObject(voucherList);
			}
		}
		
		return response;
	}
	
	
	//查看融资申请页面初始化
	/**
	 * 
	 * @param financeApplyId
	 * @return
	 */
	@RequestMapping({"/financeApplyInit"})
	public String financeApplyInit(String financeApplyId){
		if(StringUtils.isEmpty(financeApplyId)){
			super.log.error("查询参数不符合规范！");
		}
		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(financeApplyId)) {
			return "ybl/admin/factor/loan/loanDetails"; // 错误信息
		}
		paramter.put("id_", financeApplyId);
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

		getRequest().setAttribute("finaceBody", finaceBody);
		getRequest().setAttribute("factorBody", factorBody);
		getRequest().setAttribute("product", product);
		getRequest().setAttribute("financeApply", financeApply);
		getRequest().setAttribute("loanMaterialList", loanMaterialList);
		getRequest().setAttribute("contractList", contractList);
		getRequest().setAttribute("voucherList", voucherList);
		getRequest().setAttribute("maxLoanMoney", getMaxLoanMoney(financeApply, voucherList));
		
		return "ybl/admin/supplier/finance/financeApplyShow";
	}
	
	
	/**
	 * 计算最大可贷金额：最大可贷金额=凭证金额 * 融资比例
	 * 
	 * @param product
	 * @param voucherList
	 * @return
	 */
	private BigDecimal getMaxLoanMoney(FinanceApplyVo financeApply, List<VoucherVo> voucherList) {
		BigDecimal maxLoanMoney  = new BigDecimal(0);
		
		if (voucherList == null || financeApply == null || financeApply.getFinance_ratio() == null) {
			return maxLoanMoney;
		}
		for (VoucherVo voucher : voucherList) {
			maxLoanMoney = maxLoanMoney.add(voucher.getAmount());
		}
		
		return maxLoanMoney.multiply(financeApply.getFinance_ratio()).divide(new BigDecimal("100"), 2);
	}
	
}
