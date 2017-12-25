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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />资产确权</div>
		</div>
		<form action="<%=basePath%>factorLoanAuditController/loanAudit/waitAuthorizeList.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label class="label-long">放款申请单号：</label>
						<input class="content-form" name="orderNo">${factorLoanAuditVo.orderNo }</input>
					</div>
					<div class="form-grou mr40">
						<label class="label-long">关联主合同号：</label>
						<input class="content-form" name="financingOrderNumber">${factorLoanAuditVo.financingOrderNumber }</input>
					</div>
					<div class="form-grou">
						<label class="label-long">资产类型：</label>
						<select class="content-form" name="assetsType">
							<option value="">请选择</option>
							<option value="1" <c:if test="${not empty factorLoanAuditVo.assetsType and factorLoanAuditVo.assetsType eq 1}">selected="selected"</c:if>>应收账款</option>
							<option value="2" <c:if test="${not empty factorLoanAuditVo.assetsType and factorLoanAuditVo.assetsType eq 2}">selected="selected"</c:if>>应付账款</option>
							<option value="3" <c:if test="${not empty factorLoanAuditVo.assetsType and factorLoanAuditVo.assetsType eq 3}">selected="selected"</c:if>>票据</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou">
						<label class="label-long">放款申请时间：</label>
						<input id="beginDate" class="content-form" name="startApplyDate">${factorLoanAuditVo.startApplyDate }</input><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40">
						<input id="endDate" class="content-form" name="endApplyDate">${factorLoanAuditVo.endApplyDate }</input><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
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
							<th>融资方名称</th>
							<th>资产类型</th>
							<th>申请放款金额(元)</th>
							<th>融资期限(天)</th>
							<th>融资利率(%)</th>
							<th>申请日期</th>
							<th>关联融资申请单号</th>
							<th>放款状态</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
							<tr><td colspan="11">暂无数据</td></tr>
						</c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
			              	<tr>
								<td class="toggletr">${index.count}</td>
								<td class="maxwidth"><a href="javascript:;" class="order-a subView" lid="${obj.id}">${obj.orderNo}</a></td>
								<td class="maxwidth">${obj.financier}</td>
								<td class="maxwidth">
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
								</td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingTerm}" pattern="##0.####" maxFractionDigits="4"/></td>
								<td class="maxwidth"><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
								<td class="maxwidth"><%-- <a href="javascript:;" class="order-a view" fid="${obj.financingApplyId }" status="${obj.financingStatus }"> --%>${obj.financingOrderNumber}<!-- </a> --></td>
								<td class="maxwidth">
									<c:if test="${not empty obj.status and obj.status eq 3}">待确权</c:if>
								</td>
								<td><a href="<%=basePath%>factorLoanAuditController/${obj.id }/view.htm" class="btn-modify authorize mr10">确权</a></td>
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
				var lid=$(this).attr("lid");
				param={"id":lid,"url":"/factorLoanAuditController/loanAudit/waitAuthorizeList.htm"};
				httpPost('/loanApplyCommonApi/selectChildrenDetail.htm',param);
			})
			/* $(".view").click(function(){
				var fid=$(this).attr("fid");
				var status=$(this).attr("status");
				param={"id":fid,"statue":status,"url":"/factorLoanAuditController/loanAudit/waitAuthorizeList.htm"};
				httpPost('/financingApplyCommonApi/view.htm',param);
			}) */
		</script>
	</body>
</html>