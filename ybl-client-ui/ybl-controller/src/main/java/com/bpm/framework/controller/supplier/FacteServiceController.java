package com.bpm.framework.controller.supplier;

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
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.EnterpriseSignVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.MemberSign;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({ "/facteServiceController" })
public class FacteServiceController extends AbstractController {

	private static final long serialVersionUID = 2370934416225697072L;

	/**
	 * 保理服务--查询
	 * 
	 * @param enterprise
	 * @param pageVo
	 * @return
	 */
	@RequestMapping({ "/facteService" })
	public String facteService(EnterpriseSignVo enterpriseSign, PageVo pageVo) {

		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		enterpriseSign.setEnterpriseId(user.getEnterpriseId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", enterpriseSign);
		map.put("page", pageVo);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody result = TradeInvokeUtils.invoke("FacteServiceManagement", map);
		PageVo page = null;
		List<EnterpriseSignVo> enterList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				enterList = JsonUtils.toList(records, EnterpriseSignVo.class);
				
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("enterList", enterList);
			}
		}
		
		
		//查询所以省份
		Map<String, Object> condition = new HashMap<String,Object>();
		condition.put("sign", "queryAllProvince");
		ResBody res = TradeInvokeUtils.invoke("ProvinceManagement", condition);
		List<ProvinceVo> proList = null;
		if(res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String records = output.getString("result");
				proList = JsonUtils.toList(records, ProvinceVo.class);
				getRequest().setAttribute("proList", proList);
			}
		}
		 
		//用户回显查询条件
		getRequest().setAttribute("enterpriseSign", enterpriseSign);
		
		return "ybl/admin/supplier/application/facteService";
	}
	
	/*
	 * 签约申请初始化
	 * @ enterpriseId  保理商企业id
	 */
	@RequestMapping("/facteServiceSign")
	public String facteServiceSign(String enterprise2Id) {
		
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login.jsp";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		EnterpriseVo enterprsie = new EnterpriseVo();
		enterprsie.setId(user.getEnterpriseId());
		map.put("paramter", enterprsie);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		List<EnterpriseVo> enterList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				enterList = JsonUtils.toList(records, EnterpriseVo.class);
				if(CollectionUtils.isNotEmpty(enterList)){
					getRequest().setAttribute("enterprise", enterList.get(0));
				}
			}
		}

		// 查询企业上传的图片
		Map<String, Object> condition = new HashMap<String, Object>();
		AttachmentVo attachment = new AttachmentVo();
		attachment.setResourceId(user.getEnterpriseId());
		attachment.setAttribute1("userCertificate_");
		condition.put("paramter", attachment);
		condition.put("sign", "queryAttchmentByCondition");
		ResBody result2 = TradeInvokeUtils.invoke("AttachmentManagement", condition);
		List<AttachmentVo> attachmentLidst = null;
		if (result2.getSys() != null) {
			String status = result2.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result2.getOutput();
				String records = output.getString("result");
				attachmentLidst = JsonUtils.toList(records, AttachmentVo.class);
				
				getRequest().setAttribute("attachmentLidst", attachmentLidst);
			}
		}
		getRequest().setAttribute("enterprise2Id", enterprise2Id);
		
		
		return "ybl/admin/supplier/application/facteServiceSign";

	}

	@RequestMapping("/MemberSignApply")
	@ResponseBody
	public ControllerResponse signApply(String enterprise2Id ,String attachmentArray) {
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		if(StringUtils.isEmpty(enterprise2Id)){
			response.setInfo("查询参数不符合规范！");
			response.setResponseType(ResponseType.FAILURE);
			return response;
		}

		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			response.setResponseType(ResponseType.FAILURE, "请先登录！");
			return response;
		}
		MemberSign memberSign = new MemberSign();
		ControllerUtils.setWho(memberSign);
		memberSign.setMemberId(user.getId());
		memberSign.setEnterprise2Id(Long.parseLong(enterprise2Id));
		memberSign.setEnterpriseId(user.getEnterpriseId());
		memberSign.setStatus("signing");
		
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] arr = attachmentArray.split("#");
			for (int i = 0; i < arr.length; i++) {
				AttachmentVo attache = JsonUtils.toObject(arr[i], AttachmentVo.class);
				ControllerUtils.setWho(attache);
				attache.setEnterpriseId(user.getEnterpriseId());
				attachList.add(attache);
			}
		}
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memberSign", memberSign);
		map.put("attachList", attachList);

		Map<String, Object> req = new HashMap<>();
		req.put("paramter", map);
		req.put("sign", "memberSign");
		ResBody result = TradeInvokeUtils.invoke("FacteServiceManagement", req);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if ("S".equals(status) && Boolean.parseBoolean(records)) {
				response.setInfo("签约申请成功");
				response.setResponseType(ResponseType.SUCCESS);
			}else{
				response.setInfo("签约申请失败！");
				response.setResponseType(ResponseType.FAILURE);
			}
		}
		return response;
	}

}
