package com.bpm.framework.controller;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;

import com.bpm.framework.SystemConst;
import com.bpm.framework.exception.utils.ExceptionUtils;
import com.bpm.framework.utils.HttpUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.ybl.sys.util.trade.ResBody;

public abstract class AbstractController implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2993228366654823174L;

	protected final Logger log = LoggerFactory.getLogger(getClass());

	protected HttpServletRequest getRequest() {
		return ControllerUtils.getRequest();
	}

	protected HttpSession getSession() {
		return ControllerUtils.getSession();
	}

	protected <T> T getParameter(String key, Class<T> clazz) {
		return HttpUtils.getValue(this.getRequest(), key, clazz);
	}

	protected <T> T getParameterNotNull(String key, Class<T> clazz) {
		return HttpUtils.getValueNotNull(this.getRequest(), key, clazz);
	}

	protected String getParameter(String key) {
		return HttpUtils.getValue(this.getRequest(), key, String.class);
	}

	protected String getParameterNotNull(String key) {
		return HttpUtils.getValueNotNull(this.getRequest(), key, String.class);
	}

	protected String getText(String code) {
		return I18NUtils.getText(code);
	}

	protected String getText(String code, String defaultValue) {
		return I18NUtils.getText(code, defaultValue);
	}

	protected String getText(String code, Object[] args) {
		return I18NUtils.getText(code, args);
	}

	protected String getText(String code, List<?> args) {
		return I18NUtils.getText(code, args);
	}

	protected String getText(String code, Object[] args, String defaultValue) {
		return I18NUtils.getText(code, args, defaultValue);
	}

	protected String getText(String code, List<?> args, String defaultValue) {
		return I18NUtils.getText(code, args, defaultValue);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true)); // true:允许输入空值，false:不能为空值
	}

	/**
	 * 判断当前是否成功
	 * 
	 * @param resBody
	 * @return
	 */
	protected Boolean isSuccess(ResBody resBody) {
		if (resBody.getSys() != null) {
			String status = resBody.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				return true;
			}
		}
		return false;
	}

	@ExceptionHandler
	public void exception(HttpServletRequest request, HttpServletResponse response, Exception e) {
		log.error("异常",e);
		try {
			String ex = ExceptionUtils.getStackTrace(e);
			String header = request.getHeader("X-Requested-With");  
			boolean isAjax = "XMLHttpRequest".equals(header) ? true:false;  
			if (isAjax) {
				ControllerResponse cr = new ControllerResponse(ResponseType.ERROR);
				cr.setInfo(ex);
				response.setCharacterEncoding(SystemConst.ENCODING_UTF8);
				response.getOutputStream().print(JsonUtils.fromObject(cr));
			}else {
				response.sendRedirect("/gatewayController/error.htm?msg="+ex);
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	} 
}
