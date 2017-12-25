$(function(){
	//初始化时间 start
	var dmf = {
		yearOffset : 0,
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '1970-01-01', // yesterday is minimum date
		maxDate : '2099-12-31' // and tommorow is maximum date calendar
	};
	// 初始化日期控件
	$('#audit_date,#audit_max_date').datetimepicker(dmf);
	var _auditDate = $('#audit_date').val();
	if (_auditDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_auditDate);
		$("#audit_date").val(_auditDate);
	}
	var _audit_maxDate = $('#audit_max_date').val();
	if (_audit_maxDate) {
		var fmtDate = new Date();
		fmtDate.setTime(_audit_maxDate);
		$("#audit_max_date").val(_audit_maxDate);
	}
	//初始化时间 end
	
	//生成付款批次,待付款批次查询按钮
	$("#disbursement_batch_query_btn").click(function(){
		$("#pageForm").submit();
	});
	
	
	
	
	$("#audit_date_a,#audit_max_date_a").click(function(){
		$(this).prev().datetimepicker('show');
	});
	
	
	//批量导出
	$("#exportAll").click(function(){
		$("#exportAllForm").submit();
	});
	
	
	
})