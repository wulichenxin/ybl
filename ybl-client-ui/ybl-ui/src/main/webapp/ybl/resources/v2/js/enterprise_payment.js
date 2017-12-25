$(function(){
	$('#paln_return_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    maxDate:jQuery('#paln_return_max_date').val()?jQuery('#paln_return_max_date').val():false
			   });
			  },
		minDate:false
		
	});
	$('#paln_return_date_a').on('click', function () {
	    $('#paln_return_date').datetimepicker('show');
	});
	$('#paln_return_max_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    minDate:jQuery('#paln_return_date').val()?jQuery('#paln_return_date').val():false
			   });
			  },
		maxDate:false
	});
	$('#paln_return_max_date_a').on('click', function () {
	    $('#paln_return_max_date').datetimepicker('show');
	});
	$('#actual_return_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    maxDate:jQuery('#actual_return_max_date').val()?jQuery('#actual_return_max_date').val():false
			   });
			  },
		minDate:false
		
	});
	$('#actual_return_date_a').on('click', function () {
	    $('#actual_return_date').datetimepicker('show');
	});
	$('#actual_return_max_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    minDate:jQuery('#actual_return_date').val()?jQuery('#actual_return_date').val():false
			   });
			  },
		maxDate:false
	});
	$('#actual_return_max_date_a').on('click', function () {
	    $('#actual_return_max_date').datetimepicker('show');
	});
	
	initDate("paln_return_date");
	initDate("paln_return_max_date");
	initDate("actual_return_date");
	initDate("actual_return_max_date");
	//初始化时间 end
	
	//生成付款批次,待付款批次查询按钮
	$("#enterprise_payment_query_btn").click(function(){
		$("#pageForm").submit();
	});
	
	$("#audit_date_a").click(function(){
		alert("test");
		$('#audit_date').datetimepicker('show');
	});
	
	
	//批量导出
	$("#exportAll").click(function(){
		$("#exportAllForm").submit();
	});
	
});

function initDate(dateId){
	var _auditDate = $('#'+dateId).val();
	if (_auditDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_auditDate);
		$("#"+dateId).val(_auditDate);
	}
}