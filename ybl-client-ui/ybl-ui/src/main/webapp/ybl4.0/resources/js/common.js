$(function(){
	$('.hksm').hover(function(){
		$('.hktoggle').toggle();
	})
	
	$('.navlist').click(function(){
		$('.navlist').removeClass('nav_cur');
		$(this).addClass('nav_cur');
	})
	
	$('.nav_scroll').click(function(){
		var $height = $('.successtitle').offset().top;
		$('body,html').animate({scrollTop:$height},500)
	})
})
