<%@page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>head</title>
<%@ include file="/ybl4.0/admin/common/link.jsp" %> 
</head>
<script type="text/javascript">
$(function(){
	$('.lobtn').hover(function() {
		$('.lobtn').removeClass('bl-login-btn');
		$(this).toggleClass('bl-login-btn');
		$('.lobtn').addClass('color-white');
		$(this).removeClass('color-white')
	})
})
</script>
<body>
		<div class="ybl-nav">
			<div class="w1200">
				<img src="/ybl4.0/resources/images/com-logo.png" class="logo" />
				<c:if test="${empty user_session }">
				<div class="fr"><a class="bl-login-btn mr20 lobtn" href="/loginV4Controller/toLogin.htm">登录</a>
				<a class="color-white lobtn" href="/loginV4Controller/toRegister.htm">注册</a></div>
				</c:if>
				<nav class="navbar navbar-default navbar-mobile bootsnav fr">
					<div class="collapse navbar-collapse" id="navbar-menu">
						<ul class="nav navbar-nav" data-in="fadeInDown" data-out="fadeOutUp">
							<li>
								<a href="/loginV4Controller/index.htm">首页</a>
							</li>
							<li>
								<a href="/factorConsultationController/blzxIndex.htm">保理咨询</a>
							</li>
							<li>
								<a href="/loginV4Controller/businessIntroduction.htm">业务介绍</a>
							</li>
							
							<li>
								<a href="/loginV4Controller/toAboutUs.htm">关于我们</a>
							</li>
							<c:if test="${not empty user_session }">
							<li>
								<a href="/ybl4.0/admin/doorl/memberCenter.jsp">账户中心</a>
							</li>
							</c:if>
						</ul>
					</div>
				</nav>
								
			</div>
		</div>
</body>
</html>
