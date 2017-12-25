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
	
	//回购日期
	$('#buyback_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    maxDate:jQuery('#buyback_max_date').val()?jQuery('#buyback_max_date').val():false
			   });
			  },
		minDate:false
		
	});
	$('#buyback_date_a').on('click', function () {
	    $('#buyback_date').datetimepicker('show');
	});
	
	
	$('#buyback_max_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    minDate:jQuery('#buyback_date').val()?jQuery('#buyback_date').val():false
			   });
			  },
		maxDate:false
	});
	
	
	$('#buyback_max_date_a').on('click', function () {
	    $('#buyback_max_date').datetimepicker('show');
	});
	
	initDate("paln_return_date");
	initDate("paln_return_max_date");
	initDate("buyback_date");
	initDate("buyback_max_date");
	//初始化时间 end
	
	//生成付款批次,待付款批次查询按钮
	$("#supplier_buyback_query_btn").click(function(){
		$("#pageForm").submit();
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