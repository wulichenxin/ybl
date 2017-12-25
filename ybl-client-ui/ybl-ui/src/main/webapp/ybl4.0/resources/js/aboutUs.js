$(function() {
	
	var typevalue = $("#typevalue").val();
	if(typevalue == "choose"){ //人默认点击新闻资讯
		loadchoose();
	}else if(typevalue == "pay"){ //默认点击平台公告
		loadpay();
	}else if(typevalue == "ship"){   //默认点击人才招聘
		loadship();
	}
	
	var i = 0;
	$('.choose').click(function() {
		$.ajax({
        	url : "/gatewayController/companyIntroduction",
        	dataType     : "html",
        	success      :  function(data){
        		$("#right-side").html(data);
        	}
     });
	$("#titleChange").html("公司简介");
	$('#first').addClass('active');
	$('#second').removeClass('active');
	$('#third').removeClass('active');
	$('#fourth').removeClass('active');
	$('.pore').height(880);
		$('.choose').addClass('active');
		$('.choose > .icon').addClass('active');
		$('.pay').removeClass('active');
		$('.wrap').removeClass('active');
		$('.ship').removeClass('active');
		$('.pay > .icon').removeClass('active');
		$('.wrap > .icon').removeClass('active');
		$('.ship > .icon').removeClass('active');
		$('#line').addClass('one');
		$('#line').removeClass('two');
		$('#line').removeClass('three');
		$('#line').removeClass('four');
	});
	$('.pay').click(function() {
		 $.ajax({
	        	url : "/gatewayController/news?currentPage=1&pageSize=10",
	        	dataType     : "html",
	        	async: false,
	        	success      :  function(data){
	        		$("#right-side").html(data);
	        		i = $('.newslist').length;
	        	}
	        });
		 $("#titleChange").html("新闻资讯");
		$('#first').removeClass('active');
		$('#second').addClass('active');
		$('#third').removeClass('active');
		$('#fourth').removeClass('active');
		if(i>0){
			$('.pore').height(i*155+200+'px');
		}else{
			$('.pore').height(620);
		}
		$('.pay').addClass('active');
		$('.pay > .icon').addClass('active');
		$('.choose').removeClass('active');
		$('.wrap').removeClass('active');
		$('.ship').removeClass('active');
		$('.choose > .icon').removeClass('active');
		$('.wrap > .icon').removeClass('active');
		$('.ship > .icon').removeClass('active');
		$('#line').addClass('two');
		$('#line').removeClass('one');
		$('#line').removeClass('three');
		$('#line').removeClass('four');
	});
	$('.wrap').click(function() {

		$.ajax({
	        	url : "/gatewayController/notices?currentPage=1&pageSize=10",
	        	dataType     : "html",
	        	success      :  function(data){
	        		$("#right-side").html(data);
	        	}
	        });
		$("#titleChange").html("平台公告");
		$('#first').removeClass('active');
		$('#second').removeClass('active');
		$('#third').addClass('active');
		$('#fourth').removeClass('active');
		$('.pore').height(620);
		$('.wrap').addClass('active');
		$('.wrap > .icon').addClass('active');
		$('.pay').removeClass('active');
		$('.choose').removeClass('active');
		$('.ship').removeClass('active');
		$('.pay > .icon').removeClass('active');
		$('.choose > .icon').removeClass('active');
		$('.ship > .icon').removeClass('active');
		$('#line').addClass('three');
		$('#line').removeClass('two');
		$('#line').removeClass('one');
		$('#line').removeClass('four');
	});
	$('.ship').click(function() {
		 $.ajax({
	        	url : "/gatewayController/recruitment",
	        	dataType     : "html",
	        	success      :  function(data){
	        		$("#right-side").html(data);
	        	}
	        });
		 $("#titleChange").html("人才招聘");
		$('#first').removeClass('active');
		$('#second').removeClass('active');
		$('#third').removeClass('active');
		$('#fourth').addClass('active');
		$('.pore').height(600);
		$('.ship').addClass('active');
		$('.ship > .icon').addClass('active');
		$('.pay').removeClass('active');
		$('.wrap').removeClass('active');
		$('.choose').removeClass('active');
		$('.pay > .icon').removeClass('active');
		$('.wrap > .icon').removeClass('active');
		$('.choose > .icon').removeClass('active');
		$('#line').addClass('four');
		$('#line').removeClass('two');
		$('#line').removeClass('three');
		$('#line').removeClass('one');
	});
	$('.login-btn').hover(function() {
		$('.login-btn').removeClass('btn-cur');
		$(this).toggleClass('btn-cur')
	})

	$('.read').click(function(){
		$(this).next('ul').toggle(200).parent().siblings().find('ul').hide(200)
	})
})

function loadchoose(){
	$.ajax({
    	url : "/gatewayController/companyIntroduction",
    	dataType     : "html",
    	success      :  function(data){
    		$("#right-side").html(data);
    	}
	});
	$("#titleChange").html("公司简介");
	$('#first').addClass('active');
	$('#second').removeClass('active');
	$('#third').removeClass('active');
	$('#fourth').removeClass('active');
	$('.pore').height(880);
	$('.choose').addClass('active');
	$('.choose > .icon').addClass('active');
	$('.pay').removeClass('active');
	$('.wrap').removeClass('active');
	$('.ship').removeClass('active');
	$('.pay > .icon').removeClass('active');
	$('.wrap > .icon').removeClass('active');
	$('.ship > .icon').removeClass('active');
	$('#line').addClass('one');
	$('#line').removeClass('two');
	$('#line').removeClass('three');
	$('#line').removeClass('four');
}

function loadpay(){
	 $.ajax({
     	url : "/gatewayController/news?currentPage=1&pageSize=10",
     	dataType     : "html",
     	async: false,
     	success      :  function(data){
     		$("#right-side").html(data);
     		i = $('.newslist').length;
     	}
     });
	 $("#titleChange").html("新闻资讯");
	$('#first').removeClass('active');
	$('#second').addClass('active');
	$('#third').removeClass('active');
	$('#fourth').removeClass('active');

	$('.pore').height(i*155+200+'px');
	$('.pay').addClass('active');
	$('.pay > .icon').addClass('active');
	$('.choose').removeClass('active');
	$('.wrap').removeClass('active');
	$('.ship').removeClass('active');
	$('.choose > .icon').removeClass('active');
	$('.wrap > .icon').removeClass('active');
	$('.ship > .icon').removeClass('active');
	$('#line').addClass('two');
	$('#line').removeClass('one');
	$('#line').removeClass('three');
	$('#line').removeClass('four');
}

function loadship(){
	 $.ajax({
     	url : "/gatewayController/recruitment",
     	dataType     : "html",
     	success      :  function(data){
     		$("#right-side").html(data);
     	}
     });
	 $("#titleChange").html("人才招聘");
	$('#first').removeClass('active');
	$('#second').removeClass('active');
	$('#third').removeClass('active');
	$('#fourth').addClass('active');
	$('.pore').height(600);
	$('.ship').addClass('active');
	$('.ship > .icon').addClass('active');
	$('.pay').removeClass('active');
	$('.wrap').removeClass('active');
	$('.choose').removeClass('active');
	$('.pay > .icon').removeClass('active');
	$('.wrap > .icon').removeClass('active');
	$('.choose > .icon').removeClass('active');
	$('#line').addClass('four');
	$('#line').removeClass('two');
	$('#line').removeClass('three');
	$('#line').removeClass('one');
}