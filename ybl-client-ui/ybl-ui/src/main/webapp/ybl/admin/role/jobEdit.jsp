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
<jsp:include page="/ybl/admin/common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/job/jobEdit.js"></script>
<title>岗位管理-添加/修改</title>
</head>
<body>
<!--弹出窗登录-->
	<div class="vip_window_con">
	    <div class="clear"></div>
	    <form action="" method="post" id="jobForm">
		    <div class="window_xx">
		    	<ul>
		            <li class="clear">
		            	<div class="input_box"><span><spring:message code="sys.admin.role.code"/>：</span>
		            		<input name="code" value="${role.code }" <c:if test="${!empty role }"> readonly style="background:#CCCCCC" </c:if> placeholder="岗位码"  type="text" required='true' class="text w300"/>
		            		<input name="id" value="${role.id }"  type="hidden" />
		           		</div>
		           	</li>
		            <li class="clear">
		            	<div class="input_box"><span><spring:message code="sys.admin.role.name"/>：</span>
		            		<input name="name" placeholder="岗位名称" value="${role.name }"  type="text" required='true' class="text w300"/>
		           		</div>
		           	</li>
		           	<li class="clear">
		            	<div class="input_box"><span><spring:message code="sys.admin.role.description"/>：</span>
		            		<input placeholder="描述" class="text w300" name="description" value="${role.description }"  type="text" />
		           		</div>
		           	</li>
		    	</ul>
		    	<div class="clear"></div>
		        <div class="w_bottom">
		        	<ul>
		        		<li><sun:button id="ybl_web_job_save_btn" tag='a' clazz="now" i18nValue="sys.admin.save" /></li><!-- 保存 -->
	           			<li><sun:button id="anqu_close" tag='a' clazz="btnB iconEnd1" i18nValue="sys.admin.return.list"/></li><!-- 返回列表 -->
		        	</ul>
		        </div>
		    </div>
	    </form>
	</div>
</body>
</html>