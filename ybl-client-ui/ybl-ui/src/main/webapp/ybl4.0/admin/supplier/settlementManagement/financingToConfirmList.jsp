<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<html>

<head>
<meta charset="UTF-8">
<title>结算管理</title>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>


	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />结算管理<span
				class="mr10 ml10">-</span>融资确认
		</div>
	</div>
	<div class="w1200 clearfix border-b">
		<ul class="clearfix formul">
			<li id="unconfirmmed"
				class="formli <c:if test="${parm.status eq 8}">form_cur</c:if>">待确认项目</li>
			<li id="confirmmed"
				class="formli <c:if test="${parm.status eq 9}">form_cur</c:if>">已确认项目</li>
			<script type="text/javascript">
				$("#unconfirmmed")
						.click(
								function() {
									var form = $("#pageForm");
									var my_input = $('<input type="text" name="status" value="8" style="display: none;"/>');
									$("#query_status").remove();
									form.append(my_input);
									form.submit();
								});
				$("#confirmmed")
						.click(
								function() {
									var form = $("#pageForm");
									var my_input = $('<input type="text" name="status" value="9" style="display: none;"/>');
									$("#query_status").remove();
									form.append(my_input);
									form.submit();
								});
			</script>
		</ul>
	</div>
	<div class="w1200 ybl-info">
		<form id="pageForm" action="/financingToConfirm/list" method="post">
			<input id="query_status" name="status" value="${parm.status}"
				style="display: none;" type="hidden">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label>放款单号：</label><input class="content-form" name="order_no"
						value="${parm.order_no}" />
				</div>
				<div class="form-grou">
					<label class="label-long">申请时间：</label><input name="begin_date"
						value="${parm.begin_date}" id="beginDate" class="content-form" /><img
						class="timeimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40">
					<input name="end_date" value="${parm.end_date}" id="endDate"
						class="content-form" /><img class="timeimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label>保理类型：</label><select name="factoring_mode"
						class="content-form"><option
							<c:if test="${empty parm.factoring_mode}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${parm.factoring_mode eq 1}">selected="selected"</c:if>
							value="1">明保</option>
						<option
							<c:if test="${parm.factoring_mode eq 2}">selected="selected"</c:if>
							value="2">暗保</option>
					</select>
				</div>
				<div class="form-grou"><div id="query" class="btn-modify">查询</div></div>
			</div>
	</div>

	<div class="w1200 mt40">
		<div class="tabD">
			<div class="scrollbox">
				<table style="width:2200px;font-size: 14px">
					<tr>
						<th>序号</th>
						<th>放款申请单号</th>
						<th>资金方</th>
						<th>产品类型</th>
						<th>申请放款金额(元)</th>
						<th>融资期限(天)</th>
						<th>融资利率(%)</th>
						<th>申请日期</th>
						<th>结算金额(元)</th>
						<th>实际放款金额(元)</th>
						<th>融资费用(元)</th>
						<th>实际支付时间</th>
						<th>关联融资申请单号</th>
						<th>收款确认</th>
						<th>申请确认时间</th>
						<c:if test="${parm.status eq 8}">
						<th>操作</th>
						</c:if>
						
					</tr>
					<c:forEach items="${page.records}" var="entity" varStatus="xh">
						<tr>
							<td class="toggletr">${xh.count}</td>
							<td class="width"><a param="${entity.loan_id}" href="#" class="order-a appApi">${entity.order_no}</a></td>
							<td>${entity.funder_name}</td>
							<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if
									test="${entity.assets_type eq 2}">应付账款</c:if>
								<c:if test="${entity.assets_type eq 3}">票据</c:if></td>
							<td><fmt:formatNumber value="${entity.financing_amount}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
							<td>${entity.financing_term}</td>
							<td><fmt:formatNumber value="${entity.financing_rate}"
										pattern="#,##0.####" maxFractionDigits="4" /></td>
							<td><lzq:date value="${entity.created_time}"
									parttern="yyyy-MM-dd" /></td>
							<td><fmt:formatNumber value="${entity.total_settlement_amount}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
							<td><fmt:formatNumber value="${entity.actual_loan_amount}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
							<td><fmt:formatNumber value="${entity.total_financing_fee}"
										pattern="#,##0.##" maxFractionDigits="2" /></td>
							<td><lzq:date value="${entity.actual_loan_date}"
									parttern="yyyy-MM-dd" /></td>
							<td class="width"><a param="${entity.fa_id} ${entity.sfa_id}" href="#" class="order-a loanApi">${entity.sfa_order_no}</a></td>
							<c:if test="${entity.status eq 9}">
								<td>已确认收款</td>
							</c:if>
							<c:if test="${entity.status eq 8}">
								<td>待收款确认</td>
							</c:if>
							
							<td><lzq:date value="${entity.created_time}"
									parttern="yyyy-MM-dd" /></td>
							<c:if test="${entity.status==8}">
							<td><a href="#" param="${entity.loan_id}"
								class="btn-modify openSelect">确认</a>
							</td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<jsp:include page="/ybl4.0/admin/common/page.jsp" />
		</form>


	</div>
	<div class="mb80"></div>
	<script>
		$('#beginDate,#endDate').datetimepicker({
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		});

		$(function() {
			/* 查询提交表单 */
			$("#query").click(function() {

				$("#pageForm").submit();
			});

			$(".openSelect").click(function() {
				var paramString = $(this).attr("param");
				var formDateArry = paramString.split(/\s+|,|-/g);
				$.createFormAndSubmit({
					formDate : {
						id : formDateArry[0],
						url: "/financingToConfirm/list"
					},
					formAttrbute : {
						action : "/financingToConfirm/selectChildrenDetail.htm",
						method : "POST"
					}
				});

			});

			$("#submit").click(function() {
				var ids = new Array();
				var financing_apply_id = $("#financing_id").val();
				var financing_status = 5
				$("input:checkbox:checked").each(function(index, element) {
					ids[index] = $(element).val()
				});
				if (ids.length <= 0) {
					alert("至少选择一个资方");
					return false;
				}
				if (ids.length > 3) {
					alert("最多选择三家资方");
					return false;
				}
				b = ids.join(",");
				$.ajax({
					url : '/chooseFundsController/updateSubFundsList',
					type : 'POST', //GET
					async : true, //或false,是否异步
					data : {
						ids : b,
						financing_apply_id : financing_apply_id,
						financing_status : financing_status
					},
					timeout : 5000, //超时时间
					dataType : 'json',
					success : function(data) {
						alert(data);

					}

				});
				$("#subFincancingList").empty();
				$("#select").hide();
				location.replace("/chooseFundsController/chooseFundsList");

			});
			
			$(".loanApi").click(function() {
				var paramString = $(this).attr("param");
				var formDateArry = paramString.split(/\s+|,|-/g);
				$.createFormAndSubmit({
					formDate : {
						id : formDateArry[0],
						childrenId : formDateArry[1],
						statue: 9,
						url: "/financingToConfirm/list"
					},
					formAttrbute : {
						action : "/financingApplyCommonApi/view.htm",
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
						url: "/financingToConfirm/list"
					},
					formAttrbute : {
						action : "/loanApplyCommonApi/selectChildrenDetail.htm",
						method : "POST"
					}
				});

			});

			$("#cancel").click(function() {
				$("#subFincancingList").empty();
				$("#select").hide();

			});

		});
	</script>
</body>

</html>