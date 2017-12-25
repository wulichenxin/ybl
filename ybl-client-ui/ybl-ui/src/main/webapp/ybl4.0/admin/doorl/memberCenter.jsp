<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta charset="UTF-8">
		<title>账户中心</title>
	</head>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/doorl/common/top-center.jsp" />
		<!--top end -->

		<div class="person clearfix">
			<div class="per_l fl">
				<div class="userinfo">
					<img class="userimg1" src="/ybl4.0/resources/images/my/photo_icon.png" />
					<p class="usern">${user_session.userName }</p>
					<div class="imgbox">
						<c:choose>
						   <c:when test="${user_session.attribute1 eq 'adopt' }">  
						       <img src="/ybl4.0/resources/images/my/sfrzPass_icon.png" />     
						   </c:when>
						   <c:otherwise> 
						   		<img src="/ybl4.0/resources/images/my/sfrz_icon.png" /> 
						   </c:otherwise>
						</c:choose>
						<c:choose>
						   <c:when test="${user_session.attribute2 eq 'adopt' }">  
						       <img src="/ybl4.0/resources/images/my/ywrzPass_icon.png" />     
						   </c:when>
						   <c:otherwise> 
						   		<img src="/ybl4.0/resources/images/my/ywrz_icon.png" /> 
						   </c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="usermenu">
					<ul>
						<li class="userlist">
							<span class="listcur"><img src="/ybl4.0/resources/images/my/list_icon_choose.png" />我的账户</span>
							<ul style="display: block;">
								<li class="mylist">
									<a href="javascript:void(0);" id="memberInfo">账户信息</a>
								</li>	
								<li class="mylist">
									<a href="javascript:void(0);" id="cardAuth">身份认证</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="serviceAuth">业务认证</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="myMessage">我的消息</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div class="per_r fl">

				<div class="myAccount myAccount1">
					<iframe id="iframe1" onload="resizeIndexIFrame2(this)" src="/ybl4.0/admin/doorl/accountInfo/accountInfo.jsp" width="100%" height="1000px"></iframe>

				</div>
				
				</div>

		<div class="mb80"></div>

		<script type="text/javascript">
		
		$(function(){
			//账户信息
			$("#memberInfo").click(function(){
				$("#iframe1").attr("src","/accountInfoController/accountInfo");
			});
			//身份认证
			$("#cardAuth").click(function(){
				$("#iframe1").attr("src","/accountInfoController/authLook.htm");
			});
			//业务认证
			$("#serviceAuth").click(function(){
				$("#iframe1").attr("src","/serviceAuthenticationController/authHtml");
			});
			//我的消息
			$("#myMessage").click(function(){
				$("#iframe1").attr("src","/myMessageV4Controller/messageList.htm");
			});
			
		})	
		</script>
	</body>

</html>