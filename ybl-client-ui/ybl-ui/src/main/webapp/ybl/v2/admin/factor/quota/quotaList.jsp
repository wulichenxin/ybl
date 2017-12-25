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
<title><spring:message code="sys.v2.client.quota.mamage" /></title>
<!-- 保理商首页 -->
<jsp:include page="/ybl/v2/admin/common/link.jsp" />
<script type="text/javascript">
	function searchData(){
		$("#pageForm").submit();
	}
</script>
</head>
<body>
<form action="/contract/quotaPage" id="pageForm" method="post">
	<div class="v2_top_bg v2_t_bg2 ">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<!--top start -->
				<%@include file="/ybl/v2/admin/common/top.jsp" %>
				<!--top end -->
				<div class="v2_head_line"></div>
				<div class="v2_z_nav">
					<div class="v2_z_nav_con">
						<div class="v2_z_navbox">
							<a class="w130" href="/contract/contractQuotaPage"><spring:message code="sys.v2.client.contract.warning.amount.monitoring" /></a><a class="now" href="/contract/quotaPage"><spring:message code="sys.v2.client.quota.mamage" /></a><!-- <a href="强制出池.html">强制出池</a> -->
						</div>
					</div>
				</div>
			</div>
			<!---->
			<div class="v2_path"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.quota.mamage" /> > <spring:message code="sys.v2.client.quota.mamage" /></div>
			<!--搜索条件-->
			<div class="v2_seach_box">
				<ul>
					<li><label><spring:message code="sys.v2.client.core.enterprise" />:</label><input type="text" name="coreEnterpriseName" value="${contract.coreEnterpriseName }"/></li>
					<li><label><spring:message code="sys.v2.client.supplier" />:</label><input type="text" name="supplierEnterpriseName" value="${contract.supplierEnterpriseName }" /></li>
					<li><label><spring:message code="sys.v2.client.contract.fixed.amount" />:</label><span><input type="text" name="creditAmount" value="${contract.creditAmount }" class="w100"/></span><b><spring:message code="sys.v2.client.to" /></b><span><input type="text"  name="creditAmountMax" value="${contract.creditAmountMax }"  class="w100"/></span></li>
					<li><div class="v2_button_seach">
							<a href="javascript:void(0);" onclick="searchData()"><spring:message code="sys.v2.client.query" /></a>
						</div></li>
		
				</ul>
			</div>
			<!--搜索条件-->
		</div>
	</div>
	<div class="v2_vip_conbody">
		<!--table-->
		<div class="v2_table_box">
			<!--按钮top-->
			<div class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="50"><spring:message code="sys.v2.client.no" /></th>
						<th width="200"><spring:message code="sys.v2.client.core.enterprise" /></th>
						<th width="200"><spring:message code="sys.v2.client.supplier" /></th>
						<th width="160"><spring:message code="sys.v2.client.contract.fixed.amount.yuan" /></th>
						<th width="100"><spring:message code="sys.v2.client.contract.provisional.amount.yuan" /></th>
						<th width="100"><spring:message code="sys.v2.client.contract.deposit.amount.yuan" /></th>
						<th><spring:message code="sys.v2.client.operation" /></th>
					</tr>
					<c:forEach var="obj" items="${contractList}" varStatus="index" >
					<tr>
						<td>${index.count}</td>
						<td class="tl">${obj.coreEnterpriseName }</td>
						<td class="tl">${obj.supplierEnterpriseName }</td>
						<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.creditAmount }" /></td>
						<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.quota }" /></td>
						<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.deposit }" /></td>
						<td><a class="lan" href="/contract/quotaEdit?contractId=${obj.id }"><spring:message code="sys.v2.client.edit" /></a></td>
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