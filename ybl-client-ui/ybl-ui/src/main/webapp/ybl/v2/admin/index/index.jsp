<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<!-- 提示框 -->

<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	})
</script>
</head>
<body>
    <div class="gateway">
	<div class="v2_top_con">
		<%@ include file="/ybl/v2/admin/common/topV2.jsp" %> 
		<div class="v2_gateway_con">
			<div class="v2_gateway_left"></div>
			<%-- <div class="v2_gateway_login">
				<h1>登录</h1>
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
				</ul>
			</div> --%>
		</div>
		
	</div>	
</div>
    <!---->


	<div class="v2_gateway_box">
	<div class="v2_gateway_bodycon">
   		<h1>借助长亮国信保理平台，您便可轻松拥有</h1>
        <ul>
        	<li>
        		<div class="v2_gate_special">
        			<div class="v2_special_ico special_ico1"></div>
        			<div class="v2_special_xx">
        				<h2>长亮国信平台</h2>
        				<p>互联网金融新形势下保理业务为金融机构提供保商业理服务使保理商高效地开展保理业务服务于企业客户。</p>
        			</div>
        		</div>
        	</li>
        	<li>
        		<div class="v2_gate_special">
        			<div class="v2_special_ico special_ico2"></div>
        			<div class="v2_special_xx">
        				<h2>银行供应链理念+技术</h2>
        				<p>供应链金融管理理念</p>
        				<p>银行级技术开发实力</p>
        				<p>供应链金融管理技术</p>
        				<p>业务操作更顺畅、更贴心！</p>
        			</div>
        		</div>
        	</li>
        	<li>
        		<div class="v2_gate_special">
        			<div class="v2_special_ico special_ico3"></div>
        			<div class="v2_special_xx">
        				<h2>云服务+本地部署</h2>
        				<p>创新采用云服务+本地部署方式</p>
        				<p>多种模式满足您搭建保理系统</p>
        				<p>支持个性化定制开发服务</p>
        				<p>开发运维更节省、更经济！</p>
        			</div>
        		</div>
        	</li>
        	<li>
        		<div class="v2_gate_special">
        			<div class="v2_special_ico special_ico4"></div>
        			<div class="v2_special_xx">
        				<h2>企业级系统开发服务支持</h2>
        				<p>上万家企业客户系统实施经验</p>
        				<p>采用先进的互联网技术架构</p>
        				<p>拥有强大的开发团队阵营</p>
        				<p>专家级解决方案制定</p>
        			</div>
        		</div>
        	</li>
        </ul>
    </div>
	</div>

<%--     <%@include file="/ybl/v2/admin/common/bottom.jsp" %>  --%>
	<%@include file="/ybl/admin/common/bottomV2.jsp" %>
<!--    <script type="text/javascript" -->
<%-- 		src="${app.staticResourceUrl}/ybl/resources/js/jquery_003.js"></script> --%>
	<%-- <script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery-login.js"></script> --%>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/v2/js/login.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/v2/js/sha256.js"></script>
<!-- 	<script type="text/javascript" -->
<%-- 		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script> --%>
	<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>  
    <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
</body>
</html>
<%
    if(null != request.getSession())
    {
	request.getSession().invalidate();//清空session 
    }
    if(null != request.getCookies())
    {
    	Cookie[] cookies = request.getCookies();
    	if(cookies.length > 0)
    	{
		    Cookie cookie = request.getCookies()[0];//获取cookie 
		    cookie.setMaxAge(0);//让cookie过期 ； 
    	}
    }
%>