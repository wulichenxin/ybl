<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.bid.detail"/></title><!-- 竞标详情 -->
<jsp:include page="../../common/link.jsp" />
<!-- 进度条 -->
<script src="${app.staticResourceUrl}/ybl/resources/js/navlist.js"
	type="text/javascript"></script>
<!-- 进度条 -->
<script src="${app.staticResourceUrl}/ybl/resources/js/underscore.js"
	type="text/javascript"></script>
<!-- 进度条 -->
<script src="${app.staticResourceUrl}/ybl/resources/js/highcharts.js"
	type="text/javascript"></script>

</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path"><!-- 当前位置->标的管理 -> 普通标管理 -> 标的详情 ->竞标详情 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.subject.manage"/>-> 
		<spring:message code="sys.client.common.subject.manage"/>->
		<spring:message code="sys.client.subject.detail"/>->
		<spring:message code="sys.client.bid.detail"/>
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i>
					<spring:message code="sys.client.bid.detail"/><!-- 竞标详情 -->
				</h1>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.bid.message"/><!-- 竞投信息 --></h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.fee.expense.rule"/>：</span><!-- 费用计息规则 -->
								<!-- <div class="radio fl mr100">
									<input class="radio_input" type="radio" name="RadioGroup1"
										value="单选" />按贷款金额百分比：<input placeholder="10" type="text"
										class="text w50 mr10 ml10" />%
								</div> --><!-- 该计费方式暂时隐藏 -->
								<div class="radio fl">
									<!-- <input class="radio_input" type="radio" name="RadioGroup1"
										value="单选" /> -->
										<spring:message code="sys.client.interest.on.loan"/><!-- 按贷款期限计息 -->
								</div>
							</div></li>


						<li class="clear w472"><div class="input_box">
								<span><spring:message code="sys.client.loanRate"/>：</span><!-- 贷款利率 -->
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 -->
									<input placeholder="10" type="text"
										class="text w50 mr10 ml10" value='<fmt:formatNumber value="${subjectBid.rate}" pattern="0.00" maxFractionDigits="2"/>'
										disabled='disabled' />%
								</div>
							</div></li>
						<%-- <li class=" w472"><div class="input_box">
								<span><spring:message code="sys.client.managementPercent"/>：</span><!-- 管理费百分比 -->
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 -->
										<input placeholder="10" type="text"
										class="text w50 mr10 ml10" value='<fmt:formatNumber value="${subjectBid.managerRate}" pattern="0.00" maxFractionDigits="2"/>'
										disabled='disabled' />%
								</div>
							</div></li> --%>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.financingProportion"/>：</span><!-- 融资比例 -->
								<div>
									<input placeholder="10" type="text" class="text w50 mr10 ml10"
										disabled='disabled' value='<fmt:formatNumber value="${subjectBid.ratio}" pattern="0.00" maxFractionDigits="2"/>' />%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.maxLoanMoney"/>：</span><!-- 最大可贷金额 -->
								<div>
									<input placeholder="100" type="text"
										class="text w100 mr10 ml10" value='<fmt:formatNumber value="${subjectBid.maxAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>'
										disabled='disabled' />
									<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.advince.amount"/>：</span><!-- 提前还款违约金 -->
								<input placeholder="20" type="text"
									class="text w50 mr10" value='<fmt:formatNumber value="${subjectBid.advenceRate }" pattern="0.00" maxFractionDigits="2"/>'
									disabled='disabled' />%
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.overdue.amount"/>：</span><!-- 逾期违约金 -->
								<input placeholder="20" type="text"
									class="text w50 mr10" value='<fmt:formatNumber value="${subjectBid.overdueRate}" pattern="0.00" maxFractionDigits="2"/>'
									disabled='disabled' />%
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.financeApply"/></h1><!-- 融资申请 -->
				<div class="rzzt">
					<div class="basic_tb">
						<div class="prel2">
							<script type="text/javascript">
								$(document).ready(
										function() {
											var has_borrow = $("#compositeScore").html();
											var need = 100-has_borrow;
											var report = {
												"section_412" : [ {
													"label" : "",
													"data" : has_borrow
												}, {
													"label" : "",
													"data" : need
												} ]
											}
											customizeHighcharts();
											initDistribution_small(
													report.section_412,
													'maturity_412', '');
										});
							</script>

							<div data-highcharts-chart="1"
								style="height: 200px; width: 200px;" class="maturity_412">
							</div>
							<div class="progress_div2">
								<div class="tjd2">
									<div class="round">
										<span><spring:message code="sys.client.compositeScore"/><!-- 综合评分 --></span>
										<p id='compositeScore'>${subjectBid.compositeScore}</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>