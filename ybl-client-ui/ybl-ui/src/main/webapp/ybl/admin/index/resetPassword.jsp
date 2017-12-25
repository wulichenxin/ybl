<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.client.password.reset"/></title><!-- 密码重置 -->
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<link href="${app.staticResourceUrl}/ybl/resources/css/vip_page.css" rel="stylesheet" type="text/css"/>
<link href="${app.staticResourceUrl}/ybl/resources/css/login.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
<!-- 表单验证 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jsext.js"></script>
<!-- 国际化 -->
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/jquery.i18n.properties.min.js'></script>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>
<!-- 提示框 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<!-- 重置的js -->
<script language='javascript'
		src="${app.staticResourceUrl}/ybl/resources/js/accountCenter/resetPassword.js"></script>
</head>
<body>
<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->

<div class="mm_box">
	<div class="mm_con">
		<h1><spring:message code="sys.client.please.input.reset.password"/><!-- 修改密码--></h1>
		<form action="/registerController/resetPassword" method="post" id="resetPasswordFrom">
		<input type="hidden" value='${user_session.userName}'  id='userName'/>
		<input type="hidden" value='${user_session.telephone}'  id='telephone'/>
    	<div class="mmtext">
           	<ul>
            	<li><span><spring:message code="sys.client.oldPassword"/><!-- 旧密码 -->：</span>
            		<input placeholder="请输旧密码" type="password" class="mm_text validate[required]" id='oldPassword'/></li>
                <li><span><spring:message code="sys.client.newPassword"/><!-- 新密码 -->：</span>
                	<input placeholder="请输入新密码" type="password" class="mm_text validate[required]" name='password' id='newPassword'/></li>
                <li><span><spring:message code="sys.client.sure.password"/><!-- 确认密码 -->：</span>
                	<input placeholder="请输入确认密码" type="password" class="mm_text validate[required]" id='nextPassword' name='nextpassword'/></li>
                <li>
                	<div class="next_but">
                		<a id='member_reset_password_submit_btn'><spring:message code="sys.client.submit"/></a>
                		<a id='member_reset_password_submiting_btn' style='display:none;'>提交中...</a>
                	</div>
                </li> 
            </ul>
        </div>
        </form>
	</div>
</div>
<!-- 底部jsp -->
<jsp:include page="../common/bottom.jsp"/>
<!-- 底部jsp -->
</body>
</html>
