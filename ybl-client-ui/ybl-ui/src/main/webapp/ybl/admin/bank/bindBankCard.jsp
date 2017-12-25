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
<title>绑定银行卡</title>
<jsp:include page="../common/link.jsp" />
<script language='javascript'  src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript">
	var index;
	var timer;
	// 添加
	function add_start() {
		$('#add').show();
		$('t_window').css({
			overflow : 'hidden'
		});
	}
	// 添加
	function add_blank() {
		$('#add_blank').show();
		$('t_window').css({
			overflow : 'hidden'
		});
	}
	function add_close() {
		clearInterval(timer);
		$('#add').hide();
		$('body').css({
			overflow : ''
		});
	}
	function add_bclose() {
		clearInterval(timer);
		$('#add_blank').hide();
		$('body').css({
			overflow : ''
		});
	}
	function addBank(){
		
		if(!$("input[name='openName']").validationEngine('validate')){
			return ;
		}
		if(!$("select[name='certType']").validationEngine('validate')){
			return ;
		}
		if(!$("input[name='certNo']").validationEngine('validate')){
			return ;
		}
		if(!$("select[name='bankId']").validationEngine('validate')){
			return ;
		}
		if(!$("input[name='accountNo']").validationEngine('validate')){
			return ;
		}
		if(!$("input[name='bankPhone']").validationEngine('validate')){
			return ;
		}
		if(!$("#phone_vcode").validationEngine('validate')){
			return ;
		}
		
		if(!$("input[name='smsCode']").validationEngine('validate')){
			return ;
		}
		
		$.ajax({
            url:'/bankAccount/bindBankCardSave',
            type:'POST',
            data:$("#dataForm").serialize() ,
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
	function sendSmsCode(){
		if(!$("#phone").validationEngine('validate')) {
			return;
		}
	   if(!$("#phone_vcode").validationEngine('validate')) {
			return;
		}
	   $("#pwd_img_phone").click();
		$.ajax({
			url:"/validCodeController/sendSmsCode",
			type:"POST",
			data:{
				phone : $("#phone").val(),
				type : "bindbank",
				vCode : $("#phone_vcode").val()
			},
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					/* var index = $('.bakmm').index();
					$('.tab_tt .bakmm').eq(index).addClass('now').siblings().removeClass('now'); */
					alert("短信验证码发送成功");
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("系统繁忙，请稍后再试");
			}
		});
	}
	
	$(function(){
		
		$("#dataForm").validationEngine();
	})
	
</script>


</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path">当前位置->账户中心 -> 账户总览 ->提现</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>绑定银行卡
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
										<label>开户人姓名：</label>
										<div class="yhk_box">
											<input type="text" name="openName" class="text w300 mr10 validate[required,minSize[2],maxSize[20]] " /> <i class='red' >*</i>
										</div>

									</dd>
									<dd>
										<label>证件类型：</label>
										<div class="yhk_box">
											<select name="certType" class="text w320 mr10 validate[required]">
												<!-- <option value="">请选择</option> -->
												<option value="01">身份证</option>
											</select><i class='red' >*</i>
										</div>

									</dd>
									<dd>
										<label>证件号码：</label>
										<div class="yhk_box">
											<input type="text" name="certNo" class="text w300 mr10 validate[required,custom[cardid]]" /><i class='red' >*</i>
										</div>
									</dd>
									<dd>
										<label>开户银行：</label>
										<div class="yhk_box">
											<select name="bankId" class="text w320 mr10 validate[required]">
												<option value="">请选择</option>
												<c:forEach items="${bankList }" var="data">
													<option value="${data.id }">${data.name }</option>
												</c:forEach>
											</select><i class='red' >*</i>
										</div>

									</dd>
									<dd>
										<label>银行账号：</label>
										<div class="yhk_box">
											<input type="text" name="accountNo" class="text w300 mr10 validate[required,custom[bankAccount]]"  /><i class='red' >*</i>
										</div>
									</dd>
									<dd>
										<label>预留手机号：</label>
										<div class="yhk_box">
											<input type="text" id="phone" name="bankPhone" class="text w300 mr10 validate[required,custom[mobilePhone]] " />
										</div>
									</dd>
									
									<dd>
										<label>验证码：</label>
										<div class="yhk_box">
											<input placeholder="请输入验证码" type="text" class="text fl w200 mr10 validate[required]" id="phone_vcode" />
											<span><img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
											 title="看不清，点击换一张" style="cursor: pointer;"/></span>
										</div>
									</dd>
									<dd>
										<label>短信验证码：</label>
										<div class="yhk_box">
											<input type="text"  name="smsCode" class="text fl w200 mr10 validate[required,number]" /> <span><a
												class="lan unl" onclick="sendSmsCode()">点击获取</a></span>
										</div>
									</dd>
								</dl>
								<div class="w_agreen">
									<input type="checkbox" />云保理平台银行卡绑定协议
								</div>
								<div class="but_center_100 ">
									<a onClick="addBank();">绑定银行卡</a>
								</div>
							</div>
							</form>
						</div>
						<!--1-->
					</div>
				</div>
				<div class="bank_ts">
					<div class="bank_ts_l">温馨提示</div>
					<div class="bank_ts_r">
						<p>1.请确保您输入的提现金额，以及银行帐号信息准确无误。</p>
						<p>2.如果您填写的提现信息不正确可能会导致提现失败。</p>
						<p>3.在双休日和法定节假日期间，用户可以申请提现，航付保会在下一个工作日进行处理。由此造成的不便，敬请谅解。</p>
						<p>4.平台禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--conover-->
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
	<!--弹出窗登录-->
	<div id="add" style="display: none;">
		<div class="t_window"></div>
		<div class="vipwindow_box vip_w600">
			<div class="l_tittle">
				<h1>提现</h1>
				<div class="t_window_close">
					<a id="add_close" onclick="add_close();"><img
						src="${app.staticResourceUrl}/ybl/resources/images/w_close_ico.png" /></a>
				</div>
			</div>
			<div class="vip_window_con">
				<div class="clear"></div>
				<div class="xgyf_cz">
					<ul>
						<li><h2>
								账户余额：<span class="yellow"><i class="f24 mr10">8800.00</i></span>元
							</h2></li>
						<li>您已成功申请提现<span class="yellow ml10 mr10">555.00</span>元
						</li>
						<li>国信基金会在一个工作日内对您的申请进行审核</li>
						<li>
							<div class="but_center_100 ">
								<a onclick="add_close();">确定</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>