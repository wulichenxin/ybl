<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<title><spring:message code="sys.v2.client.contract.details" /></title>
	<!-- 保理商首页 -->
	<%@include file="/ybl/v2/admin/common/link.jsp" %>
	<link href="/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:if test="${userType == 'enterprise' }">
	v2_top_bg v2_t_bg1
	</c:if>
	<c:if test="${userType == 'factor' }">
	v2_top_bg v2_t_bg2
	</c:if>
	<c:if test="${userType == 'supplier' }">
	v2_top_bg 
	</c:if>
<div class="<c:if test="${userType == 'enterprise' }">
	v2_top_bg v2_t_bg1
	</c:if>
	<c:if test="${userType == 'factor' }">
	v2_top_bg v2_t_bg2
	</c:if>
	<c:if test="${userType == 'supplier' }">
	v2_top_bg 
	</c:if> h116">
	<div class="v2_top_con">
		<div class="v2_head_top">
	<!--top start -->
	<c:if test="${userType == 'enterprise' }">
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	</c:if>
	<c:if test="${userType == 'factor' }">
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	</c:if>
	<c:if test="${userType == 'supplier' }">
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	</c:if>
	<!--top end -->
	</div>
	</div>
	</div>
	<div class="v2_vip_conbody">
		<div class="v2_path_no"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.contract" /> > <spring:message code="sys.v2.client.contract.details" /></div>
		<div class="v2_box_border mt20">
			<form action="/contract/contractAddSave" id="contractAddSave" method="post">
			<input type="hidden" name="id" value="${contract.id }">
			<div class="v2_tab_con">
				<div class="v2_text_box">
					<h1><spring:message code="sys.v2.client.base.message" /></h1>
					<div class="clear"></div>
					<ul>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.number" />：</span><input type="text" name="number" value="${contract.number }"
									class="w300 v2_text" readonly="readonly" /><i>*</i>
							</div></li>

						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.efficient.date" />：</span>
								<div class="v2_date">
									<input id="beginTime" name="beginTime" value="<fmt:formatDate value='${contract.beginTime }' pattern='yyyy-MM-dd'/>" type="text" class="w120 v2_text" readonly="readonly" /><a
										id="begin_time_a" class="v2_date_text_ico"></a>
								</div>
								<b><spring:message code="sys.v2.client.to" /></b>
								<div class="v2_date">
									<input id="endTime" name="endTime" value="<fmt:formatDate value='${contract.endTime }' pattern='yyyy-MM-dd'/>" type="text" class="w120 v2_text"  readonly="readonly"/><a
										id="end_time_a" class="v2_date_text_ico"></a>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.supplier" />：</span>
								<div class="v2_i_seach">
									<input type="hidden" id="supplierEnterpriseId" name="supplierEnterpriseId" value="${supplierEnterprise.id }">
									<input id="supplierEnterpriseName" name="supplierEnterpriseName" value="${supplierEnterprise.enterpriseFullName }" type="text" readonly="readonly" class="w300 v2_text validate[required]" /><a
										href="javascript:void(0);" class="v2_i_seach_ico"></a>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.credit.quota" />：</span><input name="creditAmount" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.creditAmount }' />" type="text"
									class="w300 v2_text fl validate[required,custom[number]]" readonly="readonly" /><b><spring:message code="sys.v2.client.contract.yuan" /></b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.core.enterprise" />：</span>
								<div class="v2_i_seach">
									<input type="hidden" id="coreEnterpriseId" name="coreEnterpriseId" value="${coreEnterprise.id }">
									<input id="coreEnterpriseName" readonly="readonly" name="coreEnterpriseName" value="${coreEnterprise.enterpriseFullName }" type="text" class="w300 v2_text validate[required]"  readonly="readonly"/><a
										href="javascript:void(0);" class="v2_i_seach_ico"></a>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.fund.source" />：</span>
								<div class="v2_select_box">
									<select id="fundsSourceId" name="fundsSourceId" class="v2_select w200 fl" disabled="disabled">
										<option>${fundSource.name }</option>
									</select>
								</div>
								<i>*</i>
							</div></li>
						<li class="clear"><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.person" />：</span><input name="contractPerson" value="${contract.contractPerson }" type="text"
									class="w300 v2_text" readonly="readonly" />
							</div></li>
					</ul>
				</div>
				<div class="clear"></div>
				<div class="v2_text_box">
					<h1><spring:message code="sys.v2.client.contract.supplier.settlement" /></h1>
					<ul>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.proportion" />：</span>
								<input name="settlementRatio" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.settlementRatio }' />" type="text" class="w300 v2_text fl validate[required,custom[number]]" readonly="readonly" /><b>%</b><i>*</i>
							</div>
						</li>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.time" />：</span><b>T+</b><input name="settlementTime" value="${contract.settlementTime }" type="text"
									class="w200 v2_text fl validate[required,custom[number]]" readonly="readonly" /><b><spring:message code="sys.v2.client.contract.day" />(<spring:message code="sys.v2.client.contract.t" />)</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.factoring.rate" />：</span><input name="factoringFees" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.factoringFees }' />" type="text"
									class="w300 v2_text fl validate[required,custom[number]]"  readonly="readonly"/><b>%</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.loanRate" />：</span><input name="lendingRates" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.lendingRates }' />" type="text"
									class="w300 v2_text fl validate[required,custom[number]]" readonly="readonly"/><b>%</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.type" />：</span>
								<div class="v2_select_box">
									<select class="v2_select w320 validate[required]" name="settlementType" url="/configController/get-CONTRACT_SETTLEMENT_TYPE"
										valueFiled="code_" textField="value_"
										defaultValue="${contract.settlementType }" isSelect="Y" disabled="disabled" ></select>
								</div>
								<i>*</i>
							</div></li>
					</ul>
				</div>
				<div class="clear"></div>
				<div class="v2_but_list">
					<a class="bg_l" href="javascript:history.back(-1);" class="bg_g"><spring:message code="sys.v2.client.return" /></a>
				</div>
			</div>
			</form>
		</div>
	</div>

	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp" %>
	<!-- bottom.jsp -->
	
</body>
</html>