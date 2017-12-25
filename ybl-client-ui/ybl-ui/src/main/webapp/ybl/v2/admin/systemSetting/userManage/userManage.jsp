
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<!--top start -->
	<%-- <jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />		 --%>
	<jsp:include page="/ybl4.0/admin/common/top.jsp" />
<!--top end -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/userManage/userManage.js"></script>
<title>用户管理 </title><!-- 员工管理 -->
</head>
<body>	
   <form action="/v2UserController/list.htm" id="pageForm" method="post">
	<div class="Bread-nav">
		<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />用户管理</div>
	</div>
	<!--搜索条件-->
		<div class="v2_seach_box" style="width:1200px;padding-left:0">
			<ul>
				<li><label><spring:message code="sys.v2.client.member.userName"/><!-- 用户名称 -->:</label><input type="text" class="w130" name="userName" value="${user.userName}"/></li>
				<li><label><spring:message code="sys.v2.client.member.real.name"/><!-- 真实姓名 -->:</label><input type="text" class="w130" name="realName" value="${user.realName }" /></li>
				<li><label><spring:message code="sys.v2.client.sex"/><!-- 性别 -->:</label>
					<select name="sex"  class="w130"
						url="/configController/get-SEX" valueFiled="code_"
							textField="value_" defaultValue="${user.sex}"
							isSelect="Y">
					</select>
				</li>
				<li><label><spring:message code="sys.v2.client.has.roles"/><!-- 拥有角色 -->:</label>
					<select   class="w130"
					  name="roleId" id="roleId"
							url="/v2RoleController/queryRoleInfoByCondition" valueField="id_"
							textField="name_" defaultValue="${user.roleId }"
							isSelect="Y">
					</select>
				</li>
				<li><div class="btn-modify" id="userManage_serach_btn">查询</div></li>
			</ul>
		</div>	
	<div class="v2_vip_conbody">
    <!--table-->
    <div class="v2_table_box">
    	<div class="v2_table_top">
			<div class="v2_table_nav">
				<ul>
					<li><sun:button tag='a' clazz="v2_but_add" id="userManage_add_btn" i18nValue="sys.v2.client.add"></sun:button></li><!-- 新增 -->
					<li><sun:button tag='a' clazz="v2_but_del" id="userManage_delete_btn" i18nValue="sys.v2.client.delete"></sun:button></li><!-- 删除 -->
					<li><sun:button tag='a' clazz="v2_but_edit" id="userManage_edit_btn" i18nValue="sys.v2.client.edit"></sun:button></li><!-- 编辑 -->
					<li><sun:button tag='a' clazz="v2_but_set" id="userManage_set_role_btn" i18nValue="sys.v2.client.role.set"></sun:button></li><!-- 设置角色 -->
				</ul>
			</div>
		</div>
        <!--按钮top-->
        <div class="v2_table_con">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th width="50"><input type="checkbox" id="checkAll"/></th>
                <th><spring:message code="sys.v2.client.phone"/><!-- 手机号码 --></th>
                <th><spring:message code="sys.v2.client.member.real.name"/><!-- 真实姓名 --></th>
                <th><spring:message code="sys.v2.client.sex"/><!-- 性别 --></th>
                <th><spring:message code="sys.v2.client.email"/><!-- 邮箱 --></th>
                <th><spring:message code="sys.v2.client.has.roles"/><!-- 属于角色 --></th>
                <th><spring:message code="sys.v2.client.member.status"/><!-- 用户状态 --></th>
              </tr>
			  <c:forEach items="${userList}" var="user" >
	              <tr>
					<td><input type="checkbox" name="checkbox" value="${user.id }" isAdmin="${user.isAdmin }" /></td>
	                <td>${user.telePhone }</td>
	                <td>${user.realName }</td>
	                <td url="/configController/get-SEX/${user.sex}" textField="value_"></td>
	                <td>${user.email }</td>
	                <td>${user.attribute2 }</td>
	                <td url="/configController/get-USER_STATUS/${user.status}" textField="value_"></td>
                </tr>
			 </c:forEach>	
            </table>
        </div>
    </div>
    <div class="v2_pages">
    	<%@include file="/ybl/v2/admin/common/page.jsp" %>
    </div>
	<!--table-->
    </div>
    </form>
    <%@include file="/ybl/v2/admin/common/bottom.jsp"%>
</body>
</html>