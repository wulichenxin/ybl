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
<title><spring:message code="sys.v2.client.voucher.details" /></title>
<!-- 凭证明细 -->
<!--日期控件 -->
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
			<!-- 当前位置：结算管理 > 放款出账 > 待付款批次 > 凭证明细 -->
			<spring:message code="sys.v2.client.location" />
			：
			<spring:message code="sys.v2.client.settlement.mamage" />
			>
			<spring:message code="sys.v2.client.Loan.outAccount" />
			>
			<spring:message code="sys.v2.client.batch.tobepaid" />
			>
			<spring:message code="sys.v2.client.voucher.details" />
		</div>
		<!--table-->
		<div class="v2_table_box mt20">
			<div class="v2_table_top">
				<div class="v2_table_nav">
					<ul>
						<li><a
							href="/v2disbursementController/queryDisbursementList.htm"
							class="v2_but_back" "> <spring:message
									code="sys.v2.client.return" /> <!-- 返回 --></a></li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="50"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
						<th width="160"><spring:message
								code="sys.v2.client.supplier.enterpriseName" /> <!-- 供应商 --></th>
						<th width="100"><spring:message
								code="sys.v2.client.companyName" /> <!-- 企业名称 --></th>
						<th width="100"><spring:message
								code="sys.v2.client.voucherNumber" /> <!-- 凭证号 --></th>
						<th><spring:message code="sys.v2.client.amount" /> <!-- 金额 --></th>
						<th><spring:message code="sys.v2.client.invoiceDate" /> <!-- 开票日期 --></th>
						<th><spring:message code="sys.v2.client.expectTheReceivable" />
							<!-- 预计回款日 --></th>
						<th width="100" <spring:message code="sys.v2.client.remark" />
							<!-- 备注 --></th>
					</tr>
					<c:forEach items="${resultList}" var="data" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td >${data.supplierEnterpriseName}</td>
							<td >${data.coreEnterpriseName}</td>
							<td>${data.number}</td>
							<td ><fmt:formatNumber pattern="#,##0.00"
									value="${data.amount}" /></td>
							<td>
									<fmt:formatDate value="${data.invoiceDate}" pattern="yyyy-MM-dd" />
							</td>
							
							<td>
									<fmt:formatDate value="${data.returnDate}" pattern="yyyy-MM-dd" />
							</td>
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
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
	<script type="text/javascript">
		$(function() {
			view = function(id) {
				$.msgbox({
					height : 250,
					width : 560,
					content : '设置预警额度.html',
					type : 'iframe',
					title : '设置预警额度'
				});
				$('body').css({
					overflow : 'hidden'
				});
			}
			
			$("#return").click(function(){
				history.back(-1);
				location.reload();
			});
		});
	</script>
</body>
</html>
