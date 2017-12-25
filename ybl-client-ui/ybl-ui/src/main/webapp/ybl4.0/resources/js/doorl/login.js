$(function(){
	/*-----------------代码部分--------------------*/
	//enter键绑定登录按钮
	$(document).keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			$('#ybl_admin_member_login_btn').click(); //自动/触发登录按钮 
		} 
	}); 
	
	$("#ybl_admin_member_login_btn").click(function(){
		var usr = $("#username").val();
		var pwd = $("#password").val();
		if(usr=='' ){
			alert("用户名不能为空")
			return;
		}
		if(pwd=='' ){
			alert("密码不能为空");
			return;
		}
		pwd = sha256_digest(pwd); //加密
		login(usr,pwd);
	});
	var logining = false;	
	function login(usr,pwd){
		if(logining){
			return;
		}
		logining = true;
		$.ajax({
			url:"/loginV4Controller/login",
			type:"POST",
			dataType:"json",
			data:{
				userName:usr,
				password:pwd,
				authType: $(".form_cur").attr('value')
				},
			success:function(resp){
				logining = false;
				if(resp.responseTypeCode=="success"){
					if(resp.object.attribute3_ != null){
						location.href=resp.object.attribute3_; //子账户登录加载页面
					}else if(resp.object.status_=="supplier"){//融资方端口
						location.href = "/supplierIndexController/homepage.htm";
					}else if(resp.object.status_=="enterprise"){//核心企业端口
						location.href = "/enterpriseIndexV4Controller/enterpriseIndex.htm";
					}else if(resp.object.status_=="financil"){//资金方端口
						location.href = "/factorIndexController/homepage.htm";
					}else{//门户端
						location.href = "/ybl4.0/admin/doorl/memberCenter.jsp";
					}
				}else{
					alert(resp.info);
				}
			},
			error:function(){
				logining = false;
				alert("error");
			}
		})
	}
});
