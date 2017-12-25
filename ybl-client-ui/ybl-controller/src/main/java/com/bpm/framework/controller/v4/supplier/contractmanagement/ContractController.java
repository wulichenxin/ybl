package com.bpm.framework.controller.v4.supplier.contractmanagement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.ContractMangementVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping("/contractController")
public class ContractController extends AbstractController{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	
	/**
	 * 合同查看
	 * @param financinapply
	 * @return
	 */
		@ValidateSession(validate = false)
		@SuppressWarnings("rawtypes")
		@RequestMapping(value = "/list.htm")
		public String list(ContractMangementVO financinapply, PageVo pageVo) {
			
			Map<String, Object> maps = new HashMap<String, Object>();
		//	获取当前登录用户的企业id作为查询过滤条件
			UserVo userVo = ControllerUtils.getCurrentUser();
			Long  enterpriseid=userVo.getBusinessId();	

			financinapply.setEnterprise_id(enterpriseid);
			financinapply.setStatus(2);
			maps.put("contract", financinapply);
			maps.put("page", pageVo);
			maps.put("sign", "contractquery");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("ContractMangement",
					maps);
			PageVo page = null;
			List<ContractMangementVO> list = null;
	       if(result!=null  &&!"".equals(result)){
	    	   if (result.getSys() != null) {
	   			String status = result.getSys().getStatus();
	   			String erortx = result.getSys().getErortx();// 错误信息
	   			if ("S".equals(status)) {// 交易成功
	   				JSONObject output = (JSONObject) result.getOutput();
	   				String jsonPage = output.getString("page");
	   				String records = output.getString("contractlist");
	   				page = (PageVo<?>) JSONObject.parseObject(jsonPage,
	   						PageVo.class);
					list=JsonUtils.toList(records,ContractMangementVO.class);
					page.setRecords(list);
	   				getRequest().setAttribute("page", page);
	   				getRequest().setAttribute("financinapply", financinapply);
	   			}
	   		}
			}
			

			return "ybl4.0/admin/supplier/contractmanagement/list";

		
		}

		/**
		 * 合同签约
		 * @param financinapply
		 * @return
		 */
			@ValidateSession(validate = false)
			@SuppressWarnings("rawtypes")
			@RequestMapping(value = "/contractSure.htm")
			public String contractSure(ContractMangementVO financinapply,PageVo pageVo) {
				Map<String, Object> maps = new HashMap<String, Object>();		
				UserVo userVo = ControllerUtils.getCurrentUser();
				Long  enterpriseid=userVo.getBusinessId();	
				financinapply.setEnterprise_id(enterpriseid);
				financinapply.setStatus(1);
				maps.put("contract", financinapply);
				maps.put("page", pageVo);
				maps.put("sign", "contractquery");// 所调用的服务中的方法
				ResBody result = TradeInvokeUtils.invoke("ContractMangement",
						maps);
				PageVo page = null;
				List<ContractMangementVO> list = null;
		       if(result!=null  &&!"".equals(result)){
		    	   if (result.getSys() != null) {
		   			String status = result.getSys().getStatus();
		   			String erortx = result.getSys().getErortx();// 错误信息
		   			if ("S".equals(status)) {// 交易成功
		   				JSONObject output = (JSONObject) result.getOutput();
		   				String jsonPage = output.getString("page");
		   				String records = output.getString("contractlist");
		   				page = (PageVo<?>) JSONObject.parseObject(jsonPage,
		   						PageVo.class);
						list=JsonUtils.toList(records,ContractMangementVO.class);
						page.setRecords(list);
		   				getRequest().setAttribute("page", page);
		   				getRequest().setAttribute("financinapply", financinapply);
		   			}
		   		}
				}
				

				return "ybl4.0/admin/supplier/contractmanagement/contractAwawd";

			
			}

	/**
	 * 进入签署合同界面
	 */
	@RequestMapping("/updateInfo.htm")
	public String updateInfo(String master_contract_no,Long id,Long appid,Long applid){
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("master_contract_no", master_contract_no);
		maps.put("sign", "selectContractInfoByMasterContractNo");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ContractMangement", maps);
		if(isSuccess(result)){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("contractInfo");
				getRequest().setAttribute("entity", JSONObject.parse(stringPage));
				getRequest().setAttribute("appid",appid);
				getRequest().setAttribute("applid",applid);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息："+stringPage);
			}else{
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息："+erortx);
				return null;
			}	
		}
		return "ybl4.0/admin/supplier/contractmanagement/updateContract";
	}
	
	/**
	 * 进查看合同界面
	 */
	@RequestMapping("/goInfo.htm")
	public String goInfo(String master_contract_no,Long id){
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("master_contract_no", master_contract_no);
		maps.put("sign", "selectContractInfoByMasterContractNo");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ContractMangement", maps);
		if(isSuccess(result)){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("contractInfo");
				ContractV4Vo c = JsonUtils.toObject(stringPage, ContractV4Vo.class);
				getRequest().setAttribute("entity", JSONObject.parse(stringPage));
				AttachmentVo attachment = new AttachmentVo();
				AttachmentVo attachments = new AttachmentVo();
		 		attachment.setType(E_V4_ATTACHMENT_TYPE.CONTRACT_ATTACHMENT.getStatus());
				attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.CONTRACT_CATEGORY.getStatus()));
				if(id == null) {
					attachment.setResourceId(Integer.valueOf(c.getId().toString()));					
				}else {
					attachment.setResourceId(Integer.valueOf(id.toString()));
				}
				attachments=SelectAttachmentList(attachment);
				getRequest().setAttribute("attachment", attachments);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息："+stringPage);
			}else{
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息："+erortx);
				return null;
			}	
		}
		return "ybl4.0/admin/supplier/contractmanagement/goContract";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/getContractDocument")
	public ControllerResponse getContractDocument(Integer id){
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE);
		AttachmentVo attachment = new AttachmentVo();
 		attachment.setType(E_V4_ATTACHMENT_TYPE.CONTRACT_ATTACHMENT.getStatus());
		attachment.setCategory(Long.valueOf(E_V4_ATTACHMENT_CATEGORY.CONTRACT_CATEGORY.getStatus()));
		attachment.setResourceId(id);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		if(!"[]".equals(attachmentList)&&attachmentList != null && attachmentList.size() > 0){
			attachment = attachmentList.get(0);
			responseResult.setResponseType(ResponseType.SUCCESS, "获取合同文件成功");
			responseResult.setObject(attachment);
			super.log.info("获取合同模版成功");
		}else{
			responseResult.setResponseType(ResponseType.ERROR, "获取合同文件失败");
			super.log.info("获取合同模版失败");
		}
		
		return responseResult;
	}
	
	@ResponseBody
	@RequestMapping("/updateContractInfo")
	public ControllerResponse updateContractInfo(Integer contract_id, AttachmentVo attachment,Long appid,Long applid){
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE,"附件更新失败");
		
		Map<String,Object> map = new HashMap<String,Object>();
		ControllerUtils.setWho(attachment);
		map.put("paramter", attachment);
		map.put("sign", "updateAttachmentById");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		if(isSuccess(resultAttachment)){
			Map<String,Object> contract = new HashMap<String,Object>();
			contract.put("contract_id", contract_id);
			contract.put("status", 2);
			contract.put("sign", "updateContractStatusById");// 所调用的服务中的方法
			ResBody resultContract = TradeInvokeUtils.invoke("ContractMangement", contract);
			responseResult = new ControllerResponse(ResponseType.FAILURE,"合同更新失败");
			if(isSuccess(resultContract)){
				responseResult = new ControllerResponse(ResponseType.SUCCESS,"合同更新成功");
				//更新成功后修改融资定单以及子定单得状态
				UpdateFinalApply( appid, applid);
				
				
			}
			
		}
		return responseResult;
	}
	
	
	public AttachmentVo SelectAttachmentList(AttachmentVo  attachment){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		AttachmentVo att = new AttachmentVo();
		if(!"[]".equals(resultJson)&&resultJson!=null){
		List<AttachmentVo> attachmentlist = JsonUtils.toList(resultJson, AttachmentVo.class);
		if(attachmentlist != null && attachmentlist.size()>=0){
			att = attachmentlist.get(0);
		}
			}
		return att;
		
		
	}
	
//根据融资申请定单id和子定单id，修改签约成功的定单状态，并且修改其余子定单状态为不可用
	public ControllerResponse UpdateFinalApply(Long appid , Long applid){
		ControllerResponse responseResult = new ControllerResponse(ResponseType.FAILURE,"附件更新失败");
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("appid",appid );
		map1.put("sign", "updateById");// 所调用的服务中的方法
		ResBody result1 = TradeInvokeUtils.invoke("ContractMangement", map1);
		JSONObject output1 = (JSONObject) result1.getOutput();
		int resultJson1 = output1.getIntValue("count");
		if(resultJson1>0){
			responseResult.setResponseType(ResponseType.SUCCESS);
		}else{
			responseResult.setResponseType(ResponseType.FAILURE);
		}
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("appid",appid );
		map2.put("sign", "updateByfinaId");// 所调用的服务中的方法
		ResBody result2 = TradeInvokeUtils.invoke("ContractMangement", map2);
		JSONObject output2 = (JSONObject) result2.getOutput();
		int resultJson2 = output2.getIntValue("count");
		if(resultJson2>0){
			responseResult.setResponseType(ResponseType.SUCCESS);
		}else{
			responseResult.setResponseType(ResponseType.FAILURE);
		}
		Map<String,Object> map3 = new HashMap<String,Object>();
		map3.put("applid",applid );
		map3.put("sign", "updateByChildren");// 所调用的服务中的方法
		ResBody result3 = TradeInvokeUtils.invoke("ContractMangement", map3);
		JSONObject output3 = (JSONObject) result3.getOutput();
		int resultJson3 = output3.getIntValue("count");
		if(resultJson3>0){
			responseResult.setResponseType(ResponseType.SUCCESS);
		}else{
			responseResult.setResponseType(ResponseType.FAILURE);
		}
		return responseResult;
	}

}
