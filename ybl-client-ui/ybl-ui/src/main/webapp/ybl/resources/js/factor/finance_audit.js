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
		{index:"0",status_:"1030_finance_auditing",operation_:""},
		{index:"1",status_:"1030_finance_auditing",operation_:"waiting"},
		{index:"2",status_:"1030_finance_auditing",operation_:"disagree"}
		];
		return data;
	}
	
	
	
	//点击审核
	$("#ybl_audit_finance_audit").click(function(){
		var financeIds = [];
		$('input[name="checkbox"]:checked').each(function(){
			financeIds.push($(this).val());
		});
		if(financeIds.length==0){
			alert('请至少选中一条记录');
			return;
		}
		auditWindow(financeIds,2);
		
	});
	
	
	
	//审核全选
	$("#checkAll").click(function(){
		var isCheckAll = $("#checkAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkbox"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkbox"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
	
		
	//financeIds 融资申请id数组
	//auditType 审核类型
	function auditWindow(financeIds,auditType){
		var ids = "";
		for(var i = 0; i < financeIds.length; i ++){
			ids += financeIds[i]+",";
		}
		ids = ids.substring(0,ids.length - 1);
		
		$.msgbox({
				height : 430,
				width : 620,
				content : '/ProductAuditController/auditWindow?auditType='+auditType+'&ids='+ids,
				type : 'iframe',
				title : '审核'
				
			});
	}
	
	
});