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
	$("#generate_batch_query_btn").click(function(){
		$("#pageForm").submit();
	});
	
	
	
	$("#audit_date_a,#audit_max_date_a").click(function(){
		$(this).prev().datetimepicker('show');
	});
	
	//全选
	$("#checkAll").click(function(){
		//checked是checkbox的属性 ，这句话的意思就是把当前checkAll选择框的属性赋值给$("input[name='checkbox']")选中的选择框中。
			$("input[name='checkbox']").prop("checked",$(this).prop("checked"));
		});
	
	
	
	//生成待付款批次
	$("#v2_generate_batch").click(function(){
		
		var idsArr = [];
		$('input[name="checkbox"]:checked').each(function(){
			idsArr.push($(this).val());
		});
		
		if(idsArr.length == 0){
			alert("请至少选中一个选项");
			return;
		}
		
		var ids="";
		for(var i = 0; i < idsArr.length;i++){
			ids += idsArr[i] + ',';
		}
		ids = ids.substring(0,ids.length - 1);
		
		postGenerateBatch(ids);
		
	});
	
	
	//生成待处理批次
	$(".generateSingleBatch").click(function(){

		var ids = $(this).attr("value");
		
		postGenerateBatch(ids)
	});
	
	
	
	function postGenerateBatch(ids){
		
		var data = {};
		data.ids = ids;
		
		//发送请求
		$.ajax({
			url:"/v2disbursementController/generateDisburseBatch",
			type:"POST",
			dataType:"json",
			data:data,
			success:function(resp){
				
				if(resp.responseTypeCode=="success"){
					alert(resp.info,function(){
						window.location = "/v2disbursementController/queryGenerateBatchList.htm";
					});
				}
				else{
					alert(resp.info);
				}
			},
			error:function(){
				alert("error");
			}
			
		});
		
	}
	
	
	//批量导出
	$("#exportAll").click(function(){
		$("#exportAllForm").submit();
	});
	
	
	
})