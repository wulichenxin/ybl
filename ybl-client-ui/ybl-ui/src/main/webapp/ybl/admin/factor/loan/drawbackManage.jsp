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
<title><spring:message code="sys.client.reimburse.manage"/></title><!-- 还款管理 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
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
		$("#member_factor_RepayManage_query_btn").click(function(){
			$("#pageForm").submit();
		})
		//重置
		$("#reset").click(function(){
			$("#number").val('');
			$("#name").val('');
			$("#drawback_status").val('');
		})
	})
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->

	<div class="path"><spring:message code="sys.client.location"/><!-- 当前位置 -->-><spring:message code="sys.client.loan.manage"/><!-- 贷款管理 --> -> <spring:message code="sys.client.reimburse.manage"/><!-- 退款管理 --></div>
	<form action="/loanController/queryAllDrawback" id="pageForm" method="post">
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.loan.number"/><!-- 融资编号 -->:</label><input type="text" name="number" id="number" value="${number }"/></li>
					<li><label><spring:message code="sys.client.clientName"/><!-- 客户名称 -->:</label><input type="text" name="name" id="name" value="${name }"/></li>
					<li><label><spring:message code="sys.client.refundStatus"/><!-- 还款状态 -->:</label>
						<select name="drawback_status" id="drawback_status">
							<option value="all"><spring:message code="sys.client.queryAll"/><!-- 全部 --></option>
							<option <c:if test="${drawback_status=='processing' }">selected="selected" </c:if> value="processing">待退款</option>
							<option <c:if test="${drawback_status=='done' }">selected="selected" </c:if> value="done">已退款</option>
						</select>
					</li>
					<li><div class="button_yellow">
							<sun:button tag='a' id='member_factor_RepayManage_query_btn' i18nValue='sys.client.query' />
						</div></li>
					<li><div class="button_gary">
							<a id="reset"><spring:message code="sys.client.reset"/><!-- 重置 --></a>
						</div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box ">

			<!--按钮top-->
			<div class="table_con ">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><spring:message code="sys.client.no"/><!-- 序号 --></th>
						<th><spring:message code="sys.client.loan.number"/><!-- 贷款编号 --></th>
						<th><spring:message code="sys.client.projectName"/><!-- 项目名称 --></th>
						<th><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
						<th><spring:message code="sys.client.loanMoney"/><!-- 贷款金额 --></th>
						<th><spring:message code="sys.client.financingProportion"/><!-- 贷款比例 --></th>
						<th><spring:message code="sys.client.amountOfTheAccount"/><!-- 出账金额 --></th>
						<th><spring:message code="sys.client.amountOfMoneyBack"/><!-- 回款金额 --></th>
						<th><spring:message code="sys.client.amountToBeRefunded"/><!-- 待退款金额 --></th>
						<th><spring:message code="sys.client.RefundAmount"/><!-- 已退款金额 --></th>
						<th><spring:message code="sys.client.ActualRepaymentDate"/><!-- 实际还款日期 --></th>
						<th><spring:message code="sys.client.refundStatus"/><!-- 退款状态 --></th>
						<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
					</tr>
					<c:forEach var="bid" items="${list}" varStatus="index" >
					<c:if test="${bid.back_amount  > '0.0000' || bid.back_amount  == '0.0000'}">
					<tr>
						<td>${index.count}</td>
						<td><a class="lan" href="/ProductAuditController/queryDetail?id=${bid.finance_apply_id }&step=3">${bid.number_ }</a></td>
						<td>${bid.name_ }</td>
						<td>${bid.enterprise_name }</td>
						<td><fmt:formatNumber value="${bid.apply_amount  /10000}" pattern="#,##0.00" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber value="${bid.finance_ratio }" pattern="#,##0.00" maxFractionDigits="2"/>%</td>
						<td><fmt:formatNumber value="${bid.disbursement_amount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td><fmt:formatNumber value="${bid.actual_amount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td><fmt:formatNumber value="${bid.back_amount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td><fmt:formatNumber value="${bid.real_back_amount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${bid.repayment_date_real }" />
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
						</td>
						
						<td>
							<c:if test="${bid.back_amount / 10000 == '0.0000' }">已退款</c:if>
							<c:if test="${bid.back_amount / 10000  > '0.0000'}">待退款</c:if>
						</td>
						<td>

							<c:if test="${bid.back_amount / 10000 == '0.0000' }"><a class="lan" href="/ProductAuditController/queryDetail?id=${bid.finance_apply_id }&step=3">详情</a></c:if>
							<c:if test="${bid.back_amount / 10000 > '0.0000'}"><a class="lan" href="/loanController/getDrawbackDetail?id=${bid.finance_apply_id }"><spring:message code="sys.client.Refunds"/><!-- 退款 --></a></c:if>
						</td>
						
					</tr>
					</c:if>
					</c:forEach>
				</table>

			</div>
			<jsp:include page="../../common/page.jsp"></jsp:include>
		</div>


	</div>
	<!--table-->
	</div>
	</form>

	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>