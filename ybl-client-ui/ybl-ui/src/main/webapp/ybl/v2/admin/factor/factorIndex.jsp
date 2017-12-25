<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.factor.index" /></title>
<!-- 保理商首页 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
</head>
<body>
	<!--top start -->
	<div class="v2_top_bg h116">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp"%>
			</div>
		</div>
	</div>
	<!--top end -->
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：首页 -->
			<spring:message code="sys.v2.client.location" />
			:
			<spring:message code="sys.v2.client.index" />
		</div>
		<div class="v2_use">
			<h1><spring:message code="sys.v2.client.shortcuts"/></h1>
			<ul>
				<li><a href="/v2disbursementController/queryGenerateBatchList.htm">
						<div class="v2_use_list">
							<div class="v2_use_pic">
								<img
									src="${app.staticResourceUrl}/ybl/resources/v2/images/cy_menu_01.png" />
							</div>
							<div class="v2_use_xx">
								<h2><spring:message code="sys.v2.client.Loan.outAccount"/></h2>
								<p><spring:message code="sys.v2.client.factor.disburse"/></p>
							</div>
						</div>
				</a></li>
				<li><a href="/v2repaymentController/queryEnterprisePaymentList.htm">
						<div class="v2_use_list">
							<div class="v2_use_pic">
								<img
									src="${app.staticResourceUrl}/ybl/resources/v2/images/cy_menu_02.png" />
							</div>
							<div class="v2_use_xx">
								<h2><spring:message code="sys.v2.client.enterprise.repayment"/></h2>
								<p><spring:message code="sys.v2.client.enterprise.repayment"/></p>
							</div>
						</div>
				</a></li>
				<li><a href="/v2BalanceController/queryBuyBackList.htm">
						<div class="v2_use_list">
							<div class="v2_use_pic">
								<img
									src="${app.staticResourceUrl}/ybl/resources/v2/images/cy_menu_03.png" />
							</div>
							<div class="v2_use_xx">
								<h2><spring:message code="sys.v2.client.supplier.buyback"/></h2>
								<p><spring:message code="sys.v2.client.supplier.buyback.amount"/></p>
							</div>
						</div>
				</a></li>
				<li><a href="/v2BalanceController/queryRefundProcessList.htm">
						<div class="v2_use_list">
							<div class="v2_use_pic">
								<img
									src="${app.staticResourceUrl}/ybl/resources/v2/images/cy_menu_05.png" />
							</div>
							<div class="v2_use_xx">
								<h2><spring:message code="sys.v2.client.refund.process"/></h2>
								<p><spring:message code="sys.v2.client.supplier.reimburse"/></p>
							</div>
						</div>
				</a></li>
				<li><a href="/v2BalanceController/queryPlatformReconList.htm">
						<div class="v2_use_list">
							<div class="v2_use_pic">
								<img
									src="${app.staticResourceUrl}/ybl/resources/v2/images/cy_menu_04.png" />
							</div>
							<div class="v2_use_xx">
								<h2><spring:message code="sys.v2.client.platform.recon"/></h2>
								<p><spring:message code="sys.v2.client.factor.platform.check.balance"/></p>
							</div>
						</div>
				</a></li>
			</ul>
		</div>
		<div class="v2_table_box mt20">
			<div class="v2_table_top">
				<h1>
					<font><spring:message code="sys.v2.client.todo.list" /> <!-- 待办事项 -->
						<b>${todoSize}</b> </font> <span style="display:none;"> <a href='javascript:void(0);'
						id='to_do_list_more_btn'> <spring:message
								code="sys.v2.client.more" /> <!-- 更多 -->+
					</a>
					</span>
				</h1>
			</div>
			<!--按钮top-->
			<div class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="100"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
						<th><spring:message code="sys.v2.client.function" /> <!-- 功能 --></th>
						<th><spring:message code="sys.v2.client.key.content" /> <!-- 关键内容 --></th>
						<th><spring:message code="sys.v2.client.operation.date" /> <!-- 操作日期 --></th>
						<th><spring:message code="sys.v2.client.operation" /> <!-- 操作 --></th>
					</tr>
					<c:forEach var="data" items="${todoList}" varStatus="index">
						<tr>
							<td>${index.count }</td>
							<td>${data.function }</td>
							<td >${data.summary }</td>
							<td>${data.lastUpdateTime }</td>
							<td><a class="lan" href="${data.handleUrl }"><spring:message
										code="sys.v2.client.process" />
									<!-- 处理 --></a></td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!--table-->
		<div class="v2_table_box">
			<div class="v2_table_top">
				<h1>
					<h1>
						<spring:message code="sys.v2.client.warn.remind" />
						<!-- 预警提醒 -->
					</h1>
					<span> <a href='javascript:void(0);'
						id='warn_remind_list_more_btn'> <spring:message
								code="sys.v2.client.more" /> <!-- 更多 -->+
					</a>
					</span>
				</h1>
			</div>
			<!--按钮top-->
			<div  class="v2_table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="100"><spring:message code="sys.v2.client.no" /> <!-- 序号 --></th>
						<th ><spring:message code="sys.v2.client.warn.message" /> <!-- 预警信息 --></th>
					</tr>
					<tr>
						<td width="100"> 1</td>
						<td >订单  201706271658004321  离还款日还有5天</td>
					</tr>
					
				</table>
			</div>
		</div>
		<!--table-->
	</div>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>