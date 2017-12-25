<%@page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>head</title>
</head>
<body>
	<div class="headnav">
		<div class="w1200 clearfix">
			<img class="fl logo" src="/ybl4.0/resources/images/logo_img.png" />
			<c:if test="${empty user_session }">
			<div class="clearfix fr ml30">
				<a class="fl login-btn btn-cur"  href="/loginV4Controller/toLogin.htm">登录</a>
				<a class="fl login-btn" href="/loginV4Controller/toRegister.htm">注册</a>
			</div>
			</c:if>
			<ul class="clearfix fr">
				<li class="navlist">
					<a href="/loginV4Controller/index.htm">首页</a>
				</li>
				<li class="navlist">
					<a href="/factorConsultationController/blzxIndex.htm">保理咨询</a>
				</li>
				<li class="navlist">
					<a href="/loginV4Controller/businessIntroduction.htm">业务介绍</a>
				</li>
				<li class="navlist">
					<a href="/loginV4Controller/toAboutUs.htm">关于我们</a>
				</li>
				<c:if test="${not empty user_session }">
				<li  class="navlist">
					<a href="/ybl4.0/admin/doorl/memberCenter.jsp">账户中心</a>
				</li>
				</c:if>
			</ul>

		</div>
	</div>
</body>
</html>
