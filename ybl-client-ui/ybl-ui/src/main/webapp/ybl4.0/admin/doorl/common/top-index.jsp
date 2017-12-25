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
		<div class="w1200 clearfix" style="position:relative">
			<img class="fl logo" src="/ybl4.0/resources/images/logo_img.png" />
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
				<%-- <c:if test="${not empty user_session }">
				<li  class="navlist">
					<a href="/ybl4.0/admin/doorl/memberCenter.jsp">账户中心</a>
				</li>
				</c:if> --%>
				<c:choose>
				   <c:when test="${'supplier' eq user_session.status && not empty user_session }">
				   <li  class="navlist">  
				      <a href="/ybl4.0/admin/supplier/memberCenter.jsp">账户中心</a>   
				   </li> 
				   </c:when>
				   <c:when test="${'financil' eq user_session.status && not empty user_session }">
				   <li  class="navlist">  
				      <a href="/ybl4.0/admin/factor/memberCenter.jsp">账户中心</a>   
				   </li> 
				   </c:when>
				   <c:when test="${'enterprise' eq user_session.status && not empty user_session }">
				   <li  class="navlist">  
				      <a href="/enterpriseIndexV4Controller/accountCenter.htm">账户中心</a>   
	  				</li> 
				   </c:when>
				   <c:when test="${not empty user_session }">  
				   <li  class="navlist">
				      <a href="/ybl4.0/admin/doorl/memberCenter.jsp">账户中心</a> 
				    </li> 
				   </c:when>
				</c:choose>
			</ul>
			<c:if test="${empty user_session }">
				<div class="poabRight">
					<p>专业的保理平台</p>
					<p class="homep">诚邀你的加入</p>
					<div class="homebtn clearfix">
						<a href="/loginV4Controller/toLogin.htm">马上登录</a>
						<a href="/loginV4Controller/toRegister.htm">免费注册</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>
