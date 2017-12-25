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
	<body>
		<!--top start -->
		<%@include file="/ybl4.0/admin/common/link.jsp" %>	
		<!--top end -->
		<p class="per_title"><span>投资失败项目</span></p>
		<div class="mt40">
			<form action="/factorInvestManagementController/getFailedSubApplyList.htm" id="pageForm" method="post">
				<div class="ybl-info">
					<div class="btn-found" id="btn-query">查询</div>
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label>融资方名称：</label><input class="content-form" name="enterpriseName" value="${child.enterpriseName }"/></div>
						<div class="form-grou">
							<label>融资状态：</label>
							<select class="content-form" name="financingStatus">
								<option value="">融资失败</option>
							</select>
						</div>
					</div>
					
					<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" name="ordernNo" value="${child.ordernNo }"/></div>
					<div class="form-grou"><label>保理类型：</label>
						<select class="content-form" name="factoringMode">
							<c:if test="${child.factoringMode eq 1}">
								<option value="1">明保理</option>
							</c:if>
							<c:if test="${child.factoringMode eq 2}">
								<option value="2">暗保理</option>
							</c:if>
							<option value="">全部</option>
							<option value="1">明保理</option>
							<option value="2">暗保理</option>
						</select>
					</div>
					</div>
					<div class="ground-form">
						<div class="form-grou"><label>申请日期：</label><input id="startTime" class="content-form" name="startTime" value="${child.startTime }"/></div>
						<span class="mr10 ml10">-</span>
						<div class="form-grou mr40"><input id="endTime" class="content-form" name="endTime" value="${child.endTime }"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					</div>
				</div>
				<div class="mt40">
					<div class="tabD">
						<div class="scrollbox">
							<table>
								<tr>
									<th>序号</th>
									<th>融资订单号</th>
									<th>融资方名称</th>
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
								<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="15">
										暂时没有相关数据~
									</td>
								</tr>
								</c:if>
								<c:forEach items="${list}" var="obj" varStatus="index">
					              	<tr>
										<td class="toggletr">${index.count}</td>
										<td class="maxwidth"><a href="#" class="details" uid="${obj.financingApplyId}" child="${obj.id }" status="${obj.financingStatus }">${obj.ordernNo}</a></td>
										<td>${obj.enterpriseName}</td>
										<!-- 保理类型1-明保理2-暗保理 -->
										<td>
											<c:if test="${obj.factoringMode eq 1 }">明保理</c:if>
											<c:if test="${obj.factoringMode eq 2 }">暗保理</c:if>
										</td>
										<!-- 资产类型1-应收账款2-应付账款3-票据 -->
										<td>
											<c:if test="${obj.assetsType eq 1 }">应收账款</c:if>
											<c:if test="${obj.assetsType eq 2 }">应付账款</c:if>
											<c:if test="${obj.assetsType eq 3 }">票据</c:if>
										</td>
										<!-- 融资方式1-签约资方2-平台推荐3-竞标 -->
										<td>
											<c:if test="${obj.financingMode eq 1 }">签约资方</c:if>
											<c:if test="${obj.financingMode eq 2 }">平台推荐</c:if>
											<c:if test="${obj.financingMode eq 3 }">竞标</c:if>
										</td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${obj.financingTerm}</td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.####"/></td>
										<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
										<td>融资失败</td>
										<td>
											<a href="#" class="btn-modify mr10 tip details" uid="${obj.financingApplyId}" child="${obj.id }" status="${obj.financingStatus }">详情</a><!-- 融资申请子订单详情页 -->
										</td>
									</tr>
				              </c:forEach>
							</table>
						</div>
					</div>
					<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
				</form>
				
				<form action="/financingApplyCommonApi/view.htm" id="pageDetais" method="post" target="_blank">
					<input type="hidden" name="id" id="oId" value=""/>
					<input type="hidden" name="childrenId" id="oChildrenId" value=""/>
					<input type="hidden" name="statue" id="oStatue" value=""/>
					<input type="hidden" name="url" id="url" value="###"/>
				</form>
			</div>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/overdue.js"></script>
		<script type="text/javascript">
		$('#startTime,#endTime').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		$(".details").click(function(){
			var id=$(this).attr("uid");
			var childrenId=$(this).attr("child");
			var statue = $(this).attr("status");
			$("#oId").val(id);
			$("#oChildrenId").val(childrenId);
			$("#oStatue").val(statue);
			$("#pageDetais").submit();
		})
		</script>
	</body>
</html>