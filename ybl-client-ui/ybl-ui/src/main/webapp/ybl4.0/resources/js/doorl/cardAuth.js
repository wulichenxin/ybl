$(function(){
	
	// 提交按钮
	$("#submit_info").click(function() {
		if(!$("#enterpriseName").validationEngine('validate')) {
 			return;
 		}
		if(!$("#socialCreditCode").validationEngine('validate')) {
			alert("社会统一信用代码错误！");
 			return;
 		}
		if(!$("#enterpriseShortName").validationEngine('validate')) {
 			return;
 		}
		if(!$("#legalPhone").validationEngine('validate')) {
			alert("手机号码错误！");
 			return;
 		}
		if(!$("#legalName").validationEngine('validate')) {
 			return;
 		}
		if(!$("#legalCardId").validationEngine('validate')) {
			alert("身份证号码错误！");
 			return;
 		}
		if(!$("#applicantName").validationEngine('validate')) {
 			return;
 		}
		if(!$("#applicantPhone").validationEngine('validate')) {
 			return;
 		}
		if(!$("#applicantCardId").validationEngine('validate')) {
 			return;
 		}
		if(!$("#applicantEmail").validationEngine('validate')) {
 			return;
 		}
		var applicantName = $("#applicantName").val();
		if(applicantName != ''){//申请人不为空的情况
			var applicant_card_front_td =$("#applicant_card_front_td").html();
			var applicant_card_behind_td =$("#applicant_card_behind_td").html();
			var company_authorization_td =$("#company_authorization_td").html();
			if(applicant_card_front_td =='原件、复印件、加盖公章、提供扫描件'|| applicant_card_behind_td == '原件、复印件、加盖公章、提供扫描件' || company_authorization_td =='原件、复印件、加盖公章、提供扫描件') {
				alert("必须上传申请人证件照和公司授权书！");
				return;;
			}
		}
		var business_license_td =$("#business_license_td").html(); //营业执照上传
		if(business_license_td == '原件、复印件、加盖公章、提供扫描件') {
			alert("请上传营业执照！");
			return;
		}
		var legal_card_front_td =$("#legal_card_front_td").html(); //法人身份证正面
		if(legal_card_front_td == '原件、复印件、加盖公章、提供扫描件') {
			alert("请上传法人身份证正面！");
			return;
		}
		var legal_card_behind_td =$("#legal_card_behind_td").html(); //法人身份证反面
		if(legal_card_behind_td == '原件、复印件、加盖公章、提供扫描件') {
			alert("请上传法人身份证反面！");
			return;
		}
		
		// 获取页面的参数
		var data_form= $("#DateForm").serialize();
		
		// 进行数据提交
		$.ajax({
			url : "/accountInfoController/saveCardInfo",
			dataType : "json",
			data : data_form,
			type : "post",
			success : function(data) {
			   if(data.responseTypeCode == 'success'){
				   	$("#submit_info").attr('disabled',true);
				   	$("#submit_info").css("pointer-events","none"); //提交按钮不可再次点击
				   	alert(data.info,function(){
				   		window.location.reload();
				   	});
				}else{
					alert(data.info);
				}
			},
			error : function() {
				alert("系统错误！");// 保存失败
			}
		});
	});
	
	//取消按钮
	$("#close_info").click(function(){
		window.history.go(-1);
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
		$("#business_license,#legal_card_front,#legal_card_behind,#applicant_card_front,#applicant_card_behind,#company_authorization").click(function() {
			id = $(this).attr("id");
			utype = $(this).attr("utype");
			uname = $(this).attr("uname");
			$("#common_upload_btn").click();
		});
		//var num = 0;
		// 回调，回显图片
		uploadCallback = function(obj) {
			var attachment = eval('(' + obj + ')');
			$("#common_upload_btn").val('');
			var photoUpdateId = $("#" + id).attr("attachId");
			//
			debugger;
			var num = 0;
			var num = document.getElementsByClassName("file_index").length;
			if (document.getElementsByName("attachmentList[" + num + "].url").length > 0) {
				num++;
			}
			var htmlArray = [];
			var oldName = attachment.old_name;
			htmlArray.push( "<div class='image file_index'>");
			htmlArray.push("<input type='hidden' value='" + attachment.url_ + "' name='attachmentList[" + num + "].url'/>");
			htmlArray.push("<input type='hidden' value='" + utype+ "' name='attachmentList[" + num + "].type'/>");
			htmlArray.push("<input type='hidden' value='" + uname+ "' name='attachmentList[" + num + "].remark'/>");
			htmlArray.push("<input type='hidden' value='" + attachment.old_name + "' name='attachmentList[" + num + "].oldName'/>");
			htmlArray.push("<input type='hidden' value='" + attachment.new_name + "' name='attachmentList[" + num + "].newName'/>");
			htmlArray.push("<input type='hidden' value='" + attachment.ext_name + "' name='attachmentList[" + num + "].extName'/>");
			htmlArray.push("<input type='hidden' value='1' name='attachmentList[" + num + "].category'/>");
			htmlArray.push("<input type='hidden' value='" + attachment.file_size+ "' name='attachmentList[" + num + "].fileSize'/>");
			htmlArray.push("</div>");
          // $("#" + id +"_td").html($("#" + id +"_td").html()+" "+oldName);//先展示 ，需要再改成下载
          // $("#" + id + "_div").append(htmlArray.join(""));//多个附件同时展示
			$("#" + id +"_td").html('<a>'+oldName+'</a>');//只允许一行一个附件
			$("#" + id + "_div").empty().html(htmlArray.join(""));//只允许一行一个附件
		}
		
		
		/**
		 * 审核中查看显示
		 */
		//所有input框不可编辑
		var authType = $("#authType").val();
		if(authType == 2 || authType == 1){
			$("input").attr("readonly","true");
			$(".fff").hide();
		}else{
			return;
		}
		//附件显示
		$("#business_license_td").html($("#business_license_look").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#business_license_look").attr("attachUrl")+'">'+$("#business_license_look").val()+'</a>':'');
		$("#legal_card_front_td").html($("#legal_card_front_look").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#legal_card_front_look").attr("attachUrl")+'">'+$("#legal_card_front_look").val()+'</a>':'');
		$("#legal_card_behind_td").html($("#legal_card_behind_look").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#legal_card_behind_look").attr("attachUrl")+'">'+$("#legal_card_behind_look").val()+'</a>':'');
		$("#applicant_card_front_td").html($("#applicant_card_front_look").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#applicant_card_front_look").attr("attachUrl")+'">'+$("#applicant_card_front_look").val()+'</a>':'');
		$("#applicant_card_behind_td").html($("#applicant_card_behind_look").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#applicant_card_behind_look").attr("attachUrl")+'">'+$("#applicant_card_behind_look").val()+'</a>':'');
		$("#company_authorization_td").html($("#company_authorization_id").val()!=null?'<a href="/fileDownloadController/downloadftp?id='+$("#company_authorization_id").attr("attachUrl")+'">'+$("#company_authorization_id").val()+'</a>':'');
});
