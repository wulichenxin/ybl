package com.bpm.framework.controller.login;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.factor.MyMessageV4Controller;
import com.bpm.framework.image.CaptchaServiceSingleton;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.security.SHA256Encrypt;
import com.bpm.framework.utils.security.SaltGenerator;

import cn.sunline.framework.controller.vo.OperatePromissionUserVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PermissionVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.V2MemberVo;
import cn.sunline.framework.controller.vo.v4.factor.StationMessageVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_STATION_MESSAGE_STATUS;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping("/registerController")
@ValidateSession(validate=false)
public class RegisterController extends AbstractController {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2809460978768158852L;
	/**
	 * 跳转注册页面
	 * @return
	 */
	@RequestMapping(value = "/register.htm")
	public String toRegister(){
		return "ybl/admin/index/register";
	}
	
	/**
	 * 跳转首页
	 * @return
	 */
	@RequestMapping(value = "/toIndex")
	public String toIndex()
	{
		return "ybl/v2/admin/index/index";
	}
	
	/**
	 * 用户注册
	 * @param user 用户信息
	 * @param vCode 手机验证码
	 * @return
	 */
	@RequestMapping(value = "/doRegister")
	@ResponseBody
	public ControllerResponse doRegister(UserVo user,@RequestParam(required = false)String vCode){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		StationMessageVo messageVo = new StationMessageVo();
		if(user==null){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));
			super.log.error("注册用户对象不能为空！");
			return response;
		}
		if(StringUtils.isEmpty(user.getUserName()) ){
			response.setInfo("用户名不能为空");
			super.log.error("用户名不能为空！");
			return response;
		}else if(StringUtils.isEmpty(user.getPassword())){
			response.setInfo("密码不能为空");
			super.log.error("密码不能为空");
			return response;
		}else if(StringUtils.isNotEmpty(vCode)){
			String validCode = ValidCodeUtil.checkedValidCode(user.getUserName(), vCode);
			if(!"S".equalsIgnoreCase(validCode)){
				response.setInfo("短信验证码输入错误");
				super.log.error("短信验证码输入错误");
				return response;
			}
		}
		UserVo userVoName=new UserVo();
		userVoName.setUserName(user.getUserName());
		List<UserVo> listUserName=queryUserVoByCondition(userVoName);
		if(CollectionUtils.isNotEmpty(listUserName)){
			response.setInfo("该手机号已被注册使用,请重新输入");
			super.log.error("该手机号已被注册使用,请重新输入");
			return response;
		}
		Map<String,Object> map = new HashMap<String,Object>();
		user.setEnable(1); 				//设置为有效
		user.setCreatedTime(new Date());//设置创建时间
		user.setLastUpdateTime(new Date());//最近更新时间
		user.setStatus("normal");//状态正常
		user.setRegisterTime(new Date());//注册时间
		//user.setCertRole("member");//默认为游客
		user.setIsAdmin(1L); 	//注册默认为超级管理员
		user.setEnterpriseId(null);		//注册时企业id为空
		String salt = SaltGenerator.generator();//盐
		user.setSalt(salt);
		String password = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(user.getPassword())+salt);  //加密
		user.setPassword(password);
		map.put("paramter", user);
		map.put("sign", "insertMemeberInfo");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("V2MemberManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					JSONObject output = (JSONObject) result.getOutput();
					JSONObject results = output.getJSONObject("result");
					Long memberId = Long.parseLong(results.getString("memberId"));
					
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo("注册成功！");//设置返回的信息
					super.log.info("注册服务调用信息："+erortx);
					//给新注册的用户授予基本权限
					/*saveGrantPromissionUser(userVoName);*/
					
					//站内信消息
					ControllerUtils.setWho(messageVo);
					messageVo.setTitle("成功注册");
					messageVo.setStatus(E_V4_STATION_MESSAGE_STATUS.UNREAD.getStatus());
					messageVo.setMemberId(memberId);
					messageVo.setContent("尊敬的用户【"+user.getUserName()+"】您好，恭喜您在云保理平台注册成功");
					MyMessageV4Controller.insertStationMessage(messageVo);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
					super.log.error("注册服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
	}
	/**
	 * 绑定用户邮箱
	 * @param email  邮箱
	 * @param ecode  验证码
	 * @return
	 */
	@RequestMapping(value= "/setEmail")
	@ResponseBody
	public ControllerResponse setEmail(String email,String ecode) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(StringUtils.isEmpty(email) ){
			response.setInfo("邮箱号不能为空！");
			super.log.error("邮箱号不能为空！");
			return response;
		}
		if(StringUtils.isNotEmpty(ecode) ){//验证码判断
			String validCode = ValidCodeUtil.checkedValidCode(email, ecode);
			if(!"S".equalsIgnoreCase(validCode)){
				response.setInfo("邮箱验证码输入错误");
				super.log.error("邮箱验证码输入错误");
				return response;
			}
		}
		Map<String,Object> map = new HashMap<String,Object>();
		ControllerUtils.setWho(user);  //更新时间设置
		user.setEmail(email);
		map.put("paramter", user);
		map.put("sign", "updateMemberById");
		ResBody result  = TradeInvokeUtils.invoke("V2MemberManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo("绑定成功！");//设置返回的信息
					super.log.info("邮箱设置服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
					super.log.error("邮箱设置服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
	}
	
	/**
	 * 重置手机号码
	 * @param newUserName  新手机号码
	 * @param ucode      验证码
	 * @return
	 */
	@RequestMapping(value= "/resetUserName")
	@ResponseBody
	public ControllerResponse ressetUserName(String newUserName,String ucode) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(StringUtils.isEmpty(newUserName) ){
			response.setInfo("新手机号不能为空！");
			super.log.error("新手机号不能为空！");
			return response;
		}
		if(StringUtils.isNotEmpty(ucode) ){
			String validCode = ValidCodeUtil.checkedValidCode(newUserName, ucode);
			if(!"S".equalsIgnoreCase(validCode)){
				response.setInfo("短信验证码输入错误");
				super.log.error("短信验证码输入错误");
				return response;
			}
		}
		Map<String,Object> map = new HashMap<String,Object>();
		UserVo uservo = new UserVo();
		uservo.setUserName(newUserName);
		uservo.setId(user.getId());
		ControllerUtils.setWho(uservo); //最后更新时间
		map.put("paramter", uservo);
		map.put("sign", "updateMemberByUserName");
		ResBody result  = TradeInvokeUtils.invoke("V2MemberManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setInfo("更换手机号码成功！");//设置返回的信息
					user.setUserName(newUserName);
					HttpSession session = getSession();
					session.setAttribute(SystemConst.USER_SESSION_KEY, user);
					super.log.info("更换用户名服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
					super.log.error("更换用户名服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
	}
	
	@RequestMapping(value = "/check")
	@ResponseBody
	public ControllerResponse check(UserVo user, String code){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if(StringUtils.isEmpty(code)) {
			response.setInfo("验证码不能为空");
			return response;
		}
		String sessionCode = (String) super.getSession().getAttribute("forget");
		super.log.info("code=" + code + ",sessionCode=" + sessionCode);
		if(!code.equals(sessionCode)) {
			response.setInfo("短信验证码输入错误");
			return response;
		}
		if(user==null){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));
			super.log.error("更改用户密码对象不能为空！");
			return response;
		}
		if(StringUtils.isEmpty(user.getUserName()) ){
			response.setInfo("用户名不能为空");
			super.log.error("用户名不能为空！");
			return response;
		}
		//校验用户名
		if(StringUtils.isEmpty(user.getTelephone())){
			List<UserVo> list=queryUserVoByCondition(user);
			if(CollectionUtils.isNotEmpty(list)){
				response.setResponseType(ResponseType.SUCCESS);
				return response;
			}else{
				response.setInfo("userWrong");
				return response;
			}
		}else{//校验手机号
			List<UserVo> list=queryUserVoByCondition(user);
			if(CollectionUtils.isNotEmpty(list)){
				response.setResponseType(ResponseType.SUCCESS);
				return response;
			}else{
				response.setInfo("phoneWrong");
				return response;
			}
		}
	}
	/**
	 * 跳转忘记密码页面
	 * @return
	 */
	@RequestMapping(value = "/toForgetPassword")
	public String toForgetPassword(){
		return "ybl/v2/admin/index/forgetPassword";
		
	}
	
	/**
	 * 重置密码
	 * @param password  旧密码
	 * @param newpassword  新密码
	 * @return
	 */
	@RequestMapping(value = "/resetPassword")
	@ResponseBody
	public ControllerResponse resetPassword(@RequestParam("password")String password,@RequestParam("newpassword")String newpassword){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		StationMessageVo messageVo = new StationMessageVo();
		UserVo user = ControllerUtils.getCurrentUser();
		if(StringUtils.isEmpty(newpassword)){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));
			super.log.error("确认密码不能为空！");
			return response;
		}
		V2MemberVo userVo=new V2MemberVo();
		userVo.setUsername(user.getUserName());
		String pswd = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(password)+user.getSalt());
		userVo.setPassword(pswd);
		List<V2MemberVo> list=queryMemberVoByCondition(userVo); //旧密码验证
		if(CollectionUtils.isEmpty(list)){
			response.setInfo("密码输入错误！");
			super.log.error("密码输入错误！");
			return response;
		}else{
			V2MemberVo reuser=list.get(0);
			String repassword = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(newpassword)+reuser.getSalt());
			reuser.setPassword(repassword);
			reuser.setLastUpdateTime(new Date());
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("paramter", reuser);
			map.put("sign", "updateMemberById");
			ResBody result = null;
			result = TradeInvokeUtils.invoke("V2MemberManagement", map);
			if(result!=null){
				if(result.getSys()!=null){
					String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();//错误信息
					if("S".equals(status)){//交易成功
						response.setResponseType(ResponseType.SUCCESS_SAVE);					
						response.setInfo(I18NUtils.getText("sys.admin.save.success"));//设置返回的信息
						
						//站内信消息
						ControllerUtils.setWho(messageVo);
						messageVo.setStatus(E_V4_STATION_MESSAGE_STATUS.UNREAD.getStatus());
						messageVo.setMemberId(user.getId());
						messageVo.setTitle("修改密码");
						messageVo.setContent("尊敬的用户【"+user.getUserName()+"】您好，您的登录密码已修改成功，登录时请注意用新密码登录，感谢");
						MyMessageV4Controller.insertStationMessage(messageVo);
						
						super.log.info("更新密码服务调用信息："+erortx);
					}else{
						response.setResponseType(ResponseType.ERROR);
						response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
						super.log.error("更新密码服务调用信息："+erortx);
					}
				}
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		}
		return response;
	} 
	/**
	 * 根据条件查询用户信息
	 * @param userVo
	 * @return
	 */
	public List<UserVo> queryUserVoByCondition(UserVo userVo){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", userVo);
		map.put("page", new PageVo<>());
		map.put("sign", "queryMemberByCondition");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("v2MemberManagement", map);
		List<UserVo> userList=null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				userList=JsonUtils.toList(records,UserVo.class);
			}			
		}
 		return userList;
	}
	
	/**
	 * 根据条件查询用户信息
	 * @param userVo
	 * @return
	 */
	public List<V2MemberVo> queryMemberVoByCondition(V2MemberVo userVo){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", userVo);
		map.put("page", new PageVo<>());
		map.put("sign", "queryMemberByCondition");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("V2MemberManagement", map);
		List<V2MemberVo> userList=null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				userList=JsonUtils.toList(records,V2MemberVo.class);
			}			
		}
 		return userList;
	}
	
	@RequestMapping(value = "/sendSmsCode")
	@ResponseBody
	public ControllerResponse sendSmsCode(String phone, String vCode, @RequestParam(required = false)String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		boolean isReg = "regist".equals(type) ? true : false;
		sendValidCode(phone, vCode, true, isReg, response);
		return response;
	}
	@RequestMapping(value = "/sendEmailCode")
	@ResponseBody
	public ControllerResponse sendEmailCode(String email, String vCode, @RequestParam(required = false)String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		boolean isReg = "regist".equals(type) ? true : false;
		sendValidCode(email, vCode, false, isReg, response);
		return response;
	}
	
	/**
	 * 验证码发送
	 * @param target 手机号/邮箱
	 * @param vCode 验证码
	 * @param isSms true：手机号，false：邮箱
	 * @param isReg true：为注册发送验证码，false：其他情景发送验证码
	 * @param response 返回结果
	 */
	private void sendValidCode(String target, String vCode,boolean isSms, 
			boolean isReg, ControllerResponse response) {
		if(StringUtils.isEmpty(target) ){
			response.setResponseType(ResponseType.FAILURE);
			response.setInfo(isSms ? "手机号不能为空" : "邮箱不能为空");
			return;
		}
		if(StringUtils.isEmpty(vCode)) {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("验证码不能为空");
			return;
		}
		Boolean flag = CaptchaServiceSingleton.getInstance().validateResponseForID(ControllerUtils.getSession().getId(),vCode);
		if(!flag) {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("短信验证码输入错误");
			return;
		}
		
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("target_", target);
		if(isReg) {
			paramter.put("attribute1_", "regist");
		}
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			paramter.put("member_id", user.getId());
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("page", new PageVo<>());
		String sign = isSms ? "sendSmsCode" : "sendEmailCode";
		map.put("sign", sign);
		ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
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
		//校验用户名，短信是否发送频繁，成功发送短信，保存验证码信息
 		if("S".equals(ret)) {
 			response.setResponseType(ResponseType.SUCCESS);
 		} else {
 			response.setInfo(ret);
 		}
	}
	
	@RequestMapping(value = "/checkValidCode")
	@ResponseBody
	public ControllerResponse checkValidCode(String target, String code, String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if(StringUtils.isEmpty(target) ){
			response.setInfo(Constant.FORGET_PWD_TYPE_SMS.equals(type) ? "手机号不能为空" : "邮箱不能为空");
			return response;
		}
		if(StringUtils.isEmpty(code) ){
			response.setInfo("验证码不能为空");
			return response;
		}
		String ret = ValidCodeUtil.checkedValidCode(target, code);
		//校验用户名，短信是否发送频繁，成功发送短信，保存验证码信息
 		if("S".equals(ret)) {
 			super.getSession().setAttribute(Constant.FORGET_PWD_TARGET, target);
 			response.setResponseType(ResponseType.SUCCESS);
 		} else {
 			response.setInfo(ret);
 		}
		return response;
	}
	
	/**
	 * 检查注册时验证码输入是否正确
	 * @param target : 查找目标
	 * @param code : 输入验证码
	 * @param type : 类型
	 * @return
	 * @throws
	 */
	/*@RequestMapping(value = "/checkRegisterValidCode")
	@ResponseBody
	public List<Object> checkRegisterValidCode(String fieldValue, String fieldId){
		List<Object> list = new ArrayList<>();
		list.add(fieldId);
		if(StringUtils.isEmpty(fieldId) ){
			list.add(false);
		}
		if(StringUtils.isEmpty(fieldValue) ){
			list.add(false);
		}
		String ret = ValidCodeUtil.checkedValidCode(fieldId, fieldValue);
		//校验用户名，短信是否发送频繁，成功发送短信，保存验证码信息
		if("S".equals(ret)) {
			list.add(true);
		} else {
			list.add(false);
		}
		return list;
	}*/
	
	@RequestMapping(value = "/findResetPassword")
	@ResponseBody
	public ControllerResponse findResetPassword(String target, String password, String type){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		StationMessageVo messageVo = new StationMessageVo();
		if(StringUtils.isEmpty(target) ){
			response.setInfo(Constant.FORGET_PWD_TYPE_SMS.equals(type) ? "手机号不能为空" : "邮箱不能为空");
			return response;
		}
		String sessionPhone = (String) super.getSession().getAttribute(Constant.FORGET_PWD_TARGET);
		if(!target.equals(sessionPhone)) {
			response.setInfo("错误的手机号");
			return response;
		}
		if(StringUtils.isEmpty(password) ){
			response.setInfo("密码不能为空");
			return response;
		}
		UserVo userVoPhone=new UserVo();
		if(Constant.FORGET_PWD_TYPE_SMS.equals(type)) {
			userVoPhone.setUserName(target);
		} else {
			userVoPhone.setEmail(target);
		}
		V2MemberVo userVo=new V2MemberVo();
		userVo.setUsername(userVoPhone.getUserName());
		//userVo.setTelephone(userVoPhone.getTelephone());
		List<V2MemberVo> listUserPhone=queryMemberVoByCondition(userVo);
		//List<UserVo> listUserPhone=queryMemberVoByCondition(userVoPhone);
		if(null == listUserPhone || listUserPhone.isEmpty()) {
			response.setInfo(Constant.FORGET_PWD_TYPE_SMS.equals(type) ? "错误的手机号" : "错误的邮箱");
			return response;
		}
		
		V2MemberVo reuser=listUserPhone.get(0);
		String repassword = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(password) + reuser.getSalt());
		reuser.setPassword(repassword);
		reuser.setLastUpdateTime(new Date());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", reuser);
		map.put("sign", "updateMemberById");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("V2MemberManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setInfo(I18NUtils.getText("sys.admin.save.success"));//设置返回的信息
					
					//站内信消息
					ControllerUtils.setWho(messageVo);
					messageVo.setStatus(E_V4_STATION_MESSAGE_STATUS.UNREAD.getStatus());
					messageVo.setMemberId(reuser.getId());
					messageVo.setTitle("成功找回密码");
					messageVo.setContent("尊敬的用户您好，您的登录密码已找回成功，请妥善牢记，感谢");
					MyMessageV4Controller.insertStationMessage(messageVo);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
					super.log.error("更新密码服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
		}
		
		return response;
	}
	
	/**
	 * 给用户授予操作权限
	 * @param userVoName
	 *           新注册的用户信息
	 */
	/*private void saveGrantPromissionUser(UserVo userVoName) {
		//(1)查询新注册的用户信息
		List<UserVo> listUserName=queryUserVoByCondition(userVoName);
		if(CollectionUtils.isNotEmpty(listUserName)){
			userVoName = listUserName.get(0);
			Map<String, Object> map = new HashMap<String, Object>();
			List<String> promissionIdsList = new ArrayList<String>();
			OperatePromissionUserVo operatePromissionUserVo = new OperatePromissionUserVo();
			// (2)查询基础权限信息
			List<PermissionVo> permissionList = queryPermissionByCondition();
			if (CollectionUtils.isNotEmpty(permissionList)) {
				for (PermissionVo permission : permissionList) {
					promissionIdsList.add(permission.getId().toString());
				}
				//存在则授权
				operatePromissionUserVo.setMemberId(userVoName.getId());
				operatePromissionUserVo.setEnable(1);
				operatePromissionUserVo.setOperateId(promissionIdsList);
				operatePromissionUserVo.setEnterpriseId(userVoName.getEnterpriseId());
				ControllerUtils.setWho(operatePromissionUserVo);
				map.put("paramter", operatePromissionUserVo);
				map.put("sign", "insertUserAuthorityByUserId");
				// (3)调用服务，进行数据保存
				ResBody result = TradeInvokeUtils.invoke("BusinessMemberOperatorAuthority", map);
				// (4)解析返回数据
				if (result != null) {
					if (result.getSys() != null) {
						String status = result.getSys().getStatus();
						String erortx = result.getSys().getErortx();// 错误信息
						if ("S".equals(status)) {// 交易成功
							super.log.info("保存角色-用户授权信息，调用insertUserAuthorityByUserId服务成功：" + erortx);
						} else {
							super.log.error("保存角色-用户授权信息，调用insertUserAuthorityByUserId服务失败：" + erortx);
						}
					}
				} else {
					super.log.error("调用服务失败！");
				}
			}
		}
	}*/

	/**
	 * 根据条件查询权限列表数据
	 */
	/*private List<PermissionVo> queryPermissionByCondition() {
		// (1)调用服务，查询权限列表数据
		PermissionVo permission = new PermissionVo();
		Map<String, Object> map = new HashMap<String, Object>();
		permission.setType("base");// 查询基础数据类型
		map.put("paramter", permission);
		map.put("sign", "queryOperatorAuthorityByCondition");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessOperatorAuthorityManagement", map);
		List<PermissionVo> permissionList = null;
		// (2)服务返回数据分析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject output = (JSONObject) jsonMap.get("output");
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			permissionList = new ArrayList<PermissionVo>();
			if (sys != null) {
				String status = sys.getString("status");
				String erortx = sys.getString("erortx");
				if ("S".equals(status)) {// 交易成功
					String resultJson = output.getString("result");
					permissionList = (List<PermissionVo>) JSONArray.parseArray(resultJson, PermissionVo.class);
					super.log.info("根据条件查询权限列表，调用 queryOperatorAuthorityByCondition 服务成功:" + erortx);
				} else {
					super.log.error("根据条件查询权限列表，调用 queryOperatorAuthorityByCondition 服务失败:" + erortx);
				}
			}
		} else {
			super.log.error("调用服务失败");
		}
		return permissionList;
	}*/

}
