package cn.sunline.framework.controller.systemadmin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年2月27日
 * @version 1.0.0
 */
@Controller
@RequestMapping("systemController")
public class SystemController {
	
	@RequestMapping("userManage.htm")
	public String toUserManage(){
		return "p2p/admin/systemadmin/userManage";
	}
	
	@RequestMapping("addUser.htm")
	public String toAddUser(){
		return "p2p/admin/systemadmin/addUser";
	}

}
