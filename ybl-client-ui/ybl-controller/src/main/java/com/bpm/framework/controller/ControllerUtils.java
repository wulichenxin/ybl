package com.bpm.framework.controller;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kie.api.task.model.User;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bpm.framework.SystemConst;
import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.utils.date.DateUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.common.AbstractEntity;
import cn.sunline.framework.controller.vo.v2.V2MemberRole;
import cn.sunline.framework.controller.vo.v2.V2MemberVo;
import cn.sunline.framework.controller.vo.v2.V2UserVo;

public class ControllerUtils implements Serializable {

	private static final long serialVersionUID = -238855059544291499L;

	private ControllerUtils() {}
	
	/**
	 * 
	 * 获取request
	 * 
	 * @see ResponseFilter.java
	 * @return
	 */
	public static HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	
	public static HttpSession getSession() {
		return getRequest().getSession();
	}
	
	/**
	 * 根据实体设置创建时间，创建人，更新时间，更新人
	 * @param o 实体
	 */
	public static void setWho(AbstractEntity o) {
		UserVo user = (null == getCurrentUser() ? getAutoRunUser() : getCurrentUser());
		if(null == o.getId() || o.getId().longValue()<=0L) {
			o.setCreatedBy(user.getId());
			o.setCreatedTime(DateUtils.now());
		}
		o.setLastUpdateBy(user.getId());
		o.setLastUpdateTime(DateUtils.now());
	}
	
	/**
	 * 根据实体、sessionId设置创建时间，创建人，更新时间，更新人
	 * @param o 实体
	 * @param sessionID 
	 */
	public static void setWho(AbstractEntity o,String sessionID) {
		UserVo user = (null == getCurrentUser(sessionID) ? getAutoRunUser() : getCurrentUser(sessionID));
		if(null == o.getId() || o.getId().longValue()<=0L) {
			o.setCreatedBy(user.getId());
			o.setCreatedTime(DateUtils.now());
		}
		o.setLastUpdateBy(user.getId());
		o.setLastUpdateTime(DateUtils.now());
	}
	
	/**
	 * 获取当前登录人信息
	 * @return
	 */
	public static UserVo getCurrentUser() {
		HttpSession session = getSession();
		return (UserVo) session.getAttribute(SystemConst.USER_SESSION_KEY);
	}
	
	
	/**
	 * 根据sessionId获取当前登录人的信息
	 * @param sessionID
	 * @return
	 */
	public static UserVo getCurrentUser(String sessionID) {
		HttpSession session = getSession();
		Object value = session.getAttribute(SystemConst.USER_SESSION_KEY);
		if(null == value) {
			value = RedisCache.get(SystemConst.USER_SESSION_KEY + sessionID, User.class);
		}
		return (UserVo) value;
	}
	
	public static UserVo getAutoRunUser() {
		return new UserVo();
	}

}
