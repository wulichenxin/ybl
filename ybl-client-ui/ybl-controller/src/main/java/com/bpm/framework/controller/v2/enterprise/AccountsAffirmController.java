package com.bpm.framework.controller.v2.enterprise;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.sunline.framework.controller.vo.AttachmentVo;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.AccountVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v2.V2AuditRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/accountsAffirmController"})
public class AccountsAffirmController extends AbstractController {

    /**
     *
     */
    private static final long serialVersionUID = -2809460978768158852L;

  
    /**
     * 查询所有应收账款
     * @param enterprise_name   核心企业名称
     * @param number_			凭证号
     * @param status_			账款状态
     * @param min_invoice_date  签约时间
     * @param max_invoice_date  签约时间
     * @param pageVo			分页
     * @return
     */
    @RequestMapping({"/queryList"})
    public String queryList(AccountVo account, PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
		account.setAttribute9("submit");
		account.setAttribute3("hint");//标识、用于判断是否查询草稿状态的账款（!=null则不查）
		account.setEnterprise_id(user.getEnterpriseId().toString());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", account);
		maps.put("page", pageVo);
		maps.put("sign", "queryList");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("page", page);
 		getRequest().setAttribute("queryParam", account);
        return "ybl/v2/admin/enterprise/accountAffirm/accountAffirmHome";
    }
    /**
     * 查询合同列表
     * @return
     */
    @RequestMapping({"/toSaveaccountsReceivable"})
    @ResponseBody
    public List<Map> toSaveaccountsReceivable(){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return null;
		}
    	Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		
		paramter.put("supplier_enterprise_id", 1);
		input.put("paramter", paramter);
		input.put("sign", "queryContractInfoByEnterpriseId");
		// 调用服务
		List<Map> list= new ArrayList<>();
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", input);
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				list = JsonUtils.toList(records, Map.class);
			}else{
				return null;
			}			
		}
    	return list;
    	
    }
    
    
    /**
     * 查询账款详情
     * @param id
     * @return
     */
    @RequestMapping({"/queryaccountsReceivableAffirmDetail"})
    public String queryaccountsReceivableDetail(String id){
    	
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
    	Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return null; 
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "queryAccountsReceivableDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("V2AccountsReceivableManage", input);

		Map<String,Object> accountsReceivable = null;                                    //账款表
		List<Map> accountsReceivableAttaList = null;					                 //账款附件列表
		Map<String,Object> accountsReceivableVoucher = null;					         //账款凭证表
		List<Map> accountsReceivableVoucherAttaList = null;                              //账款凭证附件列表
		List<Map> accountsReceivableVoucherCommoditiesList = null;                       //账款凭证商品列表
		Map<String,Object> accountsReceivableBill = null;						         //账款发票表
		List<Map> accountsReceivableBillCommoditiesList = null;                          //账款发票商品列表
		List<Map> accountsReceivableBillAttaList = null;                                 //账款发票附件列表
		Map<String,Object> accountsReceivableTransportation = null;                      //账款运输表
		List<Map> accountsReceivableTransportationAttaList = null;                       //账款运输附件列表
		Map<String,Object> factorEnterprise = null;                                      //保理商
		Map<String,Object> coreEnterprise = null;										 //核心企业
		Map<String,Object> supplierEnterprise = null;									 //核心企业
		Map<String,Object> contract = null;	

		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			//  账款表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivable"))) {
				accountsReceivable = JsonUtils.toObject(result.getString("accountsReceivable"), Map.class);
			}
			
			//  账款附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableAttaList"))) {
				accountsReceivableAttaList = JsonUtils.toList(result.getString("accountsReceivableAttaList"), Map.class);
			}
			
			// 账款凭证表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucher"))) {
				accountsReceivableVoucher = JsonUtils.toObject(result.getString("accountsReceivableVoucher"), Map.class);
			}

			//  账款凭证附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucherAttaList"))) {
				accountsReceivableVoucherAttaList = JsonUtils.toList(result.getString("accountsReceivableVoucherAttaList"), Map.class);
			}
			
			//  账款凭证商品列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucherCommoditiesList"))) {
				accountsReceivableVoucherCommoditiesList = JsonUtils.toList(result.getString("accountsReceivableVoucherCommoditiesList"), Map.class);
			}
			
			//  账款发票表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBill"))) {
				accountsReceivableBill = JsonUtils.toObject(result.getString("accountsReceivableBill"), Map.class);
			}
			
			//账款发票商品列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBillCommoditiesList"))) {
				accountsReceivableBillCommoditiesList = JsonUtils.toList(result.getString("accountsReceivableBillCommoditiesList"), Map.class);
			}
			
			//账款发票附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBillAttaList"))) {
				accountsReceivableBillAttaList = JsonUtils.toList(result.getString("accountsReceivableBillAttaList"), Map.class);
			}
			
			//  账款运输表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableTransportation"))) {
				accountsReceivableTransportation = JsonUtils.toObject(result.getString("accountsReceivableTransportation"), Map.class);
			}
			
			//账款运输附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableTransportationAttaList"))) {
				accountsReceivableTransportationAttaList = JsonUtils.toList(result.getString("accountsReceivableTransportationAttaList"), Map.class);
			}
		    //  保理商
			if (StringUtils.isNotEmpty(result.getString("factorEnterprise"))) {
				factorEnterprise = JsonUtils.toObject(result.getString("factorEnterprise"), Map.class);
			}
			
			//  核心企业
			if (StringUtils.isNotEmpty(result.getString("coreEnterprise"))) {
				coreEnterprise = JsonUtils.toObject(result.getString("coreEnterprise"), Map.class);
			}
			
			//  供应商
			if (StringUtils.isNotEmpty(result.getString("supplierEnterprise"))) {
				supplierEnterprise = JsonUtils.toObject(result.getString("supplierEnterprise"), Map.class);
			}
			
			if (StringUtils.isNotEmpty(result.getString("contract"))) {
				contract = JsonUtils.toObject(result.getString("contract"), Map.class);
			}
			
		}

		
		getRequest().setAttribute("accountsReceivable",accountsReceivable);
		getRequest().setAttribute("accountsReceivableAttaList", accountsReceivableAttaList);
		getRequest().setAttribute("accountsReceivableVoucher", accountsReceivableVoucher);
		getRequest().setAttribute("accountsReceivableVoucherAttaList", accountsReceivableVoucherAttaList);
		getRequest().setAttribute("accountsReceivableVoucherCommoditiesList", accountsReceivableVoucherCommoditiesList);
		getRequest().setAttribute("accountsReceivableBill", accountsReceivableBill);
		getRequest().setAttribute("accountsReceivableBillCommoditiesList", accountsReceivableBillCommoditiesList);
		getRequest().setAttribute("accountsReceivableBillAttaList", accountsReceivableBillAttaList);
		getRequest().setAttribute("accountsReceivableTransportation", accountsReceivableTransportation);
		getRequest().setAttribute("accountsReceivableTransportationAttaList", accountsReceivableTransportationAttaList);
		getRequest().setAttribute("factorEnterprise", factorEnterprise);
		getRequest().setAttribute("coreEnterprise", coreEnterprise);
		getRequest().setAttribute("supplierEnterprise", supplierEnterprise);
		getRequest().setAttribute("contract", contract);
		getRequest().setAttribute("id", id);

    	return "ybl/v2/admin/enterprise/accountAffirm/accountAffirmDetail";
    }
    
    @RequestMapping(value="/audit")
	public String audit(String accountId){
		getRequest().setAttribute("accountId", accountId);
		return "ybl/v2/admin/enterprise/accountAffirm/audit";
	}
    /**
     * 核心企业账款确认
     * @param auditRecordVo   审核表实体
     * @param accountStatus	    账款状态
     * @return
     */
    @RequestMapping(value="/auditConfirm")
	@ResponseBody
	public ControllerResponse auditConfirm(V2AuditRecordVo auditRecordVo,String accountStatus){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() < 0 ){
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		// (1)判断对象是否为空
		if (auditRecordVo == null) {
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		// (2)判断必填参数是否填写
		if ((auditRecordVo.getBusinessId() > 0) && StringUtils.isNotEmpty(auditRecordVo.getType())
				&& StringUtils.isNotEmpty(auditRecordVo.getOperation())) {
		} else {
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		auditRecordVo.setEnterpriseId(user.getEnterpriseId());
		ControllerUtils.setWho(auditRecordVo);
		//调用服务
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("accountStatus", accountStatus);
		map.put("auditRecord", auditRecordVo);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", map);
		maps.put("sign", "accountsReceivableAudit");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);	
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				
			if("S".equals(status)){//交易成功
				response.setResponseType(ResponseType.SUCCESS_DELETE);					
				response.setObject(result);//设置返回结果	
				response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
			}
 		}
		return response;
	}
    
   
    /**
     * 保理商查询所有应收账款
     * @param account  账款复合实体
     * @param pageVo
     * @return
     */
    @RequestMapping(value={"/queryFactorList.htm","/queryAnalyzeList.htm","/queryRecheckList.htm","/queryBusinessList.htm"})
    public String queryFactorList(HttpServletRequest request,AccountVo account,PageVo pageVo){
    	String uri = request.getRequestURI();
    	String retUrl = null;
    	
    	if(uri.contains("queryFactorList")){
    		account.setAudit_status("first_trial");
			retUrl = "ybl/v2/admin/factor/accountAudit/accountAudit";//保理商初审列表
		}else if(uri.contains("queryAnalyzeList")){
			account.setAudit_status("analyze");
			retUrl = "ybl/v2/admin/factor/accountAudit/accountAnalyzeAudit";//保理商尽调分析审核列表
		}else if(uri.contains("queryRecheckList")){
			account.setAudit_status("recheck");
			retUrl = "ybl/v2/admin/factor/accountAudit/accountRecheckAudit";//保理商风控复审列表
		}else if(uri.contains("queryBusinessList")){
			account.setAudit_status("business");
			retUrl = "ybl/v2/admin/factor/accountAudit/accountBusinessAudit";//保理商业务办理审核列表
		}
    	
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		account.setAttribute3("hint");//标识、用于判断是否查询草稿状态的账款（!=null则不查）
		account.setFactor_enterprise_id(user.getEnterpriseId().toString());
		JSONObject output = queryAccountList(account, new PageVo<>());
		
		if (output != null) {
			String pageJson = output.getString("page");
			String resultJson = output.getString("result");
			PageVo page=(PageVo) JSONObject.parseObject(pageJson, PageVo.class);
			List<Map> list = JsonUtils.toList(resultJson, Map.class);
			getRequest().setAttribute("page", page);
			getRequest().setAttribute("list", list);
		}
		getRequest().setAttribute("account", account);
        return retUrl;
    }
    
    
    
    
    /**
     * 保理商查询待处理列表
     * 参数：account
     * @param audit_status: 
     * first_trial  //初审
     * analyze      //尽职调查
     * recheck      //复审
     * business     //业务办理
     * @param pageVo			分页
     * @return
     */
    public static List<Map> queryFactorToAuditList(AccountVo account,PageVo pageVo){
    	
    	UserVo user = ControllerUtils.getCurrentUser();
    	account.setAttribute3("hint");//标识、用于判断是否查询草稿状态的账款（!=null则不查）
		account.setFactor_enterprise_id(user.getEnterpriseId().toString());
		List<Map> list= new ArrayList<>();
		JSONObject output = queryAccountList(account, new PageVo<>());
		if (output != null) {
			String resultJson = output.getString("result");
			if(StringUtils.isNotEmpty(resultJson)){
				list = JsonUtils.toList(resultJson, Map.class);
			}
		}
        return list;
    }
    
    
    
    
    
    
    /**
	 * 查询账款列表（公用）
	 * 
	 * @param request
	 * @param parameters
	 *            
	 * @param page 分页对象           
	 * @return
	 */
	//@ResponseBody
	public static JSONObject queryAccountList(AccountVo parameters, PageVo<?> page) {
		
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryFactorList");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				//super.log.info("根据条件查询账款交易调用V2AccountsReceivableManage服务返回成功，信息：" + erortx);
				return output;
			} else {
				//super.log.error("根据条件查询账款交易调用V2AccountsReceivableManage服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}
	
	/**
     * 保理商审核账款
     * @param auditRecordVo   审核表实体
     * @param accountStatus	    账款状态
     * @return
     */
    @RequestMapping(value="/auditAccount")
	@ResponseBody
	@Log(operation = OperationType.Exe,info = "保理商审核账款")
	public ControllerResponse auditAccount(V2AuditRecordVo auditRecordVo, FormAttachmentListVo attachmentList){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() < 0 ){
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		// (1)判断对象是否为空
		if (auditRecordVo == null) {
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		// (2)判断必填参数是否填写
		if ((auditRecordVo.getBusinessId() > 0) && StringUtils.isNotEmpty(auditRecordVo.getType())
				&& StringUtils.isNotEmpty(auditRecordVo.getOperation())) {
		} else {
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		auditRecordVo.setEnterpriseId(user.getEnterpriseId());
		ControllerUtils.setWho(auditRecordVo);
		
		//获取附件表集合
		List<AttachmentVo> attachmentVoList = attachmentList.getAttachmentList();
		
		//调用服务
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("attachmentVoList", attachmentVoList);
		map.put("auditRecord", auditRecordVo);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", map);
		maps.put("sign", "accountsReceivableFactorAudit");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);	
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				
			if("S".equals(status)){//交易成功
				response.setResponseType(ResponseType.SUCCESS_DELETE);					
				response.setObject(result);//设置返回结果	
				response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
			}
 		}
		return response;
	}
    
    
    /**
     * 查询账款详情
     * @param id
     * @return
     */
    @RequestMapping(value={"queryAuditDetail.htm","queryauditAnalyzeDetail.htm","queryRecheckDetail.htm","queryBusinessDetail.htm"})
    public String queryaccountsFactorDetail(HttpServletRequest request, String id){
    	String uri = request.getRequestURI();
		String retUrl = "ybl/v2/admin/factor/accountAudit/audit";//保理商初审
		
		if(uri.contains("queryauditAnalyzeDetail")){
			retUrl = "ybl/v2/admin/factor/accountAudit/auditAnalyzeDetail";//尽调分析审核
		}
		if(uri.contains("queryRecheckDetail")){
			retUrl = "ybl/v2/admin/factor/accountAudit/auditRecheckDetail";//尽调分析复审
		}
		if(uri.contains("queryBusinessDetail")){
			retUrl = "ybl/v2/admin/factor/accountAudit/auditBusinessDetail";//业务审核
		}
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
    	Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return null; 
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "queryAccountsReceivableDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("V2AccountsReceivableManage", input);

		Map<String,Object> accountsReceivable = null;                                    //账款表
		List<Map> accountsReceivableAttaList = null;					                 //账款附件列表
		Map<String,Object> accountsReceivableVoucher = null;					         //账款凭证表
		List<Map> accountsReceivableVoucherAttaList = null;                              //账款凭证附件列表
		List<Map> accountsReceivableVoucherCommoditiesList = null;                       //账款凭证商品列表
		Map<String,Object> accountsReceivableBill = null;						         //账款发票表
		List<Map> accountsReceivableBillCommoditiesList = null;                          //账款发票商品列表
		List<Map> accountsReceivableBillAttaList = null;                                 //账款发票附件列表
		Map<String,Object> accountsReceivableTransportation = null;                      //账款运输表
		List<Map> accountsReceivableTransportationAttaList = null;                       //账款运输附件列表
		Map<String,Object> factorEnterprise = null;                                      //保理商
		Map<String,Object> coreEnterprise = null;										 //核心企业
		Map<String,Object> supplierEnterprise = null;									 //核心企业
		Map<String,Object> contract = null;												 //合同详情
		List<Map> auditRecordList = null;                                                //审核列表
		Map<String,Object> maxAuditRecord = null;										 //最后一条审核记录
		
		
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			//  账款表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivable"))) {
				accountsReceivable = JsonUtils.toObject(result.getString("accountsReceivable"), Map.class);
			}
			
			//  账款附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableAttaList"))) {
				accountsReceivableAttaList = JsonUtils.toList(result.getString("accountsReceivableAttaList"), Map.class);
			}
			
			// 账款凭证表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucher"))) {
				accountsReceivableVoucher = JsonUtils.toObject(result.getString("accountsReceivableVoucher"), Map.class);
			}

			//  账款凭证附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucherAttaList"))) {
				accountsReceivableVoucherAttaList = JsonUtils.toList(result.getString("accountsReceivableVoucherAttaList"), Map.class);
			}
			
			//  账款凭证商品列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableVoucherCommoditiesList"))) {
				accountsReceivableVoucherCommoditiesList = JsonUtils.toList(result.getString("accountsReceivableVoucherCommoditiesList"), Map.class);
			}
			
			//  账款发票表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBill"))) {
				accountsReceivableBill = JsonUtils.toObject(result.getString("accountsReceivableBill"), Map.class);
			}
			
			//账款发票商品列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBillCommoditiesList"))) {
				accountsReceivableBillCommoditiesList = JsonUtils.toList(result.getString("accountsReceivableBillCommoditiesList"), Map.class);
			}
			
			//账款发票附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableBillAttaList"))) {
				accountsReceivableBillAttaList = JsonUtils.toList(result.getString("accountsReceivableBillAttaList"), Map.class);
			}
			
			//  账款运输表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableTransportation"))) {
				accountsReceivableTransportation = JsonUtils.toObject(result.getString("accountsReceivableTransportation"), Map.class);
			}
			
			//账款运输附件列表
			if (StringUtils.isNotEmpty(result.getString("accountsReceivableTransportationAttaList"))) {
				accountsReceivableTransportationAttaList = JsonUtils.toList(result.getString("accountsReceivableTransportationAttaList"), Map.class);
			}
		    //  保理商
			if (StringUtils.isNotEmpty(result.getString("factorEnterprise"))) {
				factorEnterprise = JsonUtils.toObject(result.getString("factorEnterprise"), Map.class);
			}
			
			//  核心企业
			if (StringUtils.isNotEmpty(result.getString("coreEnterprise"))) {
				coreEnterprise = JsonUtils.toObject(result.getString("coreEnterprise"), Map.class);
			}
			
			//  供应商
			if (StringUtils.isNotEmpty(result.getString("supplierEnterprise"))) {
				supplierEnterprise = JsonUtils.toObject(result.getString("supplierEnterprise"), Map.class);
			}
			
			// 审核
			if (StringUtils.isNotEmpty(result.getString("contract"))) {
				contract = JsonUtils.toObject(result.getString("contract"), Map.class);
			}
			
			//  审核列表
			if (StringUtils.isNotEmpty(result.getString("auditRecordList"))) {
				auditRecordList = JsonUtils.toList(result.getString("auditRecordList"), Map.class);
			}
			
			// 最后一条审核记录
			if (StringUtils.isNotEmpty(result.getString("maxAuditRecord"))) {
				maxAuditRecord = JsonUtils.toObject(result.getString("maxAuditRecord"), Map.class);
			}
			
		}

		getRequest().setAttribute("accountsReceivable",accountsReceivable);
		getRequest().setAttribute("accountsReceivableAttaList", accountsReceivableAttaList);
		getRequest().setAttribute("accountsReceivableVoucher", accountsReceivableVoucher);
		getRequest().setAttribute("accountsReceivableVoucherAttaList", accountsReceivableVoucherAttaList);
		getRequest().setAttribute("accountsReceivableVoucherCommoditiesList", accountsReceivableVoucherCommoditiesList);
		getRequest().setAttribute("accountsReceivableBill", accountsReceivableBill);
		getRequest().setAttribute("accountsReceivableBillCommoditiesList", accountsReceivableBillCommoditiesList);
		getRequest().setAttribute("accountsReceivableBillAttaList", accountsReceivableBillAttaList);
		getRequest().setAttribute("accountsReceivableTransportation", accountsReceivableTransportation);
		getRequest().setAttribute("accountsReceivableTransportationAttaList", accountsReceivableTransportationAttaList);
		getRequest().setAttribute("factorEnterprise", factorEnterprise);
		getRequest().setAttribute("coreEnterprise", coreEnterprise);
		getRequest().setAttribute("supplierEnterprise", supplierEnterprise);
		getRequest().setAttribute("contract", contract);
		getRequest().setAttribute("id", id);
		getRequest().setAttribute("auditRecordList", auditRecordList);
		getRequest().setAttribute("maxAuditRecord", maxAuditRecord);

    	return retUrl;
    }
    
    /**
     * 查询账款详情
     * @param id
     * @return
     */
    @RequestMapping(value="/queryAuditDetail")
    public String queryAuditDetail(String id, String status){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
    	Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return null; 
		}
		if (! StringUtils.isNullOrBlank(status)){
			if(status.equals("first_trial")){//初审
				paramter.put("type_", "ybl_v2_accounts_receivable_first_trial");
			}else if(status.equals("analyze")){//尽调
				paramter.put("type_", "ybl_v2_accounts_receivable_analyze");
			}else if(status.equals("recheck")){//复审
				paramter.put("type_", "ybl_v2_accounts_receivable_recheck");
			}else if(status.equals("business")){//业务处理
				paramter.put("type_", "ybl_v2_accounts_receivable_business");
			}
		}else{
			return null;
		}
		paramter.put("business_id", id);
		input.put("paramter", paramter);
		input.put("sign", "queryAuditDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("V2AccountsReceivableManage", input);
		
		Map<String,Object> auditRecord = null;                                    
		List<Map> attachmentList = null;					                 
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			
			// 审核详情
			if (StringUtils.isNotEmpty(result.getString("auditRecord"))) {
				auditRecord = JsonUtils.toObject(result.getString("auditRecord"), Map.class);
			}
			
			//  审核附件
			if (StringUtils.isNotEmpty(result.getString("attachmentList"))) {
				attachmentList = JsonUtils.toList(result.getString("attachmentList"), Map.class);
			}
		}
		
		getRequest().setAttribute("auditRecord", auditRecord);
		getRequest().setAttribute("attachmentList", attachmentList);
		
    	return "ybl/v2/admin/factor/accountAudit/detail";
    }
    
}
