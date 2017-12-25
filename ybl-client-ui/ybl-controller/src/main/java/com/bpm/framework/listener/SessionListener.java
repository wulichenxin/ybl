package com.bpm.framework.listener;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.bpm.framework.SystemConst;
import com.bpm.framework.cache.redis.RedisCache;

import cn.sunline.framework.controller.vo.UserVo;

/**   
 * Filename:    SessionListener.java   
 * @version:    1.0   
 * @since:  JDK 1.7.0_25  
 * Create at:   2014年4月8日 上午10:33:57   
 * Description:  暂时无用
 *   
 */

public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {

	@Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
    	UserVo user = (UserVo) se.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
    	if(null == user) return;
    	se.getSession().removeAttribute(SystemConst.USER_SESSION_KEY);
    	if(RedisCache.exists(SystemConst.USER_SESSION_KEY + "#" + user.getId())) {
    		RedisCache.del(SystemConst.USER_SESSION_KEY + "#" + user.getId());
    	}
    }

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		UserVo user = (UserVo) event.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
    	if(null == user) return;
    	RedisCache.set(SystemConst.USER_SESSION_KEY + "#" + user.getId(), event.getSession().getId());
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
	}
}
