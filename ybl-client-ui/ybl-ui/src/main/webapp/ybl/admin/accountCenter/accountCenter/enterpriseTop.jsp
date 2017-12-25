<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!--核心企业头部  -->
	<div class="head">
		<div class="top_head">
			<div class="logo">
				<a href="javascript:void(0)"></a>
			</div>
			<div class="nav">
				<ul>

					<li <c:if test="${step==2}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.credit.manage"/><!-- 授信管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="#">  <%-- ${app.staticResourceUrl}/ybl/admin/enterprise/creditLimit.jsp --%>
									<spring:message code="sys.client.amount.limit"/><!-- 额度授信 --></a></li>
									<li><a href="#"><spring:message code="sys.client.name.list.manage"/><!-- 名单管理 --></a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==1}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.voucher.manage"/><!-- 凭证管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/voucherAudit/voucherConfirm">
									<spring:message code="sys.client.credit.sure"/><!-- 凭证确认 --></a></li>
									<li><a href="/voucherAudit/loanStatus">
									<spring:message code="sys.client.loan.status"/><!-- 贷款状态 --></a></li>
								</ul>
							</div>
						</div>
					</li>

					<li <c:if test="${step==0}">class="now"</c:if>>
						<div class="navmenu">
							<a href="/accountOverview/queryAccountOverview">
								<span><spring:message code="sys.client.account.center"/><b></b></span><!-- 账户中心 -->
							</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			/* ABGIN我的菜单 */
			$('.navmenu').mouseover(function() {
				$(this).find('.navmenu-list').slideDown();
			}).mouseleave(function() {
				$(this).find('.navmenu-list').slideUp();
			});
			/* END我的菜单 */
		});
	</script>