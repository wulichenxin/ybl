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
<title>修改密码</title>
<%@ include file="/ybl4.0/admin/common/link.jsp" %> 
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js"></script>
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/calendar/index.css" />
<script type="text/javascript">
$(function(){
	$("#submit").click(function(){
		var newUserName = $("#newUserName").val();
		var ucode = $("#ucode").val();
		if(newUserName==''){
			alert("新手机号不能为空！");
			return;
		}
		if(ucode==''){
			alert("验证码不能为空！");
			return;
		}
		$.ajax({
			url:"/registerController/resetUserName",
			type:"POST",
			dataType:"json",
			data:{
				newUserName:newUserName,
				ucode:ucode
			},
			success:function(resp){
				if(resp.success){
					$("#newUserName").val('');
					$("#ucode").val('');
					alert(resp.info,function(){
						window.location.reload();
					});
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("服务器繁忙");
			}
		})
	})
})
//获取短信验证码
function sendSmsCode(){
	var userName = $("#newUserName").val();
	if(userName=='') {
		alert("新手机号不能为空！");
		return;
	}
	$.ajax({
		url:"/validCodeController/sendSmsCode",
		type:"POST",
		data:{
			phone : $("#newUserName").val(),
			type  : "regist"
		},
		success:function(resp){
			if(resp.responseTypeCode=="success"){
				alert("短信验证码发送成功");
				sendMessage();
			}else{
				alert(resp.info);
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
		<div>
			<p class="per_title mb30"><span>修改手机号</span><a class="goback" href="#" onClick="javascript :history.go(-1);"><img src="/ybl4.0/resources/images/my/zjf_back_icon.png" /></a></p>
			<div class="business">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">已绑定的手机号：</label><input disabled="disabled" value="${user_session.userName }" class="content-form2" /></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">新手机号：</label><input class="content-form2" id="newUserName" /></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">验证码：</label><input class="content-form4 content-form2" id="ucode" /><a class="btn-modify ml10"  id="smsCodeBtn" onclick="sendSmsCode();">获取验证码</a></div>
				</div>
				<!-- <div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">登录密码：</label><input class="content-form2" /></div>
				</div> -->
				<div class="w400 mt40">
					<div class="btn-add btn-center mt40" id="submit">提交</div>
				</div>
			</div>
		</div>
	</body>
</html>
