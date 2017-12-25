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
			<div><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款失败项目</div>
		</div>
		<form action="/supplierAccountCenterController/supplierloanfail.htm" id="pageForm" method="post">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>放款单号：</label><input class="content-form" name="orderNo" value="${loanFailProjectVO.orderNo }" /></div>
					<div class="form-grou mr40"><label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="0" >全部</option>
							<option value="1" <c:if test="${loanFailProjectVO.factoringMode eq 1 }">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${loanFailProjectVO.factoringMode eq 2 }">selected="selected"</c:if>>暗保理</option>
						</select>
					</div>
					<div class="form-grou">
						<label class="label-long">放款状态：</label>
						<select class="content-form" name="status"><option value="99">放款失败</option></select>
					</div>
				</div>
				<div class="ground-form">
					<div class="form-grou"><label>申请时间：</label><input id="attribute1" name="attribute1" class="content-form" value="${loanFailProjectVO.attribute1 }" /></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="attribute2" class="content-form" name="attribute2" value="${loanFailProjectVO.attribute2 }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
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
								<th>资方名称</th>
								<th>资产类型</th>
								<th>申请融资金额(元)</th>
								<th>融资期限(天)</th>
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>关联主合同号</th>
								<th>放款状态</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="#" class="order-a" financingAmount="${obj.financingAmount }" assetsType="${obj.assetsType }" 
											 financingName="${obj.investorName}" orderNo="${obj.orderNo}" loanapplyid="${obj.id}" onclick="">${obj.orderNo}</a></td>
									<td>${obj.investorName}</td>
									<td>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
									</td>
									<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.financingTerm}</td>
									<td><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td>${obj.masterContractNo}</td>
									<td>放款失败</td>
									<td>
										<a href="#" class="btn-modify mr10 tip details" financingAmount="${obj.financingAmount }" assetsType="${obj.assetsType }" 
											 financingName="${obj.investorName}" orderNo="${obj.orderNo}" loanapplyid="${obj.id}" onclick="">查看</a>
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
		$('#attribute1,#attribute2').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		$(".details,.order-a").click(function(){
            var financingAmount=$(this).attr("financingAmount");
            var assetsType=$(this).attr("assetsType");
            var financingName=$(this).attr("financingName");
            var orderNo=$(this).attr("orderNo");
            var loanapplyid=$(this).attr("loanapplyid");
            
            var  url = "/supplierAccountCenterController/labelsPage";
            //首先创建一个form表单  
            var tempForm = document.createElement("form");    
            tempForm.id="tempForm1";  
            tempForm.method="post";   
            tempForm.action=url;  
            tempForm.target="_blank";   
            //创建input标签，用来设置参数  
            var hideInput = document.createElement("input");    
            hideInput.type="hidden";    
            hideInput.name= "financingAmount";  
            hideInput.value= financingAmount; 
            var hideInput2 = document.createElement("input");  
            hideInput2.type = "hidden";
            hideInput2.name = "assetsType";
            hideInput2.value = assetsType;
            var hideInput3 = document.createElement("input");  
            hideInput3.type = "hidden";
            hideInput3.name = "financingName";
            hideInput3.value = financingName;
            var hideInput4 = document.createElement("input");  
            hideInput4.type = "hidden";
            hideInput4.name = "orderNo";
            hideInput4.value = orderNo;
            var hideInput5 = document.createElement("input");    
            hideInput5.type="hidden";    
            hideInput5.name= "loanapplyid";  
            hideInput5.value= loanapplyid; 
            //将input表单放到form表单里  
            tempForm.appendChild(hideInput); 
            tempForm.appendChild(hideInput2);
            tempForm.appendChild(hideInput3);
            tempForm.appendChild(hideInput4);
            tempForm.appendChild(hideInput5);
            
            //将此form表单添加到页面主体body中  
            document.body.appendChild(tempForm); 
            tempForm.submit();
            document.body.removeChild(tempForm); 
            //window.open("/supplierAccountCenterController/labelsPage?pageFlag=1&financingAmount="+financingAmount+"&assetsType="+assetsType+"&financingName="+financingName+"&orderNo="+orderNo, '_blank', '');
        });
		
		
		//查询
		$("#btn-query-receivingacount").click(function() {
			$("#pageForm").submit();
		});
		</script>
	</body>
</html>