$(function(){
	/**
	 * 初始化日期控件start
	 */
	var dmf = {
		yearOffset : 0,
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '1970-01-01', // yesterday is minimum date
		maxDate : '2099-12-31' // and tommorow is maximum date calendar
	};
	// 初始化日期控件
	$('#expireDate').datetimepicker(dmf);
	$('#registerDate').datetimepicker(dmf);
	$('#effectiveDate').datetimepicker(dmf);
	var expireDate = $("#expireDate").val();
	var registerDate = $("#registerDate").val();
	var effectiveDate = $("#effectiveDate").val();
	if (expireDate) {
		var fmtDate = new Date();
		fmtDate.setTime(expireDate);
		$("#expireDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	if (registerDate) {
		var fmtDate = new Date();
		fmtDate.setTime(registerDate);
		$("#registerDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	if (effectiveDate) {
		var fmtDate = new Date();
		fmtDate.setTime(effectiveDate);
		$("#effectiveDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	//初始化日期控件end
	
	//定义数组attachement
	var attachmentArray = '';
	/**
	 * 图片上传statrt
	 */
	//监听图片上传按钮
	$("#common_upload_btn").watchProperty("value",function() {
		var v = $(this).val();
		if(v == '' || v == null) return;
		// 上传
		$("#common_upload_form").attr("action", "/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
		$("#common_upload_form").submit();
	});
	//点击图片上传图片
	$("#addPicture").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
		
	});
	//回调，回显图片
	uploadCallback = function(attachment) {
		//atachmentArray += attachment + "#";
		attach = eval("(" + attachment + ")");
		$("#common_upload_btn").val('');
		$(".vip_phone").find("dl").find("dd").last().before("<dd > <a><img src='"+attach.url_ +"'/><i onclick='deleteAttachment(this)' value="+attachment+"></i></a></dd>");
	}
	//图片上传end
	
	
	//删除上传的文件
	deleteAttachment = function(_this){
		$(_this).parent().parent().remove();
	}
	
	
	//提交按钮
	$("#addVoucherSubmitBtn").click(function(){
		
		//凭证编码
		var voucherNo = $("input[name='voucherNo']").val();
		//到期日期
		var expireDate = $("input[name='expireDate']").val();
		//核心企业
		var enterpriseMemeberId = $("#enterpriseMemeberId option:selected ").val();
		//凭证类型
		var type = $("#type option:selected ").val();
		//凭证面额
		var amount = $("input[name='amount']").val();
		//登记日期
		var registerDate = $("input[name='registerDate']").val();
		//起始日期
		var effectiveDate = $("input[name='effectiveDate']").val();
		//备注说明
		var remark = $("#remark").val();
		
		
		//凭证编码不能为空
		if(!voucherNo){
			alert($.i18n.prop('sys.client.voucher.no.is.empty'));/*凭证编码不能为空*/
			return false;
		}
		//凭证面额不能为空
		if(!amount){
			alert($.i18n.prop('sys.client.voucher.amount.is.empty'));/*凭证面额不能为空！*/
			return false;
		}
		if(amount<=0){
			alert($.i18n.prop('sys.client.voucher.amount.is.not.zero'));/*凭证面额不能小于0！*/
			return false;
		}
		//核心企业不能为空
		if(!enterpriseMemeberId){
			alert($.i18n.prop('sys.client.core.enterprise.is.empty'));/*核心企业不能为空!*/
			return false;
		}
		//凭证类型不能为空
		if(!type){
			alert($.i18n.prop('sys.client.voucher.type.is.empty'));/*凭证类型不能为空！*/
			return false;
		}
		//起始日期不能为空
		if(!effectiveDate){
			alert($.i18n.prop('sys.client.voucher.start.time.is.empty'));/*起始日期不能为空！*/
			return false;
		}

		//登记日期不能为空
		if(!registerDate){
			alert($.i18n.prop('sys.client.voucher.register.date.is.empty'));/*登记日期不能为空！*/
			return false;
		}
		//凭证到期日期不能为空
		if(!expireDate){
			alert($.i18n.prop('sys.client.voucher.expiration.date.is.empty'));/*凭证到期日期不能为空！*/
			return false;
		}
		
		if(new Date(expireDate) < new Date(effectiveDate)){
			alert($.i18n.prop('sys.client.voucher.expire.date.less.than.start.date'));/*凭证到期日期不能大于起始日期！*/
			return false;
		}
		
		if(new Date()>new Date(expireDate)){
			alert($.i18n.prop('sys.client.voucher.is.expired'));/*凭证已过期！*/
			return;
		}
		var count = $("img").size();
		if(count < 1){
			alert($.i18n.prop('sys.client.upload.voucher.picture'));/*请上传凭证图片*/
			return;
		}
		for(var i=0;i<count; i++){
			attachmentArray += $("img").eq(i).next().attr("value") + "#";
		}
		$("#addVoucherSubmitBtn").hide();
		$("#addVoucherSubmitingBtn").removeClass('none1');
		
		$.ajax({
			type:'post',
			traditional:true,
			dataType:'json',
			url:"/voucherController/addVoucherinfo",
			data:{
				"voucherNo":voucherNo,
				"expireDate":expireDate,
				"enterpriseMemeberId":enterpriseMemeberId,
				"type":type,
				"amount":amount,
				"registerDate":registerDate,
				"effectiveDate":effectiveDate,
				"remark":remark,
				"attachmentArray":attachmentArray,
			},
			success:function(data){
				if(data.responseTypeCode=="success"){
					
					alert(data.info,callback);
				}else{
					$("#addVoucherSubmitBtn").show();
					$("#addVoucherSubmitingBtn").addClass('none1');
					alert(data.info);
				}
			},
			error:function(){
				$("#addVoucherSubmitBtn").show();
				$("#addVoucherSubmitingBtn").addClass('none1');
				alert($.i18n.prop('sys.client.add.voucher.failed'));/*添加凭证失败！*/
			}
		})
	})
	
	
	callback=function(){
		parent.$(".msgbox_close").mousedown();
		parent.window.location.href="/voucherController/voucherManage";
	}
})




