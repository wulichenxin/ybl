package com.bpm.framework.controller.common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;

import cn.sunline.framework.controller.vo.v2.TConfig;
import edu.emory.mathcs.backport.java.util.Arrays;

/**
 * 基础数据类型controller
 * 
 * @author jzx
 *
 */
@Controller
@RequestMapping({ "/configController" })
public class ConfigController extends AbstractController {

	private static final long serialVersionUID = 6756046553579471840L;

	/**
	 * 根据类型和代码查询基础数据类型
	 * 
	 * @param request
	 * @param response
	 * @param type
	 *            类型
	 * @param code
	 *            代码
	 * @return
	 */
	@ValidateSession(validate = false)
	@RequestMapping({ "get-{type}/{code}" })
	@ResponseBody
	public TConfig getByTypeCode(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type, @PathVariable("code") String code) {
		TConfig config = ConfigCache.getByTypeCode(type, code);
		return config;
	}

	/**
	 * 根据类型查询基础数据类型
	 * 
	 * @param request
	 * @param response
	 * @param type
	 *            类型
	 * @return
	 */
	@ValidateSession(validate = false)
	@RequestMapping({ "get-{type}" })
	@ResponseBody
	public List<TConfig> getByType(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) {
		List<TConfig> oList = ConfigCache.getByType(type);
		return oList;
	}

	/**
	 * 根据类型查询基础数据类型 --除去不需要的code值
	 * @param request
	 * @param response
	 * @param type
	 * @param exceptCodes  不需要的code值
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping({ "getExcept-{type}/{exceptCodes}" })
	@ResponseBody
	public List<TConfig> getByTypeExceptCode(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type, @PathVariable("exceptCodes")String exceptCodes) {
		List<TConfig> oList = ConfigCache.getByType(type);
		List<String> codes = Arrays.asList(exceptCodes.split(","));
		List<TConfig> returnList = new ArrayList<>();
		for(TConfig o : oList) {
			if(codes.contains(o.getCode())) {
				continue;
			}
			returnList.add(o);
		}
		return returnList;
	}
}