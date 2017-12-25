<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"
	deferredSyntaxAllowedAsLiteral="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>贷款状态</title>
<jsp:include page="../common/link.jsp"/>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/form.js"></script>
<script type="text/javascript">
$(function(){   
	var status = "${status}";
	$("#status").val(status);
	$("#searchBtn").click(function(){
		$("#pageForm").submit();
	});
});
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->凭证管理 -> 贷款状态</div>
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<form action="/voucherAudit/loanStatus" id="pageForm" method="post">
				<input type="hidden" id="pageNumber" name="currentPage" value="1" />
				<input type="hidden" id="pageSize" name="pageSize" value="10"/>
				<ul>
					<li><label>贷款编号:</label><input type="text" name="number" value="${number }" /></li>
					<li><label>客户名称:</label><input type="text" name="enterpriseName" value="${enterpriseName }" /></li>
					<li><label>贷款状态:</label><select id="status" name="status">
							<option value="">全部</option>
							<option value="auditing">贷款中</option>
							<option value="audited">贷款成功</option>
							<option value="audit_failed">贷款失败</option>
							</select></li>
					<li><div class="button_yellow">
							<a id="searchBtn">查询</a>
						</div></li>
					<li><div class="button_gary">
							<a id="resetBtn">重置</a>
						</div></li>
				</ul>
				</form>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box ">

			<!--按钮top-->
			<div class="table_con ">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<!-- <th width="50"><input type="checkbox" /></th> -->
						<th width="50">序号</th>
						<th>贷款编号</th>
						<th>客户名称</th>
						<th>营业执照号</th>
						<th>联系电话</th>
						<th>保理商名称</th>
						<th>贷款金额</th>
						<th>贷款期限</th>
						<th>贷款状态</th>

					</tr>
					<c:forEach var="voucher" items="${vouchers}" varStatus="index" >
						<tr>
							<%-- <td><input type="checkbox" value="${voucher.id}" /></td> --%>
							<td>${index.count}</td>
							<td>
								<c:if test="${voucher.financeBody == 'loansign' }">
									<a href="/subjectController/lookSubject-${voucher.id}" target="_blank">${voucher.number }</a>
								</c:if>
								<c:if test="${voucher.financeBody != 'loansign' }">
									<a href="/voucherAudit/queryDetail?id=${voucher.id}" target="_blank">${voucher.number }</a>
								</c:if>
							</td>
							<td>${voucher.enterpriseName }</td>
							<td>${voucher.licenseNo }</td>
							<td>${voucher.legalPhone }</td>
							<td>${voucher.fEnterpriseName }</td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${voucher.applyAmount/10000 }" />万</td>
							<td>${voucher.loanPeriod }
								<c:if test="${voucher.periodType == 'day' }">
									天
								</c:if>
								<c:if test="${voucher.periodType == 'month' }">
									月
								</c:if>
								<c:if test="${voucher.periodType == 'year' }">
									年
								</c:if>
							</td>
							<td>
								<c:if test="${voucher.status == 'auditing' }">
									贷款中
								</c:if>
								<c:if test="${voucher.status == 'audited' }">
									贷款成功
								</c:if>
								<c:if test="${voucher.status == 'audit_failed' }">
									贷款失败
								</c:if>
							</td>
	
						</tr>
					</c:forEach>

				</table>

			</div>
			<jsp:include page="../common/page.jsp"></jsp:include>
		</div>
		<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>