<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top'}">
	<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
	<jsp:include page="/ybl/admin/common/link.jsp" />
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<div class="body_con">
</c:if>
<div class="content">
	<div class="about_box">
		<h1><span></span>免责声明</h1>
		<div class="about_lr">${responsible.content }</div>
	</div>
</div>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top'}">
	</div>
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
</c:if>