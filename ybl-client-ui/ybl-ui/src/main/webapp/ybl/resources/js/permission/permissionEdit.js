$(function(){
	//保存按钮
	$("#ybl_web_permission_save_btn").click(function(){
		var formdata=$('#permissionForm').serialize();//序列化表单
		$.ajax({
			url:'/permissionController/saveOrUpdate',
			dataType:'json',
			type:'post',
			data:formdata,
			success:function(value){
				if(value.responseTypeCode == "success"){
					alert(value.info,callback);
				}else{
					alert(value.info)
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
	
})