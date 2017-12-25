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
        <jsp:include page="/ybl4.0/admin/common/top.jsp" />
        <!--top end -->
	<body>
		<div class="Bread-nav w1200">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />资产确权</div>
		</div>
		<div class="w1200">
		<form action="/enterpriseAssetOwnership/assetOwnershipList.htm" id="pageForm" method="post">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label class="label-long">放款申请单号：</label>
						<input class="content-form" value="${factorLoanAuditVo.orderNo }" name="orderNo">
					</div>
					<div class="form-grou mr40">
						<label class="label-long">关联主合同号：</label><input class="content-form" value="${factorLoanAuditVo.financingOrderNumber }" name="financingOrderNumber">
					</div>
					<div class="form-grou">
						<label class="label-long">资产类型：</label>
						<select class="content-form" name="assetsType">
							<option value="1" <c:if test="${factorLoanAuditVo.assetsType eq 1}">selected = "selected"</c:if> >应收账款</option>
							<option value="2" <c:if test="${factorLoanAuditVo.assetsType eq 2}">selected = "selected"</c:if>>应付账款</option>
							<option value="3" <c:if test="${factorLoanAuditVo.assetsType eq 3}">selected = "selected"</c:if>>票据</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					
					<div class="form-grou">
						<label class="label-long">放款申请时间：</label>
							<input id="beginDate" class="content-form" value="${factorLoanAuditVo.startApplyDate }" name="startApplyDate"><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40">
						<input id="endDate" class="content-form" value="${factorLoanAuditVo.endApplyDate }" name="endApplyDate"><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
					<div class="btn-modify" id="query_btn">查询</div>
				</div>
			</div>
		<div class="mt40">
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
						<c:if test="${empty list }">
						<tr><td colspan="11">暂无数据</td></tr>
						</c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
			              	<tr>
								<td class="toggletr">${index.count}</td>
								<td><a href="javascript:;" uid="${obj.id}" utype="${obj.assetsType }" class="order-a loanApply_btn">${obj.orderNo}</a></td>
								<td>${obj.financier}</td>
								<td>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
								</td>
								<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td>${obj.financingTerm}</td>
								<td><fmt:formatNumber value="${obj.financingRate }" pattern="#,##0.####" maxFractionDigits="4"/></td>
								<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
								<td>${obj.financingOrderNumber}</td>
								<td>
									<c:if test="${not empty obj.status and obj.status eq 3}">待确权</c:if>
								</td>
								<td><a href="javascript:;" class="btn-modify mr10 asset_btn" uid="${obj.id}" utype="${obj.assetsType }">确权</a></td>
							</tr>
		              </c:forEach>
					</table>
				</div>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</div>
			</form>
			<form action="/enterpriseAssetOwnership/assetTransfer.htm" id="assetTransferForm" method="post">
			<input type="hidden" name="loanApplyId" id="uid">
			<input type="hidden" name="assetsType" id="assetsType">
			<input type="hidden" name="returnPage" id="returnPage">
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
		//确权按钮
		$(".asset_btn").click(function(){
			var id = $(this).attr("uid");
			var assetsType = $(this).attr("utype");
			$("#uid").val(id);
			$("#assetsType").val(assetsType);
			$("#assetTransferForm").submit();
		});
	   //查询按钮
		$("#query_btn").click(function(){
			$("#pageForm").submit();
		});
	   //loanApply_btn
	   $(".loanApply_btn").click(function(){
			var id = $(this).attr("uid");
			var assetsType = $(this).attr("utype");
			$("#assetTransferForm").attr("action","/enterpriseAssetOwnership/loanApplicationDetails.htm");
			$("#uid").val(id);
			$("#assetsType").val(assetsType);
			$("#returnPage").val("2");
			$("#assetTransferForm").submit();
		});
	   //financingApply_btn
	   $(".financingApply_btn").click(function(){
		   var id = $(this).attr("uid");
		   var usubid = $(this).attr("usubid");
		   var form = $("<form method='post'></form>");
	        form.attr({"action":"/financingApplyV4Controller/financingApply/getFinancingApply.htm"});
	            var input = $("<input type='hidden'>");
	            input.attr({"name":"id"});
	            input.val(id);
	            form.append(input);
	            var input1 = $("<input type='hidden'>");
	            input1.attr({"name":"subid"});
	            input1.val(usubid);
	            form.append(input1);
	        $(document.body).append(form);
	        form.submit();
		  //window.location.href="/financingApplyV4Controller/financingApply/getFinancingApply.htm?id="+id+"&subid="+subid;
	   });
</script>
	</body>
</html>