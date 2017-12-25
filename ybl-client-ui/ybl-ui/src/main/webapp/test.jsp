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
<title>测试</title>
<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js'></script>
</head>
<body class="error_bg">
<div class="error_box">
	<div style="width: 100px;height: 200px;" id="content"></div>
</div>
<script>
	$(function() {
		$.ajax({
			cache : true,
			type : "POST",
			url : '/factorRiskManagementController/firstAudit/list.htm',
			async : false,
			dataType : 'html',
			error : function(request) {
				alert('获取列表失败！');
			},
			success : function(data) {
				$("#content").html(data);
			}
		});
	});
</script>
</body>
</html>