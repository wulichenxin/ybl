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
<title><spring:message code="sys.v2.client.settlement" /></title><!-- 结算-->
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
	src="${app.staticResourceUrl}/ybl/resources/v2/js/balance_detail.js"></script>
</head>
<body>
	<div class="v2_top_bg v2_t_bg2 h165">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp" %>
				<div class="v2_z_nav">
					<div class="v2_z_nav_con">
						<div class="v2_z_navbox">
							<a class="now" href="javascript:void(0);"> <spring:message
									code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 --></a><a
								class="w150"
								href="/v2repaymentController/queryEnterprisePaymentList.htm">
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
			<!--搜索条件-->
		</div>
	</div>
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：结算管理 > 放款出账 > 待付款批次 > 结算 -->
			<spring:message code="sys.v2.client.location" />
			：
			<spring:message code="sys.v2.client.settlement.mamage" />
			>
			<spring:message code="sys.v2.client.Loan.outAccount" />
			>
			<spring:message code="sys.v2.client.batch.tobepaid" />
			>
			<spring:message code="sys.v2.client.settlement" />
		</div>

		<div class="v2_box_border">

			<div class="v2_tab_con">
				<div class="v2_text_box">
				
					<h1>
						<span class="gay_9"> <i><spring:message
									code="sys.v2.client.loan.amount" /> <!-- 放款金额 --></i> = <spring:message
								code="sys.v2.client.settlementAmount" /> <!-- 结算金额 --> - <spring:message
								code="sys.v2.client.facte.fee" /> <!-- 保理费 --> - <spring:message
								code="sys.v2.client.loan.raite" /> <!-- 贷款利息 --> - <spring:message
								code="sys.v2.client.other.fee" /> <!-- 其他费用 -->
						</span> <span class="gay_9"> <i><spring:message
									code="sys.v2.client.settlementAmount" /> <!-- 结算金额 --></i> = <spring:message
								code="sys.v2.client.account" /> <!-- 应收账款 --> × <spring:message
								code="sys.v2.client.settlement.ratio" /> <!-- 结算比例 -->
						</span>
					</h1>
					
					<div class="v2_table_con1">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th width="150"><spring:message
										code="sys.v2.client.batch.topay" /> <!-- 付款批次 --></th>
								<th width="200"><spring:message
										code="sys.v2.client.supplier" /> <!-- 供应商 --></th>
								<th width="150"><spring:message code="sys.v2.client.audit.date" /> <!-- 审核日期 --></th>
								<th width="100"><spring:message code="sys.v2.client.batch.amount" /> <!-- 批次金额(元) --></th>
								<th width="100"><spring:message code="sys.v2.client.settlementAmount" />
									<!-- 结算金额 --></th>
								<th width="100"><spring:message code="sys.v2.client.facte.fee" /> <!-- 保理费(元) --></th>
								<th width="100"><spring:message code="sys.v2.client.loan.raite" /> <!-- 贷款利息(元) --></th>
								<th width="100"><spring:message code="sys.v2.client.loan.amount" /> <!-- 放款金额(元) --></th>
							</tr>
							<tr>
									<td class="v2_back_je" width="150"><a class="lan">${disbursementBatch.batchNumber}</a>
										<div class="v2_back_xx">
											<div class="v2_table_con1 w900">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<th width="50"><spring:message
																code="sys.v2.client.no" /> <!-- 序号 --></th>
														<th width="160"><spring:message
																code="sys.v2.client.supplier.enterpriseName" /> <!-- 供应商 --></th>
														<th width="100"><spring:message
																code="sys.v2.client.companyName" /> <!-- 企业名称 --></th>
														<th width="100"><spring:message
																code="sys.v2.client.voucherNumber" /> <!-- 凭证号 --></th>
														<th width="100"><spring:message code="sys.v2.client.amount" /> <!-- 金额 --></th>
														<th width="100"><spring:message code="sys.v2.client.invoiceDate" />
															<!-- 开票日期 --></th>
														<th><spring:message
																code="sys.v2.client.expectTheReceivable" /> <!-- 预计回款日 --></th>
													</tr>
													<c:forEach items="${resultList}" var="data"
														varStatus="index">
														<tr>
															<td>${index.count}</td>
															<td>${data.supplierEnterpriseName}</td>
															<td>${data.coreEnterpriseName}</td>
															<td>${data.number}</td>
															<td ><fmt:formatNumber pattern="#,##0.00"
																	value="${data.amount}" /></td>
															<td>
																	<fmt:formatDate value="${data.invoiceDate}" pattern="yyyy-MM-dd"/>
															</td>
															<td>
																	<fmt:formatDate value="${data.returnDate}" pattern="yyyy-MM-dd"/>
															</td>
														</c:forEach>
														</tr>
												</table>
											</div>
										</div></td>
									<td width="200">${disbursementBatch.supplierEnterpriseName}</td>
									<td width="150">
											<fmt:formatDate value="${disbursementBatch.lastUpdateTime}" pattern="yyyy-MM-dd"/>
									</td>
									<td width="100"><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.batchAmount}" /></td>
									<td width="100"><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.balanceAmount}" /></td>
									<td width="100"><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.loanFee}" /></td>
									<td width="100"><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.loanInterest}" /></td>
									<td width="100"><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.disbursementAmount}" /></td>
							</tr>
							
						</table>
					</div>
					<ul>
						<li><div class="v2_input_box">
								<span><spring:message
										code="sys.v2.client.trade.stream.number" /> <!-- 交易流水号 -->：</span><input
									 type="text" class="w300 v2_text validate[required]" id="trxNumberSupplier"/><i>*</i>
							</div></li>
					</ul>
				</div>
				<div class="v2_text_box">
					<h1>
						<span class="gay_9"><i><spring:message
									code="sys.v2.client.platform.user.fee" /> <!-- 平台使用费 --></i> = <spring:message
								code="sys.v2.client.settlementAmount" /> <!-- 结算金额--> × <spring:message
								code="sys.v2.client.platform.user.fee.ratio" /> <!-- 平台使用费率 -->
						</span>
					</h1>
					<div class="v2_table_con1 ">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th ><spring:message
										code="sys.v2.client.factor.enterpriseName" /> <!-- 保理商 --></th>
										
								<th><spring:message code="sys.v2.client.settlementAmount" /> <!-- 结算金额(元) --></th>
								
								<th><spring:message
										code="sys.v2.client.platform.user.fee.ratio" /> %<!-- 平台使用费率 --></th>
										
								<th><spring:message code="sys.v2.client.platform.user.fee" />
									<!-- 平台使用费 --></th>

							</tr>
								<tr>
									<td >${disbursementBatch.factorEnterpriseName}</td>
									<td ><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.balanceAmount}" /></td>
									<td ><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.manageFee*100 / disbursementBatch.balanceAmount}" /></td>
									<td ><fmt:formatNumber pattern="#,##0.00"
											value="${disbursementBatch.manageFee}" /></td>
								</tr>
						</table>
					</div>
					<%-- <ul>
						<li><div class="v2_input_box">
								<span><spring:message
										code="sys.v2.client.trade.stream.number" /> <!-- 交易流水号 -->：</span><input
									 type="text" class="w300 v2_text validate[required]" id="trxNumberPlat"  name='' /><i>*</i>
							</div></li>
					</ul> --%>
				</div>

				<div class="v2_but_list">
				
					<sun:button id="v2_disbursement_balance_detail_pay" tag='a' clazz="bg_l" i18nValue="sys.v2.client.settlement" />
					<a class="bg_l" id="processing_btn" style="display:none"><spring:message code="sys.v2.client.processing" /></a>
					<a class="bg_g" id="return"><spring:message code="sys.v2.client.return"/><!-- 返回 --></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 其他参数 -->
	<input id="id_" value="${ disbursementBatch.id }" type="hidden"/>
	
	
	<!-- page.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- page.jsp -->
	<script type="text/javascript">
		$(function() {
			$(".v2_back_je a").mouseover(function() {
				$(".v2_back_xx").slideDown();
			});
			$(".v2_back_je a").mouseleave(function() {
				$(".v2_back_xx").slideUp();
			});
		});
	</script>
</body>
</html>
