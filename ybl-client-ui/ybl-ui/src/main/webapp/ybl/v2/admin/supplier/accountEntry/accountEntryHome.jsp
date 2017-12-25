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
<title>云保理</title>
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<link href="/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet"
	type="text/css" />
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("#supplier_account_Manage_Query_btn").click(function() {
			var max_invoice_date = $("#max_invoice_date").val();
			var min_invoice_date = $("#min_invoice_date").val();
			if(max_invoice_date != ''){
				max_invoice_date += ' 00:00:00';
				$("#max_invoice_date").val(max_invoice_date);
			}
			if(min_invoice_date != ''){
				min_invoice_date += ' 00:00:00';
				$("#min_invoice_date").val(min_invoice_date);
			}
			$("#pageForm").submit();
		})
		
		$('#max_invoice_date_a').on('click', function () {
		    $('#max_invoice_date').datetimepicker('show');
		});
		$('#min_invoice_date_a').on('click', function () {
		    $('#min_invoice_date').datetimepicker('show');
		});

		/**
		 * 初始化日期控件start
		 */
		var dmf = {
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		};

		//初始化日期控件start
		//最大日期
		$('#max_invoice_date').datetimepicker(dmf);
		var max_invoice_date = $("#max_invoice_date").val();
		if (max_invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(max_invoice_date);
		}
		//最小日期
		$('#min_invoice_date').datetimepicker(dmf);
		var min_invoice_date = $("#min_invoice_date").val();
		if (min_invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(min_invoice_date);
		}
		//初始化日期控件end
	})
</script>
</head>
<body>
	<form action="/accountsReceivableManageController/queryList.htm"
		id="pageForm" method="post">


		<!--top start -->
		<div class="v2_top_bg">

			<%@include file="/ybl/v2/admin/common/top.jsp" %>
			<!--top end-->
			<div class="v2_path">
				<spring:message code="sys.v2.client.location" />
				：
				<spring:message code="sys.v2.client.account.input" />
				> 
				<spring:message code="sys.v2.client.account.list" />
			</div>
			<!--搜索条件-->
			<div class="v2_seach_box">
				<ul>
					<li class="ww30"><label><spring:message
								code="sys.v2.client.companyName" />
							<!-- 企业名称 -->:</label><input type="text" name="enterprise_name" value="${account.enterprise_name }" /></li>
					<li class="ww30"><label><spring:message
								code="sys.v2.client.voucherNumber" />
							<!-- 凭证号 -->:</label><input type="text" name="number_" value="${account.number_ }" /></li>
					<li class="ww30"><label> <spring:message
								code="sys.v2.client.status" />
							<!-- 状态 -->:
					</label> <select class="v2_select w320" onchange="func()" name="status_"
						url="/configController/get-RECEIVABLE_STATUS" valueField="code_"
						textField="value_" defaultValue="${account.status_}" isSelect="Y">
					</select> </select></li>
					<li class="clear w460"><label><spring:message
								code="sys.v2.client.invoiceDate" />
							<!-- 开票日期 -->:</label> <span><input type="text" date="true"
							name="min_invoice_date" value="<fmt:formatDate value='${account.min_invoice_date }' pattern='yyyy-MM-dd'/>" id="min_invoice_date" /><a id="min_invoice_date_a"
							class="v2_date_ico"></a></span> <b><spring:message
								code="sys.v2.client.to" /></b> <span><input type="text"
							date="true" name="max_invoice_date" value="<fmt:formatDate value='${account.max_invoice_date }' pattern='yyyy-MM-dd'/>" id="max_invoice_date" /><a
							class="v2_date_ico" id="max_invoice_date_a"></a></span></li>

					<li><div class="v2_button_seach">
							<a id="supplier_account_Manage_Query_btn"><spring:message
									code="sys.v2.client.query" />
								<!-- 查询 --></a>
						</div></li>

				</ul>
			</div>
			<!--搜索条件-->
		</div>

		<!---->



		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><a
								href="/accountsReceivableManageController/queryaccountsReceivableDetail.htm"
								class="v2_but_add"><spring:message
										code="sys.v2.client.addAccount" />
									<!-- 新增应收账款 --></a></li>
<%-- 							<li><a class="v2_but_down"><spring:message --%>
<%-- 										code="sys.v2.client.bulkImport" /> --%>
<!-- 									批量导入</a></li> -->						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con" >
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" />
								<!-- 序号 --></th>
							<th width="200"><spring:message code="sys.v2.client.companyName" />
								<!-- 企业名称 --></th>
							<th width="200"><spring:message code="sys.v2.client.voucherNumber" />
								<!-- 凭证号 --></th>
							<th width="100"><spring:message code="sys.v2.client.amount.yuan" />
								<!-- 金额 (元)--></th>
							<th width="100"><spring:message code="sys.v2.client.invoiceDate" />
								<!-- 开票日期 --></th>
							<th width="100"><spring:message code="sys.v2.client.expectTheReceivable" />
								<!-- 预计回款日 --></th>
							<th width="160"><spring:message code="sys.v2.client.remark" />
								<!-- 备注 --></th>
							<th width="200"><spring:message code="sys.v2.client.status" />
								<!-- 状态 --></th>
							<th width="100"><spring:message code="sys.v2.client.operation" />
								<!-- 操作 --></th>
						</tr>
						<c:forEach var="list" items="${list}" varStatus="index">
							<tr>
								<td>${index.count }</td>
								<td>${list.enterprise_name }</td>
								<td>
									<a class="lan" href="/accountsReceivableManageController/queryaccountsReceivableDetail.htm?id=${list.id_ }&operator=query">
									${list.number_ }
									</a>
								</td>
								<td><fmt:formatNumber value="${list.amount_ }" pattern="##0.00" maxFractionDigits="2"/></td>
								<td><jsp:useBean id="dateValue" class="java.util.Date" />
									<jsp:setProperty name="dateValue" property="time"
										value="${list.invoice_date }" /> <fmt:formatDate
										value="${dateValue}" pattern="yyyy-MM-dd" /></td>
								<td><jsp:useBean id="dateValue1" class="java.util.Date" />
									<jsp:setProperty name="dateValue1" property="time"
										value="${list.return_date }" /> <fmt:formatDate
										value="${dateValue1}" pattern="yyyy-MM-dd" /></td>
								<td class="wb">${list.remark_ }</td>
								<td url="/configController/get-RECEIVABLE_STATUS/${list.status_ }"
									textField="value_"></td>
								<td>
								<c:if test="${list.status_ == 'draft'}">
								<a class="lan" href="/accountsReceivableManageController/queryaccountsReceivableDetail.htm?id=${list.id_ }">
										<spring:message code="sys.v2.client.edit" /><!-- 修改 -->
								</a>
								</c:if>
								<c:if test="${list.status_ != 'draft'}">
									--
								</c:if>
								</td>
							</tr>
						</c:forEach>

					</table>

				</div>

			</div>
			<%@include file="/ybl/v2/admin/common/page.jsp"%>
			<!--table-->

		</div>




		<!--弹出窗登录-->
		<!-- bottom.jsp -->
		<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
		<!-- bottom.jsp -->
	</form>


</body>


</html>
