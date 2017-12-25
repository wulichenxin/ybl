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
<title><spring:message code="sys.v2.client.supplier.index" /></title>
<!-- 供应商首页 -->
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
		<!--table-->
		<div class="v2_table_box mt20">
			<div class="v2_table_top">
				<h1>
					<font><spring:message code="sys.v2.client.warn.remind" /> <b>${page.recordCount}</b></font>
					<!-- 预警提醒 -->
					<span> <a
						href='/accountsReceivableManageController/queryList.htm'> <spring:message
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
						<th><spring:message code="sys.v2.client.warn.message" /> <!-- 预警信息 --></th>
					</tr>
					<c:forEach var="account" items="${list}" varStatus="index">
					<c:if test="${account.status_ ne 'draft'}">
						<tr>
							<td>${index.count}</td>
							<td class="tl"><a class="lan"
								href="/accountsReceivableManageController/queryaccountsReceivableDetail.htm?id=${account.id_}&operator=query">
									<spring:message code="sys.v2.client.core.enterprise" /> <!-- 核心企业 -->:${account.enterprise_name},
									<spring:message code="sys.v2.client.factor" /> <!-- 保理商-->:${account.factor_enterprise_name},
									<spring:message code="sys.v2.client.voucherNumber" /> <!-- 凭证号 -->:${account.number_},
									<spring:message code="sys.v2.client.return.date" /> <!-- 回款日期 -->:
									<jsp:useBean id="dateValue" class="java.util.Date" /> <jsp:setProperty
										name="dateValue" property="time"
										value="${account.return_date}" /> <fmt:formatDate
										value="${dateValue}" pattern="yyyy-MM-dd" />
							</a></td>
						</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>