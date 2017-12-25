package com.bpm.framework.controller.financemanage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductAuditVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping("/FinanceManageController")
public class FinanceManageController extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3110015613414465812L;

	
	/**
	 * 查询审核的融资列表
	 * @param request
	 * @param user_name  客户名称
	 * @param status_    审核状态
	 * @param number_    融资编号
	 * @param pageVo     分页参数
	 * @return
	 */
	@RequestMapping("/queryList")
	public String queryList(HttpServletRequest request,String user_name,String status_ ,String number_, PageVo pageVo){
		
		Map<String,Object> input = new HashMap<String,Object>();
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("user_name", user_name);
		paramter.put("status_", status_);
		paramter.put("number_", number_);
		paramter.put("enterprise_id", 1); //TODO:获取当前用户信息-获取企业信息
		
		input.put("paramter", paramter);
		input.put("sign", "queryList");
		input.put("page", pageVo==null?new PageVo(1,10):pageVo);
		
		//调用服务
		ResBody resBody = TradeInvokeUtils.invoke("ProductAuditManagement", input);		
		
		List<ProductAuditVo> productAuditList =null;
		if(super.isSuccess(resBody)){
			JSONObject output = (JSONObject) resBody.getOutput();
			pageVo = JSONObject.parseObject(output.getString("page"), PageVo.class);
			productAuditList = JsonUtils.toList(output.getString("result"), ProductAuditVo.class);
		}
		
		request.setAttribute("page", pageVo);
		request.setAttribute("productAuditList", productAuditList);
		return "ybl/admin/factor/finance/financeAudit";
	}
	
	
	/**
	 * 审核操作
	 * @param request
	 * @param ids         融资申请id
	 * @param status_     状态
	 * @param operation_  操作
	 * @param comment_    评论
	 * @return
	 */
	@RequestMapping("/audit")
	public String audit(HttpServletRequest request,String ids,String status_,String operation_,String comment_){
		
		Map<String,Object> input = new HashMap<String,Object>();
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("ids", ids);
		paramter.put("status_", status_);
		paramter.put("operation_", operation_);
		paramter.put("comment_", comment_); 
		
		input.put("paramter", paramter);
		input.put("sign", "updateAudit");
		
		//调用服务
		ResBody result = TradeInvokeUtils.invoke("ProductAuditManagement", input);		
		
		if(super.isSuccess(result)){
			request.setAttribute("isSuccess", true);
		}
		
		request.setAttribute("isSuccess", false);
		return "ybl/admin/factor/risk/loanAudit";
	}
	
	
	
	
	/**
	 * 查询融资详情
	 * @param request
	 * @param ids         融资申请id
	 * @param status_     状态
	 * @param operation_  操作
	 * @param comment_    评论
	 * @return
	 */
	@RequestMapping("/queryDetail")
	public String queryDetail(HttpServletRequest request,Long id){
		
		Map<String,Object> input = new HashMap<String,Object>();
		Map<String,Object> paramter = new HashMap<String,Object>();
		if(id == null || id < 1 ){
			return "ybl/admin/factor/loan/loanDetails";  //错误信息
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "queryDetail");
		
		//调用服务
		ResBody resBody = TradeInvokeUtils.invoke("ProductAuditManagement", input);		
		
		EnterpriseVo finaceBody = null;
		EnterpriseVo factorBody = null;
		ProductVo productVo = null;
		FinanceApplyVo financeApply = null;
		List<AttachmentVo> loanMaterialList = null;
		List<AttachmentVo> contractList = null;
		List<VoucherVo> voucherList = null;
		
		if(super.isSuccess(resBody)){
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			//1 融资主体 
			finaceBody = JSONObject.parseObject(result.getString("finaceBody"), EnterpriseVo.class);
			//2 保理商主体
			factorBody =  JSONObject.parseObject(result.getString("factorBody"), EnterpriseVo.class);
			//3 产品详情
			productVo =  JSONObject.parseObject(result.getString("product"), ProductVo.class);
			//4 融资申请
			financeApply =  JSONObject.parseObject(result.getString("financeApply"), FinanceApplyVo.class);
			//5 贷款材料列表
			loanMaterialList =  JsonUtils.toList(result.getString("loanMaterialList"), AttachmentVo.class);
			//6 合同信息 
			if(StringUtils.isNotEmpty(result.getString("contractList"))){
				contractList =  JsonUtils.toList(result.getString("contractList"), AttachmentVo.class);
			}
			//7 融资凭证材料
			voucherList =  JsonUtils.toList(result.getString("voucherList"), VoucherVo.class);
		}
		
		request.setAttribute("finaceBody", finaceBody);
		request.setAttribute("factorBody", factorBody);
		request.setAttribute("productVo", productVo);
		request.setAttribute("financeApply", financeApply);
		request.setAttribute("loanMaterialList", loanMaterialList);
		request.setAttribute("contractList", contractList);
		request.setAttribute("voucherList", voucherList);
		return "ybl/admin/factor/loan/loanDetails";
		
	}
	
	
	
	/**
	 * 审核窗口-风控初审
	 * @param request
	 * @return
	 */
	@RequestMapping("/auditWindow")
	public String auditWindow(HttpServletRequest request){
		
		return "ybl/admin/factor/audit";
	}
	
	
}
