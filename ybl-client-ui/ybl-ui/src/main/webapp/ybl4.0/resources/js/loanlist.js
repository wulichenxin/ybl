function select(no){
	var $money=$(".conditionList dd[name='money']").find("span[class='active']").attr("value");
	var $deadline=$(".conditionList dd[name='deadline']").find("span[class='active']").attr("value");
	var $type=$(".conditionList dd[name='type']").find("span[class='active']").attr("value");
	var $rank=$(".conditionList dd[name='rank']").find("span[class='active']").attr("value");
	var $loanType=$(".conditionList dd[name='loanType']").find("span[class='active']").attr("value");
	var $yearRate = $(".conditionList dd[name='yearRate']").find("span[class='active']").attr("value");
	$.ajax({
		type:'post',
		data:{money:$money,month:$deadline,type:$type,rank:$rank,loanType:$loanType,no:no,yearRate:$yearRate},
		url:'loaninfo/loanList.htm',
		success:function(msg){
			$(".jiekuanList").html(msg);
		}
	});
}
$(function($){
	select(1);
	/*$.ajax({
		type:'post',
		data:'no='+1,
		url:'loaninfo/loanList.htm',
		success:function(msg){
			$(".jiekuanList").html(msg);
		}
	});*/
	$(".conditionList dd span").click(function(){
		select(1);
	});
});

function jumpPage(pageno,totalPage){
	if(pageno<=0 || pageno>totalPage){
		return;
	}
	select(pageno);
}
