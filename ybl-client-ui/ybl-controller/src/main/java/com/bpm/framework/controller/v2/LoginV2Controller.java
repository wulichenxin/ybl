package com.bpm.framework.controller.v2;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.LogAddressCommon;
import com.bpm.framework.image.CaptchaServiceSingleton;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.security.SHA256Encrypt;

import cn.sunline.framework.controller.vo.FriendlyLinkVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.UserLoginLogVo;
import cn.sunline.framework.controller.vo.v2.V2EnterpriseVo;
import cn.sunline.framework.controller.vo.v2.V2MemberVo;
import cn.sunline.framework.controller.vo.v2.V2MenuVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理2.0用户端登录控制器
 * 
 * @author jzx
 *
 */
@Controller
@RequestMapping({ "/loginV2Controller" })
public class LoginV2Controller extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;

	@ValidateSession(validate = false)
	@RequestMapping(value = "/login.htm", method = { RequestMethod.GET })
	public String login() {
		return "ybl/v2/admin/index/login";
	}

	/**
	 * 退出
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserVo user = ControllerUtils.getCurrentUser();
		if (null != user) {
			HttpSession session = getRequest().getSession();
			final String sessionID = session.getId();
			//(1)删除登录用户的session
			session.removeAttribute(SystemConst.USER_SESSION_KEY);
			RedisCache.del(SystemConst.USER_SESSION_KEY + sessionID);
			getSession().removeAttribute("type");
			//(2)删除登录用户的菜单session
			session.removeAttribute(Constant.USER_MENU);
		}
		response.sendRedirect("/loginV2Controller/login.htm");
	}
	
	@ValidateSession(validate = false)
	@RequestMapping(value = "/checkPassword", method = { RequestMethod.POST })
	@ResponseBody
	public ControllerResponse checkPassword(HttpServletResponse response,@RequestParam("userName")String userName) {		
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if (StringUtils.isEmpty(userName)) {
				cr.setInfo("参数错误");
				return cr;
			}
			
			V2MemberVo V2MemberVo=new V2MemberVo();			
			V2MemberVo.setUsername(userName);
			List<V2MemberVo> listUser = queryV2MemberVoByCondition(V2MemberVo);
			if (CollectionUtils.isEmpty(listUser)) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			V2MemberVo member = listUser.get(0);
			String salt = member.getSalt();
			
			cr.setResponseType(ResponseType.SUCCESS);
			cr.setObject(salt);
		} catch (Exception e) {
			cr.setResponseType(ResponseType.ERROR, "登录异常，请联系管理员。");
		}
		return cr;
	}

	@ValidateSession(validate = false)
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	@ResponseBody
	@Log(operation=OperationType.Login, info="登录")
	public ControllerResponse login(HttpServletResponse response,@RequestParam("userName")String userName, @RequestParam("password")String password,@RequestParam("code")String code) {		
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
				cr.setInfo("参数错误");
				return cr;
			}
			
			Boolean flag = CaptchaServiceSingleton.getInstance().validateResponseForID(ControllerUtils.getSession().getId(),code);
			if(!flag) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.code"));
				return cr;
			}
			V2MemberVo V2MemberVo=new V2MemberVo();			V2MemberVo.setUsername(userName);
			List<V2MemberVo> listUser = queryV2MemberVoByCondition(V2MemberVo);
			if (CollectionUtils.isEmpty(listUser)) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			V2MemberVo member = listUser.get(0);
			if (!"normal".equals(member.getStatus())) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.status.wrong"));
				return cr;
			}
			String pwd = member.getPassword();
			String salt = member.getSalt();
			String pswd = SHA256Encrypt.encrypt(password + salt);
			if (!pswd.equals(pwd)) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			// 将2.0版本的V2MemberVo转成1.0的UserVo(减少改动)
			UserVo user = parseMemberToUser(member);
			// 登陆成功用户信息存到session中
			HttpSession session = getSession();
			session.setAttribute(SystemConst.USER_SESSION_KEY, user);

			// 把用户信息存到redis中
			RedisCache.set(SystemConst.USER_SESSION_KEY + session.getId(), user);
			
//			V4BusinessAuthVO paramter = new V4BusinessAuthVO();
//			paramter.setEnterprise_id(user.getEnterpriseId());
//			List<V4BusinessAuthVO> V4BusinessAuthVOList = queryEnterpriseByCondition(paramter);
 			 
			// 把用户认证角色存到session中(必须查询是否角色认证通过，不通过则还是原始类型)
			V2EnterpriseVo parameters = new V2EnterpriseVo();
			parameters.setId(member.getEnterpriseId());
			List<V2EnterpriseVo> enterpriseList = queryEnterpriseByCondition(parameters);
			if (CollectionUtils.isNotEmpty(enterpriseList)) {
				parameters = enterpriseList.get(0);
				if (parameters != null && parameters.getId() > 0) {
					getSession().setAttribute("type", parameters.getType());
				}
			}
			
			//登录成功  将当前用户拥有的菜单信息存到session
			//List<V2MenuVo> menuList = queryAllMenuByRole();
			getSession().setAttribute(Constant.USER_MENU, queryAllMenuByRole());
			
			
			/*登录成功，新增登录日志信息*/
			setUserLoginLog();
			cr.setResponseType(ResponseType.SUCCESS);
			cr.setObject(parameters);
			cr.setInfo("登录成功。");
		} catch (Exception e) {
			log.error("登录异常：", e);
			cr.setResponseType(ResponseType.ERROR, "登录异常，请联系管理员。");
		}
		return cr;
	}

	/**
	 * 校验密码是否正确
	 * 
	 * @param response
	 * @param userName
	 * @param password
	 * @return
	 */
	@ValidateSession(validate = false)
	@RequestMapping(value = "/validePassword", method = { RequestMethod.POST })
	@ResponseBody
	public ControllerResponse validePassword(HttpServletResponse response, @RequestParam("userName") String userName,
			@RequestParam("password") String password) {
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if (!StringUtils.isNotEmpty(userName) || !StringUtils.isNotEmpty(password)) {
				cr.setInfo("参数错误");
				return cr;
			}
			V2MemberVo V2MemberVo = new V2MemberVo();
			V2MemberVo.setUsername(userName);
			List<V2MemberVo> listUser = queryV2MemberVoByCondition(V2MemberVo);
			if (CollectionUtils.isEmpty(listUser)) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			V2MemberVo user = listUser.get(0);
			String pwd = user.getPassword();
			String salt = user.getSalt();
			String pswd = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(password) + salt);
			if (!pswd.equals(pwd)) {
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			cr.setResponseType(ResponseType.SUCCESS);
		} catch (Exception e) {
			log.error("查询密码异常：", e);
			cr.setResponseType(ResponseType.ERROR, "查询密码异常。");
		}
		return cr;
	}

	@RequestMapping(value = "/logout.htm")
	public String logout() {
		UserVo user = ControllerUtils.getCurrentUser();
		if (null != user) {
			HttpSession session = super.getSession();
			final String sessionID = session.getId();
			session.invalidate();
			RedisCache.del(new String[] { SystemConst.USER_SESSION_KEY, SystemConst.USER_SESSION_KEY + sessionID });
		}
		return "index";
	}

	/**
	 * 根据条件查询用户信息
	 * 
	 * @param V2MemberVo
	 * @return
	 */
	private List<V2MemberVo> queryV2MemberVoByCondition(V2MemberVo V2MemberVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		V2MemberVo.setIsAdmin(0L);// 前台查询非管理员用户
		map.put("paramter", V2MemberVo);
		map.put("sign", "queryMemberByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2MembersManagement", map);
		List<V2MemberVo> userList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				userList = JsonUtils.toList(records, V2MemberVo.class);
			}
		}
		return userList;
	}

	/**
	 * 根据类型和代码查询基础数据类型
	 * 
	 * @param request
	 * @param response
	 * @param type
	 *            类型
	 * @param code
	 *            代码
	 * @return
	 */
	@RequestMapping({ "getMemberById-{id}" })
	@ResponseBody
	public V2MemberVo getMemberById(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("id") Long id) {
		V2MemberVo member = new V2MemberVo();
		member.setId(id);
		List<V2MemberVo> memberList = queryV2MemberVoByCondition(member);
		if (CollectionUtils.isNotEmpty(memberList)) {
			member = memberList.get(0);
		}
		return member;
	}

	/**
	 * 根据用户信息查询企业信息
	 * 
	 * @param request
	 * @param parameters
	 *            企业查询条件
	 * @return
	 */
	private List<V2EnterpriseVo> queryEnterpriseByCondition(V2EnterpriseVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2EnterprisesManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<V2EnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				enterpriseList = JsonUtils.toList(resultJson, V2EnterpriseVo.class);
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
	 * @param @return 友情链接 @throws
	 */
	public static List<FriendlyLinkVo> friendlyLink() {
		PageVo<FriendlyLinkVo> pageVo = new PageVo<>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", pageVo);
		map.put("sign", "queryLinkByPage");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FriendlyLinkmanagement", map);
		List<FriendlyLinkVo> friendlyLinkVoList = new ArrayList<>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				friendlyLinkVoList = JsonUtils.toList(records, FriendlyLinkVo.class);
			}
		}
		// 在页面只显示三个友情链接
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

	/**
	 * 将2.0版本的V2MemberVo转成1.0的UserVo
	 * 
	 */
	private UserVo parseMemberToUser(V2MemberVo member) {
		UserVo user = new UserVo();
		user.setUserName(member.getUsername());
		user.setNickName(member.getNickname());
		user.setRealName(member.getRealname());
		user.setTelephone(member.getTelephone());
		user.setStatus(member.getStatus());
		user.setSign(member.getSign());
		user.setSalt(member.getSalt());
		user.setRegisterTime(member.getRegisterTime());
		if (member.getPreLoginTime() != null) {
			user.setPreLoginTime(member.getPreLoginTime().toLocaleString());
		}
		user.setPreLoginAddress(member.getPreLoginAddress());
		user.setPassword(member.getPassword());
		user.setLevel(member.getLevel());
		user.setLastUpdateTime(member.getLastUpdateTime());
		user.setLastUpdateBy(member.getLastUpdateBy());
		user.setId(member.getId());
		user.setCreatedBy(member.getCreatedBy());
		user.setCreatedTime(member.getCreatedTime());
		if (StringUtils.isNotEmpty(member.getDepartment())) {
			user.setDeptId(Long.valueOf(member.getDepartment()));
		}
		user.setEmail(member.getEmail());
		user.setEnable(member.getEnable());
		user.setEnterpriseId(member.getEnterpriseId());
		user.setGender(member.getSex());
		user.setIsAdmin(member.getIsAdmin());
		user.setType(member.getType());
		//短信验证码存放
		user.setAttribute10(member.getAttribute10());
		return user;
	}

	/**
	 * 新增登录日志
	 * 
	 */
	private void setUserLoginLog() {
		UserVo user = ControllerUtils.getCurrentUser();
		UserLoginLogVo log = new UserLoginLogVo();
		/* 获取登录ip */
		String ip = LogAddressCommon.getAddress();
		log.setLoginIp(ip);
		log.setEnable(1);
		log.setSign("");
		log.setLoginTime(DateUtils.now());
		/* 获取当前操作设备的操作系统 */
		Properties props = System.getProperties();
		if (props != null) {
			String operatorSystem = props.getProperty("os.name");
			log.setOperatorSystem(operatorSystem);
		}
		/* 获取当前操作设备的操作终端 */
		String operatorTerminal = "pc";
		boolean isMoblie =LogAddressCommon.isRealMobile(getRequest());
		if(isMoblie){
			operatorTerminal="移动客户端";
		}
		log.setOperatorTerminal(operatorTerminal);
		/* 设置基本信息 */
		ControllerUtils.setWho(log);
		/* 当前登录人的信息 */
		log.setUserId(user.getId());
		log.setUserName(user.getUserName());
		log.setEnterpriseId(user.getEnterpriseId());
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", log);
		map.put("sign", "addUserLoginLog");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("UserLoginLogsManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("新增登录信息addUserLoginLog服务返回成功，信息：" + erortx);
			} else {
				super.log.error("新增登录信息addUserLoginLog服务返回失败，信息：" + erortx);
			}
		}
	}
	
	
	
	//查询当前用户的拥有菜单
	
	 private String queryAllMenuByRole(){
	    	UserVo user =  ControllerUtils.getCurrentUser();
	    	List<V2MenuVo> menuList = new ArrayList<V2MenuVo>();
	    	//如果是企业管理员  则能看到所有的菜单
	    	if("1".equals(user.getAttribute1())){
	    		Map<String,Object> map = new HashMap<String,Object>();
	    		V2MenuVo menu = new V2MenuVo();
	    		menu.setParentId(-1L);
	    		menu.setEnterpriseId(user.getEnterpriseId());
	    		map.put("paramter",menu);
	    		map.put("sign", "queryMenuByCondition");
	    		ResBody result =  TradeInvokeUtils.invoke("V2MenuManagement", map);
	    		if (result != null) {	
	    			if (result.getSys() != null) {
	    				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
	    				String erortx = result.getSys().getErortx();// 错误信息
	    				if ("S".equals(status)) {// 交易成功
	    					JSONObject output = (JSONObject)result.getOutput();
	    					String resultJson = output.getString("result");
	    					menuList= JsonUtils.toList(resultJson, V2MenuVo.class);
	    					return resultJson;
	    				}
	    			}
	    		}
	    	}else{//如果不是管理员，则根据当前用户的角色来加载菜单
	    		  //(1)查询当前用户查询拥有的一级菜单权限
	    		Map<String,Object> condition = new HashMap<String,Object>();
	    		condition.put("paramter",user);
	    		condition.put("sign", "queryMenuByMemberId");
	    		ResBody result =  TradeInvokeUtils.invoke("V2MenuManagement", condition);
	    		if (result != null) {
	    			if (result.getSys() != null) {
	    				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
	    				String erortx = result.getSys().getErortx();// 错误信息
	    				if ("S".equals(status)) {// 交易成功
	    					JSONObject output = (JSONObject)result.getOutput();
	    					String resultJson = output.getString("result");
	    					menuList= JsonUtils.toList(resultJson, V2MenuVo.class);
	    					return resultJson;
	    				}
	    			}
	    		}
	    	}
	    	return null;
	    }
}
