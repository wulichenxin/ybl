<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8"
	deferredSyntaxAllowedAsLiteral="true"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>head</title>
<%@include file="/ybl4.0/admin/common/link.jsp" %>
<script type="text/javascript">
	  $(function(){
		  $("#logout").click(function(){
			  confirm("确定退出登录？",function(){
				  window.location.href='/loginV4Controller/logout';
			  });
		  });
	  });
	</script>
</head>
<body>
	<div class="ybl-head">
			<div class="w1200 clearfix">
				<div class="fl">
					<img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-86726640
					<%-- 欢迎您！<span class="username">${user_session.userName }</span><span class="notice-sp"><img class="notice-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span> --%>
				</div>
				<div class="fr">
					欢迎您！<span class="username">${user_session.userName }</span>
					<img class="userAvatar" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span>
					<a class="dropOut" href="javascript:;" id="logout">退出</a>
				</div>
			</div>
		</div>

		<div class="ybl-nav">
			<div class="w1200">
				<a href="/loginV4Controller/index.htm"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/com-logo.png" style="margin-top:13px;" class="logo"/></a>
				<nav class="navbar navbar-default navbar-mobile bootsnav fr">
					<div class="collapse navbar-collapse" id="navbar-menu">
						<ul class="nav navbar-nav" data-in="fadeInDown" data-out="fadeOutUp">
							<li><a href="/loginV4Controller/index.htm">首页</a></li>
							<li><a href="/factorConsultationController/blzxIndex.htm">保理咨询</a></li>
							<li><a href="/loginV4Controller/businessIntroduction.htm">业务介绍</a></li>
							<li><a href="/gatewayController/toAboutUs.htm">关于我们</a></li>
							<li><a href="/ybl4.0/admin/doorl/memberCenter.jsp">账户中心</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
</body>
</html>