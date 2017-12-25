$(function() {
	//中标按钮
	$("#member_supplier_bid_choose_company_bid_btn").click(function(){
		bidSubject();
	});
	//取消按钮
	$("#member_supplier_bid_choose_company_cancel_btn").click(function(){
		//关闭弹出框
		$(".msgbox_close").mousedown();
	});
});
//中标操作
function bidSubject(){
	var factorName = '';
	var id =$('input:radio:checked').val();
	var subjectId =$('input:radio:checked').attr("subjectId");
	var isAgree = $("#isAgree").attr("checked");
	if(!isAgree){
		alert($.i18n.prop("sys.client.please.agree.sign.facte.loan.contract.then.operate"));//请同意签署保理贷款合同合约后，再进行操作。
		return;
	}
	if (id == "" || id == null) {
		alert($.i18n.prop("sys.client.please.select.bider.then.operate"));//请选择以下中标方后，再进行操作。
		return;
	}
	var ids = getNoCheckedIds(id);
	factorName = $('input:radio:checked').parent().next().next().find("a").html();
	/*确认选择+factorName+为中标方？*/
	confirm($.i18n.prop("sys.client.sure.select")+factorName+$.i18n.prop("sys.client.be.bider")+"?",function() {
		$.ajax({
			url:"/subjectController/updateSubjectBid",      
			data:{
				ids:ids,
				id:id,
				subjectId:subjectId
			},
			type:"post",
			success:function(data){
				if (data.responseType == 'ERROR') {
					alert(data.info);/* 服务器繁忙请稍候重试 */
				} else {
					alert(data.info,function(){
						//关闭弹出框
						parent.$(".msgbox_close").mousedown();
						window.parent.location.reload();
					});/* 数据删除成功 */
					
				}
			},
			error : function() {
				alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
			}
		});
	});
}
//获取未选中的id拼装的字符串
function getNoCheckedIds(id){
	var radio=$("[name='radio']");
	var ids='';
	$.each(radio,function(i,item){
		if($(this).val()!=id){
			ids+=$(this).val()+",";
		}
	});
	return ids;	
}
