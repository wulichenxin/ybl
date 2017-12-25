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
<script type="text/javascript" src="/ybl4.0/resources/js/doorl/resetPassword.js"></script>
</head>
	<body>
		<div>
			<p class="per_title mb30"><span>修改密码</span><a class="goback" href="#" onClick="javascript :history.go(-1);"><img src="/ybl4.0/resources/images/my/zjf_back_icon.png" /></a></p>
			<div class="business">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">原密码：</label><input class="content-form2" id='oldPassword' /></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">新密码：</label><input class="content-form2" id='newPassword'/></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">确认密码：</label><input class="content-form2" id='nextPassword' /></div>
				</div>
				<div class="w400 mt40">
					<div class="btn-add btn-center mt40" id='member_reset_password_submit_btn'>提交</div>
				</div>
			</div>
			
		</div>
	</body>
</html>
