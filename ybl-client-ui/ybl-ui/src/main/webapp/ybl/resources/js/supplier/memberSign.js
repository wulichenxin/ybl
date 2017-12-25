
$(function(){
	/**
	 * 图片上传statrt
	 */
	//监听图片上传按钮
	$("#common_upload_btn").watchProperty("value",function() {
		var v = $(this).val();
		if(v == '' || v == null) return;
		// 上传
		$("#common_upload_form").attr("action", "/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
		$("#common_upload_form").submit();
	});
	//点击图片上传图片
	$("#addPicture").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
	});
	//回调，回显图片
	uploadCallback = function(_url) {
		$("#common_upload_btn").val('');
		$("#"+id).append("<img src='" + _url + "'/>");
	}
	//图片上传end
	
})