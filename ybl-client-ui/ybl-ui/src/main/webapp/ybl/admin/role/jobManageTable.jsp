<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/job/jobManagement.js"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"id="tb">
	<thead>
    	<tr>
	        <th><input type="checkbox" id="checkAll" /></th>
	       	<th><spring:message code = "sys.admin.serial.number"/></th>		<!-- 序号 -->
			<th><spring:message code = "sys.admin.role.code"/></th>		<!--角色码  -->
			<th><spring:message code = "sys.admin.role.name"/></th>		<!--岗位名称  -->
			<th><spring:message code = "sys.admin.role.description"/></th>		<!--岗位描述  -->
			<th><spring:message code = "sys.admin.operation"/></th>		<!--操作  -->
        </tr>
	</thead>
	<tbody>
		<c:forEach items="${jobList}" var="bean" varStatus="state">
			<tr>
				<td><input name="checkbox"  type="checkbox" value="${bean.id}" /></td>
				<td>${state.count}</td>
				<td>${bean.code}</td>
				<td>${bean.name}</td>
				<td>${bean.description}</td>
				<td>                           		
					<sun:button id="accreditBtn" tag='a' clazz='c-yellow mr5 grant_permission iconEnable' i18nValue='sys.admin.accredit' href="javascript:accreditRole('${bean.id}')"/>	<!--授权  -->
				</td>
			</tr>
		</c:forEach>    
	</tbody>
</table>
<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include>
