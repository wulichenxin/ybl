<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript">
	$(function() {
		$("#orderForm").validationEngine('attach', {
		    'showPrompts': false
		  });
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
				alert("手机信息有误");
				return;
			}
			if(!$("#phone_smscode").validationEngine('validate')) {
				return;
			}
			checkValidCode($("#phone").val(),$("#phone_smscode").val(), "sms");
		});
		$("#sub").click(function(){
			var name = $("#name").val();
			var phone_vcode = $("#phone_vcode").val();
			var phone_smscode = $("#phone_smscode").val();
			var productId = $("#productId").val();
			var phone = $("#phone").val();
			if(name == "" || name == null)
				{
				alert("用户名不能为空");
				return;
				}
			if(!$("#phone").validationEngine('validate')) {
				alert("请输入正确的手机号");
				return;
			}
			if(phone_vcode == "" || phone_vcode == null)
			{
				alert("图形验证码不能为空");
				return;
			}
			if(phone_smscode == "" || phone_smscode == null)
			{
				alert("手机验证码不能为空");
				return;
			}
			if(!$('#agreeMent').is(':checked')) { 
				alert("请勾选协议");
				return;
			}
			$.ajax({
				url:"/gatewayController/insertVisitor",
				type:"POST",
				data:{
					productId : productId,
					name : name,
					smsCode : phone_smscode,
					phone : phone
				},
				success:function(resp){
					if(resp.responseTypeCode=="success"){
						 alert("预约成功",function(){
							 parent.$(".v2_msgbox_close").mousedown();
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
	});
	
	//找回密码发送短信
	function sendSmsCode(obj){
		if(!$("#phone").validationEngine('validate')) {
			alert("手机号格式不正确");
			return;
		}
		if(!$("#phone_vcode").validationEngine('validate')) {
			alert("验证码输入不正确");
			return;
		}
		$.ajax({
			url:"/validCodeController/sendSmsCodeYu",
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
					$("#pwd_img_phone").click();
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
		    $(obj).text(curEmailCount + "秒");
		}
		if(obj.id == "smsCodeBtn"){
			curSmsCount = count;
		    $(obj).attr("disabled", "true");
		    $(obj).text(curSmsCount + "秒");
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
		        $(object).text(curEmailCount + "秒");
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
		        $(object).text(curSmsCount + "秒");
		    }
		}
	    
	}
	
	</script>
</head>
<body>
<form id="orderForm" action="/gatewayController/insertVisitor" method="post">
<input type="hidden" value="${id }" id="productId" name="productId"/>
<div class="v2_window">
  <div class="v2_window_con">
  	<div class="v2_order_banner"><span></span><font>陛下，请向小云倾诉你的基本情况吧！</font></div>
   <ul class="v2_order">
                 <li class="clear">
                  <div class="v2_input_box"><span>您的称呼：</span>
                    		<input type="text" placeholder="请输入姓名" class="v2_text w300" id='name' />
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="v2_input_box"><span>手机号码：</span>
                    		<input type="text" placeholder="请输入手机号" class="v2_text w300 validate[required,custom[phone]]" id="phone" />
                   		</div>
                   	</li>
                   	<li>
                    	<div class="v2_input_box" style="line-height:60px;"><span>验证码：</span>
                    	<div class="v2_i_seach"><input placeholder="" type="text" class= "w190 v2_text fl mr20 validate[required,minSize[4],maxSize[4]]" id="phone_vcode"/><div class="v2_yzm">
                    	<img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
											 title="看不清，点击换一张" style="cursor: pointer;"/></div></div>
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="v2_input_box" style="line-height:60px;"><span>手机验证码：</span>
                    		<div class="v2_i_seach"><input placeholder="" type="text" class= "w190 v2_text fl mr20 validate[required,minSize[6],maxSize[6]]" id="phone_smscode"/><div class="send_yzm"><a id="smsCodeBtn" onclick="sendSmsCode(this);">获取验证码</a></div></div>
                   		</div>
                   	</li>
                   	<li><div class="v2_gateway_login_but w300 ml150"><a id="sub">提交</a></div></li>
					<li><div class="v2_w_agreen"><input name="" id="agreeMent" type="checkbox" value="" />同意 长亮国信保理服务条款</div></li>
    </ul>
  </div> 
</form>
<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
</body>
</html>
