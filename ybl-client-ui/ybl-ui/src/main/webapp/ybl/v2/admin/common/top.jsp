<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				  window.location.href='/loginV2Controller/logout';
			  });
		  });
	  });
	</script>
</head>
<body>
		<!--top-->
		<div class="v2_top">
			<div class="v2_top_contact">
				<div class="v2_top_contact_l">
					<ul>
						<li><span class="v2_t_phone v2_top_ico"></span> <span><spring:message
								code="sys.v2.client.service.hotline" /> <!-- 服务热线 -->
							：</span><span url="/configController/get-SYSTEM_SETTING_TYPE/service_hot_line"
										textField="value_"/></span></li>
					</ul>
				</div>
				<div class="v2_top_contact_r">
					<ul>
						<li><a href="/ybl4.0/admin/doorl/memberCenter.jsp" >账户中心 <!-- 欢迎您 --></a></li>
						<li><a href="javascript:void(0);"><spring:message
									code="sys.v2.client.welcome" /> <!-- 欢迎您 --> ，${user_session.userName}</a></li>
						<li><a href="/v2messageController/messageList.htm?isRead=N"  class="v2_top_ico v2_t_letter"><b ajaxUrl="/v2messageController/getInboxCount?isRead=N"  class="count_data">0</b></a></li>
						<li><a href="javascript:;" id="logout"><span
								class="v2_top_ico v2_t_quit"></span> <spring:message
									code="sys.v2.client.logout" /> <!-- 退出 --> </a></li>
					</ul>
				</div>
			</div>
		</div>
		<!--top-->
		<!--logo+menu-->
		<c:if test="${type=='supplier'}">
			<!-- supplier:供应商 -->
			<jsp:include
				page="/ybl/v2/admin/topPage/supplierTopV2.jsp?step=${step}" />
		</c:if>
		<c:if test="${type=='factor'}">
			<!-- factor:保理商 -->
			<jsp:include
				page="/ybl/v2/admin/topPage/factorTopV2.jsp?step=${step}" />
		</c:if>
		<c:if test="${type=='enterprise'}">
			<!-- enterprise:核心企业 -->
			<jsp:include
				page="/ybl/v2/admin/topPage/enterpriseTopV2.jsp?step=${step}" />
		</c:if>
		<!--logo+menu-->
</body>
</html>
