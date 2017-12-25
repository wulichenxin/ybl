package com.bpm.framework.controller.customermanage;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.accountCenter.UserController;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AuditRecordVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/signController"})
public class SignController extends AbstractController {

    /**
     *
     */
    private static final long serialVersionUID = -2809460978768158852L;

    //查询所有签约客户
    @RequestMapping({" /myCustomer "})
    public String queryAll(String enterprise_name,String status_ , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise2_id", user.getEnterpriseId().toString());
		map.put("enterprise_name", enterprise_name);
		map.put("status_", status_);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryAllEnterprise");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("CustomerManagement", maps);					
		PageVo page=null;
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				String[] record=records.split(",");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				if(record.length > 0){
					list = JsonUtils.toList(records, Map.class);
					getRequest().setAttribute("list", list);
				}
				super.log.error("根据条件查询企业调用queryAllEnterprise服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询企业调用queryAllEnterprise服务返回失败，信息："+erortx);
				return null;
			}			
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("enterprise_name",enterprise_name);
		getRequest().setAttribute("status_",status_);
		
        return "ybl/admin/factor/customer/signManage";
    }
    
    /**
	 * 根据用户id查询企业信息
	 * @param request
	 * @param parameters 企业查询条件
	 * @return
	 */
	@RequestMapping(value="/queryEnterpriseByCondition")
	public String queryEnterpriseByCondition(String id_,String memberSignId,String type){
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() < 0 ){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		
		
		Map<String, Object> paramter = new HashMap<String,Object>();
		paramter.put("id_", id_);
		//(1)判断必要参数
		if(id_.isEmpty()){			
			return null;
		}
		//调用服务，进行企业认证表数据查询	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("sign", "queryEnterprise");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("CustomerManagement", map);	
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				
				Map<String,Object>	enterprise = JsonUtils.toMap(records);
				getRequest().setAttribute("enterprise", enterprise);
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回成功，信息："+records);
			}else{
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回失败，信息："+erortx);
				return null;
			}
		}
 		
 		//调用服务，进行签约表数据查询
 		Map<String, Object> paramters = new HashMap<String,Object>();
		paramters.put("enterprise2_id", user.getEnterpriseId());
		paramters.put("enterprise_id", id_);
		Map<String,Object> memberSignMap = new HashMap<String,Object>();
		memberSignMap.put("paramter", paramters);
		memberSignMap.put("sign", "queryMemberSign");//所调用的服务中的方法
		ResBody results = TradeInvokeUtils.invoke("CustomerManagement", memberSignMap);	
		
 		if(results.getSys()!=null){
			String statuss = results.getSys().getStatus();//状态：'S'成功，'F'失败
			String erortxs = results.getSys().getErortx();//错误信息	
			if("S".equals(statuss)){//交易成功
				JSONObject outputs = (JSONObject) results.getOutput();
				String records = outputs.getString("result");
				
				Map<String,Object>	memberSign = JsonUtils.toMap(records);
				getRequest().setAttribute("memberSign", memberSign);
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回成功，信息："+records);
			}else{
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回失败，信息："+erortxs);
				return null;
			}
		}
 		
 		
 		//查询企业上传的图片信息
 		Map<String, Object> condition = new HashMap<String, Object>();
		AttachmentVo attachment = new AttachmentVo();
		attachment.setResourceId(Long.parseLong(id_));
		attachment.setAttribute1("userCertificate_");
		condition.put("paramter", attachment);
		condition.put("sign", "queryAttchmentByCondition");
		ResBody result2 = TradeInvokeUtils.invoke("AttachmentManagement", condition);
		List<AttachmentVo> attachmentList = new ArrayList<AttachmentVo>();
		if (result2.getSys() != null) {
			String status = result2.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result2.getOutput();
				String records = output.getString("result");
				attachmentList = JsonUtils.toList(records, AttachmentVo.class);
			}
		}
		
		
		//查询签约申请时提交的图片
		Map<String,Object> paraMap = new HashMap<String,Object>();
		AttachmentVo attach = new AttachmentVo();
		attach.setResourceId(Long.parseLong(memberSignId));
		attach.setType("MemberSign");
		paraMap.put("paramter", attach);
		paraMap.put("sign", "queryAttchmentByCondition");
		ResBody resu = TradeInvokeUtils.invoke("AttachmentManagement", paraMap);
		List<AttachmentVo> attachtLidst = null;
		if (resu.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String records = output.getString("result");
				attachtLidst = JsonUtils.toList(records, AttachmentVo.class);
			}
		}
		
		attachmentList.addAll(attachtLidst);
		
		getRequest().setAttribute("attachmentList", attachmentList);
		getRequest().setAttribute("type", type);
		
 		
		
		return "ybl/admin/factor/customer/signEdit";
	}  
	
	@RequestMapping(value="/audit")
	public String audit(String signId){
		getRequest().setAttribute("memberSignId", signId);
		return "ybl/admin/factor/customer/audit";
	}
	
	@RequestMapping(value="/auditConfirm")
	@ResponseBody
	public ControllerResponse auditConfirm(AuditRecordVo auditRecordVo){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() < 0 ){
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
		}
		// (1)判断对象是否为空
		if (auditRecordVo == null) {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
		}
		// (2)判断必填参数是否填写
		if ((auditRecordVo.getBusinessId() > 0) && StringUtils.isNotEmpty(auditRecordVo.getType())
				&& StringUtils.isNotEmpty(auditRecordVo.getOperation())) {
		} else {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			super.log.error("新增/编辑时，必填参数不能为空");
			return response;
		}
		ControllerUtils.setWho(auditRecordVo);
		auditRecordVo.setAttribute1(user.getId().toString());//用备用字段放member2_id
		//调用服务
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", auditRecordVo);
		map.put("sign", "insertAuditRecord");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("CustomerManagement", map);	
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				response.setResponseType(ResponseType.SUCCESS_DELETE);					
				response.setObject(result);//设置返回结果	
				response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
				super.log.info("新增时，调用insertAuditRecord服务成功，信息：" + erortx);
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
				super.log.info("新增时，调用insertAuditRecord服务失败，信息：" + erortx);
			}
 		}
		return response;
	}
}
