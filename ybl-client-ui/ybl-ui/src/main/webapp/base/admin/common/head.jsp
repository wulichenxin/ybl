<%@page import="org.slf4j.LoggerFactory"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
if(session.getAttribute("user_session")==null && !request.getRequestURL().toString().endsWith("/")) {
%>
 <script type="text/javascript">
	top.window.location.href='/index.jsp';
</script>
<%
	return;
} 
%>

<div class="top">
	<div class="top_contact">
		<div class="top_contact_l">
	    	<ul>
	        	<li>${app.appName }欢迎你</li>
	        </ul>
	    </div>
		<div class="top_contact_r">
			<ul>
				<li><a href="javascript:void();">欢迎您，【${user_session.userName}】 ${user_session.nick}</a></li>
				<%--
					<li><a href="javascript:void();"   onclick="openFramePage('30','账户中心','/fw/admin/user/usercenter.jsp')">账户中心</a></li>
				--%>
				<li><a href="javascript:void();"   onclick="openFramePage('30','个人中心','/userController/modifyPassword.htm')">密码修改</a></li>
				<li><a href="javascript:void();"  onclick="openFramePage('26','企业认证','/enterpriseController/getByUser.htm')">企业认证</a></li>
				<!-- <li><a href="" class="top_c1">修改密码</a></li> -->
	            <li><a href="/loginController/logout.htm" class="top_c2">退出</a></li>
			</ul>
		</div>
	</div>
</div>

<!--top-->
<!--logo+menu-->
<div class="head">
	<div class="top_head">
		<div class="logo"><a href="/fw/admin/common/index.jsp"></a></div>
		<div class="nav">
	    	<ul id="head-menu-ul">
	    		<!-- js 生成菜单 -->
	        </ul>
	    </div>
	</div>
</div>
<div class="news_box">
	<div class="news_list">
    	 <div class="news_ico">&nbsp;</div>
         <ul class="scroll_ul">
            <li><a>最新公告：长亮国融信催收宝隆重上线</a></li>
            <li><a>最新公告：最新公告2</a></li>
            <li><a>最新公告：最新公告3</a></li>
         </ul>
         <div class="time">${app.nowDate }</div>
	</div>
</div>
<!--公告完-->





<!--弹出窗登录-->

<div id="add" style="display:none;">
    <div class="t_window"></div>
    <div class="window_box">
    </div>
    </div>
</div>
 
 <script type="text/javascript">
<!--

//-->
</script>
