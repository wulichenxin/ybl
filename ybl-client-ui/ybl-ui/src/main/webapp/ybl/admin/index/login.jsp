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
	<title>云保理</title>
	<meta name="Keywords" content="云保理">
	<meta name="Description" content="云保理">
	<meta name="Copyright" content="云保理" />
	<link href="${app.staticResourceUrl}/ybl/resources/css/login.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
	<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css" />
<!-- 提示框 -->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#ybl_admin_member_register_btn").click(function(){
				location.href="/registerController/register.htm";
			});
			
			window.alert = function(msg) {
				window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
			}
		})
	</script>
</head>
<body>

	<!--top-->
	<!--top-->
	<!--logo+menu-->
	<div class="head_login">
		<div class="top_head">
			<div class="logo">
				<a href="${app.staticResourceUrl}/ybl/admin/index/login.jsp"></a>
			</div>
			<div class="login_nav">
				<ul>
					<li class="now"><a><span>首页</span></a></li>
					<li><a href="javascript:void(0);">业务介绍</a></li>
					<li><a href="/aboutUsController/toAboutUs">关于我们</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!---->
	<div class="fullpage-wrapper"
		style="height: 100%; position: relative; transform: translate3d(0px, -763px, 0px); transition: all 700ms ease 0s;"
		id="dowebok">
		<div class="login_bg1 section">
			<div class="login_but">
				<div class="login_wz_pic1">
					<img
						src="${app.staticResourceUrl}/ybl/resources/images/login_1_pic.png" />
				</div>
				<ul>
					<li class="now"><a onclick="add_start();">登录</a></li>
					<li>
						<a id="ybl_admin_member_register_btn">注册</a>
						<%-- <sun:button id="ybl_admin_member_register_btn" tag='a' value="注册" /> --%><!-- 注册按钮  -->
					</li>
				</ul>
			</div>
		</div>

		<div class="section login_bg2">
			<div class="cont">
				<div class="sub-nei-ct2">
					<%-- <div class="login_wz_pic">
						<img
							src="${app.staticResourceUrl}/ybl/resources/images/login_2_pic.png" />
					</div> --%>
				</div>
			</div>
		</div>
		<div class="section login_bg3">
			<div class="cont">
				<div class="sub-nei-ct3">
					<%-- <div class="login_wz_pic">
						<img
							src="${app.staticResourceUrl}/ybl/resources/images/login_3_pic.png" />
					</div> --%>
				</div>
			</div>
		</div>
		<div class="section login_bg4">
			<div class="cont">
				<div class="sub-nei-ct2">
					<%-- <div class="login_wz_pic">
						<img
							src="${app.staticResourceUrl}/ybl/resources/images/login_4_pic.png" />
					</div> --%>
				</div>
			</div>
		</div>
		<div class="section login_bg5">
			<div class="cont">
				<div class="sub-nei-ct3">
					<%-- <div class="login_wz_pic">
						<img
							src="${app.staticResourceUrl}/ybl/resources/images/login_5_pic.png" />
					</div> --%>
				</div>
			</div>
		</div>
		<jsp:include page="/ybl/admin/common/bottom.jsp"/>

	</div>

	<!--
<div class="login_bg1">
	<div class="login_but">
    	<div class="login_wz_pic1"><img src="images/login_1_pic.png" /></div>
    	<ul>
    		<li class="now"><a onclick="add_start();">登录</a></li>
        	<li><a href="注册.html">注册</a></li>
        </ul>
    </div>
 </div>
 <div class="login_bg2">
	<div class="login_but">
    	<div class="login_wz_pic1"><img src="images/login_1_pic.png" /></div>
    	<ul>
    		<li class="now"><a onclick="add_start();">登录</a></li>
        	<li><a href="注册.html">注册</a></li>
        </ul>
    </div>
 </div>
  <div class="login_bg3">
	<div class="login_but">
    	<div class="login_wz_pic1"><img src="images/login_1_pic.png" /></div>
    	<ul>
    		<li class="now"><a onclick="add_start();">登录</a></li>
        	<li><a href="注册.html">注册</a></li>
        </ul>
    </div>
 </div>
  <div class="login_bg4">
	<div class="login_but">
    	<div class="login_wz_pic1"><img src="images/login_1_pic.png" /></div>
    	<ul>
    		<li class="now"><a onclick="add_start();">登录</a></li>
        	<li><a href="注册.html">注册</a></li>
        </ul>
    </div>
 </div>
  <div class="login_bg5">
	<div class="login_but">
    	<div class="login_wz_pic1"><img src="images/login_1_pic.png" /></div>
    	<ul>
    		<li class="now"><a onclick="add_start();">登录</a></li>
        	<li><a href="注册.html">注册</a></li>
        </ul>
    </div>
 </div>
 -->




	<!--弹出窗登录-->

	<div id="add" style="display: none;">
		<div class="t_window"></div>
		<div class="window_box">
			<div class="l_tittle1">
				<div class="t_window_close">
					<a id="add_close" onclick="add_close();"><img
						src="${app.staticResourceUrl}/ybl/resources/images/l_close.png" /></a>
				</div>
			</div>
			<div class="wlogin_box">
				<div class="clear"></div>
				<div class="wlogin">
					<%-- <h1>登录</h1>
					<ul>
						<li><div class="v2_getaway_input"><input placeholder="请输入手机号码" type="text" class="v2_gate_text" id='username' /></div></li>
						<li><div class="v2_getaway_input"><input placeholder="请输入登录密码" type="password" class="v2_gate_text" id='password' /></div></li>
						<li><div class="v2_getaway_input"><input placeholder="请输入验证码" type="text" class="v2_gate_text w170 validate[required,minSize[4],maxSize[4]]" id="phone_vcode" /><div class="v2_yzm">
						<img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
												 title="看不清，点击换一张" style="cursor: pointer;"/></div></div></li>
						<li><div class="v2_gateway_login_but"><a id="ybl_admin_member_login_btn"><spring:message
											code="sys.v2.client.login" /></a>
											 <a id="ybl_admin_member_login_btn_ing" class="zc_button none1">
										         <spring:message code="sys.client.logining" />
									         </a>
											</div></li>
						<li><div class="v2_forget"><a href="/gatewayController/toForgetPasswordV2.htm">忘记密码？</a></div></li>
					</ul> --%>
					<ul>
						<li><h1>账户登录</h1></li>
						<li><div class="login_input">
								<span><b class="l_ico1"></b></span><input placeholder="请输入手机号码"
									type="text" class="wl_text" id='username' />
							</div></li>
						<li><div class="login_input mt10">
								<span><b class="l_ico2"></b></span><input placeholder="请输入登录密码"
									type="password" class="wl_text" id='password' />
							</div></li>
							
						<li><div class="v2_getaway_input"><input placeholder="请输入验证码" type="text" class="v2_gate_text w170 validate[required,minSize[4],maxSize[4]]" id="phone_vcode" /><div class="v2_yzm">
						<img id="pwd_img_phone" src="/jcaptcha" onclick="this.src='/jcaptcha?id='+new Date();"
												 title="看不清，点击换一张" style="cursor: pointer;"/></div></div></li>
						<!--<li>
                    	<div class="login_input mt10"><span><b class="l_ico4"></b></span><input placeholder="请选择企业" type="text" class="w_text_set"/>		                    
                    		<div class="selet_but">
                            	<a class="selet_down"></a>
                                <div class="selet_box">
                                	<dl>
                                    	<dd><a>保理商</a></dd>
                                        <dd><a>商户</a></dd>
                                        <dd><a>核心企业</a></dd>
                                        <dd><a>会员游览</a></dd>
                                    </dl>
                                </div>
                            </div>
                            
                        </div>
                    </li>  -->

						
						<li><div class="login_dl mt10">
								<a id="ybl_admin_member_login_btn" class="zc_button" >
									<spring:message code="sys.client.login"/>
								</a><!-- 登陆按钮  -->
								<a id="ybl_admin_member_login_btn_ing" class="zc_button none1">
									<spring:message code="sys.client.logining"/>
								</a><!-- 登录中 -->
							</div></li>
						<li><a class="fl yellow f12" href="/registerController/register.htm">快速注册></a>
							<a class="fr yellow f12" href="/registerController/toForgetPassword">忘记密码？</a>
						</li>

					</ul>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong.js"></script>
<!-- 	<script type="text/javascript" -->
<%-- 		src="${app.staticResourceUrl}/ybl/resources/js/jquery_003.js"></script> --%>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery-login.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/login.js"></script>
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
		function add_close() {
			clearInterval(timer);
			$('#add').hide();
			$('t_window').css({
				overflow : ''
			});
		}
	</script>
</body>
</html>
