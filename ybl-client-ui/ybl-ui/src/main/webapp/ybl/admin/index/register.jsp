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
<title>云保理注册</title>
<link href="${app.staticResourceUrl}/ybl/resources/css/login.css" rel="stylesheet" type="text/css"/>
<link href="${app.staticResourceUrl}/ybl/resources/css/login_banner.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/common.js"></script>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
	
<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/index/register.js"></script> --%>

<!-- 提示框 -->
<%-- <script language='javascript'
	src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.9.1.js'></script> --%>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<script type="text/javascript">
$(function(){
	window.alert = function(msg) {
		window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
	}
	
	window.alert = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	}
	
	$("#ybl_admin_member_register_save_btn").click(function(){
 		if(!$("#userName").validationEngine('validate')) {
 			return;
 		}
 		if(!$("#password").validationEngine('validate')) {
 			return;
 		}
 		if(!$("#nextPassword").validationEngine('validate')) {
 			return;
 		}
 		/* if(!$("#telephone").validationEngine('validate')) {
 			return;
 		} */
 		if(!$("#imageCode").validationEngine('validate')) {
 			return;
 		}
 		if(!$("#validateCode").validationEngine('validate')) {
 			return;
 		}
 		if(!$("#CheckboxGroup1_0").get(0).checked){
 			alert("请先勾选用户协议");
 			return;
 		}
 		var userName=$("#userName").val();
 		console.log(userName);
 		var password=$("#password").val();
 		var nextpassword=$("#nextPassword").val();
 		/* var telephone=$("#telephone").val(); */
		$.ajax({
			url:'/registerController/doRegister',
			dataType:'json',
			type:'post',
			data:{
				userName : userName,
				password : password,
				/* telephone : telephone, */
				vCode     : $("#validateCode").val(),
			},
			success:function(value){
				if(value.responseTypeCode=='success'){
					alert(value.info,callback)
				}else{
					alert(value.info) 
					$("#pwd_img_phone").click();
					$("#imageCode").val("");
					$("#validateCode").val("");
				}
			}
		});
	});
	
	callback = function(){
		location.href="/indexController/login.htm" ;
	}
})
//获取短信验证码
function sendSmsCode(){
	if(!$("#userName").validationEngine('validate')) {
		return;
	}
	if(!$("#password").validationEngine('validate')) {
		return;
	}
	if(!$("#nextPassword").validationEngine('validate')){
		return;
	}
	/* if(!$("#telephone").validationEngine('validate')) {
		return;
	}  */
	if(!$("#imageCode").validationEngine('validate')) {
		return;
	}
	$.ajax({
		url:"/validCodeController/sendSmsCode",
		type:"POST",
		data:{
			phone : $("#userName").val(),
			vCode : $("#imageCode").val(),
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
<div class="zc_page">
<div class="banner">
    <div class="flashBox">
        <ul>           
            <li class="banner-b">
                <div class="">
                    <div class="warp wxBanner">
                        <div class="b-1 zc_tittle">
                        	<span>已有账户</span>
                        	<a href="${app.staticResourceUrl}/ybl/v2/admin/index/login.jsp">登录</a>
                        </div>
                        <img src="${app.staticResourceUrl}/ybl/resources/images/b-2.png" class="b-2">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_01.png" class="b-s b-s-1">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_02.png" class="b-s b-s-2">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_03.png" class="b-s b-s-3">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_04.png" class="b-s b-s-4">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_05.png" class="b-s b-s-5">
                        <img src="${app.staticResourceUrl}/ybl/resources/images/zc_banner_pic_06.png" class="b-s b-s-6">
                        <!--<img src="images/b-y-1.png" class="b-y b-y-1">
                        <img src="images/b-y-2.png" class="b-y b-y-2">
                        <img src="images/b-y-3.png" class="b-y b-y-3">-->
                       
                    </div>
                </div>
            </li>		
            
        </ul>

        <ol>
            <li class=""></li>
        </ol>
       
    </div>
</div>


   
<div class="zc_box">
<div class="zc_box_con">
	<div class="zc_yy"></div>
     <div class="l_tittle">
        <h1>企业注册</h1>
     </div>
     <div class="clear"></div>
     <div class="zclogin">
     <form id="registerForm" action="">
         <ul>
         	<li><div class="zc_input"><i id="userNameaTip"></i><span><b class="l_ico1"></b></span><input placeholder="请输入手机号码" type="text" class="zc_text validate[required,ajax[userName]]" name="userName" id="userName"/></div></li>
         	<li><div class="zc_input"><i id="pswTip"></i><span><b class="l_ico2"></b></span><input placeholder="请输入账户密码" type="password" class="zc_text validate[required,minSize[6],maxSize[20]]" name="password" id="password"/></div></li> 
            <li><div class="zc_input"><i id="2pswTip"></i><span><b class="l_ico2"></b></span><input placeholder="请确认账户密码" type="password" class="zc_text validate[required,minSize[6],maxSize[20],equals[password]]" name="nextPassword" id="nextPassword"/></div></li> 
            <!-- <li><div class="zc_input"><i id="phoneTip"></i><span><b class="l_ico4"></b></span><input placeholder="请输入手机号码" type="text" class="zc_text validate[required,custom[mobilePhone],ajax[validateMobile]]"  name="telephone" id="telephone"/></div></li> -->
            <li>
            	<div class="oh">
	            <div class="zc_input1 fl">
	            	<i id="verifyCodeTip"></i>
	            	<span><b class="l_ico3"></b></span>
	            	<input id="imageCode" placeholder="请输入验证码" type="text" class="zc_text1 validate[required,minSize[4],maxSize[4]]"/>
	            </div>
	            <div class="yzm fl">
	            	<img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"title="看不清，点击换一张" style="cursor: pointer;"/>
<%-- 	            	<img src="${app.staticResourceUrl}/ybl/resources/images/yzm.png" /> --%>
	            </div>
	            </div>
            </li>
            <li class="clear">
            	<div class="oh">
	            <div class="zc_input1 fl">
	            	<i id="smsCodeTip"></i>
	            	<span><b class="l_ico3"></b></span>
	            	<input id="validateCode" placeholder="请输入短信验证码" type="text" class="zc_text1 validate[required,minSize[6],maxSize[6]]"/>
	            </div>
	            <div class="phoneyzm fl">
					<a id="smsCodeBtn" onclick="sendSmsCode();">获取验证码</a>
				</div>
				</div>
            </li>
            <div class="clear"></div>
            <li><input type="checkbox" name="CheckboxGroup1" value="复选框" id="CheckboxGroup1_0" />&nbsp;&nbsp;我同意并阅读<a class="yellow">《国融信用户协议》</a>           
            </li> 
            <li>
            	<div class="zc_button">
            		<a id="ybl_admin_member_register_save_btn"  class="zc_button">立即注册</a>
	            	<%-- <sun:button id="ybl_admin_member_register_save_btn" tag='a' clazz="zc_button" value="立即注册" /> --%><!-- 注册保存按钮  -->                           
	            </div>
            </li>    
                   
                    
         </ul>
         </form>
         <div class="clear"></div>     
     </div>      
</div>
</div>
</div>
<!-- 底部jsp -->
<jsp:include page="../common/bottom.jsp"/>
<!-- 底部jsp -->
</body>
</html>
