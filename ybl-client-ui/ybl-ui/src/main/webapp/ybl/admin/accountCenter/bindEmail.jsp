<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>绑定邮箱</title>
<jsp:include page="../common/link.jsp" />
<script language='javascript'  src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript">
	function bindEmail(){
		if(!$("#email").validationEngine('validate')) {
			return;
		}
		if(!$("#emailCode").validationEngine('validate')) {
			return;
		}
		$.ajax({
            url:'/UserController/bindEmailSave',
            type:'POST',
            data: {
            	email : $("#email").val(),
            	code : $("#emailCode").val()
            },
            dataType:'text',
            success:function(data){
                if(data =="S"){
                	window.location.href = "/accountOverview/queryAccountOverview";
                } else {
                	alert(data);
                }
            },
            error:function(xhr,textStatus){
                console.log('错误');
                console.log(xhr);
                console.log(textStatus);
            },
            complete:function(){
                console.log('结束');
            }
        });
	}
	
	
	
	//找回密码发送短信
	function sendEmailCode(){
		if(!$("#email").validationEngine('validate')) {
			return;
		}
		if(!$("#vcode").validationEngine('validate')) {
			return;
		}
		$.ajax({
			url:"/validCodeController/sendEmailCode",
			type:"POST",
			data:{
				email : $("#email").val(),
				type : "bindemail",
				vCode : $("#vcode").val()
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					/* var index = $('.bakmm').index();
					$('.tab_tt .bakmm').eq(index).addClass('now').siblings().removeClass('now'); */
					alert("邮箱验证码发送成功");
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		});
	}
	
</script>


</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path">当前位置->账户中心 -> 账户总览 ->绑定邮箱</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>绑定邮箱
					</h1>
				</div>

				<div class="xtxx">
					<div class="tab_xxcon">
						<!--1-->
						<div class=" bankbox">
						<form id="dataForm" action="">
							<div class="xgyf_cz w600">
								<dl>
									<dd>
										<label>邮箱：</label>
										<div class="yhk_box">
											<input type="text" id="email" name="email" class="text w300 mr10 validate[required,custom[email]] " />
										</div>
									</dd>
									
									<dd>
										<label>验证码：</label>
										<div class="yhk_box">
											<input placeholder="请输入验证码" type="text" class="text fl w200 mr10 validate[required]" id="vcode" />
											<span><img id="imgcode" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
											 title="看不清，点击换一张" style="cursor: pointer;"/></span>
										</div>
									</dd>
									<dd>
										<label>邮箱验证码：</label>
										<div class="yhk_box">
											<input type="text" id="emailCode" name="emailCode" class="text fl w200 mr10 validate[required,number]" /> <span><a
												class="lan unl" onclick="sendEmailCode()">点击获取</a></span>
										</div>
									</dd>
								</dl>
								<div class="but_center_100 ">
									<a onClick="bindEmail();">绑定邮箱</a>
								</div>
							</div>
							</form>
						</div>
						<!--1-->
					</div>
				</div>
				<!-- <div class="bank_ts">
					<div class="bank_ts_l">温馨提示</div>
					<div class="bank_ts_r">
						<p>1.请确保您输入的提现金额，以及银行帐号信息准确无误。</p>
						<p>2.如果您填写的提现信息不正确可能会导致提现失败。</p>
						<p>3.在双休日和法定节假日期间，用户可以申请提现，航付保会在下一个工作日进行处理。由此造成的不便，敬请谅解。</p>
						<p>4.平台禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。</p>
					</div>
				</div> -->
			</div>
		</div>
	</div>
	<!--conover-->
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>