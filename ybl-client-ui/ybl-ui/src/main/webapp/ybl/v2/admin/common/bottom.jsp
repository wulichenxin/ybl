<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>bottom</title>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"/>
<style>
.v2_foot_pos{ position:fixed; bottom:0px; }
</style>
</head>

<body>
<div class="v2_foot_bottom v2_foot_pos">
     <p>
     <span id="copyrightSpan"></span>
    </p>
</div>
<script>
$(function(){
	$.ajax({
        type: "POST",
        url: '/configController/get-SYSTEM_SETTING_TYPE/copy_right',
        async:true,
        data: [],
        success: function(data){
        	$("#copyrightSpan").html(data['value_']);
        }
     });
	
	var min_height = $('body').height();
	$(window).scroll(function() {
		//获取窗口的滚动条的垂直位置      
		var s = $(window).height();
		//当窗口的滚动条的垂直位置大于页面的最小高度时 
		if (s < min_height) {
			$(".v2_foot_bottom").removeClass("v2_foot_pos");
			
		} else {
		   $(".v2_foot_bottom").addClass("v2_foot_pos");
		};
	});
	if($(".v2_foot_bottom")) {
		$('body').height(min_height + 60);// 60为bottom的高度
	}
	
	//公共部分   动态加载二级菜单和默认一级，二级菜单选中
	var menustr = '${sessionScope.user_menu}';
	if(menustr){
		var firstLevelId = '';
		var secondLevelId = '';
		var parentId = '';
		//根据当前url确定要加载的二级菜单
		var curHref=window.location.pathname;
		var tempCurHref = curHref.replace("/", "");
		var controllerBeanId = tempCurHref.substring(0, tempCurHref.indexOf("/"));
		var menu = eval(menustr);
		
		//是否是页面链接标识
		var isPageLink = true;
		
		for (var i = 0; i < menu.length; i++) {
			if(menu[i].url_.indexOf(curHref)>-1 && menu[i].parent_id ==0){
				isPageLink = false;
				firstLevelId = menu[i].attribute2_;
				continue;
			}
			if(menu[i].url_.indexOf(curHref)>-1 && menu[i].parent_id >0){
				isPageLink = false;
				secondLevelId = menu[i].parent_id;
				continue;
			}
			/** begin 如果上面两个全url没匹配上，则只用controllerBeanId匹配，主要处理一个页面多个按钮跳转刷新 */
// 			if(menu[i].url_.indexOf(controllerBeanId)>-1 && menu[i].parent_id ==0){
// 				firstLevelId = menu[i].attribute2_;
// 				continue;
// 			}
// 			if(menu[i].url_.indexOf(controllerBeanId)>-1 && menu[i].parent_id >0){
// 				secondLevelId = menu[i].parent_id;
// 				continue;
// 			}
			/** end 如果上面两个全url没匹配上，则只用controllerBeanId匹配，主要处理一个页面多个按钮跳转刷新 */
			
		}
		
		parentId = firstLevelId ? firstLevelId : secondLevelId;
		
		var ul =  $("<ul></ul>");
		var strs = '';
		//渲染菜单信息
		for (var i = 0; i < menu.length; i++) {
			//(1)加载一级菜单信息
			if(menu[i].parent_id == 0){
				var li = "<li><a id="+menu[i].attribute2_+"  href='"+menu[i].url_ +"'>"+menu[i].name_+"</a><div class='v2_navbg'></div></li>"
				ul.append(li);
			}
			
			if(!isPageLink){
				//加载二级菜单
				if(menu[i].parent_id == parentId){
					var str="<a parentId = "+menu[i].parent_id +" href='"+menu[i].url_+"'>"+menu[i].name_+"</a>";
					strs+=str;
				}
			}
		}
		$(".v2_nav").html(ul);
		$(".v2_z_navbox").html(strs);
		if(!isPageLink){
			/** 设置默认选中一级菜单 begin */
			$(".v2_nav ul li a").each(function() {
				var id = $(this).attr("id");
				if(parentId == id) {
					$(this).parent().addClass("now");
					return false;
				}
			});
			/** 设置默认选中一级菜单 end */
			
			/** 设置默认选中二级菜单 begin */
			$(".v2_z_navbox a").each(function() {
				var href = $(this).attr("href");
				if(curHref.indexOf(href) > -1) {
					$(this).addClass("now").siblings().removeClass("now");
					return false;
				}
				/** begin 如果上面两个全url没匹配上，则只用controllerBeanId匹配，主要处理一个页面多个按钮跳转刷新 */
				if(href.indexOf(controllerBeanId) > -1) {
					$(this).addClass("now");
					return true;
				}
				/** end 如果上面两个全url没匹配上，则只用controllerBeanId匹配，主要处理一个页面多个按钮跳转刷新 */
			});
			/** 设置默认选中二级菜单 end */
		
		}
		
	}
	
});	
</script>

</body>
</html>