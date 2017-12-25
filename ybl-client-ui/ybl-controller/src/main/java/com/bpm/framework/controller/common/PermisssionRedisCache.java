package com.bpm.framework.controller.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.OperatorAuthorityUserVo;
import cn.sunline.framework.controller.vo.PermissionVo;
import cn.sunline.framework.controller.vo.common.RedisKeyConstant;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 获取Redis缓存权限数据(如没有则往Redis缓存数据后，再取)
 * 
 * @author
 *
 */
public class PermisssionRedisCache {
	private static final Logger log = LoggerFactory.getLogger(AddressRedisCache.class);

	/**
	 * 获取Redis缓存中的用户操作权限信息
	 * 
	 */
	public static List<PermissionVo> getPermissionList(Long userId, String userName) {
		log.info("JOB RedisAddressCache.getProvinceList() start...");
		List<PermissionVo> permissionList = new ArrayList<PermissionVo>();
		// (1) 如果redis里面已经存在，则不再查询数据库
		permissionList = RedisCache.getList(RedisKeyConstant.MEMBER_OPERATE_PERMISSION +"_" + userName, PermissionVo.class);// 获取集合
		if (CollectionUtils.isNotEmpty(permissionList)) {
			return permissionList;
		}
		// (2) rdis中不存在，查询数据库，获得用户操作权限数据
		permissionList = queryPromissionList(userId);
		log.info("JOB RedisAddressCache.queryAllProvince() provinceList=" + permissionList);
		// (3) 将用户操作权限数据 缓存到redis，方便下次直接从redis取
		if (CollectionUtils.isNotEmpty(permissionList)) {
			RedisCache.set(RedisKeyConstant.MEMBER_OPERATE_PERMISSION +"_" + userName, permissionList);
		}
		log.info("JOB RedisAddressCache.getProvinceList() end.");
		return permissionList;
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
	public static List<PermissionVo> queryPromissionList(Long userId) {
		List<PermissionVo> permissionList = queryPermissionByCondition();
		List<PermissionVo> returnList = new ArrayList<PermissionVo>();
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
						returnList.add(permissionVo);
					}
				}
			}
		}
		return returnList;
	}

	/**
	 * 查询当前登录用户所拥有的所有授权按钮权限
	 * 
	 * @return
	 */
	private static List<OperatorAuthorityUserVo> queryGrantPromissionUser(Long userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<OperatorAuthorityUserVo> permissionList = new ArrayList<OperatorAuthorityUserVo>();
		OperatorAuthorityUserVo authPermission = new OperatorAuthorityUserVo();
		authPermission.setEnable(1);
		authPermission.setMemberId(userId);
		map.put("paramter", authPermission);
		map.put("sign", "selectUserAuthorityByUserId");
		// (2)调用服务，进行数据保存
		ResBody result = TradeInvokeUtils.invoke("BusinessMemberOperatorAuthority", map);
		// (3)解析返回数据
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					JSONObject resultJson = (JSONObject) output.get("result");
					String buinessMemberAuthority = resultJson.getString("buinessMemberAuthority");
					permissionList = JSONArray.parseArray(buinessMemberAuthority, OperatorAuthorityUserVo.class);
				}
			}
		}
		return permissionList;
	}

	/**
	 * 根据条件查询权限列表数据
	 */
	private static List<PermissionVo> queryPermissionByCondition() {
		// (1)调用服务，查询权限列表数据
		PermissionVo permission = new PermissionVo();
		Map<String, Object> map = new HashMap<String, Object>();
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
				if ("S".equals(status)) {// 交易成功
					String resultJson = output.getString("result");
					permissionList = (List<PermissionVo>) JSONArray.parseArray(resultJson, PermissionVo.class);
				}
			}
		}
		return permissionList;
	}
}
