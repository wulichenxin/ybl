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
 	<jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
</head>
<body>
<div class="vip_window_con">
          <div class="clear"></div>
          <div class="window_xx">
          	<div class="vip_conbody webBome">
			<form action="/userController/userManage" method="post" id="pageForm">
			<!-- 授权用户id -->
<input type="hidden" id='userId' value='${userId }'/>
<!--搜索条件-->
<div class="seach_box" id="submit_box">
   	<div class="switch" onclick="hideform();"><a></a></div>
     <div class="fl">
 	<ul>
     	<li><label>岗位名称:</label><input type="text" /></li>
         <li><div class="button_yellow"><a><spring:message code="sys.admin.search"/></a></div></li>
         <li><div class="button_gary"><a><spring:message code="sys.client.reset"/></a></div></li>
     </ul>
     </div>
 </div>
 <!--搜索条件-->

	<!--table-->
 <div class="table_box ">
     <!--按钮top-->
     <div class="table_con ">
     			<table cellspacing="0" cellpadding="0" id="tb">
	               <thead>
	                   <tr>
	                       <th><input type="checkbox" id="checkAll"  /></th>
	                       <th>序号</th>
	                       <th>角色编码</th>
	                       <th>角色名称</th>
	                       <th>角色描述</th>                         
	                   </tr>
	               </thead>
	               <tbody>
		               <c:forEach items="${roleList}" var="bean" varStatus="index">
		                   <tr>
		                   		<td><input name="checkbox" type="checkbox" value="${bean.id}" ${bean.attribute1=='1'?"checked":""} /></td>
		                        <td>${index.count}</td>
		                        <td>${bean.code}</td>
		              			<td>${bean.name}</td>
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
       	<div class="w_bottom">
          	<ul>
              	<li><a class="now" id="ybl_web_grantRole">确定</a></li>
          		<li><a id="anqu_close" onclick="add_close();">取消</a></li>
       		</ul>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
	//按条件查询角色
	$("#btn-query").click(function(){	
		$("#pageForm").submit();
	});
	//确认按钮事件
	$('#ybl_web_grantRole').click(function() {	
		var roleIds="";
		var userId=$("#userId").val();//当前选中授权的用户id
		$('input[name="checkbox"]:checked').each(function(){ 
			roleIds += ($(this).val()+",");	
		});
		$.ajax({
			url:"/roleController/saveGrantRoleUser",
			data:{"userId":userId,"roleIds":roleIds},//参数
			dataType: 'json',
			success:function(data){
				$("#btn-tab1-save").show();
	        	$("#btn-tab1-saveing").hide();
				alert(data.info,function(){
					parent.$(".msgbox_close").mousedown();
					parent.callBackReflush();
				});
			},
			error:function(){
				$("#btn-tab1-save").show();
	            $("#btn-tab1-saveing").hide();
	        	alert("系统忙")
			}
		}); 
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
</script>
</body>
</html>
