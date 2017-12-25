$(function(){
	//保存按钮
	$("#ybl_web_job_save_btn").click(function(){
		var formdata=$('#jobForm').serialize();//序列化表单
		$.ajax({
			url:'/roleController/saveOrUpdate',
			dataType:'json',
			type:'post',
			data:formdata,
			success:function(value){
				if(value.success){
					alert(value.info,function(){
						parent.$(".msgbox_close").mousedown();
						parent.location.href = "/roleController/list.htm";
					});
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
})

