<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%> --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="/ybl4.0/admin/common/link.jsp" %>
</head>
<body>
<p class="per_title mb30"><span>业务认证</span></p>
    <c:choose>
        <c:when test="${not empty errorInfo }">
            <c:if test="${errorInfo eq 'unfinishedError' }">
                <div style="text-align:center;font-size:18px;margin-top:100px">
                    <img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/sfrz_wrz_img.png" />
                    <p>${prompt }</p>
                </div>
            </c:if>
            <c:if test="${errorInfo eq 'auditingError' }">
                <div style="text-align:center;font-size:18px;margin-top:100px">
                   <img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/sfrz_shz_img.png" />
                   <p>${prompt }</p>
                </div>
            </c:if>
            
        </c:when>
        <c:otherwise>
		<div class="business">
			<ul class="clearfix">
				<li class="businessList">
					<img src="${app.staticResourceUrl}/ybl4.0/resources/images/my/rzfrz_icon.png" <c:if test="${empty financingParty or financingParty.authStatus eq '3'}">id ="financingPartyAuth" class="handtype" </c:if> />
						<p class="rztitle" >融资方认证</p>
						<c:if test="${not empty financingParty}">
							<div class="rz-bottom">
							<c:if test="${financingParty.authStatus eq '1' }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghe_icon2.png" />审核中
							</c:if>
							<c:if test="${financingParty.authStatus > 1 }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />审核完成 
							</c:if>
							<c:if test="${financingParty.authStatus eq '2'}">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />认证通过
							</c:if>
							<c:if test="${financingParty.authStatus eq '3'}">
								<div class="linebox"></div>
							<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenheFalse_icon.png" />认证失败
							</c:if>
							<div class="btn-modify mt30 lookAuth" uid="${financingParty.id}" authStatus="${financingParty.authStatus}" utype="1">查看</div>
							</div>
						</c:if>
				</li>
				<li class="businessList">
					<img src="${app.staticResourceUrl}/ybl4.0/resources/images/my/zjfrz_icon.png" <c:if test="${empty fundSide or fundSide.authStatus eq '3'}">id ="fundSideAuth" class="handtype" </c:if> />
						<p class="rztitle">资金方认证</p>
						<c:if test="${not empty fundSide}">
							<div class="rz-bottom">
							<c:if test="${fundSide.authStatus eq '1' }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghe_icon2.png" />审核中
							</c:if>
							<c:if test="${fundSide.authStatus > 1 }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />审核完成 
							</c:if>
							<c:if test="${fundSide.authStatus eq '2'}">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />认证通过
							</c:if>
							<c:if test="${fundSide.authStatus eq '3'}">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenheFalse_icon.png" />认证失败
							</c:if>
							<div class="btn-modify mt30 lookAuth" uid="${fundSide.id}" authStatus="${fundSide.authStatus}" utype="2">查看</div>
							</div>
						</c:if>
				</li>
				<li class="businessList">
					<img src="${app.staticResourceUrl}/ybl4.0/resources/images/my/hxqyrz_icon.png" <c:if test="${empty coreEnterprise or coreEnterprise.authStatus eq '3'}">id ="coreEnterpriseAuth" class="handtype" </c:if> />
						<p class="rztitle" >核心企业认证</p>
						<c:if test="${not empty coreEnterprise}">
							<div class="rz-bottom">
							<c:if test="${coreEnterprise.authStatus eq '1' }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghe_icon2.png" />审核中
							</c:if>
							<c:if test="${coreEnterprise.authStatus > 1 }">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />审核完成 
							</c:if>
							<c:if test="${coreEnterprise.authStatus eq '2'}">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenghePass_icon.png" />认证通过
							</c:if>
							<c:if test="${coreEnterprise.authStatus eq '3'}">
								<div class="linebox"></div>
								<img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/my/shenheFalse_icon.png" />认证失败
							</c:if>
							<div class="btn-modify mt30 lookAuth" uid="${coreEnterprise.id}" authStatus="${coreEnterprise.authStatus}" utype="3">查看</div>
							</div>
						</c:if>
				</li>
			</ul>
		</div>
        </c:otherwise>
    </c:choose>
	
<script type="text/javascript">		
		$(function(){
			/* //业务认证类型1-融资方2-资金方3-核心企业 */
			$("#financingPartyAuth").click(function(){
				var type = 1 ;
				window.location.href = "/serviceAuthenticationController/serviceAuth?type="+type;
			});
			$("#fundSideAuth").click(function(){
				var type = 2 ;
				window.location.href = "/serviceAuthenticationController/serviceAuth?type="+type;
			});
			$("#coreEnterpriseAuth").click(function(){
				var type = 3 ;
				window.location.href = "/serviceAuthenticationController/serviceAuth?type="+type;
			});
			//查看按钮
			$(".lookAuth").click(function(){
				var id = $(this).attr("uid");
				var authStatus = $(this).attr("authStatus");
				var type = $(this).attr("utype");
				window.location.href = "/serviceAuthenticationController/serviceAuth?type="+type+"&id="+id+"&authStatus="+authStatus;
			});
		});
</script>
</body>
</html>