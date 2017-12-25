$(function(){
	
	function ajaxLoadMenu(){
		if($("#head-menu-ul").length==0){
			return;
		}
		$.ajax({
			//url:"/menuController/queryAccessMenu",
			url:"/permissionController/selectMenuByUser",
			success:function(data){
				
				var $menuUL = $("#head-menu-ul");
				var len = data&&data.length;
				if(len){
					var htmlArray = [];
					
					htmlArray.push("<li><div class=\"navmenu\"><a id='head-home'><span>首页<b></b></span></a></li>");
					
					for(var i=0;i<len;i++){
						var top = data[i];
						if(!top.parentId||top.parentId==""||top.parentId==0){//parentId为空
							htmlArray.push("<li>");
							htmlArray.push("<div class=\"navmenu\"><a><span>"+top.menuName+"<b></b></span></a>");
							htmlArray.push("<div class=\"navmenu-list none\">");
							htmlArray.push("<ul>");
							for(var j=0;j<len;j++){
								var child = data[j];
								if(child.parentId==top.id){
									htmlArray.push("<li><a onclick=\"openFramePage("+child.id+",'"+child.menuName+"','"+child.url+"')\" >"+child.menuName+"</a></li>");
								}
							}
							htmlArray.push("</ul>");
							htmlArray.push("</div>");
							htmlArray.push("</li>");
						}
					}
					$menuUL.html(htmlArray.join(""));
					$("#head-home").click(function(){
						$("#homePage").click();
					})
				}
				
				/*BGIN我的菜单*/
				$('.navmenu').mouseover(function(){
					$(this).find('.navmenu-list').show();
				}).mouseleave(function(){
					$(this).find('.navmenu-list').hide();
				});
				/*END我的菜单*/
			},
			error:function(a,b,c){
				console.log("-----菜单加载失败");
			}
		});
	}
	
	//加载菜单
	ajaxLoadMenu();
	
	var registerNewsEvent = function(){
		if($("ul.scroll_ul").length==0){
			return;
		}
		var scroll_area=$("ul.scroll_ul");    
		var timespan=2000;    
		var timeID;    
		scroll_area.hover(function(){            
			clearInterval(timeID);       
		},function(){        
			timeID=setInterval(function(){            
				var moveline=scroll_area.find('li:first');            
				var lineheight=moveline.height();            
				moveline.animate({marginTop:-lineheight+'px'},500,function(){                
					moveline.css('marginTop',0).appendTo(scroll_area);                
				});            
			},timespan);        
		}).trigger('mouseleave');
	};
	
	registerNewsEvent();
	
	$("#b-close-all").click(function(){
		MenuTab.closeAll();
	});
	
});

function resizeIndexIFrame(ifm){
	//重置iframe
    if(ifm != null ){
    	$(ifm).css("height",$(ifm.contentDocument.body).height()+100);
    }
    var ww = $(window).width();
    var iw = $(ifm).width();
    if(ww>iw){
    	$(ifm).css("margin-left",(ww-iw)/2);
    }
}

function openFramePage(id,title,url){
	var ftTab = $("#ftMenuTab");
	var $li = ftTab.find("li");
	if($li.length == 6) {// 这里判断需要包含“首页”，提示的时候除掉“首页”
		alert("打开页签不能超过5个，请先关闭历史页签。");
		return;
	}
	var findObj = ftTab.find("li[mid="+id+"]");
	if(findObj.length==1){	//已存在,直接打开
		MenuTab.show(id);
	}else{
		MenuTab.add(id,title,url);
	}
}

var MenuTab = {
	add:function(id,title,url){
		//添加menuTab
		$("#ftMenuTab").append(MenuTab.generateTab(id,title,url));
		//添加iframe
		$("#frameList").append(MenuTab.generateFrame(id,title,url));
		//高亮menuTab
		MenuTab.show(id);
	},
	show:function(id){
		//修改当前选中li样式为未选中
		var now = $("#ftMenuTab .now").removeClass("now").parent().find(".close_ico1").removeClass("close_ico1").addClass("close_ico");
		//将点击的tab置为选中状态
		$("#ftMenuTab li[mid="+id+"] a").addClass("now").parent().find(".close_ico").removeClass("close_ico").addClass("close_ico1");
		//隐藏所有iframe
		$("#frameList iframe").hide();
		//显示当前选中iframe
		$("#indexFrame"+id).show();
	},
	close:function(id){
		//删除menuTab
		$("#ftMenuTab li[mid="+id+"]").remove();
		//删除iframe
		$("#indexFrame"+id).remove();
		// 显示首页默认的界面
		$("#homePage").click();
	},
	closeAll:function(){
		$("#ftMenuTab li").each(function(){
			var o = $(this);
			if(o.find("a.jtr_ico").length==0){
				//删除iframe
				$("#indexFrame"+o.attr("mid")).remove();
				//删除menutab
				o.remove();
			}
		});
		// 显示首页默认的界面
		$("#homePage").click();
	},
	generateTab:function(id,title,url){
		var hs = '<li mid="'+id+'" url="'+url+'"><a  onclick="MenuTab.show('+id+')" class="now">'+title+'</a><b  onclick="MenuTab.close('+id+')" class="close_ico1"></b></li>';
		return hs;
	},
	generateFrame:function(id,title,url){
		var hs = '<iframe onload="resizeIndexIFrame(this)" style="margin-top: 0px;" class="cont" id="indexFrame'+id+'" name="indexFrame" frameborder="0" src="'+url+'"></iframe>';
		return hs;
	}
};


