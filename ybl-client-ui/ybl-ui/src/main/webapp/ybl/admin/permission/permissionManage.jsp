<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>权限管理</title>
<jsp:include page="/ybl/admin/common/link.jsp" />
<!--弹出框-->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/permission/permissionManage.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->用户管理 -> 权限管理</div>
	<form action="/permissionController/list.htm" id="pageForm" method="post">
		<div class="vip_conbody">
			<!--搜索条件-->
			<div class="seach_box" id="submit_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				<div class="fl">
					<ul>
			        	<li><label>权限名称:</label><input name="buttonName" id="buttonName" type="text" /></li>
			            <li><div class="button_yellow"><a id="ybl_web_permission_search"><spring:message code="sys.admin.search"/></a></div></li>
			            <li><div class="button_gary"><a id="ybl_web_permission_reset"><spring:message code="sys.client.reset"/></a></div></li>
			        </ul>
				</div>
			</div>
			<!--搜索条件-->
	
			<!--table-->
			<div class="table_box ">
				<div class="table_top ">
					<div class="table_nav">
						<ul>
							<li><sun:button id="ybl_web_permission_add_btn" clazz="but_ico7" tag='a' i18nValue='sys.admin.add'/></li>
							<li><sun:button id="ybl_web_permission_edit_btn" clazz="but_ico3" tag='a' i18nValue='sys.admin.edit'/></li>
							<li><sun:button id="ybl_web_permission_delete_btn" clazz="but_ico1" tag='a' i18nValue='sys.admin.delete'/></li>
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div id="tablePage" class="table_con ">
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
	                            <%-- <td>
	                            	<sun:button id='edit_${index.count }' tag='a' clazz="c-yellow mr5 iconEdit" i18nValue="sys.admin.edit" href="javascript:editById('${bean.buttonId}')"/><!-- 编辑 -->
	                    			<sun:button id='delete_${index.count }' tag='a' clazz="c-yellow mr5 iconDelete" i18nValue="sys.admin.delete" href="javascript:deleteById('${bean.id}')"/><!-- 删除 -->                              
	                            </td> --%>
	                        </tr>
	                     </c:forEach>    
	                    </tbody>
	                </table>
					<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</form>
	<!--table-->
	<!-- 底部jsp -->
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>