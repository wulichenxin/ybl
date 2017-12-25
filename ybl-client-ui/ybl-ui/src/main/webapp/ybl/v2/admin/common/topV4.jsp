<%@page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>head</title>
</head>
<body>
		<div class="v2_head_top">
			<div class="v2_head v2_hover_bg">
			<div class="v2_top_head">
				<div class="v2_logo"><a href="/gatewayController/index.htm"></a></div>
				<div class="v2_nav">
					<ul>
						<li <c:if test="${step eq '1'}"> class="now"</c:if>><a href="">访客登录</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '2'}">class="now"</c:if>><a href="">融资方登录</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '3'}">class="now"</c:if>><a href="">资金方登录</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '4'}">class="now"</c:if>><a href="">核心企业登录</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '5'}"> class="now"</c:if>><a href="/gatewayController/index.htm">返回首页</a><div class="v2_navbg"></div></li>
					</ul>
				</div>
				
			</div>
			</div>
			<div class="v2_head_line"></div>
		</div>
</body>
</html>
