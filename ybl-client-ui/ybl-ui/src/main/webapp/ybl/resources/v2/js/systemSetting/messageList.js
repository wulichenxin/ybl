$(function(){
	//未读加粗
	$('.noread_tr td').css('font-Weight','bold');
	$('.isread_tr td').css('font-Weight','normal');
	//全部  按钮
	$("#member_center_message_query_all_btn").click(function(){
		$("#pageForm").submit();
		validateFrom();
	})
	//查询已读按钮
	$("#member_center_message_query_all_read_btn").click(function(){
		$("#isRead").val("Y");
		$("#pageForm").submit();
		validateFrom();
	})
	//查询未读按钮
	$("#member_center_message_query_all_noread_btn").click(function(){
		$("#isRead").val("N");
		$("#pageForm").submit();
		validateFrom();
	})
	//标记为已读按钮
	$("#member_center_message_sign_to_read_btn").click(function(){
		var ids = getCheckedIds();
		if(ids=='' || ids ==null){
			alert($.i18n.prop("sys.v2.client.please.select.fllow.item.then.operate"));//请选择以下项目后，在进行操作。
			return ;
		}
		updateMessage("Y",ids);
	})
	//标记为未读按钮
	$("#member_center_message_sign_to_noread_btn").click(function(){
		var ids = getCheckedIds();
		if(ids=='' || ids ==null){
			alert($.i18n.prop("sys.v2.client.please.select.fllow.item.then.operate"));//请选择以下项目后，在进行操作。
			return ;
		}
		updateMessage("N",ids);
	})
	//删除按钮
	$("#member_center_message_delete_btn").click(function(){
		deleteMessage();
	})

	/**
	 * 詳情頁面的按鈕
	 * 
	 */
	//标记为未读按钮
	$("#message_details_to_sign_noread_btn").click(function(){
		var ids = $("#id_").val();
		updateMessage("N",ids);
	})
	//标记为已读按钮
	$("#message_details_to_sign_read_btn").click(function(){
		var ids = $("#id_").val();
		updateMessage("Y",ids);
	})
	//删除按钮
	$("#message_details_delete_btn").click(function(){
		$.ajax({
			url:"/v2messageController/deleteMessage",      
			data:{
				ids:$("#id_").val()
			},
			type:"post",
			success:function(data){
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info,function(){
						location.href="/v2messageController/messageList.htm";
					});/* 数据保存/更新成功 */
				}
			},
			error : function() {
				alert($.i18n.prop("sys.v2.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	})
})
//根据条件查询
function validateFrom(){
	//企业表单检验回显
	$("#pageForm").validate({
		submitHandler:function(form){  
       	 	$(form).ajaxSubmit({
        		success:function(resp){
        			if(resp.responseType == 'ERROR'){
        				alert(resp.info);/* 服务器繁忙请稍候重试 */
        			}else{
        				alert(resp.info);/* 数据保存/更新成功 */ 
        			}         		
        		},
        		error:function(){
        			alert($.i18n.prop("sys.v2.client.save.error"));/* 服务器繁忙请稍候重试 */
        		}
        	});
   	 	}    
	});
}
//标记为已读/未读
function updateMessage(isRead,ids){
	$.ajax({
		url:"/v2messageController/updateMessage",      
		data:{
			isRead:isRead,
			ids:ids
		},
		type:"post",
		success:function(data){
			if (data.responseType == 'ERROR') {
				alert(data.info);/* 服务器繁忙请稍候重试 */
			} else {
				alert(data.info);/* 数据保存/更新成功 */
				location.reload();//刷新当前页面
			}
		},
		error : function() {
			alert($.i18n.prop("sys.v2.client.save.error"));/* 服务器繁忙请稍候重试 */
		}
	});
}

//删除
function deleteMessage(){
	var ids = getCheckedIds();
	if(ids=='' || ids ==null){
		alert($.i18n.prop("sys.v2.client.please.select.fllow.item.then.operate"));//请选择以下项目后，在进行操作。
		return ;
	}
	confirm($.i18n.prop("sys.v2.client.if.sure.delete"),function() {//是否确定删除？
		$.ajax({
			url:"/v2messageController/deleteMessage",      
			data:{
				ids:ids
			},
			type:"post",
			success:function(data){
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info);/* 数据保存/更新成功 */
					location.reload();//刷新当前页面
				}
			},
			error : function() {
				alert($.i18n.prop("sys.v2.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	});
}
//获取选中的id拼装的字符串
function getCheckedIds(){
	var checkArr = $("[name='checkBox']");
	var ids = '';
	$.each(checkArr,function(i,item){
		if($(this).attr("checked")){
			ids+=$(this).attr("ids")+",";
		}
	})
	return ids;	
}