<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title><spring:message code="sys.v2.client.role.management"/></title><!-- 角色管理 -->
<jsp:include page="../../common/link.jsp"></jsp:include>
<!-- 表单验证 -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src='${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
	<script type="text/javascript">
		$(function(){
			
			var _form = ext.formValidation("roleForm");
			
			//保存按钮
			$("#saveRoleBtn").click(function(){
				// 检验页面参数是否符合要求
				var passed = _form.validationEngine("validate");
				if (!passed) {
					return;
				}
				
				var formdata=$('#roleForm').serialize();//序列化表单
				
				$("#saveRoleBtn").hide();
				$("#saveRoleingBtn").show();
				
				$.ajax({
					url:'/v2RoleController/saveOrUpdate',
					dataType:'json',
					type:'post',
					data:formdata,
					success:function(value){
						if(value.success){
							alert(value.info,function(){
								parent.window.location.href="/v2RoleController/list.htm" ;
							})
						}else{
							$("#saveRoleBtn").show();
							$("#saveRoleingBtn").hide();
							alert(value.info);
						}
					},
					error:function(){
						$("#saveRoleBtn").show();
						$("#saveRoleingBtn").hide();
						alert($.i18n.prop("sys.v2.client.operationFail"));/*操作失败*/
					}
				}); 
			});
			//返回列表按钮
			$("#returnMenuListBtn").click(function(){
				parent.window.location.href="/v2RoleController/list.htm";
				
			});
		});
</script>
</head>
<body class="bg_w">
	<form action="/roleController/saveOrUpdate" method="post" id="roleForm">
	<div class="v2_window_con">
	   <ul style="height:300px;">
	       <li>
	            <div class="v2_input_box"><span><i class='red'>*</i><spring:message code="sys.v2.client.role.name" /><!-- 角色名称 -->：</span>
	            	<input  type="text" class="w300 v2_text validate[required,maxSize[50]]" name="name" value="${role.name }"/>
	            	<input  type="hidden" name="id" value="${role.id}" />
	            </div>
	       </li>
	       <li >
	            <div class="v2_input_box ">
	            	<span><i class='red'>*</i><spring:message code="sys.v2.client.role.type" /><!-- 角色类型 -->：</span>
	            <div class="v2_select_box mb20">
								<select class="v2_select w320 validate[required]"
									name="type" id="type"
									url="/configController/get-ROLE_TYPE" valueFiled="code_"
									textField="value_" defaultValue="${role.type }"
									isSelect="Y">
								</select>
							</div></div>
	       </li>
	        <li class="clear">
	            <div class="v2_input_box"><span><spring:message code="sys.v2.client.remark" /><!-- 描述 -->：</span><textarea  name="description" class="v2_text_tea h100 w500 validate[required,maxSize[500]]">${role.description }</textarea></div>
	       </li>
	    </ul>
	  </div>
	    <div class="v2_but_list">
			<a href="javascript:void(0);" id="saveRoleBtn" class="bg_l"><spring:message code="sys.v2.client.save" /><!-- 保存 --></a>
			<a href="javascript:void(0);" id="saveRoleingBtn"  style="display:none" class="bg_l"><spring:message code="sys.v2.client.saving" /><!-- 保存中 --></a>
		    <a href="javascript:void(0);" id="returnMenuListBtn" class="bg_l"><spring:message code="sys.v2.client.cancel" /><!-- 返回 --></a>
		</div>
	</form> 
</body>
</html>
