<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	});
</script>
</head>
<body>
    <div class="v2_login_bg">
	<div >
		<%@ include file="/ybl/v2/admin/common/topV4.jsp" %> 
		<!---->
			<div class="v2_login">
				<h1>登录</h1>
				<ul>
					<li><div class="v2_login_input"><input placeholder="请输入手机号码" type="text" class="v2_login_text" id='username'/></div></li>
					<li><div class="v2_login_input"><input placeholder="请输入登录密码" type="password" class="v2_login_text" id='password'/></div></li>
					<li><div class="v2_login_input"><input placeholder="请输入验证码" type="text" class="v2_login_text w170" id="phone_vcode"/><div class="v2_yzm"><img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
											 title="看不清，点击换一张" style="cursor: pointer;"/></div></div></li>
					<li><div class="v2_login_but"><a id="ybl_admin_member_login_btn"><spring:message
										code="sys.v2.client.login" /></a>
										<!-- 登陆按钮  -->
								 <a id="ybl_admin_member_login_btn_ing" class="zc_button none1">
									<spring:message code="sys.client.logining" />
								</a></div></li>
					<li>
						<div class="v2_forget" style="float:left"><a class="fl yellow f12" href="/registerController/register.htm">快速注册></a></div>	
						<div class="v2_forget"><a href="/loginV4Controller/toForgetPassword.htm">忘记密码？</a></div>
					</li>
				</ul>
			</div>
		
		
	</div>	
</div>

    <%@include file="/ybl/admin/common/bottomV2.jsp" %> 
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/v2/js/login.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/v2/js/sha256.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
	<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>  
    <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
</body>
</html>
<%
    if(null != request.getSession())
    {
	request.getSession().invalidate();//清空session 
    }
    if(null != request.getCookies())
    {
    	Cookie[] cookies = request.getCookies();
    	if(cookies.length > 0)
    	{
		    Cookie cookie = request.getCookies()[0];//获取cookie 
		    cookie.setMaxAge(0);//让cookie过期 ； 
    	}
    }
%>
