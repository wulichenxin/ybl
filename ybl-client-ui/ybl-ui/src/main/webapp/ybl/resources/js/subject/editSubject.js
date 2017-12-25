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
		maxDate : '2099-12-31'// and tommorow is maximum date calendar
	};
	// 初始化日期控件
	$('#_end_date').datetimepicker(dmf);
	var _repayDate = $("#repayDate").val();
	var _endDate = $("#eDate").val();
	if (_repayDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_repayDate);
		$("#_repayment_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	if (_endDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_endDate);
		$("#_end_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	// 初始化日期控件end
	/**
	 * 预览弹出框start
	 */
	view = function(urls) {
		if (urls != null && urls != '') {
			$.msgbox({
				height : 520,
				width : 800,
				content : '/ybl/admin/common/preview.jsp?urls='+urls,
				type : 'iframe',
				title : $.i18n.prop("sys.client.photo")//图片
			});
		}else{
			alert($.i18n.prop("sys.client.no.photo"));//暂无图片！
		}
	}
	// 预览弹出框end
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
	});
	//点击图片上传图片
	$("[names='loan_metarial_upload_btn']").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
	});
	var num=0;
	var html_div_=[];
	var codeArr = [];
	//回调，回显图片
	uploadCallback = function(obj) {
		var attachment=eval('('+obj+')');
		$("#common_upload_btn").val('');
		/*返显页面上的图片url,上传时间,预览按钮展示*/
		$("#"+id).next("a").attr("href","javascript:view('"+attachment.url_+"');");
		$("#"+id).next("a").removeClass("none1");
		$("#"+id).parent().parent().prev().html(ext.formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss'));//上传时间
		var code = $("#"+id).attr("code");
		var name = $("#"+id).attr("name");
		var remark = $("#"+id).attr("remark");
		var meaId = $("#"+id).attr("meaId");//已存在的标的贷款材料id
		/*要提交的图片数据和贷款材料数据*/
		var num_ = num;
		if($.inArray(code,codeArr)!=-1){//已操作过一次，再次操作
			num_=$("[code='c_"+code+"']").attr("num");
		}
		var photo_html_="<input type='hidden' value='" + attachment.url_ + "' name='attachmentlist["+num_+"].url'/>"
			+"<input type='hidden' value='" + attachment.old_name + "' name='attachmentlist["+num_+"].oldName'/>"
			+"<input type='hidden' value='" + attachment.new_name + "' name='attachmentlist["+num_+"].newName'/>"
			+"<input type='hidden' value='" + attachment.ext_name + "' name='attachmentlist["+num_+"].extName'/>"
			+"<input type='hidden' value='" + code + "' name='attachmentlist["+num_+"].attribute1'/>";
		var loan_html_="<input type='hidden' value='" + code+ "' name='productConfigLoanMaterialVoList["+num_+"].code'/>"
		+"<input type='hidden' value='" + name + "' name='productConfigLoanMaterialVoList["+num_+"].name'/>"
		+"<input type='hidden' value='" + remark + "' name='productConfigLoanMaterialVoList["+num_+"].remark'/>";
		if(meaId){//已存在  则更新
			loan_html_+="<input type='hidden' value='" + meaId + "' name='productConfigLoanMaterialVoList["+num_+"].id'/>";
			photo_html_+=+"<input type='hidden' value='" + meaId + "' name='attachmentlist["+num_+"].business_id'/>";
		}
		html_div_.push("<div code='c_"+code+"' class='none1' num='"+num_+"'>"+photo_html_+loan_html_+"</div>");		
		if($.inArray(code,codeArr)!=-1){//已操作过一次，再次操作
			$("[code='c_"+code+"']").html(photo_html_+loan_html_);//更新			
		}else{
			codeArr.push(code);
			num++;
			$("#loan_material_div").empty().html(html_div_.join(""));
		}
	}
	//图片上传end	
	//校验初始化
	var subjectForm = ext.formValidation("subjectForm");
	// 提交按钮
	$("#member_supplier_subject_submit_btn").click(function() {
		$("#subject_status").val("auditing");// 审核中
		var passed = subjectForm.validationEngine("validate");
		if(passed){
			$(this).hide();
			$("#member_supplier_subject_temporary_btn").hide();
			$("#submitingBtn").show();
			formSubmit();
		}
	})
	// 暂存按钮
	$("#member_supplier_subject_temporary_btn").click(function() {
		$("#subject_status").val("draft");// 草稿
		var passed = subjectForm.validationEngine("validate");
		if(passed){
			$(this).hide();
			$("#member_supplier_subject_submit_btn").hide();
			$("#submitingBtn").show();
			formSubmit();
		}
	});
	// 取消按钮(返回普通标的列表)
	$("#member_supplier_subject_cancel_btn").click(function() {
		location.href="/subjectController/subjectList";
	})
	
	// 添加凭证按钮(弹出凭证列表页面)
	$("#member_supplier_subject_finance_voucher_add_btn").click(function() {
		var checkbox = $("[name='checkbox']");
		var ids = "";
		$.each(checkbox,function(i,item){
			ids += $(this).attr("voucherId")+",";
		})
		if(checkbox.length>0){
			ids = ids.substr(0,ids.length-1);
		}
		$.msgbox({
			height : 610,
			width : 1150,
			content : '/voucherController/toVoucherSelect-'+ids,
			type : 'iframe',
			title : $.i18n.prop("sys.client.add.voucher")//添加凭证
		});
	})
	// 删除凭证按钮
	$("#member_supplier_subject_finance_voucher_delete_btn").click(function() {
		deleteMessage();
		calcRepaymentDate();
	})
	// 弹框页面添加凭证 取消按钮
	$("#member_supplier_apply_voucher_cancel_btn").click(function() {
		location.href = '/voucherController/toVoucherSelect';
	})
	//不同控制按钮
	//标的状态:草稿：draft 拒绝：reject 已发布/竞标中：biding 回款中：paymenting 流标：fail_subject 已完成：end
	var subject_status =$("#subject_status").val();
	if(subject_status=='draft' || subject_status=='reject'){//草稿状态和拒绝状态时,暂存按钮隐藏,不可操作,但可以进行提交
		$("#member_supplier_subject_temporary_btn").css("display","none");
	}else if(subject_status=="biding" || subject_status=="paymenting" || subject_status=="end"){//暂存和提交按钮隐藏
		$("#member_supplier_subject_temporary_btn").css("display","none");
		$("#member_supplier_subject_submit_btn").css("display","none");
	}
	//还款日期计算
	//触发计算还款日期
	var date = '';
	var dateNew ='';
	$("#loanPeriod").blur(function(){
		calcRepaymentDate();
	});
	$("#periodType").blur(function(){
		calcRepaymentDate();
	});
	
	if($("#number").val()=='' || $("#number").val()==null){
		var subjectNum = $("#subjectNum").val();
		$("#number").val(subjectNum)
	}
	// 全选 复选框
	$("#checkAll").click(function() {
		var isCheckAll = $("#checkAll").attr("checked");
		if (isCheckAll) {// 选中
			$("[name='checkbox']").attr("checked", true);
		} else {// 取消全选
			$("[name='checkbox']").attr("checked", false);
		}
	});
	//判断复选框是否全部勾选，全部勾选则选中全选按钮，否则不勾选全选按钮
	$("[name='checkbox']").click(function(){
		var allcheckBoxLength = $("[name='checkbox']").size();
		var allcheckedBoxLength = $("input:checkbox[name='checkbox']:checked").size();
		if(allcheckBoxLength==allcheckedBoxLength){
			$("#checkAll").attr("checked", true);
		}else{
			$("#checkAll").attr("checked", false);
		}
	})
})
//删除
function deleteMessage(){
	var ids = getCheckedIds();
	if(!ids){
		return;
	}
	
	confirm($.i18n.prop("sys.client.if.sure.delete"),function() {//是否确定删除？
		$.ajax({
			url:"/subjectController/deleteSubjectVoucherById",      
			data:{
				ids:ids
			},
			type:"post",
			success:function(data){
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info,function(){
						var idArr = ids.split(",");
						$.each(idArr,function(i,item){
							$('[ids='+item+']').parent().parent().remove();
						})
					});/* 数据删除成功 */
				}
			},
			error : function() {
				alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	});
	
}
//获取选中的id拼装的字符串
function getCheckedIds(){
	var checkArr = $("[name='checkbox']");
	var ids = '';
	var number=0;
	$.each(checkArr,function(i,item){
		if($(this).attr("checked")){
			var id = $(this).attr("ids");
			if(id=="-1"){
				$(this).parent().parent().remove();
			}else{
				ids+=$(this).attr("ids")+",";
			}
			number++;
		}
	})
	if(ids=='' || ids ==null){
		if(number==0){
			alert($.i18n.prop("sys.client.please.select.fllow.item.then.operate"));//请选择以下项目后，再进行操作。
			return ;
		}else{
			return;
		}
	}
	return ids;	
}
//提交表单
function formSubmit(){
	var subject_id = $("#subject_id").val();
	var subject_status =$("#subject_status").val();
	var subject_voucher_tb_length = $("#subject_voucher_tb").find("tr").length;
	//判断是否添加了凭证
	if(subject_voucher_tb_length<=1){
		alert($.i18n.prop("sys.client.please.add.voucher"));/*没有添加必要的凭证信息！*/
		$("#member_supplier_subject_submit_btn").show();
		if(!subject_id || subject_id=="" || subject_id==null || subject_id==undefined){
			$("#member_supplier_subject_temporary_btn").show();
		}
		$("#submitingBtn").hide();
		return;
	}
	/*判断凭证面额必须大于等于融资金额*/
	var trArr = $("#subject_voucher_tb").find("tr");
	var countAmount = 0;/*遍历添加的融资凭证列表中的凭证金额*/
	var amount = $("#amount").val();/*页面上填写的融资金额*/
	$.each(trArr,function(i,item){
		var td_htm = $(this).find("td").eq(4).html();
		if(td_htm && td_htm!=''){
			var this_amount = td_htm.replace(",","");
			countAmount += parseInt(this_amount);
		}
	});
	if(parseFloat(countAmount)-parseFloat(amount/10000)<0){
		alert("凭证总面额必须大于等于融资金额！");
		if(!subject_id || subject_id=="" || subject_id==null || subject_id==undefined){
			$("#member_supplier_subject_temporary_btn").show();
		}
		$("#member_supplier_subject_submit_btn").show();
		$("#submitingBtn").hide();
		return;
	}
	//是否添加了不同核心企业额凭证
	var enterprise_id_arr = $("[vou_type_id='vou_type_id']");
	var enterprise_ids = [];
	if(enterprise_id_arr.length>0){
		$.each(enterprise_id_arr,function(i,item){
			var id = $(this).val();
			if($.inArray(id,enterprise_ids)==-1){
				enterprise_ids.push(id);
			}
		});
		if(enterprise_ids.length>1){
			alert("请选择同一个核心企业的凭证后，再进行操作！");
			if(!subject_id || subject_id=="" || subject_id==null || subject_id==undefined){
				$("#member_supplier_subject_temporary_btn").show();
			}
			$("#member_supplier_subject_submit_btn").show();
			$("#submitingBtn").hide();
			return;
		}
	}
	//提交标的
	$.ajax({
		url:"/subjectController/addOrUpdateSubject",
		data:$("form").serialize(),
		dataType:"json",
		type:"post",
		success : function(resp) {
			if(!subject_id || subject_id=="" || subject_id==null || subject_id==undefined){
				$("#member_supplier_subject_temporary_btn").show();
			}
			$("#member_supplier_subject_submit_btn").show();
			$("#submitingBtn").hide();
			var _mess = "";
			if (resp.responseType == 'ERROR') {
				if(subject_status =='draft'){
					_mess = $.i18n.prop("sys.client.save.fail");
				}else{
					_mess = $.i18n.prop("sys.client.submit.fail");
				}
				alert(_mess,function(){
					var id = resp.object != null ? resp.object.id : "";
					$("#subject_id").val(id);
				}); /*服务器繁忙请稍候重试*/ 
			} else {
				if(subject_status =='draft'){
					_mess = $.i18n.prop("sys.client.save.success");
				}else{
					_mess = $.i18n.prop("sys.client.submit.success");
				}
				alert(_mess,function(){
					location.href="/subjectController/subjectList";
				}); /*数据保存/更新成功 */
			}
		},
		error : function() {
			if(!subject_id || subject_id=="" || subject_id==null || subject_id==undefined){
				$("#member_supplier_subject_temporary_btn").show();
			}
			$("#member_supplier_subject_submit_btn").show();
			$("#submitingBtn").hide();
			alert($.i18n.prop("sys.client.save.error")); /*服务器繁忙请稍候重试 */
		}
	});
}
//根据贷款期限和期限类型来计算还款日期
function calcRepaymentDate(){
	var periodType = $("#periodType").val();
	var loanPeriod = $("#loanPeriod").val();
	if(periodType && loanPeriod ){
		date = new Date();
		if(periodType=='day'){
			dateNew = date.setDate(date.getDate()+parseInt(loanPeriod));
		}
		if(periodType=='month'){
			dateNew = date.setMonth(date.getMonth()+parseInt(loanPeriod));
		}
		if(periodType=='year'){
			dateNew = date.setFullYear(date.getFullYear()+parseInt(loanPeriod));
		}
		//查询最早到到期的凭证到期日期
		var earliestDate = "3100-01-01";
		$("#subject_voucher_tb tr").size()
		if($("#subject_voucher_tb tr").size()> 0 ){
			for(var i=1;i<$("#subject_voucher_tb tr").size();i++){
				var datevoucher = $("#subject_voucher_tb tr").eq(i).children().eq(7).text();
				if(new Date(earliestDate)> new Date(datevoucher)){
					earliestDate = datevoucher;
				}
			}
		}
		if(new Date(dateNew) >= new Date(earliestDate)){
			$("#_repayment_date").val(ext.formatDate(new Date(earliestDate), 'yyyy-MM-dd'))
		}else{
			$("#_repayment_date").val(ext.formatDate(new Date(dateNew), 'yyyy-MM-dd'));
		}
	return ;
	}
}

