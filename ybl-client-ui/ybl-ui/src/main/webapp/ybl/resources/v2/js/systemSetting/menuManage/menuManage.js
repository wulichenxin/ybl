$(function(){
	/*查询*/
	$("#ybl_v2_menu_search_btn").click(function(){
		$("#pageForm").submit();
	})
	
	/**
	 *新增菜单
	 */
	$("#ybl_v2_menu_add_btn").click(function(){
		
		$.msgbox({
			height:510,
			width:640,
			content:"/v2MenuController/operator/add",
			type :'iframe',
			title: $.i18n.prop("sys.v2.client.add")/*新增*/
		});
	})
	
	
	/**
	 * 编辑菜单
	 */
	$("#ybl_v2_menu_edit_btn").click(function(){
		var id = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			id.push($(this).val());
		});
		if(id.length == 0){
			alert($.i18n.prop("sys.v2.client.select.one.record"));/*请选择一条记录*/
			return;
		};
		if(id.length > 1){
			alert($.i18n.prop("sys.v2.client.select.only.one.record"));/*请不要选择多条记录*/
			return;
		};
		var code="";
		code = id[0];
		$.msgbox({
			height:510,
			width:640,
			content:"/v2MenuController/operator/edit?menuId="+code,
			type :'iframe',
			title: $.i18n.prop("sys.v2.client.edit")/*修改*/
		});
		
	})
	
	
	/**
	 * 删除菜单
	 */
	$("#ybl_v2_menu_del_btn").click(function(){
		
		var id = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			id.push($(this).val());
		});
		if(id.length == 0){
			alert($.i18n.prop("sys.v2.client.select.delete.records"));/*"请选择要删除的记录"*/
			return;
		};
		
		confirm($.i18n.prop("sys.v2.client.confirm.delete.records"),function(){/*确定要删除数据吗?*/
			$.ajax({
				url:"/v2MenuController/deleteMenu?id="+id,
				dataType:"json",
				success:function(data){
					if(data.responseTypeCode == "success"){
						alert(data.info,function(){
							window.location.href='/v2MenuController/list.htm';
						});
					}else{
						alert(data.info);
					}
				},
				error:function(){
					alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*"系统繁忙，请联系管理员！"*/
				}
			});
		})
	})
})