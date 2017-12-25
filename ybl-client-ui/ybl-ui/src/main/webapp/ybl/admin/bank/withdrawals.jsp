<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.withdrawals"/></title><!-- 提现  -->
<jsp:include page="../common/link.jsp" />
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
	// 添加
	function add_blank() {
		$('#add_blank').show();
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
	function add_bclose() {
		clearInterval(timer);
		$('#add_blank').hide();
		$('body').css({
			overflow : ''
		});
	}
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path"><!-- 当前位置->账户中心 -> 账户总览 ->提现 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.account.center"/>-> 
		<spring:message code="sys.client.account.overview"/>->
		<spring:message code="sys.client.withdrawals"/>
	</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>
						<spring:message code="sys.client.withdrawals"/><!-- 提现 -->
					</h1>
				</div>

				<div class="xtxx">
					<div class="tab_xxcon">
						<!--1-->
						<div class=" bankbox">
							<div class="xgyf_cz">
								<dl>
									<dd>
										<label>账户余额：</label><span class="yellow"><i class="f24">
												<fmt:formatNumber
													value="${memberFund.totalAmount==''||memberFund.useableAmount==null?0.00:memberFund.useableAmount/10000}"
													pattern="#,##0.00" maxFractionDigits="2" />
										</i>
										<spring:message code="sys.client.tenThousand"/><!-- 万元 --></span><span class="txjl fr"><a
											href="/accountOverview/toWithdrawalsRecordPage">
											<spring:message code="sys.client.withdrawals.record"/><!-- 提现记录 --></a></span>
									</dd>
									<dd>
										<label>请选择提现银行卡：</label>
										<c:forEach var="data" items="${bankAccountList}"
											varStatus="index">
											<div class="addbank addbank_y">
												<a><h1>
														<span><img
															src="${app.staticResourceUrl}/ybl/resources/images/zs_logo.png" /></span>
													</h1> 
													<h2>${data.accountNo}</h2>
												</a>
											</div>
										</c:forEach>
										<div class="addbank">
											<a href="/bankAccount/bindBankCard"><p>添加银行卡</p></a>
										</div>
									</dd>
									<dd>
										<label>提现金额：</label>
										<div class="yhk_box">
											<input type="text" class="text fl w200 mr10" /> <span>元</span>
										</div>

									</dd>
									<dd>
										<label>短信验证码：</label>
										<div class="yhk_box">
											<input type="text" class="text fl w200 mr10" /> <span><a
												class="lan unl">点击获取</a></span>
										</div>

									</dd>

									<dd>
										<div class="but_center_100 ">
											<a onClick="add_start();">提现</a>
										</div>
									</dd>
								</dl>
							</div>
						</div>
						<!--1-->
					</div>
				</div>
				<div class="bank_ts">
					<div class="bank_ts_l">温馨提示</div>
					<div class="bank_ts_r">
						<p>1.请确保您输入的提现金额，以及银行帐号信息准确无误。</p>
						<p>2.如果您填写的提现信息不正确可能会导致提现失败。</p>
						<p>3.在双休日和法定节假日期间，用户可以申请提现，航付保会在下一个工作日进行处理。由此造成的不便，敬请谅解。</p>
						<p>4.平台禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--conover-->
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp" />
	<!-- 底部jsp -->
	<!--弹出窗登录-->
	<div id="add" style="display: none;">
		<div class="t_window"></div>
		<div class="vipwindow_box vip_w600">
			<div class="l_tittle">
				<h1>提现</h1>
				<div class="t_window_close">
					<a id="add_close" onclick="add_close();"><img
						src="${app.staticResourceUrl}/ybl/resources/images/w_close_ico.png" /></a>
				</div>
			</div>
			<div class="vip_window_con">
				<div class="clear"></div>
				<div class="xgyf_cz">
					<ul>
						<li><h2>
								账户余额：<span class="yellow"><i class="f24 mr10">8800.00</i></span>元
							</h2></li>
						<li>您已成功申请提现<span class="yellow ml10 mr10">555.00</span>元
						</li>
						<li>国信基金会在一个工作日内对您的申请进行审核</li>
						<li>
							<div class="but_center_100 ">
								<a onclick="add_close();">确定</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>