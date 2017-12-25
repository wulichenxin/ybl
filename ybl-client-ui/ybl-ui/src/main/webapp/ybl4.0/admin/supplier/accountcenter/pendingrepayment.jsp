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
			<div><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待还款项目</div>
		</div>
		<form action="/supplierAccountCenterController/supplierreceiving.htm" id="pageForm" method="post">
			<div class="ybl-info">
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>放款单号：</label><input class="content-form" name="orderNo" value="${loanProjectVO.orderNo }"/></div>
					<div class="form-grou mr40"><label>保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="0">全部</option>
							<option value="1" <c:if test="${loanProjectVO.factoringMode eq 1 }">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${loanProjectVO.factoringMode eq 2 }">selected="selected"</c:if>>暗保理</option>
						</select>
					</div>
					<div class="form-grou">
						<label>还款状态：</label>
						<select class="content-form" name="repaymentStatus"><option value="1">未还款</option></select>
					</div>
				</div>
				<div class="ground-form">
					<div class="form-grou"><label> 还款时间：</label><input name="beginDate" id="beginDate" class="content-form" value="${loanProjectVO.beginDate }"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input name="endDate" id="endDate" class="content-form" value="${loanProjectVO.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="btn-modify" id="btn-query-supplierreceiving">查询</div>
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
								<th>核心企业</th>
								<th>资产编号</th>
								<th>第几期/总期数</th>
								<th>还款日期</th>
								<th>本期应还本金(元)</th>
								<th>本期应还利息(元)</th>
								<th>本期还款状态</th>
								<th>还款确认</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="#" class="order-a" type="${obj.assetsType }" financingAmount="${obj.financingAmount }" status="${obj.status }"
											id="${obj.id }" period="${obj.period }" orderNo="${obj.orderNo}" onclick="">${obj.orderNo}</a></td>
									<td>${obj.financingName}</td>
									<td>${obj.coreEnterpriseName}</td>
									<td>${obj.assetNumber}</td>
									<td>${obj.period}</td>
									<td><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td><fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 1}">未还款</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 2}">已还款</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 3}">已逾期</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 4}">催收中</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 5}">坏账</c:if>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 2}">是</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus ne 2}">否</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus ne 2}">
											<a href="#" class="btn-modify mr10 tip details" type="${obj.assetsType }" financingAmount="${obj.financingAmount }" 
											id="${obj.id }" orderNo="${obj.orderNo}" status="${obj.status }" onclick="">还款</a>
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
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/loanManagement/loan_pending.js"></script>
		<script type="text/javascript">
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
            var type=$(this).attr("type");
            var financingAmount=$(this).attr("financingAmount");
            var id=$(this).attr("id");
            var orderNo=$(this).attr("orderNo");
            var status=$(this).attr("status");
            if(status != 9) {
            	alert("请先确认收款");
            	return;
            }
            //window.open('/supplierAccountCenterController/suppliereceivingadd?type='+type+'&financingAmount='+financingAmount+'&id='+id+'&period='+period+'&orderNo='+orderNo, '_blank', '');
       
            var  url = "/supplierAccountCenterController/suppliereceivingadd";
            //首先创建一个form表单  
            var tempForm = document.createElement("form");    
            tempForm.id="tempForm1";  
            tempForm.method="post";   
            tempForm.action=url;  
            tempForm.target="_blank";   
            //创建input标签，用来设置参数  
            var hideInput = document.createElement("input");    
            hideInput.type="hidden";    
            hideInput.name= "type";  
            hideInput.value= type; 
            var hideInput2 = document.createElement("input");  
            hideInput2.type = "hidden";
            hideInput2.name = "financingAmount";
            hideInput2.value = financingAmount;
            var hideInput3 = document.createElement("input");  
            hideInput3.type = "hidden";
            hideInput3.name = "id";
            hideInput3.value = id;
            var hideInput5 = document.createElement("input");  
            hideInput5.type = "hidden";
            hideInput5.name = "orderNo";
            hideInput5.value = orderNo;
            //将input表单放到form表单里  
            tempForm.appendChild(hideInput); 
            tempForm.appendChild(hideInput2);
            tempForm.appendChild(hideInput3);
            tempForm.appendChild(hideInput5);
            
            //将此form表单添加到页面主体body中  
            document.body.appendChild(tempForm); 
            tempForm.submit();
            document.body.removeChild(tempForm); 
		});

		//查询
		$("#btn-query-supplierreceiving").click(function() {
			$("#pageForm").submit();
		});
		</script>
	</body>
</html>