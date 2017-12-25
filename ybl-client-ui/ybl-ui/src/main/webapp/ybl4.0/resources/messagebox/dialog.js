

/**
 * 国融信dialog组件
 */
var i;
var dialog = {
	/**
	 * 弹窗-打开一个页面,返回一个dialogId,用于关闭时用到
	 * @param url  --必填项目
	 * @param width	--默认值800px
	 * @param height --默认值600px
	 * @param dialogId --指定dialogId,如果不指定,则返回默认生成的id
	 * return dialogId
	 */
	open:function(url,width,height,dialogId,title){
		window.parent.$('.window_box').remove();
		if(!url){
			alert("ERROR dialog.open(args  url 不能为空")
			return;
		}
		width = width||"100%";
		height = height||"100%";
		var ml = width.split('p')[0]*'-0.5';
		var mt = height.split('p')[0]*'-0.5'-40;
		dialogId = dialogId||"dialog_"+Date.now();
		var styleWidth = null; 
		if(Math.round(width.replace("px",""))){
			styleWidth = "width:"+width;
		}
		var _htm = [];
//		_htm.push("<div id='"+dialogId+"' class='_dialog_fw' style='display:none;'><div class='t_window'></div>");
		
		if(styleWidth){
			_htm.push("<div class='window_box' id='asd' style='"+styleWidth+";margin-left:"+ml+"px;margin-top:"+mt+"px'><p class='outtitle'>"+title+"<span class='outClose'></span></p>");
		}else{
			_htm.push("<div class='window_box' id='asd'>");
		}
		_htm.push("<iframe src='"+url+"' width='"+width+"' height='"+height+"'></iframe>");
		_htm.push("</div>")
		
		//添加到parent body 中
		window.parent.$("body").append(_htm.join(""));
		function move(){
			var cc = window.parent.document.getElementById('asd');
			cc.onmousedown = function(e){
				var x = e.clientX - cc.offsetLeft;
				var y = e.clientY - cc.offsetTop;
				cc.onmousemove = function(e){
					var nx = e.clientX - x;
					var ny = e.clientY - y;
					cc.style.cursor = 'move';
					cc.style.left = nx+'px';
					cc.style.top = ny+'px';
					cc.style.marginLeft = 0;
					cc.style.marginTop = 0;
				}
				cc.onmouseup = function(){
					cc.style.cursor = 'default';
					cc.onmousemove = null;
				}
			}
		}
		move();
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
		window.parent.$('.window_box').remove();
		i=1;
	},
	close2:function(dialogId){
		window.parent.$('.window_box1').remove();
		i=1;
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
	},
	getIframeBodyById:function(id){
		var ifo = $(window.top.document.body).find("#"+id);
		if(ifo){
			var ifr = ifo.find("iframe")[0];
			return $(ifr.contentWindow.document.body);
		}
		return null;
	},
	open2:function(url,width,height,dialogId,title){
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
//		_htm.push("<div id='"+dialogId+"' class='_dialog_fw' style='display:none;'><div class='t_window'></div>");
		
		if(styleWidth){
			_htm.push("<div class='window_box window_box1' id='asd' style='"+styleWidth+"'><p class='outtitle'>"+title+"<span class='outClose outClose1'></span></p>");
		}else{
			_htm.push("<div class='window_box window_box1' id='asd'>");
		}
		_htm.push("<iframe src='"+url+"' width='"+width+"' height='"+height+"'></iframe>");
		_htm.push("</div>")
		
		//添加到parent body 中
		window.parent.$("body").append(_htm.join(""));
		function move(){
			var cc = window.parent.document.getElementById('asd');
			cc.onmousedown = function(e){
				var x = e.clientX - cc.offsetLeft;
				var y = e.clientY - cc.offsetTop;
				cc.onmousemove = function(e){
					var nx = e.clientX - x;
					var ny = e.clientY - y;
					cc.style.cursor = 'move';
					cc.style.left = nx+'px';
					cc.style.top = ny+'px';
					cc.style.marginLeft = 0;
					cc.style.marginTop = 0;
				}
				cc.onmouseup = function(){
					cc.style.cursor = 'default';
					cc.onmousemove = null;
				}
			}
		}
		move();
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
	}
	
	
};