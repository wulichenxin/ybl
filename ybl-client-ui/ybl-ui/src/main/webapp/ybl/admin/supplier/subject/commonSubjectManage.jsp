<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.common.subject.manage" /></title>
<!-- 普通标管理 -->
<jsp:include page="../../common/link.jsp" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/subject/subjectList.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">
		<!-- 当前位置->标的管理 -> 普通标管理 -->
		<spring:message code="sys.client.location" />
		->
		<spring:message code="sys.client.subject.manage" />
		->
		<spring:message code="sys.client.common.subject.manage" />
	</div>
	<div class="vip_conbody">
		<form action="/subjectController/subjectList" id="pageForm"
			method="post">
			<!--搜索条件-->
			<div class="seach_box" id="submit_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				<div class="fl">
					<ul>
						<li><label><spring:message
									code="sys.client.financeNumber" /> <!-- 融资编号 -->:</label> <input
							type="text" name='number' value='${subject.number}' id='number' /></li>
						<li><label><spring:message
									code="sys.client.subject.status" /> <!-- 标的状态 -->:</label> <select
							name="status" id='status'>
								<option value=''
									${subject.status==''|| subject.status==null?'selected':''}>
									<spring:message code="sys.client.queryAll" /><!-- 全部 -->
								</option>
								<option value="'draft'"
									${subject.status=="'draft'"?'selected':''}>
									<spring:message code="sys.client.draft" /><!-- 草稿 -->
								</option>
								<option value="'auditing'"
									${subject.status=="'auditing'"?'selected':''}>
									<spring:message code="sys.client.auditing" /><!-- 审核中 -->
								</option>
								<option value="'biding'"
									${subject.status=="'biding'"?'selected':''}>
									<spring:message code="sys.client.biding" /><!-- 竞标中 -->
								</option>
								<option value="'paymenting'"
									${subject.status=="'paymenting'"?'selected':''}>
									<spring:message code="sys.client.paymenting" /><!-- 回款中 -->
								</option>
								<option value="'end'" ${subject.status=="'end'"?'selected':''}>
									<spring:message code="sys.client.complete" /><!-- 已完成 -->
								</option>
								<option value="'fail_subject'"
									${subject.status=="'fail_subject'"?'selected':''}>
									<spring:message code="sys.client.subject.flow" /><!-- 流标 -->
								</option>
								<option value="'reject'"
									${subject.status=="'reject'"?'selected':''}>
									<spring:message code="sys.client.investBidManage.unsign" /><!-- 已拒绝 -->
								</option>
						</select></li>
						<li><label><spring:message code="sys.client.isLoan" />
								<!-- 是否放款 -->:</label> <select name="isLoan" id='isLoan'>
								<option value=''
									${subject.isLoan==''|| subject.isLoan!=null?'selected':''}>
									<spring:message code="sys.client.queryAll" /><!-- 全部 -->
								</option>
								<option value='Y' ${subject.isLoan=='Y'?'selected':''}>
									<spring:message code="sys.client.already.loan" /><!-- 已放款 -->
								</option>
								<option value='N' ${subject.isLoan=='N'?'selected':''}>
									<spring:message code="sys.client.no.loan" /><!-- 未放款 -->
								</option>
						</select></li>
						<li><div class="button_yellow">
								<a id='member_supplier_common_subject_query_btn'>
									<spring:message code="sys.client.query" />
								</a>
								<!--查询-->
							</div></li>
						<li><div class="button_gary">
								<a id='member_supplier_common_subject_reset_btn'>
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
				<div class="table_top ">
					<div class="table_nav">
						<input type='hidden' id='subjectId' />
						<ul>
							<li><sun:button tag='a' clazz='but_ico7'
									id='member_supplier_common_subject_add_btn'
									i18nValue='sys.client.add' /></li>
							<!--添加 -->
							<li><sun:button tag='a' clazz='but_ico1'
									id='member_supplier_common_subject_delete_btn'
									i18nValue='sys.client.delete' /></li>
							<!--删除 -->
							<li><sun:button tag='a' clazz='but_ico3'
									id='member_supplier_common_subject_edit_btn'
									i18nValue='sys.client.edit' /></li>
							<!--修改 -->
							<li><sun:button tag='a' clazz='but_ico4'
									id='member_supplier_common_subject_look_btn'
									i18nValue='sys.client.look' /></li>
							<!--查看 -->
							<li><sun:button tag='a' clazz='but_ico5'
									id='member_supplier_common_subject_flow_btn'
									i18nValue='sys.client.subject.flow' /></li>
							<!--流标-->
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th><input name="" type="checkbox" id='checkAll' /></th>
							<th width="50"><spring:message code="sys.client.no" /></th>
							<!-- 序号 -->
							<th><spring:message code="sys.client.projectName" /></th>
							<!-- 项目名称-->
							<th><spring:message code="sys.client.financeNumber" /></th>
							<!-- 融资编号 -->
							<th><spring:message code="sys.client.loan.company" /></th>
							<!-- 贷款公司 -->
							<th><spring:message code="sys.client.licenseNumber" /></th>
							<!-- 营业执照号 -->
							<th>
								<!-- 融资金额/万元 --> <spring:message code="sys.client.financeAmount" />
								(<spring:message code="sys.client.tenThousand"/>)
							</th>
							<th>
								<!-- 还款期限 --> <spring:message code="sys.client.repaymentTime" />
							</th>
							<th><spring:message code="sys.client.subject.status" /></th>
							<!-- 标的状态-->
							<th><spring:message code="sys.client.isLoan" /></th>
							<!-- 是否放款 -->
							<th><spring:message code="sys.client.stopSubject.date" /></th>
							<!-- 截标日期 -->
						</tr>
						<c:forEach var="data" items="${subjectList}" varStatus="index">
							<tr ${index.count%2==0?'class="bg_l"':''}>
								<td><input name="checkbox" type="checkbox" value=""
									ids='${data.id}' status='${data.status}' /></td>
								<td>${index.count}</td>
								<td>${data.name}</td>
								<td>${data.number}</td>
								<td>${data.attribute1}</td>
								<td>${data.attribute2}</td>
								<td><fmt:formatNumber value="${data.amount/10000}"
										pattern="#,##0.00" maxFractionDigits="2" /></td>
								<td>${data.loanPeriod}
									${data.periodType=='day'?"天":data.periodType=='month'?"月":data.periodType=='year'?"年":"" }
								</td>
								<td><c:if test="${data.status=='draft'}">
										<spring:message code="sys.client.draft" />
										<!-- 草稿 -->
									</c:if> <c:if test="${data.status=='auditing'}">
										<spring:message code="sys.client.auditing" />
										<!-- 审核中 -->
									</c:if> <c:if test="${data.status=='biding'}">
										<spring:message code="sys.client.biding" />
										<!-- 已发布/竞标中 -->
									</c:if> <c:if test="${data.status=='fail_subject'}">
										<spring:message code="sys.client.subject.flow" />
										<!-- 流标 -->
									</c:if> <c:if test="${data.status=='paymenting'}">
										<spring:message code="sys.client.paymenting" />
										<!-- 回款中 -->
									</c:if> <c:if test="${data.status=='end'}">
										<spring:message code="sys.client.complete" />
										<!-- 已完成 -->
									</c:if> <c:if test="${data.status=='reject'}">
										<spring:message code="sys.client.investBidManage.unsign" />
										<!-- 已拒绝 -->
									</c:if></td>
								<td><c:if test="${data.isLoan=='Y'}">
										<spring:message code="sys.client.already.loan" />
										<!-- 已放款 -->
									</c:if> <c:if test="${data.isLoan=='N'}">
										<spring:message code="sys.client.no.loan" />
										<!-- 未放款 -->
									</c:if></td>
								<td>
									<!-- 时间戳转换为时间yyyy-mm-dd --> <jsp:useBean id="dateValue"
										class="java.util.Date" /> <jsp:setProperty name="dateValue"
										property="time" value="${data.endDate}" /> <fmt:formatDate
										value="${dateValue}" pattern="yyyy-MM-dd" />
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../../common/page.jsp"></jsp:include>
			</div>
		</form>
		<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>