<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title>${app.appName }</title>
<meta name="Keywords" content="${app.appName }">
<meta name="Description" content="${app.appName }">
<meta name="Copyright" content="${app.appName }" />
<link href="/fw/resources/css/login.css" rel="stylesheet" type="text/css"/>
<link href="/fw/resources/css/login_banner.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="/fw/resources/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="/fw/resources/js/common.js"></script>

</head>
<body>
<div class="zc_page">
<div class="banner">
    <div class="flashBox">
        <ul>           
            <li class="banner-b">
                <div class="">
                    <div class="warp wxBanner">
                        <div class="b-1 zc_tittle"><span>已有账户</span><a href="/index.jsp">登录</a></div>
                        <img src="/fw/resources/images/b-2.png" class="b-2">
                        <img src="/fw/resources/images/zc_banner_pic_01.png" class="b-s b-s-1">
                        <img src="/fw/resources/images/zc_banner_pic_02.png" class="b-s b-s-2">
                        <img src="/fw/resources/images/zc_banner_pic_03.png" class="b-s b-s-3">
                        <img src="/fw/resources/images/zc_banner_pic_04.png" class="b-s b-s-4">
                        <img src="/fw/resources/images/zc_banner_pic_05.png" class="b-s b-s-5">
                        <img src="/fw/resources/images/zc_banner_pic_06.png" class="b-s b-s-6">
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
     <form action="/registerController/register" id="frm" method="post">
     <div class="zclogin">
         <ul>
         	<li><div class="zc_input"><i id="userNameText"></i><span><b class="l_ico1"></b></span><input id="userName" name="userName" placeholder="请输入用户名" type="text" class="zc_text" maxlength="16" onblur="checkUserName()"/></div></li>
         	<li><div class="zc_input"><i id="passwordText"></i><span><b class="l_ico2"></b></span><input  id="password" name="password"  placeholder="请输账户密码" type="password" class="zc_text"/></div></li> 
            <li><div class="zc_input"><i id="password2Text"></i><span><b class="l_ico2"></b></span><input  id="password2" name="password2" placeholder="请输确认密码" type="password" class="zc_text"/></div></li> 
            <li><div class="zc_input1 fl"><i id="isValidText"></i><span><b class="l_ico3"></b></span><input id="isValid" name="isValid" placeholder="请输入验证码" type="text" class="zc_text1" onblur="checkValid()"/></div><div class="yzm fl">
            	<img id="validCodeImg" src="/jcaptcha" style="cursor:pointer" onclick="this.src='/jcaptcha?_timestamp=' + new Date().getTime()" />
            </div><div class="shuaxing"><a id="refreshBtn">刷新</a></div></li>
            <div class="clear"></div>
            <li><input type="checkbox" name="CheckboxXieyi" id="CheckboxXieyi" />&nbsp;&nbsp;我同意并阅读<a class="yellow">《国融信用户协议》</a>           
            </li> 
            <li><div class="zc_button"><a id="register">立即注册</a></div></li>    
                   
                    
         </ul>
         <div class="clear"></div>     
     </div>  
    </form> 
</div>
<div class="bq">${app.copyright }</div>
</div>
</div>

<script>
	var userExist=0;
	$(function() {
		$("#refreshBtn").click(function() {
			$("#validCodeImg").click();
		});
		
		//注册
		$("#register").click(function() {
			$("#userNameText").html("");
			$("#passwordText").html("");
			$("#password2Text").html("");
			$("#CheckboxXieyi").html("");
			
			var userName = $("#userName").val();
			var password = $("#password").val();
			var password2 = $("#password2").val(); 
			var isValid = $("#isValid").val();
			if(userName==""){
				$("#userNameText").html("用户名不能为空");
				return;
			}if(password==""){
				$("#passwordText").html("密码不能为空");
				return;
			}if(password2==""){
				$("#password2Text").html("确认密码不能为空");
				return;
			}
			if(password!=password2){
				$("#password2Text").html("密码和确认密码不一致");
				return;
			}
			if(isValid==""){
				$("#isValidText").html("验证码不能为空");
				return;
			}
			
			if($("#CheckboxXieyi").attr("checked")!="checked"){
				alert("您必须同意注册协议");
				return;
			}
			
			subfrm(userName,password,isValid);
		});
		
		checkValid = function(){
			var valid = $("#isValid").val();
			$.ajax({
		        url: '/registerController/checkValid', 
		        data:{valid:valid},
		        type: "post", 
		        async: true ,
		        dataType: "json",
		        success: function (data, textStatus, XMLHttpRequest) {
		        	if(data.responseTypeCode!='success'){
		        		$("#isValidText").html("验证码错误");
		        		$("#validCodeImg").click();
		        	}else{
		        		$("#isValidText").html("");
		        	}
		        }
		    });	
		}
		checkUserName = function(){	
			var userName = $("#userName").val();
			$.ajax({
		        url: '/userController/queryByUserName', 
		        data:{userName:userName},
		        type: "post", 
		        async: true ,
		        dataType: "json",
		        success: function (data, textStatus, XMLHttpRequest) {
		        	console.log(data.length);
		        	if(data.length != 0) {
						$("#userNameText").html("用户名已存在");
						userExist=1;//如果已经存在 
		        		return;
		        	}else{
						$("#userNameText").html("");
		        		userExist=0;
		        	}
		        	
		        }
		    });	
		}
		
		subfrm = function(userName,password,isValid){	
			if(userExist==1){
				$("#userNameText").html("用户名已存在");
				return;
			}
			$.ajax({
		        url: '/registerController/register', 
		        data:{userName:userName,password:password,isValid:isValid},
		        type: "post", 
		        async: true ,
		        dataType: "json",
		        success: function (data, textStatus, XMLHttpRequest) {
		        	if(data.responseTypeCode=='success'){//注册成功
		        		$("#isValidText").html(data.info);
		        		window.location.href='/fw/admin/common/index.jsp';
		        	}else{
		        		$("#isValidText").html(data.info);
		        	}
		        }
		    });	
		}
		
	});
</script>

</body>

</html>
