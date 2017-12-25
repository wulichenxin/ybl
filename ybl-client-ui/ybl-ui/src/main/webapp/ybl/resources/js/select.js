$(function(){ 
	/**
	 	<select id="registType" name="this.id" 
		url="/configController/get-ENTERPRISE_REGIST_TYPE" 
		valueFiled="code"
		textField="value"
		defaultValue="${o.registType }"
		isSelect="Y"
		class="select w200">
		</select>
		*/
	/* beign select 自动加载*/
	$("select").each(function() {
		// 加载数据url
		var _url = $(this).attr("url");
		if(!_url) return true;
		// 实际值
		var valueField = $(this).attr("valueField");
		if(!valueField) {
			valueField = "code";
		}
		// 显示值
		var textField = $(this).attr("textField");
		if(!textField) {
			textField = "value";
		}
		// 默认值
		var defaultValue = $(this).attr("defaultValue");
		if(!defaultValue) {
			defaultValue = "";
		}
		// 是否有请选择选项，默认是有的
		var isSelect = $(this).attr("isSelect");
		if(!isSelect) {
			isSelect = "Y";
		}
		var _selObj = $(this);
		$.ajax({
            type: "POST",
            url: _url,
            data: [],
            success: function(data){
            	var _html = "";
            	if(isSelect == "Y" || isSelect == "y" || isSelect == "yes") {
            		_html += "<option>请选择</option>";
            	}
            	for(var i = 0; i < data.length; i++) {
            		var d = data[i];
            		_html += "<option value=" + d[valueField] + " " + (defaultValue == d[valueField] ? "selected" : "") + ">" + d[textField] + "</option>";
            	}
            	_selObj.html(_html);
            }
         });
	});
	/* end select 自动加载*/
});




