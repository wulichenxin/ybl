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
<!--top start -->
        <jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
        <!--top end -->
	<body>
	<%-- 	<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款综合查询<span class="mr10 ml10">-</span>详情展示<span class="mr10 ml10"></span></div>
		</div>
		
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" id="one" url="/loanApplyCommonApi/loanappictionitem.html?id=${id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="two" url="/loanApplyCommonApi/selectTotalElemets?type=${type}&loanApplyId=${id}"> <div class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="three" url="/loanApplyCommonApi/assettransfer.html?id=${id}"><div class="proicon bg3 statusThree"></div>资产转让权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="four" url="/loanApplyCommonApi/platAudit?id=${id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="five" url="/loanApplyCommonApi/selectSettleInfoByLoanOrderNo?orderNo=${orderno}&financingAmount=${financingAmount}"><div class="proicon bg5 statusThree"></div>结算放款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="six" url="/loanApplyCommonApi/selectSettleInfoByLoanOrderNoConfirm?orderNo=${orderno}&financingAmount=${financingAmount}"><div class="proicon bg6 statusThree"></div>收款确认</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="seven" url="/loanApplyCommonApi/repaymentlist.htm?id=${id}"><div class="proicon bg7 statusTwo"></div>还款计划</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist"  id="eight" url="/loanApplyCommonApi/repaymentInfo?orderNo=${orderno}"><div class="proicon bg8 statusThree"></div>还款</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="nine" url="/loanApplyCommonApi/selectRepayPlanByLoanOrderNoAlreadyConfim?orderNo=${orderno}"><div class="proicon bg8 statusThree"></div>还款确认</li>
			
			</ul>	
			
		</div>
		 --%>
		
		
		
		
			<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlistappl pro_li_cur" id="one" clickTrue="clickTrue" url="/loanApplyCommonApi/loanappictionitem.html?id=${id}"><div id="proicon1" class="proicon bg1
				<c:if test="${financingstatus >1 }">statusTwo</c:if>
				<c:if test="${financingstatus ==1 }">statusThree</c:if>"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="two" 
					<c:choose>
						<c:when test="${financingstatus >2}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/loanApplyCommonApi/selectTotalElemets?type=${type}&loanApplyId=${id}"> <div id="proicon2" class="proicon bg2 
					<c:if test="${financingstatus ==2}">statusThree</c:if>
					<c:if test="${financingstatus >2}">statusTwo</c:if>
				"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="three"
					<c:choose>
						<c:when test="${financingstatus >3}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/loanApplyCommonApi/assettransfer.html?id=${id}"><div id="proicon3" class="proicon bg3 
					<c:if test="${financingstatus ==3}">statusThree</c:if>
					<c:if test="${financingstatus >3}">statusTwo</c:if>
					<c:if test="${financingstatus <3}">statusOne</c:if>
				"></div>资产转让确权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="four"
					<c:choose>
						<c:when test="${financingstatus >4}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/loanApplyCommonApi/platAudit?id=${id}"><div id="proicon4" class="proicon bg4 
					<c:if test="${financingstatus ==4}">statusThree</c:if>
					<c:if test="${financingstatus >4}">statusTwo</c:if>
					<c:if test="${financingstatus <4}">statusOne</c:if>
				"></div>平台审核</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="five" 
					<c:choose>
						<c:when test="${financingstatus >5}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/loanApplyCommonApi/selectSettleInfoByLoanOrderNo?orderNo=${orderno}&financingAmount=${financingAmount}"><div id="proicon5" class="proicon bg5 
					<c:if test="${financingstatus ==5}">statusThree</c:if>
					<c:if test="${financingstatus >5}">statusTwo</c:if>
					<c:if test="${financingstatus <5}">statusOne</c:if>
				"></div>结算放款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="six"
					<c:choose>
						<c:when test="${financingstatus >8}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/loanApplyCommonApi/selectSettleInfoByLoanOrderNoConfirm?orderNo=${orderno}&financingAmount=${financingAmount}"><div id="proicon6" class="proicon bg6 
					<c:if test="${financingstatus ==8}">statusThree</c:if>
					<c:if test="${financingstatus >8}">statusTwo</c:if>
					<c:if test="${financingstatus <8}">statusOne</c:if>
				"></div>收款确认</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="seven"
					<c:choose>
						<c:when test="${financingstatus >5}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/loanApplyCommonApi/repaymentlist.htm?orderNo=${orderno}"><div id="proicon7" class="proicon bg7 
					<c:if test="${financingstatus >5}">statusTwo</c:if>
					<c:if test="${financingstatus <=5}">statusOne</c:if>
				"></div>还款计划</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="eight" 
					<c:choose>
						<c:when test="${attribute1 >0}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/loanApplyCommonApi/repaymentInfo?orderNo=${orderno}"><div id="proicon8" class="proicon bg8 
					<c:if test="${attribute1 >0}">statusTwo</c:if>
					<c:if test="${financingstatus <=8 && attribute1 <=0}">statusOne</c:if>
					<c:if test="${financingstatus >8 && attribute1 <=0}">statusThree</c:if>
				"></div>还款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlistappl" id="nine" 
					<c:choose>
						<c:when test="${attribute2 >0}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/loanApplyCommonApi/selectRepayPlanByLoanOrderNoAlreadyConfim?orderNo=${orderno}"><div id="proicon9" class="proicon bg8 
					<c:if test="${attribute2 >0}">statusTwo</c:if>
					<c:if test="${attribute1<=0 && attribute2 <=0}">statusOne</c:if>
					<c:if test="${financingstatus <=8 && attribute2 <=0}">statusOne</c:if>
					<c:if test="${financingstatus >8 && attribute2 <=0 && attribute1>0}">statusThree</c:if>
				"></div>还款确认</li>
			</ul>
		</div>
		<input type="hidden" id="id" value="${id }">
		<input type="hidden" id="type" value="${type }">
		<input type="hidden" id="financingAmount" value="${financingAmount }">
		<input type="hidden" id="orderNo" value="${orderno }">
		<input type="hidden" id="financingstatus" value="${financingstatus }">
		<input type="hidden" id="attribute1" value="${attribute1 }">
		<input type="hidden" id="attribute2" value="${attribute2 }">	
		<div class="w1200">
			<iframe id="iframe1" onload="resizeIndexIFrame(this)" width="100%" height="1000px" src="/loanApplyCommonApi/loanappictionitem.html?id=${id}"></iframe>
			
		</div>
		
		<!-- 接受跳转的url路径。返回不同得列表 -->
		<input type="hidden"  id="jumpurl" value="${url}">
		
		<div class="mb80"></div>

		<input type="hidden" id="financingstatus" value="${financingstatus }">
		<input type="hidden" id="attribute1" value="${attribute1 }">
		<input type="hidden" id="attribute2" value="${attribute2 }">
	</body>
<script>
$('.iconlistappl').click(function(){
	var clickTrue=$(this).attr("clickTrue");
	if(clickTrue=="clickTrue"){
		$('.iconlistappl').removeClass('pro_li_cur');
		$(this).addClass('pro_li_cur');
		$('#iframe1').attr('src',$(this).attr('url'));
	}else{
		//top.alert("该订单未到此状态");
	}
})

</script>
</html>