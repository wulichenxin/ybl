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
		<title>长亮国信</title>
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist pro_li_cur" id="one" clickTrue="clickTrue" url="<%=basePath%>loanApplyCommonApi/loanappictionitem.html?id=${lid}"><div id="proicon1" class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist2 linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<c:choose>
					<c:when test="${status == 2 }">
						<li class="iconlist" id="two" clickTrue="clickTrue" url="<%=basePath%>factorLoanAuditController/loanAudit/${lid }/toFactoringElements.htm"> <div class="proicon bg2 statusThree"></div>资方办理</li>
					</c:when>
					<c:otherwise>
						<li class="iconlist" id="two" clickTrue="clickTrue" url="<%=basePath%>loanApplyCommonApi/selectTotalElemets?type=${assetsType}&loanApplyId=${lid}"> <div id="proicon2" class="proicon bg2 statusTwo"></div>资方办理</li>
						<li class="iconlist2 linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
						<li class="iconlist" id="three" clickTrue="clickTrue" url="<%=basePath%>factorLoanAuditController/loanAudit/${lid }/toAssetAuthorize.htm"><div id="proicon3" class="proicon bg3 statusThree"></div>资产转让确权</li>
					</c:otherwise>
				</c:choose>
			</ul>	
		</div>
		<div class="w1200" style="width:1350px">
			<iframe id="iframe1" onload="resizeIndexIFrame(this)" width="100%" height="2200px" src="
			<c:choose>
				<c:when test="${status == 2 }"><%=basePath%>factorLoanAuditController/loanAudit/${lid }/toFactoringElements.htm</c:when>
				<c:otherwise><%=basePath%>factorLoanAuditController/loanAudit/${lid }/toAssetAuthorize.htm</c:otherwise>
			</c:choose>"></iframe>
		</div>
		
		<!-- 接受跳转的url路径。返回不同得列表 -->
		<input type="hidden"  id="jumpurl" value="
			<c:choose>
				<c:when test="${status == 2 }">/factorLoanAuditController/loanAudit/loanAuditList.htm</c:when>
				<c:otherwise>/factorLoanAuditController/loanAudit/waitAuthorizeList.htm</c:otherwise>
			</c:choose>">
		
		<div class="mb80"></div>
	</body>
	<script>
		$('.iconlist').click(function(){
			var clickTrue=$(this).attr("clickTrue");
			if(clickTrue=="clickTrue"){
				$('.iconlist').removeClass('pro_li_cur');
				$(this).addClass('pro_li_cur');
				$('#iframe1').attr('src',$(this).attr('url'));
			}else{
				top.alert("该订单未到此状态");
			}
		})
	</script>
</html>