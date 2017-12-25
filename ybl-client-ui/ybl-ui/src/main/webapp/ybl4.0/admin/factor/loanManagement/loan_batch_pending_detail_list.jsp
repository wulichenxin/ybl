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
		<!--弹出框-->
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款管理--待付款批次详情</div>
		</div>
		<form action="/factorLoanManagementController/loanBatchPending/detail.htm" id="pageForm" method="post">
			<input type="hidden" name="batchId" value="${dto.batchId }"/>
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-back">返回</div>
			</div>
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请订单号</th>
								<th>融资方</th>
								<th>资产类型</th>
								<th>融资申请金额(元)</th>
								<th>融资期限(天)</th>
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>关联融资申请订单号</th>
								<th>放款状态</th>
							</tr>
							<c:if test="${empty page.records}">
								<tr><td colspan="10">暂无数据</td></tr>
							</c:if>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td class="maxwidth"><a href="javascript:;" class="order-a">${obj.loanApplyOrderNumber}</a></td>
									<td class="maxwidth">${obj.financier}</td>
									<td class="maxwidth">
										<c:if test="${obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${obj.assetsType eq 3}">票据</c:if>
									</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.financingTerm}</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="##0.####" maxFractionDigits="4"/></td>
									<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth">${obj.financingOrderNumber}</td>
									<td class="maxwidth">
										<c:if test="${obj.status eq 5}">待放款</c:if>
									</td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</form>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/loanManagement/loan_pending.js"></script>
		<script type="text/javascript">
		$('#startDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		$('#btn-back').click(function(){
			location.href='/factorLoanManagementController/loanBatchPending/list.htm';
		});
		/**
		 * 生成付款批次
		 */
		function createPaymentBatch(loanApplyId) {
			$.ajax({
				url:'/factorLoanManagementController/createBatch',
				dataType:'json',
				type:'post',
				data:{"loanApplyId":loanApplyId},
				success:function(data){
					if(data.responseTypeCode == "success"){
						alert(data.info,function(){
							location.href='/factorLoanManagementController/loanPending/list.htm';
						});
					}else{
						alert(data.info);
					}					
				},
				complete: function( xhr,data ){
					if(xhr.getResponseHeader('sessionstatus') == 'timeOut') {
						alert("登陆已失效，请重新登陆！",function(){
							location.href='/loginV4Controller/toLogin.htm';
						});
					}
				 }
			}); 
		}
		</script>
	</body>
</html>