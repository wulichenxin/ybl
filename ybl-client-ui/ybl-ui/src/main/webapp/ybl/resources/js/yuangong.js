// JavaScript Document
$(document).ready(function() {
	/* ABGIN我的菜单 */
	$('.navmenu').mouseover(function() {
		var listObj = $(this).find('.navmenu-list');
		if(listObj.css("display") == "none") {
			listObj.slideDown();
		}
	
	}).mouseleave(function() {
		$(this).find('.navmenu-list').slideUp();
	});
	/* END我的菜单 */

});
/* 新闻 */
$(function() {
	var scroll_area = $("ul.scroll_ul");
	var timespan = 2000;
	var timeID;
	scroll_area.hover(function() {
		clearInterval(timeID);
	}, function() {
		timeID = setInterval(function() {
			var moveline = scroll_area.find('li:first');
			var lineheight = moveline.height();
			moveline.animate({
				marginTop : -lineheight + 'px'
			}, 500, function() {
				moveline.css('marginTop', 0).appendTo(scroll_area);
			});
		}, timespan);
	}).trigger('mouseleave');
});

/* 表格 */
var obj = document.getElementById("tb");
if(obj && obj.rows!=null){
	for (var i = 0; i < obj.rows.length; i++) {
		obj.rows[i].onmouseover = function() {
			this.style.background = "#fdf2d3";
		}
		obj.rows[i].onmouseout = function() {
			this.style.background = "";
		}
	}
}

/* 表格 */
var obj = document.getElementById("tb1");
if(obj && obj.rows!=null){
	for (var i = 0; i < obj.rows.length; i++) {
		obj.rows[i].onmouseover = function() {
			this.style.background = "#fdf2d3";
		}
		obj.rows[i].onmouseout = function() {
			this.style.background = "";
		}
	}
}

/* 表格 */
var obj = document.getElementById("tb2");
if(obj && obj.rows!=null){
	for (var i = 0; i < obj.rows.length; i++) {
		obj.rows[i].onmouseover = function() {
			this.style.background = "#fdf2d3";
		}
		obj.rows[i].onmouseout = function() {
			this.style.background = "";
		}
	}
}

function hideform() {

	if ($('#submit_box').height() == 76) {
		$('#submit_box').height(25).find('.sswitch').css({
			'background-position' : '-26px 0px'
		});
	} else {
		$('#submit_box').height(76).find('.sswitch').css({
			'background-position' : '0px 0px'
		});
	}
}