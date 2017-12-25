$(function() {
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
	$('#_begin_date').datetimepicker(dmf);
	$('#_end_date').datetimepicker(dmf);
	var _beginDate = $("#bDate").val();
	var _endDate = $("#eDate").val();
	if (_beginDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_beginDate);
		$("#_begin_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	if (_endDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_endDate);
		$("#_end_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		if($("#_end_date").val()=="2099-12-31"){
			$("#ifEffective").attr("checked",true);
			$("#_end_date").val("");
		}
	}
	//初始化日期控件end
	/**
	 * 初始化省市区下拉框start....
	 */
	initAddressSelect('provinceId', 'cityId', 'areaId','1',false);
	initAddressSelect('accountProvinceId', 'accountCityId', 'accountAreaId','1',false);
	
	//初始化省市区下拉框end....
	//初始化是否三证合一复选框
	var isThreeNo =$("#isThreeInOne").val();
	if(isThreeNo=='1'){
		$("#isThreeInOne").attr("checked",true);
		$("#org_code_li").css("display","none");
		$("#tax_li").css("display","none");
	}
	//资金数据格式化(只现实2位小数)
	var registerAmount = $("#registerAmount").val();
	if(registerAmount!=null && registerAmount!=''){
		$("#registerAmount").val(new Number(registerAmount).toFixed(2));
	}
	var factAmount = $("#factAmount").val();
	if(factAmount!=null && factAmount!=''){
		$("#factAmount").val(new Number(factAmount).toFixed(2));
	}
	//校验初始化
	var roleForm = ext.formValidation("roleAuthForm");
	//企业信息提交按钮事件
	$("#ybl_admin_account_center_role_auth_btn").click(function(){
		var cardFullFacePhoto = $("#cardFullFacePhoto").find("img").attr("src");
		var cardOppositePhoto = $("#cardOppositePhoto").find("img").attr("src");
		var orgCodePhoto = $("#orgCodePhoto").find("img").attr("src");
		var licensePhoto = $("#licensePhoto").find("img").attr("src");
		var taxPhoto = $("#taxPhoto").find("img").attr("src");
		var passed = roleForm.validationEngine("validate");
		if(passed){
			if(cardFullFacePhoto==null){
				alert($.i18n.prop("sys.client.please.upload.cardFullFacePhoto"));//请上传身份证正面照！
				return;
			}
			if(cardOppositePhoto==null){
				alert($.i18n.prop("sys.client.please.upload.cardOppsitePhoto"));//请上传身份证反面照
				return;
			}
			if(orgCodePhoto==null){
				alert($.i18n.prop("sys.client.please.upload.orgCodePhoto"));//请上传组织机构代码证
				return;
			}
			if(licensePhoto==null){
				alert($.i18n.prop("sys.client.please.upload.licensePhoto"));//请上传营业执照
				return;
			}
			if(taxPhoto==null){
				alert($.i18n.prop("sys.client.please.upload.taxPhoto"));//请上传税务登记证！
				return;
			}
			$(this).hide();
			$("#submitingBtn").show();
			$.ajax({
				url:"/enterpriseController/addOrUpdateEnterprise",
				data:$("form").serialize(),
				dataType:"json",
				type:"post",
				success:function(resp){
					$(this).show();
					$("#submitingBtn").hide();
	    			if(resp.responseType == 'ERROR'){
	    				alert(resp.info);/* 服务器繁忙请稍候重试 */
	    			}else{
	    				alert($.i18n.prop("sys.client.info.submit.success.be.auditing"),function(){
	    					var roleType = $("#roleType").val();
		    				location.href="/enterpriseController/toRoleAuth?roleType="+roleType;
	    				});//恭喜您！资料提交成功，正在审核中... 
	    			}         		
	    		},
	    		error:function(){
	    			$(this).show();
					$("#submitingBtn").hide();
	    			alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
	    		}
			});
			
		}
	})
	
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
		$(this).val('');
		//暂时不能操作提交按钮，等返回后再说
		$("#ybl_admin_account_center_role_auth_btn").attr("disabled",true);
	});
	//点击图片上传图片
	$("#cardFullFacePhoto,#cardOppositePhoto,#orgCodePhoto,#licensePhoto,#taxPhoto").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
	});
	var num=0;
	//回调，回显图片
	uploadCallback = function(obj) {
		var attachment=eval('('+obj+')');
		$("#common_upload_btn").val('');
		var photoUpdateId = $("#"+id).find("img").attr("photoId");
		$("#"+id).empty().html("<img src='" + attachment.url_ + "'/>");
		var html_="<input type='hidden' value='" + attachment.url_ + "' name='attachmentlist["+num+"].url'/>"
			+"<input type='hidden' value='userCertificate_" + id + "' name='attachmentlist["+num+"].type'/>"
			+"<input type='hidden' value='" + attachment.old_name + "' name='attachmentlist["+num+"].oldName'/>"
			+"<input type='hidden' value='" + attachment.new_name + "' name='attachmentlist["+num+"].newName'/>"
			+"<input type='hidden' value='" + attachment.ext_name + "' name='attachmentlist["+num+"].extName'/>";
		if(photoUpdateId && photoUpdateId!='' && photoUpdateId!=null){
			html_+="<input type='hidden' value='" + photoUpdateId + "' name='attachmentlist["+num+"].id'/>"//更新时有图片id
		}
		$("#"+id+"_div").empty().html(html_);
		num++;
		
		//释放操作提交按钮，等返回后再说
		$("#ybl_admin_account_center_role_auth_btn").attr("disabled",false);
	}
	//图片上传end	
	
	//复选框（是否三证合一）
	$("#isThreeInOne").click(function(){
		var isCheckAll = $("#isThreeInOne").attr("checked");
		if(isCheckAll){//选中，隐藏机构代码证、税务登记证
			$("#org_code_li").css("display","none");
			$("#tax_li").css("display","none");
			$("#isThreeInOne").val("1");
		}else{//取消全选
			$("#org_code_li").css("display","block");
			$("#tax_li").css("display","block");
			$("#isThreeInOne").val("0");
		}		
	});
	//复选框(是否永久有效)
	$("#ifEffective").click(function(){
		var isCheckAll = $("#ifEffective").attr("checked");
		if(isCheckAll){//选中，结束日期为永久（考虑到时间字段不能为空，设置一个较长的时间2050-01-01）
			$("#_end_date").attr("disabled","disabled")
			$("#_end_date").val("");
		}else{//取消全选
			$("#_end_date").removeAttr("disabled")
		}		
	});	
})