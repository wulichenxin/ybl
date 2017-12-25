<%@page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<html>

<head>
<meta charset="UTF-8">
<title>选择资金方</title>

</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>

	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span
				class="mr10 ml10">-</span>选择资金方
		</div>
	</div>

	<div class="w1200 ybl-info">
		<form id="pageForm" action="/chooseFundsController/chooseFundsList"
			method="post">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label>融资订单号：</label><input class="content-form"
						name="financing_order_number"
						value="${parm.financing_order_number}" />
				</div>
				<div class="form-grou">
					<label>申请时间：</label><input name="begin_date"
						value="${parm.begin_date}" id="beginDate" class="content-form" /><img
						class="timeimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40">
					<input name="end_date" value="${parm.end_date}" id="endDate"
						class="content-form" /><img class="timeimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label>保理类型：</label><select name="factoring_mode"class="content-form"><option
							<c:if test="${empty parm.factoring_mode}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${parm.factoring_mode eq 1}">selected="selected"</c:if>
							value="1">明保理</option>
						<option
							<c:if test="${parm.factoring_mode eq 2}">selected="selected"</c:if>
							value="2">暗保理</option>
					</select>
				</div>
				<!-- <div class="form-grou mr40"><label>融资状态：</label><select class="content-form"><option>请选择</option></select></div> -->
				<div class="form-grou mr40">
					<label>融资方式：</label><select name="financing_mode" class="content-form"><option
							<c:if test="${empty parm.financing_mode}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${parm.financing_mode eq 1}">selected="selected"</c:if>
							value="1">签约资方</option>
						<option
							<c:if test="${parm.financing_mode eq 2}">selected="selected"</c:if>
							value="2">平台推荐</option>
						<option
							<c:if test="${parm.financing_mode eq 3}">selected="selected"</c:if>
							value="3">竞标</option>
					</select>
				</div>
				<div class="form-grou"><div id="query" class="btn-modify">查询</div></div>
			</div>
	</div>

	<div class="w1200 mt40">
		<div class="tabD">
			<table style="font-size: 14px">
			<tbody>
				<tr>
					<th>序号</th>
					<th>融资订单号</th>
					<th>保理类型</th>
					<th>资产类型</th>
					<th>融资方式</th>
					<th>参与资方数</th>
					<th>申请融资金额(元)</th>
					<th>融资期限(天)</th>
					<th>申请日期</th>
					<th>融资状态</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${page.records}" var="entity" varStatus="xh">
					<tr>
						<td class="toggletr">${xh.count}</td>
						<td><a param="${entity.id_}" href="#" class="order-a appApi">${entity.financing_order_number}</a></td>
						<td><c:if test="${entity.factoring_mode eq 1}">明保理</c:if> <c:if
								test="${entity.factoring_mode eq 2}">暗保理</c:if></td>
						<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if
								test="${entity.assets_type eq 2}">应付账款</c:if> <c:if
								test="${entity.assets_type eq 3}">票据</c:if></td>
						<td><c:if test="${entity.financing_mode eq 1}">签约资方</c:if>
							<c:if test="${entity.financing_mode eq 2}">平台推荐</c:if>
							<c:if test="${entity.financing_mode eq 3}">竞标</c:if></td>
						<td>${entity.funs_count}</td>
						<td><fmt:formatNumber value="${entity.financing_amount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
						<td>${entity.financing_term}</td>
						<td><lzq:date value="${entity.created_time}"
								parttern="yyyy-MM-dd" /></td>
						<td>待选择资方</td>
						<td>
						<%-- <a id="openSelect" onclick="openSelect(${entity.id_});" href="/chooseFundsController/chooseSubFundsList?id=${entity.id_}&financing_status=4&audit_type=1" class="btn-modify">选择资方</a> --%>
						<a param="${entity.id_}" href="#" class="btn-modify openSelect">选择资方</a>
						<a param="${entity.id_}" style="margin-left:8px;" href="#" class="btn-supplement canalSelect">撤销</a></td>
					</tr>
					<input id="id_" value="${entity.id_}" type="hidden" />
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		<jsp:include page="/ybl4.0/admin/common/page.jsp" />
		</form>

		<div id="select" style="display: none;">
			<p class="protitleWhite">
				<span></span>选择意向资方
			</p>
			<div class="tabD">
				<input id="financing_id" type="hidden">
				<table>
					<thead>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资方名称</th>
							<th>意向投资金额</th>
							<th>意向融资期限</th>
							<th>意向投资利率</th>
							<th>竞标时间</th>
							<th>初审意见表</th>
							<th>备注说明</th>
							<th>是否合作</th>
						</tr>
					</thead>
					<tbody id="subFincancingList">
					</tbody>
					<!-- <tr>
							<td class="toggletr">1</td>
							<td><a href="javascript:;" class="order-a">RZDD45656</a></td>
							<td>张三</td>
							<td>明保理</td>
							<td>应收账款</td>
							<td>签约资方</td>
							<td>￥100,000,000.00</td>
							<td><a href="javascript:;" class="order-a">附件1</a></td>
							<td></td>
							<td><input type="checkbox" value="1"/></td>
						</tr> -->
				</table>

			</div>




			<div class="btn2 mt40 clearfix">
				<a id="submit" href="javascript:;" class="btn-add btn-center">提交</a>
				<a id="cancel" href="javascript:;" class="btn-add btn-center">取消</a>
			</div>
		</div>


	</div>
	<div class="mb80"></div>
	<script>
		
		// 对Date的扩展，将 Date 转化为指定格式的String   
		// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
		// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
		// 例子：   
		// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
		// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
		Date.prototype.Format = function(fmt)   
		{ //author: meizz   
		  var o = {   
		    "M+" : this.getMonth()+1,                 //月份   
		    "d+" : this.getDate(),                    //日   
		    "h+" : this.getHours(),                   //小时   
		    "m+" : this.getMinutes(),                 //分   
		    "s+" : this.getSeconds(),                 //秒   
		    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
		    "S"  : this.getMilliseconds()             //毫秒   
		  };   
		  if(/(y+)/.test(fmt))   
		    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
		  for(var k in o)   
		    if(new RegExp("("+ k +")").test(fmt))   
		  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
		  return fmt;   
		}  
		
		$('#beginDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		/* 选择子订单列表 */
		function openSelect(id){
			dialog.open("/chooseFundsController/chooseSubFundsList?id="+id+ "&financing_status=4&audit_type=1", '950px', '750px', 'showFinaing', '选择资金方');
			close('outClose');
			/* var financing_status = 4;
			$("#subFincancingList").empty();
			$("#select").hide();
			$("#financing_id").val(id); */
			/* $.ajax({
				url:'/chooseFundsController/chooseSubFundsList',
			    type:'POST', //GET
			    async:true,    //或false,是否异步
			    data:{
			        id:id,
			        financing_status:financing_status,
			        audit_type:1
			    },
			    timeout:5000,    //超时时间
			    dataType:'json',
			    success:function(data){
			    	if(data.responseType=="SUCCESS"){
			    		var arrayResult = data.object.records;
				    	var htmlResult = '';
				    	if(arrayResult.length > 0){
				    		$.each(arrayResult,function(index,value){
					    	     var htmlString = "<tr>"+
							    	"<td class='toggletr'>"+(index+1)+"</td>"+
										"<td><a href='javascript:;' class='order-a'>"+value.order_no+"</a></td>"+ //子订单号
										"<td>"+value.funder_name+"</td>"+											//资方名称
										"<td>"+value.financing_amount+"</td>"+	//意向投资金额
										"<td>"+value.financing_term+"</td>"+	//意向融资期限
										"<td>"+value.financing_rate+"</td>";	//意向投资利率
										if(typeof(value.audit_date)!="undefined" && value.audit_date !=null && value.audit_date!=""){ 

											htmlString = htmlString + "<td>"+new Date(value.audit_date).Format('yyyy-MM-dd')+"</td>";//竞标时间

										} else{
											htmlString = htmlString+"<td></td>";
										}
									htmlString = htmlString+
										"<td><a href='/chooseFundsController/downloadPreaAttachment?sub_id="+value.id_+"' class='order-a down'>附件</a></td>"+ //初审意见表
										"<td>"+value.remark+"</td>"+	//备注说明
										"<td><input type='checkbox' value='"+value.id_+"-"+value.funder_name+"'/></td>"+
									"</tr>"
									htmlResult = htmlResult + htmlString;
					    	});
				    	}
				    	
				    	$("#subFincancingList").append(htmlResult);
			    	}
			    	
			    }
				
			}); */
			/* $("#select").show();
			window.location.hash = "#select"; */
		}
		
		$(function(){	
			// 查询提交表单 
			$("#query").click(function(){
				$("#pageForm").submit();
			});
			
			$(".canalSelect").click(function(){
				var paramString = $(this).attr("param");
				var formDateArry = paramString.split(/\s+|,|-/g);
				var financing_apply_id = formDateArry[0];
				var financing_status = 99;
				confirm("是否放弃本次融资?",function(){
					$.ajax({
						url:'/chooseFundsController/updateSubFundAndPattnList',
					    type:'GET', //GET
					    async:true,    //或false,是否异步
					    data:{
					        financing_apply_id:financing_apply_id,
					        financing_status:financing_status
					    },
					    timeout:5000,    //超时时间
					    dataType:'json',
					    success:function(data){
					    	alert(data.info);
					    	if(data.responseType == "SUCCESS"){
					    		location.reload(true);
							}
					    }
						
					});
				});
			});
			
			$(".openSelect").click(function() {
				var paramString = $(this).attr("param");
				var formDateArry = paramString.split(/\s+|,|-/g);
				$.createFormAndSubmit({
					formDate : {
						id : formDateArry[0],
						financing_status: 4,
						audit_type: 1
					},
					formAttrbute : {
						action : "/chooseFundsController/chooseSubFundsList",
						method : "POST"
					}
				});

			});
			
			$(".appApi").click(function() {
				var paramString = $(this).attr("param");
				var formDateArry = paramString.split(/\s+|,|-/g);
				$.createFormAndSubmit({
					formDate : {
						id : formDateArry[0],
						statue:4,
						url: "/chooseFundsController/chooseFundsList"
					},
					formAttrbute : {
						action : "/financingApplyCommonApi/view.htm",
						method : "POST"
					}
				});

			});
			
			$("#submit").click(function(){
				var ids=new Array();
				var financing_apply_id = $("#financing_id").val();
				var financing_status = 5
				$("input:checkbox:checked").each(function(index,element){
					ids[index] = $(element).val()
				});
				if(ids.length <= 0){
					alert("至少选择一个资方");
					return false;
				}
				if(ids.length > 3){
					alert("最多选择三家资方");
					return false;
				}
				b = ids.join(",");
				$.ajax({
					url:'/chooseFundsController/updateSubFundsList',
				    type:'POST', //GET
				    async:true,    //或false,是否异步
				    data:{
				        ids:b,
				        financing_apply_id:financing_apply_id,
				        financing_status:financing_status,
				        selection_status:1
				    },
				    timeout:5000,    //超时时间
				    dataType:'json',
				    success:function(data){
				    	alert(data.info);
				    	if(data.responseType == "SUCCESS"){
				    		$("#subFincancingList").empty();
							$("#select").hide();
				    		location.reload(true);
						}
				    }
					
				});
				//location.replace("/chooseFundsController/chooseFundsList");
				
			});
			
			$("#cancel").click(function(){
				$("#subFincancingList").empty();
				$("#select").hide();
				
			});
			
			
			
		});
		
		</script>
</body>

</html>