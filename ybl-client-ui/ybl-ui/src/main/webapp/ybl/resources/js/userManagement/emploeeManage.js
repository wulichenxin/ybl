$(function(){
	//删除会员信息
	$("#ybl_web_member_deleteMember").click(function(){
		var memberId = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			memberId.push($(this).val());
		});
		if(memberId.length == 0){
			alert("请至少选中一条记录");
			return;
		};
		
		confirm("确定要删除数据吗?",function() {
			$.ajax({
				url:"/UserController/deleteMemberByMemberId?memberId=" + memberId,
				dataType:"json",
				success:function(data){
					if(data.info == "删除成功"){
						alert(data.info,function(){
							location.href='/UserController/findUsersByCertRole?certRole=factor';
						});
					}else{
						alert(data.info);
					}
				}
			});
		});
		
	});
	
	//新增用户
	$("#addUserBtn").click(function(){
		$.msgbox({
			height:500,
			width:640,
			content:"/UserController/operator/addMember",
			type :'iframe',
			title: '编辑用户'
		});
	});
	//按条件查询用户
	$("#ybl_web_employee_search").click(function(){
		var userName = $("#userName").val();
		var certRole = $("#certRole").val();
		
		$.ajax({
			url:"/UserController/loadUsersByCertRoleData?certRole=" + certRole + "&userName="+userName,
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	//重置查询条件
	$("#ybl_web_employee_reset").click(function(){
		$("#userName").val("");
		var certRole = $("#certRole").val();
		$.ajax({
			url:"/UserController/loadUsersByCertRoleData?certRole=" + certRole,
			dataType:"html",
			success:function(data){
				$("#tablePage").html(data);
			}
		});
	});
	
	//重置会员密码
	$("#ybl_web_employee_password_reset").click(function(){
		var certRole = $("#certRole").val();
		var memberIdTemp = [];
		$('input[name="checkbox"]:checked').each(function(){ 
			memberIdTemp.push($(this).val());
		});
		if(memberIdTemp.length == 0){
			alert("请选择需要重置密码的用户");
			return;
		};
		if(memberIdTemp.length > 1){
			alert("请不要选择多条记录");
			return;
		};
		memberId = memberIdTemp[0];
		$.ajax({
			url:"/UserController/updatePassword?memberId=" + memberId + "&password=888888",
			dataType:"json",
			success:function(data){
				alert(data.info,callback);
//				location.href='/UserController/findUsersByCertRole?certRole=' + certRole;
			}
		});
	});
	//授权+绑定角色按钮弹框
	$(function(){	 	
		 $(".grant_role").hDialog({box: '#grantRoleHBox',title:"角色选择",width:850,height:480});
		 $(".grant_permission").hDialog({box: '#grantPromissionHBox',title:"操作权限选择",width:850,height:480});
	});	
	var ob={};
	
	callback = function(){
		var certRole = $("#certRole").val();
		location.href='/UserController/findUsersByCertRole?certRole=' + certRole;
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
//根据id编辑用户
function editById(userName){
	$.msgbox({
		height:500,
		width:640,
		content:"/UserController/operator/editMember?userName="+userName,
		type :'iframe',
		title: '编辑用户'
	});
}
//启用,冻结,注销用户
function updateUserStatusById(userName,status,id,currentpage){
	location.href="/UserController/UpdateUserStatus?userName="+userName+"&status="+status+"&userid="+id+"&currentpage="+currentpage;
}	
//授权（绑定角色）弹框
function grantRole(id,obj){
	ob = obj;
	console.log(ob);
	$.msgbox({
		height:420,
		width:640,
		content:"/roleController/selectRole?userId="+id,
		type :'iframe',
		title: '绑定/解绑角色'
	});
//		$("#grantUserId").val(id);
//		$("#grantRoleFrame").attr("src","/roleController/selectRole?userId="+id);
}
//授权（操作权限）弹框
function grantPermission(id,userName,obj){
	ob = obj;
	$.msgbox({
		height:420,
		width:640,
		content:"/permissionController/selectPromission?userId="+id + "&userName=" + userName,
		type :'iframe',
		title: '操作按钮授权'
	});
//	$("#grantUserId").val(id);
//	$("#grantPromissionFrame").attr("src","/permissionController/selectPromission?userId="+id);
}

/*关闭    授权（绑定角色）弹框*/
function closeGrantRoleDiv(){		
	var $el = $(".grant_role");
	$el.hDialog({box: '#grantRoleHBox',width:"850",title:"角色选择",height:"480"});
    $el.hDialog('close',{box:'#grantRoleHBox'}); 
}
/*关闭    授权（操作权限）弹框*/
function closeGrantPromissionDiv(){		
	var $el = $(".grant_permission");
	$el.hDialog({box: '#grantPromissionHBox',width:"850",title:"操作权限选择",height:"480"});
    $el.hDialog('close',{box:'#grantPromissionHBox'}); 
}

function callBackReflush(){
	var certRole = $("#certRole").val();
	window.location.href='/UserController/findUsersByCertRole?certRole=' + certRole;
}

	