<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>融资申请综合查询</title>
	</head>
		
	<body>

	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->

	
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资申请综合查询</div>
		</div>
	<form action="/IntegratedQueryController/list.htm" id="pageForm" method="post">
		<div class="w1200 ybl-info">
			
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">融资订单号：</label><input class="content-form" name="financing_order_number"  value="${financinapply.financing_order_number}" /></div>
				<div class="form-grou mr40"><label>资方名称：</label><input class="content-form" name="investor_name"  value="${financinapply.investor_name}" /></div>
				<div class="form-grou mr40"><label class="label-long">融资状态：</label><select name="financing_status" class="content-form"><option <c:if test="${empty financinapply.financing_status}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${financinapply.financing_status eq 1}">selected="selected"</c:if> value="1">待提交</option>
					<option <c:if test="${financinapply.financing_status eq 2}">selected="selected"</c:if> value="2">待平台初审</option>
					<option <c:if test="${financinapply.financing_status eq 3}">selected="selected"</c:if> value="3">待资方初审</option>
					<option <c:if test="${financinapply.financing_status eq 4}">selected="selected"</c:if> value="4">待选择资方</option>
					<option <c:if test="${financinapply.financing_status eq 5}">selected="selected"</c:if> value="5">待资方终审</option>
					<option <c:if test="${financinapply.financing_status eq 6}">selected="selected"</c:if> value="6">待确定资方</option>
					<option <c:if test="${financinapply.financing_status eq 7}">selected="selected"</c:if> value="7">待平台复核</option>	
					<option <c:if test="${financinapply.financing_status eq 8}">selected="selected"</c:if> value="8">待签署合同</option>
					<option <c:if test="${financinapply.financing_status eq 9}">selected="selected"</c:if> value="9">融资完成</option>
					<option <c:if test="${financinapply.financing_status eq 10}">selected="selected"</c:if> value="10">资金方驳回</option>
					<option <c:if test="${financinapply.financing_status eq 11}">selected="selected"</c:if> value="11">平台驳回</option>
					<option <c:if test="${financinapply.financing_status eq 99}">selected="selected"</c:if> value="99">融资失败</option>	
				</select>
				</div>
				
				<div class="form-grou"><label>融资方式：</label>
				<select name="financing_mode" class="content-form">
				<option <c:if test="${empty financinapply.financing_mode}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${financinapply.financing_mode eq 1}">selected="selected"</c:if> value="1">签约资方</option>
					<option <c:if test="${financinapply.financing_mode eq 2}">selected="selected"</c:if> value="2">平台推荐</option>
					<option <c:if test="${financinapply.financing_mode eq 3}">selected="selected"</c:if> value="3">竞标</option>
				</select></div>
			</div>
		
			<div class="ground-form">
			<div class="form-grou mr40"><label class="label-long">保理类型：</label>
				<select name="factoring_mode" class="content-form">
				<option <c:if test="${empty financinapply.factoring_mode}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${financinapply.factoring_mode eq 1}">selected="selected"</c:if> value="1">明保</option>
					<option <c:if test="${financinapply.factoring_mode eq 2}">selected="selected"</c:if> value="2">暗保</option>
				</select></div> 
				<div class="form-grou"><label class="label-long">融资申请时间：</label><input id="begin_date" class="content-form"  name="begin_date" value="${financinapply.begin_date }"/></div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40"><input id="end_date" name="end_date" class="content-form"  value="${financinapply.end_date }"/></div>
				<div class="btn-modify query">查询</div>
			</div>
		
		</div>
		
		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>合作资方</th>
							
							<th>保理类型</th>
							<th>资产类型</th>
							<th>融资方式</th>
							<th>融资申请金额(元)</th>
							<th>融资期限（天）</th>
							<th>融资利率（%）</th>
							<th>申请日期</th>
							
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${page.records}" var="entity" varStatus="status">
						<tr>
							<td class="toggletr" uid="${entity.id_}">${status.count} <c:if test="${entity.count  ne 0}"><img alt="" id="imgs" src="${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png"></c:if> </td>
							<td><a href="javascript:;" class=" order-a mr10 viewDetail"  uid="${entity.id_}" statue="${entity.financing_status}">${entity.financing_order_number}</a></td>
							<td class="maxwidth">${entity.investor_name }</td>
						
							<td><c:if test="${entity.factoring_mode eq 1}">明保</c:if> <c:if test="${entity.factoring_mode eq 2}">暗保</c:if></td>
							<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if test="${entity.assets_type eq 2}">应付账款</c:if> <c:if test="${entity.assets_type eq 3}">票据</c:if></td>
							<td>
							<c:if test="${entity.financing_mode eq 1}">签约资方</c:if> 
							<c:if test="${entity.financing_mode eq 2}">平台推荐</c:if>
							 <c:if test="${entity.financing_mode eq 3}">竞标</c:if>
							</td>
							<td><fmt:formatNumber value="${entity.financing_amount }" pattern="#,##0.00" maxFractionDigits="2"/></td>
							<td>${entity.financing_term }</td>
							<td><fmt:formatNumber value="${entity.financing_rate }" pattern="#,##0.####" maxFractionDigits="2"/></td>
							<td><lzq:date value="${entity.created_time}" parttern="yyyy-MM-dd"/></td>
							
							
							<td>
							<c:if test="${entity.financing_status eq 1}">待提交</c:if> 
							<c:if test="${entity.financing_status eq 2}">待平台初审</c:if>
							<c:if test="${entity.financing_status eq 3}">待资方初审</c:if>
							 <c:if test="${entity.financing_status eq 4}">待选择资方</c:if>
							 <c:if test="${entity.financing_status eq 5}">待资方终审</c:if> 
							<c:if test="${entity.financing_status eq 6}">待确定资方</c:if>
							 <c:if test="${entity.financing_status eq 7}">待平台复核</c:if>
							 <c:if test="${entity.financing_status eq 8}">待签署合同</c:if> 
							<c:if test="${entity.financing_status eq  9}">融资完成</c:if>
							 <c:if test="${entity.financing_status eq 10}">资金方驳回</c:if>
							 <c:if test="${entity.financing_status eq  11}">平台驳回</c:if>
							 <c:if test="${entity.financing_status eq 99}">融资失败</c:if>
							</td>
							
							<td><a href="javascript:;" class="btn-modify mr10 viewDetail"  uid="${entity.id_}" statue="${entity.financing_status}">查看</a></td>
						</tr>
					</c:forEach>
						
					</table>
					
				</div>
			</div>
			<!-- <div class="center-btn mt40">
				<a href="javascript:;" class="btn-add btn-center">新增</a>
			</div> -->
		<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		</form>
		

		<script>
		Date.prototype.Format = function(fmt) { //author: meizz   
			var o = {
				"M+" : this.getMonth() + 1, //月份   
				"d+" : this.getDate(), //日   
				"h+" : this.getHours(), //小时   
				"m+" : this.getMinutes(), //分   
				"s+" : this.getSeconds(), //秒   
				"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
				"S" : this.getMilliseconds()
			//毫秒   
			};
			if (/(y+)/.test(fmt))
				fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			for ( var k in o)
				if (new RegExp("(" + k + ")").test(fmt))
					fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
							: (("00" + o[k]).substr(("" + o[k]).length)));
			return fmt;
		}
			$('#begin_date,#end_date').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			// 修改为停用状态
			// 修改为停用状态
			$(".btn-supplement").click(function(){
				var id=$(this).attr("uid");
				$.ajax({
					url:"/IntegratedQueryController/updateStatue",
					type:"post",
					dataType:"json",
					data:{id:id},
					success:function(data,status){
						alert("修改成功");
						
					}
					
				});
			});
			
			
			$(function(){
			// 查询
			$(".query").click(function(){
				$("#pageForm").submit();
			});
			//js金额保留2未小数
			function returnFloat(value){
				 var value=Math.round(parseFloat(value)*100)/100;
				 var xsd=value.toString().split(".");
				 if(xsd.length==1){
				 value=value.toString()+".00";
				 return value;
				 }
				 if(xsd.length>1){
				 if(xsd[1].length<2){
				  value=value.toString()+"0";
				 }
				 return value;
				 }
				}
			
			// 查看功能，跳转到详情页面
			$(".viewDetail").click(function(){
				var id=$(this).attr("uid");
				var statue=$(this).attr("statue");
				param={
						"id":id,
						"statue":statue
				};
				httpPost('/IntegratedQueryController/view.htm',param);
				//window.open('/IntegratedQueryController/view.htm?id='+id, '_blank', '');
	
				
			});
			
			
	
			//查询子融资列表
			$(".toggletr").click(function(){
				var id = $(this).attr("uid");
				var $this = $(this);
				var aa=$(this).parent();
				var sign=aa.attr("sign");
				if(sign!="success"){
				$.ajax({
					url:"/IntegratedQueryController/getlist",
					type:"post",
					dataType:"json",
					data:{id:id},
					success:function(data,status){
						if(status == "success"){	
							//虚幻拼接字符串作为子列表展示子融资订单
							var arrayResult = data.object;
					    	var htmlResult = '';
					    	

					    	if(arrayResult.length > 0){
					    		$.each(arrayResult,function(index,value){
					    			
					    			    var assets_type='';
							    	    var factoring_mode='';
							    	    var financing_mode='';
							    	  	var financing_status='';
							    	  	var createtime='';
							    	  	var financing_amount='';
							    	  	var financing_rate='';
							    	  
							    	  	if(typeof(value.financing_amount) != "undefined"&&value.financing_amount !=null){
							    	  		financing_amount=returnFloat(value.financing_amount);
							    	  	}
							    	
							    	  	if (value.created_time != "undefined"
											 && value.created_time != null) {
							    	  		createtime = new Date(value.created_time).Format('yyyy-MM-dd')
									}
							    	  	
						    			if(value.assets_type ==1) {
						    				assets_type='应收账款'
							    	     }else if(value.assets_type ==2){
							    	    	 assets_type='应付账款'	
							    	     }else if(value.assets_type ==3){
							    	    	 assets_type='票据'
							    	     }
						    			
						    			if(value.factoring_mode==1){
						    				factoring_mode='明保';
						    			}else if(value.factoring_mode==2){
						    				factoring_mode='暗保';
						    			}
						    			
						    			if(value.financing_mode==1){
						    				financing_mode='签约资方';
						    			}else if(financing_mode==2){
						    				financing_mode='平台推荐';
						    			}else if(financing_mode==3){
						    				financing_mode='竞标';
						    			}
						    			
						    			if(value.financing_status==1){
						    				financing_status='待提交';
						    			}else if(value.financing_status==2){
						    				financing_status='待平台初审';
						    			}else if(value.financing_status==3){
						    				financing_status='待资方初审';
						    			}else if(value.financing_status==4){
						    				financing_status='待选择资方';
						    			}else if(value.financing_status==5){
						    				financing_status='待资方终审';
						    			}else if(value.financing_status==6){
						    				financing_status='待确定资方';
						    			}else if(value.financing_status==7){
						    				financing_status='待平台复核';
						    			}else if(value.financing_status==8){
						    				financing_status='待签署合同';
						    			}else if(value.financing_status==9){
						    				financing_status='融资完成';
						    			}else if(value.financing_status==10){
						    				financing_status='资方驳回';
						    			}else if(value.financing_status==11){
						    				financing_status='平台驳回';
						    			}else if(value.financing_status==99){
						    				financing_status='融资失败';
						    			}
						    			
						    			
						    			
						    			
						    	     var htmlString = "<tr class='trchrild' uid="+id+">"+
								    	"<td class='toggletr'>"+(index+1)+"</td>"+
								    	"<td><a href='javascript:;' class='order-a mr10 subView' id='view' uid='"+id+"'childrenid='"+value.id_+"' statue='"+value.financing_status+"'>"+value.financing_order_number+"</a></td>"+
											
											"<td>"+value.investor_name+"</td>"+											//资方名称
			
											"<td>"+factoring_mode+"</td>"+	//意向融资期限
											"<td>"+assets_type+"</td>"+	//意向投资利率
											"<td>"+financing_mode+"</td>"+
											"<td>"+toThousandNum(parseFloat(value.financing_amount.toFixed(2)))+"</td>"+
											"<td>"+value.financing_term+"</td>"+
											"<td>"+parseFloat(value.financing_rate) +"</td>"+									
											"<td>"+createtime+"</td>"+						
											"<td>"+financing_status+"</td>";
											
											if(value.financing_status == 99||value.financing_status==9){
												htmlString = htmlString+"<td><a href='javascript:;' class='btn-modify mr10 subView' id='view' uid='"+id+"'childrenid='"+value.id_+"' statue='"+value.financing_status+"'>查看</a></td>";
											}else{
												htmlString = htmlString+"<td><a href='javascript:;' class='btn-modify mr10 subView' id='view' uid='"+id+"'childrenid='"+value.id_+"' statue='"+value.financing_status+"'>查看</a><a href='javascript:;'  uid='"+value.id_+"' class='btn-supplement'>停止</a></td>";

											}
											
											
											htmlString = htmlString+"</tr>";
										htmlResult = htmlResult + htmlString;
										
						    	});
					    				$(aa).after(htmlResult);
					    				aa.attr("sign","success");
					    				//再次绑定子定单点击事件
					    				// 查看功能，跳转到详情页面
										$(".subView").click(function(){
											var id=$(this).attr("uid");
											var childrenId=$(this).attr("childrenid");
											var statue=$(this).attr("statue");
											param={
													"id":id,
													"childrenId":childrenId,
													"statue":statue
													
											};
											httpPost('/IntegratedQueryController/view.htm',param);
											//window.open('/IntegratedQueryController/view.htm?id='+id+'&childrenId='+childrenId, '_blank', '');
								
											
										});
					    				$(".btn-supplement").click(function(){
					    					var id=$(this).attr("uid");
					    					$.ajax({
					    						url:"/IntegratedQueryController/updateStatue",
					    						type:"post",
					    						dataType:"json",
					    						data:{id:id},
					    						success:function(data,status){
					    							alert(data.info,function(){
					    								if(data.responseType == "SUCCESS"){
					    									
					    							$("#pageForm").submit();	
					    								}else{
					    									return false;
					    								}
					    							});
					    						}
					    						
					    					});
					    				});
					    				
							
					    		
					    	}

							

							
						}else{
							alert("暂无子融资订单");
						}		
						
						
	
					
						
					},

					
				}); 
				
				
		
			}
				
				var childer = document.getElementsByClassName('trchrild');
				for(var i=0;i<childer.length;i++){
					if(childer[i].getAttribute('uid')==$this.attr('uid')){
						$(childer[i]).toggle();
					}
				}
			var src=$this.find('img').attr("src");
			if(src=="${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png"){
				$this.find('img').attr("src","${app.staticResourceUrl}/ybl4.0/resources/images/downList_icon.png");
			}else{
				$this.find('img').attr("src",'${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png');
			}
		
			});
			
	
			});
			
			
			
		</script>
	</body>

</html>