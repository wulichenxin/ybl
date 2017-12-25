


/**
 * 国融信dialog组件
 */
var dialog = {
	/**
	 * 弹窗-打开一个页面,返回一个dialogId,用于关闭时用到
	 * @param url  --必填项目
	 * @param width	--默认值800px
	 * @param height --默认值600px
	 * @param dialogId --指定dialogId,如果不指定,则返回默认生成的id
	 * return dialogId
	 */
	open:function(url,width,height,dialogId){
		if(!url){
			alert("ERROR dialog.open(args  url 不能为空")
			return;
		}
		width = width||"100%";
		height = height||"100%";
		dialogId = dialogId||"dialog_"+Date.now();
		var styleWidth = null; 
		if(Math.round(width.replace("px",""))){
			styleWidth = "width:"+width;
		}
		var _htm = [];
		_htm.push("<div id='"+dialogId+"' class='_dialog_fw' style='display:none;'><div class='t_window'></div>");
		
		if(styleWidth){
			_htm.push("<div class='window_box' style='"+styleWidth+"'>");
		}else{
			_htm.push("<div class='window_box'>");
		}
		_htm.push("<iframe src='"+url+"' width='"+width+"' height='"+height+"'></iframe>");
		_htm.push("</div></div>")
		
		//添加到parent body 中
		window.parent.$("body").append(_htm.join(""));
		
		//处理window-间距
		var wbox = window.parent.$("#"+dialogId).find(".window_box");
		try{
			var _winWidth = $(window.parent).width();
			wbox.css("left",((_winWidth-wbox.width())/2)+"px");
			wbox.css("margin-left","0px");
		}catch(e){
			console.log("dialog error"+e);
		}
		
		
		window.parent.$("#"+dialogId).show();
		return dialogId;
	},
	/**
	 * 关闭单个dialog
	 * @param dialogId
	 */
	close:function(dialogId){
		window.parent.$("#"+dialogId).remove();
	},
	/**
	 * 关闭所有
	 */
	closeAll:function(){
		window.parent.$("._dialog_fw").remove();
	},
	/**
	 * 获取当前显示的iframe
	 */
	getCurrentIFrameBody:function(){
		var iframes = $(window.top.document.body).find("#frameList iframe");
		var ifr = null;
		for(var i=0,len=iframes.length;i<len;i++){
			ifr = iframes[i];
			var $ifr = $(ifr);
			if($ifr.css("display")!="none"){
				break;
			}
		}
		if(ifr){
			return $(ifr.contentWindow.document.body);
		}
		return null;
	}
};