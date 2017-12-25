$(function(){
	$('#disbursement_date').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    maxDate:jQuery('#disbursement_date_max').val()?jQuery('#disbursement_date_max').val():false
			   });
			  },
		minDate:false
		
	});
	$('#disbursement_date_a').on('click', function () {
	    $('#disbursement_date').datetimepicker('show');
	});
	$('#disbursement_date_max').datetimepicker({
		yearOffset:0,
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		onShow:function( ct ){
			   this.setOptions({
			    minDate:jQuery('#disbursement_date').val()?jQuery('#disbursement_date').val():false
			   });
			  },
		maxDate:false
	});
	$('#disbursement_date_max_a').on('click', function () {
	    $('#disbursement_date_max').datetimepicker('show');
	});
	
	
	
	initDate("disbursement_date");
	initDate("disbursement_date_max");

	//初始化时间 end
	
	//生成付款批次,待付款批次查询按钮
	$("#platform_recon_query_btn").click(function(){
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