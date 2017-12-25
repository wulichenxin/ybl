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
	<body>
		<!--top start -->
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
		<!--top end -->
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请订单号</th>
								<th>资金方</th>
								<th>核心企业</th>
								<th>资产编号</th>
								<th>第几期/总期数</th>
								<th>还款日期</th>
								<th>本期应还本金(元)</th>
								<th>本期应还利息(元)</th>
								
								<th>逾期天数</th>
								<th>逾期费用(元)</th>
								<th>本期还款状态</th>
								<th>还款确认</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${list}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td>${obj.loanApplyOrderNo}</td>
									<td>${obj.financingName}</td>
									<td>${obj.coreEnterpriseName}</td>
									<td>${obj.assetNumber}</td>
									<td>${obj.period}</td>
									<td><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td><fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>${obj.overdueDays}</td>
									<td><fmt:formatNumber value="${obj.attribute6 }" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 1}">待还款</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 2}">已还款</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 3}">已逾期</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 4}">催收中</c:if>
										<c:if test="${not empty obj.repaymentStatus and obj.repaymentStatus eq 5}">坏账</c:if>
									</td>
									<td>
										<c:if test="${not empty obj.confirmStatus and obj.confirmStatus eq 1}">未确认</c:if>
										<c:if test="${not empty obj.confirmStatus and obj.confirmStatus eq 2}">已确认</c:if>
									</td>
									<td>
										<c:if test="${obj.repaymentStatus eq 2}"><a class="cannlSelect" param="${obj.id}" href="#">详情</a></c:if>
										<c:if test="${obj.repaymentStatus ne 2}"><a class="openSelect" param="${obj.id} ${obj.loanApplyOrderNo} ${obj.attribute4}" href="#">还款</a></c:if>
									</td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				
			<div class="btn2 mt40 clearfix">
				<a id="per_page" href="javascript:;" class="btn-add btn-center">上一页</a>
				<a id="cancel" href="javascript:;" class="btn-add btn-center">返回</a>
			</div>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/unconfirmed.js"></script>
	<script type="text/javascript">
		$('#startDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		/**
		 * 确定还款
		 */
		function preConfirmeRepayment(repaymentId) {
			//调用弹窗
			dialog.open("/factorCollectionManagementController/preConfirmeRepayment.htm?repaymentId=" + repaymentId, '950px', '750px', 'updateaj', '确定还款');
			close('outClose');
		}
		//关闭弹出窗
		window.close = function(item) {
			var clo = window.parent.document.getElementsByClassName(item);
			$(clo).click(function() {
				dialog.close();
			});
		}
		
		$("#per_page").click(function() {
			var url=$('#six',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url);
		});

		$("#cancel").click(function() {
			window.history.back(-1);
		});
		
		$(".cannlSelect").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0]
				},
				formAttrbute : {
					action : "/rePayMentController/repayInfo.htm",
					method : "POST",
					target : "_parent"
				}
			});

		});
		
		$(".openSelect").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,/g);
			
			if(formDateArry[2] != "9"){
				alert("请先确认收款");
				return false;
			}
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0],
					order_no: formDateArry[1]
				},
				formAttrbute : {
					action : "/rePayMentController/RepaymentInfo.htm",
					method : "POST",
					target : "_parent"
				}
			});

		});
		</script>
</body>
</html>