package com.bpm.framework.controller.v2.factor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.ContractEnterpriseVo;
import cn.sunline.framework.controller.vo.v2.ContractQuotaVo;
import cn.sunline.framework.controller.vo.v2.ContractVo;
import cn.sunline.framework.controller.vo.v2.FundSourceVo;
import cn.sunline.framework.controller.vo.v2.QuotaRecordVo;
import cn.sunline.framework.controller.vo.v2.ReceivableVo;
import cn.sunline.framework.controller.vo.v2.V2EnterpriseVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 合同管理管理
 * @author guang
 *
 */
@Controller
@RequestMapping({"/contract"})
public class ContractManagementController extends AbstractController {

	private static final long serialVersionUID = -97691234985560643L;

	/**
	 * 保理商合同分页查询
	 * @param contract
	 * @param pageVo
	 * @return
	 */
	@RequestMapping({ "/contractPage" })
	public String contractPage(ContractVo contract, PageVo<?> pageVo) {
		queryContractPage(contract, pageVo);
		return "ybl/v2/admin/factor/contract/contractList";
	}
	
	/**
	 * 核心企业合同分页查询
	 * @param contract
	 * @param pageVo
	 * @return
	 */
	@RequestMapping({ "/coreContractPage" })
	public String coreContractPage(ContractVo contract, PageVo<?> pageVo) {
		queryContractPage(contract, pageVo);
		return "ybl/v2/admin/factor/contract/coreContractList";
	}
	
	/**
	 * 供应商合同分页擦好像
	 * @param contract
	 * @param pageVo
	 * @return
	 */
	@RequestMapping({ "/supplierContractPage" })
	public String sipplierContractPage(ContractVo contract, PageVo<?> pageVo) {
		queryContractPage(contract, pageVo);
		return "ybl/v2/admin/factor/contract/supplierContractList";
	}

	/**
	 * 分页查询合同信息
	 * @param contract
	 * @param pageVo
	 */
	private void queryContractPage(ContractVo contract, PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		contract.setEnterpriseId(enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", contract);
		map.put("page",pageVo);
		map.put("sign", "queryContractPage");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		List<ContractVo> contractList = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String resultStr = output.getString("result");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				contractList = JsonUtils.toList(resultStr, ContractVo.class);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("contractList", contractList);
		getRequest().setAttribute("contract", contract);
	}

	@RequestMapping({ "/contractEdit" })
	public String contractAdd(Long contractId) {
		if(null != contractId && contractId.intValue() > 0){
			queryContractInfoById(contractId,false);
		}
		return "ybl/v2/admin/factor/contract/contractAdd";
	}
	
	@RequestMapping({ "/contractDetails" })
	public String contractDetails(Long contractId) {
		if(null != contractId && contractId.intValue() > 0){
			queryContractInfoById(contractId,false);
		}
		return "ybl/v2/admin/factor/contract/contractDetails";
	}

	private void queryContractInfoById(Long contractId, boolean isQueryQuotaRecord) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("enterprise_id", enterpriseId);
		paramter.put("id_", contractId);
		if(isQueryQuotaRecord){
			paramter.put("attribute1_", "yes");
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("sign", "queryContractById");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		if(null == result){
			return;
		}
		if(null == result.getSys()){
			return;
		}
		String retStatus = result.getSys().getStatus();
		if (!"S".equals(retStatus)) {
			return;
		}
		JSONObject output = (JSONObject) result.getOutput();
		JSONObject retJson = output.getJSONObject("result");
		ContractVo contract = JSONObject.parseObject(retJson.getString("contract"), ContractVo.class);
		ContractEnterpriseVo enterprise = JSONObject.parseObject(retJson.getString("enterprise"), ContractEnterpriseVo.class);
		ContractEnterpriseVo coreEnterprise = JSONObject.parseObject(retJson.getString("coreEnterprise"), ContractEnterpriseVo.class);
		ContractEnterpriseVo supplierEnterprise = JSONObject.parseObject(retJson.getString("supplierEnterprise"), ContractEnterpriseVo.class);
		FundSourceVo fundSource = JSONObject.parseObject(retJson.getString("fundsSource"), FundSourceVo.class);
		getRequest().setAttribute("contract", contract);
		getRequest().setAttribute("fundSource", fundSource);
		getRequest().setAttribute("enterprise", enterprise);
		getRequest().setAttribute("coreEnterprise", coreEnterprise);
		getRequest().setAttribute("supplierEnterprise", supplierEnterprise);
		String userType = Constant.USER_FACTOR;
		if(enterpriseId.intValue() == coreEnterprise.getId().intValue()) {
			userType = Constant.USER_CORE_ENTERPRISE;
		} else if (enterpriseId.intValue() == supplierEnterprise.getId().intValue()) {
			userType = Constant.USER_SUPPLIER;
		}
		getRequest().setAttribute("userType", userType);
		if(isQueryQuotaRecord){
			List<QuotaRecordVo> depositList = JsonUtils.toList(retJson.getString("depositList"), QuotaRecordVo.class);
			List<QuotaRecordVo> quotaList = JsonUtils.toList(retJson.getString("quotaList"), QuotaRecordVo.class);
			List<QuotaRecordVo> creditList = JsonUtils.toList(retJson.getString("creditList"), QuotaRecordVo.class);
			getRequest().setAttribute("depositList", depositList);
			getRequest().setAttribute("quotaList", quotaList);
			getRequest().setAttribute("creditList", creditList);
		}
	}
	
	/**
	 * 合同新增或修改
	 * @param contract
	 * @return
	 */
	@RequestMapping({ "/contractAddSave" })
	@ResponseBody
	@Log(operation=OperationType.Exe,info="新增或修改合同")
	public ControllerResponse contractAddSave(ContractVo contract) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		ControllerUtils.setWho(contract);
		contract.setEnterpriseId(enterpriseId.toString());
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
//		if(isExistContractInfo(contract)) {
//			response.setInfo("操作失败，三方合同已存在");
//			return response;
//		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", contract);
		String sign =  "addContract";
		if(null != contract.getId() && contract.getId().intValue() > 0) {
			sign = "updateContract";
		}
		map.put("sign", sign);
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				response.setResponseType(ResponseType.SUCCESS,ResponseType.SUCCESS.getInfo());
			}
		}
		return response;
	}
	
	/**
	 * 合同终止保持
	 * @param contract
	 * @return
	 */
	@RequestMapping({ "/contractEndSave" })
	@ResponseBody
	@Log(operation=OperationType.Exe,info="终止合同")
	public ControllerResponse contractEndSave(Long contractId) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if(null != contractId && contractId.intValue() < 1) {
			return response;
		}
		Map<String,Object> parameter = new HashMap<String,Object>();
		parameter.put("id_", contractId);
		parameter.put("enterprise_id", enterpriseId);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", parameter);
		map.put("sign", "endContract");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				response.setResponseType(ResponseType.SUCCESS,ResponseType.SUCCESS.getInfo());
			}
		}
		return response;
	}

	/**
	 * 根据核心企业、保理商、供应商三者企业id查询合同信息
	 * @param contract 新增修改的合同信息
	 * @return true：存在，false：不存在
	 */
	private boolean isExistContractInfo(ContractVo contract) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", contract);
		map.put("sign", "queryContractInfoByEnterpriseId");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		String retStatus = result.getSys().getStatus();
		if (!"S".equals(retStatus)) {
			return true;
		}
		JSONObject output = (JSONObject) result.getOutput();
		List<ContractVo> contractList = JsonUtils.toList(output.getString("result"), ContractVo.class);
		if(null == contractList || contractList.isEmpty()) {
			return false;
		}
		ContractVo contractInfo = contractList.get(0);
		if(null == contract.getId()) {
			return true;
		}
		if(contract.getId().intValue() != contractInfo.getId().intValue()) {
			return true;
		}
		return false;
	}
	
	@RequestMapping({ "/enterprisePage" })
	public String enterprisePage(String enterpriseName, String type, PageVo<?> pageVo) {
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("enterprise_name", enterpriseName);
		paramter.put("type_", type);
		paramter.put("attribute2_", "1");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("page",pageVo);
		map.put("sign", "queryEnterpriseInfo");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		List<ContractEnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String resultStr = output.getString("result");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				enterpriseList = JsonUtils.toList(resultStr, ContractEnterpriseVo.class);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("enterpriseList", enterpriseList);
		getRequest().setAttribute("enterpriseName", enterpriseName);
		getRequest().setAttribute("type", type);
		return "ybl/v2/admin/factor/contract/enterpriseList";
	}
	
	@RequestMapping({ "/fundSourceAdd" })
	public String fundSourceAdd(String enterpriseName, String type) {
		return "ybl/v2/admin/factor/contract/fundSourceAdd";
	}
	
	/**
	 * 新增资金来源
	 * @param fundSource
	 * @return
	 */
	@RequestMapping({ "/fundSourceAddSave" })
	@ResponseBody
	@Log(operation=OperationType.Add,info="新增资金来源")
	public String fundSourceAddSave(FundSourceVo fundSource) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		ControllerUtils.setWho(fundSource);
		fundSource.setEnterpriseId(enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", fundSource);
		map.put("sign", "addFundSource");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
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
	
	@RequestMapping({ "/fundSourceList" })
	@ResponseBody
	public List<FundSourceVo> fundSourceList(String enterpriseName, String type) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("enterprise_id", enterpriseId);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("sign", "queryAllFundSource");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		List<FundSourceVo> fundSourceList = new ArrayList<FundSourceVo>();
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String resultStr = output.getString("result");
				fundSourceList = JsonUtils.toList(resultStr, FundSourceVo.class);
			}
		}
		return fundSourceList;
	}
	
	@RequestMapping({ "/quotaPage" })
	public String quotaPage(ContractVo contract, PageVo<?> pageVo) {
		contract.setStatus("effecting");
		queryContractPage(contract, pageVo);
		return "ybl/v2/admin/factor/quota/quotaList";
	}
	
	@RequestMapping({ "/quotaEdit" })
	public String quotaEdit(Long contractId) {
		if(null != contractId && contractId.intValue() > 0){
			queryContractInfoById(contractId,true);
		}
		return "ybl/v2/admin/factor/quota/quotaEdit";
	}
	
	/**
	 * 新增额度记录
	 * @param quota
	 * @param pageVo
	 * @return
	 */
	@RequestMapping({ "/quotaEditSave" })
	@ResponseBody
	@Log(operation=OperationType.Add,info="新增额度记录")
	public String quotaEditSave(QuotaRecordVo quota, PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		quota.setEnterpriseId(enterpriseId.toString());
		ControllerUtils.setWho(quota);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", quota);
		map.put("page",pageVo);
		map.put("sign", "addQuotaRecord");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
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
	
	@RequestMapping({ "/contractQuotaPage" })
	public String contractQuotaPage(ContractQuotaVo contractQuota, PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		contractQuota.setEnterpriseId(enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", contractQuota);
		map.put("page",pageVo);
		map.put("sign", "queryContractQuotaPage");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		List<ContractQuotaVo> resultList = null;
		V2EnterpriseVo enterprise = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				JSONObject retJson = output.getJSONObject("result");
				enterprise = JSONObject.parseObject(retJson.getString("enterprise"), V2EnterpriseVo.class);
				resultList = JsonUtils.toList(retJson.getString("contractQuotaList"), ContractQuotaVo.class);
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("enterprise", enterprise);
		getRequest().setAttribute("contractQuotaList", resultList);
		getRequest().setAttribute("contractQuota", contractQuota);
		return "ybl/v2/admin/factor/contract/contractQuotaList";
	}
	
	/**
	 * 保理商综合信息分页查询
	 * @param receivable 查询条件
	 * @param pageVo 分页查询条件
	 */
	@RequestMapping({ "/receivableInfoPage" })
	public String receivableInfoPage(ReceivableVo receivable, PageVo<?> pageVo) {
		queryReceivableInfoPage(receivable, pageVo);
		return "ybl/v2/admin/factor/contract/receivableList";
	}
	
	/**
	 * 核心企业综合信息分页查询
	 * @param receivable 查询条件
	 * @param pageVo 分页查询条件
	 */
	@RequestMapping({ "/coreReceivableInfoPage" })
	public String coreReceivableInfoPage(ReceivableVo receivable, PageVo<?> pageVo) {
		queryReceivableInfoPage(receivable, pageVo);
		return "ybl/v2/admin/factor/contract/coreReceivableList";
	}
	
	/**
	 * 供应商综合信息分页查询
	 * @param receivable 查询条件
	 * @param pageVo 分页查询条件
	 */
	@RequestMapping({ "/supplierReceivableInfoPage" })
	public String supplierReceivableInfoPage(ReceivableVo receivable, PageVo<?> pageVo) {
		queryReceivableInfoPage(receivable, pageVo);
		return "ybl/v2/admin/factor/contract/supplierReceivableList";
	}

	/**
	 * 综合信息分页查询
	 * @param receivable 查询条件
	 * @param pageVo 分页查询条件
	 */
	private void queryReceivableInfoPage(ReceivableVo receivable,
			PageVo<?> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		receivable.setEnterpriseId(enterpriseId.toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", receivable);
		map.put("page",pageVo);
		map.put("sign", "queryReceivableInfoPage");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
		List<ReceivableVo> resultList = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String resultStr = output.getString("result");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				resultList = JsonUtils.toList(resultStr, ReceivableVo.class);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("receivableList", resultList);
		getRequest().setAttribute("receivable", receivable);
	}
	
	@RequestMapping({ "/contractQuotaEdit" })
	public String contractQuotaEdit() {
		return "ybl/v2/admin/factor/contract/contractQuotaEdit";
	}
	
	/**
	 * 更新合同的预警额度
	 * @param earlyWarningAmount
	 * @param contractIds
	 * @return
	 */
	@RequestMapping({ "/contractQuotaEditSave" })
	@ResponseBody
	@Log(operation=OperationType.Edit,info="更新合同的预警额度")
	public String contractQuotaEditSave(Double earlyWarningAmount, String contractIds) {
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("id_", enterpriseId);
		paramter.put("early_warning_amount", earlyWarningAmount);
		paramter.put("attribute1_", contractIds);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("sign", "updateContractQuota");
		ResBody result = TradeInvokeUtils.invoke("V2ContractManagement", map);
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
}
