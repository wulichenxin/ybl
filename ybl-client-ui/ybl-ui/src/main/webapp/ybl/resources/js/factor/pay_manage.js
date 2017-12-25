$(function(){
	
	function initOption(){
		var statusIndex = $("#status_index").val(); 		
		statusIndex = statusIndex || 0; 		
		$("#select_status").val(statusIndex);
	}
	
	initOption();

	//查询列表
	$("#query_list").click(function(){
		var statusArr = getStatusData();  //状态数组
		var index = $("#select_status").val();      
		var statusObj  = statusArr[index];  //当前的状态对象
		$("#status_").val(statusObj.status_);
		$("#operation_").val(statusObj.operation_);
		$("#pageForm").submit();
	});

	
	//清空查询参数
	$("#query_reset").click(function(){
		$("#number_").val("");
		$("#user_name").val("");
		$("#select_status").val("0");
	});
	

	

//选择列表状态
	function getStatusData(){
		var data = [
		{index:"0",status_:"1040_pay_audit",operation_:""}, //查询全部：包括
		{index:"1",status_:"1040_pay_audit",operation_:"waiting"},
		{index:"2",status_:"2000_end",operation_:"agree"}
		];
		return data;
	}
	
	
	
	//点击审核
	$("#ybl_audit_pay_audit").click(function(){
		var financeIds = [];
		$('input[name="checkbox"]:checked').each(function(){
			financeIds.push($(this).val());
		});
		if(financeIds.length==0){
			alert('请至少选中一条记录');
			return;
		}
		auditWindow(financeIds,3);
		
	});
	
	
	$("#checkAll").click(function(){
		//checked是checkbox的属性 ，这句话的意思就是把当前checkAll选择框的属性赋值给$("input[name='checkbox']")选中的选择框中。
			$("input[name='checkbox']").prop("checked",$(this).prop("checked"));
		});
	
		
	//financeIds 融资申请id数组
	//auditType 审核类型  0 风控审核 1 风控复审 2 财务审核 3出账管理
	function auditWindow(financeIds,auditType){
		var ids = "";
		for(var i = 0; i < financeIds.length; i ++){
			ids += financeIds[i]+',';
		}
		ids = ids.substring(0,ids.length - 1);
		
		$.msgbox({
				height : 430,
				width : 620,
				content : '/ProductAuditController/auditWindow?auditType='+auditType+'&ids='+ids,
				type : 'iframe',
				title : '支付'
				
			});
	}
	
	
});