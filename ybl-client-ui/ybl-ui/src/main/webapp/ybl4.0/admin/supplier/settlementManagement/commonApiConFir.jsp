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
	<!--top start -->
		
		<!--top end -->	
		
			<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" id="one" clickTrue="clickFalse" url="/loanApplyCommonApi/loanappictionitem.html?id=${id}"><div id="proicon1" class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="two" clickTrue="clickFalse" url="/loanApplyCommonApi/selectTotalElemets?type=${type}&loanApplyId=${id}"> <div id="proicon2" class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="three" clickTrue="clickFalse" url="/loanApplyCommonApi/assettransfer.html?id=${id}"><div id="proicon3" class="proicon bg3 statusTwo"></div>资产转让确权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="four" clickTrue="clickFalse" url="/loanApplyCommonApi/platAudit?id=${id}"><div id="proicon4" class="proicon bg4 statusTwo"></div>平台审核</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist pro_li_cur" id="five" clickTrue="clickFalse" url="/financingToConfirm/info?id_=${batch_id}&financingAmount=${financingAmount}"><div id="proicon5" class="proicon bg5 statusThree"></div>结算放款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist banned_click" id="six" clickTrue="clickFalse" url="/loanApplyCommonApi/selectSettleInfoByLoanOrderNoConfirm?orderNo=${orderno}&financingAmount=${financingAmount}"><div id="proicon6" class="proicon bg6 statusOne"></div>收款确认</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist banned_click" id="seven" clickTrue="clickTrue" url="/rePayMentController/repaymentlist.htm?id=${id}"><div id="proicon7" class="proicon bg7 statusOne"></div>还款计划</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist banned_click" id="eight" clickTrue="clickFalse" url="/loanApplyCommonApi/repaymentInfo?orderNo=${orderno}"><div id="proicon8" class="proicon bg8 statusOne"></div>还款</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist banned_click" id="nine" clickTrue="clickFalse" url="/loanApplyCommonApi/selectRepayPlanByLoanOrderNoAlreadyConfim?orderNo=${orderno}?orderNo=${orderNo}"><div id="proicon9" class="proicon bg8 statusOne"></div>还款确认</li>
			</ul>
		</div>
		<input type="hidden" id="id" value="${id }">
		<input type="hidden" id="type" value="${type }">
		<input type="hidden" id="batch_id" value="${batch_id}">
		<input type="hidden" id="financingAmount" value="${financingAmount }">
		<input type="hidden" id="orderNo" value="${orderno }">
		<input type="hidden" id="financingstatus" value="${financingstatus }">
		<input type="hidden" id="attribute1" value="${attribute1 }">
		<input type="hidden" id="attribute2" value="${attribute2 }">	
		<div class="w1200">
			<iframe id="iframe1" width="100%" height="2200px" onload="resizeIndexIFrame(this)" src="/financingToConfirm/info?id_=${batch_id}&financingAmount=${financingAmount}"></iframe>
			
		</div>
		
		<!-- 接受跳转的url路径。返回不同得列表 -->
		<input type="hidden"  id="jumpurl" value="${url}">
		
		<div class="mb80"></div>

		<input type="hidden" id="financingstatus" value="${financingstatus }">
		<input type="hidden" id="attribute1" value="${attribute1 }">
		<input type="hidden" id="attribute2" value="${attribute2 }">
	</body>
<script>
$('.iconlist').click(function(){
	var clickTrue=$(this).attr("clickTrue");
	if(clickTrue=="clickTrue"){
		$('.iconlist').removeClass('pro_li_cur');
		$(this).addClass('pro_li_cur');
		$('#iframe1').attr('src',$(this).attr('url'));
	}else{
		//top.alert("该订单未到此状态");
	}
})

</script>
</html>