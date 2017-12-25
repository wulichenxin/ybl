<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.role.management" /></title>
<!-- 角色管理 -->
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<!--top start -->
	<%-- <jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />		 --%>
	<jsp:include page="/ybl4.0/admin/common/top.jsp" />
<!--top end -->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/roleManage/roleManage.js"></script>
</head>
<body>
	<form action="/v2RoleController/list.htm" id="pageForm" method="post">
	
	<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />角色管理</div>
		</div>
	<div class="w1200">
 		</div>
			<!--搜索条件-->
			<div class="v2_seach_box" style="width:1200px;padding-left:0px">
				<ul>
					<li><label><spring:message code="sys.v2.client.role.name" /><!-- 角色名称 -->:</label><input type="text" name="name" value="${role.name }"/></li>
					<li><label><spring:message code="sys.v2.client.role.type" /><!-- 角色类型 -->:</label>
						<select  name="type" id="type"
							url="/configController/get-ROLE_TYPE" valueFiled="code_"
							textField="value_" defaultValue="${role.type}"
							isSelect="Y">
						</select>
					</li>
					<li><div class="btn-modify" id="roleSerachBtn">查询</div></li>
				</ul>
			</div>
		</div>
	</div>
		
		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><sun:button id="ybl_v2_web_role_add_btn"
									clazz="v2_but_add" tag='a' i18nValue='sys.v2.client.add' /></li>
							<li><sun:button id="ybl_v2_web_role_edit_btn"
									clazz="v2_but_edit" tag='a' i18nValue='sys.v2.client.edit' /></li>
							<li><sun:button id="ybl_v2_web_role_delete_btn"
									clazz="v2_but_del" tag='a' i18nValue='sys.v2.client.delete' /></li>
							<li><sun:button id="ybl_v2_web_accredit_role_btn"
									clazz="v2_but_qx" tag='a' i18nValue='sys.v2.client.authority' /></li>
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><input type="checkbox" id="checkAll" /></th>
							<th width="200"><spring:message
									code="sys.v2.client.role.name" />
								<!-- 角色名称 --></th>
							<th width="300"><spring:message
									code="sys.v2.client.role.type" />
								<!-- 角色类型 --></th>
							<th><spring:message code="sys.v2.client.remark" />
								<!-- 备注 --></th>
						</tr>
						<c:forEach items="${jobList}" var="bean" varStatus="state">
							<tr>
								<td><input name="checkbox" type="checkbox"
									value="${bean.id}" /></td>
								<td>${bean.name}</td>
								<td url="/configController/get-ROLE_TYPE/${bean.type}"
									textField="value_"></td>
								<td>${bean.description}</td>
							</tr>
						</c:forEach>
					</table>
				</div>

			</div>
			<div class="v2_pages">
				<%-- <%@include file="/ybl/v2/admin/common/page.jsp"%> --%>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</div>
			<!--table-->
		</div>
	</form>
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
</body>
</html>