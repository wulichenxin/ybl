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
	</head>
	<!--top start -->
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />风控终审</div>
		</div>
		<form action="/factorRiskManagementController/finalAudit/list.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资方：</label><input class="content-form" name="financier" value="${dto.financier }"/></div>
					<%-- <div class="form-grou"><label class="label-long">核心企业：</label><input class="content-form" name="coreEnterprise" value="${dto.coreEnterprise }"/></div> --%>
					<div class="form-grou"><label class="label-long">融资申请时间：</label><input id="startDate" class="content-form" name="startDate" value="${dto.startDate }"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" class="content-form" name="endDate" value="${dto.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" name="financingOrderNumber" value="${dto.financingOrderNumber }"/></div>
					<div class="form-grou"><label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="" <c:if test="${empty dto.factoringMode}">selected="selected"</c:if>>全部</option>
							<option value="1" <c:if test="${dto.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${dto.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
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
								<th>融资订单号</th>
								<th>融资方</th>
								<th>保理类型</th>
								<th>资产类型</th>
								<th>融资方式</th>
								<th>融资申请金额(元)</th>
								<th>融资期限(天)</th>
								<th>融资利率(%)</th>
								<th>申请日期</th>
								<th>融资状态</th>
								<th>操作</th>
							</tr>
							<c:if test="${empty page.records}">
								<tr><td colspan="12">暂无数据</td></tr>
							</c:if>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td class="maxwidth"><a style="cursor: pointer;" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${obj.financingApplyId }/${obj.subFinancingApplyId }/2/financingApplyDetail.htm');" class="order-a">${obj.financingOrderNumber}</a></td>
									<td class="maxwidth">${obj.financier}</td>
									<td class="maxwidth">
										<c:if test="${obj.factoringMode eq 1}">明保理</c:if>
										<c:if test="${obj.factoringMode eq 2}">暗保理</c:if>
									</td>
									<td class="maxwidth">
										<c:if test="${obj.assetsType eq 1}">应收账款</c:if>
										<c:if test="${obj.assetsType eq 2}">应付账款</c:if>
										<c:if test="${obj.assetsType eq 3}">票据</c:if>
									</td>
									<td class="maxwidth">
										<c:if test="${obj.financingMode eq 1}">签约资方</c:if>
										<c:if test="${obj.financingMode eq 2}">平台推荐</c:if>
										<c:if test="${obj.financingMode eq 3}">竞标</c:if>
									</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth">${obj.financingTerm}</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="##0.####" maxFractionDigits="4"/></td>
									<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth">
										<c:if test="${obj.financingStatus eq 5}">待资方终审</c:if>
									</td>
									<td class="maxwidth">
										<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${obj.financingApplyId }/${obj.subFinancingApplyId }/2/preCreateFinalAuditHistory.htm');" class="btn-modify mr10">审核</a>
									</td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</form>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/riskManagement/first_audit.js"></script>
		<script type="text/javascript">
		function jumpPost(url,args) {
			var form = $("<form method='post'></form>");
	        form.attr({"action":url});
	        for (arg in args) {
	            var input = $("<input type='hidden'>");
	            input.attr({"name":arg});
	            input.val(args[arg]);
	            form.append(input);
	        }
	        $(document.body).append(form);
	        form.submit();
	    }
		$('#startDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		</script>
	</body>
</html>