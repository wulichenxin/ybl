<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.v2.client.account.audit"/></title>
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

<script type="text/javascript">
	$(function() {
		$("#factor_recheck_account_Manage_Query_btn").click(function() {
			var max_apply_date = $("#max_apply_date").val();
			var min_apply_date = $("#min_apply_date").val();
			
			var min_affirm_date = $("#min_affirm_date").val();
			var max_affirm_date = $("#max_affirm_date").val();
			if(max_apply_date != ''){
				max_apply_date += ' 00:00:00';
				$("#max_apply_date").val(max_apply_date);
			}
			if(min_apply_date != ''){
				min_apply_date += ' 00:00:00';
				$("#min_apply_date").val(min_apply_date);
			}
			if(min_affirm_date != ''){
				min_affirm_date += ' 00:00:00';
				$("#min_affirm_date").val(min_affirm_date);
			}
			if(max_affirm_date != ''){
				max_affirm_date += ' 00:00:00';
				$("#max_affirm_date").val(max_affirm_date);
			}
			$("#pageForm").submit();
		})
		
		$('#max_apply_date_a').on('click', function () {
		    $('#max_apply_date').datetimepicker('show');
		});
		$('#min_apply_date_a').on('click', function () {
		    $('#min_apply_date').datetimepicker('show');
		});
		
		$('#min_affirm_date_a').on('click', function () {
		    $('#min_affirm_date').datetimepicker('show');
		});
		$('#max_affirm_date_a').on('click', function () {
		    $('#max_affirm_date').datetimepicker('show');
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
		$('#max_apply_date').datetimepicker(dmf);
		var max_apply_date = $("#max_apply_date").val();
		if (max_apply_date) {
			var fmtDate = new Date();
			fmtDate.setTime(max_apply_date);
		}
		//最小日期
		$('#min_apply_date').datetimepicker(dmf);
		var min_apply_date = $("#min_apply_date").val();
		if (min_apply_date) {
			var fmtDate = new Date();
			fmtDate.setTime(min_apply_date);
		}
		//最大日期
		$('#max_affirm_date').datetimepicker(dmf);
		var max_affirm_date = $("#max_affirm_date").val();
		if (max_affirm_date) {
			var fmtDate = new Date();
			fmtDate.setTime(max_affirm_date);
		}
		//最小日期
		$('#min_affirm_date').datetimepicker(dmf);
		var min_affirm_date = $("#min_affirm_date").val();
		if (min_affirm_date) {
			var fmtDate = new Date();
			fmtDate.setTime(min_affirm_date);
		}
		
		//初始化日期控件end
	})
</script>
</head>
<body>
<form action="/accountsAffirmController/queryRecheckList.htm" id="pageForm" method="post">
	<div class="v2_top_bg v2_t_bg2 h410">
		<div class="v2_top_con">
			<!--top start -->
			<%@ include file="/ybl/v2/admin/common/top.jsp"%>
			<div class="v2_z_nav now">
				<div class="v2_z_nav_con">
				<div class="v2_z_navbox">
					<a class="w150 "  href="/accountsAffirmController/queryFactorList.htm"><spring:message code="sys.v2.client.riskFirstAudit"/></a>
					<a class="w150 " href="/accountsAffirmController/queryAnalyzeList.htm"><spring:message code="sys.v2.client.analysis"/></a>
					<a class="w150 now" href="/accountsAffirmController/queryRecheckList.htm"><spring:message code="sys.v2.client.riskReAudit"/></a>
					<a class="w150 " href="/accountsAffirmController/queryBusinessList.htm"><spring:message code="sys.v2.client.businessHandling"/></a>
				</div>
				</div>
			</div>
			<!--top end -->
			
			<div class="v2_path"><spring:message code="sys.v2.client.location"/>：<spring:message code="sys.v2.client.account.audit"/> > <spring:message code="sys.v2.client.riskReAudit"/> </div>
			<!--搜索条件-->
			<div class="v2_seach_box">
				<ul>
					<li><label><spring:message code="sys.v2.client.supplier"/>:</label><input type="text" name="supplier_enterprise_name" value="${account.supplier_enterprise_name }"/></li>
					<li><label><spring:message code="sys.v2.client.companyName"/>:</label><input type="text" name="enterprise_name" value="${account.enterprise_name }"/></li>
					<li class="w420"><label><spring:message code="sys.v2.client.contract.confrim.date"/>:</label><span><input
							type="text" class="w130" date="true" name="min_affirm_date" id="min_affirm_date" value="<fmt:formatDate value="${account.min_affirm_date }" type="both"  pattern="yyyy-MM-dd"/>"/><a class="v2_date_ico" id="min_affirm_date_a"></a></span><b><spring:message code="sys.v2.client.to"/></b><span><input
							type="text" class="w130" date="true" name="max_affirm_date" id="max_affirm_date" value="<fmt:formatDate value="${account.max_affirm_date }" type="both"  pattern="yyyy-MM-dd"/>"/><a class="v2_date_ico" id="max_affirm_date_a"></a></span></li>
					<li><label><spring:message code="sys.v2.client.voucherNumber"/><!-- 凭证号 -->:</label><input type="text"
					name="number_" value="${account.number_ }"/></li>
					<li><label><spring:message code="sys.v2.client.status"/><!-- 状态 -->:</label>
					<select class="v2_select w320" 
						name="operation_"
						url="/configController/getExcept-AUDIT_OPERATION/agree,disagree" valueField="code_"
						textField="value_"  defaultValue="${account.operation_ }"
						isSelect="Y">
					</select>
					</li>
					<li class="w420"><label><spring:message code="sys.v2.client.contract.apply.date"/>:</label><span><input
							type="text" class="w130" date="true" name="min_apply_date" id="min_apply_date" value="<fmt:formatDate value="${account.min_apply_date }" type="both"  pattern="yyyy-MM-dd"/>"/><a class="v2_date_ico" id="min_apply_date_a"></a></span><b><spring:message code="sys.v2.client.to"/></b><span><input
							type="text" class="w130" date="true" name="max_apply_date" id="max_apply_date" value="<fmt:formatDate value="${account.max_apply_date }" type="both"  pattern="yyyy-MM-dd"/>"/><a class="v2_date_ico" id="max_apply_date_a"></a></span></li>
					<li><div class="v2_button_seach">
							<a id="factor_recheck_account_Manage_Query_btn"><spring:message code="sys.v2.client.query"/><!-- 查询 --></a>
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
				
				<!--按钮top-->
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="100"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
							<th width="100"><spring:message code="sys.v2.client.supplier.enterpriseName"/><!-- 供应商 --></th>
							<th width="100"><spring:message code="sys.v2.client.companyName"/><!-- 企业名称 --></th>
							<th width="100"><spring:message code="sys.v2.client.voucherNumber"/><!-- 凭证号 --></th>
							<th width="100"><spring:message code="sys.v2.client.amount.yuan"/><!-- 金额 --></th>
							<th width="120"><spring:message code="sys.v2.client.expectTheReceivable"/><!-- 预计回款日 --></th>
							<th width="100"><spring:message code="sys.v2.client.contract.apply.date"/></th>
							<th width="120"><spring:message code="sys.v2.client.contract.confrim.date"/></th>
							<th width="100"><spring:message code="sys.v2.client.status"/><!-- 状态 --></th>
							<th width="100"><spring:message code="sys.v2.client.operation"/><!-- 操作 --></th>
						</tr>
						<c:forEach var="list" items="${list}" varStatus="index">
							<tr>
								<td>${index.count }</td>
								<td>${list.supplier_enterprise_name }</td>
								<td>${list.enterprise_name }</td>
								<td>${list.number_ }</td>
								<td><fmt:formatNumber value="${list.amount_ }" pattern="##0.00" maxFractionDigits="2"/></td>
								<td>
									<jsp:useBean id="dateValue1" class="java.util.Date" />
									<jsp:setProperty name="dateValue1" property="time" value="${list.return_date }" />
									<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd" />
								</td>
								<td><jsp:useBean id="dateValue2" class="java.util.Date" />
									<jsp:setProperty name="dateValue2" property="time" value="${list.submission_time}" />
									<fmt:formatDate value="${dateValue2}" pattern="yyyy-MM-dd" /></td>
								<td>
									<jsp:useBean id="dateValue" class="java.util.Date" />
									<jsp:setProperty name="dateValue" property="time" value="${list.affirm_time }" />
									<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
								</td>
								<td>
									<c:if test="${list.audit_status == 'recheck'}">
										<c:if test="${list.operation_ == 'authstr'}">
											<spring:message code="sys.v2.client.checkPending"/><!-- 待审核 -->
										</c:if>
										<c:if test="${list.operation_ == 'disagree'}">
											<spring:message code="sys.v2.client.refuse"/><!-- 拒绝 -->
										</c:if>
										<c:if test="${list.operation_ == 'turn_down'}">
											<spring:message code="sys.v2.client.rejected"/><!-- 驳回 -->
										</c:if>
									</c:if>
								</td>
								<td>
									<c:if test="${list.audit_status == 'recheck'}">
										<c:if test="${list.operation_ == 'authstr'}">
										<a class="lan" href="/accountsAffirmController/queryRecheckDetail.htm?id=${list.id_ }">
										<spring:message code="sys.v2.client.auditOperator"/><!-- 审核 --></a>
										</c:if>
										<c:if test="${list.operation_ == 'agree' || list.operation_ == 'disagree' || list.operation_ == 'turn_down'}">
											--
										</c:if>
									</c:if>
									
								</td>
							</tr>
						</c:forEach>

					</table>

				</div>

			</div>
			<jsp:include page="/ybl/v2/admin/common/page.jsp" />
			<!--table-->

		</div>
</form>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>