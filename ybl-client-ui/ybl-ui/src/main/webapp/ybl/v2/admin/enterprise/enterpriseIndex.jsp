<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message
		code="sys.v2.client.core.enterprise.index" /></title>
<!-- 核心企业首页 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
</head>
<body>
	<!--top start -->
	<div class="v2_top_bg h116">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp"%>
			</div>
		</div>
	</div>
	<!--top end -->
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：首页 -->
			<spring:message code="sys.v2.client.location" />
			:
			<spring:message code="sys.v2.client.index" />
		</div>
		<div class="v2_table_box mt20">
			<div class="v2_table_top">
				<h1>
					<font><spring:message code="sys.v2.client.todo.list" /> <!-- 待办事项 -->
						<b>${page.recordCount}</b> </font> <span> <a
						href='/accountsAffirmController/queryList?status_=submit'
						id='to_do_list_more_btn'> <spring:message
								code="sys.v2.client.more" /> <!-- 更多 -->+
					</a>
					</span>
				</h1>
			</div>
			<!--按钮top-->
			<div class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="100"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
						<th><spring:message code="sys.v2.client.function" /> <!-- 功能 --></th>
						<th><spring:message code="sys.v2.client.key.content" /> <!-- 关键内容 --></th>
						<th><spring:message code="sys.v2.client.operation.date" /> <!-- 操作日期 --></th>
						<th><spring:message code="sys.v2.client.operation" /> <!-- 操作 --></th>
					</tr>
					<c:forEach var="account" items="${list}" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td><spring:message code="sys.v2.client.account.confirm" />
								<!-- 账款确认 --></td>
							<td class="tl"><spring:message
									code="sys.v2.client.clientName" /> <!-- 客户名称 -->：${account.supplier_enterprise_name},
								<spring:message code="sys.v2.client.financeApply" /> <!-- 融资申请 -->,
								<spring:message code="sys.v2.client.voucherNumber" /> <!-- 凭证号 -->：${account.number_}</td>
							<td><jsp:useBean id="dateValue" class="java.util.Date" /> <jsp:setProperty
									name="dateValue" property="time"
									value="${account.last_update_time}" /> <fmt:formatDate
									value="${dateValue}" pattern="yyyy-MM-dd" />
							<td><a class="lan"
								href='/accountsAffirmController/queryaccountsReceivableAffirmDetail?id=${account.id_}'><spring:message
										code="sys.v2.client.process" /> <!-- 处理 --></a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!--table-->
	</div>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>