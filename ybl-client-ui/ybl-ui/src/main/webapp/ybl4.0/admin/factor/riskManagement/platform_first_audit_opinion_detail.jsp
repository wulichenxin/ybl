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
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />平台初审详情<span class="mr10 ml10"></span></div>
		</div>
			<div class="w1200">
				<ul class="clearfix iconul">
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/financingApplyDetail.htm');"><div class="proicon bg1 statusTwo"></div>项目详情</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist pro_li_cur" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
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
				<p class="protitle"><span>平台初审</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>资方名称：</label><input class="content-form2" readonly="readonly" value="${vo.recommendFactor }"/></div>
					</div>
				</div>
			<div class="process">
				<p class="protitle"><span>平台初审结果</span></p>
				<div class="ground-form mb20">
					<div class="form-grou mr50"><label style="text-align: right;">初审结果：</label>
						<select class="content-form2" name="auditResult" disabled="disabled">
							<option value="">请选择</option>
							<option value="1" <c:if test="${vo.auditResult eq 1}">selected="selected"</c:if>>通过</option>
							<option value="2" <c:if test="${vo.auditResult eq 2}">selected="selected"</c:if>>不通过</option>
							<option value="3" <c:if test="${vo.auditResult eq 3}">selected="selected"</c:if>>驳回</option>
						</select>
					</div>
				</div>
				<div class="pd20">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" readonly="readonly">${vo.remark }</textarea>
				</div>
			<p class="protitle"><span>历史审核记录</span></p>
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>提交类型</th>
						<th>审核结果</th>
						<th>审核时间</th>
						<th>审核人</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${page.records}" var="obj" varStatus="index">
						<tr>
							<td class="maxwidth">${index.count}</td>
							<td class="maxwidth">
								<c:if test="${obj.auditType == 1}">平台初审</c:if>
								<c:if test="${obj.auditType == 2}">平台终审</c:if>
							</td>
							<td class="maxwidth">
								<c:if test="${obj.auditResult == 1}">通过</c:if>
								<c:if test="${obj.auditResult == 2}">不通过</c:if>
								<c:if test="${obj.auditResult == 3}">驳回</c:if>
							</td>
							<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
							<td class="maxwidth">${obj.userName }</td>
							<td class="maxwidth"><a class="btn-modify" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/${obj.id}/platformFirstAuditHistoryDetail.htm');">查看</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="mt40"></div>
			</div>
			<div class="btn2 clearfix mb80">
				<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/financingApplyDetail.htm');" class="btn-add btn-center mb80">上一页</a>
				<c:if test="${auditType == 1}">
					<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateAuditHistory.htm');" class="btn-add btn-center mb80">下一页</a>
				</c:if>
				<c:if test="${auditType == 2}">
					<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/firstAuditDetail.htm');" class="btn-add btn-center mb80">下一页</a>
				</c:if>
			</div>
		</div>
	</body>
</html>