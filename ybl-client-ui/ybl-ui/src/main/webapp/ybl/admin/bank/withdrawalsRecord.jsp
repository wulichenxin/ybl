<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.withdrawals.record"/></title><!-- 提现记录 -->
<jsp:include page="../common/link.jsp" />
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path"><!-- 当前位置->账户中心 -> 账户总览 ->提现 ->提现记录 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.account.center"/>-> 
		<spring:message code="sys.client.account.overview"/>->
		<spring:message code="sys.client.withdrawals"/>->
		<spring:message code="sys.client.withdrawals.record"/>
	</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.withdrawals.record"/><!-- 提现记录 -->
					</h1>
				</div>
				<form action="" method="post"
							id="pageForm">
				<div class="vip_table">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.client.no"/><!-- 序号 --></th>
							<th><spring:message code="sys.client.withdrawals.amount"/><!-- 提现金额(万元) --></th>
							<th><spring:message code="sys.client.withdrawals.time"/><!-- 提现时间 --></th>
							<th><spring:message code="sys.client.withdrawals.status"/><!-- 提现状态 --></th>
						</tr>
						<c:forEach var="data" items="${widthdralRecordList}" varStatus="index">
							<tr ${index.count%2==0?'class="bg_l"':''}>
								<td>${index.count}</td>
								<td><fmt:formatNumber value="${data.amount/10000}" pattern="#,##0.00" maxFractionDigits="2"/></td>
								<td><fmt:formatDate value="${data.createdTime}"
												pattern="yyyy-MM-dd" /></td>
								<td class="lan">
									<c:if test="${data.status=='success'}"><spring:message code="sys.client.success"/><!-- 成功 --></c:if>
									<c:if test="${data.status=='fail'}"><spring:message code="sys.client.fail"/><!-- 失败 --></c:if>
									<c:if test="${data.status=='processing'}"><spring:message code="sys.client.processing"/><!-- 处理中 --></c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../common/page.jsp"></jsp:include>
				</form>
			</div>
		</div>
	</div>
	<!--conover-->
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>