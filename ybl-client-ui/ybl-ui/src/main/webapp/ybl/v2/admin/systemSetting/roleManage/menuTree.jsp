<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>角色编辑</title>
<jsp:include page="/ybl/v2/admin/common/link.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.css" />
   	<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/roleManage/menuTreeEdit.js"></script>
<style>
 .save_role{
 	margin:10px 30px;
 }
 .return_role{
 	margin:10px 30px;
 }
 .dw{ position:absolute; top:-20px; left:-50px;}
</style>
</head>
<body class="bg_w">
	<ul id="selTree" class="ztree deptTree" style="height: 300px;position: absolute;top: 100px;left: 80px;width:60%;"></ul>
	<div class="v2_but_list">
	 	<form method="post" id="roleMenuForm">
	     	<input type="hidden" name="roleid" id="roleid" value="${roleId }"/>
	     	<input type="hidden" name="meunlist" id="meunlist"/>
			<a class="bg_l" id="saveRoleBtn"><spring:message code="sys.v2.client.save"/></a>
			<a class="bg_l" id="ybl_web_grantRoleing" style="display:none" ><spring:message code="sys.v2.client.confirm"/><!-- 确定 --></a>
	  		<a class="bg_g" id="anqu_close"><spring:message code="sys.v2.client.cancel"/></a>
	  	</form>
	</div>
</body>
</html>
