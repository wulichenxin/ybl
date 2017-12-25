$(function(){
	//按条件查询角色
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
	
	//新增权限
	$("#ybl_web_permission_add_btn").click(function(){
		$.msgbox({
			height:320,
			width:640,
			content:"/permissionController/operator/edit.htm",
			type :'iframe',
			title: '新增权限按钮'
		});
	});
	
	//编辑权限
	$("#ybl_web_permission_edit_btn").click(function(){
		var codeId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			codeId.push($($("input[type='checkbox']:checked").parent().parent().children()[2]).html());
		});
		if(codeId.length == 0){
			alert("请勾选一个再进行编辑");
			return;
		};
		if(codeId.length > 1){
			alert("请不要选择多条记录");
			return;
		};
		var buttonId="";
		buttonId = codeId[0];
		$.msgbox({
			height:320,
			width:640,
			content:"/permissionController/operator/edit.htm?buttonId="+buttonId,
			type :'iframe',
			title: '编辑权限按钮'
		});
	});
	//删除权限
	$("#ybl_web_permission_delete_btn").click(function(){
		var codeId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			codeId.push($(this).val());
		});
		if(codeId.length == 0){
			alert("请选择要删除的记录");
			return;
		};
		confirm("确定删除数据么？",function(){
			$.ajax({
				url:"/permissionController/deleteById?id="+codeId,
				dataType:"json",
				success:function(data){
					if(data.responseType == "SUCCESS_DELETE"){
						alert(data.info,function(){
							location.href='/permissionController/list.htm';
						});
					}else{
						alert(data.info);
					}
				}
			});
		})
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
//根据id删除角色
function deleteRole(code){
	if(code){
		if(confirm($.i18n.prop("sys.admin.sure.to.delete"))){
			 $.ajax({
					url:'/roleController/deleteRoleById?code='+code,
					dataType:'json',
					type:'post',
					success:function(value){
						if(value.responseType!="ERROR"){
							alert(value.info,function(){
								location.href="/roleController/list.htm";
							})
						}else{
							alert(value.info)
						}							
					}
				});  	
		}
	}
}  
//根据id编辑角色
function editRole(code){
	location.href="/roleController/edit.htm?code="+code;
}
//根据id授权角色
function accreditRole(id){
	location.href="/menuController/meunTree?roleId="+id;
}
function callBackReflush(){
	window.location.href='/permissionController/list.htm';
}