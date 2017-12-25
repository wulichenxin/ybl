package cn.sunline.framework.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bpm.framework.controller.AbstractController;

/**
 * @author guotai guotai@sunline.cn
 * @version 1.0.0
 * @date 2017年2月27日
 */
@Controller
@RequestMapping("/indexController")
public class IndexController extends AbstractController {

    private static final long serialVersionUID = 1L;

    //关于我们
    @RequestMapping("/about.htm")
    public String toAbout() {
        return "ybl/admin/index/about";
    }
    //首页
    @RequestMapping("/login.htm")
    public String toLogin() {
        return "ybl/admin/index/login";
    }

    //重置密码页面
    @RequestMapping("/resetPassword.htm")
    public String toResetPassword() {
        return "ybl/admin/index/resetPassword";
    }

    /**
     * 查询当前用户有操作权限的菜单
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAccessMenu")
    public String queryAccessMenu() {
        String menuJson = "{\n" +
                "    \"info\": \"操作成功。\", \n" +
                "    \"object\": [\n" +
                "        {\n" +
                "            \"attribute1\": \"iconLeft1\", \n" +
                "            \"enable\": true, \n" +
                "            \"id\": 2, \n" +
                "            \"menuCode\": \"0001\", \n" +
                "            \"menuName\": \"用户管理\", \n" +
                "            \"parentId\": 1, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1, \n" +
                "            \"url\": \"/userController/userManage\"\n" +
                "        }, \n" +
                "        {\n" +
                "            \"attribute1\": \"iconLeft2\", \n" +
                "            \"enable\": true, \n" +
                "            \"id\": 1, \n" +
                "            \"menuCode\": \"0100\", \n" +
                "            \"menuName\": \"系统管理\", \n" +
                "            \"parentId\": 0, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1\n" +
                "        },\n" +
                "        {\n" +
                "            \"attribute1\": \"iconLeft1\", \n" +
                "            \"enable\": true, \n" +
                "            \"id\": 5, \n" +
                "            \"menuCode\": \"0005\", \n" +
                "            \"menuName\": \"角色管理\", \n" +
                "            \"parentId\": 1, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1, \n" +
                "            \"url\": \"/roleController/list.htm\"\n" +
                "        }, \n" +
                "        {\n" +
                "            \"attribute1\": \"iconLeft1\", \n" +
                "            \"enable\": true, \n" +
                "            \"id\": 4, \n" +
                "            \"menuCode\": \"0004\", \n" +
                "            \"menuName\": \"权限管理\", \n" +
                "            \"parentId\": 1, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1, \n" +
                "            \"url\": \"/permissionController/list.htm\"\n" +
                "        }, \n" +
                "        {\n" +
                "            \"attribute1\": \"iconLeft1\", \n" +
                "            \"enable\": true, \n" +
                "            \"id\": 3, \n" +
                "            \"menuCode\": \"0003\", \n" +
                "            \"menuName\": \"部门管理\", \n" +
                "            \"parentId\": 1, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1, \n" +
                "            \"url\": \"/departmentController/depetManage\"\n" +
                "        }, \n" +
                "        {\n" +
                "            \"enable\": true, \n" +
                "            \"id\": 44, \n" +
                "            \"menuCode\": \"0109\", \n" +
                "            \"menuName\": \"菜单管理\", \n" +
                "            \"parentId\": 1, \n" +
                "            \"rowNo\": 0, \n" +
                "            \"show\": 1, \n" +
                "            \"sortNo\": 1, \n" +
                "            \"url\": \"/menuController/menuManage\"\n" +
                "        }\n" +
                "    ], \n" +
                "    \"responseType\": \"SUCCESS\", \n" +
                "    \"responseTypeCode\": \"success\", \n" +
                "    \"success\": true\n" +
                "}";
        return menuJson;

    }

}
