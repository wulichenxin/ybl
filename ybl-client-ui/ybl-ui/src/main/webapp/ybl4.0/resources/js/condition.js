// JavaScript Document
/* 筛选条件Js */

$(function(){//开始
	$(".conditionList li dl dd span").click(function(){
			$(this).siblings().removeClass("active");
			$(this).addClass("active");
			//alert("您选择的值所属类型："+$(this).parent("dd").attr("name")+",您选择的值："+$(this).attr("value"));
			});	
	$(".vipContBox table a").click(function(){
		$(this).siblings().removeClass("QueriesLink");
		$(this).addClass("QueriesLink");
	});
});//结束