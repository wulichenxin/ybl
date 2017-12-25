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
		<meta charset='utf-8' />
		<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
		<%@include file="/ybl4.0/admin/common/link.jsp"%>
	</head>

	<body>
		<!--弹出框-->
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
		<!--top end -->
		<div class="Bread-nav">
			<div><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待收款项目</div>
		</div>
		<form action="/supplierAccountCenterController/receivingacount.htm" id="pageForm" method="post">
			<div class="ybl-info">
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>放款单号：</label><input class="content-form" name="orderNo" value="${loanProjectVO.orderNo }"/></div>
					<div class="form-grou mr40"><label>保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="0">全部</option>
							<option value="1" <c:if test="${loanProjectVO.factoringMode eq 1 }">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${loanProjectVO.factoringMode eq 2 }">selected="selected"</c:if> >暗保理</option>
						</select>
					</div>
					<div class="form-grou">
						<label>放款状态：</label>
						<select class="content-form" name="status"><option value="8">待收款确认</option></select>
					</div>
				</div>
				<div class="ground-form">
					<!-- 启用attribute5_，attribute6_两个备用字段，表示放款申请开始时间、结束时间 -->
					<div class="form-grou"><label>申请时间：</label><input id="beginDate" name="beginDate" class="content-form" value="${loanProjectVO.beginDate }"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" name="endDate" class="content-form" value="${loanProjectVO.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="btn-modify" id="btn-query-receivingacount">查询</div>
				</div>
			</div>
			<div class="mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请单号</th>
								<th>资金方</th>
								<th>资产类型</th>
								<th>申请放款金额(元)</th>
								<th>融资期限(天)</th>
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>结算金额(元)</th>
								<th>实际放款金额(元)</th>
								<th>融资费用(元)</th>
								<th>实际支付时间</th>
								<th>关联主合同号</th>
								<th>放款状态</th>
								<th>收款确认</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="#" class="order-a" assetsType="${obj.assetsType }" financingAmount="${obj.financingAmount }" 
											id="${obj.id }" orderNo="${obj.orderNo}" onclick="">${obj.orderNo}</a></td>
									<td>${obj.financingName}</td>
									<td>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
									</td>
									<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.financingTerm}</td>
									<td><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td>${obj.totalSettlementAmount}</td>
									<td><fmt:formatNumber value="${obj.actualLoanAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.totalFinancingFee}</td>
									<td><fmt:formatDate value="${obj.actualLoanDate}" pattern="yyyy-MM-dd"/></td>
									<td>${obj.masterContractNo}</td>
									<td>
										<c:if test="${not empty obj.status and obj.status eq 8}">待确认</c:if>
										<c:if test="${not empty obj.status and obj.status eq 9}">已确认</c:if>
									<td>
										<c:if test="${not empty obj.status and obj.status eq 8}">否</c:if>
										<c:if test="${not empty obj.status and obj.status eq 9}">是</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.status and obj.status eq 8}">
											<a href="#" class="btn-modify mr10 tip details" assetsType="${obj.assetsType }" financingAmount="${obj.financingAmount }" 
											id="${obj.id }" orderNo="${obj.orderNo}" onclick="">确认</a>
										</c:if>
										<c:if test="${not empty obj.status and obj.status eq 9}">
											<a href="#" class="btn-modify mr10 tip details" assetsType="${obj.assetsType }" financingAmount="${obj.financingAmount }" 
											id="${obj.id }" orderNo="${obj.orderNo}" onclick="">查看</a>
										</c:if>
									</td>
								</tr>
			              </c:forEach>
						</table> 
					</div>
				</div>
		<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</form>
		</div>
		
		<script type="text/javascript">
		$(function(){	
			$('#beginDate,#endDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			$(".details,.order-a").click(function(){
	            var assetsType=$(this).attr("assetsType");
	            var financingAmount=$(this).attr("financingAmount");
	            var id=$(this).attr("id");
	            var orderNo=$(this).attr("orderNo");
	            
	            //window.open('/supplierAccountCenterController/receiveconfirm?assetsType='+assetsType+'&financingAmount='+financingAmount+'&id='+id+'&orderNo='+orderNo, '_blank', '');
	            var  url = "/supplierAccountCenterController/receiveconfirm";
	            //首先创建一个form表单  
	            var tempForm = document.createElement("form");    
	            tempForm.id="tempForm1";  
	            tempForm.method="post";   
	            tempForm.action=url;  
	            tempForm.target="_blank";   
	            //创建input标签，用来设置参数  
	            var hideInput = document.createElement("input");    
	            hideInput.type="hidden";    
	            hideInput.name= "assetsType";  
	            hideInput.value= assetsType; 
	            var hideInput2 = document.createElement("input");  
	            hideInput2.type = "hidden";
	            hideInput2.name = "financingAmount";
	            hideInput2.value = financingAmount;
	            var hideInput3 = document.createElement("input");  
	            hideInput3.type = "hidden";
	            hideInput3.name = "id";
	            hideInput3.value = id;
	            var hideInput4 = document.createElement("input");  
	            hideInput4.type = "hidden";
	            hideInput4.name = "orderNo";
	            hideInput4.value = orderNo;
	            //将input表单放到form表单里  
	            tempForm.appendChild(hideInput); 
	            tempForm.appendChild(hideInput2);
	            tempForm.appendChild(hideInput3);
	            tempForm.appendChild(hideInput4);
	            
	            //将此form表单添加到页面主体body中  
	            document.body.appendChild(tempForm); 
	            tempForm.submit();
	            document.body.removeChild(tempForm); 
			
			});
			
			//查询
			$("#btn-query-receivingacount").click(function() {
				$("#pageForm").submit();
			});
			
		});	
		</script>
	</body>
</html>