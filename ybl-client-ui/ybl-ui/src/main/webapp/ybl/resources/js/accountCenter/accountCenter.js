$(function() {
	// 账户中心，根据不同角色显示不同的内容
	var certRole = $("#certRole").val();
	if (certRole == 'enterprise') {// 核心企业
		$("#credit_div").show();
	} else if (certRole == 'supplier' || certRole == 'factor') {// 供应商或保理商
		$("#bank_account_message_div").show();
		$("#bind_card_div").show();
		$("#month_bill_div").show();
	}

	// 修改/设置用户昵称
	$("#member_center_nickName_edit_btn").click(function() {
		$("#nickNameSpan").html("<input class='text' type='text' id='nick_name' maxlength='20'/>");
		$("#member_center_nickName_save_btn").show();
		$("#member_center_nickName_quit_save_btn").show();
		$("#member_center_nickName_edit_btn").css("display", "none");
		
	})
	// 保存用户昵称
	$("#member_center_nickName_save_btn").click(function() {
		saveUser("nickName");
	})
	// 修改手机号码
	$("#member_center_phone_edit_btn").click(function() {
		$("#telephoneSpan").html("<input class='text' type='text' id='telephone_' maxlength='100'/>");
		$("#member_center_phone_save_btn").show();
		$("#member_center_phone_quit_save_btn").show();
		$("#member_center_phone_edit_btn").css("display","none");
	})
	// 保存手机号码
	$("#member_center_phone_save_btn").click(function() {
		saveUser("telephone");
	})
	//修改密码(跳转到修改密码页面)
	$("#member_center_password_edit_btn").click(function(){
		location.href = "/indexController/resetPassword.htm";
	})
	
	//放弃修改昵称 手机号码
	$("#member_center_nickName_quit_save_btn,#member_center_phone_quit_save_btn").click(function(){
		location.reload();
	})
	
	//邮箱设置
	$("#member_center_email_edit_btn").click(function(){
		location.href='/UserController/bindEmail';
	})

});
//绑定银行卡
function unbindCard(bankId) {
	$.ajax({
        url:'/bankAccount/unbindBankCard',
        type:'POST',
        data:{bankId:bankId} ,
        dataType:'text',    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            if(data =="S"){
            	location.reload();
            } else {
            	alert($.i18n.prop("sys.client.add.fail"));/* 新增失败 */
            }
        },
        error:function(xhr,textStatus){
        	alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
            console.log(xhr);
            console.log(textStatus);
        },
        complete:function(){
            console.log('结束');
        }
    });
}

// 修改按钮逻辑
function saveUser(type) {
	var userName = $("#userName").val();
	var enterpriseId = $("#enterpriseId").val();
	var nickName = $("#nick_name").val();
	if(type=='nickName' && !nickName){
		alert($.i18n.prop("sys.client.nickName.is.null"));
		return ;
	}
	var telephone = $("#telephoneSpan").text()!=""?$("#telephoneSpan").text():$("#telephone_").val();
	var userId = $("#userId").val();
	var pattern = new RegExp("^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$");
	if(type=='telephone' && !pattern.test(telephone)){//校验手机号码格式
		alert($.i18n.prop("sys.client.phone.format.wrong.reEnter.it"));//手机号码格式不对，请重新输入！
		return;
	}
	$.ajax({
		url : "/UserController/updateUser",
		data : {
			id:userId,
			userName:userName,
			enterpriseId : enterpriseId,
			nickName : nickName,
			telephone : telephone
		},
		type : "post",
		success : function(data) {
			if (data.responseType == 'SUCCESS') {
				if(type=='nickName'){
					$("#member_center_nickName_edit_btn").show();
					$("#member_center_nickName_save_btn").hide();
					$("#member_center_nickName_quit_save_btn").hide();
				}
				if(type=='telephone'){
					$("#member_center_phone_edit_btn").show();
					$("#member_center_phone_save_btn").hide();
					$("#member_center_phone_quit_save_btn").hide();
				}
				alert(data.info,successCallback);/* 服务器繁忙请稍候重试 */
			} else {
				alert(data.info);/* 数据保存/更新成功 */
			}
		},
		error : function() {
			alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
		}
	});
}
/*修改成功回掉*/
function successCallback(){
	location.reload();
}