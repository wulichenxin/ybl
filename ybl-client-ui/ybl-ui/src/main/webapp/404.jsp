<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>404-无法找到页面</title>
<style>
.error_bg{ background:url(/base/resources/images/error_bg.jpg) top center no-repeat; width:100%; background-color:#191d3a;}
.error_box{ width:1200px; margin:50px auto;}
.error_left{ float:left; width:389px; height:425px; margin:60px;}	
.error_500pic{background:url(/base/resources/images/500_pic.png) no-repeat; }
.error_404pic{background:url(/base/resources/images/404_pic.png) no-repeat; }
.error_right{ margin-top:80px; width:600px; float:left;}
.error_right h1{ color:#fee534; font-size:100px; line-height: 40px;}
.error_right h2{ font-size:24px; color:#fff;}
.error_but{ margin-top:30px;}
.error_but a{background:url(/base/resources/images/error_but.png) no-repeat; height:60px; width:193px; line-height: 56px; color: #9f5c16; display: block; float:left; margin-right:30px; text-align: center; font-size:24px; cursor: pointer;}
.error_de { color:#fff; width:1200px; height:300px; overflow:auto; display:none;}
.error_de h3{ font-size:18px; color:#fff;}
.error_de p{ color:#fff; line-height: 24px;}
	
</style>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js'></script>
</head>
<body class="error_bg">
<div class="error_box">
	<div class="error_left error_404pic"></div>
	<div class="error_right">
		<h1>sorry~</h1>
		<h2>您访问的页面出现异常！</h2>
		<div class="error_but" ><a href="javascript:history.go(-1);">返回上一页</a><a  href="<%=basePath%>">返回首页</a></div>
	</div>
</div>
<script>
	$(function() {
		$("#showException").click(function() {
			$(".error_de").show();
		});
	});
</script>
</body>
</html>