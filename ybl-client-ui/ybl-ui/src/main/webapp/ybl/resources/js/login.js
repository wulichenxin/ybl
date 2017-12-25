// JavaScript Document
//animate
$(function(){
	$('#dowebok').fullpage({
		 loopBottom: false,
		 'navigation': true,
		 /*anchors: [ 'hero','services', 'cases', 'news','about','contact','think','footer'],*/
		afterLoad: function(anchorLink, index){
			if(index == 1){
				$('header').stop().animate({top:"0px"},700);
				$('.gb-nav').stop().animate({top:"-100%"},700);
			     var an =window.screen.width; 
			     if(an < 1150 ){  
				   $('header').stop().animate({top:"-100%"},700);	
			       $('.gb-nav').stop().animate({top:"0%"},700);  
				  }
			}
			if(index == 2){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 3){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 4){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 5){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			
		},
		onLeave: function(index, direction){
			if(index == '1'){
				 var an =window.screen.width; 
			     if(an < 1150 ){  
				   $('header').stop().animate({top:"-100%"},700);	
			       $('.gb-nav').stop().animate({top:"0%"},700);  
				  }
			}
			if(index == '2'){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '3'){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '4'){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '5'){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			
			
		}
	});
    setInterval(function(){
        $.fn.fullpage.moveSlideRight();
    }, 18000)	
   $(function(){
//	  $('.slide video').get(0).play();
	  /*_slideAutoChange = setInterval("$.slideAutoChange()",18000);*/
	})
	
	
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
		}if(pwd=='' ){
			alert("密码不能为空");return;
		}
		login(usr,pwd);
	});
	var logining = false;	
	function login(usr,pwd){
		if(logining){
			return;
		}
		//$("#ybl_admin_member_login_btn").text($.i18n.prop("login") + "...");
		logining = true;
		$("#ybl_admin_member_login_btn").hide();
		$("#ybl_admin_member_login_btn_ing").removeClass('none1');
		$.ajax({
			url:"/loginController/login",
			type:"POST",
			data:{
				userName:usr,
				password:pwd
			},
			success:function(resp){
				logining = false;
				if(resp.responseTypeCode=="success"){
					location.href = "/accountOverview/queryAccountOverview";
				}else{
					$("#ybl_admin_member_login_btn").show();
					$("#ybl_admin_member_login_btn_ing").addClass('none1');
					//$("#ybl_admin_member_login_btn").text($.i18n.prop("login"));
					if(resp.info == "userWrong"){
						$("#userTip").text("输入用户名错误");
					}
					if(resp.info == "passWrong"){
						$("#passTip").text("密码错误");
					}
					alert(resp.info)
				}
			},
			error:function(){
				//$("#ybl_admin_member_login_btn").text($.i18n.prop("login"));
				logining = false;
				alert("error");
				$("#ybl_admin_member_login_btn").show();
				$("#ybl_admin_member_login_btn_ing").addClass('none1');
			}
		})
	}
});
