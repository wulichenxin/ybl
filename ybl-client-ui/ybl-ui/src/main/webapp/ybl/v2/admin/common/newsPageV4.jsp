<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
var _totalRows = ${page.recordCount};
var _pageSize = ${page.pageSize};
var _pageNumber = ${page.currentPage};
var _totalPageCount = parseInt(_totalRows/_pageSize);
if(_totalRows%_pageSize!=0){
	_totalPageCount++;
}
function $GrxPage(){
	var pageForm = $("#newPageForm");
	if(pageForm.length==0){
		alert("必须指定表单form id = newPageForm --- 来源  newsPage.jsp");
		return;
	}
	var ha = [];
	if(_pageNumber==0){
		_pageNumber = 1;
	}	
	ha.push('<div class="v2_pages2">')
	ha.push('<div class="v2_pages_l">共'+_totalRows+'条记录,');
	ha.push('每页显示<select name="pageSize"  onchange="goNewsPage(1)"><option value="10">10</option><option value="20">20</option><option value="30">30</option><option value="40">40</option></select>条</div>');
	ha.push('<div class="v2_pages_r">');
	ha.push('<ul>');	
    ha.push('<li><a onclick="goNewsPage(1)">首页</a></li>');
    ha.push('<li><a onclick="goNewsPage('+(_pageNumber -1)+')"><</a></li>');
	if(_totalPageCount<=10){
		for(var i=1;i<=_totalPageCount;i++){
			if(_pageNumber==i){
				ha.push('<li><a class="now">'+i+'</a></li>')
			}else{
				ha.push('<li><a onclick="goNewsPage('+i+')">'+i+'</a></li>')				
			}
		}
	}
	else //大于10页的显示
	{
		var start = 0;//开始页
		var end = 0;  //结束页
		
		//只显示前面10页
		if(_pageNumber <= 6 ){ 
			for(var i=1;i<=10;i++){
				if(_pageNumber==i){
					ha.push('<li><a class="cur now">'+i+'</a></li>')
				}else{
					ha.push('<li><a onclick="goNewsPage('+i+')">'+i+'</a></li>')				
				}
			}
		}
		
		//显示第1页，...，以及最后面9页
		else if(_pageNumber + 4 > _totalPageCount){
			//1 显示第1页
			ha.push('<li><a onclick="goNewsPage(1)">'+1+'</a></li>')				
			//2 显示 ...
			ha.push('<li><span>...</span></li>')
			start = _totalPageCount - 8;
			for(;start <= _totalPageCount;start++){
				if(_pageNumber==start){
					ha.push('<li><a class="cur now">'+start+'</a></li>')
				}else{
					ha.push('<li><a onclick="goNewsPage('+start+')">'+start+'</a></li>')				
				}
			}
		}
		//显示中间页
		else{
			//1 显示第1页
			ha.push('<li><a onclick="goNewsPage(1)">'+1+'</a></li>')				
			//2 显示 ...
			ha.push('<li><span>...</span></li>')
			
			//3.1 以当前页为准，往前面拿4个页面
			start = _pageNumber - 4;
			for(;start<_pageNumber;start++){
				ha.push('<li><a onclick="goNewsPage('+start+')">'+start+'</a></li>')
			}
			
			//3.2 显示当前页
			ha.push('<li><a class="cur now">'+_pageNumber+'</a></li>');
			
			//3.3 以当前页为准，往后面拿4页
			start = _pageNumber + 1;
			end = _pageNumber + 4;
			for( ; start <= end ; start ++){
				ha.push('<li><a onclick="goNewsPage('+start+')">'+start+'</a></li>');
			}
			
		}
	}	
	
    ha.push('<li><a onclick="goNewsPage('+(_pageNumber+1)+')">></a></li>');
    ha.push('<li><a onclick="goNewsPage('+_totalPageCount+')">尾页</a></li>');_totalPageCount
	ha.push('</ul>');
	ha.push('</div>');
	ha.push('</div>');
	$("#_commonPage").html(ha.join(""));
	$("select[name='pageSize']").val(_pageSize);
		
}

$(function(){
	var pageForm = $("#newPageForm");
	if(pageForm.length==0){
		alert("必须指定表单form id = pageForm --- 来源  page.jsp");
		return;
	}
	$GrxPage();
	
	//处理表单行样式
	var pageTable = $("#newPageForm #tb");
	var rows = pageTable.find("tr");
	var rowlen = rows&&rows.length;
	if(rowlen>1){//第一行忽略
		for(var i=1;i<rowlen;i++){
			var row = $(rows[i]);
			if(i%2==1){
				row.addClass("bg_l");
			}else{
				row.removeClass("bg_l");
			}
		}
	}
	
});
function goNewsPage(pageNumber){
	if(pageNumber>=_totalPageCount){
		pageNumber=_totalPageCount;
	}
	if(pageNumber<=1){
		pageNumber=1;
	}
	$('#pageNumber').val(pageNumber);
	console.log($("input[name='currentPage']").val());
	var pageSize = $("select[name='pageSize']").val();
	$('#pageSize').val(pageSize);
	$.ajax({
		url      : "/gatewayController/loadnewsListByAsync?currentPage=" + pageNumber + "&pageSize=" + pageSize,
		dataType : "html",
		success  : function(data){
			$("#newPageForm").html(data);
		}
	})
}
</script>
<input type="hidden" id="pageNumber" name="currentPage" value="1" />
<input type="hidden" id="pageSize" name="pageSize" value="10"/>
 <div class="pageBox clearfix" id="_commonPage">
 
 </div>