package com.bpm.framework.controller.login;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.security.SHA256Encrypt;

import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FriendlyLinkVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/loginController"})
public class LoginController extends AbstractController {

    /**
     *
     */
    private static final long serialVersionUID = -2809460978768158852L;
	
	@ValidateSession(validate=false)
	@RequestMapping(value="/login.htm",method={RequestMethod.GET})
	public String login(){
		return "ybl/admin/index/login";
	}
	
	/**
	 * 退出
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException{
		/*HttpSession session = request.getSession();
		final String sessionID = session.getId();
		session.invalidate();
		RedisCache.del(new String[]{ SystemConst.USER_SESSION_KEY, SystemConst.USER_SESSION_KEY + sessionID });*/
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			HttpSession session = getRequest().getSession();
			final String sessionID = session.getId();
			session.removeAttribute(SystemConst.USER_SESSION_KEY);
			RedisCache.del(SystemConst.USER_SESSION_KEY + sessionID);
			getSession().removeAttribute("type");
		}
		response.sendRedirect("/loginController/login.htm");
//		return "ybl/admin/index/login";
	}
	
	@ValidateSession(validate=false)
	@RequestMapping(value="/login", method={ RequestMethod.POST })
	@ResponseBody
	public ControllerResponse login(HttpServletResponse response,@RequestParam("userName")String userName, @RequestParam("password")String password) {
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if(!StringUtils.isNotEmpty(userName) ||  !StringUtils.isNotEmpty(password)){
				cr.setInfo("参数错误");
				return cr;
			}
			UserVo userVo=new UserVo();
			userVo.setUserName(userName);
			List<UserVo> listUser=queryUserVoByCondition(userVo);
			if(CollectionUtils.isEmpty(listUser)){
				cr.setInfo(I18NUtils.getText("sys.client.login.wrong"));
				return cr;
			}
			UserVo user=listUser.get(0);
			if(!"normal".equals(user.getStatus())){
				cr.setInfo(I18NUtils.getText("sys.client.login.status.wrong"));
				return cr;
			}
			String pwd=user.getPassword();
			String salt=user.getSalt();
			String pswd=SHA256Encrypt.encrypt(password+salt);
			if(!pswd .equals(pwd)){
				cr.setInfo(I18NUtils.getText("sys.client.login.wrong"));
				return cr;
			}
			//登陆成功用户信息存到session中
			HttpSession session = getSession();
			session.setAttribute(SystemConst.USER_SESSION_KEY,user);
			//把用户信息存到redis中
			RedisCache.set(SystemConst.USER_SESSION_KEY+session.getId(), user);
			//把用户认证角色存到session中(必须查询是否角色认证通过，不通过则还是原始类型)
			EnterpriseVo parameters = new EnterpriseVo();
			parameters.setId(user.getEnterpriseId());
			List<EnterpriseVo> enterpriseList= queryEnterpriseByCondition(parameters);
			if(CollectionUtils.isNotEmpty(enterpriseList)){
				parameters = enterpriseList.get(0);
				if(parameters.getId()>0 && parameters.getStatus().equals(Constant.USER_AUTH_AGREE)){
					super.getSession().setAttribute("type", user.getCertRole());
				}else{
					super.getSession().setAttribute("type", Constant.USER_MEMBER);
				}
			}else{
				super.getSession().setAttribute("type", Constant.USER_MEMBER);
			}
			cr.setResponseType(ResponseType.SUCCESS);
			cr.setInfo("登录成功。");
		} catch(Exception e) {
			log.error("登录异常：", e);
			cr.setResponseType(ResponseType.ERROR, "登录异常，请联系管理员。");
		}
		return cr;
	}
	/**
	 * 校验密码是否正确
	 * @param response
	 * @param userName
	 * @param password
	 * @return
	 */
	@ValidateSession(validate=false)
	@RequestMapping(value="/validePassword", method={ RequestMethod.POST })
	@ResponseBody
	public ControllerResponse validePassword(HttpServletResponse response,@RequestParam("userName")String userName, @RequestParam("password")String password) {
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if(!StringUtils.isNotEmpty(userName) ||  !StringUtils.isNotEmpty(password)){
				cr.setInfo("参数错误");
				return cr;
			}
			UserVo userVo=new UserVo();
			userVo.setUserName(userName);
			List<UserVo> listUser=queryUserVoByCondition(userVo);
			if(CollectionUtils.isEmpty(listUser)){
				cr.setInfo(I18NUtils.getText("sys.client.login.wrong"));
				return cr;
			}
			UserVo user=listUser.get(0);
			String pwd=user.getPassword();
			String salt=user.getSalt();
			String pswd=SHA256Encrypt.encrypt(password+salt);
			if(!pswd .equals(pwd)){
				cr.setInfo(I18NUtils.getText("sys.client.login.wrong"));
				return cr;
			}
			cr.setResponseType(ResponseType.SUCCESS);
		} catch(Exception e) {
			log.error("查询密码异常：", e);
			cr.setResponseType(ResponseType.ERROR, "查询密码异常。");
		}
		return cr;
	}
	
	@RequestMapping(value="/logout.htm")
	public String logout() {
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			HttpSession session = super.getSession();
			final String sessionID = session.getId();
			session.invalidate();
			RedisCache.del(new String[]{ SystemConst.USER_SESSION_KEY, SystemConst.USER_SESSION_KEY + sessionID });
		}
		return "index";
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
		ResBody result = TradeInvokeUtils.invoke("MemberManagement", map);
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
	 * 根据用户信息查询企业信息
	 * 
	 * @param request
	 * @param parameters
	 *            企业查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/queryEnterpriseByCondition")
	@ResponseBody
	public List<EnterpriseVo> queryEnterpriseByCondition(EnterpriseVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo());
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<EnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				enterpriseList = JsonUtils.toList(resultJson, EnterpriseVo.class);
				super.log.info("根据条件查询企业调用queryEnterpriseByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return enterpriseList;
	}
	
	/**
	 * 
	 * @param
	 * @return 友情链接
	 * @throws
	 */
	public static List<FriendlyLinkVo> friendlyLink(){
		PageVo<FriendlyLinkVo> pageVo = new PageVo<>();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", pageVo);
		map.put("sign", "queryLinkByPage");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FriendlyLinkmanagement", map);					
		List<FriendlyLinkVo> friendlyLinkVoList=new ArrayList<FriendlyLinkVo>();
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				pageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				friendlyLinkVoList=JsonUtils.toList(records,FriendlyLinkVo.class);
			}			
		}
 		//在页面只显示三个友情链接
 		List<FriendlyLinkVo> list = new ArrayList<>();
 		for (FriendlyLinkVo friendlyLinkVo : friendlyLinkVoList) {
			if (friendlyLinkVo.getIsShow() == 1) {
				list.add(friendlyLinkVo);
			}
		}
 		if (list != null && list.size() > 3) {
			list = list.subList(0, 3);
		}
		return list;
	}
	
}
