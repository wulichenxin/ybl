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
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->
		
		<p class="protitle"><span></span>还款计划</p>
			<div class="w1200 mt40">
				<div class="tabD">
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>放款申请订单号</th>
								<th>资金方</th>
								<th>核心企业</th>
								<th>第几期/总期数</th>
								<th>还款日期</th>
								<th>本期应还本金</th>
								<th>本期应还利息</th>
								
								<th>逾期天数</th>
								<th>逾期费用</th>
								<th>还款确认</th>
								<th>本期还款状态</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${record}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td><a href="javascript:;" class="order-a">${obj.loan_apply_order_no}</a></td>
									<td>${obj.financing_name}</td>
									<td>${obj.core_enterprise_name}</td>
									<td>${obj.period}</td>
									<td><fmt:formatDate value="${obj.repayment_date}" pattern="yyyy-MM-dd" /></td>
									<td>￥<fmt:formatNumber value="${obj.repayment_principal}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>￥<fmt:formatNumber value="${obj.repayment_interest}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>${obj.overdue_days}</td>
								    <td>￥<fmt:formatNumber value="${obj.over_money}" pattern="##0.00" maxFractionDigits="2"/></td>
									<td>
										<c:if test="${obj.repayment_status eq 6}">是</c:if>
										<c:if test="${obj.repayment_status ne 6 }">否</c:if>
									</td>
									<td>
										<c:if test="${obj.repayment_status eq 1}">待还款</c:if>
										<c:if test="${obj.repayment_status eq 2}">已还款</c:if>
										<c:if test="${obj.repayment_status eq 3}">未确认</c:if>
										<c:if test="${obj.repayment_status eq 4}">已逾期</c:if>
										<c:if test="${obj.repayment_status eq 5}">催收中</c:if>
										<c:if test="${obj.repayment_status eq 6}">坏账</c:if>
										<c:if test="${obj.repayment_status eq 6}">已还款已确认</c:if>
										
										
									</td>

								</tr>
			              </c:forEach>
						</table>
					</div>
							<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab7_1" class="btn-add">上一页</a>
					<a href="#" id="tab7_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
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
		//所有的input设为不可编辑
		$('input').attr("readonly",true);
		$('select').attr("disabled",true);
		$('textarea').attr("readonly",true);
		
		//上一页，下一页,返回的跳转
		$('#tab7_1').click(function(){	
			var url=$('#six',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url);
		})		
		$('#tab7_2').click(function(){	
			var url=$('#eight',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url);
		})		
		
		$(".btn-return").click(function(){
			window.parent.location.href="/loanapplicationcontroller/list.htm";
		});
		</script>
	</body>
</html>