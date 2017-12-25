<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!-- 供应商头部 -->
	<div class="head">
		<div class="top_head">
			<div class="logo">
				<a href="javascript:void(0)"></a>
			</div>
			<div class="nav">
				<ul>
					<li <c:if test="${step==3}">class="now"</c:if>>
						<div class="navmenu">
							<a  href="javascript:void(0);">
							<span><spring:message code="sys.client.financeApply"/><!-- 融资申请 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/facteServiceController/facteService"><spring:message code="sys.client.facte.service"/><!-- 保理服务 --></a></li>
									<li><a href="/loanApplicationController/loanApplication"><spring:message code="sys.client.loan.apply"/><!-- 贷款申请 --></a></li>
									<li><a href="/voucherController/voucherManage"><spring:message code="sys.client.voucher.manage"/><!-- 凭证管理 --></a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==2}">class="now"</c:if>>
						<div class="navmenu">
							<a href="javascript:void(0);"><span><spring:message code="sys.client.subject.manage"/><!-- 标的管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/subjectController/subjectList"><spring:message code="sys.client.common.subject.manage"/><!-- 普通标管理 --></a></li>
									<li><a href="/subjectController/subjectList?step=bid_subject"><spring:message code="sys.client.bid.subject.manage"/><!-- 竞标管理 --></a></li>
									<li><a href="/subjectController/subjectList?step=fail_subject&status='fail_subject'"><spring:message code="sys.client.fail.subject.manage"/><!-- 流标管理 --></a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==1}">class="now"</c:if>>
						<div class="navmenu">
							<a href="javascript:void(0);"><span><spring:message code="sys.client.financing.manage"/><!-- 融资管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/financeApplyController/loanEdit"><spring:message code="sys.client.loan.message"/><!-- 贷款信息 --></a></li>
									<li><a href="/repaymentController/repayment"><spring:message code="sys.client.repay.manage"/><!-- 还款管理 --></a></li>
									<%-- <li><a href="${app.staticResourceUrl}/ybl/admin/supplier/finance/refund.jsp">退款管理</a></li> --%>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==0}">class="now"</c:if>>
						<div class="navmenu">
							<a href="/accountOverview/queryAccountOverview" >
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