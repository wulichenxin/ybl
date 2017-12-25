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
	</head>
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待回款项目</div>
		</div>
		<form action="/factorRepaymentPlanController/pendingPayment.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>放款申请单号：</label><input class="content-form" name="loanApplyOrderNo"/></div>
					<div class="form-grou"><label class="label-long">还款状态：</label>
						<select class="content-form" name="repaymentStatus">
							<option value="">全部</option>
							<option value="1">待还款</option>
							<option value="2">待确认</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long">还款时间：</label><input id="startDate" class="content-form" name="startDate"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" class="content-form" name="endDate" />
					<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
				</div>
			</div>
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请订单号</th>
								<th>融资方</th>
								<th>核心企业</th>
								<th>第几期/总期数</th>
								<th>还款日期</th>
								<th>本期应还本金</th>
								<th>本期应还利息</th>
								<th>本期还款状态</th>
								<th>本期实际还款金额</th>
								<th>实际还款日期</th>
								<th>还款确认</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${list}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="javascript:;" class="order-a">${obj.loanApplyOrderNo}</a></td>
									<td>${obj.enterpriseShortName}</td>
									<td>${obj.coreEnterpriseName}</td>
									<td>${obj.period}</td>
									<td><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td>￥<fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>￥<fmt:formatNumber value="${obj.repaymentInterest}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>
										<c:if test="${obj.repaymentStatus eq 1}">待还款</c:if>
										<c:if test="${obj.repaymentStatus eq 2}">已还款待确认</c:if>
									</td>
									<td>￥<fmt:formatNumber value="${obj.actualAmount}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td><fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td>
										<c:if test="${obj.repaymentStatus eq 6}">是</c:if>
										<c:if test="${obj.repaymentStatus eq 2 or dto.repaymentStatus eq 1}">否</c:if>
									</td>
									<td>
										<a href="/loanapplicationcontroller/repaymentlist.htm?id=" class="btn-modify mr10 tip" onclick="">还款</a>
									</td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</form>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/overdue.js"></script>
		<script type="text/javascript">
		$('#startDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		</script>
	</body>
</html>