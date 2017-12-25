<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>长亮国信</title>
	<%@include file="/ybl4.0/admin/common/link.jsp" %> 
</head>

	<body>
		<!--弹出框-->
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
		<!--top end -->
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="images/rzf_bre_icon.png" />还款计划</div>
		</div>
		<!-- <form action="/supplierAccountCenterController/supplieroverdue.htm" id="pageForm" method="post"> -->
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请单号</th>
								<th>资金方</th>
								<th>核心企业</th>
								<th>第几期/总期数</th>
								<th>还款日期</th>
								<th>本期应还本金</th>
								<th>本期应还利息</th>
								<th>逾期天数</th>
								<th>逾期利息</th>
								<th>本期还款状态</th>
								<th>还款确认</th>
							</tr>
							<c:forEach items="${list}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="javascript:;" class="order-a">${obj.loanApplyOrderNo}</a></td>
									<td>${obj.financingName}</td>
									<td>${obj.coreEnterpriseName}</td>
									<td>${obj.period}</td>
									<td><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td><fmt:formatNumber value="${obj.repaymentInterest}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>${obj.overdueDays}</td>
									<td>${obj.attribute6 }</td>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 1}">待还款</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 2}">已还款未确认</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 3}">已逾期</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 4}">催收中</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 5}">坏账</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 6}">已还款已确认</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 6}">是</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus ne 6}">否</c:if>
									</td>
								</tr>
			              </c:forEach>
						</table> 
					</div>
				</div>
		<%-- <jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include> 
		</form>--%>
		</div>
		<script type="text/javascript">
			/* $('#beginDate,#endDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
	
			//查询
			$("#btn-query-supplieroverdue").click(function() {
				$("#pageForm").submit();
			}); */
		</script>
	</body>
</html>