$(function(){
	//修改密码
	$("#member_reset_password_submit_btn").click(function(){
		var oldPassword = $("#oldPassword").val();
		var newPassword = $("#newPassword").val();
		var nextPassword = $("#nextPassword").val();
		if(oldPassword.length < 6 || newPassword.length < 6 || nextPassword.length < 6)
		{
		 alert("密码不能少于6位");
		 return;
		}
		if(newPassword!=nextPassword){//新密码和确认密码不一致时，给出提示
			alert("新密码和确认密码不一致!");
			return;
		}
		$.ajax({
			url:"/registerController/resetPassword",
			type:"POST",
			dataType:"json",
			data:{
				password:oldPassword,
				newpassword:newPassword
			},
			success:function(resp){
				if(resp.success){
					$("#oldPassword").val('');
					$("#newPassword").val('');
					$("#nextPassword").val('');
					alert("密码修改成功",function(){
						window.location.reload();
					});
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("服务器繁忙");
			}
		})
	})
	
	/*function resetPwCallback(){
		window.location.href="/loginController/logout";
	}*/
})
