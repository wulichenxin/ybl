package com.bpm.framework.controller.v4.factor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementAuditHistoryVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementFinalAuditDto;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementFinalAuditVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementFirstAuditVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementIntentionalCapitalVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformAuditRecordVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_AUDIT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.ApplicantFinancialSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.ExternalGuaranteeSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanDebtSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_STATE;
import cn.sunline.framework.util.ParameterValidateUtil;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.Sys;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0资金方风控审核
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
@Controller
@RequestMapping({ "/factorRiskManagementController" })
public class FactorRiskManagementController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 资方初审列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/firstAudit/list.htm")
	public String firstAuditList(FactorRiskManagementFirstAuditVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setBusinessId(user.getBusinessId().intValue());
		dto.setFinancingStatus(E_V4_FINANCING_STATE.PLATFORM_FIRSTTRIAL.getStatus());//待资方初审
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectFirstAuditList");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page=null;
		List<FactorRiskManagementFirstAuditVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorRiskManagementFirstAuditVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询资方初审列表调用selectFirstAuditList服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}	
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/riskManagement/first_audit_list";
	}
	
	/**
	 * 资方终审列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/finalAudit/list.htm")
	public String finalAuditList(FactorRiskManagementFinalAuditVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setBusinessId(user.getBusinessId().intValue());
		dto.setFinancingStatus(E_V4_FINANCING_STATE.FINALAPPEAL_PENDINGPARTY.getStatus());//待资方终审		
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectFinalAuditList");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page=null;
		List<FactorRiskManagementFinalAuditVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorRiskManagementFinalAuditVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询资方终审列表调用selectFinalAuditList服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}	
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/riskManagement/final_audit_list";
	}
	
	/**
	 * 融资申请详情
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @return
	 */
	@Deprecated
	@RequestMapping(value = "/auditDetail.htm")
	public String auditDetail(Long financingApplyId,Long subFinancingApplyId,Long auditType) {
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		return "ybl4.0/admin/factor/riskManagement/audit_view";
	}
	
	/**
	 * 融资申请详情
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/financingApplyDetail.htm")
	public String financingApplyDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType < 1 || auditType > 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		//1、融资申请订单信息
		FinancingApplyVO financing = FinancingApplyCommonApi.getCurrentUserFinancingApplyDetail(financingApplyId,subFinancingApplyId,user.getBusinessId());
		if(null != financing && StringUtils.isNotEmpty(financing.getInvestorName())) {
			String[] array = financing.getInvestorName().split(",");
			StringBuffer sb = new StringBuffer();
			for(String s : array) {
				String[] sArray = s.split("-");
				sb.append(sArray[1]).append(",");
			}
			financing.setInvestorName(sb.toString().substring(0, sb.length()-1));
		} else if(null == financing){
			return "404";
		}
		getRequest().setAttribute("financing", financing);
		//2、查询申请人信息
		V4BusinessAuthVO businessAuth = FinancingApplyCommonApi.getBusinessApply(financing);
		getRequest().setAttribute("businessAuth", businessAuth);
		//3、查询股东列表信息
		List<StockHolderVO> stockHolderList = FinancingApplyCommonApi.getStockHolderList(financing);
		getRequest().setAttribute("stockHolderList", stockHolderList);
		//4、查询申请人财务情况
		ApplicantFinancialSituationVO situationVo = FinancingApplyCommonApi.getSituationInfoById(financing);
		getRequest().setAttribute("situationVo", situationVo);
		//5、查询出企业/个人的借款负债情况列表
		List<LoanDebtSituationVO> loanDebtSituationList = FinancingApplyCommonApi.getLoanDebtSituationListById(financing);
		getRequest().setAttribute("loanDebtSituationList", loanDebtSituationList);
		//6、查询对外担保情况列表
		List<ExternalGuaranteeSituationVO> externalGuaranteeSituationList = FinancingApplyCommonApi.getExternalGuaranteeSituationById(financing);
		getRequest().setAttribute("externalGuaranteeSituationList", externalGuaranteeSituationList);
		//底层资产列表展示 1、应收账款 2、应付账款 3、票据
		if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
			/*1、应收账款列表*/
			List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financing);
			getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
		} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
			/*2、应付账款列表*/
			List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financing);
			getRequest().setAttribute("accountsPayableList", accountsPayableList);
		} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
			/*3、票据列表*/
			List<BillVO> billList = FinancingApplyCommonApi.getBillById(financing);
			getRequest().setAttribute("billList", billList);
		}
		//4、获取融资申请资料清单
		List<AttachmentVo> attachments = FinancingApplyCommonApi.getAttachmentListByFinancingApply(financing.getId().intValue(),12,null);
		getRequest().setAttribute("attachments", attachments);
		//5、获取子订单补充资料
		List<AttachmentVo> supplementAttachments = FinancingApplyCommonApi.getAttachmentListByCurrentUserSubFinancingApply(user.getBusinessId(),financingApplyId,subFinancingApplyId,13,"34");
		getRequest().setAttribute("supplementAttachments", supplementAttachments);
		return "ybl4.0/admin/factor/riskManagement/financing_apply_details";
	}
	

	/**
	 * 平台端初审记录
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/platformFirstAuditDetail.htm")
	public String platformFirstAuditDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType < 1 || auditType > 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getPlatformFirstAuditDetail");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page = null;
		PlatformAuditRecordVo vo = null;
		List<PlatformAuditRecordVo> list=null;
		Map<String,Object> resultMap = null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				resultMap = (Map) JSONObject.parseObject(records, Map.class);
				Object obj = resultMap.get("obj");
				if(null == obj) {
					return "404";
				}
				vo=(PlatformAuditRecordVo) JSONObject.parseObject(obj.toString(), PlatformAuditRecordVo.class);
				if(null != vo && StringUtils.isNotEmpty(vo.getRecommendFactor())) {
					String[] array = vo.getRecommendFactor().split(",");
					StringBuffer sb = new StringBuffer();
					for(String s : array) {
						String[] sArray = s.split("-");
						sb.append(sArray[1]).append(",");
					}
					vo.setRecommendFactor(sb.toString().substring(0, sb.length()-1));
				}
				getRequest().setAttribute("vo", vo);
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(resultMap.get("result").toString(),PlatformAuditRecordVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询平台端初审记录调用getPlatformFirstAuditDetail服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/platform_first_audit_opinion_detail";
	}
	
	/**
	 * 平台端初审历史详情记录
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param auditId
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/{auditId}/platformFirstAuditHistoryDetail.htm")
	public String platformFirstAuditShow(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType,@PathVariable("auditId")Long auditId, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType < 1 || auditType > 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		param.put("auditId", auditId);
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getPlatformFirstAuditHistoryDetail");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PlatformAuditRecordVo vo = null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if(StringUtils.isEmpty(records)) {
					return "404";
				}
				vo=(PlatformAuditRecordVo) JSONObject.parseObject(records, PlatformAuditRecordVo.class);
				if(null != vo && StringUtils.isNotEmpty(vo.getRecommendFactor())) {
					String[] array = vo.getRecommendFactor().split(",");
					StringBuffer sb = new StringBuffer();
					for(String s : array) {
						String[] sArray = s.split("-");
						sb.append(sArray[1]).append(",");
					}
					vo.setRecommendFactor(sb.toString().substring(0, sb.length()-1));
				}
				getRequest().setAttribute("vo", vo);
			} else{
				log.error("查询平台端初审历史详情记录调用getPlatformFirstAuditHistoryDetail服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/platform_first_audit_history_detail";
	}
	/**
	 * 资金方初审记录
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/firstAuditDetail.htm")
	public String firstAuditDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType != 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getFirstAuditDetail");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page = null;
		Map<String,Object> resultMap = null;
		List<AttachmentVo> attachmentList=null;
		FactorRiskManagementAuditHistoryVo vo = null;
		List<FactorRiskManagementAuditHistoryVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				resultMap = (Map) JSONObject.parseObject(records, Map.class);
				Object obj = resultMap.get("obj");
				if(null == obj) {
					return "404";
				}
				Object attachments = resultMap.get("attachments");
				if(null != attachments) {
					attachmentList=JsonUtils.toList(attachments.toString(),AttachmentVo.class);
					getRequest().setAttribute("attachmentList", attachmentList);
				}
				vo=(FactorRiskManagementAuditHistoryVo) JSONObject.parseObject(obj.toString(), FactorRiskManagementAuditHistoryVo.class);
				getRequest().setAttribute("vo", vo);
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(resultMap.get("result").toString(),FactorRiskManagementAuditHistoryVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询资金方初审记录调用getFirstAuditDetail服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/first_audit_opinion_detail";
	}
	
	/**
	 * 资金方审核历史详情记录
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param auditId
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/{auditId}/factorAuditHistoryDetail.htm")
	public String factorAuditHistoryDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType,@PathVariable("auditId") Long auditId, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType < 1 || auditType > 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		param.put("auditId", auditId);
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getFactorAuditHistoryDetail");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page = null;
		FactorRiskManagementAuditHistoryVo vo = null;
		List<AttachmentVo> list=null;
		Map<String,Object> resultMap = null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				resultMap = (Map) JSONObject.parseObject(records, Map.class);
				Object obj = resultMap.get("obj");
				if(null == obj) {
					return "404";
				}
				vo=(FactorRiskManagementAuditHistoryVo) JSONObject.parseObject(obj.toString(), FactorRiskManagementAuditHistoryVo.class);
				getRequest().setAttribute("vo", vo);
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				String attachments = resultMap.get("attachments").toString();
				list=JsonUtils.toList(attachments,AttachmentVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询资金方审核历史详情记录调用getFactorAuditHistoryDetail服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/factor_audit_history_detail";
	}
	/**
	 * 意向资方
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/{auditType}/intentionalCapitalDetail.htm")
	public String intentionalCapitalDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType != 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getIntentionalCapitalDetail");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page = null;
		List<FactorRiskManagementIntentionalCapitalVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorRiskManagementIntentionalCapitalVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("查询意向资方调用getIntentionalCapitalDetail服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/intentional_capital_details";
	}
	
	/**
	 * 弹出新增资方初审页面
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param pageVo
	 * @return
	 */
	@RequestMapping("/{financingApplyId}/{subFinancingApplyId}/{auditType}/preCreateAuditHistory.htm")
	public String preCreateAuditHistory(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType != 1) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectAuditHistory");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page=null;
		List<FactorRiskManagementAuditHistoryVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				if(null == records) {
					page.setRecords(new ArrayList<FactorRiskManagementAuditHistoryVo>());
				} else {
					list=JsonUtils.toList(records,FactorRiskManagementAuditHistoryVo.class);
					page.setRecords(list);	
				}
				getRequest().setAttribute("page", page);
			} else{
				log.error("弹出新增资方初审页面调用selectAuditHistory服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/riskManagement/first_audit_opinion";
	}
	
	/**
	 * 保存资方初审记录
	 * @param dto
	 * @param attachmentlist
	 * @return
	 */
	@RequestMapping(value = "/createAuditHistory")
	@ResponseBody
	public ControllerResponse createAuditHistory(FactorRiskManagementAuditHistoryVo dto,FormAttachmentListVo attachmentlist,String auditDateStr) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			//参数校验
			String validate = ParameterValidateUtil.validate(dto);
			if (validate.length() > 0) {
				response.setInfo(validate);
				return response;
			}
			UserVo user = ControllerUtils.getCurrentUser();
			if(StringUtils.isNotEmpty(auditDateStr))
				dto.setAuditDate(DateUtils.toDate(auditDateStr, "yyyy-MM-dd"));
			//附件集合校验
			List<AttachmentVo> tempList = new ArrayList<AttachmentVo>();
			if(attachmentlist != null && null != attachmentlist.getAttachmentList() && attachmentlist.getAttachmentList().size() > 0){
				List<AttachmentVo> amList = attachmentlist.getAttachmentList();
				if(CollectionUtils.isNotEmpty(amList)){
					for(int i =0, j = amList.size() ; i < j ; i++){
						AttachmentVo attachmentVo = amList.get(i);
						if(attachmentVo != null && attachmentVo.getOldName() != null ){//防止页面空数据进入
							attachmentVo.setEnterpriseId(user.getEnterpriseId());
							ControllerUtils.setWho(attachmentVo);//设置时间、操作人
							tempList.add(attachmentVo);
						}
					}
					if(CollectionUtils.isEmpty(tempList)){
						response.setResponseType(ResponseType.ERROR);
						response.setInfo("请上传初审意见表！");
						return response;
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo("请上传初审意见表！");
				return response;
			}
			ControllerUtils.setWho(dto);//设置时间、操作人
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			dto.setAuditType(E_V4_AUDIT_TYPE.AUDIT_BEGIN.getStatus());
			param.put("businessId", user.getBusinessId());
			param.put("enterpriseId", user.getEnterpriseId());
			param.put("memberId", user.getId());
			param.put("dto", dto);
			param.put("attachmentList", tempList);
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "insertAuditHistory");
			ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				} else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);
				}
			}
		} catch (Exception e) {
			log.error("保存资方初审记录出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}

	/**
	 * 弹出资方终审页面
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @param auditType
	 * @param pageVo
	 * @return
	 */
	@RequestMapping("/{financingApplyId}/{subFinancingApplyId}/{auditType}/preCreateFinalAuditHistory.htm")
	public String preCreateFinalAuditHistory(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId,@PathVariable("auditType")Long auditType, PageVo pageVo) {
		if(null == financingApplyId || null == subFinancingApplyId || null == auditType || auditType != 2) {
			return "404";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("auditType", auditType);
		getRequest().setAttribute("financingApplyId", financingApplyId);
		getRequest().setAttribute("subFinancingApplyId", subFinancingApplyId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectAuditHistory");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		PageVo page=null;
		List<FactorRiskManagementAuditHistoryVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				if(null == records) {
					page.setRecords(new ArrayList<FactorRiskManagementAuditHistoryVo>());
				} else {
					list=JsonUtils.toList(records,FactorRiskManagementAuditHistoryVo.class);
					page.setRecords(list);	
				}
				getRequest().setAttribute("page", page);
			} else{
				log.error("弹出资方终审页面调用selectAuditHistory服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		
		return "ybl4.0/admin/factor/riskManagement/final_audit_opinion";
	}
	
	/**
	 * 保存资方终审记录
	 * @param dto
	 * @param attachmentlist
	 * @return
	 */
	@RequestMapping(value = "/createFinalAuditHistory")
	@ResponseBody
	public ControllerResponse createFinalAuditHistory(FactorRiskManagementFinalAuditDto dto,FormAttachmentListVo attachmentlist,String audithistoryAuditDateStr,String cooperationElementsAuditDateStr) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			//参数校验 
			String audithistoryValidate = ParameterValidateUtil.validate(dto.getAudithistory());
			String cooperationElementsValidate = ParameterValidateUtil.validate(dto.getCooperationElements());
			if (audithistoryValidate.length() > 0) {
				response.setInfo(audithistoryValidate);
				return response;
			}
			if (cooperationElementsValidate.length() > 0) {
				response.setInfo(cooperationElementsValidate);
				return response;
			}
			UserVo user = ControllerUtils.getCurrentUser();
			//附件集合校验
			List<AttachmentVo> tempList = new ArrayList<AttachmentVo>();
			if(attachmentlist != null && null != attachmentlist.getAttachmentList() && attachmentlist.getAttachmentList().size() > 0){
				List<AttachmentVo> amList = attachmentlist.getAttachmentList();
				if(CollectionUtils.isNotEmpty(amList)){
					for(int i =0, j = amList.size() ; i < j ; i++){
						AttachmentVo attachmentVo = amList.get(i);
						//风控措施没有oldName
						if(null != attachmentVo && StringUtils.isNotEmpty(attachmentVo.getType()) && attachmentVo.getType().equals("60")) {
							attachmentVo.setEnterpriseId(user.getEnterpriseId());
							ControllerUtils.setWho(attachmentVo);//设置时间、操作人
							tempList.add(attachmentVo);
						} else if(attachmentVo != null && StringUtils.isNotEmpty(attachmentVo.getOldName())){//防止页面空数据进入
							attachmentVo.setEnterpriseId(user.getEnterpriseId());
							ControllerUtils.setWho(attachmentVo);//设置时间、操作人
							tempList.add(attachmentVo);
						}
					}
					if(CollectionUtils.isEmpty(tempList)){
						response.setResponseType(ResponseType.ERROR);
						response.setInfo("请上传终审意见表");
						return response;
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo("请上传终审意见表");
				return response;
			}
			if(StringUtils.isNotEmpty(audithistoryAuditDateStr))
				dto.getAudithistory().setAuditDate(DateUtils.toDate(audithistoryAuditDateStr, "yyyy-MM-dd"));
			if(StringUtils.isNotEmpty(cooperationElementsAuditDateStr))
				dto.getCooperationElements().setAuditDate(DateUtils.toDate(cooperationElementsAuditDateStr, "yyyy-MM-dd"));
			ControllerUtils.setWho(dto.getAudithistory());//设置时间、操作人
			ControllerUtils.setWho(dto.getCooperationElements());//设置时间、操作人
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			dto.getAudithistory().setAuditType(E_V4_AUDIT_TYPE.AUDIT_AGAIN.getStatus());
			param.put("memberId", user.getId());
			param.put("enterpriseId", user.getEnterpriseId());
			param.put("audithistory", dto.getAudithistory());
			param.put("businessId", user.getBusinessId());
			param.put("cooperationElements", dto.getCooperationElements());
			param.put("attachmentList", tempList);
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "insertFinalAuditHistory");
			ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				} else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);
				}
			}
		} catch (Exception e) {
			log.error("保存资方终审记录出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
}
