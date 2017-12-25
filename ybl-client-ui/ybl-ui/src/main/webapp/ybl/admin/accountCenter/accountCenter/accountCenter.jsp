<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
	<title><spring:message code="sys.client.account.center"/></title><!-- 账户中心 -->
	 <jsp:include page="../../common/link.jsp" />
	<script language='javascript'
		src="${app.staticResourceUrl}/ybl/resources/js/accountCenter/accountCenter.js"></script>
	<style type="text/css">
		.should_hidden{display:none;}
		.should_block{display:block;}
		.zhxx_right_a_{display:inline-block !important;}
	</style>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=0" />
	<!--top end -->
	<div class="path"><!-- 当前位置->账户中心 -> 账户总览 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.account.center"/>-> 
		<spring:message code="sys.client.account.overview"/>
	</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con start-->
		<div class="vip_concon">
			<!-- 所有共有的内容 end -->
			<div class="vip_r_con vborder">
				<input type='hidden' value="${user_session.userName}" id='userName'/>
				<input type='hidden' value="${user_session.id}" id='userId'/>
				<input type='hidden' value="${user_session.enterpriseId}" id='enterpriseId'/>
				<input type='hidden' value="${type}" id='certRole'/>
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.person.message"/><!-- 个人信息 -->
					</h1>
				</div>
				<div class="v_basic">
					<!--1-->
					<div class="v_basic_xx">
						<ul>
							
							<li>
								<div class="vip_xx">
									<spring:message code="sys.client.member.nickname"/>：<!-- 用户昵称-->
									<span id='nickNameSpan'>${user_session.nickName}</span>
								</div>
							</li>
							<li><div class="vip_zt">
									<c:if test="${user_session.nickName==null || user_session.nickName==''}">
										<span class="ysz_bg wsz_ico"></span>
										<a><spring:message code="sys.client.no.set"/></a><!-- 未设置 -->
								</c:if>
									<c:if test="${user_session.nickName!=null && user_session.nickName!=''}">
										<span class="ysz_bg ysz_ico"></span>
										<a><spring:message code="sys.client.already.set"/></a><!-- 已设置 -->
								</c:if>
								</div></li>
							<!-- <li class="w160">&nbsp;</li> -->
							<li><c:if test="${user_session.nickName==null || user_session.nickName==''}">
									<sun:button tag='a' id='member_center_nickName_edit_btn'
										clazz='lan' i18nValue='sys.client.immediately.set' />
										<!--立即设置 -->
								</c:if> <c:if test="${user_session.nickName!=null && user_session.nickName!=''}">
									<sun:button tag='a' id='member_center_nickName_edit_btn'
										clazz='lan' i18nValue='sys.client.edit' />
									<!--修改 -->
								</c:if>
								<!-- 保存 -->
								<sun:button tag='a' id='member_center_nickName_save_btn'
										clazz='lan should_hidden' i18nValue='sys.client.save' />
								<!-- 放弃修改 -->	
								<sun:button tag='a' id='member_center_nickName_quit_save_btn'
										clazz='lan should_hidden ml20' i18nValue='sys.client.quit.edit' />
							</li>
						</ul>
					</div>
					<!--1over-->
					<!--1-->
					<div class="v_basic_xx">
						<ul>
							<li><div class="vip_xx">
								<spring:message code="sys.client.login.password"/>：<!-- 登录密码-->
								<span><spring:message code="sys.client.ensure.account.security.change.password"/>
								<!-- 保障账户安全，建议您定期更换密码。 --></span>
								</div></li>
							<li><div class="vip_zt">
									<span class="ysz_bg ysz_ico"></span>
									<a><spring:message code="sys.client.already.set"/></a><!-- 已设置 -->
								</div></li>
							<!-- <li class="w160">&nbsp;</li> -->
							<li><sun:button tag='a' id='member_center_password_edit_btn'
									clazz='lan' i18nValue='sys.client.edit' />
								<!--修改 --></li>
						</ul>
					</div>

					<!--1over-->
					<!--1-->
					<div class="v_basic_xx">
						<ul>
							
							<li><div class="vip_xx">
									<spring:message code="sys.client.phone"/>：<!-- 手机号码-->
									<span id='telephoneSpan'>${user_session.telephone}</span>
									<!-- 保障账户与资金安全，是您在云保理平台重要的身份凭证。 -->
								</div></li>
							<li><div class="vip_zt">
									<span class="ysz_bg ysz_ico"></span>
									<a><spring:message code="sys.client.already.set"/></a><!-- 已设置 -->
								</div></li>
							<!-- <li class="w160">&nbsp;</li> -->
							<li><sun:button tag='a' id='member_center_phone_edit_btn'
									clazz='lan' i18nValue='sys.client.edit' />
								<!--修改 -->
								<!-- 保存 -->
								<sun:button tag='a' id='member_center_phone_save_btn'
										clazz='lan should_hidden' i18nValue='sys.client.save' />
								<!-- 放弃修改 -->	
								<sun:button tag='a' id='member_center_phone_quit_save_btn'
										clazz='lan should_hidden ml20' i18nValue='sys.client.quit.edit' />
							</li>
								
						</ul>
					</div>
					<!--1over-->
					<!--1-->
					<div class="v_basic_xx">
						<ul>
							<li><div class="vip_xx">
								<spring:message code="sys.client.email.bind"/>：<!-- 邮箱绑定-->
								<span>${user_session.email}</span>
									<!-- 用于接收所有电子对账单。 -->
								</div></li>
							<li><div class="vip_zt">
									<c:if test="${user_session.email==null || user_session.email==''}">
										<span class="ysz_bg wsz_ico"></span>
										<a><spring:message code="sys.client.no.set"/></a><!-- 未设置 -->
								</c:if>
									<c:if test="${user_session.email!=null && user_session.email!=''}">
										<span class="ysz_bg ysz_ico"></span>
										<a><spring:message code="sys.client.already.set"/></a><!-- 已设置 -->
								</c:if>
								</div></li>
							<!-- <li class="w160">&nbsp;</li> -->
							<li><c:if test="${user_session.email==null || user_session.email==''}">
									<sun:button tag='a' id='member_center_email_edit_btn'
										clazz='lan v_yellow' i18nValue='sys.client.immediately.set' />
									<!--立即设置 -->
								</c:if> <c:if test="${user_session.email!=null && user_session.email!=''}">
									<sun:button tag='a' id='member_center_email_edit_btn'
										clazz='lan v_yellow' i18nValue='sys.client.edit' />
									<!--修改 -->
								</c:if>
						</ul>
					</div>
					<!--1over-->
				</div>
			</div>
			<!-- 所有共有的内容 end -->
			<!-- 供应商和保理商才有的内容 start  目前资金走线下，所以先隐藏该部分内容 20170608-by jinzhixian -->
			<%-- <div class="zhxx_box" style='display: none;'
				id='bank_account_message_div'>
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.bank.account.message"/><!-- 银行账号信息-->
					</h1>
				</div>
				<!--1-->
				<div class="zhxx">
					<div class="zhxx_left">
						<ul>
							<li>
							<span><spring:message code="sys.client.account.balance"/>：</span><!-- 账户余额-->
							<font class="yellow">
								<fmt:formatNumber value="${memberFund.totalAmount==''||memberFund.useableAmount==null?0.00:memberFund.useableAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</font></li>
							<!-- <li><span>银行子账户：</span><font>6787*******789</font></li> -->
						</ul>
					</div>
					<div class="zhxx_right">
						<ul>
							<li class="vip_cz" style='margin: 30px 0px 0px -30px;'><sun:button
									tag='a' id='member_center_recharge_btn'
									i18nValue='sys.client.recharge'
									href="/accountOverview/toRechargePage" clazz='zhxx_right_a_'/>
								<!--充值 --> <sun:button tag='a'
									id='member_center_withdrawals_btn'
									i18nValue='sys.client.withdrawals'
									href="/accountOverview/toWithdrawalPage" clazz='zhxx_right_a_'/>
								<!--提现 --></li>
						</ul>

					</div>
				</div>
			</div>
			<div class="zhxx_box" style='display: none;' id='bind_card_div'>
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.bind.bank.card"/><!-- 绑定银行卡 -->
					</h1>
					<span class="bk">
						<sun:button tag='a' id='member_center_bind_card_btn'
							i18nValue='sys.client.bind.card'
							href="/bankAccount/bindBankCard" />	<!-- 绑卡 -->
					</span>
				</div>
				<!--1-->
				<div class="vip_table">
					<table>
						<tr>
							<th class="w100"><spring:message code="sys.client.no"/></th><!-- 序号 -->
							<th class="w300"><spring:message code="sys.client.open.bank.name"/></th><!-- 开户行名称 -->
							<th><spring:message code="sys.client.open.bank.account"/></th><!-- 开户银行账号 -->
							<th class="w100"><spring:message code="sys.client.operation"/></th><!-- 操作 -->
						</tr>
						<c:forEach var="data" items="${bankAccountList}" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td>${data.attribute1}</td>
								<td>${data.accountNo}</td>
								<td><div class="jk">
										<sun:button tag='a' id='member_center_unbind_card_btn_${index.count}'
											i18nValue='sys.client.unlock.card'
											href="javascript:unbindCard(${data.id })" /><!-- 解卡 -->
									</div></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="zhxx_box" style='display: none;' id='month_bill_div'>
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.month.bill"/><!-- 本月账单 -->
					</h1>
					<span class="bk">
					<sun:button tag='a' id='member_center_more_bill_btn'
							i18nValue='sys.client.more.bill' />	<!-- 更多账单 -->
					</span>
				</div>
				<!--1-->
				<div class="zd">
					<ul>
						<li>
							<h2><spring:message code="sys.client.income"/><!-- 当月收入 --></h2>
							<p>
								<fmt:formatNumber value="${monthIncom==''||monthIncom==null?0.00:monthIncom/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</p>
						</li>
						<li>
							<h2><spring:message code="sys.client.last.month.balance"/><!-- 上月结余 --></h2>
							<p>
								<fmt:formatNumber value="${lastMonthUaseableAmount=='' || lastMonthUaseableAmount==null?0.00:lastMonthUaseableAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 --></p>
						</li>
						<li>
							<h2><spring:message code="sys.client.month.expenditure"/><!-- 当月支出 --></h2>
							<p>
								<fmt:formatNumber value="${monthExpenditure==''||monthExpenditure==null?0.00:monthExpenditure/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</p>
						</li>
						<li>
							<h2><spring:message code="sys.client.month.balance"/><!-- 当月结余 --></h2>
							<p>
								<fmt:formatNumber value="${monthUaseableAmount==''||monthUaseableAmount==null?0.00:monthUaseableAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</p>
						</li>
					</ul>
				</div>
				<div class="vip_table">
					<table>
						<tr>
							<th class="w100"><spring:message code="sys.client.no"/></th><!-- 序号 -->
							<th class="w300"><spring:message code="sys.client.type"/></th><!-- 类型 -->
							<th><spring:message code="sys.client.income"/></th><!-- 收入 -->
							<th><spring:message code="sys.client.expenditure"/></th><!-- 支出 --></th>
						</tr>
						<c:forEach var="data" items="${memberFundLinesList}"
							varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td>
									<c:if test="${data.type=='01'}">
										<spring:message code="sys.client.recharge"/><!-- 充值 -->
									</c:if> 
									<c:if test="${data.type=='02'}">
										<spring:message code="sys.client.withdrawals"/><!-- 提现 -->
									</c:if>
								</td>
								<td>								
									<fmt:formatNumber value="${data.income/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								</td>
								<td class="red">
									<fmt:formatNumber value="${data.expenditure/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div> --%>
			<!-- 供应商和保理商才有的内容 start -->
			<!-- 核心企业才有的内容 start -->
			<div class="zhxx_box" style='display: none;' id='credit_div'>
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.limit.amount"/><!-- 额度授信 -->
					</h1>
				</div>
				<!--1-->
				<div class="sqed">
					<ul>
						<li><span><spring:message code="sys.client.amount.limit"/><!-- 授信额度 -->：</span>
							<font class="yellow">
								<fmt:formatNumber value="${memberFund.creditAmount==null||memberFund.creditAmount==''?0.00:memberFund.creditAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</font>
							<div class="but_but sqed_r">
								<sun:button tag='a' id='member_center_apply_credit_btn'
									i18nValue='sys.client.apply.accredit' />
								<!--申请授权 -->
							</div></li>
						<li><span><spring:message code="sys.client.useable.amount"/><!-- 可用额度 -->：</span>
							<font class="yellow">
								<fmt:formatNumber value="${memberFund.useableAmount==null || memberFund.useableAmount==''?0.00:memberFund.useableAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
								<spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</font>
						</li>
					</ul>
				</div>
			</div>
			<!-- 核心企业才有的内容 start -->
		</div>
		<!--con over-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>
