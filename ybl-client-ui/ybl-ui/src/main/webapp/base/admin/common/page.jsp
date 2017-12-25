<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
var _totalRows = ${page.totalRows};
var _pageSize = ${page.pageParam.pageSize};
var _pageNumber = ${page.pageParam.pageNumber};
var _sortName = '${page.pageParam.sortName}';
var _sortOrder = '${page.pageParam.sortOrder}';
var _totalPageCount = parseInt(_totalRows/_pageSize);
if(_totalRows%_pageSize!=0){
	_totalPageCount++;
}
function $GrxPage(){
	var pageForm = $("#pageForm");
	if(pageForm.length==0){
		alert("必须指定表单form id = pageForm --- 来源  page.jsp");
		return;
	}
	var ha = [];
	if(_pageNumber==0){
		_pageNumber = 1;
	}
	ha.push('<div class="pages_l">共'+_totalRows+'条记录,');
	ha.push('每页显示<select name="pageSize" onchange="goPage(1)"><option value="10">10</option><option value="20">20</option><option value="50">50</option></select>条</div>');
	ha.push('<div class="pages_r">');
	ha.push('<ul>');
	ha.push('<li><a class="now" onclick="goPage('+(_pageNumber-1)+')" >上一页</a></li>');
    ha.push('<li><a onclick="goPage(1)">首页</a></li>');
	if(_totalPageCount<10){
		for(var i=1;i<=_totalPageCount;i++){
			if(_pageNumber==i){
				ha.push('<li><a style="border:0px;cursor:default;background: #ffba00;color:#fff;">'+i+'</a></li>')
			}else{
				ha.push('<li><a onclick="goPage('+i+')">'+i+'</a></li>')				
			}
		}
	}else{
	}
	ha.push('<li><a onclick="goPage('+_totalPageCount+')">尾页</a></li>');
    ha.push('<li><a onclick="goPage('+(_pageNumber+1)+')" class="now">下一页</a></li>');
	ha.push('</ul>');
	ha.push('</div>');
	$("#_commonPage").html(ha.join(""));
	$("select[name='pageSize']").val(_pageSize);
		
}

$(function(){
	var pageForm = $("#pageForm");
	if(pageForm.length==0){
		alert("必须指定表单form id = pageForm --- 来源  page.jsp");
		return;
	}
	$GrxPage();
	
	//处理表单行样式
	var pageTable = $("#pageForm #tb");
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
function goPage(pageNumber){
	if(pageNumber>=_totalPageCount){
		pageNumber=_totalPageCount;
	}if(pageNumber<=1){
		pageNumber=1;
	}
	$('#pageNumber').val(pageNumber);
	$('#pageForm').submit();  
}
</script>
<input type="hidden" id="pageNumber" name="pageNumber" value="${page.pageParam.pageNumber}">
 <div class="pages" id="_commonPage">
 
 </div>