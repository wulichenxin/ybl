<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/userManagement/emploeeManage.js"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
	<thead>
    	<tr>
	       	<th><input id="checkAll" name="checkAll" type="checkbox"/></th>
	        <th><spring:message code="sys.admin.serial.number"/></th>
	        <th><spring:message code="sys.admin.user.name"/></th>
	        <th><spring:message code="sys.admin.name"/></th>
	        <th><spring:message code="sys.admin.sex"/></th>
	        <th><spring:message code="sys.admin.phone"/></th>
	        <th><spring:message code="sys.admin.cellphone.number"/></th>
	        <th><spring:message code="sys.admin.role"/></th>
	        <th><spring:message code="sys.admin.dept.name"/></th>
	        <th>状态</th>
	        <th><spring:message code="sys.admin.operation"/></th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${userList}" var="user" varStatus="status" >
			<tr>
				<td><input name="checkbox" type="checkbox" value="${user.id }" /></td>
    			<td>${status.count }</td> 				<!--序号  -->
    			<td>${user.userName }</td>			<!--用户账号  -->
    			<td>${user.realName }</td>				<!--用户名称  -->
    			<td>
    				<c:if test="${user.gender !='M' && user.gender !='F' }">未知</c:if> <!--用户性别  -->
    				<c:if test="${user.gender=='M' }">男</c:if>
    				<c:if test="${user.gender=='F' }">女</c:if>
    			</td>
    			<td>${user.telephone }</td>
    			<td>${user.telephone }</td>
    			<td>${user.attribute2 }</td>	<!--岗位角色  -->
    			<td>${user.attribute1 }</td>	<!--所属部门  -->
    			<td>
    				<c:if test="${user.status =='normal'}">
    					正常
    				</c:if>
    				<c:if test="${user.status =='freeze'}">
    					冻结
    				</c:if>
    				<c:if test="${user.status =='logout'}">
    					注销
    				</c:if>
    			</td>
   				<td>
		      		<c:if test="${user.status =='normal'}">
		      			 <sun:button tag='a' id='sys.customer.editUserBtn_${status.count }' clazz='c-yellow mr5 iconEdit' i18nValue='sys.admin.edit' href="javascript:editById('${user.userName }')"/>										<!--编辑用户  -->	  
		      			 <sun:button tag='a' id='sys.customer.cancelUserBtn_${status.count }' clazz='c-yellow mr5 icon_zx' i18nValue='sys.admin.cancellation' href="javascript:updateUserStatusById('${user.userName}','logout','${user.id}','${page.currentPage }')"/>	<!--注销用户  -->   
		      			 <sun:button tag='a' id='sys.customer.frozenUserBtn_${status.count }' clazz='c-yellow mr5 iconDisable' i18nValue='sys.admin.frozen' href="javascript:updateUserStatusById('${user.userName}','freeze','${user.id}','${page.currentPage }')"/>		<!--冻结用户  -->  
		      			 <sun:button tag='a' id='sys.customer.editUserBtn_${status.count }' clazz='c-yellow mr5 grant_role iconSet' i18nValue='sys.admin.grant.user.role' href="javascript:grantRole('${user.id}',this)"/>							<!--绑定角色 -->	    
		       			 <sun:button tag='a' id='sys.customer.editUserBtn_${status.count }' clazz='c-yellow mr5 grant_permission iconEnable' i18nValue='sys.admin.accredit' href="javascript:grantPermission('${user.id}',this)"/>							<!--授权  -->	        		                        		                    
		      		</c:if>
			        <c:if test="${user.status !='normal' }"> 
			        	 <sun:button tag='a' id='enableUserBtn_${status.count }' clazz='c-yellow mr5 iconEnable' i18nValue='sys.admin.enable' href="javascript:updateUserStatusById('${user.userName }','normal','${user.id}','${page.currentPage }')"/>		<!--启用用户  -->	                       
			        </c:if> 
    			</td> 
			</tr>
	    </c:forEach>
	</tbody>
</table>
<jsp:include page="../../common/page.jsp"></jsp:include>