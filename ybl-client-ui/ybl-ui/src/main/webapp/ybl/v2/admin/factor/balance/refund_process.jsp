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
<title><spring:message code="sys.v2.client.refund.process" /></title><!-- 退款处理 -->
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
</head>
<script language='javascript'
 	src="${app.staticResourceUrl}/ybl/resources/v2/js/refund_process.js"></script> 
 	
<body>
<form action="/v2BalanceController/queryRefundProcessList.htm" method="post"
		id='pageForm'>
	<div class="v2_top_bg v2_t_bg2 h410">
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
							</a><a href="/v2BalanceController/queryRefundProcessList.htm" class='now'> <spring:message
									code="sys.v2.client.refund.process" /> <!-- 退款处理 -->
							</a><a href="/v2BalanceController/queryPlatformReconList.htm"> <spring:message
									code="sys.v2.client.platform.recon" /> <!-- 平台对账 --></a>
						</div>
					</div>
				</div>
			</div>
			<div class="v2_path"><!-- 当前位置：结算管理 > 退款处理 -->
				<spring:message code="sys.v2.client.location" />
					：
					<spring:message code="sys.v2.client.settlement.mamage" />
					>
					<spring:message code="sys.v2.client.refund.process" />
			</div>
			<!--搜索条件-->
			<div class="v2_seach_box">
			<ul>
						<li><label><spring:message
									code="sys.v2.client.supplier" />
								<!-- 供应商 -->:</label>
								<input type="text" class="w100" name='supplierEnterpriseName' value="${paramters.supplierEnterpriseName}"/></li>
						<li><label><spring:message
									code="sys.v2.client.core.enterprise" />
								<!-- 企业 -->:</label><input type="text" class="w100" 
								name='coreEnterpriseName' value="${paramters.coreEnterpriseName}"/></li>
						<li class="w460"><label><spring:message
									code="sys.v2.client.plan.return.date" /> <!-- 计划回款日 -->:</label><span><input id="paln_return_date" name="attribute1" value="${paramters.attribute1 }" 
								type="text" class="w100" /><a id="paln_return_date_a" class="v2_date_ico"></a></span><b><spring:message
									code="sys.v2.client.to" /> <!-- 至 --></b><span><input id="paln_return_max_date" name="attribute2" value="${paramters.attribute2 }"
								type="text" class="w100" /><a id="paln_return_max_date_a" class="v2_date_ico"></a></span></li>
						<li><label><spring:message
									code="sys.v2.client.account.voucher" /> <!-- 账款凭证 -->:</label><input
							type="text" class="w100" name='voucherNumber' value="${paramters.voucherNumber}"/></li>
						<li><label><spring:message
									code="sys.v2.client.buyback.status" />
								<!-- 回购状态 -->:</label><select name="buybackStatus" id="buybackStatus"
							url="/configController/get-BUYBACK_STATUS" valueFiled="code_"
							textField="value_" defaultValue="${paramters.buybackStatus}"
							isSelect="Y">
						</select></li>
						<li><label><spring:message
									code="sys.v2.client.repayment.status" /> <!-- 回款状态 -->:</label><select
							name="repaymentStatus" id="repaymentStatus"
							url="/configController/get-REPAYMENT_STATUS" valueFiled="code_"
							textField="value_" defaultValue="${paramters.repaymentStatus}"
							isSelect="Y">
						</select></li>
						<li><div class="v2_button_seach">
								<a href='javascript:void(0);' id='refund_process_query_btn'><spring:message
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

					<ul class="fl">
						<li><a href="javascript:void(0);" class="v2_but_export" id="exportAll"><spring:message code="sys.v2.client.export.excel"/></a></li>
					</ul>
					<%-- <div class="v2_tab_nav_r fr">
						<dd class="gay_9">
							<i><spring:message code="sys.v2.client.amountToBeRefunded"/><!-- 待退款金额 --></i> 
							= <spring:message code="sys.v2.client.amountOfMoneyBack" /><!-- 回款金额 --> 
							+ <spring:message code="sys.v2.client.buyback.amount" /><!-- 回购金额  -->
							- <spring:message code="sys.v2.client.amount.receivable.number"/><!-- 应收账款金额 --> 
							* <spring:message code="sys.v2.client.settlement.ratio"/><!-- 结算比例 --> 
							- <spring:message code="sys.v2.client.RefundAmount"/><!-- 已退款金额 -->
						</dd>
						<dd><spring:message code="sys.v2.client.note.amount.mustbeRMB"/><!-- 金额单位统一为人民币元。 --></dd>
					</div> --%>
				</div>
			</div>
			<!--按钮top-->
			 <div class="v2_table_con" style="width:100%; overflow-x:scroll;">
	        	<table border="0" cellspacing="0" cellpadding="0" style="width:1550px;">
				<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
							<th width="150"><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 --></th>
							<th width="120"><spring:message code="sys.v2.client.core.enterprise" />
								<!-- 企业 --></th>
							<th width="100"><spring:message code="sys.v2.client.account.voucher" />
								<!-- 账款凭证 --></th>
							<th width="100"><spring:message code="sys.v2.client.repayment.status" />
								<!-- 回款状态 --></th>
							<th width="100"><spring:message code="sys.v2.client.buyback.status" />
								<!-- 回购状态 --></th>
							<th width="100"><spring:message code="sys.v2.client.actual.return.date" />
								<!-- 实际回款日 --></th>
							<th width="100"><spring:message code="sys.v2.client.buyback.date" />
								<!-- 回购日期 --></th>
							<th width="100"><spring:message code="sys.v2.client.settlementAmount.yuan" />
								<!-- 应收金额（元） --></th>
							<th width="100"><spring:message code="sys.v2.client.settlement.ratio" />(%)
								<!-- 结算比例 --></th>
							<th width="100"><spring:message code="sys.v2.client.amountOfMoneyBack" />
								<!-- 回款金额（元） --></th>
							<th width="100"><spring:message code="sys.v2.client.buyback.amount" />
							(<spring:message code="sys.v2.client.element" />)
								<!-- 回购金额 --></th>
							<th width="100"><spring:message code="sys.v2.client.RefundAmount" />
							(<spring:message code="sys.v2.client.element" />)
								<!-- 已退款金额 --></th>
							<th width="100"><spring:message code="sys.v2.client.amountToBeRefunded" />
							(<spring:message code="sys.v2.client.element" />)
								<!-- 待退款金额 --></th>
							<th width="100"><spring:message code="sys.v2.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach items="${resultList}" var="data" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td class="lan"><a>${data.supplierEnterpriseName}</a></td>
								<td class="lan"><a>${data.coreEnterpriseName}</a></td>
								<td><a class="lan" href="/v2disbursementController/getVoucherByNumber.htm-${data.voucherNumber}">${data.voucherNumber}</a></td>
								
								<td url="/configController/get-REPAYMENT_STATUS/${data.repaymentStatus}"
									textField="value_"></td>
									
								<td url="/configController/get-BUYBACK_STATUS/${data.buybackStatus}"
									textField="value_"></td>
								<td>
										<fmt:formatDate value="${data.realRepaymentDate}" pattern="yyyy-MM-dd" />
								</td>
								<td>
										<fmt:formatDate value="${data.realBuybackDate}" pattern="yyyy-MM-dd" />
								</td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${(data.voucherAmount * data.settlementRatio) / 100}" /></td>
								<td ><fmt:formatNumber pattern="0.00"
										value="${data.settlementRatio}" /></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.actualRepaymentAmount}" /></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.actualBuybackAmount}" /></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.reimbursedAmount}" /></td>
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.reimbursementAmount > 0 ? data.reimbursementAmount:0}" /></td>
								<td><a class="lan"
									href="/v2BalanceController/reimbursementEdit.htm-${data.id}">
									 <c:if test="${ data.reimbursementAmount > 0}"> 
										<spring:message code="sys.v2.client.refund" />
									 </c:if>
									 <c:if test="${ data.reimbursementAmount <= 0}"> 
										<spring:message code="sys.v2.client.detail" />
									 </c:if>
										<!-- 退款 -->
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
	<form action="/v2reimbursementController/exportAll" id="exportAllForm" style="disblay:none" target="_hide"></form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>
