<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>部门编辑</title>
	<!-- 公共js css -->
 	<jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
   	<!-- 树 -->
   	<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<!-- 国际化js -->
	<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/i18n/jquery.i18n.properties.mim.js"></script>
	<!-- 部门编辑js -->
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/department/fw-department-edit.js"></script>
</head>
<body>
<!-- 部门树弹框开始-->
<ul id="selTree" class="ztree deptTree" 
	style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 
	10px;z-index:10;height: 220px;overflow: auto;margin:-10px -122px;">
</ul>
<!-- 部门树弹框结束-->
<form action="/departmentController/saveOrUpdate" method="post" id="dataForm">
<input type="hidden" id="departmentId" value="${dept.id}" name='id' />
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
			<ul>

				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.dept.no"/>：</span> 
						<input required name="code" value="${dept.code }" <c:if test="${not empty dept.code }"> disabled=disabled</c:if> id="deptCode" type="text" class="text w300" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.dept.name"/>：</span> 
						<input required name="name" value="${dept.name}" id="deptName" type="text" class="text w300"/>
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.dept.super.no"/>：</span> 
						<input name="parentDepartmentName" placeholder="请选择所属部门" id="parentDepartmentName" readonly="readonly" style="cursor: pointer;" type="text" class="text w300" value='${parentDept.name}'/>
	                    <input id="parentId" value="${dept.parentId}" type="hidden" name="parentId" />
					</div>
				</li>
			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
					<li><sun:button id="saveDepartBtn" tag='a' clazz="btnB icon_ok_b now" i18nValue="sys.admin.save" /></li>
					<li><sun:button id="returnDapartBtn" tag='a' clazz="btnB" i18nValue="sys.admin.return.list"/></li>
				</ul>
			</div>
		</div>
	</div>
</form>    
</body>
</html>
