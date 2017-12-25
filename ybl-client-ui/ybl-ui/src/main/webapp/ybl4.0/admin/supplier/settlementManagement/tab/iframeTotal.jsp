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
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<body>
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--弹出框-->
	<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<!--top end -->
	<div class="w1200 clearfix border-b">
		<ul class="clearfix formul">
			<%-- <li class="iconlist showiframe" url="/IntegratedQueryController/tab1?id=${id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
            <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
            <li class="iconlist showiframe" url="/IntegratedQueryController/tab2?id=${id}&audittype=1"> <div class="proicon bg2 statusTwo"></div>资方办理</li>
            <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
            <li class="iconlist showiframe" url="/IntegratedQueryController/tab3?id=${id}"><div class="proicon bg3 statusThree"></div>资产转让权</li>
            <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
            <li class="iconlist showiframe" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
            <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
            <li class="iconlist showiframe" url="/IntegratedQueryController/tab5?id=${id}"><div class="proicon bg5 statusThree"></div>结算放款</li>
             --%>
			
			<li class="iconlist showiframe" url="/loanapplicationcontroller/tab1?id=${id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
			<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
			<li class="iconlist showiframe" url="/tabDetailController/selectTotalElemets?type=${assetsType}&loanApplyId=${factorLoanVo.id}"> <div class="proicon bg2 statusTwo"></div>资方办理</li>
			<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
			<li class="iconlist showiframe" url="/tabDetailController/selectAssetAttach?orderNo=${orderNo}"><div class="proicon bg3 statusThree"></div>资产转让权</li>
			<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
			<li class="iconlist showiframe" url="/tabDetailController/selectPlatAudiByLoanOrderId?loanApplyId=${factorLoanVo.id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
			<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
			<li class="iconlist showiframe" url="/tabDetailController/selectSettleInfoByLoanOrderNo?orderNo=${orderNo}&financingAmount=${financingAmount}"><div class="proicon bg5 statusThree"></div>结算放款</li>
			<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
			<li class="iconlist hideiframe" url=""><div class="proicon bg6 statusThree"></div>收款确认</li>
		</ul>
	</div>
	<div class="w1200">
			<iframe id="iframe1" width="100%" height="2000px" src="/supplierAccountCenterController/receiveconfirm?orderNo=${orderNo}&financingAmount=${financingAmount}&assetsType=${assetsType}"></iframe>
	</div>
	</body>
</html>