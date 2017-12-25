package com.bpm.framework.controller.accountCenter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.login.ValidCodeUtil;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;
import com.bpm.framework.utils.security.SHA256Encrypt;
import com.bpm.framework.utils.security.SaltGenerator;

import cn.sunline.framework.controller.vo.DepartmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 用户controller
 * 
 * @author MaiBenBen
 * 
 */
@Controller
@RequestMapping({ "/UserController" })
public class UserController extends AbstractController {

	private static final long serialVersionUID = -5501612350731781456L;

	/**
	 * 编辑页面跳转，并加载数据
	 * 
	 * @param request
	 * @param id
	 *            用户id
	 * @return
	 */
	@RequestMapping("operator/{operatorId}")
	public String editMember(HttpServletRequest request, @PathVariable String operatorId, String userName) {
		if (operatorId.equals("addMember")) {
			return "ybl/admin/factor/user/employeeEdit";
		} else if (operatorId.equals("editMember")) {
			UserVo userVo = new UserVo();
			userVo.setUserName(userName);
			// TODO 这里没必要再查一次后台，可以把数据从前台传过来。
			List<UserVo> memberByCondition = queryMemberByCondition(userVo);

			// (3)调用服务，查询该用户所属部门
			Long deptId = memberByCondition.get(0).getDeptId();
			if (deptId != null) {
				DepartmentVo dept = new DepartmentVo();
				dept.setId(deptId);
				List<DepartmentVo> departmentList = getDepartmentList(dept);
				if(departmentList.size() > 0){
					getRequest().setAttribute("dept", departmentList.get(0));	
				}
			}

			getRequest().setAttribute("memberInfo", memberByCondition.get(0));
			return "ybl/admin/factor/user/employeeEdit";
		}
		return null;
	}

	/**
	 * 根据用户信息查询用户
	 * 
	 * @param request
	 * @param parameters
	 *            用户查询条件
	 * @return userList 用户对象集合
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/queryMemberByCondition")
	@ResponseBody
	public List<UserVo> queryMemberByCondition(UserVo parameters) {
		//用户只能查询自己企业下的用户
		parameters.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		PageVo<UserVo> pageVo = new PageVo<>();
		map.put("page", pageVo);
		map.put("sign", "queryMemberByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("MemberManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<UserVo> userList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				userList = JsonUtils.toList(resultJson, UserVo.class);
				String page = output.getString("page");
				pageVo = JsonUtils.toObject(page, PageVo.class);
				super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息：" + erortx);
				getRequest().setAttribute("page", pageVo);
			} else {
				super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return userList;
	}

	/**
	 * 查询所有用户信息集合
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryAllMember")
	@ResponseBody
	public ControllerResponse queryAllMember() {
		ControllerResponse response = new ControllerResponse(ResponseType.SUCCESS);
		Map<String, Object> map = new HashMap<String, Object>();
		// 调用服务，进行数据更新
		map.put("paramter", "");
		map.put("sign", "queryAllMember");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("MemberManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<UserVo> userList = null;
		if (sys != null) {
			String status = sys.getString("status");
			String erortx = sys.getString("erortx");// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				userList = (List<UserVo>) JSONArray.parseArray(resultJson, UserVo.class);
				response.setInfo(I18NUtils.getText("sys.client.query.success"));//查询用户集合信息成功！
				super.log.info("查询所有用户调用queryAllMember服务成功，信息：" + erortx);
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.client.query.fail"));//查询用户集合信息失败！
				super.log.error("查询所有用户调用queryAllMember服务失败，信息：" + erortx);
			}
		}
		// 设置结果
		response.setObject(userList);
		return response;
	}

	/**
	 * 查询单个用户
	 * 
	 * @param user
	 *            查询条件对象
	 * @return userVo 符合条件的对象
	 */
	@RequestMapping({ "/findUserById" })
	@ResponseBody
	public UserVo findUserById(UserVo user) {
		UserVo userVo = null;
		// 调用服务，查询用户列表数据
		List<UserVo> userList = queryMemberByCondition(user);
		if (CollectionUtils.isNotEmpty(userList)) {
			userVo = userList.get(0);
		}
		return userVo;
	}

	/**
	 * 根据认证角色查询所有用户
	 * 
	 * @param user
	 *            查询条件对象
	 * @return 跳转页面
	 */
	@RequestMapping({ "/findUsersByCertRole" })
	public String findUsersByCertRole(UserVo user) {
		// 调用服务，查询用户列表数据
		List<UserVo> userList = queryMemberByCondition(user);
		getRequest().setAttribute("userList", userList);
		return "ybl/admin/factor/user/employeeManage";
	}

	@RequestMapping({ "/loadUsersByCertRoleData" })
	public String loadUsersByCertRoleData(UserVo user) {
		// 调用服务，查询用户列表数据
		List<UserVo> userList = queryMemberByCondition(user);
		getRequest().setAttribute("userList", userList);
		return "ybl/admin/factor/user/employeeManageTable";
	}

	/**
	 * 保存或者新增用户信息 @param @return @throws
	 */
	@RequestMapping(value = "/addOrUpdateUser")
	@ResponseBody
	public ControllerResponse addOrUpdateUser(HttpServletRequest request, UserVo memberInfo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断是否有数据
		if (memberInfo == null) {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			super.log.error("保存/编辑用户数据对象不能为空！");
			return response;
		}
		// (2)判断必要参数
		if (StringUtils.isEmpty(memberInfo.getUserName()) || memberInfo.getDeptId() == null) {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			super.log.error("用户登录名和部门不能为空");
			return response;
		}
		// (3)新增/编辑操作
		Long userId = memberInfo.getId();
		ControllerUtils.setWho(memberInfo);// 设置时间、操作人
		memberInfo.setEnable(1);// 设置有效字段（0：否，1：是）
		memberInfo.setSign("");// 设置签名字段
		Object result = null;
		// 如果密码填写了，则设置默认密码
		if (!StringUtils.isEmpty(memberInfo.getPassword())) {
			String salt = SaltGenerator.generator();
			memberInfo.setSalt(salt);
			String password = SHA256Encrypt.encrypt(SHA256Encrypt.encrypt(memberInfo.getPassword()) + salt);
			memberInfo.setPassword(password);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		String userName = memberInfo.getUserName();
		if (userId == null) { // 新增
			// (4)校验用户名是否存在（新增时需要判断）
			UserVo parameters = new UserVo();
			parameters.setUserName(userName);
			// 查询用户的方法（调用服务，得到用户数据集合）
			List<UserVo> userList = queryMemberByCondition(parameters);
			if (CollectionUtils.isNotEmpty(userList)) {// 若存在，则给出提示
				response.setInfo(I18NUtils.getText("sys.client.login.name")+"[" + userName + "]"+I18NUtils.getText("sys.client.already.used.please.change"));//登录名已被使用,请换一个用户名
				super.log.error("新增用户的登录名重复！");
				return response;
			}
			memberInfo.setRegisterTime(DateUtils.now());
			// TODO 这里添加用户，角色由当前用户的角色决定
			memberInfo.setCertRole(getSession().getAttribute("type").toString());
			memberInfo.setCertTime(DateUtils.now());
			//新增的时候给默认密码888888
			String salt = SaltGenerator.generator();
			memberInfo.setSalt(salt);
			String password = SHA256Encrypt.encrypt("888888" + salt);
			memberInfo.setPassword(password);
			memberInfo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			// (5)调用服务，进行数据保存
			map.put("paramter", memberInfo);
			map.put("sign", "insertMemberInfo");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("MemberManagement", map);
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		} else {// 编辑
				// (5)调用服务，进行数据更新
			map.put("paramter", memberInfo);
			map.put("sign", "saveMember");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("MemberManagement", map);
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		// (6)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(result);// 设置返回结果
					response.setInfo(I18NUtils.getText("sys.client.save.success"));// 设置返回的信息
					super.log.info("新增/编辑addUser/saveUser服务调用信息：" + erortx);
					
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.login.name")+"[" + userName + "]"+I18NUtils.getText("sys.client.already.used.please.change"));// 设置返回的信息
					super.log.error("新增/编辑addUser/saveUser服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		
		return response;
	}

	/**
	 * 查询所有部门信息集合
	 * 
	 * @param departmentVo
	 * @return
	 */
	@RequestMapping(value = "/getDepartmentList")
	@ResponseBody
	public List<DepartmentVo> getDepartmentList(DepartmentVo departmentVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		departmentVo.setEnable(1);// 查询有效的部门（0：否，1：是）
		// 调用服务，进行数据查询
		map.put("paramter", departmentVo);
		map.put("sign", "queryDeptByCondition");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<DepartmentVo> departList = null;
		if (sys != null) {
			String status = sys.getString("status");
			String erortx = sys.getString("erortx");// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				departList = (List<DepartmentVo>) JSONArray.parseArray(resultJson, DepartmentVo.class);
				super.log.info("查询所有部门调用  queryDeptByCondition 服务返回成功，信息：" + erortx);
			} else {
				super.log.error("查询所有部门调用  queryDeptByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		// 设置结果
		return departList;
	}

	/**
	 * 注销/启用/冻结用户信息(更新status)
	 * 
	 * @param request
	 * @param loginName
	 *            用户登录名
	 * @return
	 */
	@RequestMapping(value = "/UpdateUserStatus")
	public String UpdateUserStatus(HttpServletRequest request, String userName, String status, Long userid,
			int currentpage) {
		// (1)判断必要参数
		if (!(userName != null && userid != null)) {
			super.log.error("注销/启用/冻结参数loginName和id不能为空！");
			return "redirect:/UserController/findUsersByCertRole?certRole=factor";
		}
		// (2)查询用户是否存在
		UserVo param = new UserVo();
		param.setUserName(userName);
		List<UserVo> userList = queryMemberByCondition(param);
		if (CollectionUtils.isNotEmpty(userList)) {
			UserVo userVo = userList.get(0);
			userVo.setStatus(status);
			// (2)调用服务，进行数据注销/启用/冻结
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("paramter", userVo);
			map.put("sign", "saveMember");// 所调用的服务中的方法
			Object result = TradeInvokeUtils.invoke("MemberManagement", map);
			// (3)对调用服务后的返回数据进行解析
			if (result != null) {
				Map<String, Object> jsonMap = JsonUtils.toMap(result);
				JSONObject sys = (JSONObject) jsonMap.get("sys");
				if (sys != null) {
					String estatus = sys.getString("status");// 状态：'S'成功，'F'失败
					String erortx = sys.getString("erortx");// 错误信息
					if ("S".equals(estatus)) {// 交易成功
						super.log.info("注销/启用/冻结用户调用saveUser服务，信息：" + erortx);
					} else {
						super.log.error("注销/启用/冻结用户调用saveUser服务，信息：" + erortx);
					}
				}
			} else {
				super.log.error("调用服务失败！");
			}
		} else {
			super.log.error("注销/启用/冻结失败,记录不存在！");
		}
		return "redirect:/UserController/findUsersByCertRole?certRole=factor&currentpage=" + currentpage;
	}

	/**
	 * 根据会员id删除会员信息 支持批量删除
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteMemberByMemberId")
	@ResponseBody
	public ControllerResponse deleteMemberByMemberId(HttpServletRequest request, Long memberId[]) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Long> asList = Arrays.asList(memberId);
		List<Long> failList = new ArrayList<>();
		UserVo userVo = (UserVo)getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		//用户不能删除自己
		for (Long _memberId : memberId) {
			if (_memberId.equals(userVo.getId())) {
				response.setInfo("不用删除自己！");
				return response;
			}
		}
//		for (Long _memberId : asList) {
			// 支持批量删除
			map.put("paramter", memberId);
//			map.put("paramter", _memberId);
			map.put("sign", "deleteMemberByMemberId");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("MemberManagement", map);
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					super.log.info("删除友情链接调用deleteMemberByMemberId服务成功，信息：" + erortx);
				} else {
//					failList.add(_memberId);
//					super.log.error("删除友情链接失败，信息：" + _memberId);
					super.log.error("删除友情链接deleteMemberByMemberId服务失败，信息：" + erortx);
				}
			}
//		}
		if (failList.size() >= asList.size()) {
			response.setResponseType(ResponseType.FAILURE);
			response.setInfo(I18NUtils.getText("sys.client.delete.fail"));// 删除失败
		} else {
			response.setResponseType(ResponseType.SUCCESS_DELETE);
			response.setInfo(I18NUtils.getText("sys.client.delete.success"));// 删除成功
		}
		return response;
	}

	/**
	 * 更新用户密码 @param @return @throws
	 */
	@RequestMapping(value = "/updatePassword")
	@ResponseBody
	public ControllerResponse updatePassword(HttpServletRequest request, Long memberId, String password) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo userVo = new UserVo();
		userVo.setId(memberId);
		userVo = findUserById(userVo);
		userVo.setPassword(password);
		response = addOrUpdateUser(request, userVo);
		return response;
	}

	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @param user
	 *            用户对象
	 * @return
	 */
	@RequestMapping(value = "/updateUser")
	@ResponseBody
	public ControllerResponse updateUser(UserVo user) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (!(user != null && StringUtils.isNotEmpty(user.getUserName()))) {
			super.log.error("参数对象不能为空！");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
		}
		// (2)查询用户是否存在
		UserVo param = new UserVo();
		param.setUserName(user.getUserName());
		List<UserVo> userList = queryMemberByCondition(param);
		if (CollectionUtils.isNotEmpty(userList)) {
			ControllerUtils.setWho(user);// 设置时间、操作人
			// (2)调用服务，进行数据更新
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("paramter", user);
			map.put("sign", "saveMember");// 所调用的服务中的方法
			Object result = TradeInvokeUtils.invoke("MemberManagement", map);
			// (3)对调用服务后的返回数据进行解析
			if (result != null) {
				Map<String, Object> jsonMap = JsonUtils.toMap(result);
				JSONObject sys = (JSONObject) jsonMap.get("sys");
				if (sys != null) {
					String estatus = sys.getString("status");// 状态：'S'成功，'F'失败
					String erortx = sys.getString("erortx");// 错误信息
					if ("S".equals(estatus)) {// 交易成功
						super.log.info("更新用户调用saveUser服务，信息：" + erortx);
						response.setInfo(I18NUtils.getText("sys.client.update.success"));//更新成功
						response.setResponseType(ResponseType.SUCCESS);
						//更新增成功用户信息存到session中
						UserVo userVo = new UserVo();
						userVo.setUserName(user.getUserName());
						userList= queryMemberByCondition(userVo) ;
						if(CollectionUtils.isNotEmpty(userList)){
							super.getSession().setAttribute(SystemConst.USER_SESSION_KEY,userList.get(0));
						}					
					} else {
						response.setInfo(I18NUtils.getText("sys.client.update.fail"));//更新失败
						super.log.error("更新用户调用saveUser服务，信息：" + erortx);
					}
				}
			} else {
				response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.update.fail.record.unexist"));//更新失败,记录不存在！
			super.log.error("更新失败,记录不存在！");
		}
		return response;
	}
	
	/**
	 * 验证用户名是否已经存在
	 * @param
	 * @return
	 * @throws
	 */
	@RequestMapping("/validateMemberName")
	@ResponseBody
	public List<Object> validateMemberName(String fieldId,String fieldValue){
		UserVo userVo = new UserVo();
		userVo.setUserName(fieldValue);
		List<UserVo> queryMemberByCondition = queryMemberByCondition(userVo);
		List<Object> list = new ArrayList<>();
		list.add(fieldId);
		if(queryMemberByCondition != null && queryMemberByCondition.size() > 0){
			//用户名已经存在
			list.add(false);
		}else{
			list.add(true);
		}
		return list;
	}
	/**
	 * 验证注册的手机号是否已经存在
	 * @param
	 * @return
	 * @throws
	 */
	@RequestMapping("/validateMobile")
	@ResponseBody
	public List<Object> validateMobile(String fieldId,String fieldValue){
		UserVo userVo = new UserVo();
		userVo.setTelephone(fieldValue);
		List<UserVo> queryMemberByCondition = queryMemberByCondition(userVo);
		List<Object> list = new ArrayList<>();
		list.add(fieldId);
		if(queryMemberByCondition != null && queryMemberByCondition.size() > 0){
			//用户名已经存在
			list.add(false);
		}else{
			list.add(true);
		}
		return list;
	}

	/**
	 * 校验邮箱是否存在
	 * @param fieldId 页面input的id值，如：<input type="text" id="email"/>
	 * @param email 邮箱信息
	 * @return ["email",true]
	 */
	@RequestMapping("/validateEmail")
	@ResponseBody
	public List<Object> validateEmail(String fieldId, String email){
		if(StringUtils.isEmpty(fieldId)) {
			fieldId = "email";
		}
		UserVo userVo = new UserVo();
		userVo.setEmail(email);
		List<UserVo> queryMemberByCondition = queryMemberByCondition(userVo);
		List<Object> list = new ArrayList<Object>();
		list.add(fieldId);
		if(queryMemberByCondition != null && !queryMemberByCondition.isEmpty()){
			//邮箱已经存在
			list.add(false);
		}else{
			list.add(true);
		}
		return list;
	}
	
	@RequestMapping("/bindEmail")
	public String bindEmail(){
		return "ybl/admin/accountCenter/bindEmail";
	}
	
	@RequestMapping("/bindEmailSave")
	@ResponseBody
	public String bindEmailSave(String email, String code){
		if(StringUtils.isEmpty(email)) {
			return "邮箱不能为空";
		}
		if(StringUtils.isEmpty(code)) {
			return "验证码不能为空";
		}
		String ret = ValidCodeUtil.checkedValidCode(email, code);
		if(!"S".equals(ret)) {
			return ret;
		}
		UserVo param = new UserVo();
		param.setEmail(email);
		List<UserVo> userList = queryMemberByCondition(param);
		if (CollectionUtils.isNotEmpty(userList)) {
			return "邮箱已存在，请填写其他邮箱";
		}
		UserVo user = ControllerUtils.getCurrentUser();
		param.setId(user.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", param);
		map.put("sign", "saveMember");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("MemberManagement", map);
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String estatus = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(estatus)) {// 交易成功
					super.log.info("更新用户调用saveUser服务，信息：" + erortx);
					ret = "S";
					user.setEmail(email);
					super.getSession().setAttribute(SystemConst.USER_SESSION_KEY,user);
				} else {
					ret = I18NUtils.getText("sys.client.update.fail");
					super.log.error("更新用户调用saveUser服务，信息：" + erortx);
				}
			}
		} else {
			ret = I18NUtils.getText("sys.client.call.service.fail");
			super.log.error("调用服务失败！");
		}
		return ret;
	}
}
