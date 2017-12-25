<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="UTF-8">
<title>云保理登录</title>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/doorl/login.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/doorl/sha256.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/page.css">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js"></script>
</head>

	<body class="regbg">

		<div class="ybl-head border-b">
			<div class="w1200 clearfix">
				<div class="fl">
					<img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-86726640
					<!-- 15814435455 --><!-- <span class="notice-sp"><img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span> -->
				</div>
				<div class="fr">
					<!-- <img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span> -->
					欢迎您！<span class="username"></span><a class="dropOut" href="/loginV4Controller/index.htm">返回首页</a>
				</div>
			</div>
		</div>
		<div class="reghead">
			<div class="w1200">
				<img src="/ybl4.0/resources/images/login/logo_red.png" /><span class="regtitle">会员登录</span>
			</div>
		</div>
		
		
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur" value="4">访客</li>	
				<li class="formli" value="1">融资方</li>
				<li class="formli" value="2">资金方</li>
				<li class="formli" value="3">核心企业</li>
			</ul>
		</div>
		<div class="logonCont clearfix">
			<p class="zctitle fr">还没有账号？<a href="/loginV4Controller/toRegister.htm" class="color-yellow">立即注册</a></p>
			<div class="login_form clearfix">
				
				<ul class="login_ul fl pt60">
					<li></li>
					<li class="loginlist">账号：<input type="text" placeholder="请输入手机号" id='username'/><img class="usernameimg" src="/ybl4.0/resources/images/login/tel_icon.png" /></li>
					<li class="loginlist">密码：<input type="password" placeholder="请输入登录密码" class="pwd" id='password' /><img class="userpsdimg" src="/ybl4.0/resources/images/login/closeEye_icon.png" /></li>
					<li class="loginlist ft12"><span class="remsp"></span><a class="color-yellow fr" href="/loginV4Controller/toForgetPassword.htm">忘记密码?</a></li>
					<li class="loginlist"><a class="login_btn1" href="javascript:void(0);" id="ybl_admin_member_login_btn">登录</a></li>
					<li class="loginlist"><span class="remsp color-red2"><!-- <img src="/ybl4.0/resources/images/login/tips_icon.png" />业务认证审核中，请选择访客登录！</span></span> --></li>
				</ul>
				<div class="login_left fl">
					<img class="rightimg" src="/ybl4.0/resources/images/login/login_img.png" />
				</div>
			</div>
		</div>
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
