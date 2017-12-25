package com.bpm.framework.controller.common;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.common.RedisKeyConstant;
import cn.sunline.framework.controller.vo.v2.TConfig;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;
/**
 * 获取Redis缓存数据(如没有则往Redis缓存数据后，再取)
 * 
 * @author
 *
 */
public class ConfigCache implements Serializable {

	private static final long serialVersionUID = -5802143821954568450L;
	
	private static final Logger log = LoggerFactory.getLogger(ConfigCache.class);
	
	private ConfigCache() {}
	
	/**
	 * 根据数据类型和代码获取基础数据类型数据
	 * @param type 类型
	 * @param code 代码
	 * @return
	 */
	public static TConfig getByTypeCode(String type, String code) {
		String key = RedisKeyConstant.REDIS_CONFIG + type + "#" + code;
		TConfig config = RedisCache.get(key, TConfig.class);
		if(null == config) {
			List<TConfig> oList = queryConfigByCondition(type,code);
			if(CollectionUtils.isNotEmpty(oList)){
				RedisCache.set(key, oList.get(0));
			}
		}
		return config;
	}
	
	public static String getValueByTypeCode(String type, String code) {
		TConfig config = getByTypeCode(type, code);
		if(null == config) return null;
		return config.getValue();
	}
	
	/**
	 * 根据数据类型获取基础数据类型数据
	 * @param type 类型
	 * @return
	 */
	public static List<TConfig> getByType(String type) {
		String key = RedisKeyConstant.REDIS_CONFIG + type;
		List<TConfig> oList = RedisCache.getList(key, TConfig.class);
		if(CollectionUtils.isEmpty(oList)) {
			oList = queryConfigByCondition(type,null);
			RedisCache.set(key, oList);
		}
		return oList;
	}
	
	public static Map<String, String> getByTypeMap(String type) {
		List<TConfig> oList = getByType(type);
		if(CollectionUtils.isEmpty(oList)) return null;
		Map<String, String> oMap = new HashMap<>();
		for(TConfig o : oList) {
			oMap.put(o.getCode(), o.getValue());
		}
		return oMap;
	}
	
	/**
	 *  根据条件查询基础数据类型
	 * @param type 类型 
	 * @param code 代码
	 * @return
	 */
	private static List<TConfig> queryConfigByCondition(String type,String code) {
		// 调用服务，进行数据查询
		TConfig config = new TConfig();
		config.setType(type);
		config.setCode(code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", config);
		map.put("sign", "queryConfigByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("TConfigManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<TConfig> configList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				configList = JsonUtils.toList(resultJson, TConfig.class);
				log.info("根据类型查询基础数据类型调用queryConfigByCondition服务返回成功，信息：" + erortx);
			} else {
				log.error("根据类型查询基础数据类型调用queryConfigByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return configList;
	}
	
}
