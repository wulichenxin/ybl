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
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />风控审核<span class="mr10 ml10">-</span>意向资方详情展示<span class="mr10 ml10"></span></div>
		</div>
		
	   <div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/financingApplyDetail.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'"><div class="proicon bg1 statusOne"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/platformFirstAuditDetail.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<c:if test="${auditType == 1}">
					<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/preCreateAuditHistory.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'"><div class="proicon bg3 statusThree"></div>资方初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
				</c:if>
				<c:if test="${auditType == 2}">
					<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/firstAuditDetail.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'"><div class="proicon bg3 statusThree"></div>资方初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/intentionalCapitalDetail.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
				</c:if>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<c:if test="${auditType == 1}">
					<li class="iconlist" onclick="javascript:void(0);'"><div class="proicon bg5 statusThree"></div>资方终审</li>
				</c:if>
				<c:if test="${auditType == 2}">
					<li class="iconlist" onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/preCreateFinalAuditHistory.htm?financingApplyId=${financingApplyId}&subFinancingApplyId=${subFinancingApplyId }&auditType=${auditType }'"><div class="proicon bg5 statusThree"></div>资方终审</li>
				</c:if>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab6?id=${id}"><div class="proicon bg6 statusThree"></div>合作资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab7?id=${id}&audittype=2"><div class="proicon bg7 statusTwo"></div>平台复审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab7?id=${id}"><div class="proicon bg8 statusThree"></div>签署主合同</li>
			</ul>	
		</div>
		<div class="w1200">
			<div class="process">
				${contractContnent }
			</div>
			<td>合同模板下载</td><td><a class="" href="/contractQuotaV4Controller/exportWord?id=1">保理融资主合同</a></td>
		</div>
	</body>
</html>