<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>角色编辑</title>
<jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.css" />
   	<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/job/job-menu-edit.js"></script>
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
<body style="background:#fff;">
	<ul id="selTree" class="ztree deptTree" style="height: 100%;position: absolute;top: 100px;left: 80px;width:60%;"></ul>
	
		<div class="w_bottom dw">
		 <form method="post" id="roleMenuForm">
	     	<input type="hidden" name="roleid" id="roleid" value="${roleId }"/>
	     	<input type="hidden" name="meunlist" id="meunlist"/>
	     	<ul>
				<li><a id="saveRoleBtn" class="now">保存</a></li>
				<li><a id="anqu_close" onclick="add_close();">取消</a></li>
			</ul>
<%-- 	     	<li><sun:button id="returnRoleListBtn" tag='a' clazz="btnB fl return_role" i18nValue="sys.admin.return.list"/></li><!-- 返回列表 -->            --%>
<%-- 	     	<li><sun:button id="saveRoleBtn" tag='a' clazz="btnB fl icon_ok_b save_role now" i18nValue="sys.admin.save" /></li><!-- 保存 --> --%>
<%-- 	     	<li><sun:button id="returnRoleListBtn" tag='a' clazz="btnB fl return_role" i18nValue="sys.admin.return.list"/></li><!-- 返回列表 -->            --%>
	     </form>
     	</div>
	
</body>
</html>
