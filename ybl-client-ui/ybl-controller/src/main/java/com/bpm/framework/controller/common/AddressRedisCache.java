package com.bpm.framework.controller.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AreaVo;
import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.common.RedisKeyConstant;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 获取Redis缓存地址数据(如没有则往Redis缓存数据后，再取)
 * 
 * @author
 *
 */
public class AddressRedisCache {
	private static final Logger log = LoggerFactory.getLogger(AddressRedisCache.class);
	
	/**
	 * 获取Redis缓存中的省份信息
	 * 
	 */
	public static List<ProvinceVo> getProvinceList() {
		log.info("JOB RedisAddressCache.getProvinceList() start...");
		List<ProvinceVo> provinceList = new ArrayList<ProvinceVo>();
		//(1) 如果redis里面已经存在，则不再查询数据库
		provinceList = RedisCache.getList(RedisKeyConstant.ADDRESS_PROVINCE, ProvinceVo.class);// 获取集合
		if (CollectionUtils.isNotEmpty(provinceList)) {
			return provinceList;
		}
		//(2) rdis中不存在，查询数据库，获得省份数据
		provinceList = queryAllProvince();
		log.info("JOB RedisAddressCache.queryAllProvince() provinceList="+provinceList);
		//(3) 将省份数据 缓存到redis，方便下次直接从redis取
		if (CollectionUtils.isNotEmpty(provinceList)) {
			RedisCache.set(RedisKeyConstant.ADDRESS_PROVINCE, provinceList);
		}
		log.info("JOB RedisAddressCache.getProvinceList() end.");
		return provinceList;
	}
	
	/**
	 * 获取Redis缓存中的地市信息
	 * 
	 */
	public static List<CityVo> getCityList() {
		log.info("JOB RedisAddressCache.getCityList() start...");
		List<CityVo> cityList = new ArrayList<CityVo>();
		//(1) 如果redis里面已经存在，则不再查询数据库
		cityList = RedisCache.getList(RedisKeyConstant.ADDRESS_CITY, CityVo.class);// 获取集合
		if (CollectionUtils.isNotEmpty(cityList)) {
			return cityList;
		}
		//(2) rdis中不存在，查询数据库，获得地市数据
		cityList = queryAllCity();
		log.info("JOB RedisAddressCache.queryAllCity() cityList="+cityList);
		//(3) 将地市数据 缓存到redis，方便下次直接从redis取
		if (CollectionUtils.isNotEmpty(cityList)) {
			RedisCache.set(RedisKeyConstant.ADDRESS_CITY, cityList);
		}
		log.info("JOB RedisAddressCache.getCityList() end.");
		return cityList;
	}
	
	/**
	 * 获取Redis缓存中的区县信息
	 * 
	 */
	public static List<AreaVo> getAreaList() {
		log.info("JOB RedisAddressCache.getProvinceList() start...");
		List<AreaVo> areaList = new ArrayList<AreaVo>();
		//(1) 如果redis里面已经存在，则不再查询数据库
		areaList = RedisCache.getList(RedisKeyConstant.ADDRESS_AREA, AreaVo.class);// 获取集合
		if (CollectionUtils.isNotEmpty(areaList)) {
			return areaList;
		}
		//(2) rdis中不存在，查询数据库，获得区县数据
		areaList = queryAllArea();
		log.info("JOB RedisAddressCache.queryAllArea() areaList="+areaList);
		//(3) 将区县数据 缓存到redis，方便下次直接从redis取
		if (CollectionUtils.isNotEmpty(areaList)) {
			RedisCache.set(RedisKeyConstant.ADDRESS_AREA, areaList);
		}		
		log.info("JOB RedisAddressCache.getProvinceList() end.");
		return areaList;
	}

	/**
	 * 查询所有省份
	 * 
	 * @param request
	 * @return
	 */
	public static List<ProvinceVo> queryAllProvince() {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("sign", "queryAllProvince");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ProvinceManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ProvinceVo> provinceList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				provinceList = JsonUtils.toList(resultJson, ProvinceVo.class);
				log.info("查询所有省份调用queryAllProvince服务返回成功，信息：" + erortx);
			} else {
				log.error("查询所有省份调用queryAllProvince服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return provinceList;
	}

	/**
	 * 查询所有地市
	 * 
	 * @param request
	 * @return
	 */
	public static List<CityVo> queryAllCity() {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("sign", "queryAllCity");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("CityManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<CityVo> cityList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				cityList = JsonUtils.toList(resultJson, CityVo.class);
				log.info("查询所有地市调用queryAllCity服务返回成功，信息：" + erortx);
			} else {
				log.error("查询所有地市调用queryAllCity服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return cityList;
	}

	/**
	 * 查询所有区县
	 * 
	 * @param request
	 * @return
	 */
	public static List<AreaVo> queryAllArea() {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("sign", "queryAllArea");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("AreaManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<AreaVo> areaList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				areaList = JsonUtils.toList(resultJson, AreaVo.class);
				log.info("查询所有区县调用queryAllArea服务返回成功，信息：" + erortx);
			} else {
				log.error("查询所有区县调用queryAllArea服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return areaList;
	}
}
