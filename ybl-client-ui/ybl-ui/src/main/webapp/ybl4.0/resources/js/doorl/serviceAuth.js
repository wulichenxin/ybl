$(function() {
	$("#supplierDateForm").validationEngine();
	// 保存按钮
	$("#supplier_auth_message_save_btn")
			.click(
					function() {
						/*数据校验*/
						if(!$("#supplierDateForm").validationEngine('validate')){
							$('.box').each(function(index){
								$('.box').hide();
						        if($(this).find("div.formErrorContent").length >= 1){
						        	$(this).show();
						        	$(this).validationEngine("updatePromptsPosition");
						        	$('.formli').removeClass('form_cur');
						        	var formli = $('.formli');
						    		$(formli[index]).addClass('form_cur');
						    		return false;
						        };
						        return false;
					          });
							return ;
						}
						if ($("#business_license_div").html() == null
								|| $("#business_license_div").html() == "" || $("#business_license_div").html().length == 0) { 
							top.alert("请上传营业执照(三证合一)！");
							return;
						}
						if ($("#license_account_div").html() == null
								|| $("#license_account_div").html() == "" || $("#license_account_div").html().length == 0) {
							top.alert("请上传开户许可证！");
							return;
						}
						if ($("#credit_code_div").html() == null
								|| $("#credit_code_div").html() == "" || $("#credit_code_div").html().length == 0 ) {
							top.alert("请上传机构信用代码证！");
							return;
						}
						if ($("#legal_representative_identity_card_div").html() == null
								|| $("#legal_representative_identity_card_div" ).html() == "" || $("#legal_representative_identity_card_div" ).html().length == 0) {
							top.alert("请上传法人代表人身份证！");
							return;
						}
						var authType = $("#authType").val(); // 业务认证类型1-融资方2-资金方3-核心企业
						if (authType == '1') {
							if ($("#association_articles_div").html() == null
									|| $("#association_articles_div").html() == "" || $("#association_articles_div").html().length == 0) {
								top.alert("请上传公司章程！");
								return;
							}
							if ($("#enterprise_credit_repor_div").html() == null
									|| $("#enterprise_credit_repor_div").html() == "" || $("#enterprise_credit_repor_div").html().length == 0) {
								top.alert("请上传企业信用报告！");
								return;
							}
						}
						var check = document.getElementById("check");
						if(check!= null && !check.checked){
					        top.alert("请先阅读并勾选申明协议！");
					        return false;        
					    }
						var _form_data = $("#supplierDateForm").serialize();
						// 进行数据提交
						$
								.ajax({
									url : "/serviceAuthenticationController/addOrUpdateAuth",
									dataType : "json",
									data : _form_data,
									type : "post",
									success : function(data) {
										if (data.responseType != 'ERROR') {
											$("#supplier_auth_message_save_btn").attr('disabled',true);
										   	$("#supplier_auth_message_save_btn").css("pointer-events","none"); //提交按钮不可再次点击
											top.alert(data.info,function(){
												window.location.href = "/serviceAuthenticationController/authHtml";
						            		});
										} else {
											top.alert(data.info);
										}
									},
									error : function() {
										top.alert(
												$.i18n
														.prop("sys.v2.admin.save.error"),
												function() {

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
	$(
			"#business_license,#license_account,#credit_code,#legal_representative_identity_card,#association_articles,#capital_verification_report,#enterprise_credit_repor,#company_shareholders_introduction,#company_executives_introduction,#company_business_introduction")
			.click(function() {
				id = $(this).attr("id");
				utype = $(this).attr("utype");
				uname = $(this).attr("uname");
				$("#common_upload_btn").click();
			});
	// var num = 0;
	// 回调，回显图片
	uploadCallback = function(obj) {
		var attachment = eval('(' + obj + ')');
		$("#common_upload_btn").val('');
		var photoUpdateId = $("#" + id).attr("attachId");
		var num = 0;
		var num = document.getElementsByClassName("file_index").length;
		if (document.getElementsByName("attachmentList[" + num + "].url").length > 0) {
			num++;
		}
		var htmlArray = [];
		var oldName = attachment.old_name;
		var newName = attachment.new_name;
		htmlArray.push("<div class='image file_index'>");
		htmlArray.push("<input type='hidden' value='" + attachment.url_
				+ "' name='attachmentList[" + num + "].url'/>");
		htmlArray.push("<input type='hidden' value='" + utype
				+ "' name='attachmentList[" + num + "].type'/>");
		htmlArray.push("<input type='hidden' value='" + uname
				+ "' name='attachmentList[" + num + "].remark'/>");
		htmlArray.push("<input type='hidden' value='" + attachment.old_name
				+ "' name='attachmentList[" + num + "].oldName'/>");
		htmlArray.push("<input type='hidden' value='" + attachment.new_name
				+ "' name='attachmentList[" + num + "].newName'/>");
		htmlArray.push("<input type='hidden' value='" + attachment.ext_name
				+ "' name='attachmentList[" + num + "].extName'/>");
		htmlArray.push("<input type='hidden' value='2' name='attachmentList["
				+ num + "].category'/>");
		htmlArray.push("<input type='hidden' value='" + attachment.file_size
				+ "' name='attachmentList[" + num + "].fileSize'/>");
		htmlArray.push("</div>");
		//$("#" + id + "_td").html(oldName);// 只允许一行一个附件
		$("#" + id + "_td").html("<a href='/fileDownloadController/downloadNow?newName="+newName+"&oldName="+oldName+"&extName="+attachment.ext_name+"'>"+oldName+"</a>");
		$("#" + id + "_div").empty().html(htmlArray.join(""));// 只允许一行一个附件
	}

	// 返回
	$("#go_to_back").click(function() {
		window.history.go(-1);
	});
	// 页面切换
	$('.formli').click(function() {
		$('.formli').removeClass('form_cur');
		$(this).addClass('form_cur');
		var index = $(this).index() + 1;
		ClickShow('.box', '.box' + index);
	});
	function ClickShow(item1, item2) {
		$(item1).hide();
		$(item2).show();
	}
});
