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
<title><spring:message code="sys.client.investBidManage.CustomerDetails"/></title><!-- 客户详情 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
	$(function() {
		//tab切换
		$('.tabnav dl dd').click(function() {
			var index = $(this).index();
			$('.content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
			$('.tabnav dl dd').eq(index).addClass('now').siblings().removeClass('now');
		});
	});
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
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=7" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.customer.manage"/> -> <spring:message code="sys.client.sign.manage"/> -> <spring:message code="sys.client.investBidManage.CustomerDetails"/></div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a><spring:message code="sys.client.investBidManage.financingCompanyProfile"/><!-- 客户公司简介 --></a>
					</dd>
					<dd>
						<a><spring:message code="sys.client.investBidManage.FinancingRecord"/><!-- 融资记录 --></a>
					</dd>
				</dl>
			</div>
			<div>
				<div class="text_box content">
					<div class="blsjj">
						<h1><spring:message code="sys.client.investBidManage.companyProfile"/><!-- 公司简介 --></h1>
						${enterprise.company_profile }
					</div>
					<div class="blsjj">
						<h1><spring:message code="sys.client.company.base.message"/><!-- 基本信息 --></h1>
						<ul>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span><input value="${enterprise.enterprise_name }"  type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input value="${enterprise.fixed_phone }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.legalPersonName"/><!-- 法定代表人 -->：</span><input value="${enterprise.legal_name }" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input value="${enterprise.license_no }"
										type="text" class="text_gary w300 fl" />
									<!-- <div class="checkbox">
										<input type="checkbox" />我是三证合一企业
									</div> -->
									<i></i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.orgCodeNo"/><!-- 机构代码证号 -->：</span><input value="${enterprise.org_code_no }" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.taxNo"/><!-- 税务登记号 -->：</span><input value="${enterprise.tax_no }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.financeNo"/><!-- 财务登记证 -->：</span><input value="${enterprise.finance_no }"
										type="text" class="text_gary w600" />
								</div></li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.register.province.area"/><!-- 注册省份地区 -->：</span> 
									<input value="${provinceName }" type="text" class="text_gary w160" />
								    <input value="${cityName }" type="text" class="text_gary w160" /> 
								    <input value="${areaName }" type="text" class="text_gary w160" />
								</div>
							</li>

							<li><div class="input_box">
									<span><spring:message code="sys.client.register.address"/><!-- 注册地址 -->：</span><input value="${enterprise.address_ }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bussiness.scope"/><!-- 经营范围 -->：</span><input value="${enterprise.bussiness_scope }" type="text"
										class="text_gary w600" />
								</div></li>
						</ul>
					</div>
				</div>
				<div class=" content" style="display: none;">
					<div class="table_con table_border m20">
						<table width="100%">
							<tr>
								<th class="w100"><spring:message code="sys.client.no"/><!-- 序号 --></th>
								<th class="w300"><spring:message code="sys.client.factor"/><!-- 保理商名称 --></th>
								<th><spring:message code="sys.client.financeAmount"/><!-- 融资金额/万 --></th>
								<th class="w100"><spring:message code="sys.client.financeApplyTime"/><!-- 融资日期 --></th>
								<th><spring:message code="sys.client.loanPeriod"/><!-- 融资期限/月 --></th>
								<th><spring:message code="sys.client.repaymentTime"/><!-- 还款日期 --></th>
								<th><spring:message code="sys.client.repaymentType"/><!-- 还款方式 --></th>
								<th><spring:message code="sys.client.factorType"/><!-- 保理类型 --></th>
								<th><spring:message code="sys.client.investBidManage.RepaymentStatus"/><!-- 还款状态 --></th>
							</tr>
							<c:forEach var="enterprises" items="${list}" varStatus="index" >
							<tr>
								<td>${index.count}</td>
								<td>${enterprises.enterprise_name_fact}</td>
								<!-- ${enterprises.factoring_member_id} -->
								<td><fmt:formatNumber value="${enterprises.apply_amount /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
								<td>
									<jsp:useBean id="dateValue" class="java.util.Date" />
									<jsp:setProperty name="dateValue" property="time" value="${enterprises.created_time}" />
									<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
								</td>
								<td>${enterprises.loan_period }</td>
								<td>
									<jsp:useBean id="dateValue1" class="java.util.Date" />
									<jsp:setProperty name="dateValue1" property="time" value="${enterprises.repayment_date}" />
									<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd" />
								</td>
								<td><spring:message code="sys.client.product.OneTimePayment"/></td>
								<td>
									<c:if test="${enterprises.factor_type == 'online_factor'}"><spring:message code="sys.client.online.clear.facte"/><!-- 明保理 --></c:if>
									<c:if test="${enterprises.factor_type == 'dark_factor'}"><spring:message code="sys.client.dark.facte"/><!-- 暗保理 --></c:if>
								</td>
								<td>
									<c:if test="${enterprises.repayment_date_real <= enterprises.repayment_date }">
										<spring:message code="sys.client.investBidManage.NormalRepayment"/><!-- 正常还款 -->
									</c:if>
									<c:if test="${enterprises.repayment_date_real > enterprises.repayment_date }">
										<spring:message code="sys.client.investBidManage.OverdueRepayment"/><!-- 逾期 -->
									</c:if>
									<c:if test="${enterprises.repayment_date_real == '' }">
										<spring:message code="sys.client.investBidManage.Outstanding"/><!-- 未还款 -->
									</c:if>
								</td>
							</tr>
							</c:forEach>
						</table>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>