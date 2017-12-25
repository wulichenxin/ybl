$(function() {
	// tab切换
	$('.tabnav dl dd').click(function() {
		var index = $(this).index();
		$('.content').eq(index).show().addClass('now').siblings()
			.removeClass('now').hide();
		$('.tabnav dl dd').eq(index).addClass('now').siblings()
			.removeClass('now');
	});
	
	//判断角色认证状态显示不同内容
	var status=$("#status").val();
	var roleType=$("#roleType").val();
	if(roleType!=null && roleType!=''){//已提交认证申请
		if(status=='' || status==null || status=='authing'){//认证中
			var authing = $.i18n.prop("sys.client.authing");
			if(roleType=='supplier'){
				$("#supplier_p").html($.i18n.prop("sys.client.supplier")+authing);//商户认证审核中
			}
			if(roleType=='factor'){
				$("#factor_p").html($.i18n.prop("sys.client.factor")+authing);//保理 商认证审核中
			}
			if(roleType=='enterprise'){
				$("#enterprise_p").html($.i18n.prop("sys.client.core.enterprise")+authing);//核心企业认证审核中
			}
			$("#supplier_a").attr("href","/enterpriseController/editEnterprise?roleType=supplier");
			$("#factor_a").attr("href","/enterpriseController/editEnterprise?roleType=factor");
			$("#enterprise_a").attr("href","/enterpriseController/editEnterprise?roleType=enterprise");
			if(status=='authing'){
				$("#supplier_a").attr("href","javascript:void(0)");
				$("#factor_a").attr("href","javascript:void(0)");
				$("#enterprise_a").attr("href","javascript:void(0)");
			}
		}
		if(status=='agree'){//认证成功
			var authSuccess = $.i18n.prop("sys.client.auth.success");
			if(roleType=='supplier'){
				$("#supplier_p").html($.i18n.prop("sys.client.supplier")+authSuccess);//商户认证成功
				$("#supplier_a").attr("href","javascript:void(0)");
			}
			if(roleType=='factor'){
				$("#factor_p").html($.i18n.prop("sys.client.factor")+authSuccess);//保理 商认证成功
				$("#factor_a").attr("href","javascript:void(0)");
			}
			if(roleType=='enterprise'){
				$("#enterprise_p").html($.i18n.prop("sys.client.core.enterprise")+authSuccess);//核心企业认证成功
				$("#enterprise_a").attr("href","javascript:void(0)");
			}	
			$(".tabnav").show();
		}
		if(status=='disagree'){//认证失败
			var authFail = $.i18n.prop("sys.client.auth.failed");
			if(roleType=='supplier'){
				$("#supplier_p").html($.i18n.prop("sys.client.supplier")+authFail);//商户认证失败
				$("#supplier_a").attr("href","/enterpriseController/editEnterprise?roleType=supplier");
				$("#factor_a").attr("href","javascript:void(0)");
				$("#enterprise_a").attr("href","javascript:void(0)");
			}
			if(roleType=='factor'){
				$("#factor_p").html($.i18n.prop("sys.client.factor")+authFail);//保理 商认证失败
				$("#factor_a").attr("href","/enterpriseController/editEnterprise?roleType=factor");
				$("#supplier_a").attr("href","javascript:void(0)");
				$("#enterprise_a").attr("href","javascript:void(0)");
			}
			if(roleType=='enterprise'){
				$("#enterprise_p").html($.i18n.prop("sys.client.core.enterprise")+authFail);//核心企业认证失败
				$("#enterprise_a").attr("href","/enterpriseController/editEnterprise?roleType=enterprise");
				$("#supplier_a").attr("href","javascript:void(0)");
				$("#factor_a").attr("href","javascript:void(0)");
			}	
			$(".tabnav").show();
		}
	}else{
		$(".jsrz_box").children().removeClass().addClass("jsrz_li");
		$("#supplier_a").attr("href","/enterpriseController/editEnterprise?roleType=supplier");
		$("#factor_a").attr("href","/enterpriseController/editEnterprise?roleType=factor");
		$("#enterprise_a").attr("href","/enterpriseController/editEnterprise?roleType=enterprise");
	}
	/**
	 * 百度编辑器start
	 */
	// 百度编辑器加载
	UE.getEditor('editor', {
	/*	toolbars : [ [ 'source', 'undo', 'redo', 'bold', 'italic', 'underline',
				'fontborder', 'backcolor', 'fontsize', 'fontfamily',
				'justifyleft', 'justifyright', 'justifycenter',
				'justifyjustify', 'date', 'time', 'strikethrough',
				'superscript', 'subscript', 'removeformat', 'formatmatch',
				'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor',
				'backcolor', 'insertorderedlist', 'insertunorderedlist',
				'selectall', 'cleardoc', 'link', 'unlink', 'emotion', 'help',
				'inserttable', 'deletetable' ] ],*/
		autoHeightEnabled : false,
		zIndex : 900,
		maximumWords : 10000,
		elementPathEnabled:false,//是否启用元素路径，默认是显示，这里不展示
        enableAutoSave: false,//启用自动保存,这里不需要
		wordCountMsg : "{#count}/10000"
	});
	// 百度编辑器end

	// 保存按钮（公司简介）点击事件触发
	$("#ybl_admin_account_center_company_profile_btn").click(function() {
		// 百度编辑器校验输入字数是否超出
		var contentTxtLengthCheck = $("#edui1_wordcount").text();
		if (contentTxtLengthCheck.indexOf("字数超出") >= 0) {
			alert($.i18n.prop("sys.client.save.fail"));//保存失败!
		} else {
			saveCompanyProfile();
		}
	});
	//填充百度编辑器内容
	var companyProfile = $("#companyProfile").val();
	UE.getEditor("editor").ready(function() {
		UE.getEditor("editor").setContent(companyProfile,false);
	});
	//初始化是否三证合一复选框
	var isThreeNo =$("#isThreeInOne").val();
	if(isThreeNo=='1'){
		$("#isThreeInOne").attr("checked",true);
		$("#org_code_li").css("display","none");
		$("#tax_li").css("display","none");
	}
	//地址id转换
	var addressData=selectAddress();
	if(addressData!=''){
		$("#provinceId").attr("disabled",true);
		$("#cityId").attr("disabled",true);
		$("#areaId").attr("disabled",true);
	}
})
//保存按钮逻辑
	function saveCompanyProfile(){
		var saveUrl = "/enterpriseController/updateEnterprise";
		var enterpriseId = $("#enterpriseId").val();
		var roleType = $("#roleType").val();
		var list = UE.getEditor('editor').hasContents();//判断是否有内容
		var test = "";
		if(list != ""){
			 test = UE.getEditor('editor').getContent();
		}
		if(test != ""){
			$("#ybl_admin_account_center_company_profile_btn").hide();
			$("#submitingBtn").show();
			$.ajax({
				url:saveUrl,      
				data:{
					id:enterpriseId,
					companyProfile:test,
					roleType:roleType
				},
				type:"post",
				success:function(data){
					$("#ybl_admin_account_center_company_profile_btn").show();
					$("#submitingBtn").hide();
					if (data.responseType == 'ERROR') {
						alert(data.info);/* 服务器繁忙请稍候重试 */
					} else {
						alert(data.info);/* 数据保存/更新成功 */
					}
				},
				error : function() {
					$("#ybl_admin_account_center_company_profile_btn").show();
					$("#submitingBtn").hide();
					alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
				}
			});
		}else{
			alert($.i18n.prop("sys.client.save.data.is.not.null"));/*保存不能为空！*/
		}	
	}
