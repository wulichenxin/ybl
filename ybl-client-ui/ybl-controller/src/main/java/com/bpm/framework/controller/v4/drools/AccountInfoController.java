package com.bpm.framework.controller.v4.drools;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.drools.compiler.lang.dsl.DSLMapParser.condition_key_return;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.drools.V4CardAutoVO;
import cn.sunline.framework.controller.vo.v4.drools.V4EnterpriseVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_STATUS;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 账户信息V4
 * @author win7
 *
 */
@Controller
@RequestMapping({ "/accountInfoController" })
public class AccountInfoController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2062048489067294599L;
	
	/**
	 * 账户信息 
	 * @return
	 */
	@RequestMapping(value="/accountInfo")
	public String accountInfo(){
		return "ybl4.0/admin/doorl/accountInfo/accountInfo";
	}
	
	/**
	 * 身份认证页面
	 */
	@RequestMapping(value="/authLook.htm")
	public String authLook(){
		UserVo user = ControllerUtils.getCurrentUser();
		if(0 == user.getEnterpriseId()) {  //还没有进行过身份认证
			return "ybl4.0/admin/doorl/cardAuth/authInfoTable";
		}
		boolean authStatus = true;
		V4EnterpriseVO v4EnterpriseVO = new V4EnterpriseVO();
		//身份认证表单信息查询
		EnterpriseVo  enterpriseVo = new EnterpriseVo();    //此对象只携带当前用户id查询身份认证表对象
		enterpriseVo.setId(user.getEnterpriseId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", enterpriseVo);
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4EnterpriseManagement", map);
		String erortx = result.getSys().getErortx();// 错误信息
		if ("S".equals(result.getSys().getStatus())) {// 交易成功
			JSONObject output = (JSONObject) result.getOutput();
			JSONObject results = output.getJSONObject("result");
			V4EnterpriseVO enterprise=JSONObject.toJavaObject(results, V4EnterpriseVO.class);
			if(enterprise.getAuthStatus() != E_V4_AUTH_STATUS.AUDITFAIL.getStatus()){//身份认证状态不失败情况
				ControllerUtils.getRequest().setAttribute("parameters", enterprise);
			}else{//审核失败
				v4EnterpriseVO.setAuthStatus(enterprise.getAuthStatus());
				ControllerUtils.getRequest().setAttribute("parameters", v4EnterpriseVO);//审核失败状态值
				authStatus = false;
			}
			super.log.info("获取当前身份认证信息queryEnterpriseByCondition服务返回成功信息：" + erortx);
		}else{
			super.log.info("获取当前身份认证信息queryEnterpriseByCondition服务返回失败信息：" + erortx);
			return null;
		}
		if(authStatus){//审核不失败加载附件
			//附件信息查询
			AttachmentVo attachmentVo = new AttachmentVo();
			attachmentVo.setResourceId(user.getEnterpriseId().intValue());
			attachmentVo.setCategory((long) E_V4_ATTACHMENT_CATEGORY.ENTERPRISE_CERTIFICATION.getStatus());//身份认证属性值
			Map<String, Object> mapattac = new HashMap<String, Object>();
			mapattac.put("paramter", attachmentVo);
			mapattac.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
			ResBody resultsa = TradeInvokeUtils.invoke("AttachmentManagement", mapattac);
			String erortxsa = result.getSys().getErortx();// 错误信息
			List<AttachmentVo> attachmentList = null;
			JSONObject output = (JSONObject) resultsa.getOutput();
			if ("S".equals(resultsa.getSys().getStatus())) {// 交易成功
				String resultJson = output.getString("result");
				attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
				ControllerUtils.getRequest().setAttribute("attachmentList", attachmentList); //附件数组对象
				super.log.info("获取当前身份认证附件信息queryEnterpriseByCondition服务返回成功信息：" + erortxsa);
			}else{
				super.log.info("获取当前身份认证附件信息queryEnterpriseByCondition服务返回失败信息：" + erortxsa);
				return null;
			}
		}
		//ControllerUtils.getRequest().setAttribute("look", 1);//查看属性
		return "ybl4.0/admin/doorl/cardAuth/authInfoTable";
	}
	
	
	/**
	 * 获取当前身份认证状态
	 * @return
	 */
	@RequestMapping(value="/authInfo")
	public String authInfo(){
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() == 0){//账号没有做过身份认证
			ControllerUtils.getRequest().setAttribute("status", "nopass");
			return "ybl4.0/admin/doorl/cardAuth/authInfo";
		}
		EnterpriseVo  enterpriseVo = new EnterpriseVo();    //此对象只携带用户id传值
		enterpriseVo.setId(user.getEnterpriseId());
		ControllerUtils.setWho(enterpriseVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", enterpriseVo);
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4EnterpriseManagement", map);
		String erortx = result.getSys().getErortx();// 错误信息
		if ("S".equals(result.getSys().getStatus())) {// 交易成功
			JSONObject output = (JSONObject) result.getOutput();
			JSONObject results = output.getJSONObject("result");
			V4EnterpriseVO enterprise=JSONObject.toJavaObject(results, V4EnterpriseVO.class);
			if(null != enterprise) {
				if(enterprise.getAuthStatus() == E_V4_AUTH_STATUS.AUDITING.getStatus()) {
					ControllerUtils.getRequest().setAttribute("status", "examine"); //身份认证处于审核中状态
				}else if(enterprise.getAuthStatus() == E_V4_AUTH_STATUS.AUDITSUCCESS.getStatus()) {
					ControllerUtils.getRequest().setAttribute("status", "adopt");  //身份认证处于认证成功状态
				}else{
					ControllerUtils.getRequest().setAttribute("status", "nopass"); //身份认证处于未通过状态
				}
			}
			super.log.info("获取当前身份认证状态queryEnterpriseByCondition服务返回成功信息：" + erortx);
		}else{ //当前用户暂未做身份认证申请
			super.log.info("获取当前身份认证状态queryEnterpriseByCondition服务返回失败信息：" + erortx);
			return null;
		}
		return "ybl4.0/admin/doorl/cardAuth/authInfo";
	}
	
	/**
	 * 身份认证提交
	 * @param enterpriseVO  身份认证基础信息
	 * @param attachmentList 附件信息
	 * @return
	 */
	@RequestMapping(value="/saveCardInfo")
	@ResponseBody
	public ControllerResponse saveOrUpdate(V4EnterpriseVO enterpriseVO, FormAttachmentListVo attachmentList){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		V4CardAutoVO cardAutoVO = new V4CardAutoVO();
		// 对象判断
		if (enterpriseVO == null ) {// 参数错误
			response.setInfo("参数错误");
			super.log.error("保存/编辑企业数据对象不能为空！");
			return response;
		}
		ControllerUtils.setWho(enterpriseVO);
		enterpriseVO.setEnable(1);  //是否可用
		enterpriseVO.setAuthStatus(E_V4_AUTH_STATUS.AUDITING.getStatus());  //审核中状态
		//附件集合判断
		List<AttachmentVo> tempList = new ArrayList<AttachmentVo>();
		if(attachmentList != null && CollectionUtils.isNotEmpty(attachmentList.getAttachmentList())){
			List<AttachmentVo> amList = attachmentList.getAttachmentList();
			if(CollectionUtils.isNotEmpty(amList)){
				for(int i =0, j = amList.size() ; i < j ; i++){ //遍历当前附件列表
					AttachmentVo attachmentVo = amList.get(i);
					if(attachmentVo != null && attachmentVo.getOldName() != null ){//防止页面空数据进入
						ControllerUtils.setWho(attachmentVo);//设置时间、操作人
						attachmentVo.setEnable(1);
						tempList.add(attachmentVo);
					}
				}
			}
		}
		cardAutoVO.setAttachmentList(tempList);	//附件对象
		cardAutoVO.setEnterprise(enterpriseVO);	//身份认证信息
		cardAutoVO.setMemberId(user.getId());	//当前用户ID
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", cardAutoVO); //交易传值
		map.put("sign", "insertEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4EnterpriseManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				JSONObject results = output.getJSONObject("result");
				Long enterpriseId = Long.parseLong(results.getString("enterpriseId"));
				user.setEnterpriseId(enterpriseId);  //将企业id放值session中
				HttpSession session = getSession();
				session.setAttribute(SystemConst.USER_SESSION_KEY, user);
				response.setInfo("操作成功！");
				response.setResponseType(ResponseType.SUCCESS_SAVE);
				super.log.info("保存认证申请insertEnterpriseByCondition服务返回成功信息：" + erortx);
			} else {
				response.setInfo("操作失败！");
				super.log.error("保存认证申请insertEnterpriseByCondition服务返回失败信息：" + erortx);
			}
		}
		return response;
	}
}
