<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>充值</title>
<jsp:include page="../common/link.jsp" />
<script type="text/javascript">
	$(function() {
		//tab切换
		$('.bankbox ul li').click(
				function() {
					var index = $(this).index();
					$('.yh_tablebox').eq(index).show().addClass('now')
							.siblings().removeClass('now').hide();
					$('.bankbox ul li').eq(index).addClass('now').siblings()
							.removeClass('now');
				});
		//tab切换
		$('.xtxx dl dd').click(
				function() {
					var index = $(this).index();
					$('.vip_tabxx').eq(index).show().addClass('now').siblings()
							.removeClass('now').hide();
					$('.xtxx dl dd').eq(index).addClass('now').siblings()
							.removeClass('now');
				});
	});
	function vip_morebank() {
		$('.morebank-list').show();
		$('.vip_morebank').hide();
	}
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path">当前位置->账户中心 -> 账户总览 ->充值</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=0" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_1"></i>充值
					</h1>
				</div>
				<div class="xtxx">
					<div class="tab_xxcon">
						<!--1-->
						<div class=" bankbox">
							<div class="vip_banklist">
								<h2>请选择充值银行：</h2>
								<ul>
									<li class="now"><a class="vip_bank_bg bank_ico1"></a></li>
									<li><a class="vip_bank_bg bank_ico2"></a></li>
									<li><a class="vip_bank_bg bank_ico3"></a></li>
									<li><a class="vip_bank_bg bank_ico4"></a></li>
									<li><a class="vip_bank_bg bank_ico5"></a></li>
									<li><a class="vip_bank_bg bank_ico6"></a></li>
									<li><a class="vip_bank_bg bank_ico7"></a></li>
									<li><a class="vip_bank_bg bank_ico8"></a></li>
									<li><a class="vip_bank_bg bank_ico9"></a></li>
									<li><a class="vip_bank_bg bank_ico10"></a></li>
									<li><a class="vip_bank_bg bank_ico11"></a></li>
									<li><a class="vip_bank_bg bank_ico12"></a></li>
									<li><a class="vip_bank_bg bank_ico13"></a></li>
									<li><a class="vip_bank_bg bank_ico14"></a></li>
									<li onclick="vip_morebank();" class="vip_morebank"><a>查看更多</a></li>
									<div class="morebank-list" style="display: none;">
										<li><a class="vip_bank_bg bank_ico15"></a></li>
										<li><a class="vip_bank_bg bank_ico16"></a></li>
										<li><a class="vip_bank_bg bank_ico17"></a></li>
										<li><a class="vip_bank_bg bank_ico18"></a></li>
									</div>
								</ul>
							</div>

							<div class="xgyf_cz">
								<dl>
									<dd>
										<label>账户余额：</label><span class="yellow"><i class="f24">
											<fmt:formatNumber value="${memberFund.totalAmount==''||memberFund.useableAmount==null?0.00:memberFund.useableAmount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>
										</i><spring:message code="sys.client.tenThousand"/><!-- 万元 --></span>
									</dd>
									<dd>
										<label>充值金额：</label>
										<div class="yhk_box">
											<input type="text" class="text fl w200 mr10" /> <span>元</span>
										</div>

									</dd>
									<dd>
										<div class="but_center_100 ">
											<a>充值</a>
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
						<p>1. 充值的过程中，请勿关闭浏览器页面，等待充值成功后刷新页面，查看最新的账户余额</p>
						<p>2. 如果您的银行卡未开通网上支付功能，需要开通网上支付，请咨询开户行客服</p>
						<p>3. 如果您充值过程中遇到任何问题欢迎致电免费客服咨询：400-880-8888，我们将第一时间为您解决</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--conover-->
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>