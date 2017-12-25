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
<script type="text/javascript">
	  $(function(){
		  $("#logout").click(function(){
			  confirm("确定退出登录？",function(){
				  window.location.href='/loginController/logout';
			  });
		  });
	  });
	</script>
</head>
<body>
	<div class="head_top">
		<div class="top">
			<div class="top_contact">
				<div class="top_contact_l">
					<ul>
						<li><span class="t_phone"></span>
							<spring:message code="sys.client.service.hotline"/><!-- 服务热线 -->：0755-82989066</li>
					</ul>
				</div>
				<c:if test="${not empty user_session}">
					<div class="top_contact_r">
						<ul>
							<li><a href="#">
								<spring:message code="sys.client.welcome"/><!-- 欢迎您 -->，${user_session.userName}</a></li>
							<li><a href="/indexController/resetPassword.htm" class="top_c1">
								<spring:message code="sys.client.update.password"/><!-- 修改密码 --></a></li>
							<li><a href="javascript:;" id="logout" class="top_c2">
								<spring:message code="sys.client.logout"/><!-- 退出 --></a></li>
	
						</ul>
					</div>
				</c:if>
			</div>
		</div>

		<c:if test="${type=='member' ||type==null||type==''}"><!-- visitor:未认证角色 -->
			<jsp:include page="../accountCenter/accountCenter/visitorTop.jsp"/>
		</c:if>
		<c:if test="${type=='supplier'}"><!-- supplier:供应商 -->
			<jsp:include page="../accountCenter/accountCenter/supplierTop.jsp?step=${step}"/>
		</c:if>
		<c:if test="${type=='factor'}"><!-- factor:保理商 -->
			<jsp:include page="../accountCenter/accountCenter/factorTop.jsp?step=${step}"/>
		</c:if>
		<c:if test="${type=='enterprise'}"><!-- enterprise:核心企业 -->
			<jsp:include page="../accountCenter/accountCenter/enterpriseTop.jsp?step=${step}"/>
		</c:if>
	</div>
</body>
</html>
