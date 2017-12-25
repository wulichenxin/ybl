$(function(){
	/**
	 * 查询按钮
	 */
	$("#userManage_serach_btn").click(function(){
		$("#pageForm").submit();
	})
	
	/**
	 * 新增会员
	 */
	$("#userManage_add_btn").click(function(){
		dialog.open('/v2UserController/operator/addMember','800px','550px','asdf','新增会员');
		close('outClose');
	})
	
		/**
	 * 编辑会员
	 */
	$("#userManage_edit_btn").click(function(){
		
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
		dialog.open('/v2UserController/operator/editMember?userId='+id[0],'800px','490px','asdf','编辑会员');
		close('outClose');
	})
	
	
	/**
	 * 删除会员
	 */
	$("#userManage_delete_btn").click(function(){
		
		var memberIdArr = [];
		$('input[name="checkbox"]:checked').each(function(i,item){ 
			memberIdArr.push($(item).val());
		});
		if(memberIdArr.length == 0){
			alert($.i18n.prop("sys.v2.client.select.delete.records")); /*请选择要删除的记录*/
			return;
		};
		
		
		confirm($.i18n.prop("sys.v2.client.confirm.delete.records"), function(){/*确定要删除吗？*/
			$.ajax({
				type:'post',
				dataType:'json',
				url:'/v2UserController/deleteMemberByMemberId',
				data:{
					memberId : memberIdArr.join(","),
					},
				success:function(data){
					if(data.responseTypeCode=='success'){
						alert($.i18n.prop("sys.v2.client.delete.success"),function(){/*删除成功*/
							window.location.reload();
						});
					}else{
						alert($.i18n.prop("sys.v2.client.delete.fail"));/*删除失败*/
					}	
				},
				error:function(){
					alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*系统繁忙，请稍后重试！*/
				}
			})
		})
		
		
	})
	
	
	/**
	 * 设置角色
	 */
	$("#userManage_set_role_btn").click(function(){
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
		
		//若为超级管理员  则不能设置角色
		if($("input[name='checkbox']:checked").attr("isAdmin")=='1'){
			alert($.i18n.prop("sys.v2.client.current.user.is.administrator.can.not.set.role"));/*该用户为超级管理员，不能设置角色*/
			return false;
		}
		dialog.open('/v2RoleController/selectRole.htm?userId='+id[0],'800px','610px','asdf','角色设置');
		close('outClose');
		
	
	})
	
	/*全选反选*/
	$("#checkAll").click(function() {
		$('input[type="checkbox"]').prop("checked",this.checked); 
   });
	
	/*去掉一个选中，全选框不选中*/
	$("input[type='checkbox']").click(function(){
		if(!$(this).prop("checked")){
			$("#checkAll").prop("checked",false);
		}
	})
})