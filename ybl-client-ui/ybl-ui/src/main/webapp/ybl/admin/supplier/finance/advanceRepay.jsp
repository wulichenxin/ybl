<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>提前还款</title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="hkxx fl border-r">
			<h2><spring:message code='sys.client.Prepayment.message'></spring:message>：</h2><!-- 提前还款信息 -->
			<ul>
				<li><div class="input_box">
						<span><spring:message code='sys.client.principal.payable'></spring:message>：</span><input type="text" placeholder=""
							class="text w100 mr10" value="${repay.amount }" /><spring:message code='sys.client.tenThousand'></spring:message> <!-- 应还本金 --><!-- 万元 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code='sys.client.advince.amount'></spring:message>：</span><input type="text" placeholder=""
							class="text w100 mr10" /><spring:message code='sys.client.tenThousand'></spring:message><!-- 违约金万元 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code='sys.client.interest.should.be.paid.as.of.now'></spring:message>：</span><input type="text" placeholder=""
							class="text w100 mr10" /><spring:message code='sys.client.tenThousand'></spring:message><!-- 截至当前应还利息 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code='sys.client.total.repayment'></spring:message>：</span><font class="f28 red">5708</font><spring:message code='sys.client.tenThousand'></spring:message><!-- 总计还款额万元 -->
					</div></li>
			</ul>
		</div>
		<div class="hkxx fr">
			<h2><spring:message code='sys.client.original.repayment.information'></spring:message>：</h2><!-- 原始还款信息 -->
			<ul>
				<li><div class="input_box">
						<span><spring:message code='sys.client.principal.payable'></spring:message>：</span><input type="text" placeholder=""
							class="text w100 mr10" value="${repay.amount }" /><spring:message code='sys.client.tenThousand'></spring:message><!-- 应还本金万元 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code='sys.client.interest.payable'></spring:message>：</span><input type="text" placeholder=""
							class="text w100 mr10" /><spring:message code='sys.client.tenThousand'></spring:message><!-- 应还利息万元 -->
					</div></li>
				<li></li>
				<li><div class="input_box">
						<span><spring:message code='sys.client.total.repayment'></spring:message>：</span><font class="f28 red">5708</font><spring:message code='sys.client.tenThousand'></spring:message><!-- 总计还款额万元 -->
					</div></li>
			</ul>
		</div>
		<div class="clear"></div>
		<div class="tqhk">
			<h2><spring:message code='sys.client.Prepayment'></spring:message>：</h2><!-- 提前还款 -->
			<div class="tqhkxx">
				<div class="input_box fl mr20">
					<span><spring:message code='sys.client.repayment.amount'></spring:message>：</span><input type="text" 
						class="text w300 mr10 fl" /><spring:message code='sys.client.tenThousand'></spring:message><!-- 还款金额万元 -->
				</div>
				<div class="zf_but fl">
					<a><spring:message code='sys.client.pay'></spring:message></a><!-- 支付 -->
				</div>
			</div>
		</div>
	</div>


</body>
</html>