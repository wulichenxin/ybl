<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款管理--待付款批次</div>
		</div>
		<form action="/factorLoanManagementController/loanBatchPending/list.htm" id="pageForm" method="post">
			<div class="w1200 clearfix border-b">
				<ul class="clearfix formul">
					<li class="formli" onclick="javascript:window.location.href='<%=basePath%>factorLoanManagementController/loanPending/list.htm'">生成付款批次</li>
					<li class="formli form_cur" onclick="javascript:window.location.href='<%=basePath%>factorLoanManagementController/loanBatchPending/list.htm'">待付款批次</li>
				</ul>
			</div>
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">付款批次号：</label><input class="content-form2" name="batchNo" value="${dto.batchNo }"/></div>
					<div class="form-grou mr40"><label class="label-long">融资方：</label><input class="content-form2" name="financierName" value="${dto.financierName }"/></div>
				</div>
			</div>
			<div class="w1200 ybl-info">
				放款金额 = 结算金额<br/><br/>
				结算金额 = 申请融资金额 × 结算比例 
			</div>
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>付款批次号</th>
								<th>融资方</th>
								<th>合计申请金额(元)</th>
								<th>合计结算金额(元)</th>
								<th>合计保理融资费用(元)</th>
								<th>操作</th>
							</tr>
							<c:if test="${empty page.records}">
								<tr><td colspan="7">暂无数据</td></tr>
							</c:if>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td class="maxwidth"><a href="/factorLoanManagementController/loanBatchPending/detail.htm?batchId=${obj.batchId}" class="order-a">${obj.batchNo}</a></td>
									<td class="maxwidth">${obj.financierName}</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.totalApplyAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.totalSettlementAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.totalFinancingFee}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><a href="/factorLoanManagementController/loanBatchPending/${obj.batchId}/preSettlement.htm" class="btn-modify mr10">结算</a></td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</form>
		</div>
		
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/loanManagement/loan_pending.js"></script>
		<script type="text/javascript">
		/* function settlement(batchId) {
			//调用弹窗
			dialog.open("/factorLoanManagementController/loanBatchPending/preSettlement.htm?batchId=" + batchId, '1000px', '800px', 'updateaj', '结算');
			close('outClose');
		} */
		//关闭弹出窗
		/* window.close = function(item) {
			var clo = window.parent.document.getElementsByClassName(item);
			$(clo).click(function() {
				dialog.close();
			});
		} */
		</script>
	</body>
</html>