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
<jsp:include page="/fw/admin/common/link.jsp" />
<script type="text/javascript" src="/fw/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/fw/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
</head>
<body> 

<div class="cont">

    <!--table-->
    <div class="table_box mt20">
     <!--机构信息认证-->
         <!--注册信息-->
       <!-- <div class="base_con2">
		<h1><span class="base_ico4"></span>注册信息</h1>
    		<div class="base_boxrz">
            	<ul>
            		<li><div class="base_input"><span>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span><em>zhan123456</em></div></li>  
                    <li><div class="base_input"><span>类　　型：</span><em>机构用户</em></div></li>                    
            	</ul>
            	<div class="clear"></div>
            </div>
		</div>
         <!--注册信息-->
        <div class="base_con2">
		<h1><span class="base_ico5"></span>安全信息</h1>
    		<div class="base_boxrz">
					<ul>
						<li><div class="base_input">
								<span>手 机：</span>
								<div class="bd_but">
								<c:if test="${empty user_session.mobile }"><a onclick="add_start()">绑定</a></c:if>
								<c:if test="${!empty user_session.mobile }">${user_session.mobile}</c:if>
								</div>
							</div></li>
						<li><div class="base_input">
								<span>邮 箱：</span>
								<div class="bd_but">
								<c:if test="${empty user_session.email }"><a onclick="email_start()">绑定</a></c:if>
								<c:if test="${!empty user_session.email }">${user_session.email}</c:if>
								</div>
								
							</div></li>
						<li><div class="base_input">
								<span>密码重置：</span>
								<div class="bd_but"><a onclick="pascz_start()">修改</a></div>
							</div></li>
					</ul>
					<div class="clear"></div>
            </div>
		</div>
         
    </div>
	<!--table-->
</div>
  
<!--密码重置-->
<form action="" id="restPwdFrm">
<input name="id" type="hidden" value="${user_session.id}"/>
<div id="pascz" style="display:none;">
    <div class="t_window"></div>
    <div class="window_rz">
        <div class="l_tittle">
        	<h1>密码重置</h1>
            <div class="t_window_close"><a id="add_close" onclick="add_close();"><img src="/fw/resources/images/w_close_ico.png"/></a></div>
        </div>
        <div class="rzlogin_box">
            <div class="clear"></div>
            <div class="rzlogin" style="width:250px;">
                 <ul>
                    <li><div class="rz_input"><!-- <i><em></em>用户名错误</i> --><input required name="password" id="password" placeholder="旧密码" type="password" class="rz_text"/></div></li> 
                    <li><div class="rz_input"><!-- <i><em></em>用户名错误</i> --><input required name="newPassword" id="newPassword" placeholder="新密码" type="password" class="rz_text"/></div></li>        
                    <li><div class="rz_input"><!-- <i><em></em>用户名错误</i> --><input required name="surePassword" id="surePassword" placeholder="再次输入新密码" type="password" class="rz_text"/></div></li>               
                 </ul>
                <div class="pw_bottom">
                	<ul>
                    	<li>
                    	<a class="w_sure_but" id="respwdButton">确定</a>
                    	<a class="del_butico" id="respwdButtoning" style="display: none;">提交中...</a>
                    	</li>
                	</ul>
                </div>
            </div>
        </div>
    </div>
</div>
</form>
<!--提示弹出框-->

<div id="ts_win" style="display:none;">
    <div class="t_window"></div>
    <div class="window_rz">
        <div class="l_tittle">
        	<h1>信息提示</h1>
            <div class="t_window_close"><a id="add_close" onclick="add_close();"><img src="/fw/resources/images/w_close_ico.png"/></a></div>
        </div>
        <div class="rzlogin_box">
            <div class="clear"></div>
            <div class="rzlogin" style="width:250px;">
                <div class="window_ts"><span class="win_worong"></span>请输入手机号</div>
                <div class="pw_bottom">
                	<ul>
                    	<li><a class="w_sure_but">确定</a></li>
                	</ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
var index;
var timer;
var allSecond=30;//短信倒计时总秒数
var second;//短信当前计时总秒数
var countdown;//是否在倒计时中
// 添加
function add_start() {
	$('#phone').show();
	$('t_window').css({overflow:'hidden'});
}
function email_start() {
	$('#edemail').show();
	$('t_window').css({overflow:'hidden'});
}
function pascz_start() {
	$('#pascz').show();
	$('t_window').css({overflow:'hidden'});
}
function tswin_start() {
	//$('#ts_win').show();
	//$('#phone').hide();
	//$('t_window').css({overflow:'hidden'});
	sendTime(second);
}
 


function add_close(){
	clearInterval(timer);
	$('#phone,#edemail,#pascz,#ts_win').hide();
	$('body').css({overflow:''});
}

$("#sendmsg").on('click', function() { 
	if(countdown==1){return;}
	var mobile=$("#mobile").val();
	//发送短信
	$.ajax({
        cache: true,
        type: "get",
        url:"/loginController/sendmsg?mobile="+mobile, 
        async: true,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
            if(data.responseType=="SUCCESS"){
            	alert('短信发送成功');
            }else{
                alert(data.info);
            }
        }
    });
	//定时显示
	countdown=1;
	second=allSecond;
	showTime();
});

//默认加载省份和选中,并初始化市
function   showTime(){
	second--;
	$("#sendtext").html(second+"秒后再发");
	if(second==0){
		countdown=0; 
		second=allSecond;
		$("#sendtext").html("发送");
	}else{ 
		setTimeout(showTime,"1000");
	}
}

var isSubIng=0;//是否在提交中
$("#emailButton").on('click', function() { 
	if(isSubIng=1){return;}
	isSubIng=1;
	if(!$("#emailFrm").valid()){
		return;
	}  
	
	var rgemail= /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
	if(!rgemail.test($("#email").val())){
		 alert('邮箱格式不正确');
		 isSubIng=0;
		 return;
	}

	
	$.ajax({
        cache: true,
        type: "POST",
        url:"/loginController/bindEmail",
        data:$('#emailFrm').serialize(),// 你的formid
        async: true,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
            if(data.responseType=="SUCCESS"){
            	$("#edemail").hide();
            	alert('已发送验证链接到您的邮箱,请您登录邮箱点击验证!');
            	window.location.reload(true);
            }else{
                alert(data.info);
            }
        }
    });
	isSubIng=0;
});

$("#mobileButton").on('click', function() {  
	if(!$("#mobileFrm").valid()){
		return;
	}  
	$.ajax({
        cache: true,
        type: "POST",
        url:"/loginController/bindPhone",
        data:$('#mobileFrm').serialize(),// 你的formid
        async: true,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	console.log(data);
            alert(data.info);
            if(data.responseType=="SUCCESS"){
            	$("#phone").hide();
            	window.location.reload(true);
            }
        }
    });
});


$("#respwdButton").on('click', function() {  
	if(!$("#restPwdFrm").valid()){
		return;
	} 
	if($('#newPassword').val() !=$('#surePassword').val()){
		alert("新密码和确认密码不一致");return;
	}
	if($('#newPassword').val().length<5){
		alert("密码长度至少6位");return;
	}
	$("#respwdButton").hide();
	$("#respwdButtoning").show();
	$.ajax({
        cache: true,
        type: "POST",
        url:"/loginController/modifypwd",
        data:$('#restPwdFrm').serialize(),// 你的formid
        async: false,
        error: function(request) {
            alert("Connection error");
            $("#respwdButton").show();
        	$("#respwdButtoning").hide();
        },
        success: function(data) {
        	console.log(data);
            alert(data.info);
            if(data.responseType=="SUCCESS"){
            	$("#pascz").hide();
            	$("#respwdButton").show();
            	$("#respwdButtoning").hide();
            	window.location.reload(true);
            }
            
        }
    });
});


</script>

</body>


</html>
