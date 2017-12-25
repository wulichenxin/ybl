$(function(){
	$('.formli').on('click',function(){
		var index = $(this).index()+1;
		ClickShow('.box','.box'+index);
		$('.formli').removeClass('form_cur');
		$(this).addClass('form_cur');
	})
	
	$('.prolist').on('click',function(){
		$('.prolist').removeClass('pro_cur');
		$(this).addClass('pro_cur');
		var index = $(this).index()+1;
		ClickShow('.chebox','.chebox'+index);
		
	})
	
	$('.iconlist').click(function(){
		if($(this).attr('url') !=null && $(this).attr('url') !="" && $(this).attr('url') != "#"){
		$('.iconlist').removeClass('pro_li_cur');
		$(this).addClass('pro_li_cur');
		
		$('#iframe1').attr('src',$(this).attr('url'))
		}
	})
	
	
	$('.yhkje').hover(function(e){
		$('.jeout').css("top",$(".yhkje").offset().top+20);
		$('.jeout').css("left",$(".yhkje").offset().left+25);
		$('.jeout').toggle();
	})
	
	$('.mylist').click(function(){
		var $url = $(this).find('a').attr('url');
		$('#iframe1').attr('src',$url);
		$(".mylist").find('a').css('color','#333');
        $(this).find('a').css('color','#D5B46B');
	})

	
	$('.rzlist').click(function(){
		var $url = $(this).attr('url');
		$('#iframe1').attr('src',$url);
		$(".rzlist").find('a').css('color','#333');
        $(this).find('a').css('color','#D5B46B');
	})
	
	$('.rz-link').click(function(){
		$('.outbox').show();
	})
	$('.close-out').click(function(){
		$('.outbox').hide();
	})
	
	$('.linkid').click(function(){
		var index = $(this).attr('data-linkid');
		ClickShow('.modify','.modify'+index);
		$('.rzbox').hide();
		$('.myAccount').hide();
	})
	
	$('.userpsdimg').click(function(){
		if($(this).attr('src') == '/ybl4.0/resources/images/login/closeEye_icon.png'){
			$(this).attr('src','/ybl4.0/resources/images/login/closeEye_icon.png');
			$('.pwd').prop('type','text');
		}
		else{
			$(this).attr('src','/ybl4.0/resources/images/login/closeEye_icon.png');
			$('.pwd').prop('type','password');
		}
	})
	
	$('.mymessage').click(function(){
		var ifr = window.parent.document.getElementById("iframe1");
		$(ifr).attr('src',$(this).attr('url'))
	})
	
/*	$('.add-img').click(function(){
		
		$(this).parents('table').append($(this).parent().parent().clone())
	})*/
	
	$(document).on('click','.sp-delete',function(){
		$(this).parents('tr').remove()
	})
	$('.historysp').click(function(){
		$(this).parents('.operating').find('.hidebox').toggle();
//		if($(this).parents('.operating').find('.hidebox').is(':visited')){
//			alert(8)
//			debugger
//			$(this).find('img').attr('src','images/my/up_sele_icon.png');
//		}
//		else{
//			alert(9)
//			debugger
//			$(this).find('img').attr('src','images/my/down_sele_icon.png');
//		}
	})
	
	$('.sele').change(function(){
		var $val = $(this).find('option:selected').attr('value');
		ClickShow('.togglebox','.togglebox'+$val);
	})
	
	$('.yjfz').click(function(){
		outbox('500','300');
	})
	
//	$('.nextbtn1').click(function(){
//		$('.foundpwd').hide();
//		$('.foundpwd2').show();
//	})
//	
//	$('.nextbtn2').click(function(){
//		$('.foundpwd').hide();
//		$('.foundpwd3').show();
//	})
	
	function countdown(){
		var i = $('.countdown').html();
		i = parseInt(i);
		$('.countdown').html(i-1);
		if($('.countdown').html()<1){
			clearInterval(cc);
			window.location.href = 'http://www.baidu.com'
		}

	}
	var cc = setInterval(countdown,1000);
	function ClickShow(item1,item2){
		$(item1).hide();
		$(item2).show();
	}
	
	
	function outbox(width,height){
		$('.outbox').show();
		var mt = '-0.5'*height;
		var ml = '-0.5'*width;
		$('.outbox').css({'height':height+'px','width':width+'px','margin-top':mt+'px','margin-left':ml+'px'})
	}

	window.close = function(item) {
			var clo = window.parent.document.getElementsByClassName(item);
			$(clo).click(function() {
			dialog.close();
		})
	}
	
	
})

function httpPost(URL, PARAMS) {
    var temp = document.createElement("form");
    temp.action = URL;
    temp.method = "post";
    temp.style.display = "none";

    for (var x in PARAMS) {
        var opt = document.createElement("textarea");
        opt.name = x;
        opt.value = PARAMS[x];
        temp.appendChild(opt);
    }

    document.body.appendChild(temp);
    temp.submit();

    return temp;
}

//待提交的form表单数据
/*
* {
*	formDate:{
*		name:"",
*		age:"",
*		cardId:""
*		...
*	
*	},		提交数据
*	formAttrbute:{
*		action:action,		提交url
*		method:method 		post 或者 get(默认post)
*		..
*		..
*		..
*	}
*}
*/

$.createFormAndSubmit = function (date){
		var formTemplate = $("<form></form>");
		 $.each(date.formDate,function(name,value) {
			var input = $("<input type='hidden'/>");
			input.attr('name',name);
			input.attr('value',value);;
			formTemplate.append(input);
        });
		var formAttrbute = date.formAttrbute;
		if(formAttrbute.action == null){
			console.log('表单action:',formAttrbute.action);
			return false;
		}
		if(formAttrbute.method == "" || formAttrbute.method == null){
			formAttrbute.method="POST";
		}
		$.each(formAttrbute, function(name,value){
			formTemplate.attr(''+name,value);
		});
		formTemplate.css('display','none')
		formTemplate.appendTo("body");
        formTemplate.submit()
		return formTemplate
}

function resizeIndexIFrame(ifm){
	//重置iframe
    if(ifm != null ){
    	$(ifm).css("height",$(ifm.contentDocument.body).height()+200);
    }
}
function resizeIndexIFrame2(ifm){
	//重置iframe
    if(ifm != null ){
    	$(ifm).css("height",$(ifm.contentDocument.body).height()+400);
    }
}


/**
 * 格式化数字,满三位加逗号
 * @param num
 * @returns
 */
function toThousandNum(num) {
	var nums = new Array();
	nums = (num || 0).toString().split(".");
	var formatNum = nums[0], result = '';  
    while (formatNum.length > 3) {  
        result = ',' + formatNum.slice(-3) + result;  
        formatNum = formatNum.slice(0, formatNum.length - 3);  
    }  
    if (formatNum) {
    	result = formatNum + result; 
    }  
    if (nums.length > 1) {
    	result = result + "." + nums[1];
    }
    return result; 
}
