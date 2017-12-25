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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />资方初审详情</div>
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
						<li class="iconlist pro_li_cur" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/firstAuditDetail.htm');"><div class="proicon bg3 statusTwo"></div>资方初审</li>
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
				<p class="protitle"><span>项目初审意见</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资企业：</label><input class="content-form2" value="${vo.financingEnterprise }" disabled="disabled"/></div>
						<div class="form-grou mr50"><label>融资金额：</label><input class="content-form2" value="<fmt:formatNumber value="${vo.financingAmount }" pattern="#,##0.##" maxFractionDigits="2"/>" disabled="disabled"/><span class="timeimg">元</span></div>
						<div class="form-grou"><label class="label-long">融资期限：</label><input class="content-form2" value="${vo.financingTerm }" disabled="disabled"/><span class="timeimg">天</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>收费方式：</label>
							<select class="content-form2 sffs" name="feeMode" disabled="disabled">
								<option value="1" <c:if test="${vo.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
								<option value="2" <c:if test="${vo.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
								<option value="3" <c:if test="${vo.feeMode eq 3}">selected="selected"</c:if>>折后转让</option>
							</select>
						</div>
						<c:if test="${vo.feeMode eq 1}">
							<div id="financingRate" class="form-grou mr50"><label class="sffs-label">融资利率：</label><input class="content-form2" value="<fmt:formatNumber value="${vo.financingRate }" pattern="##0.####" maxFractionDigits="4"/>" disabled="disabled"/><span class="timeimg sffs-sp">%</span></div>
						</c:if>
						<c:if test="${vo.feeMode eq 2}">
							<div id="serviceFee" class="form-grou mr50" ><label class="sffs-label">服务费：</label><input class="content-form2" value="<fmt:formatNumber value="${vo.serviceFee }" pattern="#,##0.##" maxFractionDigits="2"/>" disabled="disabled"/><span class="timeimg sffs-sp">元</span></div>
						</c:if>
						<c:if test="${vo.feeMode eq 3}">
							<div id="transferMoney" class="form-grou mr50" ><label class="sffs-label">折后转让：</label><input class="content-form2" value="<fmt:formatNumber value="${vo.transferMoney }" pattern="#,##0.##" maxFractionDigits="2"/>" name="transferMoney" disabled="disabled"/><span class="timeimg sffs-sp">元</span></div>
						</c:if>
						<div class="form-grou mr50"><label class="label-long">意见编号：</label><input class="content-form2" value="${vo.opinionNumber }" disabled="disabled"/></div>
					</div>
				</div>
			
			<div class="process">
				<p class="protitle"><span>融资说明</span></p>
				<div class="pd20">
					融资说明：<textarea class="protext" name="financingExplain" disabled="disabled">${vo.financingExplain }</textarea>
				</div>	
				<p class="protitle"><span>交易结构</span></p>
				<div class="pd20">
					交易结构：<textarea class="protext" name="transactionStructure" disabled="disabled">${vo.transactionStructure }</textarea>
				</div>	
				<p class="protitle"><span>增信措施</span></p>
				<div class="pd20">
					增信措施：<textarea class="protext" name="trustMeasure" disabled="disabled">${vo.trustMeasure }</textarea>
				</div>	
				<p class="protitle"><span>审核意见</span></p>
				<div class="pd20">
					审核意见：<textarea class="protext" name="auditOpinion" disabled="disabled">${vo.auditOpinion }</textarea>
				</div>	
				
				<div class="pd20 mb20">
					<div class="form-grou mr50 mt20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：<input id="auditDate" class="content-form" name="auditDate" value="<fmt:formatDate value="${vo.auditDate }" pattern="yyyy-MM-dd" />" disabled="disabled"/>
				</div>
				
				<p class="protitle"><span>请选择资方初审结果</span></p>
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
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" disabled="disabled">${vo.remark}</textarea>
				</div>
				
				<p class="protitle"><span>初审意见表</span></p>
				
				<div class="pd20">
					<div id='licensePhoto'>
						<c:forEach items="${attachmentList}" var="attachment" varStatus="index">
							<a href="/fileDownloadController/downloadftp?id=${attachment.id }"><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
						</c:forEach>
					</div>
					<div id='licensePhoto_div'></div>
				</div>
			</form>	
			
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
								<c:if test="${obj.auditType == 1}">资方风控初审</c:if>
								<c:if test="${obj.auditType == 2}">资方风控终审</c:if>
							</td>
							<td class="maxwidth">
								<c:if test="${obj.auditResult == 1}">通过</c:if>
								<c:if test="${obj.auditResult == 2}">不通过</c:if>
								<c:if test="${obj.auditResult == 3}">驳回</c:if>
							</td>
							<td class="maxwidth"><fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" /></td>
							<td class="maxwidth">${obj.auditor }</td>
							<td class="maxwidth"><a class="btn-modify"  onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/${obj.id}/factorAuditHistoryDetail.htm');">查看</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="mt40"></div>
			</div>
			<div class="btn2 clearfix mb80">
				<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');" class="btn-add btn-center mb80">上一页</a>
				<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/intentionalCapitalDetail.htm');" class="btn-add btn-center mb80">下一页</a>
			</div>
		</div>
	</body>
</html>