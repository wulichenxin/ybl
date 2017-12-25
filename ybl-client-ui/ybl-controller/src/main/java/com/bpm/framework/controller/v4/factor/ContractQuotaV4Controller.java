package com.bpm.framework.controller.v4.factor;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.number.NumberToCN;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.ContractCooperationElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.ContractTemplate;
import cn.sunline.framework.controller.vo.v4.factor.ContractV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorFinancingQueryVo;
import cn.sunline.framework.controller.vo.v4.factor.QuotaRecordVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_CONTRACT_COMPLATE;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_CONTRACT_STATUS;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_STATE;
import cn.sunline.framework.util.ParameterValidateUtil;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 合同额度控制器
 * @author WIN
 *
 */
@Controller
@RequestMapping({ "/contractQuotaV4Controller" })
public class ContractQuotaV4Controller extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8318170577647094716L;
	/**
	 * 查找合同额度记录和合同信息
	 * @param page
	 * @param contractId 合同ID
	 * 
	 * @return
	 */
	@RequestMapping({ "/quotaRecordList.htm" })
	public String queryQuotaRecordList(PageVo<?> page,String contractId,String status) {
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		
		QuotaRecordVo qr = new QuotaRecordVo();
		if (userVo != null && userVo.getId().longValue()>0){
			qr.setContractId(Long.valueOf(contractId));
			qr.setEnterpriseId(userVo.getEnterpriseId());
			JSONObject output = queryQuotaRecordByCondition(qr, page);
			if (output != null) {
				String pageJson = output.getString("page");
				String resultJson = output.getString("quotaRecords");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				List<QuotaRecordVo> quotaRecordList = JsonUtils.toList(resultJson, QuotaRecordVo.class);
				getRequest().setAttribute("quotaRecordList", quotaRecordList);
				getRequest().setAttribute("page", page);
			}
		}
		ContractQuotaV4Vo contractQuotaV4Vo = new ContractQuotaV4Vo();
		contractQuotaV4Vo.setId(Long.valueOf(contractId));
		JSONObject output = querycontractQuotaByCondition(contractQuotaV4Vo, new PageVo<>());
		List<ContractQuotaV4Vo> contractQuotaList = null;
		
		if (output != null) {
			String resultJson = output.getString("v4ContractQuotaInfo");
			contractQuotaList = JsonUtils.toList(resultJson, ContractQuotaV4Vo.class);
		}
		if(!contractQuotaList.isEmpty()) {
			getRequest().setAttribute("contractQuota", contractQuotaList.get(0));
		}
			getRequest().setAttribute("status", status);
		return "ybl4.0/admin/factor/contract/quotaRecordList";
	}
	/**
	 * 新增额度记录
	 * @param quotaRecord
	 * @return
	 */
	@RequestMapping({ "/insertQuotaRecord" })
	@ResponseBody
	@Log(operation=OperationType.Add, info="新增额度记录")
	public ControllerResponse insertQuotaRecord(QuotaRecordVo quotaRecord) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			String validate = ParameterValidateUtil.validate(quotaRecord);
			if (validate.length() > 0) {
				response.setInfo(validate);
				return response;
			}
			// (1)获取当前登录人的信息
			UserVo userVo = ControllerUtils.getCurrentUser();

			Map<String, Object> input = new HashMap<String, Object>();
			if (userVo != null && userVo.getId().longValue()>0){
				quotaRecord.setEnterpriseId(userVo.getEnterpriseId());
				ControllerUtils.setWho(quotaRecord);
				input.put("quotaRecord", quotaRecord);
				ResBody resBody = TradeInvokeUtils.invoke("V4InsertQuotaRecordManagement", input);
				if (super.isSuccess(resBody)) {
					JSONObject output = (JSONObject) resBody.getOutput();
					String records = output.getString("isadd");
					if (Boolean.parseBoolean(records)) {
						response.setInfo("保存成功");
						response.setResponseType(ResponseType.SUCCESS);
					}
				}
			}
		} catch (Exception e) {
			log.error("新增额度记录出现异常，信息：" + e.getMessage(),e);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
	/**
	 * 资金方合同额度信息
	 * @param contractQuotaV4Vo
	 * @param pageVo
	 * @param path   为1时跳池水位监控列表,否则跳额度调整列表
	 * @return
	 */
	@RequestMapping({ "/contractQuotaPage" })
	public String contractQuotaPage(ContractQuotaV4Vo contractQuotaV4Vo, PageVo<?> pageVo,String path) {
		
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		contractQuotaV4Vo.setFactor(enterpriseId);
		JSONObject output = querycontractQuotaByCondition(contractQuotaV4Vo,pageVo);
		List<ContractQuotaV4Vo> contractQuotaList = null;
		
		if (output != null) {
			String pageJson = output.getString("page");
			String resultJson = output.getString("v4ContractQuotaInfo");
			pageVo = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
			contractQuotaList = JsonUtils.toList(resultJson, ContractQuotaV4Vo.class);
			getRequest().setAttribute("contractQuotaList", contractQuotaList);
			getRequest().setAttribute("page", pageVo);
			getRequest().setAttribute("contractQuota", contractQuotaV4Vo);
		}
		//当path不等于1时跳转到额度调整页面,当path等于1时跳转到池水位监控
		if("1".equals(path) ) {
			return "ybl4.0/admin/factor/contract/contractQuotaList";
			
		}else {
			return "ybl4.0/admin/factor/contract/contractQuotaEditList";
		}
			
		
	}
	/**
	 * 根据主合同号查合同额度信息
	 * @param masterContractNo
	 * @return
	 */
	@RequestMapping({ "/contractQuotaPageByNo" })
	public String contractQuotaPageByContractNo(String masterContractNo) {
		
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		ContractQuotaV4Vo contractQuotaV4Vo = new ContractQuotaV4Vo();
		contractQuotaV4Vo.setMasterContractNo(masterContractNo);
		contractQuotaV4Vo.setFactor(enterpriseId);
		contractQuotaV4Vo.setEnable(1);
		JSONObject output = querycontractQuotaByCondition(contractQuotaV4Vo,new PageVo<>());
		List<ContractQuotaV4Vo> contractQuotaList = null;
		
		if (output != null) {
			String resultJson = output.getString("v4ContractQuotaInfo");
			contractQuotaList = JsonUtils.toList(resultJson, ContractQuotaV4Vo.class);
		}
		if(!contractQuotaList.isEmpty()) {
			getRequest().setAttribute("contractQuota", contractQuotaList.get(0));
		}
		return "ybl4.0/admin/factor/contract/setWaringQuota";
	}
	/**
	 * 设置预警额度
	 * @param quotaRecord
	 * @return
	 */
	@RequestMapping({ "/warningAmountEdit" })
	@ResponseBody
	@Log(operation=OperationType.Exe,info="设置合同预警额度")//V4queryContractManagement
	public ControllerResponse contractAddSave(ContractV4Vo contract) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			String validate = ParameterValidateUtil.validate(contract);
			if(validate.length()>0) {
				response.setInfo(validate);
				return response;
			}
			Map<String,Object> input = new HashMap<String,Object>();
			input.put("contract", contract);
			ResBody resBody = TradeInvokeUtils.invoke("V4queryContractManagement", input);
			ContractV4Vo ct = null;
			if (super.isSuccess(resBody)) {
				JSONObject output = (JSONObject) resBody.getOutput();
				String records = output.getString("contract");
				ct = JsonUtils.toObject(records, ContractV4Vo.class);
			}
			if(ct != null) {
				ct.setEarlyWarningAmount(contract.getEarlyWarningAmount());
			}
			ControllerUtils.setWho(ct);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("contract", ct);
			ResBody result = TradeInvokeUtils.invoke("V4UpdateContractManagement", map);
			if (super.isSuccess(result)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("isupdate");
				if (Boolean.parseBoolean(records)) {
					response.setInfo("修改额度成功");
					response.setResponseType(ResponseType.SUCCESS);
				}
			}
		} catch (Exception e) {
			log.error("设置预警额度出现异常，信息：" + e.getMessage(),e);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
	/**
	 * 生成主合同
	 * @param id 融资子订单id
	 * @param enterpriseid 融资方业务id
	 * @return
	 */
	@RequestMapping({ "/createContract" })
	public String createContract(Long id) {
		String templateContent = createContractContent(id);
		getRequest().setAttribute("contractContnent", templateContent);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		ResBody result = TradeInvokeUtils.invoke("V4QueryFinancingApplyIdManagement", map);
		if (super.isSuccess(result)) {
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("parentId");
			//getRequest().setAttribute("parentId", records);
			getRequest().setAttribute("id", records);
		}
		//getRequest().setAttribute("id", id);
		getRequest().setAttribute("childrenId", id);
		getRequest().setAttribute("statue", E_V4_FINANCING_STATE.SIGNED_CONTRACT.getStatus());
		getRequest().setAttribute("url", "/contractQuotaV4Controller/contractQuery/list.htm?type=1");
		return "ybl4.0/admin/factor/contract/contractSign";
	}
	/**
	 * 生成word
	 * @param id 融资子订单id
	 * @param response
	 * @throws IOException
	 */
	 @RequestMapping("/exportWord")
	 public void exportWord(Long id, HttpServletResponse response) throws IOException {
		 //获取合同内容
			String content = createContractContent(id);
			
			try {
				ByteArrayInputStream bais = new ByteArrayInputStream(content.getBytes("GBK"));    
				POIFSFileSystem poifs = new POIFSFileSystem();    
				DirectoryEntry directory = poifs.getRoot();    
				DocumentEntry documentEntry = directory.createDocument("WordDocument", bais);    
				//输出文件  
				String name="应收账款转让协议";  
				response.reset();  
				response.setHeader("Content-Disposition",  
				                     "attachment;filename=" +  
				                     new String( (name + ".doc").getBytes(),  
				                                "iso-8859-1"));  
				response.setContentType("application/msword");  
				OutputStream ostream = response.getOutputStream();
				poifs.writeFilesystem(ostream);    
				ostream.flush();  
				ostream.close();   
				bais.close();   
				
				
			} catch (IOException e) {
			
				e.printStackTrace();
			}
		
	 }
	/**
	 * 合同查询列表
	 * @param vo
	 * @param pageVo
	 * @param fstatus 融资状态
	 * @return
	 */
	@RequestMapping(value = "contractQuery/list.htm")
	public String contractList(FactorFinancingQueryVo vo,PageVo<?> pageVo,String type) {
	
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			vo.setBusinessId(user.getBusinessId());
		}
		if("1".equals(type)) { //type为1时查待签署合同状态下的融资子订单
			vo.setFinancingStatus(E_V4_FINANCING_STATE.SIGNED_CONTRACT.getStatus());	
		}else {//否则查融资完成的子订单
			vo.setFinancingStatus(E_V4_FINANCING_STATE.FINANCING_COMPLETED.getStatus());	
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("financingInfo",vo);
		map.put("page", pageVo);

		ResBody result = TradeInvokeUtils.invoke("V4QueryContractListManagement", map);
		PageVo page=null;
		List<FactorFinancingQueryVo> list = null;
		if (super.isSuccess(result)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("financingInfo");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list = JsonUtils.toList(records,FactorFinancingQueryVo.class);
				getRequest().setAttribute("list", list);
			
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("vo", vo);
		getRequest().setAttribute("type", type);
		return "ybl4.0/admin/factor/contract/contractList";
	}
	/**
	 * 签署合同
	 * @param id	融资子订单id
	 * @param attachment
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="contractsign")
	@Log(operation=OperationType.Add,info="签署合同")
	public ControllerResponse uploadConfirm(Long appid, AttachmentVo attachment){
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE,"签署合同失败");
		if(attachment.getOldName() == null) {//防止空上传
			responseResult.setInfo("请先选择附件再签署!");
			return responseResult;
		}
		UserVo user = ControllerUtils.getCurrentUser();
		//根据融资子订单id查融资子订单信息
		FactorFinancingQueryVo vo = getFactorFinancing(appid);
		//融资方企业id
		Long supplier = getBusinessApply(vo.getEnbusinessId()).getEnterpriseId();
		ContractV4Vo contract = new ContractV4Vo();
		contract.setMasterContractNo(vo.getOrderNo());
		//资金方企业id
		//插入合同信息
		contract.setFactor(user.getEnterpriseId());
		contract.setSupplier(supplier);
		contract.setCreditAmount(vo.getGiveQuota());
		contract.setStatus(E_V4_CONTRACT_STATUS.FACTOR_SIGN.getStatus());//资金方签署
		contract.setContent( createContractContent(appid));
		contract.setEarlyWarningAmount(new BigDecimal(0));
		ControllerUtils.setWho(contract);
		
		//插入附件的信息
		attachment.setType(E_V4_ATTACHMENT_TYPE.CONTRACT_ATTACHMENT.getStatus());
		attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.CONTRACT_CATEGORY.getStatus()));
		attachment.setEnterpriseId(user.getEnterpriseId());
		ControllerUtils.setWho(attachment);
		Map<String,Object> input = new HashMap<String,Object>();
		input.put("contract", contract);
		input.put("attachment", attachment);
		ResBody result = TradeInvokeUtils.invoke("V4InsertContractManagement", input);
		if(isSuccess(result)){
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("isadd");
			if (Boolean.parseBoolean(records)) {
					responseResult.setResponseType(ResponseType.SUCCESS, "合同签署成功");
			}
		}
		return responseResult;
	}
	/**
	 * 根据条件查合同额度信息
	 * @param parameters
	 * @param page
	 * @return
	 */
	private JSONObject querycontractQuotaByCondition(ContractQuotaV4Vo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("v4ContractQuotaInfo", parameters);
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("V4QueryContractQuotaManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回失败，信息：" + erortx);
				return null;
			}
		}
		return output;
	}
	/**
	 * 根据条件查找合同额度记录
	 * @param parameters
	 * @param page
	 * @return
	 */
	private JSONObject queryQuotaRecordByCondition(QuotaRecordVo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("quotaRecord", parameters);
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("V4QueryQuotaRecordManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询合同额度信息调用V4QueryQuotaRecordManagement交易返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询合同额度信息调用V4QueryQuotaRecordManagement交易返回失败，信息：" + erortx);
				return null;
			}
		}
		return output;
	}
	/**
	 * 根据融资子订单id获取合作要素信息
	 * @param ccev
	 * @return
	 */
	private ContractCooperationElementsVo queryCooperationElement(Long id) {
		ContractCooperationElementsVo ccev = new ContractCooperationElementsVo();
		ccev.setId(id);
		Map<String,Object> input = new HashMap<String,Object>();
		input.put("cooperationElements", ccev);
		ResBody resBody = TradeInvokeUtils.invoke("V4QueryContractCooperationManagement", input);
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("cooperationElements");
			ccev = JsonUtils.toObject(records,ContractCooperationElementsVo.class);
		}
		return ccev;
	}
	/**
	 * 根据业务id查基本信息
	 */
	private V4BusinessAuthVO getBusinessApply(Long businessid) {
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		vo.setBusinessId(businessid.intValue());
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyBusinessAuthInfoById", map);
		//融资申请订单申请人信息
		V4BusinessAuthVO businessAuth=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("businessApply");
				businessAuth=JsonUtils.toObject(records, V4BusinessAuthVO.class);
			}
		}
		return businessAuth;
	}
	/**
	 * 根据融资子订单id查融资子订单信息
	 */
	private FactorFinancingQueryVo getFactorFinancing(Long id){
		FactorFinancingQueryVo ffq = new FactorFinancingQueryVo();
		ffq.setId(id);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("financingInfo",ffq);
		map.put("page", new PageVo<>());

		ResBody result = TradeInvokeUtils.invoke("V4QueryContractListManagement", map);
		List<FactorFinancingQueryVo> list = null;
		if (super.isSuccess(result)) {
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("financingInfo");
			list = JsonUtils.toList(records,FactorFinancingQueryVo.class);
		}
		
		return list.get(0);
	}
	/**
	 * 根据子订单id生成合同内容信息
	 * @param id
	 * @return
	 */
	private String createContractContent(Long id) {
		UserVo user = ControllerUtils.getCurrentUser();
		//1.获取主合同模板内容
		ContractTemplate ct = new ContractTemplate();
		ct.setTemplateType(E_V4_CONTRACT_COMPLATE.TEMPLATE_MASTER.getStatus());
		//ct.setTemplateName(E_V4_CONTRACT_COMPLATE.TEMPLATE_MASTER.getName());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("param", JsonUtils.fromObject(ct));
		map.put("sign", "queryContractTemplateByCondition");
		ResBody resBody = TradeInvokeUtils.invoke("PlatformContractManagement", map);
		List<ContractTemplate> list = null;
		String templateContent = null;
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("result");
			list = JsonUtils.toList(records,ContractTemplate.class);
		}
		if(CollectionUtils.isNotEmpty(list)){
			templateContent = list.get(0).getTemplateContent();
		}
		//2.根据融资子订单id获取合作要素信息
		ContractCooperationElementsVo cce = new ContractCooperationElementsVo();
		cce.setId(id);
		cce = queryCooperationElement(id);
		//3根据业务id查基本信息
		
		Long  enbusinessid = getFactorFinancing(id).getEnbusinessId();
		//融资方信息
		V4BusinessAuthVO  enBusinessAuth = getBusinessApply(enbusinessid);
		//资金方信息
		V4BusinessAuthVO  faBusinessAuth = getBusinessApply(user.getBusinessId());
		//子订单号(合同号)
		templateContent = templateContent.replaceAll("#master_no#", cce.getOrderNo() == null ? "" : cce.getOrderNo());
		
		//没有签定地点信息
		templateContent = templateContent.replaceAll("#master_address#", "");
		//甲方信息
		templateContent = templateContent.replaceAll("#master_first_party_name#", enBusinessAuth.getEnterpriseName() == null ? "" : enBusinessAuth.getEnterpriseName());
		templateContent = templateContent.replaceAll("#master_first_party_address#", enBusinessAuth.getOfficeAddress() == null ? "" : enBusinessAuth.getOfficeAddress());
		//没有邮编信息
		templateContent = templateContent.replaceAll("#master_first_party_post#", "");
		templateContent = templateContent.replaceAll("#master_first_party_corporation#", enBusinessAuth.getLegalName() == null ? "" : enBusinessAuth.getLegalName());
		templateContent = templateContent.replaceAll("#master_first_party_contacts#", enBusinessAuth.getContacts() == null ? "" : enBusinessAuth.getContacts());
		templateContent = templateContent.replaceAll("#master_first_party_contacts_address#", enBusinessAuth.getOfficeAddress() == null ? "" : enBusinessAuth.getOfficeAddress());
		templateContent = templateContent.replaceAll("#master_first_party_telephone#", enBusinessAuth.getContactsPhone() == null ? "" : enBusinessAuth.getContactsPhone());
		//乙方信息
		templateContent = templateContent.replaceAll("#master_second_party_name#", faBusinessAuth.getEnterpriseName() == null ? "" : faBusinessAuth.getEnterpriseName());
		templateContent = templateContent.replaceAll("#master_second_party_address#", faBusinessAuth.getOfficeAddress() == null ? "" : faBusinessAuth.getOfficeAddress());
		//没有邮编信息
		templateContent = templateContent.replaceAll("#master_second_party_post#", "");
		templateContent = templateContent.replaceAll("#master_second_party_corporation#", faBusinessAuth.getLegalName() == null ? "" : faBusinessAuth.getLegalName());
		templateContent = templateContent.replaceAll("#master_second_party_contacts#", faBusinessAuth.getContacts() == null ? "" : faBusinessAuth.getContacts());
		templateContent = templateContent.replaceAll("#master_second_party_contacts_address#", faBusinessAuth.getOfficeAddress() == null ? "" : faBusinessAuth.getOfficeAddress());
		templateContent = templateContent.replaceAll("#master_second_party_telephone#", faBusinessAuth.getContactsPhone() == null ? "" : faBusinessAuth.getContactsPhone());
		//额度合同
		templateContent = templateContent.replaceAll("#master_finance_service_finnance_method#", cce.getContractType() == null ? " " : cce.getContractType().toString());
		if(cce.getContractType() != null  && 1 == cce.getContractType()) {
			templateContent = templateContent.replaceAll("#master_finance_amount#", cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN) == null ? "" : cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN).toString());
			//转大写
			templateContent = templateContent.replaceAll("#master_finance_amount_upper#",
					NumberToCN.number2CNMontrayUnit(cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN)) == null ? "" : NumberToCN.number2CNMontrayUnit(cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN)));
			templateContent = templateContent.replaceAll("#master_finance_quota#","");
			templateContent = templateContent.replaceAll("#master_finance_quota_upper#","");
		}else if(cce.getContractType() != null  && 2 == cce.getContractType() ) {
			templateContent = templateContent.replaceAll("#master_finance_quota#", cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN) == null ? "" : cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN).toString());
			templateContent = templateContent.replaceAll("#master_finance_quota_upper#",
					NumberToCN.number2CNMontrayUnit(cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN)) == null ? "" : NumberToCN.number2CNMontrayUnit(cce.getGiveQuota().setScale(2,BigDecimal.ROUND_HALF_DOWN)));
			templateContent = templateContent.replaceAll("#master_finance_amount#","");
			templateContent = templateContent.replaceAll("#master_finance_amount_upper#","");
		}else {
			templateContent = templateContent.replaceAll("#master_finance_quota#","");
			templateContent = templateContent.replaceAll("#master_finance_quota_upper#","");
			templateContent = templateContent.replaceAll("#master_finance_amount#","");
			templateContent = templateContent.replaceAll("#master_finance_amount_upper#","");
		}
		//保理服务费及收取方式
		if(cce.getFeeMode() != null && 1 == cce.getFeeMode()) {//融资利率
			templateContent = templateContent.replaceAll("#master_finance_service_pay_method#", cce.getFeeMode() == null ? " " : cce.getFeeMode().toString());
			templateContent = templateContent.replaceAll("#master_finance_rate_year#", cce.getFinancingRate() == null ? "" : cce.getFinancingRate().stripTrailingZeros().toString());
			templateContent = templateContent.replaceAll("#master_finance_service_fee#","");
			templateContent = templateContent.replaceAll("#master_finance_service_fee_upper#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money_upper#","");
		}else if(cce.getFeeMode() != null && 2 == cce.getFeeMode()) {//服务费
			templateContent = templateContent.replaceAll("#master_finance_service_pay_method#", cce.getFeeMode() == null ? " " : cce.getFeeMode().toString());
			templateContent = templateContent.replaceAll("#master_finance_rate_year#", "");
			templateContent = templateContent.replaceAll("#master_finance_service_fee#",cce.getServiceFee().setScale(2,BigDecimal.ROUND_HALF_DOWN) == null ? "" : cce.getServiceFee().setScale(2,BigDecimal.ROUND_HALF_DOWN).toString());
			templateContent = templateContent.replaceAll("#master_finance_service_fee_upper#",NumberToCN.number2CNMontrayUnit(cce.getServiceFee().setScale(2,BigDecimal.ROUND_HALF_DOWN)) == null ? "" : NumberToCN.number2CNMontrayUnit(cce.getServiceFee().setScale(2,BigDecimal.ROUND_HALF_DOWN)));
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money_upper#","");
		}else if(cce.getFeeMode() != null && 3 == cce.getFeeMode()) {//折价转让
			templateContent = templateContent.replaceAll("#master_finance_service_pay_method#", cce.getFeeMode() == null ? " " : cce.getFeeMode().toString());
			templateContent = templateContent.replaceAll("#master_finance_rate_year#", "");
			templateContent = templateContent.replaceAll("#master_finance_service_fee#","");
			templateContent = templateContent.replaceAll("#master_finance_service_fee_upper#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money#",cce.getTransferMoney().setScale(2,BigDecimal.ROUND_HALF_DOWN) == null ? "" : cce.getTransferMoney().setScale(2,BigDecimal.ROUND_HALF_DOWN).toString());
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money_upper#",NumberToCN.number2CNMontrayUnit(cce.getTransferMoney().setScale(2,BigDecimal.ROUND_HALF_DOWN)) == null ? "" : NumberToCN.number2CNMontrayUnit(cce.getTransferMoney().setScale(2,BigDecimal.ROUND_HALF_DOWN)));
		}else {
			templateContent = templateContent.replaceAll("#master_finance_service_pay_method#", "4");
			templateContent = templateContent.replaceAll("#master_finance_rate_year#", "");
			templateContent = templateContent.replaceAll("#master_finance_service_fee#","");
			templateContent = templateContent.replaceAll("#master_finance_service_fee_upper#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money#","");
			templateContent = templateContent.replaceAll("#master_finance_service_transfer_money_upper#","");
		}
		//银行信息
		templateContent = templateContent.replaceAll("#master_second_party_accounts_bank#", cce.getBank() == null ? "" : cce.getBank());
		templateContent = templateContent.replaceAll("#master_second_party_accounts_number#", cce.getBankAccount() == null ? "" : cce.getBankAccount());
		templateContent = templateContent.replaceAll("#master_second_party_account_name#", cce.getBankAccountName() == null ? "" : cce.getBankAccountName());
		//html拼接出word内容  
		String content="<html>";  
		//String temp = contractTemplateVO.getTemplateContent();
		//html拼接出word内容  
	    content+="<div style=\"text-align: left\"><span >"+templateContent+"<br /> <br /> </span></span></div>";  
	    //插入分页符  
	    content+="<span lang=EN-US style='font-size:12.0pt;line-height:150%;mso-fareast-font-family:宋体;mso-font-kerning:1.0pt;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'></span>";  
	    content+="<p class=MsoNormal style='line-height:150%'><span lang=EN-US style='font-size:12.0pt;line-height:150%'><o:p> </o:p></span></p>";  
	    content += "</html>";
		
		return content;
	}
}
