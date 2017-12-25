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
		<style type="text/css">
			.tr-red td{
				color:red !important;
			}
		</style>
	</head>

    <!--top start -->
    <jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
    <!--top end -->
    
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span class="mr10 ml10">-</span>暗保理业务</div>
		</div>
		
		<form action="/financingApplyV4Controller/financingApply/darkList.htm" id="pageForm" method="post">
			<input type="hidden" id="factoringMode" name="factoringMode" value="${financingApply.factoringMode}">
			<div class="w1200 ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" name="financingOrderNumber" value="${financingApply.financingOrderNumber }"/></div>
					<div class="form-grou"><label>申请时间：</label><input id="beginDate" date="true" name="beginDate" class="content-form" value="${financingApply.beginDate }"/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" class="timeimg" /></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou"><input id="endDate" date="true" name="endDate" class="content-form" value="${financingApply.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
				</div>
				
				<div class="ground-form">
					<div class="form-grou mr40"><label>融资状态：</label><select class="content-form" name="financingStatus">
							<option value="">全部</option>
							<option value="1" <c:if test="${financingApply.financingStatus eq 1 }">selected="selected"</c:if>>待提交</option>
							<option value="2" <c:if test="${financingApply.financingStatus eq 2 }">selected="selected"</c:if>>待平台初审</option>
							<option value="3" <c:if test="${financingApply.financingStatus eq 3 }">selected="selected"</c:if>>待资方初审</option>
							<option value="4" <c:if test="${financingApply.financingStatus eq 4 }">selected="selected"</c:if>>待选择资方</option>
							<option value="5" <c:if test="${financingApply.financingStatus eq 5 }">selected="selected"</c:if>>待资方终审</option>
							<option value="6" <c:if test="${financingApply.financingStatus eq 6 }">selected="selected"</c:if>>待确定资方</option>
							<option value="7" <c:if test="${financingApply.financingStatus eq 7 }">selected="selected"</c:if>>待平台复核</option>
							<option value="8" <c:if test="${financingApply.financingStatus eq 8 }">selected="selected"</c:if>>待签署合同</option>
							<option value="9" <c:if test="${financingApply.financingStatus eq 9 }">selected="selected"</c:if>>融资完成</option>
							<option value="99" <c:if test="${financingApply.financingStatus eq 99 }">selected="selected"</c:if>>融资失败</option>
							<option value="10" <c:if test="${financingApply.financingStatus eq 10 }">selected="selected"</c:if>>资金方驳回</option>
							<option value="11" <c:if test="${financingApply.financingStatus eq 11 }">selected="selected"</c:if>>平台方驳回</option>
						</select>
					</div>
					<div class="form-grou mr40"><label>融资方式：</label><select class="content-form" name="financingMode">
							<option value="">全部</option>
							<option value="1" <c:if test="${financingApply.financingMode eq '1' }">selected="selected"</c:if>>签约资方</option>
							<option value="2" <c:if test="${financingApply.financingMode eq '2' }">selected="selected"</c:if>>平台推荐</option>
							<option value="3" <c:if test="${financingApply.financingMode eq '3' }">selected="selected"</c:if>>竞标</option>
						</select>
					</div>
					<div class="form-grou"><a href="javascript:;" class="btn-modify" id="btn-query">查询</a></div>
				</div>
			</div>
		
			<div class="w1200 mt40">
				<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>保理类型</th>
							<th>资产类型</th>
							<th>融资方式</th>
							<th>申请融资金额(元)</th>
							<th>融资期限(天)</th>
							<th>融资利率(%)</th>
							<th>申请日期</th>
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
                            <tr><td colspan="12">暂无数据</td></tr>
                        </c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
							<tr <c:if test="${obj.financingStatus eq 11 or obj.rujectStatus eq true}">class="tr-red"</c:if>>
								<td uindex="${index.count}" uid="${obj.id}" <c:if test="${obj.rujectStatus eq true}">class="toggletr"</c:if>>${index.count}<c:if test="${obj.rujectStatus eq true}"><img alt="" id="imgs" src="${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png"></c:if></td>
								<td><a href="javascript:;" class="order-a 
                                        <c:if test="${not empty obj.financingStatus and obj.financingStatus ne 1 and obj.financingStatus ne 11}">btn-query-one</c:if>
                                        <c:if test="${not empty obj.financingStatus and obj.financingStatus eq 1}">btn-update-one</c:if>
                                        <c:if test="${not empty obj.financingStatus and obj.financingStatus eq 11}">btn-update-one</c:if>"
                                        uid="${obj.id}">${obj.financingOrderNumber}</a></td>
								<td>
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 1}">明保理</c:if>
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 2}">暗保理</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 1}">签约资方</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 2}">平台推荐</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 3}">竞标</c:if>
								</td>
								<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td>${obj.financingTerm}</td>
								<td><fmt:formatNumber value="${obj.financingRate}" pattern="##0.####" maxFractionDigits="4"/></td>
								<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 1}">待提交</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 2}">待平台初审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 3}">待资方初审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 4}">待选择资方</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 5}">待资方终审</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 6}">待确定资方</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 7}">待平台复核</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 8}">待签署合同</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 9}">融资完成</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 99}">融资失败</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 10}">资金方驳回</c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 11}">平台方驳回</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus ne 1 and obj.financingStatus ne 11}"><a href="javascript:;" uid="${obj.id}" class="btn-modify btn-query-one">查看</a></c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 1}"><a href="javascript:;" uid="${obj.id}" class="btn-modify btn-update-one">修改</a></c:if>
									<c:if test="${not empty obj.financingStatus and obj.financingStatus eq 11}"><a href="javascript:;" uid="${obj.id}" class="btn-modify btn-update-one">补充</a></c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="center-btn mt40">
					<a  class="btn-add btn-add-one btn-center">新增</a>
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
			$('.btn-query-one').click(function(){
				var uid = $(this).attr("uid");
				var param = new Array();
				param = {
					"id":uid
				};
				httpPost('/financingApplyV4Controller/financingApply/getFinancingApply.htm', param);
			});
			$('.btn-update-one').click(function(){
				var uid = $(this).attr("uid");
				var param = new Array();
				param = {
					"id":uid
				};
				httpPost('/financingApplyV4Controller/financingApply/update.htm', param);
			});
			$('.btn-add-one').click(function(){
				var factoringMode = $("#factoringMode").val();
				var param = new Array();
				param = {
					"factoringMode":factoringMode
				};
				httpPost('/financingApplyV4Controller/financingApply/add.htm', param);
			});
			
			//查询子融资列表
			$(".toggletr").click(function(){
				var id = $(this).attr("uid");
				var uindex = $(this).attr("uindex");
				var $this = $(this);
				var aa=$(this).parent();
				var sign=aa.attr("sign");
				if(sign!="success"){
					$.ajax({
						url:"/financingApplyV4Controller/getSubList",
						type:"post",
						dataType:"json",
						data:{financing_apply_id:id},
						success:function(data,status){
							if(status == "success"){	
								//虚幻拼接字符串作为子列表展示子融资订单
								var arrayResult = data.object;
						    	var htmlResult = '';
						    	
	
						    	if(arrayResult.length > 0){
						    		$.each(arrayResult,function(index,value){
						    			var red = "";
						    			var controll_class = "";
						    			var controll_text = "";
						    			var factoring_mode = "";
						    			var assets_type = "";
						    			var financing_mode = "";
						    			var financing_status = "";
						    			if (value.factoring_mode == '1') {
						    				factoring_mode = "明保理";
						    			} else if (value.factoring_mode == '2') {
						    				factoring_mode = "暗保理";
						    			} 
						    			if (value.assets_type == '1') {
						    				assets_type = "应收账款";
						    			} else if (value.assets_type == '2') {
						    				assets_type = "应付账款";
						    			} else if (value.assets_type == '3') {
						    				assets_type = "票据";
						    			}
						    			if (value.financing_mode == '1') {
						    				financing_mode = "签约资方";
						    			} else if (value.financing_mode == '2') {
						    				financing_mode = "平台推荐";
						    			} else if (value.financing_mode == '3') {
						    				financing_mode = "竞标";
						    			}
						    			if (value.financing_status == '1') {
						    				financing_status = "未提交";
						    			} else if (value.financing_status == '2') {
						    				financing_status = "待平台初审";
						    			} else if (value.financing_status == '3') {
						    				financing_status = "待资方初审";
						    			} else if (value.financing_status == '4') {
						    				financing_status = "待选择资方";
						    			} else if (value.financing_status == '5') {
						    				financing_status = "待资方终审";
						    			} else if (value.financing_status == '6') {
						    				financing_status = "待确定资方";
						    			} else if (value.financing_status == '7') {
						    				financing_status = "待平台复核";
						    			} else if (value.financing_status == '8') {
						    				financing_status = "待签署合同";
						    			} else if (value.financing_status == '9') {
						    				financing_status = "融资完成";
						    			} else if (value.financing_status == '99') {
						    				financing_status = "融资失败";
						    			} else if (value.financing_status == '10') {
						    				financing_status = "资方驳回";
						    			} else if (value.financing_status == '11') {
						    				financing_status = "平台驳回";
						    			}
						    			if (value.financing_status == 10) {
						    				red = "tr-red";
						    				controll_class = "reject-sub-financing";
						    				controll_text = "补充";
						    			} else {
						    				controll_class = "select-sub-financing";
						    				controll_text = "查看";
						    			}
							    	     var htmlString = "<tr class='trchrild "+red+"' uid="+id+">"+
									    	"<td class='toggletr'>"+uindex+"."+(index+1)+"</td>"+
												"<td><a href='javascript:;' class='order-a "+controll_class+"' uid='"+id+"' subid='"+value.id_+"'>"+value.order_no+"</a></td>"+ 
												"<td>"+factoring_mode+"</td>"+
												"<td>"+assets_type+"</td>"+
												"<td>"+financing_mode+"</td>"+
												"<td>"+toThousandNum(parseFloat(value.financing_amount.toFixed(2)))+"</td>"+
												"<td>"+value.financing_term+"</td>"+
												"<td>"+parseFloat(value.financing_rate)+"</td>"+
												"<td>"+value.created_time+"</td>"+
												"<td>"+financing_status+"</td>"+
												"<td><a href='javascript:void(0);' class='btn-modify mr10 "+controll_class+"' uid='"+id+"' subid='"+value.id_+"'>"+controll_text+"</a></td>"+
											"</tr>"
											htmlResult = htmlResult + htmlString;
											
							    	});
				    				$(aa).after(htmlResult);
				    				aa.attr("sign","success");
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
				$(".select-sub-financing").click(function(){
					var uid=$(this).attr("uid");
					var subid=$(this).attr("subid");
					var param = new Array();
					param = {
						"id":uid,
						"subid":subid
					};
					httpPost('/financingApplyV4Controller/financingApply/getFinancingApply.htm', param);
				});
				$(".reject-sub-financing").click(function(){
					var uid=$(this).attr("uid");
					var subid=$(this).attr("subid");
					var param = new Array();
					param = {
						"id":uid,
						"subid":subid
					};
					httpPost('/financingApplyV4Controller/financingApply/update.htm', param);
				});
			}
		</script>
	</body>

</html>