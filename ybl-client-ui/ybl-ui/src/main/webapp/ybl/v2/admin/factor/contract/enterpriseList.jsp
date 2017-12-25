<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.factor.index" /></title>
<link href="/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/ybl/resources/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
function searchData(){
	$("#pageForm").submit();
}
function selectEnterprise(id,name){
	<c:if test="${type == 'supplier'}">
		$("#supplierEnterpriseId", window.parent.document).val(id);
		$("#supplierEnterpriseName", window.parent.document).val(name);
		parent.$("#supplierEnterpriseName").validationEngine('validate');
	</c:if>
	<c:if test="${type == 'enterprise'}">
		$("#coreEnterpriseId", window.parent.document).val(id);
		$("#coreEnterpriseName", window.parent.document).val(name);
		parent.$("#coreEnterpriseName").validationEngine('validate');
	</c:if>
	parent.$(".v2_msgbox_close").mousedown();
}
</script>
</head>
<body class="v2_no_minwidth bg_w">
	<div class="v2_window v2_w1">
		<div class="v2_window_con">
			<form action="/contract/enterprisePage" method="post" id="pageForm">
			<input type="hidden" name="type" value="${type }">
			<div class="v2_t_seach">
				<span>
					<c:if test="${type == 'supplier'}"><spring:message code="sys.v2.client.contract.supplier.name" /> </c:if>
					<c:if test="${type == 'enterprise'}"><spring:message code="sys.v2.client.contract.core.name" /> </c:if>
				</span><input type="text" name="enterpriseName" value="${enterpriseName }" class="v2_text w200 fl" />
				<div class="v2_button_seach fl v2_t_but">
					<a onclick="searchData();"><spring:message code="sys.v2.client.query" /></a>
				</div>
			</div>
			<div class="v2_table_box">
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<c:if test="${type == 'supplier'}">
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /></th>
							<th width="160"><spring:message code="sys.v2.client.contract.supplier.fullname" /></th>
							<th width="200"><spring:message code="sys.v2.client.contract.supplier.name" /></th>
						</tr>
						</c:if>
						<c:if test="${type == 'enterprise'}">
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /></th>
							<th width="160"><spring:message code="sys.v2.client.contract.core.fullname" /></th>
							<th width="200"><spring:message code="sys.v2.client.contract.core.name" /></th>
						</tr>
						</c:if>
						<c:forEach var="obj" items="${enterpriseList}" varStatus="index" >
						<tr>
							<td>${index.count}</td>
							<td class="lan"><a class="lan" onclick="selectEnterprise('${obj.id}','${obj.enterpriseFullName}')"> ${obj.enterpriseFullName }</a></td>
							<td>${obj.enterpriseName }</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!--page start -->
			<jsp:include page="/ybl/v2/admin/common/popupPage.jsp" />
			<!--page end -->
			</form>
		</div>
	</div>
</body>
</html>