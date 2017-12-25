// JavaScript Document
//animate
$(function(){
	$('#dowebok').fullpage({
		 loopBottom: false,
		 'navigation': true,
		 /*anchors: [ 'hero','services', 'cases', 'news','about','contact','think','footer'],*/
		afterLoad: function(anchorLink, index){
			if(index == 1){
				$('header').stop().animate({top:"0px"},700);
				$('.gb-nav').stop().animate({top:"-100%"},700);
			     var an =window.screen.width; 
			     if(an < 1150 ){  
				   $('header').stop().animate({top:"-100%"},700);	
			       $('.gb-nav').stop().animate({top:"0%"},700);  
				  }
			}
			if(index == 2){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 3){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 4){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			if(index == 5){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(0,0,0)','-webkit-transform':'translate3d(0,0,0)','opacity':'1'});
			}
			
		},
		onLeave: function(index, direction){
			if(index == '1'){
				 var an =window.screen.width; 
			     if(an < 1150 ){  
				   $('header').stop().animate({top:"-100%"},700);	
			       $('.gb-nav').stop().animate({top:"0%"},700);  
				  }
			}
			if(index == '2'){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '3'){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '4'){
			   $('.cont .sub-nei-ct2').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			if(index == '5'){
			   $('.cont .sub-nei-ct3').css({'transform':'translate3d(200px,0,0)','-webkit-transform':'translate3d(200px,0,0)','opacity':'0'});	
			}
			
			
		}
	});
    setInterval(function(){
        $.fn.fullpage.moveSlideRight();
    }, 18000)	
   $(function(){
	  $('.slide video').get(0).play();
	  /*_slideAutoChange = setInterval("$.slideAutoChange()",18000);*/
	})	
});
