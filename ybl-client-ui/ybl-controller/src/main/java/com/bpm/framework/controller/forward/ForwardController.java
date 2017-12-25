package com.bpm.framework.controller.forward;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bpm.framework.controller.AbstractController;

/**
 * 
 * spring mvc 国际化必须要通过控制层才能生效，所以所有界面跳转直接通过此Controller
 * 
 * @author lixx
 * @createDate 2015-03-13 17:05:00
 */
@Controller
@RequestMapping(value="/forwardController")
public class ForwardController extends AbstractController {

	private static final long serialVersionUID = 6525383312440780818L;
	
	@RequestMapping(value="/forward", method={RequestMethod.GET, RequestMethod.POST})
	public String forward() {
		String url = this.getParameterNotNull("__url");
		return url;
	}
}
