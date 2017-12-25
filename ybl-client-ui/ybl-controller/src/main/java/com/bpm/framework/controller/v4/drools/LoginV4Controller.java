package com.bpm.framework.controller.v4.drools;

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
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.security.SHA256Encrypt;

import cn.sunline.framework.controller.vo.NewsVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.UserLoginLogVo;
import cn.sunline.framework.controller.vo.v2.V2MemberVo;
import cn.sunline.framework.controller.vo.v2.V2MenuVo;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_STATUS;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_TYPE;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_ISADMIN;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理4.0用户端登录控制器
 */
@Controller
@RequestMapping({ "/loginV4Controller" })
@ValidateSession(validate = false)
public class LoginV4Controller extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;

	@ValidateSession(validate = false)
	@RequestMapping(value = "/login.htm", method = { RequestMethod.GET })
	public String login() {
		return "ybl4.0/admin/doorl/login";
	}
	
	/**
	 * 门户端首页
	 * @return
	 */
	@RequestMapping(value="/index.htm")
	public String toIndex(){
		//行业动态新闻资讯展示
		Map<String,Object> newsMap = new HashMap<String,Object>();
		NewsVo newsVo2 = new NewsVo();
 		//只显示平台已发布的新闻资讯,并且是以推荐的
		newsVo2.setRecommend(1);  //已推荐
		newsVo2.setStatus("released"); //发布状态
 		newsMap.put("paramter", newsVo2);
 		newsMap.put("sign", "queryNewsByCondition");//所调用的服务中的方法		
		ResBody newsResult = TradeInvokeUtils.invoke("NewsManagement", newsMap);					
		List<NewsVo> newsList=null;
 		if(newsResult.getSys()!=null){
			String status = newsResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) newsResult.getOutput();
				String records = output.getString("result");
				newsList=JsonUtils.toList(records,NewsVo.class);
				ControllerUtils.getRequest().setAttribute("newsList", newsList);
			}			
		}
		
		/*//查询融资方入驻数量
		V4BusinessAuthVO authVO = new V4BusinessAuthVO();
		authVO.setAuthType(1);
		authVO.setAuthStatus(2);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", authVO);
		map.put("sign", "queryIndexInfo");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("V4IndexInfoManagement", map);
		List<V4BusinessAuthVO> list=null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				list=JsonUtils.toList(records,V4BusinessAuthVO.class);
				ControllerUtils.getRequest().setAttribute("supplier", list.size());
			}			
		}
 		//查询资金方入驻数量
 		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
 		businessAuthVO.setAuthType(2);
 		businessAuthVO.setAuthStatus(2);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", businessAuthVO);
		maps.put("sign", "queryIndexInfo");//所调用的服务中的方法		
		ResBody results = TradeInvokeUtils.invoke("V4IndexInfoManagement", maps);
		List<V4BusinessAuthVO> lists=null;
 		if(results.getSys()!=null){
			String status = results.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				lists=JsonUtils.toList(records,V4BusinessAuthVO.class);
				ControllerUtils.getRequest().setAttribute("factor", lists.size());
			}			
		}*/
		return "ybl4.0/admin/doorl/index";
	}
	
	/**
	 * @Description:门户端页面业务介绍页面
	 * @return 门户端页面业务介绍页面
	 */
	@RequestMapping(value="/businessIntroduction.htm")
	public String toBusinessIntroduction(){
		return "ybl4.0/admin/doorl/BusinessIntroduction";
	}
	
	/**
	 * @Description:关于我们页面（包括公司简介、发展历程、团队介绍）
	 * @param page
	 * @return 4.0关于我们页面
	 */
	@RequestMapping(value="/toAboutUs.htm")
	public String toAboutUs(PageVo page){
		companyIntroduction("index");
		//设置step为了控制页面导航时菜单样式问题
		ControllerUtils.getRequest().getParameter("step");
		ControllerUtils.getRequest().setAttribute("step", 3);
		return "ybl4.0/admin/aboutUs/aboutUs";
	}
	
	/**
	 * @Description:关于我们页面（公司简介）
	 * @return 4.0关于我们公司简介页面
	 */
	@RequestMapping("companyIntroduction")
	public String companyIntroduction(@RequestParam(required=false) String position){
		return "ybl4.0/admin/aboutUs/companyIntroduction";
	}
	
	/**
	 * 跳转登录页面
	 * @return
	 */
	@RequestMapping(value = "/toLogin.htm")
	public String toLogin(){
		return "ybl4.0/admin/doorl/login";
		
	}
	
	/**
	 * 跳转注册页面
	 * @return
	 */
	@RequestMapping(value = "/toRegister.htm")
	public String toRegister(){
		return "ybl4.0/admin/doorl/register";
		
	}
	
	/**
	 * 跳转忘记密码页面 
	 * @return
	 */
	@RequestMapping(value = "/toForgetPassword.htm")
	public String toForgetPassword(){
		return "ybl4.0/admin/doorl/forgetPassword";
		
	}
	
	/**
	 * 登录
	 * @param response
	 * @param userName  手机号用户
	 * @param password	密码
	 * @param authType	登录端口1.融资方 2.资金方 3.核心企业 4.门户端
	 * @return
	 */
	@ValidateSession(validate = false)
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	@ResponseBody
	@Log(operation=OperationType.Login, info="登录")
	public ControllerResponse login(HttpServletResponse response,@RequestParam("userName")String userName, @RequestParam("password")String password,int authType) {		
		final ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
		try {
			if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
				cr.setInfo("参数错误");
				return cr;
			}
			
			V2MemberVo V2MemberVo=new V2MemberVo();			
			V2MemberVo.setUsername(userName);
			List<V2MemberVo> listUser = queryV2MemberVoByCondition(V2MemberVo); //根据用户名查询当前登录用户
			if (CollectionUtils.isEmpty(listUser)) {//用户不存在
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			V2MemberVo member = listUser.get(0);
			if (!"normal".equals(member.getStatus())) {//判断账号是否正常
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.status.wrong"));
				return cr;
			}
			String pwd = member.getPassword();
			String salt = member.getSalt();
			String pswd = SHA256Encrypt.encrypt(password + salt);
			if (!pswd.equals(pwd)) {//密码校验
				cr.setInfo(I18NUtils.getText("sys.v2.client.login.wrong"));
				return cr;
			}
			// 将2.0版本的V2MemberVo转成1.0的UserVo(减少改动)
			UserVo user = parseMemberToUser(member);
			
			//登录时进行端口访问判断
			if(authType == E_V4_AUTH_TYPE.MEMBER.getStatus()) {// 访客登录访问
				user.setStatus("member");
			}else{//会员认证后登录访问
				if(user.getEnterpriseId() == 0){
					cr.setResponseType(ResponseType.ERROR, "该用户尚未通过角色业务认证！");
	 				return cr;
				}
				V4BusinessAuthVO parameters = new V4BusinessAuthVO();
				parameters.setEnterpriseId(user.getEnterpriseId());
				parameters.setAuthType(authType);    //端口访问1-融资方2-资金方3-核心企业
				V4BusinessAuthVO V4BusinessAuthVO = queryBusinessAuthByCondition(parameters);
				if (V4BusinessAuthVO != null && V4BusinessAuthVO.getAuthStatus() != null){//通过过业务认证请求
					if(V4BusinessAuthVO.getAuthStatus() == E_V4_AUTH_STATUS.AUDITSUCCESS.getStatus()){ //平台业务认证审核成功
						user.setBusinessId(V4BusinessAuthVO.getId());
						if(authType == E_V4_AUTH_TYPE.FINANCINGPARTY.getStatus()){
							user.setStatus("supplier"); //回调参数为融资方端口
							user.setType("financing");  //融资方类型
						}else if(authType == E_V4_AUTH_TYPE.FUNDSIDE.getStatus()){
							user.setStatus("financil"); //回调参数为资金方端口
							user.setType("fund");  //资金方类型
						}else{
							user.setStatus("enterprise"); //回调参数为核心企业方端口
							user.setType("enterprise");  //核心企业方类型
						}
					}else{
						cr.setResponseType(ResponseType.ERROR, "该用户没有通过当前角色认证！");
		 				return cr;
					}
	 			}else{
	 				cr.setResponseType(ResponseType.ERROR, "该用户尚未进行业务认证！");
	 				return cr;
	 			}
			}
			
			
			// 登陆成功用户信息存到session中
			HttpSession session = getSession();
			session.setAttribute(SystemConst.USER_SESSION_KEY, user);

			// 把用户信息存到redis中
			RedisCache.set(SystemConst.USER_SESSION_KEY + session.getId(), user);

			//子账号登录页面菜单页面加载控制
			if(user.getIsAdmin() == 0){
				String resultJson = queryAllMenuByRole(user.getType());
				List<V2MenuVo> menuList = JsonUtils.toList(resultJson, V2MenuVo.class);
				if(menuList.size() > 0) {
					V2MenuVo menuVo = menuList.get(0);
					user.setAttribute3(menuVo.getLink());
					for(V2MenuVo menu : menuList){
						if(menuVo.getId().equals(menu.getParentId())){
							user.setAttribute3(menu.getLink());
							break;
						}
					}
				}
			}
			
			//登录成功  将当前用户拥有的菜单信息存到session
			//List<V2MenuVo> menuList = queryAllMenuByRole();
			getSession().setAttribute(Constant.USER_MENU, queryAllMenuByRole(user.getType()));
			
			/*登录成功，新增登录日志信息*/
			//setUserLoginLog();
			cr.setResponseType(ResponseType.SUCCESS);
			cr.setObject(user);
			cr.setInfo("登录成功。");
		} catch (Exception e) {
			log.error("登录异常：", e);
			cr.setResponseType(ResponseType.ERROR, "登录异常，请联系管理员。");
		}
		return cr;
	}
	
	/**
	 * 退出登录
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException{
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			HttpSession session = getRequest().getSession();
			final String sessionID = session.getId();
			session.removeAttribute(SystemConst.USER_SESSION_KEY);
			if(RedisCache.exists(SystemConst.USER_SESSION_KEY + sessionID)){ //值判断是否存在
				RedisCache.del(SystemConst.USER_SESSION_KEY + sessionID);
			}
			//删除登录用户的菜单session
			session.removeAttribute(Constant.USER_MENU);
		}
		response.sendRedirect("/loginV4Controller/index.htm");
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
			List<UserVo> listUser=queryUserVoByCondition(userVo);//通过用户名查询当前用户
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
	
	/**
	 * 根据条件查询用户信息
	 * @param userVo
	 * @return
	 */
	private List<UserVo> queryUserVoByCondition(UserVo userVo){
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
	 * 根据条件查询用户信息
	 * @param V2MemberVo
	 * @return
	 */
	private List<V2MemberVo> queryV2MemberVoByCondition(V2MemberVo V2MemberVo) {
		Map<String, Object> map = new HashMap<String, Object>();
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
	 * 根据用户信息查询企业信息
	 * @param request
	 * @param parameter
	 * @return
	 */
	private V4BusinessAuthVO  queryBusinessAuthByCondition(V4BusinessAuthVO paramter) {
		paramter.setEnable(1);//数据可用
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", paramter);
		map.put("sign", "queryBusinessAuthByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2EnterprisesManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		V4BusinessAuthVO V4BusinessAuthVO = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject results = output.getJSONObject("result");
				String resultJson = results.getString("result");
				V4BusinessAuthVO = JsonUtils.toObject(resultJson, V4BusinessAuthVO.class);
				super.log.info("根据条件查询企业调用queryBusinessAuthByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询企业调用queryBusinessAuthByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return V4BusinessAuthVO;
	}
	
	
	//查询当前用户的拥有菜单
	
	 private String queryAllMenuByRole(String type){
	    	UserVo user =  ControllerUtils.getCurrentUser();
	    	List<V2MenuVo> menuList = new ArrayList<V2MenuVo>();
	    	//如果是企业管理员  则能看到所有的菜单
	    	if(user.getIsAdmin() == E_V4_ISADMIN.ISADMIN.getStatus()){
	    		Map<String,Object> map = new HashMap<String,Object>();
	    		V2MenuVo menu = new V2MenuVo();
	    		menu.setParentId(-1L);
	    		//menu.setEnterpriseId(user.getEnterpriseId());
	    		menu.setRoleType(type); //加载所属角色端口菜单类型
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
	
		 
	 /**
		 * 新增登录日志
		 * 
		 */
		/*private void setUserLoginLog() {
			UserVo user = ControllerUtils.getCurrentUser();
			UserLoginLogVo log = new UserLoginLogVo();
			 获取登录ip 
			String ip = LogAddressCommon.getAddress();
			log.setLoginIp(ip);
			log.setEnable(1);
			log.setSign("");
			log.setLoginTime(DateUtils.now());
			 获取当前操作设备的操作系统 
			Properties props = System.getProperties();
			if (props != null) {
				String operatorSystem = props.getProperty("os.name");
				log.setOperatorSystem(operatorSystem);
			}
			 获取当前操作设备的操作终端 
			String operatorTerminal = "pc";
			boolean isMoblie =LogAddressCommon.isRealMobile(getRequest());
			if(isMoblie){
				operatorTerminal="移动客户端";
			}
			log.setOperatorTerminal(operatorTerminal);
			 设置基本信息 
			ControllerUtils.setWho(log);
			 当前登录人的信息 
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
		}*/	 
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
		if(StringUtils.isNotEmpty(member.getAttribute1())){
			user.setAttribute1(member.getAttribute1());   //身份认证状态
		}
		if(StringUtils.isNotEmpty(member.getAttribute2())){
			user.setAttribute2(member.getAttribute2());  //业务认证状态
		}
		user.setEmail(member.getEmail());
		user.setEnable(member.getEnable());
		user.setEnterpriseId(member.getEnterpriseId());
		user.setGender(member.getSex());
		user.setIsAdmin(member.getIsAdmin());
		user.setType(member.getType());
		return user;
	}
}
