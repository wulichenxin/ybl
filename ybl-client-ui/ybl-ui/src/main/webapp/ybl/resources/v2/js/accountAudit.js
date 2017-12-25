//凭证商品删除行 
function deleteRow(obj,id){
	$(obj).parent().parent().remove();
	if(id){
		var voucherId = $("#deleteVoucherCommoditiesIdArray").val();
		voucherId +=  id + "#";
		$("#deleteVoucherCommoditiesIdArray").val(voucherId);
	}
	
}

	$(function() {
		$("a[rel=group1]").fancybox({
		    'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group2]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group3]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group4]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		//审核详情按钮
		$(".auditDetail").click(function() {
			var id = $(this).attr("value");
			var status = $(this).attr("type");
			$.msgbox({
				height : 500,
				width : 800,
				content : '/accountsAffirmController/queryAuditDetail?id='+id + '&status=' + status,
				type : 'iframe',
				title : $.i18n.prop("sys.v2.client.audit.detail")
			});
		});
		
		listenUpload = function(){
			//监听图片上传按钮
			$("#common_upload_btn").watchProperty("value",function() {
				debugger;
				var v = $(this).val();
				console.log(v);
				if (v == '' || v == null)
					return;
				// 上传
				$("#common_upload_form").attr("action","/fileUploadController/uploadFtp?uploadUrl=/factorAudit/&_callback=uploadCallback");
				$("#common_upload_form").submit();
			});
		}
		listenUpload();
		//点击图片上传图片
		$("#uploading").click(function() {
			id = $(this).attr("id");
			$("#common_upload_btn").removeAttr("readonly");
			$("#common_upload_btn").click();
			
		});
		
		
		//图片上传end
		//删除上传的文件
		deleteAttachment = function(_this,id) {
			$(_this).parent().parent().remove();
			
		}
		
		//预览图片
		view = function(urls) {
			$.msgbox({
				height : 520,
				width : 800,
				content : '/ybl/v2/admin/common/preview.jsp?urls=' + urls,
				type : 'iframe',
				title : $.i18n.prop('sys.v2.client.voucher.attachment'),/*凭证附件*/
			});
		}
		
		//下载文件
		$(".filedown").click(function(){
			var newName = $(this).attr("value");
			var oldName = $(this).attr("name");
			if(newName == null || oldName == null){
				return;
			}
			$("#newName").val(newName);
			$("#oldName").val(oldName);
			$("#download").submit();
		})
		
		//文本框设为只读
		$("input").attr("readonly","readonly");
		$("select").attr("readonly","readonly");
		
		//tab切换
		$('.v2_t_nav dl dd').click(
			function() {
				index = $(this).index();
				$('.v2_tab_con').eq(index).show().addClass('now').siblings().removeClass('now').hide();
				$('.v2_tab dl dd').eq(index).addClass('now').siblings().removeClass('now');
				//bottom高度
				var min_height = $('.v2_tab_con').eq(index).height();
				
				if($(".v2_foot_bottom")) {
					$('body').height(min_height + 620);// 60为bottom的高度
				}
			});
		

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
		
		//初始化日期控件start
		//凭证开票日期
		$('#invoice_date').datetimepicker(dmf);
		var invoice_date = $("#invoice_date").val();
		if (invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(invoice_date);
			$("#invoice_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		// 预计回款日期
		$('#return_date').datetimepicker(dmf);
		var return_date = $("#return_date").val();
		if (return_date) {
			var fmtDate = new Date();
			fmtDate.setTime(return_date);
			$("#return_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		
		//发票开票日期
		$('#bill_invoice_date').datetimepicker(dmf);
		var bill_invoice_date = $("#bill_invoice_date").val();
		if (bill_invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(bill_invoice_date);
			$("#bill_invoice_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		
		//运输日期 
		$('#transportation_date').datetimepicker(dmf);
		var transportation_date = $("#transportation_date").val();
		if (transportation_date) {
			var fmtDate = new Date();
			fmtDate.setTime(transportation_date);
			$("#transportation_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		//初始化日期控件end
		
			
			/* 审核通过  */
			$("#factor_accountAffirm_agree_audit_btn,#factor_analyze_accountAffirm_agree_audit_btn,#factor_recheck_accountAffirm_agree_audit_btn,#factor_business_accountAffirm_agree_audit_btn").click(function() {
				if(!validationField){
					return;
				}
				formSubmit();//保存提交
			})
			
		})
	
		function formSubmit(){
			//校验 
			var operation = $("#operation").val();
			if(operation == '' || operation == null){
				alert($.i18n.prop("sys.v2.client.investBidManage.selectTheAuditResults"));/* "请选择审核结果! " */
				return false;
			}
			//选择拒绝则需输入审核意见 
			if(operation =="disagree"){
				var comment = $("#comment").val();
				if(comment == '' || comment == null){
					alert($.i18n.prop("sys.v2.client.investBidManage.fillInTheAuditOpinion"));/* "请填写审核意见! " */
					return false;
				}
			}
			
			$("#factor_accountAffirm_agree_audit_btn,#factor_analyze_accountAffirm_agree_audit_btn,#factor_recheck_accountAffirm_agree_audit_btn,#factor_business_accountAffirm_agree_audit_btn").hide();
			$(".none1").removeClass('none1');
			$.ajax({
				url:"/accountsAffirmController/auditAccount",
				data:$("form").serialize(),
				dataType:"json",
				type:"post",
				success : function(resp) {
					if (resp.responseType == 'ERROR') {
						$("#factor_accountAffirm_agree_audit_btn,#factor_analyze_accountAffirm_agree_audit_btn,#factor_recheck_accountAffirm_agree_audit_btn,#factor_business_accountAffirm_agree_audit_btn").show();
						$(".none1").addClass('none1');
						alert(resp.info);/* 服务器繁忙请稍候重试 */
					} else {
						alert(resp.info,callback);/* 数据保存/更新成功 */
					}
				},
				error : function() {
					$("#factor_accountAffirm_agree_audit_btn,#factor_analyze_accountAffirm_agree_audit_btn,#factor_recheck_accountAffirm_agree_audit_btn,#factor_business_accountAffirm_agree_audit_btn").show();
					$(".none1").addClass('none1');
					alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
				}
			});
			
		}