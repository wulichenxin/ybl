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
		
    <%@ include file="/ybl/v2/admin/common/link.jsp" %> 
	<title>忘记密码</title>

	<link href="${app.staticResourceUrl}/ybl/resources/css/vip_page.css" rel="stylesheet" type="text/css" />
	<link href="${app.staticResourceUrl}/ybl/resources/css/login.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/yuangong.js"></script>
	<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
	<!-- 提示框 -->
	<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
		//tab切换
		$('.tab_tt .bakmm').click(function() {
			var index = $(this).index();
			$('.content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
			$('.tab_tt .bakmm').eq(index).addClass('now').siblings().removeClass('now');
		});
		//tab切换
		$('.content dl dd').click(function() {var index = $(this).index();
			if(index == 0) {
				$("#pwd_img_phone").attr("src", '/jcaptcha?id='+new Date());
			} else {
				$("#pwd_img_email").attr("src", '/jcaptcha?id='+new Date());
			}
			$('.zcontent').eq(index).show().addClass('now').siblings().removeClass('now').hide();
			$('.content dl dd').eq(index).addClass('znow').siblings().removeClass('znow');
		});
		$("#ybl_admin_check_telephone_btn").click(function(){
			if(!$("#phone").validationEngine('validate')) {
				alert("手机号输入有误");
				return;
			}
			if(!$("#phone_smscode").validationEngine('validate')) {
				alert("手机验证码不正确");
				return;
			}
			checkValidCode($("#phone").val(),$("#phone_smscode").val(), "sms");
		});
		$("#ybl_admin_reset_password_btn").click(function(){
			var type = $("#type").val();
			var target = $("#phone").val();
			if("sms" == type) {
				if(!$("#phone").validationEngine('validate')) {
					alert("请输入正确的手机号");
					return;
				}
			} else {
				if(!$("#email").validationEngine('validate')) {
					alert("请输入正确的邮箱");
					return;
				}
				target = $("#email").val();
			}
			if(!$("#password").validationEngine('validate')) {
				return;
			}
			if(!$("#nextpassword").validationEngine('validate')) {
				return;
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
						alert("保存成功",function(){
							location.href="${app.staticResourceUrl}/indexController/login.htm" ;
						});
						
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
		if(!$("#phone").validationEngine('validate')) {
			return;
		}
		if(!$("#phone_vcode").validationEngine('validate')) {
			return;
		}
		$.ajax({
			url:"/validCodeController/sendSmsCode",
			type:"POST",
			data:{
				phone : $("#phone").val(),
				type  : "findpwd",
				vCode : $("#phone_vcode").val()
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					/* var index = $('.bakmm').index();
					$('.tab_tt .bakmm').eq(index).addClass('now').siblings().removeClass('now'); */
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
					$('.content').eq(1).show().addClass('now').siblings().removeClass('now').hide();
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		})
	}
	//发送找回密码邮件
	function sendEmailCode(obj){
		if(!$("#email").validationEngine('validate')) {
			return;
		}
		if(!$("#send_email_code").validationEngine('validate')) {
			return;
		}
		$.ajax({
			url:"/validCodeController/sendEmailCode",
			type:"POST",
			data:{
				email : $("#email").val(),
				type  : "findpwd",
				vCode : $("#send_email_code").val()
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					alert("邮箱验证码发送成功");
					sendMessage(obj);
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
	<div class="gateway h76">
	<div class="v2_top_con">
	<%@ include file="/ybl/v2/admin/common/topV2.jsp" %> 
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
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
</body>
</html>

