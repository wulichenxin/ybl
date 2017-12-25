<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资申请综合查询</div>
		</div>
		<form action="<%=basePath%>factorFinancingQueryController/financingQuery/list.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label class="label-long">融资订单号：</label>
						<input class="content-form" name="orderNo" value="${vo.orderNo }"/>
					</div>
					<div class="form-grou mr40">
						<label class="label-long">融资方：</label>
						<input class="content-form" name="financier" value="${vo.financier }" />
					</div>
					<div class="form-grou">
						<label class="label-long">主合同号：</label>
						<input class="content-form" name="financingOrderNumber" value="${vo.financingOrderNumber }" />
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label class="label-long">融资状态：</label>
						<select class="content-form" name="financingStatus">
							<option value="">全部</option>
							<option value="1" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 1}">selected="selected"</c:if>>待提交</option>
							<option value="2" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 2}">selected="selected"</c:if>>待平台初审</option>
							<option value="3" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 3}">selected="selected"</c:if>>待资方初审</option>
							<option value="4" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 4}">selected="selected"</c:if>>待选择资方</option>
							<option value="5" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 5}">selected="selected"</c:if>>待资方终审</option>
							<option value="6" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 6}">selected="selected"</c:if>>待确定资方</option>
							<option value="7" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 7}">selected="selected"</c:if>>待平台复核</option>
							<option value="8" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 8}">selected="selected"</c:if>>待签署合同</option>
							<option value="9" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 9}">selected="selected"</c:if>>融资完成</option>
							<option value="10" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 10}">selected="selected"</c:if>>资方驳回</option>
							<option value="11" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 11}">selected="selected"</c:if>>平台驳回</option>
							<option value="99" <c:if test="${not empty vo.financingStatus and vo.financingStatus eq 99}">selected="selected"</c:if>>融资失败</option>
						</select>
					</div>
					<div class="form-grou mr40">
						<label class="label-long">融资方式：</label>
						<select class="content-form" name="financingMode">
							<option value="">请选择</option>
							<option value="1" <c:if test="${not empty vo.financingMode and vo.financingMode eq 1}">selected="selected"</c:if>>签约资方</option>
							<option value="2" <c:if test="${not empty vo.financingMode and vo.financingMode eq 2}">selected="selected"</c:if>>平台推荐</option>
							<option value="3" <c:if test="${not empty vo.financingMode and vo.financingMode eq 3}">selected="selected"</c:if>>竞标</option>
						</select>
					</div>
					<div class="form-grou">
						<label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="">全部</option>
							<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou">
						<label class="label-long">放款申请时间：</label>
						<input id="beginDate" class="content-form" name="startApplyDate" value="${vo.startApplyDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40">
						<input id="endDate" class="content-form" name="endApplyDate" value="${vo.endApplyDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
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
							<th>关联融资主合同号</th>
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
							<tr><td colspan="13">暂无数据</td></tr>
						</c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
			              	<tr>
								<td class="toggletr">${index.count}</td>
								<td title="${obj.orderNo}" class="maxwidth"><a href="javascript:;" class="order-a subView" uid="${obj.financingApplyId}" childrenid="${obj.id}" statue="${obj.financingStatus }">${obj.orderNo}</a></td>
								<td title="${obj.financier}" class="maxwidth">${obj.financier}</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 1}">明保理</c:if>
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 2}">暗保理</c:if>
								</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
								</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 1}">签约资方</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 2}">平台推荐</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 3}">竞标</c:if>
								</td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingTerm}" pattern="##0.####" maxFractionDigits="4"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
								<td title="${obj.financingOrderNumber}" class="maxwidth">${obj.financingOrderNumber}</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 1}">待提交</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 2}">待平台初审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 3}">待资方初审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 4}">待选择资方</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 5}">待资方终审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 6}">待确定资方</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 7}">待平台复核</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 8}">待签署合同</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 9}">融资完成</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 10}">资方驳回</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 11}">平台驳回</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 99}">融资失败</c:if>
								</td>
								<td><a href="javascript:;" class="btn-modify mr10 subView" uid="${obj.financingApplyId}" childrenid="${obj.id}" statue="${obj.financingStatus }">查看</a></td>
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
		$('#query').click(function(){
			$('#pageForm').submit();
		})
		$(".subView").click(function(){
			var id=$(this).attr("uid");
			var childrenId=$(this).attr("childrenid");
			var statue=$(this).attr("statue")

			param={
					"id":id,
					"childrenId":childrenId,
					"statue":statue,
					"url":"/factorFinancingQueryController/financingQuery/list.htm"
			};
			httpPost('/financingApplyCommonApi/view.htm',param);
		});
		</script>
	</body>
</html>