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
		location.href = "/v2BalanceController/queryBuyBackList.htm";
	});
	
	$("#v2_single_buyback_save").click(function(){
		//校验
		if(!$("#payTime").validationEngine('validate')) {
			alert($.i18n.prop("sys.v2.client.enter.buyback.date")); /*请输入回购日期*/
			return;
		}
		
		if(!$("#trxNumber").validationEngine('validate')) {
			alert($.i18n.prop("sys.v2.client.enter.trade.stream.number"));/*请输入交易流水号*/
			return;
		}
		
		//构造参数
		var data = {};
		data.amount = $("#amount").val();
		data.payTimeStr = $("#payTime").val();
		data.trxNumber = $("#trxNumber").val();
		data.buybackId = $("#buybackId").val();
		
		var postUrl = "/v2buybackController/saveBuyback";
		var locationUrl = "/v2BalanceController/queryBuyBackList.htm";
		
		$("#v2_single_buyback_save").hide();
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
					$("#v2_single_buyback_save").show();
					$("#processing_btn").hide();
					alert(resp.info);
				}
			},
			error:function(){
				$("#v2_single_buyback_save").show();
				$("#processing_btn").hide();
				alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*系统繁忙，请稍后重试*/
			}
			
		});
		
	});
	
	
	
});