package com.bpm.framework.controller.common;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.controller.about.AboutUsController;
import com.bpm.framework.controller.login.LoginController;
import com.bpm.framework.utils.CollectionUtils;

import cn.sunline.framework.controller.vo.ContactVo;
import cn.sunline.framework.controller.vo.FriendlyLinkVo;
import cn.sunline.framework.controller.vo.PageVo;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年5月23日
 * @version 1.0.0
 * @Description 页面底部数据缓存类
 */
public class BottomRedisCache {
	
	private static final Logger log = LoggerFactory.getLogger(BottomRedisCache.class);
	
	/**
	 * 友情连接
	 */
	public static List<FriendlyLinkVo> getFriendlyLinkList(){
		log.info("开始从redis获取友情链接数据...");
		List<FriendlyLinkVo> friendlyLinkList = new ArrayList<>();
		friendlyLinkList = RedisCache.getList("friendlyLink", FriendlyLinkVo.class);
		if(CollectionUtils.isNotEmpty(friendlyLinkList)){
			log.info("从redis获取到友情链接数据...");
			return friendlyLinkList;
		}
		log.info("从redis未获取到友情链接数据，开始从数据库中查询数据");
		friendlyLinkList = LoginController.friendlyLink();
		log.info("把数据库中的友情链接数据" + friendlyLinkList + "塞到redis缓存中");
		RedisCache.set("friendlyLink", friendlyLinkList);
		return friendlyLinkList;
	}
	
	/**
	 * 联系我们
	 */
	public static List<ContactVo> getContact(){
		log.info("开始从redis获取联系我们数据...");
		List<ContactVo> contactUsList = new ArrayList<ContactVo>();
		contactUsList = RedisCache.getList("contactUs", ContactVo.class);
		if(CollectionUtils.isNotEmpty(contactUsList)){
			log.info("从redis获取到联系我们数据...");
			return contactUsList;
		}
		log.info("从redis未获取到联系我们数据，开始从数据库中查询数据");
		PageVo<ContactVo> contactList = AboutUsController.contactList();
		contactUsList = contactList.getRecords();
		log.info("把数据库中的联系我们数据" + contactUsList + "塞到redis缓存中");
		RedisCache.set("contactUs", contactUsList);
		return contactUsList;
	}

}
