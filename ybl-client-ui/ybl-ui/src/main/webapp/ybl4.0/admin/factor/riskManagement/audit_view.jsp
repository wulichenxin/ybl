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
		<title>融资申请详情</title>
	</head>

	<body>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" url="/IntegratedQueryController/tab1?id=${id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab2?id=${id}&audittype=1"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab3?id=${id}"><div class="proicon bg3 statusThree"></div>资方初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab5?id=${id}"><div class="proicon bg5 statusThree"></div>资方终审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab6?id=${id}"><div class="proicon bg6 statusThree"></div>合作资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab7?id=${id}&audittype=2"><div class="proicon bg7 statusTwo"></div>平台复审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" url="/IntegratedQueryController/tab7?id=${id}"><div class="proicon bg8 statusThree"></div>签署主合同</li>
			</ul>	
			
		</div>
		
	
		
		<div class="w1200">
			<iframe id="iframe1" width="100%" height="2200px" src="/factorRiskManagementController/financingApplyDetail.htm?financingApplyId=${financingApplyId }&subFinancingApplyId=${subFinancingApplyId}"></iframe>
			
		</div>
		
		
		
		<div class="mb80"></div>
		
		
	</body>

</html>