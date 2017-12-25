<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js"></script>
	<!-- 提示框 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>	
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.css">
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/page.css">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>	
<script type="text/javascript">
	$(function() {
		$("#ybl_admin_check_telephone_btn").click(function(){
			if(!$("#phone").validationEngine('validate')) {
	 			return;
	 		}
			if(!$("#phone_smscode").validationEngine('validate')) {
	 			return;
	 		}
			var phone = $("#phone").val();
			if(phone == '') {
				alert("请输入手机号码！");
				return;
			}
			checkValidCode(phone,$("#phone_smscode").val(), "sms");
		});
		$("#ybl_admin_reset_password_btn").click(function(){
			if(!$("#password").validationEngine('validate')) {
	 			return;
	 		}
			if(!$("#nextpassword").validationEngine('validate')) {
	 			return;
	 		}
			var type = "sms";
			var target = $("#phone").val();
			var password = $("#password").val();
			var nextpasswore = $("#nextpassword").val();
			if(password=='' || nextpasswore=='' || password != nextpasswore) {
				alert("确认密码不一致！");
			}
			$.ajax({
				url:"/registerController/findResetPassword",
				type:"POST",
				data:{
					target : target,
					password : $("#password").val(),
					type : type
				},
				success:function(resp){
					if(resp.responseTypeCode=="success"){
						alert("保存成功");
						$('.foundpwd').hide();
						$('.foundpwd3').show();
						setTimeout(function(){
							window.location="/ybl4.0/admin/doorl/login.jsp";},5000);   //5秒后跳转至登录页面
					}else{
						alert(resp.info);
					}
				},
				error:function(){
					alert("系统繁忙，请稍后再试");
				}
			})
			
		});
		$("#ybl_admin_register_email_btn").click(function(){
			if(!$("#email").validationEngine('validate')) {
				alert("邮箱信息有误");
				return;
			}
			if(!$("#email_code").validationEngine('validate')) {
				return;
			}
			checkValidCode($("#email").val(),$("#email_code").val(), "email");
		});
		$("#flush").click(function(){
			$("#pwd_img_phone").click();
		});
	});
	
	//找回密码发送短信
	function sendSmsCode(obj){
		var phone = $("#phone").val();
		if(phone == '') {
			alert("请输入手机号码！");
			return;
		}
		$.ajax({
			url:"/validCodeController/sendSmsCode",
			type:"POST",
			data:{
				phone : $("#phone").val(),
				type  : "findpwd"
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					alert("短信验证码发送成功");
					sendMessage(obj);
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		});
	}
	//短信验证码校验
	function checkValidCode(target, code, type){
		$("#type").val(type);
		$.ajax({
			url:"/registerController/checkValidCode",
			type:"POST",
			data:{
				target : target,
				code : code,
				type : type
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					$('.foundpwd').hide();
					$('.foundpwd2').show();
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		})
	}
	
	//验证码发送倒计时
	var InterValObj;//timer变量，控制时间
	var count = 120; //间隔函数，1秒执行一次
	var curEmailCount;//当前秒数
	var curSmsCount;//当前秒数

	function sendMessage(obj){
		if(obj.id == "emailCodeBtn"){
			curEmailCount = count;
		    $(obj).attr("disabled", "true");
		    $(obj).text(curEmailCount + "秒后重新发送");
		}
		if(obj.id == "smsCodeBtn"){
			curSmsCount = count;
		    $(obj).attr("disabled", "true");
		    $(obj).text(curSmsCount + "秒后重新发送");
		}
// 		curCount = count;
		//设置button效果，开始计时
	    InterValObj = window.setInterval(function(){
	    	SetRemainTime(obj);
	    }, 1000); //启动计时器，1秒执行一次
	}

	function SetRemainTime(object) {
		if(object.id == "emailCodeBtn"){
			if (curEmailCount == 0) {                
		        window.clearInterval(InterValObj);//停止计时器
		        $(object).removeAttr("disabled");//启用按钮
		        $(object).text("获取验证码");
		    }
		    else {
		    	curEmailCount--;
		        $(object).text(curEmailCount + "秒后重新发送");
		    }
		}
		if(object.id == "smsCodeBtn"){
			if (curSmsCount == 0) {                
		        window.clearInterval(InterValObj);//停止计时器
		        $(object).removeAttr("disabled");//启用按钮
		        $(object).text("获取验证码");
		    }
		    else {
		    	curSmsCount--;
		        $(object).text(curSmsCount + "秒后重新发送");
		    }
		}
	    
	}
	
	</script>
</head>
<body>
	<%-- <div class="gateway h76">
	<div class="v2_top_con">
	<%@ include file="/ybl4.0/admin/doorl/common/top-index.jsp" %> 
		<!---->
	</div>	
</div>

<!---->


	<div class="v2_mm_box">
	<div class="v2_mm_con">
		<h1>找回密码</h1>
    	<div class="v2_mmtext content">
           	<ul>
            	<li><span>手机号：</span><input placeholder="请输入手机号" type="text" class="v2_mm_text validate[required,custom[phone]]" id="phone"/></li>
				<li><span>验证码：</span><input placeholder="请输入验证码" type="text" class="v2_mm_text1 mr20 w170 validate[required,minSize[4],maxSize[4]]" id="phone_vcode"/><div class="yzm fl"><img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
											 title="看不清，点击换一张" style="cursor: pointer;"/></div><div class="v2_shuaxing"><a id="flush">刷新</a></div></li>
                <li><span>手机验证码：</span><input placeholder="手机验证码" type="text" class="v2_mm_text1 fl mr20 validate[required,minSize[6],maxSize[6]]" id="phone_smscode"/><div class="send_yzm"><a id="smsCodeBtn" onclick="sendSmsCode(this);">获取验证码</a></div></li>
                <li><div class="v2_next_but"><a id="ybl_admin_check_telephone_btn" href="javascript:;">确定</a><i> </i></div></li> 
            </ul>
        </div>
        <div class="mmtext content" style="display: none;">
						<ul>
							<input type="hidden" id="type" value="" />
							<li><span>新密码：</span><input placeholder="请输入新密码"
								type="password" class="mm_text validate[required,minSize[6],maxSize[20]]" id="password"/></li>
							<li><span>确认密码：</span><input placeholder="请输入确认密码"
								type="password" class="mm_text validate[required,minSize[6],maxSize[20],equals[password]]" id="nextpassword"/></li>
							<li><div class="next_but">
									<sun:button id="ybl_admin_reset_password_btn" tag='a'  value="提交" /><!-- 下一步  -->
								</div></li>
						</ul>
		</div>
	</div>
</div>
<%@ include file="/ybl/v2/admin/common/bottom.jsp" %> 
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script> --%>

		<div class="ybl-head border-b">
			<div class="w1200 clearfix">
				<div class="fl">
					欢迎您！<span class="username"><!-- 15814435455 --></span><span class="notice-sp"><img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span>
				</div>
				<div class="fr">
					<!-- <img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span> -->
					<a class="dropOut" href="/loginV4Controller/index.htm">返回首页</a><img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-12345678
				</div>
			</div>
		</div>
		<div class="reghead">
			<div class="w1200">
				<img src="/ybl4.0/resources/images/login/logo_red.png" /><span class="regtitle">会员注册 - 找回密码</span>
			</div>
		</div>
		
		
		
		<div class="logonCont clearfix">
			<ul class="clearfix stepul">
				<li class="steplist color-yellow">1、身份验证</li>
				<li class="steplist"><img src="/ybl4.0/resources/images/login/login_arr_icon.png" /></li>
				<li class="steplist color-blue">2、重置密码</li>
				<li class="steplist"><img src="/ybl4.0/resources/images/login/login_arr_icon.png" /></li>
				<li class="steplist">3、完成</li>
			</ul>
			
			<div class="foundpwd foundpwd1">
				
				<ul class="foundpwdul">
					<li>账户名：<input type="text" placeholder="请输入手机号" id="phone" class="validate[custom[phone]]" /></li>
					<li>验证码：<input class="w150 mr20" type="text" placeholder="请输入手机验证码" id="phone_smscode"/ class="validate[custom[number]]"><div class="getyzm" style="font-size: 12px;" id="smsCodeBtn" onclick="sendSmsCode(this);">获取验证码</div></li>
					<li class="clearfix mt30"><div class="nextbtn nextbtn1 getyzm" id="ybl_admin_check_telephone_btn">下一步</div></li>
				</ul>
				
			</div>
			<div class="foundpwd foundpwd2">
				
				<ul class="foundpwdul">
					<li>新密码：<input type="password" placeholder="请输入密码"  id="password" class="validate[required]"/></li>
					<li>确认密码：<input type="password" placeholder="请再次确认密码" id="nextpassword" class="validate[required]"/></li>
					<li class="clearfix mt30"><div class="nextbtn nextbtn2 getyzm" id="ybl_admin_reset_password_btn">下一步</div></li>
				</ul>
				
			</div>
			
			<div class="foundpwd foundpwd3">
				
				<ul class="foundpwdul">
					<li><p class="bigfont"><img src="/ybl4.0/resources/images/agree_icon.png"/>恭喜您，密码重置成功！</p></li>
					<li>5s后自动返回登录<a class="ml20 color-blue" href="/ybl4.0/admin/doorl/login.jsp">返回>></a></li>
				</ul>
				
			</div>
		</div>
</body>
</html>

