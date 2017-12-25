package com.bpm.framework.controller.permission;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.PermisssionRedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.OperatePromissionUserVo;
import cn.sunline.framework.controller.vo.OperatorAuthorityUserVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PermissionVo;
import cn.sunline.framework.controller.vo.common.RedisKeyConstant;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({ "/permissionController" })
public class PermissionController extends AbstractController {

	private static final long serialVersionUID = -6087960489785839809L;

	/**
	 * 根据条件查询权限列表数据，并返回权限列表
	 * 
	 * @param request
	 * @param param
	 *            分页对象
	 * @param permission
	 *            权限对象
	 * @return
	 */
	@RequestMapping({ "/list.htm" })
	public String queryList(PermissionVo permission) {
		permission.setEnable(1);// 有效字段：1有效；0无效
		// (1)调用服务，查询权限列表数据
		Map<String, Object> map = new HashMap<String, Object>();
		PageVo<PermissionVo> pageVo = new PageVo<>();
		// 用户只能查询自己企业下的操作权限信息
		permission.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		map.put("paramter", permission);
		map.put("page", pageVo);
		map.put("sign", "queryOperatorAuthorityByCondition");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessOperatorAuthorityManagement", map);
		List<PermissionVo> permissionList = null;
		// (2)服务返回数据分析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject output = (JSONObject) jsonMap.get("output");
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");
				if ("S".equals(status)) {// 交易成功
					String resultJson = output.getString("result");
					String pageJson = output.getString("page");
					pageVo = JsonUtils.toObject(pageJson, PageVo.class);
					getRequest().setAttribute("page", pageVo);
					permissionList = (List<PermissionVo>) JSONArray.parseArray(resultJson, PermissionVo.class);
				} 
			}
		} 
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("permissionList", permissionList);
		getRequest().setAttribute("permission", permission);
		return "ybl/admin/permission/permissionManage";
	}

	@RequestMapping({ "/loadPermissionInfoByName" })
	public String loadPermissionInfoByName(PermissionVo permission) {
		List<PermissionVo> permissionList = queryPermissionByCondition(permission);
		getRequest().setAttribute("permissionList", permissionList);
		return "ybl/admin/permission/permissionManageTable";
	}

	/**
	 * 弹窗编辑页面
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("operator/{edit.htm}")
	public String editRole(HttpServletRequest request,
			@RequestParam(value = "buttonId", required = false) String buttonId) {
		// (1)判断必要参数
		List<PermissionVo> permissionList = null;
		if (StringUtils.isNotEmpty(buttonId)) {
			PermissionVo permission = new PermissionVo();
			permission.setButtonId(buttonId);
			// (2)调用服务，进行用户数据查询
			// 查询用户的方法（调用服务，得到用户数据集合）
			permissionList = queryPermissionByCondition(permission);
			if (CollectionUtils.isNotEmpty(permissionList)) {// 若存在，返回页面数据
				getRequest().setAttribute("permission", permissionList.get(0));
			}
		}
		return "ybl/admin/permission/permissionEdit";
	}

	/**
	 * 授权（操作权限）所展示的列表数据
	 * 
	 * @param request
	 * @param param
	 *            分页对象
	 * @param role
	 *            操作权限对象
	 * @return
	 */
	@RequestMapping(value = "/selectPromission")
	public String selectPromission(PermissionVo permission, Long userId, String userName) {
		permission.setEnable(1);// 有效字段：1有效；0无效
		List<PermissionVo> permissionList = queryPermissionByCondition(permission);
		if (CollectionUtils.isNotEmpty(permissionList)) {
			List<OperatorAuthorityUserVo> operateAuthList = queryGrantPromissionUser(userId);
			List<Long> permissionIds = new ArrayList<Long>();
			if (CollectionUtils.isNotEmpty(operateAuthList)) {
				for (OperatorAuthorityUserVo operator : operateAuthList) {
					permissionIds.add(operator.getOperatorId());
				}
			}
			// 如果有已授权的操作权限，那么前台展示时默认选中
			if (CollectionUtils.isNotEmpty(permissionIds)) {
				for (PermissionVo permissionVo : permissionList) {
					if (permissionIds.contains(permissionVo.getId())) {
						permissionVo.setAttribute1("1");// 使用备用字段attrbute1,用1标识已选中；
					}
				}
			}
		}
		getRequest().setAttribute("userId", userId);
		getRequest().setAttribute("userName", userName);
		getRequest().setAttribute("permissionList", permissionList);
		return "ybl/admin/permission/permissionSelect";
	}

	/**
	 * 根据条件查询权限列表数据
	 * 
	 * @param request
	 * @param param
	 *            分页对象
	 * @param permission
	 *            权限对象
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/queryPermissionByCondition")
	public List<PermissionVo> queryPermissionByCondition(PermissionVo permission) {
		// (1)调用服务，查询权限列表数据
		Map<String, Object> map = new HashMap<String, Object>();
		PageVo<PermissionVo> pageVo = new PageVo<>();
		// 用户只能查询自己企业下的操作权限信息
		permission.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		map.put("paramter", permission);
		map.put("page", pageVo);
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
					String pageJson = output.getString("page");
					pageVo = JsonUtils.toObject(pageJson, PageVo.class);
					getRequest().setAttribute("page", pageVo);
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
	}

	/**
	 * 查询所有权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryAllOperatorAuthority")
	@ResponseBody
	public List<?> queryAllOperatorAuthority() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<PermissionVo> permissionList = null;
		// 调用服务，进行数据查询
		map.put("paramter", "");
		map.put("sign", "queryAllOperatorAuthority");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessOperatorAuthorityManagement", map);
		// (2)服务返回数据分析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject output = (JSONObject) jsonMap.get("output");
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					String resultJson = output.getString("result");
					permissionList = JSONArray.parseArray(resultJson, PermissionVo.class);
					super.log.info("查询所有权限调用queryAllOperatorAuthority服务成功，信息：" + erortx);
				} else {
					super.log.error("查询所有权限调用queryAllOperatorAuthority服务失败，信息：" + erortx);
				}
			}
		} else {
			super.log.error("调用服务失败");
		}
		return permissionList;
	}

	/**
	 * 根据ID删除权限组 若已关联则不删除
	 * 
	 * @param request
	 * @param department
	 * @return
	 */
	@RequestMapping(value = "/deleteById")
	@ResponseBody
	public ControllerResponse deleteById(HttpServletRequest request, Long id[]) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数是否存在
		if (id == null) {
			super.log.error("删除权限时，权限id不能为空。");
			response.setInfo("参数错误");
			return response;
		}
		// 判断权限组是否已经授权
		for (int i = 0; i < id.length; i++) {
			// (2)先判断这个权限是否被分配到用户
			List<?> list = queryGrantPromissionUser(id[0]);
			if (CollectionUtils.isNotEmpty(list)) {
				super.log.error("删除失败," + id[i] + "权限组已关联用户,请先解除关联再删除");
				response.setInfo(id[i] + "该权限组已关联用户,请先解除关联再删除");
				return response;
			}
		}
		// PermissionVo permission = new PermissionVo();
		// permission.setId(id[i]);
		// permission.setEnable(1);
		// List<PermissionVo> permissionList =
		// queryPermissionByCondition(permission);
		// if (CollectionUtils.isNotEmpty(permissionList)) { // 若存在，则删除
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", id);
		map.put("sign", "deleteOperatorAuthorityById");// 所调用的服务中的方法
		Object result = TradeInvokeUtils.invoke("BusinessOperatorAuthorityManagement", map);
		// (4)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.delete.success"));
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("删除权限信息，调用deleteOperatorAuthorityById服务成功，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.delete.fail"));
					super.log.error("删除权限信息，调用deleteOperatorAuthorityById服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));
			super.log.error("删除权限信息，调用deleteOperatorAuthorityById服务失败");
		}
		// } else { // 不存在，则删除失败
		// super.log.error("删除失败,记录不存在");
		// response.setInfo("删除失败,记录不存在");
		// }
		return response;
	}

	/**
	 * 保存或更新权限组信息 前台参数 id,deptCode,deptName
	 * 
	 * @param request
	 * @param permissionVo
	 *            权限对象
	 * @return
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ControllerResponse saveOrUpdate(PermissionVo permissionVo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		/* (1)表单数据后台二次校验 */
		if (StringUtils.isEmpty(permissionVo.getButtonName())) {
			response.setInfo("权限名称不能为空");
			super.log.error("新增/编辑权限时，权限名称不能为空");
			return response;
		}
		if (StringUtils.isEmpty(permissionVo.getButtonId())) {
			response.setInfo("权限编号不能为空");
			super.log.error("新增/编辑权限时，权限编号不能为空");
			return response;
		}
		// (2)根据权限编号查询数据，若已存在，则给出提示
		PermissionVo permission = new PermissionVo();
		permission.setButtonId(permissionVo.getButtonId());
		permission.setEnable(1);
		List<PermissionVo> permissionList = queryPermissionByCondition(permission);
		if (CollectionUtils.isNotEmpty(permissionList)) { // 若存在，则提示
			for (Object obj : permissionList) {
				PermissionVo pro = (PermissionVo) obj;
				if (permissionVo.getButtonId().equals(pro.getButtonId()) && permissionVo.getId().longValue() != pro.getId().longValue()) {
					response.setInfo("权限编号已存在！");
					super.log.error("权限编号" + permissionVo.getButtonId() + "已存在");
					return response;
				}
			}
		}
		// (3)新增/更新操作
		Long permissionId = permissionVo.getId();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", permissionVo);
		ControllerUtils.setWho(permissionVo);// 设置时间、操作人
		if (permissionId == null) { // 新增
			permissionVo.setEnable(1);// 是否有效(1：有效；0：无效)
			permissionVo.setSign("");// 签名字段
			// 登录用户的企业id
			permissionVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			// 调用服务，进行数据新增
			map.put("sign", "insertOperatorAuthority");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_SAVE);
			response.setInfo(I18NUtils.getText("sys.client.save.success"));
		} else {
			map.put("sign", "updateOperatorAuthorityById");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
			response.setInfo(I18NUtils.getText("sys.client.save.success"));
		}
		ResBody result = TradeInvokeUtils.invoke("BusinessOperatorAuthorityManagement", map);
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
					super.log.info("新增/编辑时，调用insertOperatorAuthority/updateOperatorAuthorityById服务成功，信息：" + erortx);
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.save.fail"));// 设置返回的信息
					super.log.error("新增/编辑时，调用insertOperatorAuthority/updateOperatorAuthorityById服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.save.fail"));// 设置返回的信息
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 给用户授予操作权限
	 * 
	 * @param request
	 * @param userId
	 *            用户id
	 * @param roleIds
	 *            角色id(多组)
	 * @return
	 */
	@RequestMapping(value = "/saveGrantPromissionUser")
	@ResponseBody
	public ControllerResponse saveGrantPromissionUser(Long userId, String promissionIds, String userName) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> promissionIdsList = new ArrayList<String>();
		OperatePromissionUserVo operatePromissionUserVo = new OperatePromissionUserVo();
		// (1)判断必要参数是否存在
		if (userId != null) {
			if (StringUtils.isNotEmpty(promissionIds)) {
				String[] roleArr = promissionIds.split(",");
				for (int i = 0; i < roleArr.length; i++) {
					promissionIdsList.add(roleArr[i]);
				}
				operatePromissionUserVo.setOperateId(promissionIdsList);
				map.put("sign", "updateUserAuthorityByUserId");
			} else {
				// 解除用户操作权限
				map.put("sign", "deleteUserAuthorityByUserId");
			}
			operatePromissionUserVo.setMemberId(userId);
			operatePromissionUserVo.setEnable(1);
			// 当前用户的企业id
			operatePromissionUserVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			ControllerUtils.setWho(operatePromissionUserVo);
			map.put("paramter", operatePromissionUserVo);
			// (2)调用服务，进行数据保存
			Object result = TradeInvokeUtils.invoke("BusinessMemberOperatorAuthority", map);
			// (3)解析返回数据
			if (result != null) {
				Map<String, Object> jsonMap = JsonUtils.toMap(result);
				JSONObject sys = (JSONObject) jsonMap.get("sys");
				if (sys != null) {
					String status = sys.getString("status");
					String erortx = sys.getString("erortx");// 错误信息
					if ("S".equals(status)) {// 交易成功
						response.setResponseType(ResponseType.SUCCESS_SAVE);
						response.setInfo(I18NUtils.getText("sys.client.accredit.success"));
						// 把用户操作权限放到redis中
						List<PermissionVo> list = RedisCache.getList(
								RedisKeyConstant.MEMBER_OPERATE_PERMISSION + "_" + userName, PermissionVo.class);// 获取集合
						if (list != null && list.size() > 0) {
							RedisCache.del(RedisKeyConstant.MEMBER_OPERATE_PERMISSION + "_" + userName);
						}
						List<PermissionVo> queryPromissionList = PermisssionRedisCache.queryPromissionList(userId);
						RedisCache.set(RedisKeyConstant.MEMBER_OPERATE_PERMISSION + "_" + userName,
								queryPromissionList);
						super.log.info("保存角色-用户授权信息，调用  updateUserAuthorityByUserId服务成功：" + erortx);
					} else {
						response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));
						super.log.error("保存角色-用户授权信息，调用updateUserAuthorityByUserId  服务失败：" + erortx);
					}
				}
			} else {
				response.setInfo(I18NUtils.getText("sys.client.accredit.failure"));
				super.log.error("调用服务失败！");
			}
		} else {
			response.setInfo("必要参数不能为空");
			super.log.error("必要参数不能为空！");
		}
		return response;
	}

	/**
	 * 查询用户所拥有的操作权限
	 * 
	 * @param request
	 * @param userId
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "/queryGrantPromissionUser")
	@ResponseBody
	public List<OperatorAuthorityUserVo> queryGrantPromissionUser(Long userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<OperatorAuthorityUserVo> promissionIdsList = new ArrayList<OperatorAuthorityUserVo>();
		OperatorAuthorityUserVo permission = new OperatorAuthorityUserVo();
		// (1)判断必要参数是否存在
		if (userId != null) {
			permission.setMemberId(userId);
			permission.setEnable(1);
			map.put("paramter", permission);
			map.put("sign", "selectUserAuthorityByUserId");
			// (2)调用服务，进行数据保存
			ResBody result = TradeInvokeUtils.invoke("BusinessMemberOperatorAuthority", map);
			// (3)解析返回数据
			if (result != null) {
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {// 交易成功
						JSONObject output = (JSONObject) result.getOutput();
						JSONObject resultJson = (JSONObject) output.get("result");
						String buinessMemberAuthority = resultJson.getString("buinessMemberAuthority");
						promissionIdsList = JSONArray.parseArray(buinessMemberAuthority, OperatorAuthorityUserVo.class);
						super.log.info("查询已授权的角色-用户信息，调用selectUserAuthorityByUserId服务成功：" + erortx);
					} else {
						super.log.error("查询已授权的角色-用户信息，调用 selectUserAuthorityByUserId服务失败：" + erortx);
					}
				}
			} else {
				super.log.error("调用服务失败！");
			}
		} else {
			super.log.error("必要参数不能为空！");
		}
		return promissionIdsList;
	}

}
