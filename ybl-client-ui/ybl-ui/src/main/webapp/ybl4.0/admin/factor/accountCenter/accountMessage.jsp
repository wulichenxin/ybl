<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>账户总览</title>
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
		<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl4.0/resources/calendar/index.css">
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl4.0/resources/echarts/echarts.js"></script>

			<script type="text/javascript"
			src="${app.staticResourceUrl}/ybl4.0/resources/js/factor/accounCenter/myAccount.js"></script>
		<link rel="stylesheet" href="/ybl4.0/resources/css/vip_center.css" />
		
	</head>
	<body>
		<p class="per_title"><span>账户总览</span></p>
					<table class="tabD2">
						<tr>
							<td>总资产(元)</td>
							<td>累计收益(元)</td>
							<td>待收本金(元)</td>
							<td>待收利息(元)</td>
						</tr>
						<tr>
							<td class="color-yellow" id="allMount"><fmt:formatNumber value="${allMount }" pattern="#,##0.##" maxFractionDigits="2"/></td>
							<td class="color-blue" id="totalIncome"><fmt:formatNumber value="${totalIncome }" pattern="#,##0.##" maxFractionDigits="2"/></td>
							<td id="totalPrincipal"><fmt:formatNumber value="${totalPrincipal }" pattern="#,##0.##" maxFractionDigits="2"/></td>
							<td id="totalUnInterest"><fmt:formatNumber value="${totalUnInterest }" pattern="#,##0.##" maxFractionDigits="2"/></td>
						</tr>
					</table>
					<div class="vip_right_content">
	           	<div class="assets_chart" >
	           		<div id="assets_chart_loading" style="width: 340px;height:240px;top:-20px;"></div>
	           	</div>
	           	<div class="assets_chart_content" style="margin-left:300px;">
	           		<ul>
	           			<li>
	           				<i class="ic1"></i>待收本金
	           				
	           				<span style="margin-right:70px;"><em id='totalPrincipal'><fmt:formatNumber value="${totalPrincipal }" pattern="#,##0.##" maxFractionDigits="2"/>元</em></span>
	           				
	           			</li>
	           			<li>
	           				<i class="ic2"></i>待收利息
	           				<span style="margin-right:70px;"><em id='totalUnInterest'><fmt:formatNumber value="${totalUnInterest }" pattern="#,##0.##" maxFractionDigits="2"/>元</em></span>
	           			</li>
	           		</ul>
	        	</div>
	
			</div>
	<div class="calendar">
		<!-- 账户主要表格 -->
		<%-- <input type="hidden" value="${repaymentPlan}" id="repaymentPlan"> --%>
		<div class="account-box" >
			<h2 class="account-title">
				<span class="left c3">回款日历</span> <a href="###"
					class="f-btn-fhby right">返回本月</a>
				<div class="clearfix right">
					<div class="f-btn-jian left">&lt;</div>
					<div class="left f-riqi">
						<span class="f-year">2017</span>年<span class="f-month">1</span>月
					</div>
					<div class="f-btn-jia left">&gt;</div>
					<!-- 一定不能换行-->
				</div>
			</h2>
			<div class="f-rili-table">
				<div class="f-rili-head celarfix">
					<div class="f-rili-th">周日</div>
					<div class="f-rili-th">周一</div>
					<div class="f-rili-th">周二</div>
					<div class="f-rili-th">周三</div>
					<div class="f-rili-th">周四</div>
					<div class="f-rili-th">周五</div>
					<div class="f-rili-th">周六</div>
					<div class="clear"></div>
				</div>
				<div class="f-tbody clearfix"></div>
			</div>
		</div>
	</div>

	</body>
</html>
