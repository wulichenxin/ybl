<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.v2.client.platform.recon" /></title>
<!-- 平台对账 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<!-- 检验文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script language='javascript'
 	src="${app.staticResourceUrl}/ybl/resources/v2/js/platform_reconciliation.js"></script> 
</head>
<body>
	<form action="/v2BalanceController/queryPlatformReconList.htm"
		method="post" id='pageForm'>
		<div class="v2_top_bg v2_t_bg2">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
								<a href="/v2disbursementController/queryGenerateBatchList.htm">
									<spring:message code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 -->
								</a><a class="w150"
									href="/v2repaymentController/queryEnterprisePaymentList.htm">
									<spring:message code="sys.v2.client.enterprise.repayment" /> <!-- 核心企业回款 -->
								</a><a class="w130" href="/v2BalanceController/queryBuyBackList.htm">
									<spring:message code="sys.v2.client.supplier.buyback" /> <!-- 供应商回购 -->
								</a><a href="/v2BalanceController/queryRefundProcessList.htm">
									<spring:message code="sys.v2.client.refund.process" /> <!-- 退款处理 -->
								</a><a href="/v2BalanceController/queryPlatformReconList.htm" class='now'> <spring:message
										code="sys.v2.client.platform.recon" /> <!-- 平台对账 --></a>
							</div>
						</div>
					</div>
				</div>
				<!---->
				<div class="v2_path">
					<!-- 当前位置：结算管理 > 平台对账 -->
					<spring:message code="sys.v2.client.location" />
					：
					<spring:message code="sys.v2.client.settlement.mamage" />
					>
					<spring:message code="sys.v2.client.platform.recon" />
				</div>
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 -->:</label><input name='supplierEnterpriseName' value="${paramters.supplierEnterpriseName}"
							type="text" /></li>
						<li><label><spring:message
									code="sys.v2.client.core.enterprise" /> <!-- 企业 -->:</label><input type="text" name='coreEnterpriseName' value="${paramters.coreEnterpriseName}"/></li>
						<li class="w420"><label><spring:message
									code="sys.v2.client.settlement.date" /> <!-- 结算日期 -->:</label><span><input id="disbursement_date" name="attribute8" value="${ paramters.attribute8}"
								type="text" class="w130" /><a id="disbursement_date_a" class="v2_date_ico"></a></span><b><spring:message
									code="sys.v2.client.to" /> <!-- 至 --></b><span><input id="disbursement_date_max" name="attribute9" value="${ paramters.attribute9 }"
								type="text" class="w130" /><a id="disbursement_date_max_a" class="v2_date_ico"></a></span></li>

						<li><div class="v2_button_seach">
								<a href='javascript:void(0);' id='platform_recon_query_btn'><spring:message
										code="sys.v2.client.query" /> <!-- 查询 --></a>
							</div></li>

					</ul>
				</div>
				<!--搜索条件-->
			</div>
		</div>

		<!---->



		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><a class="v2_but_excel" id="exportAll">
							<spring:message code="sys.v2.client.export.excel"/><!-- 导出Excel --></a></li>
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
							<th width="160"><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 --></th>
							<th width="160"><spring:message code="sys.v2.client.core.enterprise" />
								<!-- 企业 --></th>
							<th><spring:message code="sys.v2.client.account.voucher" />
								<!-- 账款凭证 --></th>
							<th><spring:message code="sys.v2.client.amount.receivable" />
								<!-- 应收金额（元） --></th>
							<th><spring:message code="sys.v2.client.settlementAmount.yuan" />
								<!-- 结算金额（元） --></th>
							<th><spring:message code="sys.v2.client.settlement.date" />
								<!-- 结算日期 --></th>
							<th><spring:message code="sys.v2.client.platform.user.fee.yuan" />
								<!-- 平台使用费 --></th>
						</tr>
						<c:forEach items="${resultList}" var="data" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td class="lan"><a>${data.supplierEnterpriseName}</a></td>
								<td class="lan"><a>${data.coreEnterpriseName}</a></td>
								<td><a class="lan" href="/v2disbursementController/getVoucherByNumber.htm-${data.voucherNumber}">${data.voucherNumber}</a></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.voucherAmount}" /></td>
								<td ><fmt:formatNumber pattern="0.00"
										value="${(data.voucherAmount * data.settlementRatio)/100}" /></td>
								<td>
									<fmt:formatDate value="${data.disbursementDate}" pattern="yyyy-MM-dd" />
								</td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.manageFee}" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- page.jsp -->
			<%@include file="/ybl/v2/admin/common/page.jsp"%>
			<!-- page.jsp -->
			<!--table-->
		</div>
	</form>
	<form action="/v2BalanceController/exportAll" id="exportAllForm" style="disblay:none" target="_hide"></form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
	<!--弹出窗登录-->
</body>
</html>
