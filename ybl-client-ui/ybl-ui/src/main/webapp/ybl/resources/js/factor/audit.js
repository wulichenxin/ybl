$(function(){
	
	
	//点击审核
	$("#ybl_facor_risk_audit_btn").click(function(){
		var data = {};
		data.ids= $("#financeId").val();
		data.status_ = $("#status_").val(); //审核状态
		data.operation_ = $("#audit_operation").val();
		data.comment_ = $("#audit_comment").val();
		data.auditType = $("auditType").val();
		
		$.ajax({
			type: "post",
			url: "/ProductAuditController/audit",
			data: data,
			dataType:"json",
			success: function(msg){
				alert(msg.info,callBack,msg.object.toString());
				
   			},
   			error: function(){
				alert("操作失败！",callBack);
				
			}
		  }
		);
		
	});
	
	
      $("#anqu_close").click(function() {
			parent.$(".msgbox_close").mousedown();
	 });
	 
	 
	 function callBack(url){
	 	$("#anqu_close").click();
		parent.callBackRefresh(url);//跳转到列表页面
	 }
	 
	 
	
});