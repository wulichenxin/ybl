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
<title><spring:message code="sys.client.investBidManage.myInvest"/></title><!-- 我要竞投 -->
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
		$("#member_factor_bid_Manage_query_btn").click(function(){
			$("#pageForm").submit();
		})
		$("#reset").click(function(){
			$("input[name='name_']").val('');
			$("#loan_period").val('');
			$("#amount_").val('');
		})
	})
	
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=6" />
	<!--top end -->
	<div class="wsjt_banner"></div>
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.investBidManage"/> -> <spring:message code="sys.client.investBidManage.myInvest"/></div>
	<form action="/bidController/queryAllLoanSignBid" id="pageForm" method="post">
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.projectName"/>:</label><input type="text" name="name_" value="${name_ }"/></li>
					<li><label><spring:message code="sys.client.loanMoney"/>:</label>
						<select name="amount_" id="amount_">
							<option value=""><spring:message code="sys.client.queryAll"/></option>
							<option <c:if test="${amount_=='1000000' }">selected="selected" </c:if> value="1000000">100W以下</option>
							<option <c:if test="${amount_=='5000000' }">selected="selected" </c:if> value="5000000">100W-500W</option>
						</select>
					</li>
					<li><label><spring:message code="sys.client.investBidManage.LoanPeriod"/>:</label>
						<select name="loan_period" id="loan_period">
							<option value=""><spring:message code="sys.client.queryAll"/></option>
							<option <c:if test="${loan_period=='3' }">selected="selected" </c:if> value="3">3个月以下</option>
							<option <c:if test="${loan_period=='6' }">selected="selected" </c:if> value="6">3个月-6个月</option>
						</select>
					</li>
					<li><div class="button_yellow">
							<sun:button tag='a' id='member_factor_bid_Manage_query_btn' i18nValue='sys.client.query' /><!-- 查询 -->
						</div></li>
					<li><div class="button_gary">
							<a id="reset"><spring:message code="sys.client.reset"/><!-- 重置 --></a>
						</div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->
		<!--table-->
		<div class="table_box">

			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="100"><spring:message code="sys.client.no"/></th><!-- 序号 -->
						<th><spring:message code="sys.client.projectName"/></th><!-- 项目名称 -->
						<th><spring:message code="sys.client.loanMoney"/></th><!-- 融资金额 -->
						<th><spring:message code="sys.client.loanPeriod"/></th><!-- 贷款期限 -->
						<th><spring:message code="sys.client.repaymentType"/></th><!-- 还款方式 -->
						<th><spring:message code="sys.client.investBidManage.investEnterprise"/></th><!-- 竞标企业数 -->
						<th><spring:message code="sys.client.core.enterprise"/></th><!-- 核心企业 -->
						<th></th>
					</tr>
					<c:forEach var="bid" items="${list}" varStatus="index" >
					<tr>
						<td>${index.count}</td>
						<td>
							<sun:button tag='a' href="/subjectController/investdetail?id=${bid.id_ }" clazz='lan'  id='member_factor_bid_Manage_toBidDetail_btn' value='${bid.name_ }' />
						</td>
						<td><fmt:formatNumber value="${bid.amount_ /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
						<td>${bid.loan_period }&nbsp;
							<c:if test="${bid.period_type == 'day' }"><spring:message code="sys.client.day"/></c:if>
	                		<c:if test="${bid.period_type == 'month' }"><spring:message code="sys.client.month"/></c:if>
	                		<c:if test="${bid.period_type == 'year' }"><spring:message code="sys.client.year"/></c:if>
						<td><spring:message code="sys.client.product.OneTimePayment"/></td>
						<td>${bid.count }</td>
						<td>
							<sun:button tag='a' href="/bidController/queryEnterprise?id_=${bid.core_enterprise_id }" clazz='lan'  id='member_factor_bid_Manage_lookEnterprise_btn' value='${bid.core_name }' />
						</td>

						<td>
							<div class="but_left">
								<sun:button tag='a' href="/subjectController/investdetail?id=${bid.id_ }" clazz='lan'  id='member_factor_bid_Manage_toBidDetail_btn' i18nValue='sys.client.investBidManage.toParticipateInBidding' /><!-- 参与竞标 -->
							</div>
						</td>
					</tr>
					</c:forEach>
				</table>

			</div>
			<jsp:include page="../../common/page.jsp"></jsp:include>
		</div>
		<!--table-->
	</form>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
	<!--弹出窗登录-->
	<!-- 签约信息 start -->
	<div id="add" style="display: none;">
		<div class="t_window"></div>
		<div class="vipwindow_box vip_w1000">
			<div class="l_tittle">
				<h1>签约保理商</h1>
				<div class="t_window_close">
					<a id="add_close" onclick="add_close();"><img
						src="${app.staticResourceUrl}/ybl/resources/images/w_close_ico.png" /></a>
				</div>
			</div>
			<div class="vip_window_con">
				<div class="clear"></div>
				<div class="window_xx">
					<ul>
						<li><div class="input_box">
								<span>企业名称：</span><input placeholder="电子供应商" type="text"
									class="w300 text_gary" />
							</div></li>
						<li><div class="input_box">
								<span>企业固定电话：</span><input placeholder="0755-123456" type="text"
									class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>营业执照注册号：</span><input placeholder="324345465465"
									type="text" class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>法人代表名称：</span><input placeholder="张生" type="text"
									class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>法人代表身份证号：</span><input placeholder="345678987654323456"
									type="text" class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>联系电话号码：</span><input placeholder="15678909876" type="text"
									class="text_gary w300" />
							</div></li>
						<li class="w472"><div class="input_box">
								<span>企业注册资金：</span><input placeholder="50000.00" type="text"
									class="text w200" />万元
							</div></li>
						<li>
							<div class="input_box">
								<span>企业规模：</span>
								<div class="select_box">
									<select class="select w200">
										<option>请选择</option>
										<option>北京</option>
										<option>深圳</option>
									</select>
								</div>
							</div>
						</li>
						<li class="clear"><div class="input_box">
								<span>申请签约时间：</span><input placeholder="2016-12-10" type="text"
									class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>主营业务范围：</span><input placeholder="请输入企业名称" type="text"
									class="text_gary w300" />
							</div></li>
						<li><div class="input_box">
								<span>联系人：</span><input placeholder="请输入企业名称" type="text"
									class="text w300" />
							</div></li>
						<li><div class="input_box">
								<span>联系电话：</span><input placeholder="请输入企业名称" type="text"
									class="text w300" />
							</div></li>
						<li>
							<div class="input_box">
								<span>组织机构代码证：</span>
								<div class="vip_phone fl500">
									<dl>
										<dd>
											<a><img src="${app.staticResourceUrl}/ybl/resources/images/login_bg_01.jpg" /><i></i></a>
											<p>手持正面照</p>
										</dd>
									</dl>
								</div>
							</div>
						</li>
						<li>
							<div class="input_box">
								<span>营业执照号：</span>
								<div class="vip_phone fl500">
									<dl>
										<dd>
											<a><img src="${app.staticResourceUrl}/ybl/resources/images/login_bg_03.jpg" /><i></i></a>
											<p>手持反面照</p>
										</dd>
									</dl>
								</div>
							</div>
						</li>
						<li class="clear"><div class="w_agreen">
								<input name="" type="checkbox" value="" />同意签署保理服务协议
							</div></li>
					</ul>
					<div class="clear"></div>
					<div class="w_bottom">
						<ul>
							<li><a class="now">审核</a></li>
							<li><a id="anqu_close" onclick="add_close();">取消</a></li>
						</ul>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- 签约信息 end -->
</body>
</html>