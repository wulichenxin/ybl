//大图轮播
function bigScroll(){
    $(".flashBox").each(function(index, element){
        var i=0;
        var timer=0;
        var prev=$(element).find(".bannerBtn a.prev");
        var next=$(element).find(".bannerBtn a.next");
        var pageI=$(element).find("ol li");
        var imgLi=$(element).find("ul li");
        function right() {
            i++;
            if (i == imgLi.length) {
                i = 0
            }
        }
        function left() {
            i--;
            if (i < 0) {
                i = imgLi.length - 1
            }
        }
        function run(){
            pageI.eq(i).addClass("active").siblings().removeClass("active");
            imgLi.eq(i).fadeIn(600).siblings().fadeOut(600).hide();
        }
        pageI.each(function(index){
            $(this).click(function(){
                i=index;
                run();
            });
        }).eq(0).trigger("click");
        function runn(){
            right();
            run();
        }
        timer= setInterval(runn, 8000);
        $(".flashBox").hover(function(){
            clearInterval(timer);
            $(".bannerBtn a").fadeIn(600);
        },function(){
            timer = setInterval(runn, 8000);
            $(".bannerBtn a").fadeOut(600);
        });
        prev.click(function(){
            left();
            run();
        });
        next.click(function(){
            right();
            run();
        });
    })
}
$(function(){
	//全选、反选
	$("#checkAll").click(function(){
		$("input[name='checkBox']").prop("checked",$(this).prop("checked"));
	});
	//判断复选框是否全部勾选，全部勾选则选中全选按钮，否则不勾选全选按钮
	$("[name='checkBox']").click(function(){
		var allcheckBoxLength = $("[name='checkBox']").size();
		var allcheckedBoxLength = $("input:checkbox[name='checkBox']:checked").size();
		if(allcheckBoxLength==allcheckedBoxLength){
			$("#checkAll").attr("checked", true);
		}else{
			$("#checkAll").attr("checked", false);
		}
	})
	/* beign select 自动加载*/
	$("select").each(function(index, element) {
		
		// 加载数据url
		var _url = $(element).attr("url");
		if(!_url) {
			return true;
		}
		// 实际值
		var valueField = $(element).attr("valueField");
		if(!valueField) {
			valueField = "code_";
		}
		// 显示值
		var textField = $(element).attr("textField");
		if(!textField) {
			textField = "value_";
		}
		// 默认值
		var defaultValue = $(element).attr("defaultValue");
		if(!defaultValue) {
			defaultValue = "";
		}
		// 是否有请选择选项，默认是有的
		var isSelect = $(element).attr("isSelect");
		if(!isSelect) {
			isSelect = "Y";
		}
		$.ajax({
            type: "POST",
            url: _url,
            async:false,
            data: [],
            success: function(data){
            	var _html = "";
            	if(isSelect == "Y" || isSelect == "y" || isSelect == "yes") {
            		_html += "<option value=\"\">请选择</option>";
            	}
            	for(var i = 0; i < data.length; i++) {
            		var d = data[i];
            		_html += "<option value=\"" + d[valueField] + "\" " + (defaultValue == d[valueField] ? "selected" : "") + ">" + d[textField] + "</option>";
            	}
            	$(element).html(_html);
            }
         });
	});
	/* end select 自动加载*/
	
	/* beign td,span,em 自动加载*/
	$("td,span,em,.h4_content_").each(function(index, element) {
		// 加载数据url
		var _url = $(element).attr("url");
		if(!_url) {
			return true;
		}
		// 显示值
		var textField = $(element).attr("textField");
		if(!textField) {
			textField = "value_";
		}
		$.ajax({
            type: "POST",
            url: _url,
            async:false,
            data: [],
            success: function(data){
            	$(element).html(data[textField]);
            }
         });
	});
	/* end td,span,em 自动加载*/
	/* beign count_data 自动加载 ,用于返回String，Long，Integer等等*/
	$(".count_data").each(function(index, element) {
		// 加载数据url
		var _url = $(element).attr("ajaxUrl");
		if(!_url) {
			return true;
		}
		$.ajax({
            type: "POST",
            url: _url,
            async:false,
            data: [],
            success: function(data){
            	$(element).html(data);
            }
         });
	});
	/* end count_data 自动加载*/
	/* beign li 自动加载*/
	$("li").each(function(index, element) {
		// 加载数据url
		var _url = $(element).attr("url");
		if(!_url) {
			return true;
		}
		// 实际值
		var valueField = $(element).attr("valueField");
		if(!valueField) {
			valueField = "code_";
		}
		// 显示值
		var textField = $(element).attr("textField");
		if(!textField) {
			textField = "value_";
		}
		// 默认值
		var defaultValue = $(element).attr("defaultValue");
		if(!defaultValue) {
			defaultValue = "";
		}
		// 是否有不限选项，默认是有的
		var isAll = $(element).attr("isAll");
		if(!isAll) {
			isAll = "Y";
		}
		// 是否有不限选项，默认是有的
		var spanField = $(element).attr("spanField");
		if(!spanField) {
			spanField = "";
		}
		//标识
		var aSign = $(element).attr("aSign");
		if(!aSign) {
			aSign = "";
		}
		$.ajax({
            type: "POST",
            url: _url,
            async:false,
            data: [],
            success: function(data){
            	var _html = "<span>"+spanField+":</span>";
            	if(isAll == "Y" || isAll == "y" || isAll == "yes") {
            		_html += "<a value=\"\" class=\"" + (defaultValue == "" ? "now" : "")+"\"" + " aSign=\"" + aSign + "\" >不限</a>";
            	}
            	for(var i = 0; i < data.length; i++) {
            		var d = data[i];
            		//有默认值则给选中样式
            		_html += "<a value=\"" + d[valueField] + "\" class=\"" + (defaultValue == d[valueField] ? "now" : "")+"\"" + " aSign=\"" + aSign + "\">" + d[textField] + "</a>";
            	}
            	$(element).html(_html);
            }
         });
	});
	/* end li 自动加载*/
	$.fn.watchProperty = function( name,handler ){
 		if(!this.length) return;
		var that = this[0];
		if ( "watch" in that ) {
			// that.watch(name,handler);
			var o = that[name];
			setInterval( function() {
				var n = that[name];
				if(o !== n) {
					o = n;
					handler.call(that);
				}
			}, 300);
		} else if ( "onpropertychange" in that ) {
			name = name.toLowerCase();
			that.onpropertychange = function() {
				if(window.event.propertyName.toLowerCase() === name) {
					handler.call(that);
				}
			}
		} else {
			var o = that[name];
			setInterval( function() {
				var n = that[name];
				if(o !== n) {
					o = n;
					handler.call(that);
				}
			}, 300);
		}
	};
	
	// 表单元素校验
	validationField = function() {
		var fields = $("input,select,textarea");
		var bool = true;
		for(var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var clazz = $(field).attr("class");
			if(clazz && clazz.indexOf('validate') == -1) {
				continue;
			}
			if(!$(field).validationEngine("validate")) {
				bool = false;
			}
		}
		return bool;
	};
	// 弹出窗口关闭
	$("#cancel_close").click(function(){
		parent.$(".msgbox_close").mousedown();
	})
	
	/*重写alert,带返回*/
	window.alert = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	}
	
	/*重写alert,带返回,参数*/
	window.alert = function(msg, _callback,param) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info, {
				onOk : function(v) {
					_callback(param);
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	}
	/*重写confirm,带返回*/
	window.confirm = function(msg, _callback) {
		if(_callback) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.confirm, {
				onOk : function(v) {
					_callback();
				}
			});
		} else {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.confirm);
		}
	}
})



