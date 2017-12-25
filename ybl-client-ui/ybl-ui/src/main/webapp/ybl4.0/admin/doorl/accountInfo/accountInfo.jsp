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
<title>账户中心</title>
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/calendar/index.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/calendar/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
</head>
	<body>
		<p class="per_title"><span>基础信息</span></p>

					<ul class="pd20">
						<li class="xinxilist">
							<label>用户名</label>
							<span><input type="text" class="userName" value="${user_session.userName }" disabled="disabled" /></span>
						</li>
						<li class="xinxilist">
							<label>登录密码</label>
							<span><input type="password" class="userName" value="666666666" disabled="disabled" /><font>(为保障账户安全请定期修改密码)</font></span>
							<a class="linkid" data-linkid="1" href="/ybl4.0/admin/doorl/accountInfo/resetPassword.jsp">修改</a><img class="ml10 showpwd" src="/ybl4.0/resources/images/my/closeEye_icon.png" />
						</li>
						<li class="xinxilist">
							<label>手机号码</label>
							<span><input type="text" class="userName" placeholder="手机号码更换请立即修改账户名(手机号码)" disabled="disabled" /></span>
							<a class="linkid" data-linkid="2" href="/ybl4.0/admin/doorl/accountInfo/resetUserName.jsp">立即更换</a>
						</li>
						<!-- <li class="xinxilist">
							<label>邮箱绑定</label>
							<span><input type="text" class="userName" value="用于接受所有电子对账单" disabled="disabled" /></span>
							<a class="linkid" data-linkid="3" href="/ybl4.0/admin/doorl/accountInfo/setEmail.jsp">立即绑定</a>
						</li> -->
					</ul>
	</body>
</html>
