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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款申请综合查询</div>
		</div>
		<form action="<%=basePath%>factorLoanQueryController/loanQuery/list.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label class="label-long">放款申请单号：</label>
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
						<label class="label-long">放款状态：</label>
						<select class="content-form" name="status">
							<option value="">全部</option>
							<option value="1" <c:if test="${not empty vo.status and vo.status eq 1}">selected="selected"</c:if>>待提交</option>
							<option value="2" <c:if test="${not empty vo.status and vo.status eq 2}">selected="selected"</c:if>>待资方办理</option>
							<option value="3" <c:if test="${not empty vo.status and vo.status eq 3}">selected="selected"</c:if>>待确权</option>
							<option value="4" <c:if test="${not empty vo.status and vo.status eq 4}">selected="selected"</c:if>>待平台审核</option>
							<option value="5" <c:if test="${not empty vo.status and vo.status eq 5}">selected="selected"</c:if>>待放款</option>
							<option value="8" <c:if test="${not empty vo.status and vo.status eq 8}">selected="selected"</c:if>>待放款确认</option>
							<option value="9" <c:if test="${not empty vo.status and vo.status eq 9}">selected="selected"</c:if>>已确认收款</option>
							<option value="99" <c:if test="${not empty vo.status and vo.status eq 12}">selected="selected"</c:if>>放款失败</option>
						</select>
					</div>
					<div class="form-grou mr40">
						<label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="">请选择</option>
							<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
						</select>
					</div>
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
							<th>放款申请单号</th>
							<th>融资方</th>
							<th>保理类型</th>
							<th>资产类型</th>
							<th>放款申请金额(元)</th>
							<th>融资期限(天)</th>
							<th>融资利率(%)</th>
							<th>申请日期</th>
							<th>实际放款金额(元)</th>
							<th>平台管理费(元)</th>
							<th>累计还款本息(元)</th>
							<th>最后一次还款时间</th>
							<th>关联融资申请单号</th>
							<th>放款状态</th>
							<th>还款状态</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
							<tr><td colspan="17">暂无数据</td></tr>
						</c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
			              	<tr>
								<td class="toggletr">${index.count}</td>
								<td title="${obj.orderNo}" class="maxwidth"><a href="javascript:;" class="order-a subView" lid="${obj.id}">${obj.orderNo}</a></td>
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
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingTerm}" pattern="##0.####" maxFractionDigits="4"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.actualLoanAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.factoringPlatformFee}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.actualAmountCount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" /></td>
								<td title="${obj.financingOrderNumber}" class="maxwidth"><%-- <a href="javascript:;" class="order-a view" fid="${obj.financingApplyId }" status="${obj.financingStatus }"> --%>${obj.financingOrderNumber}<!-- </a> --></td>
								<td class="maxwidth">
									<c:if test="${not empty obj.status and obj.status eq 1}">待提交</c:if>
									<c:if test="${not empty obj.status and obj.status eq 2}">待资方办理</c:if>
									<c:if test="${not empty obj.status and obj.status eq 3}">待确权</c:if>
									<c:if test="${not empty obj.status and obj.status eq 4}">待平台审核</c:if>
									<c:if test="${not empty obj.status and obj.status eq 5}">待放款</c:if>
									<c:if test="${not empty obj.status and obj.status eq 8}">待放款确认</c:if>
									<c:if test="${not empty obj.status and obj.status eq 9}">已确认收款</c:if></option>
									<c:if test="${not empty obj.status and obj.status eq 99}">放款失败</c:if>
								</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 1}">待还款</c:if>
									<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 2}">还款中</c:if>
									<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 3}">已完成</c:if>
								</td>
								<td><a href="javascript:;" class="btn-modify mr10 subView" lid="${obj.id}">查看</a></td>
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
		});

		$(".subView").click(function(){
			var lid=$(this).attr("lid");
			param={"id":lid,"url":"/factorLoanQueryController/loanQuery/list.htm"};
			httpPost('/loanApplyCommonApi/selectChildrenDetail.htm',param);
		})
		/* $(".view").click(function(){
			var fid=$(this).attr("fid");
			var status=$(this).attr("status");
			param={"id":fid,"statue":status,"url":"/factorLoanQueryController/loanQuery/list.htm"};
			httpPost('/financingApplyCommonApi/view.htm',param);
		}) */
		</script>
	</body>
</html>