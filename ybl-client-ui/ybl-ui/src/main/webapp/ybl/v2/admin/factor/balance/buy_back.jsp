<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.v2.client.buyback" /></title>
<!-- 回购 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<!-- 检验文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>

<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/v2/js/buy_back.js"></script>

</head>
<body>
	<div class="v2_top_bg v2_t_bg2 h165">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp" %>
				<div class="v2_z_nav">
					<div class="v2_z_nav_con">
						<div class="v2_z_navbox">
							<a href="/v2disbursementController/queryGenerateBatchList.htm">
								<spring:message code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 -->
							</a><a class="w150"
								href="/v2repaymentController/queryEnterprisePaymentList.htm">
								<spring:message code="sys.v2.client.enterprise.repayment" /> <!-- 核心企业回款 -->
							</a><a class="w130 now" href="javascript:void(0);"> <spring:message
									code="sys.v2.client.supplier.buyback" /> <!-- 供应商回购 -->
							</a><a href="/v2BalanceController/queryRefundProcessList.htm"> <spring:message
									code="sys.v2.client.refund.process" /> <!-- 退款处理 -->
							</a><a href="/v2BalanceController/queryPlatformReconList.htm"> <spring:message
									code="sys.v2.client.platform.recon" /> <!-- 平台对账 --></a>
						</div>
					</div>
				</div>
			</div>
			<!--搜索条件-->
		</div>
	</div>
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：结算中心 >  供应商回购 >  回购 -->
			<spring:message code="sys.v2.client.location" />
			：
			<spring:message code="sys.v2.client.settlement.mamage" />
			>
			<spring:message code="sys.v2.client.supplier.buyback" />
			>
			<spring:message code="sys.v2.client.buyback" />
		</div>
		<div class="v2_box_border mt20">

			<div class="v2_tab_con">
				<div class="v2_text_box_g h200">
					<ul>
						<li><span><spring:message
									code="sys.v2.client.supplier" /> <!-- 供应商 -->：</span>${repaymentRecord.supplierEnterpriseName }</li>
						<li><span><spring:message
									code="sys.v2.client.core.enterprise" /> <!-- 企业 -->：</span>${repaymentRecord.coreEnterpriseName }</li>
						<li ><span><spring:message
									code="sys.v2.client.account.voucher" /> <!-- 账款凭证 -->：</span>${repaymentRecord.number }</li>
						<li class="clear"><span><spring:message
									code="sys.v2.client.plan.return.date" /> <!-- 计划回款日 -->：</span> <fmt:formatDate
								value="${repaymentRecord.repaymentDate}" pattern="yyyy-MM-dd" /></li>

						<li><span><spring:message
									code="sys.v2.client.actual.return.date" /> <!-- 实际回款日 -->：</span> <fmt:formatDate
								value="${repaymentRecord.payTime}" pattern="yyyy-MM-dd" /></li>
									
						<li class="clear"><span><spring:message
									code="sys.v2.client.repayment.status" /> <!-- 回款状态 -->：</span> <span
							url="/configController/get-REPAYMENT_STATUS/${repaymentRecord.status}"
							textField="value_"> </span></li>

						<li><span><spring:message
									code="sys.v2.client.buyback.status" /> <!-- 回购状态 -->：</span> <span
							url="/configController/get-BUYBACK_STATUS/${balance.buybackStatus}"
							textField="value_"> </span></li>
						<li ><span><spring:message
									code="sys.v2.client.voucher.amount" /> <!-- 凭证面额 -->：</span><b
							class="f16 green"><fmt:formatNumber pattern="#,##0.00"
									value="${ balance.voucherAmount }" /></b>
						<spring:message code="sys.v2.client.element" /></li>

						

						<li class="clear"><span><spring:message
									code="sys.v2.client.settlementAmount" /> <!-- 结算金额 -->：</span><b
							class="f16 green"> <fmt:formatNumber pattern="#,##0.00"
									value="${repaymentRecord.amount }" /></b>
						<spring:message code="sys.v2.client.element" /></li>
						<li class="v2_back_je"><div class="je">
								<span><i></i> <spring:message
										code="sys.v2.client.amountOfMoneyBack.already" /> <!-- 已回款金额 -->：</span><b
									class="f16 lan"><fmt:formatNumber pattern="#,##0.00"
										value="${repaymentRecord.actualAmount}" /></b>
								<spring:message code="sys.v2.client.element" />
								<div class="v2_table_con1 v2_back_xx w800"> 
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<th width="50"><spring:message code="sys.v2.client.no" />
											<!-- 序号 --></th>
										<th><spring:message code="sys.v2.client.buyback.date" />
											<!-- 回款日期 --></th>
										<th><spring:message code="sys.v2.client.amountOfBuyback" />
											<!-- 回款金额（元 --></th>
										<th><spring:message
												code="sys.v2.client.trade.stream.number" /> <!-- 交易流水号 --></th>
										<th><spring:message code="sys.v2.client.remark" /> <!-- 备注 --></th>
										<th><spring:message code="sys.v2.client.operator" /> <!-- 操作人 --></th>
									</tr>
									<c:forEach items="${resultList}" var="data" varStatus="index">
										<tr>
											<td>${index.count}</td>
											<td><fmt:formatDate value="${data.payTime}"
													pattern="yyyy-MM-dd" /></td>
											<td class="tr"><fmt:formatNumber pattern="#,##0.00"
													value="${data.amount}" /></td>
											<td>${data.trxNumber}</td>
											<td>${data.comment}</td>
											<td>${data.userName}</td>
										</tr>
									</c:forEach>
								</table>
							</div>
							</div>
							</li>
						<li><span><spring:message
									code="sys.v2.client.amountOfBuyback" /> <!-- 已回购金额 -->：</span><b
							class="f16 lan"> <fmt:formatNumber pattern="#,##0.00"
									value="${balance.actualBuybackAmount }" /></b>
						<spring:message code="sys.v2.client.element" /></li>
						<li class="clear"><span><spring:message
									code="sys.v2.client.amountOfMoneyBack.pending" /> <!-- 待回款金额 -->：</span>
							<b class="f16 red"><fmt:formatNumber pattern="#,##0.00"
									value="${repaymentRecord.amount - repaymentRecord.actualAmount > 0 ? (repaymentRecord.amount - repaymentRecord.actualAmount) : 0}" /></b>
						<spring:message code="sys.v2.client.element" /></li>

						<li><span><spring:message
									code="sys.v2.client.amountOfBuybacked" /> <!-- 待回款金额 -->：</span> <b
							class="f16 red"><fmt:formatNumber pattern="#,##0.00"
									value="${balance.toBuybackAmount}" /></b>
						<spring:message code="sys.v2.client.element" /></li>


					</ul>
				</div>
				<div class="v2_text_box">
					<ul>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.buyback.date" />
									<!-- 回购日期 -->：</span>
								<div class="v2_date">
									<input id="payTime" placeholder="" type="text"
										class="w300 v2_text validate[required]" />
									<div id="payTime_a" class="v2_date_text_ico">
										<a></a>
									</div>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message
										code="sys.v2.client.trade.stream.number" /> <!-- 交易流水号 -->：</span><input
									id="trxNumber" placeholder="" type="text"
									class="w300 v2_text validate[required]" /><i>*</i>
							</div></li>
					</ul>
				</div>
				<div class="v2_but_list">
					<c:if test="${ balance.toBuybackAmount  > 0 }">
						<sun:button id="v2_single_buyback_save" tag='a' clazz="bg_l" i18nValue="sys.v2.client.save" />
					</c:if>
					<a class="bg_l" id="processing_btn" style="display:none"><spring:message code="sys.v2.client.processing" /></a>
					<a class="bg_g" id="return"><spring:message code="sys.v2.client.return" /> <!-- 返回 --></a>
				</div>
			</div>
		</div>
	</div>

	<!-- 其他参数 -->
	<input id="buybackId" type="hidden" value="${balance.buybackId }" />


	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
	<script type="text/javascript">
		$(function() {
			$(".je").mousemove(function() {
				$(".v2_back_xx").slideDown();
			});
			$(".je").mouseleave(function() {
				$(".v2_back_xx").slideUp();
			});
		});
	</script>
</body>
</html>
