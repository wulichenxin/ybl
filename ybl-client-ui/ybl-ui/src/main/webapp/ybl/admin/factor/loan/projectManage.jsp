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
<title><spring:message code="sys.client.project.manage"/></title><!-- 项目管理 -->
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
		$("#member_factor_ProjectManage_query_btn").click(function(){
			$("#pageForm").submit();
		})
		//重置
		$("#reset").click(function(){
			$("#number").val('');
			$("#name").val('');
		})
	})
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/><!-- 当前位置 -->-><spring:message code="sys.client.loan.manage"/><!-- 贷款管理 --> -><spring:message code="sys.client.project.manage"/> <!-- 项目管理 --></div>
	<form action="/loanController/queryAllProject" id="pageForm" method="post">
	<div class="vip_conbody">

		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.loan.number"/><!-- 融资编号 -->:</label><input type="text" name="number" value="${number }"/></li>
					<li><label><spring:message code="sys.client.clientName"/><!-- 客户名称 -->:</label><input type="text" name="name" value="${name }"/></li>
					
					<li><div class="button_yellow">
							<sun:button tag='a' id='member_factor_ProjectManage_query_btn' i18nValue='sys.client.query' />
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
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a><spring:message code="sys.client.investBidManage.ProjectList"/><!-- 项目列表 --></a>
					</dd>
				</dl>
			</div>
			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="100"><spring:message code="sys.client.no"/><!-- 序号 --></th>
						<th><spring:message code="sys.client.loan.number"/><!-- 贷款编号 --></th>
						<th><spring:message code="sys.client.projectName"/><!-- 项目名称 --></th>
						<th><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
						<th><spring:message code="sys.client.phone"/><!-- 联系电话 --></th>
						<th><spring:message code="sys.client.loanMoney"/><!-- 贷款金额 --></th>
						<th><spring:message code="sys.client.yearRate"/><!-- 年利率 --></th>
						<th><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 --></th>
						<th><spring:message code="sys.client.factorType"/><!-- 保理类型 --></th>
						<th><spring:message code="sys.client.operation"/><!-- 操作 --></th>
					</tr>
					<c:forEach var="bid" items="${list}" varStatus="index" >
					<tr>
						<!-- <td><input type="checkbox" /></td> -->
						<td>${index.count}</td>
						<td><a class="lan" href="/ProductAuditController/queryDetail?id=${bid.finance_apply_id }&step=3">${bid.number_ }</a></td>
						<td>${bid.name_ }</td>
						<td>${bid.enterprise_name }</td>
						<td>${bid.legal_phone}</td>
						<td><fmt:formatNumber value="${bid.apply_amount  /10000}" pattern="#,##0.00" maxFractionDigits="2"/>万元</td>
						<td><fmt:formatNumber value="${bid.rate_ }" pattern="#,##0.00" maxFractionDigits="2"/></td>
						<td>${bid.loan_period }&nbsp;
							<c:if test="${bid.period_type == 'day'}"><spring:message code="sys.client.day"/></c:if>
							<c:if test="${bid.period_type == 'month'}"><spring:message code="sys.client.month"/></c:if>
							<c:if test="${bid.period_type == 'year'}"><spring:message code="sys.client.year"/></c:if>
						</td>
						<td>
							<c:if test="${bid.factor_type == 'dark_factor'}"><spring:message code="sys.client.dark.facte"/></c:if>
							<c:if test="${bid.factor_type == 'online_factor'}"><spring:message code="sys.client.online.clear.facte"/></c:if>
						</td>
						<td><div class="but_but">
								<a><spring:message code="sys.client.investBidManage.toFinance"/><!-- 去融资 --></a>
							</div>
						</td>
					</tr>
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