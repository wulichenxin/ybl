<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>权限管理-添加</title>
<jsp:include page="/ybl/admin/common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/permission/permissionEdit.js"></script>
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<form action="" method="post" id="permissionForm">
			<div class="window_xx">
				<ul>
					<li class="clear">
						<div class="input_box"><span><spring:message code="ybl.web.permission.no"/>：</span>
		            		<input name="buttonId" value="${permission.buttonId }" <c:if test="${!empty permission }"> readonly style="background:#CCCCCC" </c:if> placeholder="权限按钮id"  type="text" required='true' class="text w300"/>
		            		<input name="id" value="${permission.id }"  type="hidden" />
		           		</div>
					</li>
					<li class="clear">
						<div class="input_box"><span><spring:message code="ybl.web.permission.name"/>：</span>
			            	<input name="buttonName" placeholder="权限按钮名称" value="${permission.buttonName }"  type="text" required='true' class="text w300"/>
			           	</div>
					</li>
				</ul>
				<div class="clear"></div>
				<div class="w_bottom">
					<ul>
			        	<li><sun:button id="ybl_web_permission_save_btn" tag='a' clazz="now" i18nValue="sys.admin.save" /></li><!-- 保存 -->
		           		<li><sun:button id="anqu_close" tag='a' clazz="btnB iconEnd1" i18nValue="sys.admin.return.list"/></li><!-- 返回列表 -->
			        </ul>
				</div>
			</div>
		</form>
	</div>
</body>
</html>