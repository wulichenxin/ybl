<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>云保理</title>
	</head>

    <!--top start -->
    <jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
    <!--top end -->

	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span class="mr10 ml10">-</span>放款申请</div>
		</div>
		
		<form action="/loanApplyV4Controller/loanApply/subFinancingApplyList.htm" id="pageForm" method="post">
			<input type="hidden" name="factoringMode" value="${param.factoringMode}">
			<div class="w1200 ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" name="order_no" value="${param.order_no }"/></div>
					<div class="form-grou mr40"><label>资金方：</label><input class="content-form" name="funder_name" value="${param.funder_name }"/></div>
				</div>
				
				<div class="ground-form">
				    <div class="form-grou mr40"><label>保理类型：</label><select class="content-form" name="factoring_mode">
                            <option value="">全部
                            <option value="1" <c:if test="${param.factoring_mode == '1' }">selected="selected"</c:if>>明保理</option>
                            <option value="2" <c:if test="${param.factoring_mode == '2' }">selected="selected"</c:if>>暗保理</option>
                        </select>
                    </div>
					<div class="form-grou"><label>申请时间：</label><input id="beginDate" date="true" name="begin_date" class="content-form" value="${param.begin_date }"/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" class="timeimg" /></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" date="true" name="end_date" class="content-form" value="${param.end_date }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="form-grou"><a href="javascript:;" class="btn-modify" id="btn-query">查询</a></div>
				</div>
			</div>
		
			<div class="w1200 mt40">
				<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资金方</th>
							<th>保理类型</th>
							<th>资产类型</th>
							<th>融资方式</th>
							<th>申请融资金额(元)</th>
							<th>融资期限(天)</th>
							<th>融资利率(%)</th>
							<th>申请日期</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
                            <tr><td colspan="12">暂无数据</td></tr>
                        </c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
							<tr>
								<td uindex="${index.count}" uid="${obj.id}" <c:if test="${obj.had_loan eq true}">class="toggletr"</c:if>>${index.count}<c:if test="${obj.had_loan eq true}"><img alt="" id="imgs" src="${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png"></c:if></td>
								<td><a href="javascript:;" class="order-a btn-query-financing-apply" uid="${obj.financing_apply_id }">${obj.order_no}</a></td>
								<td>${obj.funder_name}</td>
								<td>
									<c:if test="${not empty obj.factoring_mode and obj.factoring_mode eq 1}">明保理</c:if>
									<c:if test="${not empty obj.factoring_mode and obj.factoring_mode eq 2}">暗保理</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.assets_type and obj.assets_type eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assets_type and obj.assets_type eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assets_type and obj.assets_type eq 3}">票据</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.financing_mode and obj.financing_mode eq 1}">签约资方</c:if>
									<c:if test="${not empty obj.financing_mode and obj.financing_mode eq 2}">平台推荐</c:if>
									<c:if test="${not empty obj.financing_mode and obj.financing_mode eq 3}">竞标</c:if>
								</td>
								<td><fmt:formatNumber value="${obj.financing_amount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td>${obj.financing_term}</td>
								<td><fmt:formatNumber value="${obj.financing_rate}" pattern="##0.####" maxFractionDigits="4"/></td>
								<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>
									<a href="javascript:;" uid="${obj.financing_apply_id }" class="btn-modify btn-query-financing-apply">查看</a>
									<a href="javascript:;" financingid="${obj.financing_apply_id }" uid="${obj.id }" class="btn-modify btn-add-loan-apply">新增放款申请</a>
								</td>
							</tr>
						</c:forEach>
					</table>
					</div>
				</div>
				
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</div>
		
		</form>
		
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
			$('#btn-query').click(function(){
				$("#pageNumber").val(1);
				$("#pageForm").submit();
			});
			$('.btn-query-financing-apply').click(function(){
				var uid = $(this).attr("uid");
				var param = new Array();
				param = {
					"id":uid	
				};
				httpPost('/financingApplyV4Controller/financingApply/getFinancingApply.htm',param);
			});
			$('.btn-add-loan-apply').click(function(){
				var financingid = $(this).attr("financingid");
				var uid = $(this).attr("uid");
				var param = new Array();
				param = {
					"subId":uid,
					"financingApplyId":financingid
				};
				httpPost('/loanApplyV4Controller/loanApply/add.htm', param);
			});
			
			//查询放款申请列表
			$(".toggletr").click(function(){
				var id = $(this).attr("uid");
				var uindex = $(this).attr("uindex");
				var $this = $(this);
				var aa=$(this).parent();
				var sign=aa.attr("sign");
				if(sign!="success"){
					$.ajax({
						url:"/loanApplyV4Controller/getLoanApplyListBySubId",
						type:"post",
						dataType:"json",
						data:{subFinancingApplyId:id},
						success:function(data,status){
							if(status == "success"){	
								//虚幻拼接字符串作为子列表展示子融资订单
								var arrayResult = data.object;
						    	var htmlResult = '';
						    	if(arrayResult.length > 0){
						    		$.each(arrayResult,function(index,value){
						    			var controll_class = "";
						    			var controll_text = "";
						    			var assets_type = "";
						    			var loan_status = "";
						    			if (value.assets_type == '1') {
						    				assets_type = "应收账款";
						    			} else if (value.assets_type == '2') {
						    				assets_type = "应付账款";
						    			} else if (value.assets_type == '3') {
						    				assets_type = "票据";
						    			}
						    			if (value.status == '1') {
						    				loan_status = "未提交";
						    			} else if (value.status == '2') {
						    				loan_status = "待资方办理";
						    			} else if (value.status == '3') {
						    				loan_status = "待确权";
						    			} else if (value.status == '4') {
						    				loan_status = "待平台审核";
						    			} else if (value.status == '5') {
						    				loan_status = "待放款";
						    			} else if (value.status == '8') {
						    				loan_status = "待放款确认";
						    			} else if (value.status == '9') {
						    				loan_status = "已确认收款";
						    			} else if (value.status == '99') {
						    				loan_status = "放款失败";
						    			}
						    			if (value.status == 1) {
						    				controll_class = "update-loan-one";
						    				controll_text = "修改";
						    			} else {
						    				controll_class = "select-loan-one";
						    				controll_text = "查看";
						    			}
							    	     var htmlString = "<tr class='trchrild' uid="+id+">"+
									    	"<td class='toggletr'>"+uindex+"."+(index+1)+"</td>"+
												"<td><a href='javascript:;' class='order-a "+controll_class+"' uid='"+value.id_+"'>"+value.order_no+"</a></td>"+ 
												"<td>"+value.funder_name+"</td>"+
												"<td>"+assets_type+"</td>"+
												"<td>"+toThousandNum(parseFloat(value.financing_amount.toFixed(2)))+"</td>"+
												"<td>"+value.financing_term+"</td>"+
												"<td>"+parseFloat(value.financing_rate)+"</td>"+
												"<td>"+value.created_time+"</td>"+
												"<td>"+loan_status+"</td>"+
												"<td><a href='javascript:void(0);' class='btn-modify mr10 "+controll_class+"' uid='"+value.id_+"'>"+controll_text+"</a></td>"+
												"<td></td>"+
												"</tr>"
											htmlResult = htmlResult + htmlString;
											
							    	});
				    				$(aa).after(htmlResult);
				    				aa.attr("sign","success");
						    		var htmlTitle = "<tr class='trchrild' uid="+id+">"+
							    		"<td class='toggletr'></td>"+
										"<td>放款申请单号</td>"+ 
										"<td>资金方</td>"+
										"<td>资产类型</td>"+
										"<td>申请放款金额(元)</td>"+
										"<td>融资期限(天)</td>"+
										"<td>融资利率(%)</td>"+
										"<td>申请日期</td>"+
										"<td>放款状态</td>"+
										"<td>操作</td>"+
										"<td></td>"+
									"</tr>";
						    		$(aa).after(htmlTitle);
				    				//再次绑定子定单点击事件
				    				// 查看功能，跳转到详情页面
				    				activeClick();
						    	}
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
			
			function activeClick() {
				$(".update-loan-one").click(function(){
					var uid=$(this).attr("uid");
					var param = new Array();
					param = {
						"id":uid,
					};
					httpPost('/loanApplyV4Controller/loanApply/update.htm', param);
				});
				$(".select-loan-one").click(function(){
					var uid=$(this).attr("uid");
					var param = new Array();
					param = {
						"id":uid,
					};
					httpPost('/loanApplyV4Controller/loanApply/getLoanApply.htm', param);
				});
			}
		</script>
	</body>

</html>