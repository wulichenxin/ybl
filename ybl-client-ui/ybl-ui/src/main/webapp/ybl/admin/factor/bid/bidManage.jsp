<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.bid.manage"/></title><!-- 竞投管理 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
	/* 测试222  */
	var index;
	var timer;
	// 添加
	function add_start() {
		$('#add').show();
		$('t_window').css({
			overflow : 'hidden'
		});
	}
	function add_close() {
		clearInterval(timer);
		$('#add').hide();
		$('body').css({
			overflow : ''
		});
	}
	
	$(function(){
		$("#member_factor_bid_Manage_bidQuery_btn").click(function(){
			$("#pageForm").submit();
		})
		$("#reset").click(function(){
			$("input[name='name_']").val('');
			$("#contend_status").val('');
		})
	})
	
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=6" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.investBidManage.investManage"/> -> <spring:message code="sys.client.investBidManage"/></div>
	<form action="/bidController/investManage" id="pageForm" method="post">
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.projectName"/>:</label><input type="text" name="name_" value="${name_ }"/></li>
					<li><label><spring:message code="sys.client.investBidManage.investBidStatus"/>:</label>
						<select name="contend_status" id="contend_status">
							<option value=""><spring:message code="sys.client.queryAll"/><!-- 全部 --></option>
							<option <c:if test="${contend_status=='bided' }">selected="selected" </c:if> value="bided"><spring:message code="sys.client.investBidManage.bided"/><!-- 已中标 --></option>
							<option <c:if test="${contend_status=='biding' }">selected="selected" </c:if> value="biding"><spring:message code="sys.client.investBidManage.biding"/><!-- 竞标中 --></option>
							<option <c:if test="${contend_status=='unbid' }">selected="selected" </c:if> value="unbid"><spring:message code="sys.client.investBidManage.unbid"/><!-- 未中标 --></option>
						</select>
					</li>
					<li><div class="button_yellow">
							<sun:button tag='a' id='member_factor_bid_Manage_bidQuery_btn' i18nValue='sys.client.query' />
						</div></li>
					<li><div class="button_gary">
							<a id="reset"><spring:message code="sys.client.reset"/></a>
						</div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box">

			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="100"><spring:message code="sys.client.no"/><!-- 序号 --></th>
						<th><spring:message code="sys.client.projectName"/></th><!-- 项目名称 -->
						<th><spring:message code="sys.client.loanMoney"/></th><!-- 融资金额 -->
						<th><spring:message code="sys.client.investBidManage.maxFinanceScale"/></th><!-- 最大贷款比例 -->
						<th><spring:message code="sys.client.investBidManage.repaymentPeriod"/></th><!-- 还款期限 -->
						<th><spring:message code="sys.client.investBidManage.investEnterprise"/></th><!-- 竞标企业数 -->
						<th><spring:message code="sys.client.investBidManage.TheAuctionEndTime"/></th><!-- 竞标结束时间 -->
						<th><spring:message code="sys.client.investBidManage.TheWinningTime"/></th><!-- 中标时间 -->
						<th><spring:message code="sys.client.investBidManage.BiddingStatus"/></th><!-- 竞标状态 -->
					</tr>
					<c:forEach var="bid" items="${list}" varStatus="index" >
					<tr>
						<td>${index.count }</td>
						<td>
							<sun:button tag='a' href="/subjectController/investdetail?id=${bid.id_ }" clazz='lan'  id='member_factor_bid_Manage_lookBidDetail_btn' value='${bid.name_ }' />
						</td>
						<td><fmt:formatNumber value="${bid.amount_ /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td><fmt:formatNumber value="${bid.ratio_}" pattern="#,##0.00" maxFractionDigits="2"/>%</td>
						<td>${bid.loan_period} &nbsp;
							<c:if test="${bid.period_type == 'day' }"><spring:message code="sys.client.day"/></c:if>
	                		<c:if test="${bid.period_type == 'month' }"><spring:message code="sys.client.month"/></c:if>
	                		<c:if test="${bid.period_type == 'year' }"><spring:message code="sys.client.year"/></c:if>
						</td>
						<td>${bid.count}</td>
						<td>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${bid.end_date}" />
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
						</td>
						<td>
							<c:if test="${bid.contend_status == 'unbid' || bid.contend_status == 'bided'}">
								<jsp:useBean id="dateValue1" class="java.util.Date" />
								<jsp:setProperty name="dateValue1" property="time" value="${bid.last_update_time}" />
								<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd" />
							</c:if>
						</td>
						<td class="yellow">
							<c:if test="${bid.contend_status == 'bided'}">
								<spring:message code="sys.client.investBidManage.bided"/>
							</c:if>
							<c:if test="${bid.contend_status == 'biding'}">
								<spring:message code="sys.client.investBidManage.biding"/>
							</c:if>
							<c:if test="${bid.contend_status == 'unbid'}">
								<spring:message code="sys.client.investBidManage.unbid"/>
							</c:if>
						</td>
						
					</tr>
					</c:forEach>
				</table>
			</div>
			<jsp:include page="../../common/page.jsp"></jsp:include>
		</div>
		<!--table-->
	</div>
	</form>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
	
</body>
</html>