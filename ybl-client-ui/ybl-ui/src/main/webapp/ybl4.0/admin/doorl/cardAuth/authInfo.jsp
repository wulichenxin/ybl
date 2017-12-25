<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
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
	<p class="per_title"><span>身份认证</span><a class="goback" href="#" onClick="javascript :history.go(-1);"><img src="/ybl4.0/resources/images/my/zjf_back_icon.png" /></a></p>
	<table class="tabD2 lh40">
		<tr>
			<td>机构信息认证</td>
			<c:if test="${status eq 'examine'}"><td><a href="/accountInfoController/authLook.htm" class="color-yellow">审核中</a></td></c:if>
			<c:if test="${status eq 'adopt'}"><td><a href="javascript:;" class="color-yellow">审核成功</a></td></c:if>
			<c:if test="${status eq 'nopass'}"><td><a href="/ybl4.0/admin/doorl/cardAuth/authInfoTable.jsp" class="color-yellow rz-link">认证</a></td></c:if>
		</tr>
	</table>
</body>
</html>
