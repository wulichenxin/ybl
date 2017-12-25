<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<%@include file="/ybl4.0/admin/common/link.jsp" %>
		<p class="per_title"><span>我的消息</span></p>
		<div class="pd20">
			<p class="regtitle2">注册成功<a class="goback" href="/myMessageV4Controller/messageList.htm"><img src="/ybl4.0/resources/images/my/zjf_back_icon.png" /></a></p>
			<p><span class="mr30">发件人：平台</span><span class="mr10"><fmt:formatDate value="${stationMessage.createdTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></span>  <span>来源：</span><span>普通消息</span></p>
			<div class="text-cont">
				${stationMessage.content}
			</div>
		</div>	
	</body>
</html>
