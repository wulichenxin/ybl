$(function(){
	/**
	 * 表单查询
	 */
	$("#btn-query").click(function(){
		$("#pageForm").submit();
	});
	
	/**
	 * 选择所有或取消
	 */
	$("#checkAll").click(function(){
		$('.tabche').each(function(){
			if($("#checkAll").is(':checked')){
				$(this).attr('checked','checked');
				$(this).prop('checked','checked');
			}
			else{
				$(this).attr('checked',false);
				$(this).prop('checked',false);
			}
		})
	})
	//重置查询
	$("#btn-reset").click(function(){
		$("input[name='createTime']").val("");
		$("input[name='lastUpdateTime']").val("");
		$("input[name='opUserName']").val("");
		$("#opType").val("");
		$("#pageForm").submit();
	});
	
});

