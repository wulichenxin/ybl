$(function(){
	//按条件查询角色
	$("#ybl_web_menu_search").click(function(){
		var menuName = $("#menuName").val();
		$.ajax({
			url:"/menuController/loadMenuByAsync?menuName=" + menuName,
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	//重置查询条件
	$("#ybl_web_menu_reset").click(function(){
		$.ajax({
			url:"/menuController/loadMenuByAsync",
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
				$("#menuName").val("");
				
			}
		});
	});
	
	//新增菜单
	$("#ybl_web_menu_add_btn").click(function(){
		$.msgbox({
			height:650,
			width:640,
			content:"/menuController/operator/add",
			type :'iframe',
			title: '新增菜单'
		});
	});
	
	//编辑菜单
	$("#ybl_web_menu_edit_btn").click(function(){
		var codeId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			codeId.push($("input[type='checkbox']:checked").val());
		});
		if(codeId.length == 0){
			alert("请选择一条记录");
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
			content:"/menuController/operator/edit?menuId="+code,
			type :'iframe',
			title: '编辑'
		});
	});
	//删除菜单信息
	$("#ybl_web_menu_delete_btn").click(function(){
		var id = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			id.push($(this).val());
		});
		if(id.length == 0){
			alert("请选择要删除的记录");
			return;
		};
		
		confirm("确定删除数据么？",function(){
			$.ajax({
				url:"/menuController/deleteMenu?id="+id,
				dataType:"json",
				success:function(data){
					if(data.info == "删除成功"){
						alert(data.info,function(){
							location.href='/menuController/list.htm';
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
	location.href="/menuController/meunTree?roleId="+id;
}
function callBackReflush(url){
	window.location.href = url;
}