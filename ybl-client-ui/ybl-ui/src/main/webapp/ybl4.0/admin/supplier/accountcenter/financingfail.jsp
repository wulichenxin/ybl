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
			<div><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资失败项目</div>
		</div>
		<form action="/supplierAccountCenterController/supplierfinancingfail.htm" id="pageForm" method="post">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资订单号：</label><input name="financingOrderNumber" class="content-form" value="${financingApplyVO.financingOrderNumber }"/></div>
					<div class="form-grou mr40"><label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="0">全部</option>
							<option value="1" <c:if test="${financingApplyVO.factoringMode eq 1 }">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${financingApplyVO.factoringMode eq 2 }">selected="selected"</c:if>>暗保理</option>
						</select>
					</div>
					<div class="form-grou">
						<label class="label-long">融资状态：</label>
						<select class="content-form" name="financingStatus">
							<option value="99">融资失败</option>
						</select>
					</div>
				</div>
				<div class="ground-form">
					<div class="form-grou"><label>申请时间：</label><input id="beginDate" name="beginDate" class="content-form" value="${financingApplyVO.beginDate}"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" name="endDate" class="content-form" value="${financingApplyVO.endDate}"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="form-grou">
						<label class="label-long">融资方式：</label>
						<select class="content-form" name="financingMode">
							<option value="0">请选择</option>
							<option value="1" <c:if test="${financingApplyVO.financingMode eq 1 }">selected="selected"</c:if> >签约资方</option>
							<option value="2" <c:if test="${financingApplyVO.financingMode eq 2 }">selected="selected"</c:if>>平台推荐</option>
							<option value="3" <c:if test="${financingApplyVO.financingMode eq 1 }">selected="selected"</c:if>>竞标</option>
						</select>
					</div>
					<div class="btn-modify" id="btn-query-supplierfinancingfail">查询</div>
				</div>
			</div>
			<div class="mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>融资订单号</th>
								<th>资方名称</th>
								<th>保理类型</th>
								<th>资产类型</th>
								<th>融资方式</th>
								<th>申请融资金额(元)</th>
								<th>融资期限(天)</th>
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>融资状态</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${list}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="javascript:;" class="order-a" id="${obj.id }">${obj.financingOrderNumber}</a></td>
									<td>${obj.financier}</td>
									<td>
										<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 1}">明保理</c:if>
										<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 2}">暗保理</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.financingMode and obj.financingMode eq 1}">签约资方</c:if>
										<c:if test="${not empty obj.financingMode and obj.financingMode eq 2}">平台推荐</c:if>
										<c:if test="${not empty obj.financingMode and obj.financingMode eq 3}">竞标</c:if>
									</td>
									<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.financingTerm}</td>
									<td><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td>融资失败</td>
									<td><a href="javascript:;" class="btn-modify mr10 tip details" id="${obj.id }">查看</a></td>
								</tr>
			              </c:forEach>
						</table> 
					</div>
				</div>
		<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</form>
		</div>
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
			var id=$(this).attr("id");
			var  url = "/supplierAccountCenterController/financingApply/getFinancingApply";
            //首先创建一个form表单  
            var tempForm = document.createElement("form");    
            tempForm.id="tempForm1";  
            tempForm.method="post";   
            tempForm.action=url;  
            tempForm.target="_blank";   
            //创建input标签，用来设置参数  
            var hideInput = document.createElement("input");    
            hideInput.type="hidden";    
            hideInput.name= "id";  
            hideInput.value= id; 
			tempForm.appendChild(hideInput);
            
            //将此form表单添加到页面主体body中  
            document.body.appendChild(tempForm); 
            tempForm.submit();
            document.body.removeChild(tempForm); 
		});
		
		//查询
		$("#btn-query-supplierfinancingfail").click(function() {
			$("#pageForm").submit();
		});
		</script>
	</body>
</html>