$(function(){
		
	// 校验初始化
	//var _form = ext.formValidation("supplierDateForm");
	// 保存按钮
	
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
			if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(attachment.url_)){
				$("#"+id).attr("src",attachment.url_)	
			}else{
				$("#"+id).attr("src","/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
			}
			$("#contractname").html(attachment.old_name);
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
		
		
		
		
});
