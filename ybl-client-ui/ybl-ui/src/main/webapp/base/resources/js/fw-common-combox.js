$(function(){
	
	function comboxEvent(){
		var me = $(this);
		//注册重新加载事件
		me.off("comboxReload").on("comboxReload",comboxEvent);
		//注册清除事件
		me.off("comboxClear").on("comboxClear",function(){
			me.html("<option value=''>请选择</option>")
		});
		var ajaxUrl = me.attr("ajaxurl");
		var valueField = me.attr("valueField");
		var textField = me.attr("textField");
		var defaultValue = me.attr("defaultValue");
		if(ajaxUrl){
			$.ajax({
				url:ajaxUrl,
				dataType:"json",
				type:"post",
				success:function(data){
					if(data.responseType=="SUCCESS"&&data.object){
						var array = data.object;
						var len = array.length;
						if(len){
							var _htm = ["<option value=''>请选择</option>"];
							for(var i=0;i<len;i++){
								var pojo = array[i];
								_htm.push("<option value='"+pojo[valueField]+"'>"+pojo[textField]+"</option>")
							}
							me.html(_htm.join(""));
							if(defaultValue){
								me.val(defaultValue);
							}
						}
					}else if(!data.responseType){
						console.log("请求错误");
					}
				},
				error:function(){
					
				}
			});
		}
	}
	
	$(".fw_comp_select").each(comboxEvent);
});