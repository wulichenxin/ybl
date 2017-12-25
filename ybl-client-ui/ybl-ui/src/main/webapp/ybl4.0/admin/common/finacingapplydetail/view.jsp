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
		<title>融资综合查询详情</title>
	</head>

	<body>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		<input type="hidden" value="${statue}" id="finstatue"/>
		<script type="text/javascript">
	/* 	//通过比对状态，给tab页签加载样式
		$(function () {
		var statue=$("#finstatue").val();
            $('.proicon').each(function (index, obj) {
               if(index+1<statue){            	      	   
            	   $(this).addClass('statusTwo');
            	   $(this).parent().attr("clickTrue","clickTrue");
            	   
               }else if(statue==index+1){
            	   $(this).addClass('statusThree');
            	   $(this).parent().attr("clickTrue","clickFalse");
               }else if(index+1>statue){
            	   $(this).addClass('statusOne');
            	   $(this).parent().attr("clickTrue","clickFalse");
               }
            });
        });
		 */
		
		</script>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资综合查询<span class="mr10 ml10">-</span>详情展示<span class="mr10 ml10"></span></div>
		</div>
		<input type="hidden" value="${statue}" id="finstatue"/>
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlistappl" id="one" clickTrue="clickTrue" url="/IntegratedQueryController/projectDetails.htm?id=${id}&childrenId=${childrenId}"><div class="proicon bg1
				<c:if test="${statue >1 }">statusTwo</c:if>
				<c:if test="${statue ==1 }">statusThree</c:if>" ></div>项目详情</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="two" 
				<c:choose>
						<c:when test="${statue >2 and statue!=11 }">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>	
				url="/IntegratedQueryController/preliminarytrialPlatform?id=${id}&audittype=1"> <div class="proicon bg2
				<c:if test="${statue ==2 or statue==11}">statusThree</c:if>
					<c:if test="${statue >2 and financingstatus!=11}">statusTwo</c:if>"></div>平台初审</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="three" 
				<c:choose>
						<c:when test="${statue >3 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
				</c:choose>
				url="/IntegratedQueryController/capitalTrial?id=${id}&childrenId=${childrenId}"><div class="proicon bg3 
				<c:if test="${statue ==3 or statue==10}">statusThree</c:if>
					<c:if test="${statue >3 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <3 or statue ==10 or statue ==11}">statusOne</c:if>
				
				"></div>资方初审</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="four" 
				<c:choose>
						<c:when test="${statue >4 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/IntegratedQueryController/chooseIntentionalCapital.htm?id=${id}&childrenId=${childrenId}"><div class="proicon bg4 
				<c:if test="${statue ==4}">statusThree</c:if>
					<c:if test="${statue >4 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <4 or statue ==10 or statue ==11}">statusOne</c:if>
				"></div>选择意向资方</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="five" 
				<c:choose>
						<c:when test="${statue >5 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/IntegratedQueryController/capitalTrialLast?id=${id}&childrenId=${childrenId}"><div class="proicon bg5
				<c:if test="${statue ==5}">statusThree</c:if>
					<c:if test="${statue >5 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <5 or statue ==10 or statue ==11}">statusOne</c:if>
				"></div>资方终审</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="six" 
				<c:choose>
						<c:when test="${statue >6 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/IntegratedQueryController/cooperativeCapital?id=${id}&childrenId=${childrenId}"><div class="proicon bg6
				<c:if test="${statue ==6}">statusThree</c:if>
					<c:if test="${statue >6 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <6 or statue ==10 or statue ==11}">statusOne</c:if>
				 "></div>合作资方</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="seven" 
				<c:choose>
						<c:when test="${statue >7 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				url="/IntegratedQueryController/platformreview?id=${id}&childrenId=${childrenId}"><div class="proicon bg7
				<c:if test="${statue ==7}">statusThree</c:if>
					<c:if test="${statue >7 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <7 or statue ==10 or statue ==11}">statusOne</c:if>
				"></div>平台复审</li>
				
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				
				<li class="iconlistappl" id="eight"
				<c:choose>
						<c:when test="${statue >8 and statue!=10 and statue!=11}">clickTrue="clickTrue"</c:when>
						<c:otherwise>clickTrue="clickFalse"</c:otherwise>
					</c:choose>
				 url="/IntegratedQueryController/selectcontractdetail.htm?id=${id}&childrenId=${childrenId}"><div class="proicon bg8 
				 <c:if test="${statue ==8}">statusThree</c:if>
					<c:if test="${statue >8 and statue!=10 and statue!=11}">statusTwo</c:if>
					<c:if test="${statue <8 or statue ==10 or statue ==11}">statusOne</c:if>
				 "></div>签署主合同</li>
			</ul>	
			
		</div>
		
	
		
		<div class="w1200">
			<iframe id="iframe1" onload="resizeIndexIFrame(this)" width="100%" height="1000px" src="/IntegratedQueryController/projectDetails.htm?id=${id}&childrenId=${childrenId}"></iframe>
			
		</div>
		
		<input type="hidden"  id="jumpurl" value="${url}">
		
		<div class="mb80"></div>
		
		
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