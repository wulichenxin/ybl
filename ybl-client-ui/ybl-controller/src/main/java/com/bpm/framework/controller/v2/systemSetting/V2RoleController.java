package com.bpm.framework.controller.v2.systemSetting;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.bootstrap.page.PageParam;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.OperateRoleMenuVo;
import cn.sunline.framework.controller.vo.OperateUserRoleVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.RoleVo;
import cn.sunline.framework.controller.vo.UserRoleVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.V2RoleVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 2.0岗位管理
 * @author lpp
 *
 */
@Controller
@RequestMapping({"/v2RoleController"})
public class V2RoleController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7130775987068133099L;

	
	@RequestMapping(value="/list.htm")
	public String list(HttpServletRequest request,PageParam param,V2RoleVo role,PageVo<?> pageVo){
		/*******************************/
		/**
		 * V4版本-根据用户类型查询该用户对应的角色信息
		 */
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user&&null != user.getType()){
			//用户登录状态
			role.setRoleType(user.getType());
		}
		/******************************/
		Map<String, Object> map=new HashMap<String, Object>();
		//用户只能查询自己企业的岗位信息。
		role.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		map.put("paramter", role);
		map.put("sign", "queryRoleInfoByCondition");
		map.put("page", pageVo);
		Object result = TradeInvokeUtils.invoke("V2RoleManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);		
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<V2RoleVo> roleList = new ArrayList<>();
		if(sys!=null){
			String status = sys.getString("status");
			if("S".equals(status)){//交易成功
				String records =  output.getString("result");		
				String jsonPage = output.getString("page");
				pageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				roleList=JsonUtils.toList(records, V2RoleVo.class);
			}			
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("jobList", roleList);
		getRequest().setAttribute("role", role);
		return "ybl/v2/admin/systemSetting/roleManage/roleManage";
	}
	@RequestMapping(value="/loadRoleInfoByRoleName")
	public String loadRoleInfoByRoleName(HttpServletRequest request,PageParam param,V2RoleVo role){
		Map<String, Object> map=new HashMap<String, Object>();
		//用户只能查询自己企业的岗位信息。
		role.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		map.put("paramter", role);
		map.put("sign", "queryRoleInfoByCondition");
		PageVo<V2RoleVo> pageVo = new PageVo<>();
		map.put("page", pageVo);
		Object result = TradeInvokeUtils.invoke("V2RoleManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);		
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<V2RoleVo> roleList = new ArrayList<>();
		if(sys!=null){
			String status = sys.getString("status");
			if("S".equals(status)){//交易成功
				String records =  output.getString("result");		
				String jsonPage = output.getString("page");
				pageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				roleList=JsonUtils.toList(records, V2RoleVo.class);
			}			
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("jobList", roleList);
		return "ybl/admin/role/jobManageTable";
	}
	/**
	 * 弹窗编辑页面
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping({"/edit.htm"})
	public String editRole(HttpServletRequest request,String id) {
	    	//(1)判断必要参数
		List<V2RoleVo> roleList = null;
    	if(StringUtils.isNotEmpty(id)){
    		V2RoleVo parameters = new V2RoleVo();
    		parameters.setId(Long.parseLong(id));
    		//(2)调用服务，进行用户数据查询	
    		//查询用户的方法（调用服务，得到用户数据集合）
    		roleList = queryRoleInfoByCondition(parameters);
    		if(CollectionUtils.isNotEmpty(roleList)){//若存在，返回页面数据
    			getRequest().setAttribute("role", roleList.get(0));
    		}	
		}
        return "ybl/v2/admin/systemSetting/roleManage/roleEdit";
	}
	/**
	 * 根据条件查角色信息
	 * @param role
	 * @return
	 */
	@RequestMapping({"/queryRoleInfoByCondition"})
	@ResponseBody
	  public List<V2RoleVo> queryRoleInfoByCondition(V2RoleVo role){
		Map<String, Object> map=new HashMap<String, Object>();
		//用户只能查看自己企业的岗位
		role.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		//v4.0增加，当前业务认证的岗位
		role.setRoleType(ControllerUtils.getCurrentUser().getType());
		map.put("paramter", role);
		PageVo<V2RoleVo> pageVo = new PageVo<>();
		map.put("page", pageVo);
		map.put("sign", "queryRoleInfoByCondition");
		Object result = TradeInvokeUtils.invoke("V2RoleManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);		
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<V2RoleVo> roleList = new ArrayList<>();
		if(sys!=null){
			String status = sys.getString("status");
			if("S".equals(status)){//交易成功
				String resultJson = output.getString("result");
				roleList = JsonUtils.toList(resultJson, V2RoleVo.class);
			}			
		}
		return roleList;
		   
	   }
	/**
	 * 更新/保存角色信息
	 * @param request
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	@Log(operation=OperationType.Edit, info="角色新增或者修改")
    public ControllerResponse addOrUpdateRole(HttpServletRequest request,V2RoleVo role) {
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	//(1)判断是否有数据
		if(role==null){
			response.setInfo("参数错误");
			super.log.error("保存/编辑角色数据对象不能为空！");
			return response;
		}
		//(2)判断必要参数
		if(StringUtils.isEmpty(role.getName())){
			response.setInfo("角色名不能为空");
			super.log.error("保存/编辑角色数据对象必要参数不能为空！");
			return response;
		}					
		//(3)新增/编辑操作
		Long roleId = role.getId();
		Object result = null;
		Map<String,Object> map = new HashMap<String,Object>();
		ControllerUtils.setWho(role);//设置时间、操作人	
		
		/*******************************/
		/**
		 * V4版本-根据用户类型保存该用户对应的角色类型
		 */
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user&&null != user.getType()){
			//用户登录状态
			role.setRoleType(user.getType());
		}
		/******************************/
		
		//如果角色码重复不让添加或修改
		if(roleId==null){	//新增
			String code=role.getCode();
			V2RoleVo role1=new V2RoleVo();
			role1.setCode(code);
			List<V2RoleVo> list = queryRoleInfoByCondition(role1);
			/*if(CollectionUtils.isNotEmpty(list)){//若存在，则给出提示
				response.setInfo("角色码["+code+"]已被使用,请换一个角色码");
				super.log.error("新增角色码重复！");
				return response;			
			}*/
			//(5)调用服务，进行数据保存
			role.setSign("");//设置签名字段
			role.setEnable(1);//设置有效字段
			//当前登录用户的企业id赋值给角色表中的企业id
			role.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			ControllerUtils.setWho(role);
			map.put("paramter", role);
			map.put("sign", "insertRoleInfo");//所调用的服务中的方法
			result = TradeInvokeUtils.invoke("V2RoleManagement", map);
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		}else{
			//编辑
			//(5)调用服务，进行数据更新
			map.put("paramter", role);
			map.put("sign", "updateRoleInfo");//所调用的服务中的方法
			result = TradeInvokeUtils.invoke("V2RoleManagement", map);
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		//(6)对调用服务后的返回数据进行解析
		if(result!=null){
			Map<String, Object> jsonMap = JsonUtils.toMap(result);		
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if(sys!=null){
				String status = sys.getString("status");//状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");//错误信息
				if("S".equals(status)){//交易成功
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.save.success"));//设置返回的信息
					super.log.info("新增/编辑addRole/saveRole服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.save.fail"));
					super.log.error("新增/编辑addRole/saveRole服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.save.fail"));
			super.log.error("调用服务失败！");
		}	
		return response;
    }
	/**
	 * 根据id解绑角色下的所有用户
	 * @return
	 */
	@RequestMapping(value="/deleteUserRoleById")
	@Log(operation=OperationType.Delete, info="解绑角色下的所有用户")
	public String deleteUserRoleById(@RequestParam("id") Long id){
		//判断id必要参数是否为空
		if(id==null){
			super.log.error("删除用户id不能为空！");
			return "redirect:/roleController/list.htm";
		}
		//根据角色id查询角色用户表有效数据是否有记录,有则设置enable为false
		UserRoleVo ur=new UserRoleVo();
		ur.setUserId(id);
		ur.setEnable(1);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", ur);
		map.put("sign", "queryUserRoleInfoByUserId");//所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessMemberRoleManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);		
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<UserRoleVo> userRoleList = null;
		if(sys!=null){
			String status = sys.getString("status");
			String erortx = sys.getString("erortx");//错误信息
			if("S".equals(status)){//交易成功
				userRoleList = (List<UserRoleVo>) output.get("result");		
				super.log.info("根据条件查询用户角色调用服务返回成功，信息："+erortx);
			}else{
				super.log.error("根据条件查询用户角色调用服务返回失败，信息："+erortx);
				return null;
			}
		}
		//如果该角色下有用户信息,解绑用户再删角色
		if(CollectionUtils.isNotEmpty(userRoleList)){
			for (UserRoleVo userRoleVo : userRoleList) {
				Map<String,Object> map1 = new HashMap<String,Object>();
				userRoleVo.setEnable(0);
				map1.put("paramter", userRoleVo);
				map1.put("sign", "");//所调用的服务中的保存方法
				Object result1 = TradeInvokeUtils.invoke("BusinessMemberRoleManagement", map1);
				//(3)对调用服务后的返回数据进行解析
				if(result1!=null){
					Map<String, Object> jsonMap1 = JsonUtils.toMap(result1);		
					JSONObject sys1 = (JSONObject) jsonMap1.get("sys");
					if(sys1!=null){
						String estatus = sys1.getString("status");//状态：'S'成功，'F'失败
						String erortx = sys1.getString("erortx");//错误信息
						if("S".equals(estatus)){//交易成功						
							super.log.info("禁用用户角色调用服务，信息："+erortx);
						}else{						
							super.log.error("禁用用户角色服务，信息："+erortx);
						}
					}
				}else{				
					super.log.error("调用服务失败！");
				}
			}
		}
		
		return null;
	}
	/**
	 * 根据角色码删除角色
	 * @param code
	 * @return
	 */
	@RequestMapping(value="/deleteRoleById")
	@Log(operation=OperationType.Delete, info="删除角色")
	public ControllerResponse deleteRoleById(HttpServletRequest request,String code){
		V2RoleVo role=new V2RoleVo();
		role.setCode(code);
		List<V2RoleVo> list = queryRoleInfoByCondition(role);
		V2RoleVo roleVo = list.get(0);
		roleVo.setEnable(0);
		deleteUserRoleById(roleVo.getId());
		addOrUpdateRole(request,roleVo);
		return null;
	}
	/**
	 * 给角色授权
	 * @param meunlist
	 * @param roleid
	 * @return
	 */
	@RequestMapping(value = "/accreditRole")
	@ResponseBody
	@Log(operation=OperationType.Auth, info="给角色授权")
	public ControllerResponse accreditRoleById(String meunlist,Long roleid){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		OperateRoleMenuVo rm=new OperateRoleMenuVo();
		List<Long> menuIds = new ArrayList<>();
		Map<String,Object> map = new HashMap<String,Object>();
		rm.setRoleId(roleid);
		if(meunlist != null && meunlist.length() > 0){
			String[] strings = meunlist.split(",");
			for (int i=0;i<strings.length;i++) {
				menuIds.add(Long.valueOf(strings[i]));			
			}
			rm.setMenuId(menuIds);
			rm.setEnable(1);
			map.put("sign", "updateRoleMenuByRoleId");//所调用的服务中的方法
		}else{
			map.put("sign", "deleteRoleMenuByRoleId");//解绑角色绑定的菜单信息
		}
		rm.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());;
		ControllerUtils.setWho(rm);
		map.put("paramter", rm);
		Object result = TradeInvokeUtils.invoke("V2RoleMenuManagement", map);
		response.setResponseType(ResponseType.SUCCESS_SAVE);
		if(result!=null){
			Map<String, Object> jsonMap = JsonUtils.toMap(result);		
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if(sys!=null){
				String status = sys.getString("status");//状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");//错误信息
				if("S".equals(status)){//交易成功
					response.setObject(result);//设置返回结果	
					if("deleteRoleMenuByRoleId".equals(map.get("sign"))){
						response.setInfo(I18NUtils.getText("sys.client.accredit.success"));//设置返回的信息
					}else{
						response.setInfo(I18NUtils.getText("sys.client.accredit.success"));//设置返回的信息
					}
					super.log.info("授权用户权限服务调用信息："+erortx);
				}else{
					if("deleteRoleMenuByRoleId".equals(map.get("sign"))){
						response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));//设置返回的信息
					}else{
						response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));//设置返回的信息
					}
					response.setResponseType(ResponseType.ERROR);
					super.log.error("授权用户权限服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			if("deleteRoleMenuByRoleId".equals(map.get("sign"))){
				response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));//设置返回的信息
			}else{
				response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));//设置返回的信息
			}
			super.log.error("调用服务失败！");
		}	
		return response;
	}
	/**
	 * 绑定用户所展示的列表数据
	 * @param request
	 * @param param 分页对象
	 * @param role 角色对象
	 * @return
	 */
	@RequestMapping(value="/selectRole.htm")
	public String selectRoleList(HttpServletRequest request,V2RoleVo role,Long userId){
		Map<String, Object> map=new HashMap<String, Object>();
		//查询当前用户企业的角色信息
		role.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		/**********************************/
		/**
		 * V4版本需求
		 * 角色根据用户类型来过滤
		 */
		/*********************************/
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//用户已登录
			role.setRoleType(user.getType());
		}
		map.put("paramter", role);
		PageVo<V2RoleVo> pageVo = new PageVo<V2RoleVo>();
		map.put("page", pageVo);
		map.put("sign", "queryRoleInfoByCondition");
		Object result = TradeInvokeUtils.invoke("V2RoleManagement", map);
		Map<String, Object> jsonMap = JsonUtils.toMap(result);		
		JSONObject output = (JSONObject) jsonMap.get("output");
		JSONObject sys = (JSONObject) jsonMap.get("sys");
		List<V2RoleVo> roleList = new ArrayList<>();
		if(sys!=null){
			String status = sys.getString("status");
			if("S".equals(status)){//交易成功
				String resultJson = output.getString("result");
				roleList = JSONArray.parseArray(resultJson, V2RoleVo.class);
				if(CollectionUtils.isNotEmpty(roleList)){
					List<UserRoleVo> userRoleList = queryGrantRoleUser(userId);
					List<Long> roleIds = new ArrayList<Long>();
					if(CollectionUtils.isNotEmpty(userRoleList)){
						for(UserRoleVo userRoleVo:userRoleList){
							roleIds.add(userRoleVo.getRoleId());
						}
					}
					//如果有已授权的用户角色，那么前台展示时默认选中
					if(CollectionUtils.isNotEmpty(roleIds)){
						for(V2RoleVo roleVo:roleList){							
							if(roleIds.contains(roleVo.getId())){
								roleVo.setAttribute1("1");//使用备用字段attrbute1,用1标识已选中；
							}
						}
					}				
				}
			}			
		}
		getRequest().setAttribute("userId", userId);
		getRequest().setAttribute("roleList", roleList);
		getRequest().setAttribute("role", role);
		return "ybl/v2/admin/systemSetting/userManage/roleSelect";
	}
	
	/**
	 * 绑定角色-用户
	 * @param request
	 * @param userId 用户id
	 * @param roleIds 角色id(多组)
	 * @return
	 */
	@RequestMapping(value="/saveGrantRoleUser")
	@ResponseBody
	@Log(operation=OperationType.Auth, info="给用户绑定角色")
	public ControllerResponse saveGrantRoleUser(Long userId,String roleIds){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map=new HashMap<String, Object>();
		List<Long> userRoleIdList = new ArrayList<Long>();
		OperateUserRoleVo operateUserRoleVo  = new OperateUserRoleVo();
		//(1)判断必要参数是否存在
		if(userId!=null){
			if(StringUtils.isNotEmpty(roleIds)){
				String[] roleArr = roleIds.split(",");
				for(int i=0;i<roleArr.length;i++){
					userRoleIdList.add(Long.valueOf(roleArr[i]));
				}
				operateUserRoleVo.setRoleId(userRoleIdList);
				operateUserRoleVo.setEnable(1);
				ControllerUtils.setWho(operateUserRoleVo);
				map.put("sign", "updateUserRoleByUserId");
			}else{
				//解绑用户角色
				map.put("sign", "deleteUserRoleByUserId");
			}
			operateUserRoleVo.setUserId(userId);
			operateUserRoleVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			map.put("paramter", operateUserRoleVo);
			//(2)调用服务，进行数据保存
			Object result = TradeInvokeUtils.invoke("V2MemberRoleManagement", map);
			//(3)解析返回数据
			if(result!=null){
				Map<String, Object> jsonMap = JsonUtils.toMap(result);		
				JSONObject sys = (JSONObject) jsonMap.get("sys");
				if(sys!=null){
					String status = sys.getString("status");
					String erortx = sys.getString("erortx");//错误信息
					if("S".equals(status)){//交易成功	
						response.setResponseType(ResponseType.SUCCESS_SAVE);
						response.setInfo(I18NUtils.getText("sys.client.save.success"));
						super.log.info("保存角色-用户授权信息，调用updateUserRoleByUserId  服务成功："+erortx);
					}else{
						response.setInfo(I18NUtils.getText("sys.client.save.fail"));
						super.log.error("保存角色-用户授权信息，调用 updateUserRoleByUserId 服务失败："+erortx);
					}
				}
			}else{				
				response.setInfo("调用服务失败！");
				super.log.error("调用服务失败！");
			}
		}else{
			response.setInfo("用户id不能为空！！！");
			super.log.error("调用服务失败！");
		}	
		return response;
	}
	
	/**
	 * 查询已绑定角色-用户
	 * @param request
	 * @param userId 用户id
	 * @return
	 */
	@RequestMapping(value="/queryGrantRoleUser")
	@ResponseBody
	public List<UserRoleVo> queryGrantRoleUser(Long userId){	
		Map<String, Object> map=new HashMap<String, Object>();
		List<UserRoleVo> userRoleList = new ArrayList<UserRoleVo>();
		UserRoleVo userRole  = new UserRoleVo();
		//(1)判断必要参数是否存在
		if(userId!=null){
			userRole.setUserId(userId);
			userRole.setEnable(1);
			map.put("paramter", userRole);
			map.put("sign", "queryUserRoleInfoByUserId");
			//(2)调用服务，进行数据保存
			ResBody result = TradeInvokeUtils.invoke("BusinessMemberRoleManagement", map);
			//(3)解析返回数据
			if(result!=null){
				JSONObject output = (JSONObject)result.getOutput();				
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {// 交易成功
						JSONObject resultJson = (JSONObject)output.get("result");
						String roles = resultJson.getString("roles");
						userRoleList = JSONArray.parseArray(roles, UserRoleVo.class);
						super.log.info("查询已授权的角色-用户信息，调用queryUserRoleInfoByUserId  服务成功："+erortx);
					}else{						
						super.log.error("查询已授权的角色-用户信息，调用 queryUserRoleInfoByUserId服务失败："+erortx);
					}
				}
			}else{								
				super.log.error("调用服务失败！");
			}
		}else{			
			super.log.error("必要参数不能为空！");
		}	
		return userRoleList;
	}
	
	/**
	 * 根据岗位id删除岗位信息<br/>
	 * 1、先判断该岗位是否与用户绑定<br/>
	 * 2、如果已与用户绑定则要先删除用户角色表这个中间表的信息
	 */
	@RequestMapping(value = "/deleteRoleByRoleId")
	@ResponseBody
	public ControllerResponse deleteRoleByRoleId(HttpServletRequest request,Long jobId[]) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String,Object> map = new HashMap<String,Object>();
		//支持批量删除
		map.put("paramter", jobId);
		map.put("sign", "deleteRoleByRoleId");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("V2RoleManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功	
				response.setResponseType(ResponseType.SUCCESS_DELETE);
				response.setInfo(I18NUtils.getText("sys.client.delete.success"));//删除成功
				super.log.info("删除角色信息调用deleteRoleByRoleId服务成功，信息：" + erortx);
			} else {
				response.setResponseType(ResponseType.FAILURE);
				response.setInfo(I18NUtils.getText("sys.client.delete.fail"));//删除失败
				super.log.error("删除角色信息deleteRoleByRoleId服务失败，信息：" + erortx);
			}
		}	
		return response;
	}
	
	
}
