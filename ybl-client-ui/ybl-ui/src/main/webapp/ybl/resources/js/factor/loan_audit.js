$(function(){
	
	//初始化
	function initOption(){
		var statusIndex = $("#statusInputId").val();
		statusIndex = statusIndex || 0;
		$("#select_status").val(statusIndex);
	}
	
	
	
	var audit_current_index = $("#audit_current_index").val() || 0;  //全局变量-风控初审、复审的tab切换
	
	$(function(){
		loadSelectStatus();  //初始化tab选择框
		$('.content').eq(audit_current_index).show().addClass('now').siblings()
				.removeClass('now').hide();
		$('.tabnav dl dd').eq(audit_current_index).addClass('now').siblings()
				.removeClass('now');
	});
	
	
	
	$('.tabnav dl dd').click(
			function() {
				var index = $(this).index();
				audit_current_index = index;
				loadSelectStatus();  //加载选择框数据
				
				$('.content').eq(index).show().addClass('now').siblings()
						.removeClass('now').hide();
				$('.tabnav dl dd').eq(index).addClass('now').siblings()
						.removeClass('now');
				
			$("#query_reset").click();
			queryList(); //触发查询
		});
	
	

	//点击风控初审tab
	$("#query_list").click(function(){
		queryList();
	});

	
	
	
	
	//清空查询参数
	$("#query_reset").click(function(){
		$("#number_").val("");
		$("#user_name").val("");
		$("#enterprise_name").val("");
		$("#select_status").val("0");
	});
	
	
	function queryList(){
		//查询风控初审列表
		var statusArr = getStatusData();  //状态数组
		var index = $("#select_status").val();      
		var statusObj  = statusArr[index];  //当前的状态对象
		$("#status_").val(statusObj.status_);
		$("#operation_").val(statusObj.operation_);
		$("#pageForm").submit();
	}
	
	
	/*如果是初审 index=0，则选择框显示：全部 初审中、初审失败;   
	如果是复审 index=1，则显示，全部，复审中，复审失败。*/
	function loadSelectStatus(){
		var data = getStatusData();
		var str = '';
		for(var i =0; i < data.length;i++){
			str += '<option value="'+data[i].index+'">'+data[i].text+'</option>';
		}
		$("#select_status").html(str)
		initOption();
		
	}
	
	//通过风控类型，返回查询的状态对象
	//type = 0 初审
	//type = 1 复审
	function getStatusData(){
		//var type = $('.tabnav dl dd').index();
		var type  = audit_current_index;
		var data;

	
		if(type == 1){//风控复审
			data = [
			{index:"0",status_:"1020_reauditing",operation_:"",text:'全部'},
			{index:"1",status_:"1020_reauditing",operation_:"waiting",text:'复审中'},
			{index:"2",status_:"1020_reauditing",operation_:"disagree",text:'复审失败'}
			];
		}
		else{ //风控初审

			data = [{index:"0",status_:"1000_auditing",operation_:"",text:'全部'},
			{index:"1",status_:"1000_auditing",operation_:"waiting",text:'初审中'},
			{index:"2",status_:"1000_auditing",operation_:"disagree",text:'初审失败'}
			];
		}

		return data;
		
	}
	
	//点击风控初审
	$("#ybl_risk_audit_first_audit").click(function(){
		var financeIds = [];
		$('input[name="checkbox-first-audit"]:checked').each(function(){
			financeIds.push($(this).val());
		});
		if(financeIds.length==0){
			alert('请至少选中一条记录');
			return;
		}
		auditWindow(financeIds,0);
		
	});
	
	
	
	//风控初审-全选
	$("#firstAudit-checkAll").click(function(){
		var isCheckAll = $("#firstAudit-checkAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkbox-first-audit"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkbox-first-audit"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
	
	
	//风控复审-全选
	$("#reAudit-checkAll").click(function(){
		var isCheckAll = $("#reAudit-checkAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkbox-reaudit"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkbox-reaudit"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
	
	//点击风控复审
	$("#ybl_risk_audit_reaudit").click(function(){
		var financeIds = [];
		$('input[name="checkbox-reaudit"]:checked').each(function(){
			financeIds.push($(this).val());
		});
		if(financeIds.length==0){
			alert('请至少选中一条记录');
			return;
		}
		auditWindow(financeIds,1);
		
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