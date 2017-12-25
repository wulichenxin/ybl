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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />风控审核记录详情<span class="mr10 ml10"></span></div>
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
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/intentionalCapitalDetail.htm');" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
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
		<div class="w1200">
			<div class="process">
			
				<p class="protitle"><span>风控审核</span></p>
				
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>审核结果：</label>
							<c:if test="${vo.auditResult == 1}">通过</c:if>
							<c:if test="${vo.auditResult == 2}">不通过</c:if>
							<c:if test="${vo.auditResult == 3}">驳回</c:if>
						</div>
					</div>
					<div class="pd20">
						审核意见：<textarea class="protext" name="auditOpinion" readonly="readonly">${vo.auditOpinion }</textarea>
					</div>	
				</div>
				
				<p class="protitle"><span>审核附件信息</span></p>
				<div class="pd20">
					<div class="tabD">
						<table>
							<tr>
								<th>序号</th>
								<th>附件名称</th>
								<th>备注</th>
								<th>上传时间</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
								<tr>
									<td class="maxwidth">${index.count}</td>
									<td class="maxwidth">${obj.oldName}</td>
									<td class="maxwidth">${obj.remark }</td>
									<td class="maxwidth"><fmt:formatDate value="${obj.createdTime }" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth"><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-modify">下载</a></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="mb80"></div>
	</body>
</html>