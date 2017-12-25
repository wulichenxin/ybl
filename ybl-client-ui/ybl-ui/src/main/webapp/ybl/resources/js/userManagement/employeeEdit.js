$(function(){
		//用户表单检验回显
	$("#userForm").validate({
		submitHandler:function(form){
			console.log(form);
           	 $(form).ajaxSubmit({
            	success:function(resp){
            		if(resp.responseType == 'ERROR'){
            			alert(resp.info);/* 服务器繁忙请稍候重试 */
            		}else{
            			alert(resp.info);/* 数据保存/更新成功 */ 
            			/*location.href="/UserController/findUsersByCertRole?certRole=factor";*/
            		}         		
            	},
            	error:function(){
            		alert(resp.info);/* 服务器繁忙请稍候重试 */
            	}
            });
       	 }    
    });
	//保存按钮事件
//	$("#saveUserBtn").click(function(){
//		$("#userForm").submit();
//	});
	
	$("#saveUserBtn").click(function(){
		var formdata=$('#userForm').serialize();//序列化表单
		console.log(formdata + "===========");
		$.ajax({
			url:'/UserController/addOrUpdateUser',
			dataType:'json',
			type:'post',
			data:formdata,
			success:function(value){
				if(value.success){
					alert(value.info,callback);
				}else{
					alert(value.info);
				}
			}
		}); 
	});
	
	
	//返回列表按钮
	$("#anqu_close").click(function(){
		parent.$(".msgbox_close").mousedown();
	});
	
	callback = function(){
		parent.$(".msgbox_close").mousedown();
		parent.callBackReflush();
	}
	//返回列表按钮
//	$("#returnListBtn").click(function(){
//		location.href="/UserController/findUsersByCertRole?certRole=factor";
//	});
});