<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>权限管理</title>
<!-- 公共js css -->
<jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
<!-- 功能js css -->
<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
<!--弹框js -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.hDialog.min.js"></script>
<script type="text/javascript">
$(function(){
	//表单查询
// 	$("#searchOperateProBtn").click(function(){
// 		$("#pageForm").submit();
// 	});	
	
	$("#ybl_web_permission_search").click(function(){
		var buttonName = $("#buttonName").val();
		$.ajax({
			url:"/permissionController/loadPermissionInfoByName?buttonName=" + buttonName,
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	//重置查询条件
	$("#ybl_web_permission_reset").click(function(){
		$.ajax({
			url:"/permissionController/loadPermissionInfoByName",
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	
	//确认按钮事件
	$('#btn-tab1-save').click(function() {	
		saveGrantPromission();
	});
	
	//取消按钮事件
	$('#btn-upload-cancel').click(function() {	
		parent.$(".msgbox_close").mousedown();
	});
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
//保存授权信息
function saveGrantPromission(){
	var promissionIds="";
	var userId=$("#userId").val();//当前选中授权的用户id
	var userName=$("#userName").val();//当前选中授权的用户id
	$('input[name="checkbox"]:checked').each(function(){ 
		promissionIds += ($(this).val()+",");	
	});
	$.ajax({
		url:"/permissionController/saveGrantPromissionUser",
		data:{
			"userId":userId,
			"promissionIds":promissionIds,
			"userName":userName
			},//参数
		dataType: 'json',
		success:function(data){
			if(data.responseTypeCode == "success"){
				alert(data.info,function(){
					parent.$(".msgbox_close").mousedown();
					parent.callBackReflush();
				});
			}else{
				alert(data.info);
			}
// 			parent.closeGrantPromissionDiv();//关闭弹框
		},
		error:function(){
        	alert("系统忙")
		}
	}); 
}

</script>
</head>
<body style="background:#fff;">
	<form action="/permissionController/list.htm" id="pageForm" method="post">
		<div class="">
			<!--搜索条件-->
			<div class="seach_box" id="submit_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				
				<div class="fl">
					<ul>
			        	<input name="userId" id="userId" type="hidden" value="${userId}" />
			        	<input name="userName" id="userName" type="hidden" value="${userName}" />
			        	<li><label>权限名称:</label><input name="buttonName" id="buttonName" type="text" /></li>
			            <li><div class="button_yellow"><a id="ybl_web_permission_search"><spring:message code="sys.admin.search"/></a></div></li>
			            <li><div class="button_gary"><a id="ybl_web_permission_reset"><spring:message code="sys.client.reset"/></a></div></li>
			        </ul>
				</div>
			</div>
			<!--搜索条件-->
	
			<!--table-->
			<div class="table_box ">
				<!--按钮top-->
				<div id="tablePage" class="table_con ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb" class="tab_gun">
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
	                        	<td><input name="checkbox"  type="checkbox" value="${bean.id}" ${bean.attribute1=='1'?"checked":""} /></td>
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
<%-- 					<jsp:include page="/ybl/admin/common/page.jsp"></jsp:include> --%>
				</div>
			</div>
		</div>
	</form>
	<div class="clear"></div>
    <div class="wb_bottom">
      	<ul>
          	<li><a class="now" id="btn-tab1-save">确定</a></li>
      		<li><a id="anqu_close" onclick="add_close();">取消</a></li>
   		</ul>
	</div>
</body>
</html>
