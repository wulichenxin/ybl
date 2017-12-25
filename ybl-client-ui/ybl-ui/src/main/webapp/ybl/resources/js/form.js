$(function(){ 
	/**
	 * 表单提交按钮
	 */
	$("#searchBtn").click(function(){
		$("#pageForm").submit();
	});
	
	/**
	 * 表单提交按钮
	 */
	$("#resetBtn").click(function(){
		$("#pageForm :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
	});
});




