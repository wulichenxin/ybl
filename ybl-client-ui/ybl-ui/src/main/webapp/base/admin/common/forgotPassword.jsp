<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title>催收宝</title>
<meta name="Keywords" content="催收宝">
<meta name="Description" content="催收宝">
<meta name="Copyright" content="催收宝" />
<link href="/fw/resources/css/login.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/fw/resources/js/jquery-1.8.0.min.js"></script>

</head>
<body>

<!--top-->
<!--top-->
<!--logo+menu-->
<div class="head_mm">
<div class="top_head">
	<div class="logo"><a href="index.html"></a><span>重置登录密码</span></div>
	<div class="mm_nav">
    	<ul>
        	<li><a href="register.jsp">注册</a></li>
            <li class="now"><a href="/index.jsp"><span>登录</span></a></li>      
        </ul>
    </div>
</div>
</div>
<!---->

<div class="mm_box">
	<div class="mm_con">
		<h1>请输入您需要重置登录密码</h1>
    	<div class="mmtext">
           	<ul>
            	<li><span>用户名：</span><input placeholder="请输入用户名" type="text" class="mm_text"/></li>
                <li><span>验证码：</span><input placeholder="请输入验证码" type="text" class="mm_text1"/><div class="yzm fl">
                	<img id="validCodeImg" src="/jcaptcha" style="cursor:pointer" onclick="this.src='/jcaptcha?_timestamp=' + new Date().getTime()" />
                </div><div class="shuaxing"><a id="refreshBtn">刷新</a></div></li>
                <li><div class="next_but"><a>下一步</a></div></li> 
            </ul>
        </div>
	</div>
</div>

<script>
	$(function() {
		$("#refreshBtn").click(function() {
			$("#validCodeImg").click();
		});
	});
</script>

</body>


</html>
