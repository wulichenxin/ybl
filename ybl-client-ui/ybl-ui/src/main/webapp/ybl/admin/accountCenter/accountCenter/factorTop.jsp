<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!-- 保理商头部 -->
	<div class="head">
		<div class="top_head">
			<div class="logo">
				<a href="javascript:void(0)"></a>
			</div>
			<div class="nav">
				<ul>
					<li <c:if test="${step==7}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.customer.manage"/><b></b></span></a><!-- 客户管理 -->
							<div class="navmenu-list none">
								<ul>
									<li><a href="/signController/myCustomer">
											<spring:message code="sys.client.sign.manage"/><!-- 签约管理 -->
										</a></li>
									<li><a href="/myCustomerController/myCustomer?status_=signed">
										<spring:message code="sys.client.myCustomer"/><!-- 我的客户 -->
									</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==6}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.bid.manage"/><b></b></span></a><!-- 竞投管理 -->
							<div class="navmenu-list none">
								<ul>
									<li><a href="/bidController/queryAllLoanSignBid">
										<spring:message code="sys.client.want.bid"/><!-- 我要竞投 -->
									</a></li>
									<li><a href="/bidController/investManage">
										<spring:message code="sys.client.bid.manage"/><!-- 竞投管理 -->
									</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==5}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.risk.manage"/><!-- 风控管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/ProductAuditController/queryRiskList">
										<spring:message code="sys.client.loan.audit"/><!-- 贷款审核 -->
									</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==4}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.financeManage"/><!-- 财务管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/ProductAuditController/queryFinanceList">
										<spring:message code="sys.client.financeAudit"/><!-- 财务审核 -->
									</a></li>
									<li><a href="/ProductAuditController/queryPayList">
										<spring:message code="sys.client.payManage"/><!-- 出账管理 -->
									</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==3}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.loan.manage"/><!-- 贷款管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/loanController/queryAllLoan">
										<spring:message code="sys.client.repay.manage"/><!-- 还款管理 -->
									</a></li>
									<li><a href="/loanController/queryAllOverdue?isOverdue=1">
										<spring:message code="sys.client.overdue.manage"/><!-- 逾期管理 -->
									</a></li>
									<li><a href="/loanController/queryAllDrawback">
										<spring:message code="sys.client.reimburse.manage"/><!-- 退款管理 -->
									</a></li>
									<li><a href="/loanController/queryAllProject">
										<spring:message code="sys.client.project.manage"/><!-- 项目管理 -->
									</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==2}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.product.factory"/><!-- 产品工厂 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/productManageController/queryAllProduct">
									<spring:message code="sys.client.product.manage"/><!-- 产品管理 --></a></li>
								</ul>
							</div>
						</div>
					</li>
					<li <c:if test="${step==1}">class="now"</c:if>>
						<div class="navmenu">
							<a><span><spring:message code="sys.client.user.manage"/><!-- 用户管理 --><b></b></span></a>
							<div class="navmenu-list none">
								<ul>
									<li>
										<a href="/roleController/list.htm">
											<spring:message code="sys.client.job.manage"/><!-- 岗位管理 -->
										</a>
									</li>
									<li>
										<a href="/UserController/findUsersByCertRole?certRole=${type}">
											<spring:message code="sys.client.employee.manage"/><!-- 员工管理 -->
										</a>
									</li>
									<li>
										<a href="/departmentController/depetManage">
											<spring:message code="sys.client.dept.manage"/><!-- 部门管理 -->
										</a>
									</li>
									<li>
										<a href="/permissionController/list.htm">
											<spring:message code="sys.client.premission.manage"/><!-- 操作权限管理 -->
										</a>
									</li>
									<li>
										<a href="/menuController/list.htm">
											<spring:message code="sys.client.menu.manage"/><!-- 菜单管理 -->
										</a>
									</li>
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