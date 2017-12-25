<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%-- 公共jsp,一般用于session跳转等 --%>
<%
	Object sessionUser = session.getAttribute("user_session");
	if(sessionUser==null){
		//使用js window.top进行跳转,防止页面iframe跳转到登录页
		out.print("<script type='text/javascript'>window.top.location.href='/';</script>");
	}
%>

