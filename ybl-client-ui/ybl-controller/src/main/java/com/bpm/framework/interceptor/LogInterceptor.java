package com.bpm.framework.interceptor;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bpm.framework.annotation.Log;
import com.bpm.framework.constant.Browser;
import com.bpm.framework.constant.OperatingSystem;
import com.bpm.framework.constant.UserAgent;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.common.LogAddressCommon;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.UserOPeratorLog;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 日志拦截器，处理日志入库
 * 
 * @author andyLee
 * @createDate 2017-05-09 13:55:00
 */
public class LogInterceptor implements HandlerInterceptor  {

	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 
	 * 方法执行之前
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return true;
	}

	/**
	 * 
	 * 方法执行之后
	 * 
	 */
	@Override
	public void postHandle(final HttpServletRequest request, HttpServletResponse response, final Object handler,
			final ModelAndView modelAndView) throws Exception {
		if(!(handler instanceof HandlerMethod)) {
			return;
		}
		final UserVo user = ControllerUtils.getCurrentUser();
		if(null==user)
		{
			return;
		}
		  new Thread(new Runnable() {
				
				@Override
				public void run() {
					HandlerMethod method = (HandlerMethod) handler;
					Log log = method.getMethodAnnotation(Log.class);
					if(null == log) return;
					String methodName = method.getMethod().getName();
					String clazzName = method.getBeanType().getName();
					MethodParameter[] methodParams = method.getMethodParameters();
					String buffer = JsonUtils.fromObject(methodParams);
					String operation = log.operation().getName(log.operation().name());
					String info = log.info();
					String ip = LogAddressCommon.getAddress();
					/* 获取当前操作设备的操作系统 */
					String operatorSystem = "";
					operatorSystem = System.getProperty("os.name");
					UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("user-agent"));   
					Browser browser =null;
					OperatingSystem os = null;
					if(userAgent !=null)
					{
						browser = userAgent.getBrowser();    
						os = userAgent.getOperatingSystem();  
					}
					 //获取当前操作设备的操作终端 
					String operatorTerminal = "pc";
					boolean isMoblie =LogAddressCommon.isRealMobile(request);
					if(isMoblie){
						operatorTerminal="移动客户端";
					}
					String operator = "操作人："+user.getUserName()+",操作时间:"+DateUtils.toString(DateUtils.now())+",ip地址:"+ip+",客户端浏览器信息:"+request.getHeader("user-agent")+",操作系统"+os+",操作内容:"+info
							+",操作路径:"+clazzName+",操作方法:"+methodName;
					// 日志入库
					UserOPeratorLog operatorLog = new UserOPeratorLog();
					operatorLog.setEnable(1);
					operatorLog.setLoginIp(ip);
					operatorLog.setLoginTime(DateUtils.now());
					 //设置基本信息 
					operatorLog.setCreatedTime(DateUtils.now());
					operatorLog.setLastUpdateTime(DateUtils.now());
					operatorLog.setCreatedBy(user.getId());
					operatorLog.setLastUpdateBy(user.getId());
					operatorLog.setRemark(operator);
					operatorLog.setOperatorSystem(operatorSystem);
					operatorLog.setOperatorTerminal(operatorTerminal);
					operatorLog.setUserId(user.getId());
					operatorLog.setUserName(user.getUserName());
					operatorLog.setEnterpriseId(user.getEnterpriseId());
					operatorLog.setRequestParameter(buffer);
					operatorLog.setOperator(operation);
					operatorLog.setContext(info);
					// 调用服务，进行数据查询
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("paramter", operatorLog);
					map.put("sign", "insertUserOperatorLog");// 所调用的服务中的方法
					ResBody result = TradeInvokeUtils.invoke("V2UserOperatorLog", map);
					if (result.getSys() != null) {
						String status = result.getSys().getStatus();
						String erortx = result.getSys().getErortx();// 错误信息
						if ("S".equals(status)) {// 交易成功
							logger.info("新增登录信息addUserLoginLog服务返回成功，信息：" + erortx);
						} else {
							logger.error("新增登录信息addUserLoginLog服务返回失败，信息：" + erortx);
						}
					}
				}
			}).start();
	}

	/**
	 * 
	 * 整个过程全部执行完之后
	 * 
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
