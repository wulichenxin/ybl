


$(function(){
	
	$('#payTime').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			   });
			  },
		minDate:false
		
	});
	$('#payTime_a').on('click', function () {
	    $('#payTime').datetimepicker('show');
	});
	
	
	//返回
	$("#return").click(function(){
		location.href = "/v2BalanceController/queryRefundProcessList.htm";
	});
	

	
	$("#v2_single_reimburse_save").click(function(){
		//校验
		if(!$("#amount").validationEngine('validate')) {
			alert("请输入本次退款的金额"); //
			return;
		}
		
		if(!$("#payTime").validationEngine('validate')) {
			alert("请输入退款日期"); //
			return;
		}
		
		if(!$("#trxNumber").validationEngine('validate')) {
			alert("请输入交易流水号");
			return;
		}
		
		//构造参数
		var data = {};
		data.amount = $("#amount").val();
		data.payTimeStr = $("#payTime").val();
		data.trxNumber = $("#trxNumber").val();
		data.comment = $("#comment").val();
		data.reimburseId = $("#reimburseId").val();
		
		var postUrl = "/v2reimbursementController/saveReimburse";
		var locationUrl = "/v2BalanceController/queryRefundProcessList.htm";
		
		//增加""处理中""状态，避免重复提交
		$("#v2_single_reimburse_save").hide();
		$("#processing_btn").show();
		
		//发送请求
		$.ajax({
			url:postUrl,
			type:"POST",
			dataType:"json",
			data:data,
			success:function(resp){
				
				if(resp.responseTypeCode=="success"){
					alert(resp.info,function(){
						window.location = locationUrl;
					});
				}
				else{
					$("#v2_single_reimburse_save").show();
					$("#processing_btn").hide();
					alert(resp.info);
				}
			},
			error:function(){
				$("#v2_single_reimburse_save").show();
				$("#processing_btn").hide();
				alert("error");
			}
			
		});
		
	});
	
	
	
	
});