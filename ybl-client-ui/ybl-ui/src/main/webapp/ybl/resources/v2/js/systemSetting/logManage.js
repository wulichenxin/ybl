$(function(){
	/**
	 * 查询按钮
	 */
	$("#userlog_serach_btn").click(function(){
		$("#pageForm").submit();
	})
	// 删除
	$("#log_manage_delete_btn").click(function(){
		
		var checkArr = $("[name='checkBox']");
		var ids = '';
		$.each(checkArr, function(i, item) {
			if ($(this).attr("checked")) {
				ids += $(this).attr("ids") + ",";
			}
		});
		if (ids == "" || ids == null) {
			alert($.i18n.prop("sys.v2.client.please.select.fllow.item.then.operate"));//请选择以下项目后，再进行操作。
			return;
		}
		confirm($.i18n.prop("sys.v2.client.if.sure.delete"),function() {// 是否确定删除？
			$.ajax({
				url : "/v2LogController/deleteUserLoginLog",
				data : {
					ids : ids
				},
				type : "post",
				success : function(data) {
					if (data.responseType == 'ERROR') {
						alert(data.info);/* 服务器繁忙请稍候重试 */
					} else {
						alert(data.info,function(){
							location.reload();// 刷新当前页面
						});/* 数据保存/更新成功 */
					}
				},
				error : function() {
					alert($.i18n.prop("sys.v2.client.save.error"));/* 服务器繁忙请稍候重试 */
				}
			});
		});
	});
});