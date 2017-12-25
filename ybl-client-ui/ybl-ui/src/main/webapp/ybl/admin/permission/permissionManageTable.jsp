<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/permission/permissionManage.js"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
	<thead>
	    <tr>   
	    	<th><input type="checkbox" id="checkAll" /></th>                    
	        <th><spring:message code="sys.admin.number"/></th><!-- 序号 -->
	        <th><spring:message code="ybl.web.permission.no"/></th><!-- 权限编号 -->
	        <th><spring:message code="ybl.web.permission.name"/></th><!-- 权限名称 -->
	        <th><spring:message code="ybl.web.creater"/></th> <!-- 创建人 -->
	        <th><spring:message code="ybl.web.createTime"/></th> <!-- 创建时间 -->
	       <%--  <th><spring:message code="sys.admin.operate"/></th> --%><!-- 操作 -->
	    </tr>
	</thead>
	<tbody>
		<c:forEach items="${permissionList}" var="bean" varStatus="index">
			<tr>
				<td><input name="checkbox"  type="checkbox" value="${bean.id}" /></td>
			   	<td>${index.count}</td>
			   	<td>${bean.buttonId}</td>
			   	<td>${bean.buttonName}</td>
			   	<td>${bean.attribute1}</td>
			   	<td><fmt:formatDate value="${bean.createdTime}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>    
	</tbody>
</table>
<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include>