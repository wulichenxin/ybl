<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
	</head>
	<!--top start -->
	<%@include file="/ybl4.0/admin/common/link.jsp" %>	
	<!--top end -->
	<body>
		<p class="per_title"><span>放款失败项目</span></p>
		<div class="mt40">
			<form action="/factorInvestManagementController/getFailedLoanApplyList.htm" id="pageForm" method="post">
				<div class="ybl-info">
					<div class="btn-found" id="btn-query">查询</div>
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long">放款申请编号：</label><input class="content-form" name="orderNo" value="${vo.orderNo }"/></div>
						<label>放款状态：</label>
						<select class="content-form" name="financingStatus">
							<option value="">放款失败</option>
						</select>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long">申请日期：</label><input id="payStartDate" class="content-form" name="payStartDate" value="${vo.payStartDate }"/></div>
						<span class="mr10 ml10">-</span>
						<div class="form-grou mr40"><input id="payEndDate" class="content-form" name="payEndDate" value="${vo.payEndDate }"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					</div>
				</div>
				<div class="mt40">
					<div class="tabD">
						<div class="scrollbox">
							<table>
								<tr>
									<th>序号</th>
									<th>放款申请单号</th>
									<th>融资方名称</th>
									<th>资产类型</th>
									<th>申请融资金额(元)</th>
									<th>融资期限(天)</th>
									<th>融资利率(%)</th>
									<th>申请日期</th>
									<th>融资订单号</th>
									<th>融资状态</th>
									<th>操作</th>
								</tr>
								<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="15">
										暂时没有相关数据~
									</td>
								</tr>
								</c:if>
								<c:forEach items="${list}" var="obj" varStatus="index">
					              	<tr>
										<td class="toggletr">${index.count}</td>
										<td title="${obj.orderNo}" class="maxwidth"><a href="#" class="order-a details" uid="${obj.id }" orderNo="${obj.orderNo }" batchId="${obj.paymentBatchId }" subId="${obj.subFinancingApplyId }">${obj.orderNo}</a></td>
										<td title="${obj.enterpriseName}" class="maxwidth">${obj.enterpriseName}</td>
										<!-- 资产类型1-应收账款2-应付账款3-票据 -->
										<td>
											<c:if test="${obj.assetsType eq 1 }">应收账款</c:if>
											<c:if test="${obj.assetsType eq 2 }">应付账款</c:if>
											<c:if test="${obj.assetsType eq 3 }">票据</c:if>
										</td>
										<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${obj.financingTerm}</td>
										<td><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.####"/></td>
										<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
										<td title="${obj.orderNoApply}" class="maxwidth"><a href="javascript:;" class="order-a">${obj.orderNoApply}</a></td>
										<td>放款失败</td>
										<td>
											<a href="#" class="btn-modify mr10 tip details" uid="${obj.id }" orderNo="${obj.orderNo }" batchId="${obj.paymentBatchId }" subId="${obj.subFinancingApplyId }">查看</a>
										</td>
									</tr>
				              </c:forEach>
							</table>
						</div>
					</div>
					<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
				</form>
				<form action="/loanApplyCommonApi/selectChildrenDetail.htm" id="pageDetais" method="post" target="_blank">
					<input type="hidden" name="id" id="oId" value=""/>
					<input type="hidden" name="orderno" id="orderNo" value=""/>
					<input type="hidden" name="batchid" id="oBatchid" value=""/>
					<input type="hidden" name="subid" id="oSubid" value=""/>
					<input type="hidden" name="url" id="url" value="###"/>
				</form>
			</div>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/overdue.js"></script>
		<script type="text/javascript">
		$('#payStartDate,#payEndDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		$(".details").click(function(){
			var id=$(this).attr("uid");
			var orderno=$(this).attr("orderNo");
			var batchid=$(this).attr("batchId");
			var subid=$(this).attr("subId");
			if(batchid ==null || batchid == 'undefined'){
				batchid = 0;
			}
			$("#oId").val(id);
			$("#orderNo").val(orderno);
			$("#oBatchid").val(batchid);
			$("#oSubid").val(subid);
			$("#pageDetais").submit();
		})
		</script>
	</body>
</html>