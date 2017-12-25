package com.bpm.framework.controller.i18n;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.bpm.framework.controller.AbstractController;

/**
 * 
 * 全局语言设置Controller
 * 
 * @author lixx
 * @createDate 2015-03-12 13:32:00
 */
@Controller
@RequestMapping(value="/globalLanguageController")
public class GlobalLanguageController extends AbstractController {

	private static final long serialVersionUID = 1598448196929717508L;
	
	@RequestMapping(value="/setLanguage", method = {RequestMethod.GET, RequestMethod.POST})
    public String setLanguage(HttpServletRequest request, @RequestParam(value="local", defaultValue="zh_CN") String local) {
		String[] locals = local.split("_");
		Locale locale;
		if(locals[0].equals("zh") && locals[1].equals("HANS")){   //  针对IE11 的中文语言编码做特殊处理  lijing 2015.07.10
			locale = new Locale("zh", "CN");
		}else{
			locale = new Locale(locals[0], locals[1]);
		}
		request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);

		return "redirect:/index.jsp";
    }
}
