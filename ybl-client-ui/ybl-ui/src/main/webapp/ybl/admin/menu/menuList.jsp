<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>菜单管理</title>
<jsp:include page="/ybl/admin/common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/menu/menuManagement.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->用户管理 -> 菜单管理</div>
	<div class="vip_conbody">
		<form action="/menuController/list.htm" id="pageForm" method="post">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label>菜单名称:</label><input id="menuName" name="menuName" type="text" /></li>
					<li><div class="button_yellow"><a id="ybl_web_menu_search"><spring:message code="sys.admin.search"/></a></div></li>
			        <li><div class="button_gary"><a id="ybl_web_menu_reset"><spring:message code="sys.client.reset"/></a></div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->
		<div class="table_box ">
			<div class="table_top ">
				<div class="table_nav">
					<ul>
						<li><sun:button id="ybl_web_menu_add_btn" clazz="but_ico7" tag='a' i18nValue='sys.admin.add'/></li>
						<li><sun:button id="ybl_web_menu_edit_btn" clazz="but_ico3" tag='a' i18nValue='sys.admin.edit'/></li>
						<li><sun:button id="ybl_web_menu_delete_btn" clazz="but_ico1" tag='a' i18nValue='sys.admin.delete'/></li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div id="tablePage" class="table_con ">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"id="tb">
					<thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" /></th>
                            <th><spring:message code = "sys.client.no"/></th>		<!-- 序号 -->
                            <th><spring:message code = "sys.client.menu.name"/></th>		<!--菜单名称  -->
                            <th><spring:message code = "sys.client.super.menu"/></th>		<!--上级菜单  -->
                            <th><spring:message code = "sys.client.whether.leaf.node"/></th>		<!--是否是叶子节点  -->
                            <th><spring:message code = "sys.client.link"/></th>		<!--链接  -->
<%--                             <th><spring:message code = "sys.client.operation"/></th>		<!--操作  --> --%>
                        </tr>
                    </thead>
					<tbody>
                     <c:forEach items="${menuList}" var="items" varStatus="index">
                        <tr>
                        	<td><input name="checkbox" type="checkbox" value="${items.id }" /></td>
                        	<td>${index.count}</td>
                    		<td>${items.menuName}</td>
                    		<td>${items.attribute1}</td><!-- 父菜单的名称暂用attribute1传递，但不存入数据库 -->
                    		<td>
	                    		<c:if test='${items.isLeaf==1}'><spring:message code="sys.client.yes"/></c:if>
	                    		<c:if test='${items.isLeaf==0}'><spring:message code="sys.client.menu.noleaf"/></c:if>
                    		</td>
                    		<td>${items.link}</td>
                    		<%-- <td>${items.subStystemCode}</td> --%>
<%--                     		<td>${items.sortNo}</td> --%>
<!--                     		<td> -->
<%-- 	                    		<sun:button id='edit_${index.count }' tag='a' clazz="c-yellow mr5 iconEdit" i18nValue="sys.admin.edit" href="javascript:editMenuById('${items.id}')"/><!-- 编辑 --> --%>
<%-- 	                    		<sun:button id='delete_${index.count }' tag='a' clazz="c-yellow mr5 iconDelete" i18nValue="sys.admin.delete" href="javascript:deleteMenuById('${items.id}')"/><!-- 删除 --> --%>
<!--                     		</td> -->
                        </tr>
                     </c:forEach>    
                    </tbody>
				</table>
				<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include>
			</div>
		</div>
		</form>
	</div>
	<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>