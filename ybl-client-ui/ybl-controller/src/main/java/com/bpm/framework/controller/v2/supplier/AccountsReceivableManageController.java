package com.bpm.framework.controller.v2.supplier;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.drools.compiler.lang.DRL5Expressions.operator_key_return;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductConfigArchiveMaterialVo;
import cn.sunline.framework.controller.vo.ProductConfigFeeVo;
import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.AccountVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableBillCommoditiesVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableBillVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableTransportationVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableVoucherCommoditiesVo;
import cn.sunline.framework.controller.vo.v2.AccountsReceivableVoucherVo;
import cn.sunline.framework.controller.vo.v2.FormBillVoucherObject;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/accountsReceivableManageController"})
public class AccountsReceivableManageController extends AbstractController {

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
    @RequestMapping({"/queryList.htm"})
    public String queryList(AccountVo account, PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
		account.setSupplier_enterprise_id(user.getEnterpriseId().toString());//供应商id
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
 		getRequest().setAttribute("account", account);
        return "ybl/v2/admin/supplier/accountEntry/accountEntryHome";
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
		paramter.put("status_", "effecting");//effecting 生效中的合同 
		paramter.put("supplier_enterprise_id", user.getEnterpriseId());
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
     * 查询合同详情
     * @param id   合同id
     * @return
     */
    @RequestMapping({"/queryContract"})
    @ResponseBody
    public ControllerResponse queryContract(String id){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(id.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.clinet.select.contract.number"));//参数错误
			return response;
		}
    	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id_", id);
		
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "queryContractDetail");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS);	
					response.setObject(result.getOutput());//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("修改产品服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					super.log.error("修改产品服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
		}
		return response;
    }
    
    
    /**
     * 查询账款详情
     * @param id
     * @return
     */
    @RequestMapping({"/queryaccountsReceivableDetail.htm"})
    public String queryaccountsReceivableDetail(String id, @RequestParam(required = false)String operator){
    	
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		
    	Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return "ybl/v2/admin/supplier/accountEntry/accountEntryAdd"; 
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
		getRequest().setAttribute("operator", operator);

    	return "ybl/v2/admin/supplier/accountEntry/accountEntryAdd";
    }
    
    /**
     * 保存账款信息并提交
     * @param accountsReceivableBill      		账款发票表 
     * @param accountsReceivable				账款表 
     * @param accountsReceivableVoucher			账款凭证表 
     * @param accountsReceivableTransportation	账款运输表 
     * @param formBillVoucherObject				表单列表对象(发票商品表、凭证商品表)
     * @param attachmentArray					添加时附件数组
     * @param deleteAttachmentIdArray			删除时、附件id数组
     * @param deleteBillCommoditiesIdArray		删除时、发票商品id数组
     * @param deleteVoucherCommoditiesIdArray	删除时、凭证商品id数组
     * @param accountsReceivableId				修改时、账款表id 
     * @param sta								标识、保存提交为1,保存草稿为0;
     * @return					
     */
    @RequestMapping({"/saveAll"})
    @ResponseBody
    @Log(operation = OperationType.Add,info = "保存账款信息")
    public ControllerResponse saveAll(AccountsReceivableBillVo accountsReceivableBill, AccountsReceivableVo accountsReceivable,
    		AccountsReceivableVoucherVo accountsReceivableVoucher, AccountsReceivableTransportationVo accountsReceivableTransportation,
    		FormBillVoucherObject formBillVoucherObject, String attachmentArray, String deleteAttachmentIdArray,
    		String deleteBillCommoditiesIdArray,String deleteVoucherCommoditiesIdArray,String accountsReceivableId,Integer sta){
    	
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	Map<String,Object> map = new HashMap<String,Object>();
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return response;
		}
    	//获取凭证商品集合
    	List<AccountsReceivableVoucherCommoditiesVo>  voucherCommoditiesList= formBillVoucherObject.getVoucherCommoditiesList();
    	map.put("voucherCommoditiesList", voucherCommoditiesList);
    	
    	//获取发票商品集合
    	List<AccountsReceivableBillCommoditiesVo> billCommoditiesList = formBillVoucherObject.getBillCommoditiesList();
    	map.put("billCommoditiesList", billCommoditiesList);
    	
    	//账款表信息
    	if(sta == 1){
    		accountsReceivable.setStatus("submit"); //提交状态   		
    	}else{
    		accountsReceivable.setStatus("draft");   // 草稿状态
    	}
    	ControllerUtils.setWho(accountsReceivable);
    	
    	
    	//账款附件信息
    	List<AttachmentVo> accountsReceivableAttachList = new ArrayList<AttachmentVo>();
    	//账款发票附件信息
    	List<AttachmentVo> accountsReceivableBillAttachList = new ArrayList<AttachmentVo>();
    	//账款凭证附件表信息
    	List<AttachmentVo> accountsReceivableVoucherAttachList = new ArrayList<AttachmentVo>();
    	//账款运输附件表信息
    	List<AttachmentVo> accountsReceivableTransportationAttachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] str = attachmentArray.split("#");
			for (int i = 0; i < str.length; i++) {
				//账款凭证附件表信息
				if(str[i].contains("addPicture1")){
					String[] picture1 = str[i].split("addPicture1");
					for (int j = 0; j < picture1.length; j++) {
						AttachmentVo accountsReceivableVoucherAttach = JsonUtils.toObject(picture1[j], AttachmentVo.class);
						ControllerUtils.setWho(accountsReceivableVoucherAttach);
						accountsReceivableVoucherAttach.setEnterpriseId(user.getEnterpriseId());
						accountsReceivableVoucherAttachList.add(accountsReceivableVoucherAttach);
						
					}
				}
				//账款发票附件信息
				if(str[i].contains("addPicture2")){
					String[] picture2 = str[i].split("addPicture2");
					for (int j = 0; j < picture2.length; j++) {
						AttachmentVo accountsReceivableBillAttach = JsonUtils.toObject(picture2[j], AttachmentVo.class);
						ControllerUtils.setWho(accountsReceivableBillAttach);
						accountsReceivableBillAttach.setEnterpriseId(user.getEnterpriseId());
						accountsReceivableBillAttachList.add(accountsReceivableBillAttach);
					}
				}
				//账款运输附件表信息
				if(str[i].contains("addPicture3")){
					String[] picture3 = str[i].split("addPicture3");
					for (int j = 0; j < picture3.length; j++) {
						AttachmentVo accountsReceivableTransportationAttach = JsonUtils.toObject(picture3[j], AttachmentVo.class);
						ControllerUtils.setWho(accountsReceivableTransportationAttach);
						accountsReceivableTransportationAttach.setEnterpriseId(user.getEnterpriseId());
						accountsReceivableTransportationAttachList.add(accountsReceivableTransportationAttach);
					}
				}
				//账款附件信息
				if(str[i].contains("addPicture4")){
					String[] picture4 = str[i].split("addPicture4");
					for (int j = 0; j < picture4.length; j++) {
						AttachmentVo accountsReceivableAttach = JsonUtils.toObject(picture4[j], AttachmentVo.class);
						ControllerUtils.setWho(accountsReceivableAttach);
						accountsReceivableAttach.setEnterpriseId(user.getEnterpriseId());
						accountsReceivableAttachList.add(accountsReceivableAttach);
					}
				}
			}
		}
		
		//账款附件信息
		map.put("accountsReceivableAttachList", accountsReceivableAttachList);
    	//账款发票附件信息
		map.put("accountsReceivableBillAttachList", accountsReceivableBillAttachList);
    	//账款凭证附件表信息
    	map.put("accountsReceivableVoucherAttachList", accountsReceivableVoucherAttachList);
    	//账款运输附件表信息
    	map.put("accountsReceivableTransportationAttachList", accountsReceivableTransportationAttachList);
    	
    	//账款凭证表
    	ControllerUtils.setWho(accountsReceivableVoucher);
    	map.put("accountsReceivableVoucher", accountsReceivableVoucher);
    	
    	//账款发票表
    	ControllerUtils.setWho(accountsReceivableBill);
    	map.put("accountsReceivableBill", accountsReceivableBill);
    	
    	//账款运输表
    	ControllerUtils.setWho(accountsReceivableTransportation);
    	map.put("accountsReceivableTransportation", accountsReceivableTransportation);
		
    	Map<String,Object> maps = new HashMap<String,Object>();
    	ResBody result = null;
    	//账款id为空则新增账款
		if(accountsReceivableId.isEmpty()){
			map.put("accountsReceivable", accountsReceivable);
			maps.put("paramter", map);
			maps.put("sign", "insertAll");
			result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);
			if(result!=null){
				if(result.getSys()!=null){
					String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();//错误信息
					if("S".equals(status)){//交易成功
						response.setResponseType(ResponseType.SUCCESS_DELETE);					
						response.setObject(result);//设置返回结果	
						response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
						super.log.info("新增账款服务调用信息："+erortx);
					}else{
						response.setResponseType(ResponseType.ERROR);
						response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
						super.log.error("新增账款服务调用信息："+erortx);
					}
				}
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.call.service.fail"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		}
		//修改账款
		else{
			accountsReceivable.setSupplierMemberId(user.getId());
			accountsReceivable.setEnterpriseId(user.getEnterpriseId());
			accountsReceivable.setId(Long.valueOf(accountsReceivableId));
			map.put("deleteVoucherCommoditiesIdArray",deleteVoucherCommoditiesIdArray);
			map.put("deleteBillCommoditiesIdArray",deleteBillCommoditiesIdArray);
			map.put("deleteAttachmentIdArray",deleteAttachmentIdArray);
			map.put("accountsReceivable", accountsReceivable);
			maps.put("paramter", map);
			maps.put("sign", "updateAll");
			result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);
			if(result!=null){
				if(result.getSys()!=null){
					String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();//错误信息
					if("S".equals(status)){//交易成功
						response.setResponseType(ResponseType.SUCCESS_DELETE);					
						response.setObject(result);//设置返回结果	
						response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
						super.log.info("新增账款服务调用信息："+erortx);
					}else{
						response.setResponseType(ResponseType.ERROR);
						response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
						super.log.error("新增账款服务调用信息："+erortx);
					}
				}
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.call.service.fail"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		}
		
		return response;
    }
    
}
