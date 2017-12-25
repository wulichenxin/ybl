$(function(){
	//重写alert
	window.alert = function(msg) {
		window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
	}
	
	window.alert = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	}
	//提交按钮
	var resetFrom = ext.formValidation("resetPasswordFrom");
	$("#member_reset_password_submit_btn").click(function(){
		var oldPassword = $("#oldPassword").val();
		var newPassword = $("#newPassword").val();
		var nextPassword = $("#nextPassword").val();
		if(oldPassword.length < 6 || newPassword.length < 6 || nextPassword.length < 6)
		{
		 alert("密码不能少于6位");
		 return;
		}
		var userName=$("#userName").val();
		var telephone=$("#telephone").val();
		var passValide = resetFrom.validationEngine("validate");
		if(passValide){
			if(newPassword!=nextPassword){//新密码和确认密码不一致时，给出提示
				//新密码和确认密码不一致，请重新输入！
				alert($.i18n.prop("sys.client.newpassword.confirmpassword.inconsistent.please.input.again"));
				return;
			}
			$.ajax({
				url:"/loginController/validePassword",
				type:"POST",
				dataType:"json",
				data:{
					userName:userName,
					password:oldPassword
				},
				success:function(resp){
					if(resp.success){
						resetPassword(userName,newPassword,nextPassword,telephone);
					}else{
						alert($.i18n.prop("sys.client.input.true.oldPassword"));//请输入正确的旧密码！
						return;
					}
				},
				error:function(){
					alert($.i18n.prop("sys.client.input.true.oldPassword"));//请输入正确的旧密码！
					return;
				}
			})
			
		}
	});
	//修改密码
	function resetPassword(userName,password,nextpassword,telephone){
		$("#member_reset_password_submit_btn").hide();
		$("#member_reset_password_submiting_btn").show();
		$.ajax({
			url:"/registerController/resetPassword",
			type:"POST",
			dataType:"json",
			data:{
				userName:userName,
				password:password,
				nextpassword:nextpassword,
				telephone:telephone
			},
			success:function(resp){
				$("#member_reset_password_submit_btn").show();
				$("#member_reset_password_submiting_btn").hide();
				if(resp.success){
					alert("密码修改成功",resetPwCallback);
				}else{
					alert("修改失败")
				}
			},
			error:function(){
				$("#member_reset_password_submit_btn").show();
				$("#member_reset_password_submiting_btn").hide();
				alert("服务器繁忙");
			}
		})
	}
	
	
	function resetPwCallback(){
		window.location.href="/loginController/logout";
	}
})
