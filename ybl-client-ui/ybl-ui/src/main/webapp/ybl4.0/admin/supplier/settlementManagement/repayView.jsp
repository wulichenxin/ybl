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
		<meta charset="UTF-8">
		<title>放款综合查询详情</title>
	</head>

	<body>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->

		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资综合查询<span class="mr10 ml10">-</span>详情展示<span class="mr10 ml10"></span></div>
		</div>
		
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" url="/loanapplicationcontroller/loanappictionitem.html?id=${loanApply.id_}"><div class="proicon bg1 statusOne"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/captialhandle.htm?id=${loanApply.id_}"> <div class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/assettransfer.html?subid=${loanApply.sub_financing_apply_id}"><div class="proicon bg3 statusThree"></div>资产转让权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/platAudit?id=${loanApply.id_}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/info?id=${id}&batchId=${loanApply.payment_batch_id}"><div class="proicon bg5 statusThree"></div>结算放款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/preSettlement.htm?id=${loanApply.id_}&batchId=${loanApply.payment_batch_id}"><div class="proicon bg6 statusThree"></div>收款确认</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/rePayMentController/repaymentlist.htm?id=${loanApply.id_}"><div class="proicon bg7 statusTwo"></div>还款计划</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/repaymentInfo.htm?id=${loanApply.id_}&orderno=${loanApply.order_no}"><div class="proicon bg8 statusThree"></div>还款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" url="/loanapplicationcontroller/makeSurerepaymented.htm?id=${loanApply.id_}"><div class="proicon bg8 statusThree"></div>还款确认</li>
			
			</ul>	
			
		</div>
		
	
		
		<div class="w1200">
		<c:if test="${empty iframeChange}">
			<iframe id="iframe1" width="100%" height="2200px" onload="resizeIndexIFrame(this)" src="/rePayMentController/repaymentlist.htm?id=${loanApply.id_}"></iframe>
		</c:if>	
		<c:if test="${not empty iframeChange and iframeChange eq 'iframeChange' }">
		   <iframe id="iframe1" width="100%" height="2200px" onload="resizeIndexIFrame(this)" src="/rePayMentController/RepaymentInfo.htm?id=${id}&order_no=${orderNo}"></iframe>
		</c:if>
		</div>
		
		
		
		<div class="mb80"></div>
		
		
	</body>

</html>