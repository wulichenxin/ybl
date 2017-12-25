<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>绑定/解绑角色</title>
 	<jsp:include page="/ybl/v2/admin/common/link.jsp"></jsp:include>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>
</head>
<body class="bg_w">
<div class="v2_window">
  <div class="v2_window_con">
			<form action="/v2RoleController/selectRole.htm" method="post" id="pageForm">
			<!-- 授权用户id -->
<input type="hidden" id='userId' name="userId" value='${userId }'/>
<!--搜索条件-->

<div class="v2_seach_box_t" id="submit_box">
 	<ul>
     	<li><label><spring:message code="sys.v2.client.role.name"/><!-- 岗位名称 -->:</label><input type="text" name="name" value="${role.name }" /></li>
        <li><div class="v2_button_seach"><a id="role_set_search_btn"><spring:message code="sys.admin.search"/></a></div></li>
     </ul>
 </div>
 <!--搜索条件-->

	<!--table-->
 <div class="v2_table_box ">
     <!--按钮top-->
     <div class="v2_table_con ">
     			<table cellspacing="0" cellpadding="0" id="tb">
	               <thead>
	                   <tr>
	                       <th><input type="checkbox" id="checkAll"  /></th>
	                       <th><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
	                       <th><spring:message code="sys.v2.client.role.name"/><!-- 角色名称 --></th>
	                       <th><spring:message code="sys.v2.client.role.type"/><!-- 角色类型 --></th>
	                       <th><spring:message code="sys.v2.client.reamrk"/><!-- 角色描述 --></th>                         
	                   </tr>
	               </thead>
	               <tbody>
		               <c:forEach items="${roleList}" var="bean" varStatus="index">
		                   <tr>
		                   		<td><input name="checkbox" type="checkbox" value="${bean.id}" ${bean.attribute1=='1'?"checked":""} /></td>
		                        <td>${index.count}</td>
		              			<td>${bean.name}</td>
		              			<td url="/configController/get-ROLE_TYPE/${bean.type}" textField="value_"></td>
		             			<td>${bean.description}</td>                            
		                   </tr>
		               </c:forEach>    
	               </tbody>
               </table>
        </div>
   	</div>
</form>
  </div>
       	<div class="clear"></div>
        <div class="v2_but_list">
			<a class="bg_l" id="ybl_web_grantRole"><spring:message code="sys.v2.client.confirm"/><!-- 确定 --></a>
			<a class="bg_l" id="ybl_web_grantRoleing" style="display:none" ><spring:message code="sys.v2.client.confirm"/><!-- 确定 --></a>
	  		<a class="bg_l" id="anqu_close" onclick="add_close();"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
	   </div>
</div>
<script type="text/javascript">
$(function(){
	//按条件查询角色
	$("#role_set_search_btn").click(function(){	
		$("#pageForm").submit();
	});
	//确认按钮事件
	$('#ybl_web_grantRole').click(function() {	
		var roleIds="";
		var userId=$("#userId").val();//当前选中授权的用户id
		$('input[name="checkbox"]:checked').each(function(){ 
			roleIds += ($(this).val()+",");	
		});
		if(roleIds.length == 0){
			alert("请选择一条记录");/*请选择一条记录*/
			return;
		};
		$("#ybl_web_grantRole").parent().hide();
		$("#ybl_web_grantRoleing").parent().show();
		$.ajax({
			url:"/v2RoleController/saveGrantRoleUser",
			data:{"userId":userId,"roleIds":roleIds},//参数
			dataType: 'json',
			success:function(data){
				if(data.responseTypeCode="success"){
					alert(data.info,function(){
						parent.$(".msgbox_close").mousedown();
						parent.window.location.reload();
					});
				}else{
					$("#ybl_web_grantRole").parent().show();
					$("#ybl_web_grantRoleing").parent().hide();
					alert(data.info);
				}
			},
			error:function(){
				$("#ybl_web_grantRole").parent().show();
				$("#ybl_web_grantRoleing").parent().hide();
	        	alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*系统繁忙,请联系管理员*/
			}
		}); 
	});
	
	
	
	add_close = function(){
		
		dialog.close();
		
	}
	
	//全选
	$("#checkAll").click(function(){
		var isCheckAll = $("#checkAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkbox"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkbox"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
})
</script>
</body>
</html>
