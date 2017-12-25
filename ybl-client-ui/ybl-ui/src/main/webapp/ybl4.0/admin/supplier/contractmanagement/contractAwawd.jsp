<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>合同签署</title>
		<style>
			.trchrild{
				display:none
			}
		</style>
	</head>
		
	<body>

	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=9" />
		<!--top end -->

	
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />合同签署</div>
		</div>
	<form action="/contractController/contractSure.htm" id="pageForm" method="post">
		<div class="w1200 ybl-info">
			<div class="btn-found">查询</div>
			<div class="ground-form mb20">
				<div class="form-grou mr20"><label class="label-long">资金方名称：</label><input class="content-form" name="funder_name" value="${financinapply.funder_name}" /></div>
				<div class="form-grou mr20"><label>融资订单号：</label><input class="content-form" name="financing_order_number"  value="${financinapply.financing_order_number}" /></div>
				<%--  <div class="form-grou mr40"><label>融资状态：</label>
				 <select name="financing_status" class="content-form">
				<option <c:if test="${empty financinapply.financing_status}">selected="selected"</c:if> value="">全部</option>
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
				 </div> --%>
				 				<div class="form-grou"><label class="label-long">申请日期：</label><input id="begin_date" class="content-form"  name="begin_date" value="${financinapply.begin_date }"/></div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40"><input id="end_date" class="content-form"  name="end_date" value="${financinapply.end_date }" /></div>
			    
			</div>
			
			
			<%-- <div class="ground-form">
				<div class="form-grou"><label class="label-long">申请日期：</label><input id="begin_date" class="content-form"  name="begin_date" value="${financinapply.begin_date }"/></div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40"><input id="end_date" class="content-form"  name="end_date" value="${financinapply.end_date }" /></div>
			    
			
			</div> --%>
		
		</div>
		
		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资金方名称</th>
							<th>保理类型</th>			
							<th>资产类型</th>
							<th>融资方式</th>
							<th>融资金额（元）</th>
							<th>批复额度（元）</th>
							<!-- <th>保理服务费（元）</th> -->
							<th>融资期限（天）</th>
							<th>申请日期</th>
							
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${page.records}" var="entity" varStatus="status">
						<tr>
							<td class="toggletr" uid="">${status.count} </td>
							<td><a href="javascript:;" class="order-a viewContract" pid="${entity.id}" uid="${entity.master_contract_no} " appid="${entity.appid}" applid="${entity.applid}">${entity.financing_order_number}</a></td>
							<td>${entity.funder_name }</td>
							<td><c:if test="${entity.factoring_mode eq 1}">明保</c:if> <c:if test="${entity.factoring_mode eq 2}">暗保</c:if></td>
							<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if test="${entity.assets_type eq 2}">应付账款</c:if> <c:if test="${entity.assets_type eq 3}">票据</c:if></td>
							<td>
							<c:if test="${entity.financing_mode eq 1}">签约资方</c:if> 
							<c:if test="${entity.financing_mode eq 2}">平台推荐</c:if>
							 <c:if test="${entity.financing_mode eq 3}">竞标</c:if>
							</td>
							<td><fmt:formatNumber value="${entity.financing_amount }" pattern="#,##0.##" maxFractionDigits="2"/></td>
							<td><fmt:formatNumber value="${entity.credit_amount }" pattern="#,##0.##" maxFractionDigits="2"/></td>
							<%-- <td><fmt:formatNumber value="${entity.handlingcharge }" pattern="#,##0.##" maxFractionDigits="2"/></td>	 --%>						
							<td>${entity.financing_term }</td>
							<td><fmt:formatDate value="${entity.createdTime}" pattern="yyyy-MM-dd" /></td>
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
							<td><a href="javascript:;" class="btn-modify mr10 viewContract" pid="${entity.id}" uid="${entity.master_contract_no} " appid="${entity.appid}" applid="${entity.applid}">合同签约</a></td>
						</tr>
					</c:forEach>
						
					</table>
					
				</div>
			</div>
			<!-- <div class="center-btn mt40">
				<a href="javascript:;" class="btn-add btn-center">新增</a>
			</div> -->
		<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</form>
		</div>
		

		<script>
		$('#begin_date,#end_date').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		$(function(){
		$(".viewContract").click(function() {
			var uid=$(this).attr("uid");
			var pid=$(this).attr("pid");
			var appid=$(this).attr("appid");
			var applid=$(this).attr("applid");
			param={
					"master_contract_no":uid,
					"id":pid,
					"appid":appid,
					"applid":applid
			};
			httpPost('/contractController/updateInfo.htm',param);
			//window.open('/contractController/updateInfo.htm?master_contract_no='+uid+'&id='+pid+'&appid='+appid+'&applid='+applid, '_blank', '');

		});
		
		
		$(".btn-found").click(function(){
			$("#pageForm").submit();
		});

		});
		
			
			
		</script>
	</body>

</html>