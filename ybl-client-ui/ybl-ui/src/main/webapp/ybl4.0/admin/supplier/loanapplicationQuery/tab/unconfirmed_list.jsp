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
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->
	<body>
		<c:choose>
			<c:when test="${fn:length(list) eq 0}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<p class="protitle"><span>还款计划</span></p>
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
								</tr>
			              </c:forEach>
						</table>
					</div>
						
				</div>
		</div>
			<div class="bottom-line mb20"></div>
			<div class="btn3 clearfix mb80 mt40">
					<a href="#" id="tab7_1" class="btn-add">上一页</a>
					<a href="#" id="tab7_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/unconfirmed.js"></script>
		<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>
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
			/* var url=$('#six',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url); */
			$('#six',parent.document).click();
		})		
		$('#tab7_2').click(function(){	
			/* var url=$('#eight',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url); */
			$('#eight',parent.document).click();
			
		})		
		
		$(".btn-return").click(function(){
			var url=$("#jumpurl",parent.document).val()
			window.parent.location.href=url;
		});
		</script>
		</c:otherwise>
		</c:choose>
	</body>
</html>