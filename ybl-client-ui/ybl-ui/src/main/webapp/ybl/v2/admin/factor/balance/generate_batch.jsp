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
<title><spring:message code="sys.v2.client.settlement.mamage"/></title><!-- 结算管理 -->
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
	src="${app.staticResourceUrl}/ybl/resources/v2/js/batchManage.js"></script>
</head>




<body>
	<form action="/v2disbursementController/queryGenerateBatchList.htm"
		method="post" id='pageForm'>
		<!--top start -->
		<div class="v2_top_bg v2_t_bg2 h410">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
								<a class="now" href="/v2disbursementController/queryGenerateBatchList.htm">
								<spring:message code="sys.v2.client.Loan.outAccount"/><!-- 放款出账 --></a><a
									class="w150"
									href="/v2repaymentController/queryEnterprisePaymentList.htm">
									<spring:message code="sys.v2.client.enterprise.repayment"/><!-- 核心企业回款 --></a><a
									class="w130" href="/v2BalanceController/queryBuyBackList.htm">
									<spring:message code="sys.v2.client.supplier.buyback"/><!-- 供应商回购 --></a><a
									href="/v2BalanceController/queryRefundProcessList.htm">
									<spring:message code="sys.v2.client.refund.process"/><!-- 退款处理 --></a><a
									href="/v2BalanceController/queryPlatformReconList.htm">
									<spring:message code="sys.v2.client.platform.recon"/><!-- 平台对账 --></a>
							</div>
						</div>
					</div>
				</div>
				<!--top end -->
				<!---->
				<div class="v2_path"><!-- 当前位置：结算管理 > 放款出账 -->
				<spring:message code="sys.v2.client.location"/>：
				<spring:message code="sys.v2.client.settlement.mamage"/>>
				<spring:message code="sys.v2.client.Loan.outAccount"/></div>
				<div class="v2_tablist">
					<dl>
						<dd class="now">
							<a><spring:message code="sys.v2.client.generate.payment.lot"/><!-- 生成付款批 --></a>
						</dd>
						<dd>
							<a href="/v2disbursementController/queryDisbursementList.htm">
							<spring:message code="sys.v2.client.batch.tobepaid" />
								<!-- 待付款批次 --></a>
						</dd>
					</dl>
				</div>
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message code="sys.v2.client.supplier"/><!-- 供应商 -->:</label>
						<input type="text"
							name='enterpriseName' value='${paramters.enterpriseName}' /></li>
						<li><label><spring:message code="sys.v2.client.audit.date"/><!-- 审核日期 -->:</label>
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
								<a href='javascript:void(0);' id='generate_batch_query_btn'>
								<spring:message code="sys.v2.client.query"/><!-- 查询 --></a>
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
							<li><a class="v2_but_batch" id="v2_generate_batch">
							<spring:message code="sys.v2.client.batch.generate"/><!-- 批量生成 --></a></li>
							<li><a class="v2_but_excel" id="exportAll">
							<spring:message code="sys.v2.client.export.excel"/><!-- 导出Excel --></a></li>
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><input type="checkbox" id='checkAll' /></th>
							<th width="50"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
							<th width="200"><spring:message code="sys.v2.client.supplier"/><!-- 供应商 --></th>
							<th><spring:message code="sys.v2.client.amount.receivable"/><!-- 应收金额(元) --></th>
							<th><spring:message code="sys.v2.client.audit.date"/><!-- 审核日期 --></th>
							<th><spring:message code="sys.v2.client.status"/><!-- 状态 --></th>
							<th><spring:message code="sys.v2.client.operation"/><!-- 操作 --></th>
						</tr>
						<c:forEach items="${resultList}" var="data" varStatus="index">
							<tr>
								<td><input type="checkbox" name='checkbox' value="${ data.ids }"/></td>
								
								<td>${index.count}</td>
								
								<td >${data.enterpriseName}</td>
								
								<td ><fmt:formatNumber pattern="#,##0.00"
										value="${data.amount}" /></td>
								<td>
									<fmt:formatDate value="${data.lastUpdateTime}" pattern="yyyy-MM-dd" />
								</td>
								<td><spring:message code="sys.v2.client.pending.settlement"/><!-- 待结算 --></td>
								<td>
									
								  <a class="lan generateSingleBatch" value="${ data.ids }">
									    <spring:message code="sys.v2.client.generate.payment.lot"/><!-- 生成付款批 -->
									</a>
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
	<form action="/v2disbursementController/exportGenerateBatch" id="exportAllForm" style="disblay:none" target="_hide"></form>
	<iframe name="_hide" style="display: none;"></iframe>
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
		});
	</script>
</body>
</html>
