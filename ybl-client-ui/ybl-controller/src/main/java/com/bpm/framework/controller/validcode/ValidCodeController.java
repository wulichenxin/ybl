package com.bpm.framework.controller.validcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.image.CaptchaServiceSingleton;
import com.bpm.framework.utils.RandomUtils;
import com.bpm.framework.utils.StringUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.mail.MailSender;
import cn.sunline.framework.sms.SMSUtils;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping("/validCodeController")
@ValidateSession(validate=false)
public class ValidCodeController extends AbstractController {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 短信验证码发送
	 * @param phone 手机号
	 * @param vCode 验证码
	 * @param type 短信验证码类型，regist：注册，findpwd：找回密码，bindbank，绑定银行卡
	 * @return
	 */
	@RequestMapping(value = "/sendSmsCode")
	@ResponseBody
	public ControllerResponse sendSmsCode(String phone, @RequestParam(required = false)String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		String isSendStr = isSendValidCode(phone, true, type, user);
		if(!"S".equals(isSendStr)) {
			response.setInfo(isSendStr);
			return response;
		}
		String smsCode = RandomUtils.generate(2, 6);
		String content = "短信验证码为：" + smsCode;
		boolean bool = SMSUtils.sendSms(phone, content);
		if(bool) {
			Map<String,Object> paramter = new HashMap<String,Object>();
			paramter.put("target_", phone);
			paramter.put("code_", smsCode);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("paramter", paramter);
			map.put("page", new PageVo<>());
			map.put("sign", "sendSmsCode");
			ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
			String ret = getResultStr(result);
			if("S".equals(ret)) {
	 			response.setResponseType(ResponseType.SUCCESS);
	 		} else {
	 			response.setInfo(ret);
	 		}
		} else {
			response.setInfo("短信发送失败");
		}
		return response;
	}
	
	/**
	 * 短信验证码发送
	 * @param phone 手机号
	 * @param vCode 验证码
	 * @param type 短信验证码类型，regist：注册，findpwd：找回密码，bindbank，绑定银行卡
	 * @return
	 */
	/*@RequestMapping(value = "/sendSmsCodeYu")
	@ResponseBody
	public ControllerResponse sendSmsCodeYu(String phone, String vCode, @RequestParam(required = false)String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		String isSendStr = isSendValidCodeYu(phone, vCode, true, type);
		if(!"S".equals(isSendStr)) {
			response.setInfo(isSendStr);
			return response;
		}
		String smsCode = RandomUtils.generate(2, 6);
		String content = "短信验证码为：" + smsCode;
		boolean bool = SMSUtils.sendSms(phone, content);
		if(bool) {
			Map<String,Object> paramter = new HashMap<String,Object>();
			paramter.put("target_", phone);
			paramter.put("code_", smsCode);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("paramter", paramter);
			map.put("page", new PageVo<>());
			map.put("sign", "sendSmsCode");
			ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
			String ret = getResultStr(result);
			if("S".equals(ret)) {
	 			response.setResponseType(ResponseType.SUCCESS);
	 		} else {
	 			response.setInfo(ret);
	 		}
		} else {
			response.setInfo("短信发送失败");
		}
		return response;
	}*/
	
	/**
	 * 邮箱验证码发送
	 * @param email
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/sendEmailCode")
	@ResponseBody
	public ControllerResponse sendEmailCode(String email, @RequestParam(required = false)String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		String isSendStr = isSendValidCode(email, false, type, user);
		if(!"S".equals(isSendStr)) {
			response.setInfo(isSendStr);
			return response;
		}
		String emailCode = RandomUtils.generate(2, 6);
		String content = "邮箱验证码为：" + emailCode;
		List<String> targets = new ArrayList<String>();
		targets.add(email);
		boolean bool = MailSender.sendSysMail("测试邮件", content, targets);
		if(bool){
			Map<String,Object> paramter = new HashMap<String,Object>();
			paramter.put("target_", email);
			paramter.put("code_", emailCode);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("paramter", paramter);
			map.put("page", new PageVo<>());
			map.put("sign", "sendEmailCode");
			ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
			String ret = getResultStr(result);
			if("S".equals(ret)) {
				response.setResponseType(ResponseType.SUCCESS);
			} else {
				response.setInfo(ret);
			}
		}
		return response;
	}
	
	/**
	 * 是否可以发送短信验证码或邮箱
	 * @param target 手机号/邮箱
	 * @param vCode 验证码
	 * @param isSms true：手机号，false：邮箱
	 * @param type 类型
	 * @return "S":可以发送，其他字符串，不满足验证码发送条件
	 */
	private String isSendValidCode(String target,boolean isSms, String type,UserVo user) {
		if(StringUtils.isEmpty(target) ){
			return isSms ? "手机号不能为空" : "邮箱不能为空";
		}
	/*	if(StringUtils.isEmpty(vCode)) {
			return "验证码不能为空";
		}
		Boolean flag = CaptchaServiceSingleton.getInstance().validateResponseForID(ControllerUtils.getSession().getId(),vCode);
		if(!flag) {
			return "验证码输入错误";
		}*/
		Map<String,Object> paramter = new HashMap<String,Object>();
		if(null != user && type.equals("bindemail")){//邮箱验证
			paramter.put("attribute2_",user.getUserName());
		}
		paramter.put("target_", target);
		paramter.put("attribute1_", type);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("page", new PageVo<>());
		String isSendSign = isSms ? "isSendSmsCode" : "isSendEmailCode";
		map.put("sign", isSendSign);
		ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
		return getResultStr(result);
	}
	
	/**
	 * 是否可以发送短信验证码或邮箱
	 * @param target 手机号/邮箱
	 * @param vCode 验证码
	 * @param isSms true：手机号，false：邮箱
	 * @param type 类型
	 * @return "S":可以发送，其他字符串，不满足验证码发送条件
	 */
	/*private String isSendValidCodeYu(String target, String vCode,boolean isSms, 
			String type) {
		if(StringUtils.isEmpty(target) ){
			return isSms ? "手机号不能为空" : "邮箱不能为空";
		}
		if(StringUtils.isEmpty(vCode)) {
			return "验证码不能为空";
		}
		Boolean flag = CaptchaServiceSingleton.getInstance().validateResponseForID(ControllerUtils.getSession().getId(),vCode);
		if(!flag) {
			return "验证码输入错误";
		}
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("telephone_", target);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("page", new PageVo<>());
		map.put("sign", "queryVisitorByConfition");
		ResBody result = TradeInvokeUtils.invoke("V2VisitorsManagement", map);
		return getResultStr(result);
	}*/
	private String getResultStr(ResBody result) {
		String ret = "";
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				ret = output.getString("result");
			} else {
				ret = result.getSys().getErortx();
			}
		}
		return ret;
	}
	
	
}
