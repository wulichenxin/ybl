<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>云保理注册</title>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/page.css">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>
<script type="text/javascript">
$(function(){
	$("#ybl_admin_member_register_save_btn").click(function(){
 		var vCode = $("#validateCode").val();
 		var userName=$("#userName").val();
 		var password=$("#password").val();
 		var nextpassword=$("#nextPassword").val();
 		if(userName=='') {
 			alert("用户名不能为空！");
 			return;
 		}
 		if(password=='') {
 			alert("密码不能为空！");
 			return;
 		}
 		if(nextpassword=='') {
 			alert("确认密码不能为空！");
 			return;
 		}
 		if(nextpassword != password) {
 			alert("密码和确认密码不一致！");
 			return;
 		}
 		if(vCode=='') {
 			alert("请输入手机验证码！");
 			return;
 		}
 		if(!$("#CheckboxGroup1_0").get(0).checked){
 			alert("请先勾选用户协议");
 			return;
 		}
		$.ajax({
			url:'/registerController/doRegister',
			dataType:'json',
			type:'post',
			data:{
				userName : userName,
				password : password,
				vCode     : vCode
			},
			success:function(value){
				if(value.responseTypeCode=='success'){
					alert(value.info,function(){
						callback();
					});
				}else{
					alert(value.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		});
	});
	
	callback = function(){
		location.href="/loginV4Controller/login.htm" ;
	}
})

//获取短信验证码
function sendSmsCode(){
	var userName = $("#userName").val();
	var password = $("#password").val();
	var nextPassword = $("#nextPassword").val();
	if(userName=='') {
		alert("手机号不能为空！");
		return;
	}
	if(password=='') {
		alert("密码不能为空！");
		return;
	}
	if(password.length < 6)
	{
	 alert("密码不能少于6位");
	 return;
	}
	if(nextPassword=='' || password!=nextPassword){
		alert("确认密码不一致！");
		return;
	}
	$.ajax({
		url:"/validCodeController/sendSmsCode",
		type:"POST",
		data:{
			phone : $("#userName").val(),
			/* vCode : $("#imageCode").val(), */
			type  : "regist"
		},
		success:function(resp){
			if(resp.responseTypeCode=="success"){
				alert("短信验证码发送成功");
				sendMessage();
			}else{
				alert(resp.info);
				$("#pwd_img_phone").click();
			}
		},
		error:function(){
			alert("系统繁忙，请稍后再试");
		}
	});
}

//验证码发送倒计时
var InterValObj;//timer变量，控制时间
var count = 120; //间隔函数，1秒执行一次
var curCount;//当前秒数

function sendMessage(){
	curCount = count;
	//设置button效果，开始计时
    $("#smsCodeBtn").attr("disabled", "true");
    $("#smsCodeBtn").text(curCount + "秒后重新发送");
    InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
}

function SetRemainTime() {
    if (curCount == 0) {                
        window.clearInterval(InterValObj);//停止计时器
        $("#smsCodeBtn").removeAttr("disabled");//启用按钮
        $("#smsCodeBtn").text("获取验证码");
    }
    else {
        curCount--;
        $("#smsCodeBtn").text(curCount + "秒后重新发送");
    }
}



</script>
</head>
<body>
	<div class="ybl-head border-b">
		<div class="w1200 clearfix">
			<div class="fl">
				<img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-86726640
				<!-- <img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span> -->
			</div>
			<div class="fr">
				<!-- <img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span> -->
				欢迎您！<span class="username"></span><span class="notice-sp"><a class="dropOut" href="/loginV4Controller/index.htm">返回首页</a>
			</div>
		</div>
	</div>
	<div class="reghead">
		<div class="w1200">
			<img src="/ybl4.0/resources/images/login/logo_red.png" /><span class="regtitle">会员注册</span>
		</div>
	</div>
	
	<div class="logonCont clearfix">
		<p class="zctitle fr">已有账号，请<a href="/loginV4Controller/toLogin.htm" class="color-yellow">登录</a></p>
		<div class="login_form clearfix">
			
			<ul class="login_ul fl">
				<li><input type="text" placeholder="请输入手机号"  name="userName" id="userName"/><img class="usernameimg" src="/ybl4.0/resources/images/login/tel_icon.png" /></li>
				<li><input type="password" placeholder="请输入登录密码" class="pwd" name="password" id="password"/><img class="userpsdimg" src="/ybl4.0/resources/images/login/closeEye_icon.png" /></li>
				<li><input type="password" placeholder="请确认登录密码" class="pwd" name="nextPassword" id="nextPassword"/><img class="userpsdimg" src="/ybl4.0/resources/images/login/closeEye_icon.png" /></li>
				<li></li>
				<li><input type="text" placeholder="请输入手机验证码"  id="validateCode" /><div class="getyzm"><a style="font-size: 12px;" id="smsCodeBtn" onclick="sendSmsCode();">获取验证码</a></div></li>
				<li class="yqm" style="display: none;"><input type="text" placeholder="请输入邀请码" /></li>
				<li class="ft14"><input type="checkbox" id="CheckboxGroup1_0" /><label for="che1">我已阅读并同意<a class="color-yellow" href="javascript:void(0)">《云保理注册协议》</a></label></li>
				<li><a class="login_btn1" style="cursor:pointer" id="ybl_admin_member_register_save_btn">注册</a></li>
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
