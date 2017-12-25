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
<title><spring:message code="sys.v2.client.enterprise.repayment" /></title>
<!-- 核心企业回款 -->
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
	src="${app.staticResourceUrl}/ybl/resources/v2/js/enterprise_payment.js"></script>
</head>
<body>
	<form action="/v2repaymentController/queryEnterprisePaymentList.htm"
		method="post" id='pageForm'>
		<!--top start -->
		<div class="v2_top_bg v2_t_bg2 h410">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
								<a href="/v2disbursementController/queryGenerateBatchList.htm">
									<spring:message code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 -->
								</a><a class="w150 now" href="/v2repaymentController/queryEnterprisePaymentList.htm"> <spring:message
										code="sys.v2.client.enterprise.repayment" /> <!-- 核心企业回款 -->
								</a><a class="w130" href="/v2BalanceController/queryBuyBackList.htm">
									<spring:message code="sys.v2.client.supplier.buyback" /> <!-- 供应商回购 -->
								</a><a href="/v2BalanceController/queryRefundProcessList.htm">
									<spring:message code="sys.v2.client.refund.process" /> <!-- 退款处理 -->
								</a><a href="/v2BalanceController/queryPlatformReconList.htm"> <spring:message
										code="sys.v2.client.platform.recon" /> <!-- 平台对账 --></a>
							</div>
						</div>
					</div>
				</div>
				<!---->
				<div class="v2_path">
					<!-- 当前位置：结算管理 > 核心企业回款 -->
					<spring:message code="sys.v2.client.location" />
					：
					<spring:message code="sys.v2.client.settlement.mamage" />
					>
					<spring:message code="sys.v2.client.enterprise.repayment" />
				</div>
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 -->:</label> <input
							type="text" name='supplierEnterpriseName'
							value='${paramters.supplierEnterpriseName }' /></li>
						<li><label><spring:message
									code="sys.v2.client.core.enterprise" /> <!-- 企业 -->:</label> <input
							type="text" name="coreEnterpriseName"
							value="${paramters.coreEnterpriseName }" /></li>
						<li class="w420"><label><spring:message
									code="sys.v2.client.plan.return.date" /> <!-- 计划回款日 -->:</label><span>
								<input type="text" id="paln_return_date" name="attribute1" value="${paramters.attribute1 }" class="w130" /><a id="paln_return_date_a" class="v2_date_ico"></a>
						</span><b><spring:message code="sys.v2.client.to" /> <!-- 至 --></b><span><input
								type="text" id="paln_return_max_date" name="attribute2" value="${paramters.attribute2 }" class="w130" /><a id="paln_return_max_date_a" class="v2_date_ico"></a></span></li>
						
						<li><label><spring:message
									code="sys.v2.client.repayment.status" /> <!-- 回款状态 -->:</label> <select
							name="status" id="status"
							url="/configController/get-REPAYMENT_STATUS" valueFiled="code_"
							textField="value_" defaultValue="${paramters.status}"
							isSelect="Y">
						</select></li>
						<li class="w420"><label><spring:message
									code="sys.v2.client.actual.return.date" /> <!-- 实际回款日 -->:</label><span><input
								type="text"  id="actual_return_date" name="attribute3" value="${paramters.attribute3 }" class="w130" /><a id="actual_return_date_a" class="v2_date_ico"></a></span><b><spring:message
									code="sys.v2.client.to" /> <!-- 至 --></b><span><input
								type="text" id="actual_return_max_date" name="attribute4" value="${paramters.attribute4 }" class="w130" /><a id="actual_return_max_date_a" class="v2_date_ico"></a></span></li>
						<li><div class="v2_button_seach">
								<a href='javascript:void(0);' id='enterprise_payment_query_btn'><spring:message
										code="sys.v2.client.query" /> <!-- 查询 --></a>
							</div></li>

					</ul>
				</div>
				<!--搜索条件-->
			</div>
		</div>
		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><a href="/v2repaymentController/toBatchPaymentPage.htm" class="v2_but_import"> <spring:message
										code="sys.v2.client.bulkImport" /> <!-- 批量导入 --></a></li>
							<li><a class="v2_but_export" id="exportAll"> <spring:message
										code="sys.v2.client.export.excel" /> <!-- 批量导出 --></a></li>
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
							<th><spring:message code="sys.v2.client.plan.return.date" />
								<!-- 计划回款日 --></th>
							<th><spring:message code="sys.v2.client.actual.return.date" />
								<!-- 实际回款日 --></th>
							<th><spring:message code="sys.v2.client.settlementAmount.yuan" />
								<!-- 应收金额（元） --></th>
							<th><spring:message code="sys.v2.client.amountOfMoneyBack" />
								<!-- 回款金额（元） --></th>
							<th><spring:message code="sys.v2.client.repayment.status" />
								<!-- 回款状态 --></th>
							<th><spring:message code="sys.v2.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach items="${resultList}" var="data" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td class="lan"><a>${data.supplierEnterpriseName}</a></td>
								<td class="lan"><a>${data.coreEnterpriseName}</a></td>
								<td><a class="lan" href="/v2disbursementController/getVoucherByNumber.htm-${data.number}">${data.number}</a></td>
								<td>
										<fmt:formatDate value="${data.repaymentDate}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
										<fmt:formatDate value="${data.payTime}" pattern="yyyy-MM-dd"/>
								</td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.amount}" /></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.actualAmount}" /></td>
								<td url="/configController/get-REPAYMENT_STATUS/${data.status}"
									textField="value_"></td>
								<td><a class="lan"
									href="/v2BalanceController/singleRepaymentEdit.htm-${data.accountsReceivableId }">
									   <c:if test="${data.status != 'done'}">
											<spring:message code="sys.v2.client.add" /> <!-- 新增 -->
										</c:if>
										<c:if test="${data.status == 'done'}">
											<spring:message code="sys.v2.client.detail" /> <!-- 详情 -->
										</c:if>
										
								</a></td>
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
	<form action="/v2repaymentController/exportAll" id="exportAllForm" style="disblay:none" target="_hide"></form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>
