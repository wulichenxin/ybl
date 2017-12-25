<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>岗位管理</title>
<jsp:include page="/ybl/admin/common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/job/jobManagement.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->用户管理 -> 岗位管理</div>
	<div class="vip_conbody">
		<form action="/roleController/list.htm" id="pageForm" method="post">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label>岗位名称:</label><input id="userName" name="name" type="text" /></li>
					<li><div class="button_yellow"><a id="ybl_web_job_search"><spring:message code="sys.admin.search"/></a></div></li>
			        <li><div class="button_gary"><a id="ybl_web_job_reset"><spring:message code="sys.client.reset"/></a></div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->
		<div class="table_box ">
			<div class="table_top ">
				<div class="table_nav">
					<ul>
						<li><sun:button id="ybl_web_role_add_btn" clazz="but_ico7" tag='a' i18nValue='sys.admin.add'/></li>
						<li><sun:button id="ybl_web_role_edit_btn" clazz="but_ico3" tag='a' i18nValue='sys.admin.edit'/></li>
						<li><sun:button id="ybl_web_role_delete_btn" clazz="but_ico1" tag='a' i18nValue='sys.admin.delete'/></li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div id="tablePage" class="table_con ">
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
<%--                                <sun:button id="editRoleBtn" tag='a' clazz='c-yellow mr5 iconEdit' i18nValue='sys.admin.edit' href="javascript:editRole('${bean.code}')"/> 	<!--编辑用户  -->                               --%>
<%--                                <sun:button id="deleteRoleBtn" tag='a' clazz='c-yellow mr5 iconDelete' i18nValue='sys.admin.delete' href="javascript:deleteRole('${bean.code}')"/>	<!--删除用户  --> --%>
                           		<sun:button id="accreditBtn" tag='a' clazz='c-yellow mr5 grant_permission iconEnable' i18nValue='sys.admin.accredit' href="javascript:accreditRole('${bean.id}')"/>	<!--授权  -->
                            </td> 
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