
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.menu.manage" /></title><!-- 菜单管理 -->
</head>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/menuManage/menuManage.js" ></script>
<body>
	<form action="/v2MenuController/list.htm" method="post" id='pageForm'>
		<!--top start -->
		<div class="v2_top_bg v2_t_bg2 h357">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
								<a href="/v2RoleController/list.htm"><spring:message code="sys.v2.client.job.manage" /> <!-- 岗位管理 --></a>
								<a href="/v2UserController/list.htm"><spring:message code="sys.v2.client.employee.manage" /> <!-- 人员管理 --></a> 
								<a class="now" href="/v2MenuController/list.htm"><spring:message code="sys.v2.client.menu.manage" /></a><!-- 菜单管理 -->
								<a href="/v2LogController/queryUserLoginLog.htm"><spring:message code="sys.v2.client.log.manage" /> <!-- 日志管理 --></a>
							</div>
						</div>
					</div>
				</div>
				<!---->
				<div class="v2_path"><spring:message code="sys.v2.client.location" /> <!-- 当前位置 -->：
				<spring:message code="sys.v2.client.system.set" /> <!-- 系统设置 --> > 
				<spring:message code="sys.v2.client.menu.manage" /> <!-- 菜单管理 --></div>s
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message code="sys.v2.client.menu.name" /><!--  菜单名称 -->:</label><input type="text" class="w130" name="menuName" value="${menu.menuName }" /></li>

						<li><div class="v2_button_seach">
								<a id="ybl_v2_menu_search_btn"><spring:message code="sys.v2.client.query" /> <!-- 查询 --></a>
							</div></li>
					</ul>
				</div>
				<!--搜索条件-->
			</div>
		</div>
		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><sun:button tag="a" id="ybl_v2_menu_add_btn" clazz="v2_but_add" i18nValue="sys.v2.client.add"></sun:button></li><!-- 新增 -->
							<li><sun:button tag="a" id="ybl_v2_menu_edit_btn" clazz="v2_but_edit" i18nValue="sys.v2.client.edit"></sun:button></li><!--编辑-->
							<li><sun:button tag="a" id="ybl_v2_menu_del_btn" clazz="v2_but_del" i18nValue="sys.v2.client.delete"></sun:button></li><!-- 删除-->
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><input type="checkbox" /></th>
							<th><spring:message code="sys.v2.client.menu.name" /> <!-- 菜单名称 --></th>
							<th><spring:message code="sys.v2.client.super.menu" /> <!-- 上级菜单 --></th>
							<th><spring:message code="sys.v2.client.whether.leaf.node" /> <!-- 是否叶子节点 --></th>
							<th><spring:message code="sys.v2.client.link" /> <!-- 链接 --></th>
							<th><spring:message code="sys.v2.client.remark" /> <!-- 备注 --></th>

						</tr>
						<c:forEach items="${menuList }" var="menu">
							<tr>
								<td><input type="checkbox" name="checkbox" value="${menu.id }" /></td>
								<td>${menu.menuName }</td>
								<td>${menu.attribute1 }</td>
								<td url="/configController/get-YESORNO/${menu.isLeaf}" textField="value_"></td>
								<td>${menu.link }</td>
								<td>${menu.remark }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- page.jsp -->
			<%@include file="/ybl/v2/admin/common/page.jsp"%>
			<!-- page.jsp -->
			<!--table-->
		</div>
	</form>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>