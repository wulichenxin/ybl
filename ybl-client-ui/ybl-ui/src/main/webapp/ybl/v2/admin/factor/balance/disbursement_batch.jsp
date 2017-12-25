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
<title><spring:message code="sys.v2.client.batch.tobepaid" /></title>
<!-- 待付款批次 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/v2/js/disbursement_batch.js"></script>

</head>
<body>
	<form action="/v2disbursementController/queryDisbursementList.htm"
		method="post" id='pageForm'>
		<!--top start -->
		<div class="v2_top_bg v2_t_bg2 h410">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
								<a class="now" href="/v2disbursementController/queryGenerateBatchList.htm"> <spring:message
										code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 --></a>
										<a class="w150" href="/v2repaymentController/queryEnterprisePaymentList.htm">
									<spring:message code="sys.v2.client.enterprise.repayment" /> <!-- 核心企业回款 -->
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
					<!-- 当前位置：结算管理 > 放款出账 > 待付款批次 -->
					<spring:message code="sys.v2.client.location" />
					：
					<spring:message code="sys.v2.client.settlement.mamage" />
					>
					<spring:message code="sys.v2.client.Loan.outAccount" />
					>
					<spring:message code="sys.v2.client.batch.tobepaid" />
				</div>
				<div class="v2_tablist">
					<dl>
						<dd>
							<a href="/v2disbursementController/queryGenerateBatchList.htm">
								<spring:message code="sys.v2.client.generate.payment.lot" /> <!-- 生成付款批 -->
							</a>
						</dd>
						<dd class="now">
							<a><spring:message code="sys.v2.client.batch.tobepaid" /> <!-- 待付款批次 --></a>
						</dd>
					</dl>
				</div>
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message
									code="sys.v2.client.batch.topay" /> <!-- 付款批次 -->:</label> <input
							type="text" name='batchNumber' value='${paramters.batchNumber }'/></li>
						<li><label><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 -->:</label> <input
							type="text" name='supplierEnterpriseName'
							value='${paramters.supplierEnterpriseName}'/></li>
						<li><label><spring:message
									code="sys.v2.client.audit.date" /> <!-- 审核日期 -->:</label>
							<span>
								<input id="audit_date" name="attribute1"
								value="${paramters.attribute1 }" type="text" class="w130" /><a
								id="audit_date_a" class="v2_date_ico"></a>
							</span><b><spring:message code="sys.v2.client.to" /> <!-- 至 --></b><span>
								<input id="audit_max_date" name="attribute2"
								value="${paramters.attribute2 }" type="text" class="w130" /><a
								id="audit_max_date_a" class="v2_date_ico"></a>
							</span>
						</li>
						<li><div class="v2_button_seach">
								<a href='javascript:void(0);' id='disbursement_batch_query_btn'>
									<spring:message code="sys.v2.client.query" /> <!-- 查询 -->
								</a>
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
							<li><a class="v2_but_excel" id="exportAll"><spring:message
										code="sys.v2.client.export.excel" /> <!-- 导出Excel --></a></li>
						</ul>
						<%-- <div class="v2_tab_nav_r fr">
							<dd class="gay_9">
								<i><spring:message code="sys.v2.client.loan.amount" /> <!-- 放款金额 --></i>
								=
								<spring:message code="sys.v2.client.settlementAmount" />
								<!-- 结算金额 -->
								-
								<spring:message code="sys.v2.client.facte.fee" />
								<!-- 保理费 -->
								-
								<spring:message code="sys.v2.client.loan.raite" />
								<!-- 贷款利息 -->
								-
								<spring:message code="sys.v2.client.other.fee" />
								<!-- 其他费用 -->
							</dd>
							<dd class="gay_9">
								<i><spring:message code="sys.v2.client.settlementAmount" />
									<!-- 结算金额 --></i> =
								<spring:message code="sys.v2.client.account" />
								<!-- 应收账款 -->
								×
								<spring:message code="sys.v2.client.settlement.ratio" />
								<!-- 结算比例 -->
							</dd>
						</div> --%>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con"  style="width: 100%; overflow-x: scroll;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" style="width: 1550px;">
					
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
							<th width="150"><spring:message
									code="sys.v2.client.batch.topay" /> <!-- 付款批次 --></th>
							<th width="200"><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 --></th>
							<th width="100"><spring:message
									code="sys.v2.client.audit.date" /> <!-- 审核日期 --></th>
							<th width="100"><spring:message
									code="sys.v2.client.batch.amount" /> <!-- 批次金额(元) --></th>
							<th width="100"><spring:message
									code="sys.v2.client.settlementAmount.yuan" /> <!-- 结算金额 --></th>
							<th width="100"><spring:message
									code="sys.v2.client.facte.fee" /> <!-- 保理费(元) --></th>
							<th width="100"><spring:message
									code="sys.v2.client.loan.raite" /> <!-- 贷款利息(元) --></th>
							<th width="100"><spring:message
									code="sys.v2.client.platform.user.fee.yuan" /> <!-- 其他费用（元） --></th>
							<th width="100"><spring:message
									code="sys.v2.client.loan.amount" /> <!-- 放款金额(元) --></th>
							<th width="50"><spring:message code="sys.v2.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach items="${resultList}" var="data" varStatus="index">
							<tr>
								<td width="50">${index.count}</td>
								<td width="150"><a class="lan" href="/v2disbursementController/getVoucherDetail.htm-${data.id}">${data.batchNumber}</a></td>
								<td width="200">${data.supplierEnterpriseName}</td>
								
								<td>
									<fmt:formatDate value="${data.lastUpdateTime}" pattern="yyyy-MM-dd" />
								</td>
								
								<td width="100"><fmt:formatNumber pattern="#,##0.00"
										value="${data.batchAmount}" /></td>
								<td width="100"><fmt:formatNumber pattern="#,##0.00"
										value="${data.balanceAmount}" /></td>
								<td width="100"><fmt:formatNumber pattern="#,##0.00"
										value="${data.loanFee}" /></td>
								<td width="100"><fmt:formatNumber pattern="0.00"
										value="${data.loanInterest}" /></td>
								<td width="100"><fmt:formatNumber pattern="#,##0.00"
										value="${data.manageFee}" /></td>
								<td width="100"><fmt:formatNumber pattern="#,##0.00"
										value="${data.disbursementAmount}" /></td>

								<td width="50"><a class="lan" href="/v2disbursementController/getBalanceDetail.htm-${data.batchNumber}"> <spring:message
											code="sys.v2.client.settlement" /> <!-- 结算 --></a></td>
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
	<form action="/v2disbursementController/exportDisbursementBatch" id="exportAllForm" style="disblay:none" target="_hide"></form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>
