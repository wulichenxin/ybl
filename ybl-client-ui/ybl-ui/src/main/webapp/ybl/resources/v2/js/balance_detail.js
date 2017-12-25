$(function(){
	//返回
	$("#return").click(function(){
		window.history.back();
		return false;
	});
	//结算-放款
	$("#v2_disbursement_balance_detail_pay").click(function(){
		//校验
		if(!$("#trxNumberSupplier").validationEngine('validate')) {
			alert("请输入交易流水号"); //
			return;
		}
		//构造参数
		var data = {};
		data.trxNumberSupplier = $("#trxNumberSupplier").val();
		//data.trxNumberPlat = $("#trxNumberPlat").val();
		data.id = $("#id_").val();
		$("#v2_disbursement_balance_detail_pay").hide();
		$("#processing_btn").show();
		//发送请求
		$.ajax({
			url:"/v2disbursementController/balanceAccounts",
			type:"POST",
			dataType:"json",
			data:data,
			success:function(resp){
				if(resp.responseTypeCode=="success"){
					alert(resp.info,function(){
						window.location = "/v2disbursementController/queryDisbursementList.htm";
					});
				}
				else{
					$("#v2_disbursement_balance_detail_pay").show();
					$("#processing_btn").hide();
					alert(resp.info);
				}
			},
			error:function(){
				$("#v2_disbursement_balance_detail_pay").show();
				$("#processing_btn").hide();
				alert("error");
			}
		});
	});
	
	
});