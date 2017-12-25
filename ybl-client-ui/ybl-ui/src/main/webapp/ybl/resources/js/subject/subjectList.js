$(function() {
	/**
	 * 普通标的管理按钮
	 */
	// 查询按钮
	$("#member_supplier_common_subject_query_btn").click(function() {
		$("#pageForm").submit();
	})
	// 重置按钮
	$("#member_supplier_common_subject_reset_btn").click(function() {
		$("#isLoan").val("");
		$("#status").val("");
		$("#number").val("");
	});
	// 删除按钮
	$("#member_supplier_common_subject_delete_btn").click(function() {
		deleteMessage();
	})
	// 新增按钮跳转页面
	$("#member_supplier_common_subject_add_btn").click(function() {
		location.href = "/subjectController/editSubject";
	})
	// 修改按钮跳转页面
	$("#member_supplier_common_subject_edit_btn").click(function() {
		var len =$("input[name='checkbox']:checked").size();
		//判断选中几个
		if(len>1){
			alert($.i18n.prop("sys.client.please.select.one.item.then.operate"));//请选择其中一个项目，再进行操作！
			return ;
		}
		var subjectId = getCheckedIds('update').replace(",", "");
		location.href = "/subjectController/editSubject?id=" + subjectId;
	})
	// 查看标的按钮跳转页面
	$("#member_supplier_common_subject_look_btn").click(function() {
		var len =$("input[name='checkbox']:checked").size();
		//判断选中几个
		if(len>1){
			alert($.i18n.prop("sys.client.please.select.one.item.then.operate"));//请选择其中一个项目，再进行操作！
			return ;
		}
		var subjectId = getCheckedIds('').replace(",", "");
		location.href = "/subjectController/lookSubject-" + subjectId;
	})
	//流标按钮
	$("#member_supplier_common_subject_flow_btn").click(function(){
		failSubject();
	})
	
	/**
	 * 竞标的管理按钮
	 */
	// 查询按钮
	$("#member_supplier_bid_subject_query_btn").click(function() {
		$("#pageForm").submit();
	})
	// 重置按钮
	$("#member_supplier_bid_subject_reset_btn").click(function() {
		$("#status").val("");
		$("#number").val(""); 
	});
	// 查看竞标按钮跳转页面
	$("#member_supplier_bid_subject_look_btn").click(function() {
		var id =$('input:radio:checked').val();
		var status = $('input:radio:checked').attr("status");
		if(id=='' || id==null){
			alert($.i18n.prop("sys.client.please.select.one.item.then.operate"));//请选择其中一个项目，再进行操作！
			return;
		}
		$.msgbox({
			height : 542,
			width : 1000,
			content : '/subjectController/queryBidList?loanSignId='+id+'&status='+status,
			type : 'iframe',
			title : $.i18n.prop("sys.client.look.bider")//查看竞标方
		});
	})
	// 选择中标方按钮弹框页面
	$("#member_supplier_bid_subject_flow_btn").click(function() {
		var loanSignId =$('input:radio:checked').val();
		var status =$('input:radio:checked').attr("status");
		if(loanSignId=='' || loanSignId==null){
			alert($.i18n.prop("sys.client.please.select.one.item.then.operate"));//请选择其中一个项目，再进行操作！
			return;
		}	
		//标的状态:草稿：draft,拒绝：reject,已发布/竞标中：biding ,回款中：paymenting,流标：fail_subject,已完成：end
		if(status=='paymenting'){
			alert($.i18n.prop("sys.client.this.project.bided.change.again.then.operate"));//该项目已中标，请重新选择项目后，再进行操作。
			return;
		}
		if(status=='fail_subject'){
			alert($.i18n.prop("sys.client.this.project.fail_subject.change.again.then.operate"));//该项目已流标，请重新选择项目后，再进行操作。
			return;
		}
		if(status=="end"){
			alert($.i18n.prop("sys.client.this.project.end.change.again.then.operate"));//该项目已成交，请重新选择项目后，再进行操作。
			return;
		}
		if(status=="reject"){
			alert("该项目已被拒绝，请重新选择项目后，再进行操作。");//该项目已成交，请重新选择项目后，再进行操作。
			return;
		}
		$.msgbox({
			height : 542,
			width : 1000,
			content : '/subjectController/queryBidList?loanSignId='+loanSignId,
			type : 'iframe',
			title : $.i18n.prop("sys.client.chooese.bider")//选择中标方
		});
	})
	
	/**
	 * 流标的管理按钮
	 */
	// 查询按钮
	$("#member_supplier_fail_subject_query_btn").click(function() {
		$("#pageForm").submit();
	})
	// 重置按钮
	$("#member_supplier_fail_subject_reset_btn").click(function() {
		$("#number").val("");
	});
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

// 删除
function deleteMessage() {
	var ids = getCheckedIds('delete');
	if(!ids){
		return;
	}
	confirm($.i18n.prop("sys.client.if.sure.delete"),function() {//是否确定删除？
		$.ajax({
			url : "/subjectController/deleteSubject",
			data : {
				ids : ids
			},
			type : "post",
			success : function(data) {
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info);/* 数据保存/更新成功 */
					location.reload();// 刷新当前页面
				}
			},
			error : function() {
				alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	})
}
//流标
function failSubject() {
	var ids = getCheckedIds('flow');
	if(!ids){
		return;
	}
	confirm($.i18n.prop("sys.client.if.sure.flow.choosed.subject"),function() {/*是否确定流标以下选中的标的？*/
		$.ajax({
			url : "/subjectController/updateSubjectStatus",
			data : {
				ids : ids,
				status:"fail_subject"
			},
			type : "post",
			success : function(data) {
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info);/* 数据保存/更新成功 */
					location.reload();// 刷新当前页面
				}
			},
			error : function() {
				alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	});
}
// 获取选中的id拼装的字符串
function getCheckedIds(type) {
	var checkArr = $("[name='checkbox']");
	var ids = '';
	var isDraft=true;
	var isFlow=true;
	$.each(checkArr, function(i, item) {
		if ($(this).attr("checked")) {
			ids += $(this).attr("ids") + ",";
			if(type!=''){//修改或删除或流标
				if(type!='flow' && $(this).attr("status")!="draft"){//草稿状态才能删除、编辑
					isDraft=false;
				}
				if(type=='flow' && $(this).attr("status")!="biding"){//发布中才能流标
					isFlow=false;
				}
			}
		}
	})
	if (ids == "" || ids == null) {
		alert($.i18n.prop("sys.client.please.select.fllow.item.then.operate"));//请选择以下项目后，再进行操作。
		return;
	}
	if(!isDraft){
		alert($.i18n.prop("sys.client.only.draft.project.cando.please.select.again"));//只有草稿状态的项目才能进行此操作，请重新选择
		return;
	}
	if(!isFlow){
		alert($.i18n.prop("sys.client.only.release.project.cando.please.select.again"));//只有已发布/竞标中状态的项目才能进行此操作，请重新选择。
		return;
	}
	return ids;
}