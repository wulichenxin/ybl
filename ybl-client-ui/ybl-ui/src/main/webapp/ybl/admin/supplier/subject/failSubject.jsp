<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.fail.subject.manage"/></title><!-- 流标管理 -->
<jsp:include page="../../common/link.jsp" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/subject/subjectList.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path"><!-- 当前位置->标的管理 -> 流标管理 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.subject.manage"/>-> 
		<spring:message code="sys.client.fail.subject.manage"/>
	</div>
	<div class="vip_conbody">
		<form action="/subjectController/subjectList?step=fail_subject"
			id="pageForm" method="post">
			<input type="hidden" value="'fail_subject'" name='status'/>
			<!--搜索条件-->
			<div class="seach_box" id="submit_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				<div class="fl">
					<ul>
						<li><label><spring:message code="sys.client.financeNumber"/><!-- 融资编号 -->:</label>
						<input type="text"
							value='${subject.number}' name='number' id='number'/></li>
						<li><div class="button_yellow">
								<a id='member_supplier_fail_subject_query_btn'>
									<spring:message code="sys.client.query" />
								</a>
								<!--查询-->
							</div></li>
						<li><div class="button_gary">
								<a id='member_supplier_fail_subject_reset_btn'/>
									<spring:message code="sys.client.reset" />
								</a>
								<!--重置-->
							</div></li>
					</ul>
				</div>
			</div>
			<!--搜索条件-->
			<!--table-->
			<div class="table_box">
				<!--按钮top-->
				<div class="table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.client.no"/></th><!-- 序号 -->
							<th><spring:message code="sys.client.projectName" /></th>
							<!-- 项目名称-->
							<th><spring:message code="sys.client.financeNumber"/></th><!-- 融资编号 -->
							<th><spring:message code="sys.client.loan.company"/></th><!-- 贷款公司 -->
							<th><spring:message code="sys.client.licenseNumber"/></th><!-- 营业执照号 -->
							<th><!-- 贷款金额(万元) -->
								<spring:message code="sys.client.loanMoney"/>
								(<spring:message code="sys.client.tenThousand"/>)
							</th>
							<th><spring:message code="sys.client.winPart"/></th><!-- 中标方 -->
							<th><!-- 还款期限 -->
								<spring:message code="sys.client.repaymentTime"/>
							</th>
							<th><!-- 竞标数/人 -->
								<spring:message code="sys.client.bid.number"/>/
								<spring:message code="sys.client.people"/>
							</th>
							<th><spring:message code="sys.client.bid.stopTime"/></th><!-- 竞标结束时间 -->
							<th><spring:message code="sys.client.subject.status"/></th><!-- 标的状态 -->
						</tr>
						<c:forEach var="data" items="${subjectList}" varStatus="index">
							<tr ${index.count%2==0?'class="bg_l"':''}>
								<td>${index.count}</td>
								<td>${data.name}</td>
								<td>${data.number}</td>
								<td>${data.attribute1}</td>
								<td>${data.attribute2}</td>
								<td><fmt:formatNumber value="${data.amount/10000}" pattern="#,##0.00" maxFractionDigits="2"/></td>
								<td>${data.attribute4==''?'-':data.attribute4}</td>
								<td>${data.loanPeriod}</td>
								<td>${data.attribute3}</td>
								<td>
									<!-- 时间戳转换为时间yyyy-mm-dd -->
									<jsp:useBean id="dateValue" class="java.util.Date" />
									<jsp:setProperty name="dateValue" property="time" value="${data.endDate}" />
									<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
								</td>
								<td><spring:message code="sys.client.subject.flow"/></td><!-- 流标 -->
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../../common/page.jsp"></jsp:include>
			</div>
			<!--table-->
		</form>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>