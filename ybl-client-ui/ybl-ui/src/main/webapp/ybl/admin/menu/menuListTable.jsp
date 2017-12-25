<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/menu/menuManagement.js"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"id="tb">
	<thead>
        <tr>
            <th><input type="checkbox" id="checkAll" /></th>
            <th><spring:message code = "sys.client.no"/></th>		<!-- 序号 -->
            <th><spring:message code = "sys.client.menu.name"/></th>		<!--菜单名称  -->
            <th><spring:message code = "sys.client.super.menu"/></th>		<!--上级菜单  -->
            <th><spring:message code = "sys.client.whether.leaf.node"/></th>		<!--是否是叶子节点  -->
            <th><spring:message code = "sys.client.link"/></th>		<!--链接  -->
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
           </tr>
        </c:forEach>    
	</tbody>
</table>
<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include>