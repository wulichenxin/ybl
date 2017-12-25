package com.bpm.framework.controller.v4.factor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchPendingVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanPendingVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementPaymentBatchVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformConfigFreeVo;
import cn.sunline.framework.util.ParameterValidateUtil;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.Sys;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0资金方放款管理
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
@Controller
@RequestMapping({ "/factorLoanManagementController" })
public class FactorLoanManagementController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 待放款列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/loanPending/list.htm")
	public String loanPending(FactorLoanManagementLoanPendingVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setBusinessId(user.getBusinessId().intValue());
		dto.setStatus(5);
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectLoanPending");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
		PageVo page=null;
		List<FactorLoanManagementLoanPendingVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorLoanManagementLoanPendingVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("待放款列表调用selectLoanPending服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/loanManagement/loan_pending_list";
	}
	
	/**
	 * 保存付款批次
	 * @param loanApplyId
	 * @return
	 */
	@RequestMapping(value = "/createBatch")
	@ResponseBody
	public ControllerResponse createBatch(Long loanApplyId) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			if(null == loanApplyId) {
				response.setInfo("参数不能为空");
				return response;
			}
			UserVo user = ControllerUtils.getCurrentUser();
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("loanApplyId", loanApplyId);
			param.put("businessId", user.getBusinessId());
			param.put("enterpriseId", user.getEnterpriseId());
			FactorLoanManagementPaymentBatchVo factorLoanManagementPaymentBatchVo = new FactorLoanManagementPaymentBatchVo();
			ControllerUtils.setWho(factorLoanManagementPaymentBatchVo);//设置时间、操作人;
			param.put("paymentBatch", factorLoanManagementPaymentBatchVo);
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "insertPaymentBatch");
			ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);//操作失败！
				}
			}
		} catch (Exception e) {
			log.error("保存付款批次出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
	
	/**
	 * 待放款批次列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/loanBatchPending/list.htm")
	public String loanBatchPending(FactorLoanManagementLoanBatchPendingVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setBusinessId(user.getBusinessId().intValue());
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectLoanBatchPending");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
		PageVo page=null;
		List<FactorLoanManagementLoanBatchPendingVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorLoanManagementLoanBatchPendingVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("待放款批次列表调用selectLoanBatchPending服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/loanManagement/loan_batch_pending_list";
	}
	
	/**
	 * 待付款批次详情
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/loanBatchPending/detail.htm")
	public String detail(FactorLoanManagementLoanPendingVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setBusinessId(user.getBusinessId().intValue());
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectLoanPending");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
		PageVo page=null;
		List<FactorLoanManagementLoanPendingVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorLoanManagementLoanPendingVo.class);
				if(null == list || list.size() <= 0) {
					return "404";
				}
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("待待付款批次详情调用selectLoanPending服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/loanManagement/loan_batch_pending_detail_list";
	}
	
	/**
	 * 弹出结算页面
	 * @param request
	 * @param batchId
	 * @return
	 */
	@RequestMapping("/loanBatchPending/{batchId}/preSettlement.htm")
	public String preSettlement(HttpServletRequest request,@PathVariable("batchId")Integer batchId) {
		UserVo user = ControllerUtils.getCurrentUser();
		getRequest().setAttribute("batchId", batchId);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("batchId", batchId);
		param.put("enterpriseId", user.getEnterpriseId());
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getPaymentBatchById");
		ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
		Map<String,Object> resultMap = null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				resultMap = (Map) JSONObject.parseObject(records, Map.class);
				String paymentBatchStr=resultMap.get("paymentBatch").toString();
				FactorLoanManagementPaymentBatchVo paymentBatch = JSONObject.parseObject(paymentBatchStr, FactorLoanManagementPaymentBatchVo.class);
				getRequest().setAttribute("paymentBatch", paymentBatch);
				String platformConfigFreeStr = resultMap.get("platformConfigFree").toString();
				PlatformConfigFreeVo platformConfigFree = JSONObject.parseObject(platformConfigFreeStr, PlatformConfigFreeVo.class);
				getRequest().setAttribute("platformConfigFree", platformConfigFree);
				String totalAssetsSettlementAmount = resultMap.get("totalAssetsSettlementAmount").toString();
				getRequest().setAttribute("totalAssetsSettlementAmount", totalAssetsSettlementAmount);
			} else{
				log.error("弹出结算页面调用getPaymentBatchById服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/loanManagement/pre_settlement";
	}
	
	/**
	 * 保存结算
	 * @param dto
	 * @param attachmentlist
	 * @return
	 */
	@RequestMapping("/loanBatchPending/settlement")
	@ResponseBody
	public ControllerResponse settlement(FactorLoanManagementLoanBatchSettlementVo dto,FormAttachmentListVo attachmentlist) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			//参数校验
			String validate = ParameterValidateUtil.validate(dto);
			if (validate.length() > 0) {
				response.setInfo(validate);
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
						if(attachmentVo != null && attachmentVo.getOldName() != null ){//防止页面空数据进入
							attachmentVo.setEnterpriseId(user.getEnterpriseId());
							ControllerUtils.setWho(attachmentVo);//设置时间、操作人
							tempList.add(attachmentVo);
						}
					}
					if(CollectionUtils.isEmpty(tempList)){
						response.setResponseType(ResponseType.ERROR);
						response.setInfo("请上传支付凭证！");
						return response;
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo("请上传支付凭证！");
				return response;
			}
			ControllerUtils.setWho(dto);//设置时间、操作人;
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("dto", dto);
			param.put("userId", user.getId());
			param.put("enterpriseId", user.getEnterpriseId());
			param.put("businessId", user.getBusinessId());
			param.put("attachmentList", tempList);
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "insertLoanBatchSettlement");
			ResBody result = TradeInvokeUtils.invoke("FactorLoanManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);//操作失败！
				}
			}
		} catch (Exception e) {
			log.error("保存结算出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;

	}

}
