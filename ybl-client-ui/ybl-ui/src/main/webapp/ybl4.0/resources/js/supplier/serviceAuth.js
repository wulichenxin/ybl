$(function(){
		
	// 校验初始化
	//var _form = ext.formValidation("supplierDateForm");
	// 保存按钮
	$("#supplier_auth_message_save_btn").click(function() {
						// 检验页面参数是否符合要求
						//var passed = _form.validationEngine("validate");
						/*if (!passed) {
							return;
						}
						//校验图片是否上传
						var identifiedCardPhoto = $("#identifiedCardPhoto").find("img").attr("src");
						var licensePhoto = $("#licensePhoto").find("img").attr("src");
						if(identifiedCardPhoto==null){
							alert($.i18n.prop("sys.v2.admin.please.upload.identification.photo"));//请上传身份证正面照！
							return;
						}
						if(licensePhoto==null){
							alert($.i18n.prop("sys.v2.admin.please.upload.business.license.face.photo"));//请上传营业执照
							return;
						}*/
						// 获取页面的参数
						var _form_data = $("#supplierDateForm").serialize();
						
						// 进行数据提交
						$.ajax({
							url : "/serviceAuthenticationController/addOrUpdateAuth",
							dataType : "json",
							data : _form_data,
							type : "post",
							success : function(data) {
									   if(data.responseType != 'ERROR'){
											alert(data.info);
											//window.history.go(-1);
											window.location.href = "/serviceAuthenticationController/authHtml";
										}else{
											alert(data.info);
										}
									},
									error : function() {
										alert($.i18n.prop("sys.v2.admin.save.error"),function(){
											
										});// 保存失败
									}
								});
					});
	
		/**
		 * 图片上传statrt
		 */
		// 监听图片上传按钮
		$("#common_upload_btn")
				.watchProperty(
						"value",
						function() {
							var v = $(this).val();
							if (v == '' || v == null)
								return;
							// 上传
							$("#common_upload_form")
									.attr("action",
											"/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadCallback");
							$("#common_upload_form").submit();
							$(this).val('');
						});
		// 点击图片上传图片 
		$("#upfile").click(function() {
			id = $(this).attr("id");
			$("#common_upload_btn").click();
		});
		//var num = 0;
		// 回调，回显图片
		uploadCallback = function(obj) {
			var attachment = eval('(' + obj + ')');
			$("#common_upload_btn").val('');
			var photoUpdateId = $("#" + id).attr("attachId");
			if (/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(attachment.url_)) {
				$("#"+id).attr("src", attachment.url_)
			} else {
				$("#"+id).attr("src",
						"/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
			}
			//$("#"+id).attr("src",attachment.url_)
			var html_ = "<input type='hidden' value='" + attachment.url_
					+ "' name='url'/>"
					+ "<input type='hidden' value='" + attachment.old_name
					+ "' name='oldName'/>"
					+ "<input type='hidden' value='" + attachment.new_name
					+ "' name='newName'/>"
					+ "<input type='hidden' value='" + attachment.ext_name
					+ "' name='extName'/>"
					+"<input type='hidden' value='" + attachment.file_size
					+ "' name='fileSize'/>";
			$("#" + id + "_div").empty().html(html_);
		}
		
		//返回
		$("#go_to_back").click(function(){
			window.history.go(-1);
		});
		//页面切换
		$('.formli').click(function(){
			$('.formli').removeClass('form_cur');
			$(this).addClass('form_cur');
			var index = $(this).index()+1;
			ClickShow('.box','.box'+index);
		});
		function ClickShow(item1,item2){
			$(item1).hide();
			$(item2).show();
		}
});
