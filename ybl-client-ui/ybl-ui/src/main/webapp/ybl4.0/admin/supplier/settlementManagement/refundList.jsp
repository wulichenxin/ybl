<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%> 
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js" ></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
		
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/css/index.css" />
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootstrap.min.css" />
		<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/htmleaf-demo.css">
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootsnav.css"> --%>
	</head>

	<body>
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7"/>
		
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span class="mr10 ml10">-</span>选择资金方</div>
		</div>
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">融资需求列表</li>
				<li class="formli">资料清单</li>
			</ul>
		</div>
		<div class="w1200 ybl-info">
		<form id="pageForm" action="/chooseFundsController/chooseFundsList" method="post">
			<div id="query" class="btn-found">查询</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" name="financing_order_number" value="${parm.financing_order_number}"/></div>
				<div class="form-grou"><label class="label-long">申请时间：</label><input name="begin_date" value="${parm.begin_date}" id="beginDate" class="content-form" /><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40"><input name="end_date" value="${parm.end_date}" id="endDate" class="content-form" /><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
			</div>
			
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>保理类型：</label>
				<select name="factoring_mode" class="content-form">
					<option <c:if test="${empty parm.factoring_mode}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${parm.factoring_mode eq 1}">selected="selected"</c:if> value="1">明保</option>
					<option <c:if test="${parm.factoring_mode eq 2}">selected="selected"</c:if> value="2">暗保</option>
				</select></div>
				<!-- <div class="form-grou mr40"><label>融资状态：</label><select class="content-form"><option>请选择</option></select></div> -->
				<div class="form-grou"><label>融资方式：</label>
				<select name="financing_mode" class="content-form">
					<option <c:if test="${empty parm.financing_mode}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${parm.financing_mode eq 1}">selected="selected"</c:if> value="1">签约资方</option>
					<option <c:if test="${parm.financing_mode eq 2}">selected="selected"</c:if> value="2">平台推荐</option>
					<option <c:if test="${parm.financing_mode eq 3}">selected="selected"</c:if> value="3">竞标</option>
				</select>
				</div>
			</div>
			</form>
		</div>
		
		<div class="w1200 mt40">
			<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>放款申请单号</th>
							<th>融资方</th>
							<th>保理类型</th>
							<th>第几期/总期</th>
							<th>返款日期</th>
							<th>本期应还本金(元)</th>
							<th>本期应还利息(元)</th>
							<th>本期还款状态</th>
							<th>返款确认</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${page.records}" var="entity" varStatus="xh">
						<tr>
							<td class="toggletr">${xh.count}</td>
							<td class="maxwidth"><a href="javascript:;" class="order-a">${entity.financing_order_number}</a></td>
							<td>${entity.financier}</td>
							<td><c:if test="${entity.factoring_mode eq 1}">明保</c:if> <c:if test="${entity.factoring_mode eq 2}">暗保</c:if></td>
							<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if test="${entity.assets_type eq 2}">应付账款</c:if> <c:if test="${entity.assets_type eq 3}">票据</c:if></td>
							<td><c:if test="${entity.financing_mode eq 1}">签约资方</c:if><c:if test="${entity.financing_mode eq 2}">平台推荐</c:if><c:if test="${entity.financing_mode eq 3}">竞标</c:if></td>
							<td>${entity.funs_count}</td>
							<td>${entity.financing_amount}</td> 
							<td><lzq:date value="${entity.created_time}" parttern="yyyy-MM-dd"/></td>
							<td>待选择资方</td>
							<td><a id="openSelect" onclick="openSelect(${entity.id_});" href="javascript:;" class="btn-supplement">选择资方</a></td>
						</tr>
						</c:forEach>
					</table>
			</div>
			<%-- <jsp:include page="/ybl4.0/admin/common/page.jsp"/> --%>
			
			
		</div>
		<div class="mb80"></div>
		<script>
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
			var financing_status = 4;
			$("#subFincancingList").empty();
			$("#select").hide();
			$("#financing_id").val(id);
			$.ajax({
				url:'/chooseFundsController/chooseSubFundsList',
			    type:'POST', //GET
			    async:true,    //或false,是否异步
			    data:{
			        id:id,
			        financing_status:financing_status
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
										"<td>"+value.real_name+"</td>"+											//资方名称
										"<td>"+value.financing_amount+"</td>"+	//意向投资金额
										"<td>"+value.financing_term+"</td>"+	//意向融资期限
										"<td>"+value.financing_rate+"</td>"+	//意向投资利率
										"<td>"+value.audit_date+"</td>"+	//竞标时间
										"<td><a href='"+value.audit_opinion+"' class='order-a'>附件1</a></td>"+ //初审意见表
										"<td>"+value.financing_rate+"</td>"+	//备注说明
										"<td><input type='checkbox' value='"+value.id_+"'/></td>"+
									"</tr>"
									htmlResult = htmlResult + htmlString;
					    	});
				    	}
				    	
				    	$("#subFincancingList").append(htmlResult);
			    	}
			    	
			    }
				
			});
			$("#select").show();
			window.location.hash = "#select";
		}
		
		$(function(){	
			/* 查询提交表单 */
			$("#query").click(function(){
				$("#pageForm").submit();
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
				        financing_status:financing_status
				    },
				    timeout:5000,    //超时时间
				    dataType:'json',
				    success:function(data){
				    	alert(data);
				    	
				    }
					
				});
				$("#subFincancingList").empty();
				$("#select").hide();
				location.replace("/chooseFundsController/chooseFundsList");
				
			});
			
			$("#cancel").click(function(){
				$("#subFincancingList").empty();
				$("#select").hide();
				
			});
			
			
			
		});
		
		</script>
	</body>

</html>