<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<!-- 树 -->
<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>

<!-- 表单验证 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>

<!-- 加载菜单树 -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/menuManage/editMenu.js"></script>

<title>Insert title here</title>

</head>
<body>
<!-- 菜单树弹框开始 -->
<ul id="selTree" class="ztree deptTree" 
	style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 
	10px;z-index:10;height: 220px;overflow: auto;margin:-116px -120px;">
</ul>
	<form id="menuForm" >
	<div class="v2_window">
		<div class="v2_window_con">
			<ul>
				<%-- <li class="clear">
					<div class="v2_input_box">
						<span><spring:message code="sys.v2.client.menu.no" /> <!-- 菜单编号 -->：</span> <input type="text" placeholder="" name="menuCode"  value="${menu.menuCode }"
							class="v2_text w300 validate[required]" />
					</div>
				</li> --%>
				<!-- <li class="clear">
					<div class="v2_input_box">
						<span>所属子系统：</span> <input type="text" placeholder=""
							class="v2_text w300" />
					</div>
				</li> -->
				<input  type="hidden" name="id" value="${menu.id }" />
				<li class="clear">
					<div class="v2_input_box">
						<span><spring:message code="sys.v2.client.super.menu.no" /><!-- 上级菜单编号 -->：</span> <input id="parentDepartmentName" name="parentDepartmentName" type="text" placeholder=""
							class="v2_text w300" readonly="readonly" style="cursor: pointer;" value="${menu.attribute1 }" />
							<input id="parentId" value="${menu.parentId}" type="hidden" name="parentId" />
					</div>
				</li>
				<li class="clear">
					<div class="v2_input_box">
						<span><i class="red">*</i><spring:message code="sys.v2.client.menu.name" /><!-- 菜单名称 -->：</span> <input type="text"  name="menuName" value="${menu.menuName }"
							class="v2_text w300 validate[required] " />
					</div>
				</li>
				<%-- <li class="clear">
					<div class="v2_input_box">
						<span><spring:message code="sys.v2.client.sort" /><!-- 排序 -->：</span> <input type="text" placeholder="" name="sortNo" value="${menu.sortNo }" 
							class="v2_text w300 validate[required]" />
					</div>
				</li> --%>
				<!-- <li class="clear">
					<div class="v2_input_box">
						<span>图标地址：</span> <input type="text" placeholder=""
							class="v2_text w300" />
					</div>
				</li> -->
				<li class="clear">
					<div class="v2_input_box">
						<span><i class="red">*</i><spring:message code="sys.v2.client.link" /><!-- 链接 -->：</span> <input type="text" placeholder=""  name="link" value="${menu.link }" 
							class="v2_text w300 validate[required]" />
					</div>
				</li>
				<li class="clear">
					<div class="v2_input_box">
						<span><spring:message code="sys.v2.client.remark" /><!-- 备注 -->：</span>
						<textarea name="remark" class="v2_text_tea h100 w300  validate[maxSize[200]]">${menu.remark }</textarea>
					</div>
				</li>
			</ul>
		</div>
		<div class="v2_but_list">
			<a class="bg_l" id="saveMenuBtn"><spring:message code="sys.v2.client.save" /><!-- 保存 --></a>
			<a class="bg_l" id="saveMenuingBtn" style="display:none" ><spring:message code="sys.v2.client.saving" /><!-- 保存中... --></a>
			<a class="bg_g" id="anqu_close"><spring:message code="sys.v2.client.cancel" /><!-- 取消 --></a>
		</div>
	</div>
	</form>
</body>
</html>