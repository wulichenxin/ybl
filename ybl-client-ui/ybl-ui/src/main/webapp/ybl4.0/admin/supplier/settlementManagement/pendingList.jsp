<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>正常还款</title>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>
	<!--top start -->
	<!--top end -->
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />正常还款
		</div>
	</div>
	<div class="w1200 clearfix border-b">
		<ul class="clearfix formul">
			<li id="unconfirmmed"
				class="formli <c:if test="${status eq 1}">form_cur</c:if>">正常还款</li>
			<li id="confirmmed"
				class="formli <c:if test="${status eq 3}">form_cur</c:if>">逾期还款</li>
			<script type="text/javascript">
				$("#unconfirmmed")
						.click(
								function() {
									var form = $("#pageForm");
									var my_input = $('<input type="text" name="status" value="1" style="display:none;"/>');
									$("#query_status").remove();
									form.append(my_input);
									form.submit();
								});
				$("#confirmmed")
						.click(
								function() {
									var form = $("#pageForm");
									var my_input = $('<input type="text" name="status" value="3" style="display:none;"/>');
									$("#query_status").remove();
									form.append(my_input);
									form.submit();
								});
			</script>
		</ul>
	</div>
	<form action="/rePayMentController/pendingPayment.htm" id="pageForm"
		method="post">
		<div class="w1200 ybl-info">
			<div class="ground-form mb20">
				<input id="query_status" name="status" value="${status}"
					style="display: none;">
				<div class="form-grou mr40">
					<label class="label-long">放款申请单号：</label><input
						class="content-form" name="loanApplyOrderNo" value="${parm.loanApplyOrderNo}"/>
				</div>
				<!-- <div class="form-grou mr40">
					<label>还款状态：</label> <select class="content-form"
						name="repaymentStatus">
						<option value="">全部</option>
						<option value="1">待还款</option>
						<option value="2">待确认</option>
					</select>
				</div> -->
				<div class="form-grou">
					<label class="label-long">还款时间：</label><input id="startDate"
						class="content-form" name="startDate" value="${startDate}"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40">
					<input id="endDate" class="content-form" name="endDate" value="${endDate}"/> <img
						class="timeimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
				<div class="form-grou"><div id="btn-query" class="btn-modify">查询</div></div>
			</div>
		</div>
		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>放款申请订单号</th>
							<th>资金方</th>
							<th>核心企业</th>
							<th>资产编号</th>
							<th>第几期/总期数</th>
							<th>还款日期</th>
							<th>本期应还本金(元)</th>
							<th>本期应还利息(元)</th>
							<th>关联融资申请单号</th>
							<th>本期还款状态</th>
							<th>还款确认</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${list}" var="obj" varStatus="index">
							<tr>
								<td class="toggletr">${index.count}</td>
								<td class="width"><a param="${obj.loanId}" href="#" class="order-a loanApi">${obj.loanApplyOrderNo}</a></td>
								<td>${obj.financingName}</td>
								<td>${obj.coreEnterpriseName}</td>
								<td>${obj.assetNumber}</td>
								<td>${obj.period}</td>
								<td><fmt:formatDate value="${obj.repaymentDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatNumber value="${obj.repaymentPrincipal}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${obj.repaymentInterest}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
								<td class="width"><a param="${obj.faId} ${obj.sfaId}" href="#" class="order-a appApi">${obj.financing_order_number}</a></td>
								<td>待还款</td>
								<td>否
								</td>
								<td><a param="${obj.loanId}"
									class="btn-modify mr10 tip openSelect" onclick="">还款</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
	</form>
	</div>
	<script type="text/javascript"
		src="/ybl4.0/resources/js/factor/collectionManagement/overdue.js"></script>
	<script type="text/javascript">
		$('#startDate,#endDate').datetimepicker({
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		});

		/* $(".openSelect").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,|-/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0]
				},
				formAttrbute : {
					action : "/rePayMentController/view.htm",
					method : "POST"
				}
			});

		}); */
		
		$(".loanApi").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,|-/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0],
					url: "/rePayMentController/pendingPayment.htm"
				},
				formAttrbute : {
					action : "/loanApplyCommonApi/selectChildrenDetail.htm",
					method : "POST"
				}
			});

		});
		
		$(".appApi").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,|-/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0],
					childrenId : formDateArry[1],
					statue: 9,
					url: "/rePayMentController/pendingPayment.htm"
				},
				formAttrbute : {
					action : "/financingApplyCommonApi/view.htm",
					method : "POST"
				}
			});

		});
		
		$(".openSelect").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,|-/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0],
					url: "/rePayMentController/pendingPayment.htm"
				},
				formAttrbute : {
					action : "/rePayMentController/selectChildrenDetail.htm",
					method : "POST"
				}
			});

		});
	</script>
</body>
</html>