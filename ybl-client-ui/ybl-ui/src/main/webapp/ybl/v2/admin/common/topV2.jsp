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
			<!--top-->
			<!--logo+menu-->
			<div class="v2_head v2_hover_bg">
			<div class="v2_top_head">
				<div class="v2_logo"><a href="/gatewayController/index.htm"></a></div>
				<div class="v2_nav">
					<ul>
						<li <c:if test="${step eq '0'}"> class="now"</c:if>><a href="/gatewayController/index.htm">首页</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '1'}"> class="now"</c:if>><a href="/gatewayController/queryProduct.htm">保理咨询</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '2'}">class="now"</c:if>><a href="/gatewayController/businessIntroduction.htm">业务介绍</a><div class="v2_navbg"></div></li>
						<li <c:if test="${step eq '3'}">class="now"</c:if>><a href="/gatewayController/toAboutUs.htm">关于我们</a><div class="v2_navbg"></div></li>
						<li class="gatewayMenu">
							<div class="nav_login">
								<a href="/gatewayController/toLogin.htm"> <spring:message code="sys.v2.client.login" /></a>
							</div>
						</li>
						<li class="gatewayMenu">
							<div class="nav_login">
								<a href="/gatewayController/toRegister.htm"> <spring:message code="sys.v2.client.register" /></a>
							</div>
						</li>
					</ul>
				</div>
				
			</div>
			</div>
			<div class="v2_head_line"></div>
		</div>
</body>
<script type="text/javascript">
// 	$(function(){
// 		$(".gatewayMenu").click(function(){
// 			if($(this).hasClass("now")){
// 				return;
// 			}else{
// 				$(this).prevAll().removeClass("now");
// 				$(this).nextAll().removeClass("now");
// 				$(this).addClass("now")
// 			}
// 		})
// 	})
</script>


</html>
