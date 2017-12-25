<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<title>放款综合查询详情</title>
<link
	href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet">
	<style type="text/css">
	.banned_click {
		pointer-events: none;
		cursor: not-allowed;
		box-shadow: none;
		opacity: 0.3;
	}
	</style>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />结算管理<span
				class="mr10 ml10">-</span>融资确认<span class="mr10 ml10">-</span>待确认项目
		</div>
	</div>
	<div class="w1200">
		<ul class="clearfix iconul">
			<li class="iconlist showiframe"
				url="/financingToConfirm/loanappictionitem?loanApplyId=${loanApply.id}"><div
					class="proicon bg1 statusOne"></div>项目详情</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe"
				url="/financingToConfirm/selectTotalElemets?type=${loanApply.assetsType}&loanApplyId=${loanApply.id}">
				<div class="proicon bg2 statusTwo"></div>资方办理
			</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe"
				url="/financingToConfirm/selectAssetAttach?loanApplyId=${loanApply.id}"><div
					class="proicon bg3 statusThree"></div>资产转让权</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe"
				url="/financingToConfirm/selectPlatAudiByLoanOrderId?loanApplyId=${loanApply.id}"><div
					class="proicon bg4 statusTwo"></div>平台审核</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe"
				url="/financingToConfirm/selectSettleInfoByLoanOrderNo?orderNo=${loanApply.orderNo }&financingAmount=${loanApply.financing_amount}"><div
					class="proicon bg5 statusThree"></div>结算放款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe"
				url="/financingToConfirm/info?id_=${entity.id}&financingAmount=${loanApply.financing_amount}"><div?
					class="proicon bg6 statusThree"></div>收款确认</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe banned_click"><div
					class="proicon bg7 statusTwo"></div>还款计划</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe banned_click"><div
					class="proicon bg8 statusThree"></div>还款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>

			<li class="iconlist showiframe banned_click"><div
					class="proicon bg8 statusThree"></div>还款确认</li>

		</ul>

	</div>

	<%-- <input type="hidden" value="${orderNo }" id="orderNo" /> <!-- 放款订单号 -->
		<input type="hidden" value="${financingAmount }" id="financingAmount" /> <!-- 融资申请金额 -->
		<input type="hidden" value="${assetsType }" id="assetsType" /> <!-- 资产类型 -->
		<input type="hidden" id="loan_apply_id" value="${factorLoanVo.id}"/> <!-- 放款申请id -->
		<input type="hidden" id="pageFlag" value="${pageFlag}"/> --%>
	<div class="w1200">
		<%-- <c:if test="${pageFlag eq '6'}"> --%>
		<iframe id="iframe1" width="100%" height="2200px" onload="resizeIndexIFrame(this)"
			src="/financingToConfirm/info?id_=${entity.id}&financingAmount=${loanApply.financing_amount}"></iframe>
		<%-- </c:if> --%>
		<%-- <c:if test="${pageFlag eq '8'}">
				<iframe id="iframe1" width="100%" height="2000px" src="/tabDetailController/suppliereceivingadd?orderNo=${orderNo }
																		&id=${id}&period=${period}&financingName=${financingName }
																		&overfee=${overfee}&financingAmount=${financingAmount}"></iframe>
			</c:if> --%>



	</div>



	<div class="mb80"></div>


</body>

</html>