<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />意向资方详情<span class="mr10 ml10"></span></div>
		</div>
		
	   <div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/financingApplyDetail.htm');"><div class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<c:if test="${auditType == 1}">
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateAuditHistory.htm');"><div class="proicon bg3 statusThree"></div>资方初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg4 statusOne"></div>选择意向资方</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg5 statusOne"></div>资方终审</li>
				</c:if>
				<c:if test="${auditType == 2}">
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/firstAuditDetail.htm');"><div class="proicon bg3 statusTwo"></div>资方初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist pro_li_cur" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/intentionalCapitalDetail.htm');" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateFinalAuditHistory.htm');"><div class="proicon bg5 statusThree"></div>资方终审</li>
				</c:if>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/"><div class="proicon bg6 statusOne"></div>合作资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/"><div class="proicon bg7 statusOne"></div>平台复审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/"><div class="proicon bg8 statusOne"></div>签署主合同</li>
			</ul>
		</div>
		<div class="w1200 mt40">
			<p class="protitle"><span>选择意向资方</span></p>
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>融资订单号</th>
						<th>资方名称</th>
						<th>意向投资金额（元）</th>
						<th>意向融资期限（天）</th>
						<th>意向投资利率（%）</th>
						<th>竞标时间</th>
						<th>意向资方</th>
					</tr>
					<c:forEach items="${page.records}" var="obj" varStatus="index">
						<tr>
							<td class="toggletr">${index.count}</td>
							<td class="maxwidth"><a href="javascript:;" class="order-a">${obj.orderNo}</a></td>
							<td class="maxwidth">${obj.funderName}</td>
							<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount }" pattern="#,##0.##" maxFractionDigits="2"/></td>					
							<td class="maxwidth">${obj.financingTerm}</td>
							<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate }" pattern="##0.####" maxFractionDigits="4"/></td>
							<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td class="maxwidth"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/agree_icon.png"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="mb80"></div>
		<div class="btn2 clearfix mb80">
			<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/firstAuditDetail.htm');" class="btn-add btn-center mb80">上一页</a>
			<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateFinalAuditHistory.htm');" class="btn-add btn-center mb80">下一页</a>
		</div>
	</body>
</html>