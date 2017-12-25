$(function(){
	
	
	/**
	 * 全选反选
	 */
	$("#checkAll").click(function() {
		$('input[type="checkbox"]').prop("checked",this.checked); 
   });
	
	/*去掉一个选中，全选框不选中*/
	$("input[type='checkbox']").click(function(){
		if(!$(this).prop("checked")){
			$("#checkAll").prop("checked",false);
		}
	})
	
	
	/*查询按钮绑定事件*/
	$("#roleSerachBtn").click(function(){
		 $("#pageForm").submit();
	})
	
	//新增岗位
	$("#ybl_v2_web_role_add_btn").click(function(){
		dialog.open('/v2RoleController/edit.htm','800px','500px','asdf','新增');
		close('outClose');
		
	});
	
	//保存/更新角色信息
	$("#ybl_v2_web_role_edit_btn").click(function(){
		var id = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			id.push($("input[name='checkbox']:checked").val());
		});
		if(id.length == 0){
			alert("请选择一条记录");/*请选择一条记录*/
			return;
		};
		if(id.length > 1){
			alert("请不要选择多条记录");/*请不要选择多条记录*/
			return;
		};
		dialog.open('/v2RoleController/edit.htm?id='+id,'800px','500px','asdf','修改');
		close('outClose');
	})
	
	
	//删除角色信息
	$("#ybl_v2_web_role_delete_btn").click(function(){
		
		var jobId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			jobId.push($(this).val());
		});
		if(jobId.length == 0){
			alert($.i18n.prop("sys.v2.client.select.delete.records")); /*请选择要删除的记录*/
			return;
		};
		confirm($.i18n.prop("sys.v2.client.confirm.delete.records"),function(){
			$.ajax({
				url:"/v2RoleController/deleteRoleByRoleId?jobId="+jobId,
				dataType:"json",
				success:function(data){
					if(data.responseTypeCode="success"){
						alert(data.info,function(){
							location.href='/v2RoleController/list.htm';
						});
					}else{
						alert(data.info);
					}
				},
				error:function(){
					alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*系统繁忙，请稍后重试！*/
				}
			});
		})
	})
		

	
	/**
	 * 角色授权
	 */
	$("#ybl_v2_web_accredit_role_btn").click(function(){
		
		var id = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			id.push($("input[name='checkbox']:checked").val());
		});
		if(id.length == 0){
			alert("请选择一条记录");/*请选择一条记录*/
			return;
		};
		if(id.length > 1){
			alert("请不要选择多条记录");/*请不要选择多条记录*/
			return;
		};
		dialog.open("/v2MenuController/meunTree?roleId="+id,'800px','500px','asdf','权限');
		close('outClose');
	})
})