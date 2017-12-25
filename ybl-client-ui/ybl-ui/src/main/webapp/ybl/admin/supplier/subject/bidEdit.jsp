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
<title><spring:message code="sys.client.bid.subject.manage" />-<spring:message
		code="sys.client.look" /></title>
<!-- 竞标管理-查看 -->
<jsp:include page="../../common/link.jsp" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/subject/bidSubject.js"></script>
</head>
<body>
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
		<form action="/subjectController/queryBidList" id="pageForm" method="post">
			<div class="table_con table_border ">
				<input type='hidden' id='status' name='status' value="${status}" />
				<input type='hidden' id='loanSignId' name='loanSignId' value="${parameters.loanSignId}" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb2">
					<tr>
						<th width="50"></th>
						<th width="50"><spring:message code="sys.client.no" /></th>
						<!-- 序号 -->
						<th><spring:message code="sys.client.bid.company" /></th>
						<!-- 竞标公司 -->
						<th><spring:message code="sys.client.orgCodeNo" /></th>
						<!-- 组织机构代码 -->
						<th><spring:message code="sys.client.yearRate" />(%)</th>
						<!-- 年利率 -->
						<th><spring:message code="sys.client.max.loan.rate" />(%)</th>
						<!-- 最大贷款比例 -->
						<th><spring:message code="sys.client.sure.bid.time" /></th>
						<!-- 应标时间 -->
						<th><spring:message code="sys.client.compositeScore" /></th>
						<!-- 综合评分 -->
						<th><spring:message code="sys.client.bid.result" /></th>
						<!-- 竞标结果 -->
						<th><spring:message code="sys.client.operation" /> <!-- 操作 --></th>
					</tr>
					<c:forEach var="data" items="${subjectBidList }" varStatus="index">
						<tr ${index.count%2==0?'class="bg_l"':''}>
							<td><input name="radio" type="radio" value='${data.id }'
								subjectId="${data.loanSignId}" /></td>
							<td>${index.count}</td>
							<td><a  target="_Blank"
								href="/loanApplicationController/factorDetails?id=${data.enterpriseId}">${data.enterpriseName}</a></td>
							<td>${data.orgCodeNo}</td>
							<td><fmt:formatNumber value="${data.rate}" pattern="0.00"
									maxFractionDigits="2" /></td>
							<td><fmt:formatNumber value="${data.ratio}" pattern="0.00"
									maxFractionDigits="2" /></td>
							<td><fmt:formatDate value="${data.createdTime}"
									pattern="yyyy-MM-dd" /></td>
							<td>${data.compositeScore}</td>
							<td><c:if test="${data.status=='unbid'}">
									<spring:message code="sys.client.unbid" />
									<!-- 未中标 -->
								</c:if> <c:if test="${data.status=='bided'}">
									<spring:message code="sys.client.bid" />
									<!-- 中标 -->
								</c:if> <c:if test="${data.status=='biding'}">
									<spring:message code="sys.client.biding" />
									<!-- 竞标中 -->
								</c:if></td>
							<td><div class="qy">
									<a href="/subjectController/toBidPage?id=${data.id}"
										target="_blank"> <spring:message
											code="sys.client.bid.detail" /> <!-- 竞标详情 --></a>
								</div></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<jsp:include page="../../common/page.jsp"></jsp:include>
			</form>
			<div class="clear"></div>
			<c:if
				test="${!(status=='paymenting'||status=='end' ||status=='fail_subject'||status=='reject')}">
				<div class="w_agreen mt20">
					<input name="" type="checkbox" id='isAgree' />
					<spring:message code="sys.client.agree.sign.facte.loan.contract" />
					<!-- 同意签署保理贷款合同合约 -->
				</div>
				<div class="w_bottom">
					<ul>
						<li><a class="now"
							id='member_supplier_bid_choose_company_bid_btn'> <spring:message
									code="sys.client.bid" /> <!-- 中标 --></a></li>
						<li><a id="anqu_close"
							id='member_supplier_bid_choose_company_cancel_btn'> <spring:message
									code="sys.client.cancel" /> <!-- 取消 --></a></li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>