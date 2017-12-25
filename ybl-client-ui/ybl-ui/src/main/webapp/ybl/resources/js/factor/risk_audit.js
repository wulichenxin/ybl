$(function(){
	

	$("#ybl_facor_risk_audit_btn").click(function(){
		alert(11);
		var data = {};
		data.status_ =  $("#audit_type").val();
		data.operation_ = $("#audit_operation").val();
		data.comment_ = $("#ybl_admin_factor_risk_audit_comment");
		$.post("/RiskManageController/audit",data);
	});
	
	
	
});