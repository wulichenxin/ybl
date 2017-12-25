<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>left</title>
</head>
<body>
	<div class="vip_leftmenu">
		<ul>
			<li <c:if test="${step==0}">class="now"</c:if>>
				<a href="/accountOverview/queryAccountOverview">
					<span class="left_menuico1"><spring:message code="sys.client.account.overview"/></span><!-- 账户总览 -->
				</a>
			</li>
			<li <c:if test="${step==1}">class="now"</c:if>>
				<a href="/enterpriseController/toRoleAuth">
					<span class="left_menuico2"><spring:message code="sys.client.role.auth"/></span><!-- 角色认证 -->
				</a>
			</li>
			<li <c:if test="${step==2}">class="now"</c:if>>
				<a href="/messageController/messageList">
					<span class="left_menuico3"><spring:message code="sys.client.message.center"/></span><!-- 消息中心 -->
				</a>
			</li>
		</ul>
	</div>
</body>
</html>

