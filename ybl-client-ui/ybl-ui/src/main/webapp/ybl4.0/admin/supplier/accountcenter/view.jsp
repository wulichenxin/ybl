<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset='utf-8' />
	<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
	<%@include file="/ybl4.0/admin/common/link.jsp"%>
</head>

	<body>
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist showiframe" url="/tabDetailController/loanappictionitem?loanApplyId=${factorLoanVo.id}"><div class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist showiframe" url="/tabDetailController/selectTotalElemets?type=${assetsType }&loanApplyId=${factorLoanVo.id}"> <div class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist showiframe" url="/tabDetailController/selectAssetAttach?loanApplyId=${factorLoanVo.id}"><div class="proicon bg3 statusTwo"></div>资产转让确权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist showiframe" url="/tabDetailController/selectPlatAudiByLoanOrderId?loanApplyId=${factorLoanVo.id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
				
				<c:if test="${pageFlag ne '1'}">
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/selectSettleInfoByLoanOrderNo?orderNo=${orderNo }&financingAmount=${financingAmount}"><div class="proicon bg5 statusTwo"></div>结算放款</li>
				</c:if>
				
				<c:if test="${pageFlag eq '6'}">
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/selectReceiveConfirmByOrderNoAndLoanOrderId?orderNo=${orderNo }
																		&financingAmount=${financingAmount}&loanOrderId=${factorLoanVo.id}">
					<div class="proicon bg6 statusThree"></div>收款确认</li>
				</c:if>
				<c:if test="${pageFlag eq '8' or pageFlag eq '2'}">
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/selectReceiveConfirmByOrderNoAndLoanOrderId?orderNo=${orderNo }
																		&financingAmount=${financingAmount}&loanOrderId=${factorLoanVo.id}">
					<div class="proicon bg6 statusTwo"></div>收款确认</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					
					<li class="iconlist showiframe" url="/tabDetailController/selectRepayPlanByLoanOrderNo?orderNo=${orderNo}">
					<div class="proicon bg7 statusTwo"></div>还款计划</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/suppliereceivingadd?orderNo=${orderNo }
																		&id=${id}&overfee=${overfee}&financingAmount=${financingAmount}">
					<div class="proicon bg6 statusThree"></div>还款</li>
				</c:if>
				
				<c:if test="${pageFlag eq '4' or pageFlag eq '3'}">
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/selectReceiveConfirmByOrderNoAndLoanOrderId?orderNo=${orderNo }
																		&financingAmount=${financingAmount}&loanOrderId=${factorLoanVo.id}">
					<div class="proicon bg6 statusTwo"></div>收款确认</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/selectRepayPlanByLoanOrderNo?orderNo=${orderNo}">
					<div class="proicon bg7 statusTwo"></div>还款计划</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist showiframe" url="/tabDetailController/repaymentInfo?orderNo=${orderNo }">
					<div class="proicon bg6 statusThree"></div>还款</li>
					
				</c:if>
			</ul>	
			
		</div>
		
		<input type="hidden" value="${orderNo }" id="orderNo" /> <!-- 放款订单号 -->
		<input type="hidden" value="${financingAmount }" id="financingAmount" /> <!-- 融资申请金额 -->
		<input type="hidden" value="${assetsType }" id="assetsType" /> <!-- 资产类型 -->
		<input type="hidden" id="loan_apply_id" value="${factorLoanVo.id}"/> <!-- 放款申请id -->
		<input type="hidden" id="pageFlag" value="${pageFlag}"/>
		<div class="w1200">
			<c:if test="${pageFlag eq '6'}">
				<iframe id="iframe1" onload="resizeIndexIFrame2(this)" width="100%" height="2000px" src="/tabDetailController/selectReceiveConfirmByOrderNoAndLoanOrderId?orderNo=${orderNo }
																		&financingAmount=${financingAmount}&loanOrderId=${factorLoanVo.id}"></iframe>
			</c:if>
			<c:if test="${pageFlag eq '2' or pageFlag eq '8'}">
				<iframe id="iframe1" onload="resizeIndexIFrame2(this)" width="100%" height="2000px" src="/tabDetailController/suppliereceivingadd?orderNo=${orderNo }
																		&id=${id}&&overfee=${overfee}&financingAmount=${financingAmount}"></iframe>
			</c:if>
			<c:if test="${pageFlag eq '3' or pageFlag eq '4'}">
				<iframe id="iframe1" onload="resizeIndexIFrame2(this)" width="100%" height="2000px" src="/tabDetailController/loanappictionitem?loanApplyId=${factorLoanVo.id}"></iframe>
			</c:if>
			<c:if test="${pageFlag eq '1'}">
				<iframe id="iframe1" onload="resizeIndexIFrame2(this)" width="100%" height="2000px" src="/tabDetailController/loanappictionitem?loanApplyId=${factorLoanVo.id}"></iframe>
			</c:if>
		</div>
		
		<div class="mb80"></div>
		
	</body>
</html>