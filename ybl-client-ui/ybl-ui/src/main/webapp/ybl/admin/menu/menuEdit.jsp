<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>菜单管理</title>
    <jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.css" />
    <!-- 树 -->
   	<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<!-- 菜单树js -->
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/menu/fw-menu-edit.js"></script>
</head>
<body>
<!-- 菜单树弹框开始 -->
<ul id="selTree" class="ztree deptTree" 
	style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 
	10px;z-index:10;height: 220px;overflow: auto;margin:-15px -120px;">
</ul>
<!-- 菜单树弹框结束 -->
<form action="/menuController/addOrUpdateMenu" id="menuForm" method="post">
    <!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
			<ul>

				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.menu.no"/>：</span> 
						<input name="menuCode" type="text" placeholder="菜单编号" value="${menu.menuCode }" class="text w300" />
						<input name="id" type="hidden" value="${menu.id }" class="text w300" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.subordinate.subsystem"/>：</span> <input name="subStystemCode" type="text" placeholder="所属子系统"  value="${menu.subStystemCode }"
							class="text w300" />
					</div>
				</li>
				
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.super.menu.no"/>：</span> <input id="parentDepartmentName" name="parentDepartmentName" type="text" placeholder="请选择上级菜单"
							class="text w300" readonly="readonly" style="cursor: pointer;" value="${menu.attribute1 }" />
							<input id="parentId" value="${menu.parentId}" type="hidden" name="parentId" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.menu.name"/>：</span> <input name="menuName" type="text" placeholder="菜单名称"
							class="text w300" value="${menu.menuName }" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.sort"/>：</span> <input name="sortNo" type="text" placeholder="排序"
							class="text w300" value="${menu.sortNo }" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.icon.address"/>：</span> <input name="menuIcon" type="text" placeholder="菜单图标地址"
							class="text w300" value="${menu.menuIcon }" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.link"/>：</span> <input name="link" type="text" placeholder="超链接地址"
							class="text w300" value="${menu.link }" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span><spring:message code="sys.admin.rank"/>：</span> <textarea name="remark" type="text" placeholder="备注"
							class="text w300 h60">${menu.remark }</textarea>
					</div>
				</li>
				
			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
					<li><a id="saveMenuBtn" class="now">保存</a></li>
					<li><a id="anqu_close">取消</a></li>
				</ul>
			</div>
		</div>
	</div>
</form>
</body>
</html>
