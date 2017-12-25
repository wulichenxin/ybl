$(function(){
	//按条件查询角色
	$("#ybl_web_job_search").click(function(){
		var userName = $("#userName").val();
		$.ajax({
			url:"/roleController/loadRoleInfoByRoleName?name=" + userName,
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	//重置查询条件
	$("#ybl_web_job_reset").click(function(){
		$("#userName").val("");
		var certRole = $("#certRole").val();
		$.ajax({
			url:"/roleController/loadRoleInfoByRoleName",
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	
	
	
	//新增岗位
	$("#ybl_web_role_add_btn").click(function(){
		$.msgbox({
			height:500,
			width:640,
			content:"/roleController/operator/edit.htm",
			type :'iframe',
			title: '新增岗位'
		});
	});
	
	//编辑岗位
	$("#ybl_web_role_edit_btn").click(function(){
		var codeId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			codeId.push($($("input[type='checkbox']:checked").parent().parent().children()[2]).html());
		});
		if(codeId.length == 0){
			alert("请勾选一个用户");
			return;
		};
		if(codeId.length > 1){
			alert("请不要选择多条记录");
			return;
		};
		var code="";
		code = codeId[0];
		$.msgbox({
			height:500,
			width:640,
			content:"/roleController/operator/edit.htm?code="+code,
			type :'iframe',
			title: '编辑'
		});
	});
	//删除岗位
	$("#ybl_web_role_delete_btn").click(function(){
		
		
		var jobId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			jobId.push($(this).val());
		});
		if(jobId.length == 0){
			alert("请选择要删除的记录");
			return;
		};
		confirm("确定删除数据么？",function(){
			$.ajax({
				url:"/roleController/deleteRoleByRoleId?jobId="+jobId,
				dataType:"json",
				success:function(data){
					if(data.info == "删除成功"){
						alert(data.info,function(){
							location.href='/roleController/list.htm';
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
							alert(value.info)
						}else{
							alert(value.info)
						}							
						location.href="/roleController/list.htm" ;
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
	$.msgbox({
		height:500,
		width:640,
		content:"/menuController/meunTree?roleId="+id,
		type :'iframe',
		title: '岗位授权'
	});
//	location.href="/menuController/meunTree?roleId="+id;
}