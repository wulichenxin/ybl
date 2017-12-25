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
<title>咨询信息</title>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/css/common.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/common.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript">
	$(function() {
		$("#submit").click(function(){
			if(!$("#name").validationEngine('validate')) {
	 			return;
	 		}
			if(!$("#telephone").validationEngine('validate')) {
	 			return;
	 		}
			if(!$("#enterpriseName").validationEngine('validate')) {
	 			return;
	 		}
			var name = $("#name").val();
			var validateCode = $("#validateCode").val();
			var productId = $("#productId").val();
			var telephone = $("#telephone").val();
			var enterpriseName = $("#enterpriseName").val();
			if(name == "" || name == null)
				{
				alert("称呼不能为空！");
				return;
				}
			if(telephone == '' || telephone == null) {
				alert("手机号不能为空！");
				return;
			}
			if(enterpriseName == "" || enterpriseName == null)
			{
				alert("企业名称不能为空");
				return;
			}
			if(validateCode == "" || validateCode == null)
			{
				alert("手机验证码不能为空");
				return;
			}
			/* if(!$('#agreeMent').is(':checked')) { 
				alert("请勾选协议");
				return;
			} */
			$.ajax({
				url:"/factorConsultationController/insertVisitor",
				type:"POST",
				data:{
					productId : productId,
					name : name,
					smsCode : validateCode,
					phone : telephone,
					enterpriseName:enterpriseName
				},
				success:function(resp){
					if(resp.responseTypeCode=="success"){
						 alert("预约成功!");
					}else{
						alert(resp.info);
					}
				},
				error:function(){
					alert("系统繁忙，请稍后再试");
				}
			})
			
		});
	});
	
	//获取短信验证码
	function sendSmsCode(){
		if($("#smsCodeBtn").html() != "获取验证码"){
			alert("操作过于频繁，请稍后再试!");
			return;
		}
		var name = $("#name").val();
		var telephone = $("#telephone").val();
		var enterpriseName = $("#enterpriseName").val();
		if(!$("#telephone").validationEngine('validate')) {
 			return;
 		}
		if(name=='') {
			alert("称呼不能为空！");
			return;
		}
		if(telephone=='') {
			alert("手机号不能为空！");
			return;
		}
		if(enterpriseName==''){
			alert("公司名称不能为空！");
			return;
		}
		$.ajax({
			url:"/validCodeController/sendSmsCode",
			type:"POST",
			data:{
				phone : $("#telephone").val(),
				/* vCode : $("#imageCode").val(), */
				type  : "visit"
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					alert("短信验证码发送成功");
					sendMessage();
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
<input type="hidden" value="${id }" id="productId" name="productId"/>
<!-- <div class="ybl-head">
			<div class="w1200 clearfix">
				<div class="fl">
					欢迎您！<span class="username">15814435455</span><span class="notice-sp"><img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span>
				</div>
				<div class="fr">
					<img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span>
					<a class="dropOut" href="javascript:;">退出</a><img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-12345678
				</div>
			</div>
		</div> -->

		<%@ include file="/ybl4.0/admin/doorl/common/top-blzx.jsp" %>
		
		<div class="w1200 blsq">
			<p class="centerp">陛下，请向小云倾诉你的基础情况吧！</p>
			<ul class="login_ul fl">
					<li>您的称呼：<input type="text" placeholder="请输入姓名" class="validate[required]" id="name" name="name"/></li>
					<li></li>
					<li>手机号码：<input type="text" placeholder="请输入手机号码" class="validate[custom[mobilePhone]]"  id="telephone" name="telephone"/></li>
					<li></li>
					<li></li>
					<li>企业名称：<input type="text" placeholder="请输入企业名称" class="validate[maxSize[20]]"  id="enterpriseName" name="enterpriseName"/></li>
					<li></li>
					<li>手机验证：<input type="text" placeholder="请输入手机验证码" style="width: 150px;margin-right: 15px;" id="validateCode"/><div class="getyzm" style="font-size: 12px;" id="smsCodeBtn" onclick="sendSmsCode(this);">获取验证码</div></li>
					<!-- <li class="ft14"><input type="checkbox" id="che1" /><label for="che1">我已阅读并同意<a class="color-yellow" href="javascript:void(0)">《云保理注册协议》</a></label></li> -->
					<li><a class="login_btn1" href="javascript:void(0);" id="submit">提交</a></li>
				</ul>
		</div>
	</body>
</html>
