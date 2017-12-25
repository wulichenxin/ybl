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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款管理--生成付款批次</div>
		</div>
		<form action="/factorLoanManagementController/loanPending/list.htm" id="pageForm" method="post">
			<div class="w1200 clearfix border-b">
				<ul class="clearfix formul">
					<li class="formli form_cur" onclick="javascript:window.location.href='<%=basePath%>factorLoanManagementController/loanPending/list.htm'">生成付款批次</li>
					<li class="formli" onclick="javascript:window.location.href='<%=basePath%>factorLoanManagementController/loanBatchPending/list.htm'">待付款批次</li>
				</ul>
			</div>
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form" name="loanApplyOrderNumber" value="${dto.loanApplyOrderNumber }"/></div>
					<div class="form-grou mr40"><label class="label-long">融资单号：</label><input class="content-form" name="financingOrderNumber" value="${dto.financingOrderNumber }"/></div>
					<div class="form-grou"><label class="label-long">放款状态：</label>
						<select class="content-form" name="status">
							<option value="5">待放款</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long">放款申请时间：</label><input id="startDate" class="content-form" name="startDate" value="${dto.startDate }"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" class="content-form" name="endDate" value="${dto.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="form-grou"><label class="label-long">资产类型：</label>
						<select class="content-form" name="assetsType">
							<option value="">请选择</option>
							<option value="1" <c:if test="${dto.assetsType eq 1}">selected="selected"</c:if>>应收账款</option>
							<option value="2" <c:if test="${dto.assetsType eq 2}">selected="selected"</c:if>>应付账款</option>
							<option value="3" <c:if test="${dto.assetsType eq 3}">selected="selected"</c:if>>票据</option>
						</select>
					</div>
				</div>
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
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>关联融资申请订单号</th>
								<th>放款状态</th>
								<th>操作</th>
							</tr>
							<c:if test="${empty page.records}">
								<tr><td colspan="11">暂无数据</td></tr>
							</c:if>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td class="maxwidth"><a style="cursor: pointer;" href="javascript:;" class="order-a subView" lid="${obj.loanApplyId}">${obj.loanApplyOrderNumber}</a></td>
									<td class="maxwidth">${obj.financier}</td>
									<td class="maxwidth">
										<c:if test="${obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${obj.assetsType eq 3}">票据</c:if>
									</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="##0.####" maxFractionDigits="4"/></td>
									<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth">${obj.financingOrderNumber}</td>
									<td class="maxwidth">
										<c:if test="${obj.status eq 5}">待放款</c:if>
									</td>
									<td class="maxwidth"><a href="javascript:;" class="btn-modify mr10" onclick="createPaymentBatch(${obj.loanApplyId})">生成付款批次</a></td>
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
		$(".subView").click(function(){
			var lid=$(this).attr("lid");
			param={"id":lid,"url":"/factorLoanManagementController/loanPending/list.htm"};
			httpPost('/loanApplyCommonApi/selectChildrenDetail.htm',param);
		})
		</script>
	</body>
</html>