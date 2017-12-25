<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.contract" /></title>
<!-- 保理商首页 -->
<jsp:include page="/ybl/v2/admin/common/link.jsp" />
<script type="text/javascript">
	function searchData(){
		$("#pageForm").submit();
	}
</script>
</head>
<body>
<form action="/contract/contractPage" id="pageForm" method="post">
<div class="v2_top_bg v2_t_bg2">
	<div class="v2_top_con">
		<div class="v2_head_top">
			<!--top start -->
			<%@include file="/ybl/v2/admin/common/top.jsp" %>
			<!--top end -->
		</div>
		<!---->
		<div class="v2_path"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.contract" /></div>
		<!--搜索条件-->
		<div class="v2_seach_box">
			<ul>
				<li class="ww28"><label><spring:message code="sys.v2.client.core.enterprise" />:</label><input type="text" name="coreEnterpriseName" value="${contract.coreEnterpriseName }"/></li>
				<li class="ww28"><label><spring:message code="sys.v2.client.supplier" />:</label><input type="text" name="supplierEnterpriseName" value="${contract.supplierEnterpriseName }" /></li>
				<li class="ww28"><label><spring:message code="sys.v2.client.contract.fund.source" />:</label><input type="text" name="fundSourceName" value="${contract.fundSourceName }" /></li>
				<li class="ww28"><label><spring:message code="sys.v2.client.contract.number" />:</label><input type="text" name="number" value="${contract.number }" /></li>
				<li class="ww28"><label><spring:message code="sys.v2.client.status" />:</label>
						<select name="status" url="/configController/get-CONTRACT_STATUS"
											valueFiled="code_" textField="value_"
											defaultValue="${contract.status}" isSelect="Y"></select></li>
				<li><div class="v2_button_seach">
						<a href="javascript:void(0);" onclick="searchData()"><spring:message code="sys.v2.client.query" /></a>
					</div>
				</li>
			</ul>
		</div>
		<!--搜索条件-->
	</div>	
</div>	
		
	<div class="v2_vip_conbody">
		
		<!--table-->
		<div class="v2_table_box">
			<div class="v2_table_top">
				<div class="v2_table_nav">
					<ul>
						<li><a href="/contract/contractEdit" class="v2_but_add"><spring:message code="sys.v2.client.add" /></a></li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="50"><spring:message code="sys.v2.client.no" /></th>
						<th width="160"><spring:message code="sys.v2.client.contract.number" /></th>
						<th width="135"><spring:message code="sys.v2.client.core.enterprise" /></th>
						<th width="135"><spring:message code="sys.v2.client.supplier" /></th>
						<th width="130"><spring:message code="sys.v2.client.factor" /></th>
						<th><spring:message code="sys.v2.client.contract.fund.source" /></th>
						<th width="160"><spring:message code="sys.v2.client.contract.person" /></th>
						<th width="100"><spring:message code="sys.v2.client.contract.end.date" /></th>
						<th width="100"><spring:message code="sys.v2.client.status" /></th>
						<th><spring:message code="sys.v2.client.operation" /></th>
					</tr>
					<c:forEach var="obj" items="${contractList}" varStatus="index" >
					<tr>
						<td>${index.count}</td>
						<td><a class="lan" href="/contract/contractDetails?contractId=${obj.id }">${obj.number }</a></td>
						<td>${obj.coreEnterpriseName }</td>
						<td>${obj.supplierEnterpriseName }</td>
						<td>${obj.enterpriseName }</td>
						<td>${obj.fundSourceName }</td>
						<td>${obj.contractPerson }</td>
						<td><fmt:formatDate value="${obj.endTime }" pattern="yyyy-MM-dd"/> </td>
						<td url="/configController/get-CONTRACT_STATUS/${obj.status}" textField="value_"></td>
						<td><c:if test="${obj.status == 'inoperative' || obj.status == 'effecting' }"><a class="lan" href="/contract/contractEdit?contractId=${obj.id }"><spring:message code="sys.v2.client.edit" /></a></c:if></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<!--page start -->
		<jsp:include page="/ybl/v2/admin/common/page.jsp" />
		<!--page end -->
		<!--table-->
		
	</div>
	</form>
	<!-- bottom.jsp -->
	<jsp:include page="/ybl/v2/admin/common/bottom.jsp" />
	<!-- bottom.jsp -->
</body>
</html>