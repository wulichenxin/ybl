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
		<p class="per_title"><span>已放款项目</span></p>
		<div class="mt40">
			<form action="/factorInvestManagementController/getSecuredLoanRepaymentList.htm" id="pageForm" method="post">
				<div class="ybl-info">
					<div class="btn-found" id="btn-query">查询</div>
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form" name="orderNo" value="${securedLoanRepayment.orderNo }"/></div>
						<div class="form-grou"><label class="label-long">收款确认：</label>
							<select class="content-form" name="flag">
								<c:if test="${flag eq 1}">
									<option value="1">是</option>
								</c:if>
								<c:if test="${flag eq 2}">
									<option value="2">否</option>
								</c:if>
								<option value="">全部</option>
								<option value="1">是</option>
								<option value="2">否</option>
							</select>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long">付款日期：</label><input id="payStartDate" class="content-form" name="payStartDate" value="${securedLoanRepayment.payStartDate }"/></div>
						<span class="mr10 ml10">-</span>
						<div class="form-grou mr20"><input id="payEndDate" class="content-form" name="payEndDate" value="${securedLoanRepayment.payEndDate }"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
						<div class="form-grou"><label>确认时间：</label><input id="confirmStartDate" class="content-form" name="confirmStartDate" value="${securedLoanRepayment.confirmStartDate }"/></div>
						<span class="mr10 ml10">-</span><div class="form-grou"><input id="confirmEndDate" class="content-form" name="confirmEndDate" value="${securedLoanRepayment.confirmEndDate }"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					</div>
					<div class="ground-form mb20">
						
					</div>
				</div>
				<div class="mt40">
					<div class="tabD">
						<div class="scrollbox">
							<table>
								<tr>
									<th>序号</th>
									<th>放款申请单号</th>
									<th>融资方名称</th>
									<th>资产类型</th>
									<th>融资申请金额(元)</th>
									<th>实际放款金额(元)</th>
									<th>融资期限(天)</th>
									<th>融资利率(%)</th>
									<th>申请日期</th>
									<th>付款时间</th>
									<th>收款确认</th>
									<th>收款确认时间</th>
									<th>融资子订单号</th>
									<th>放款状态</th>
									<th>操作</th>
								</tr>
								<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="15">
										暂时没有相关数据~
									</td>
								</tr>
								</c:if>
								<c:forEach items="${list}" var="obj" varStatus="index">
					              	<tr>
										<td class="toggletr">${index.count}</td>
										<td title="${obj.orderNo}" class="maxwidth"><a class="order-a details" href="#" uid="${obj.id }" orderNo="${obj.orderNo }" batchId="${obj.paymentBatchId }" subId="${obj.subFinancingApplyId }">${obj.orderNo}</a></td>
										<td>${obj.enterpriseName}</td>
										<!-- 资产类型 1-应收账款2-应付账款3-票据 -->
										<td>
											<c:if test="${obj.assetsType eq 1 }">
												应收账款
											</c:if>
											<c:if test="${obj.assetsType eq 2 }">
												应付账款
											</c:if>
											<c:if test="${obj.assetsType eq 3 }">
												票据
											</c:if>
										</td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.actualloanAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${obj.financingTerm}</td>
										<td><fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.####"/></td>
										<td class="maxwidth"><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
										<td class="maxwidth"><fmt:formatDate value="${obj.actualloanDate}" pattern="yyyy-MM-dd" /></td>
										<td>
											<c:if test="${obj.status eq 9 }">
												是
											</c:if>
											<c:if test="${obj.status eq 8 }">
												否
											</c:if>
										</td>
										<td class="maxwidth"><fmt:formatDate value="${obj.confirmDate}" pattern="yyyy-MM-dd" /></td>
										<td class="maxwidth">${obj.orderNoApply}</td>
										<td>
											<c:if test="${obj.status eq 9 }">
												放款完成
											</c:if>
											<c:if test="${obj.status eq 8 }">
												待收款确认
											</c:if>
										</td>
										<td>
											<a class="details" href="#" class="btn-modify mr10 tip" uid="${obj.id }" orderNo="${obj.orderNo }" batchId="${obj.paymentBatchId }" subId="${obj.subFinancingApplyId }">查看</a>
										</td>
									</tr>
				              </c:forEach>
							</table>
						</div>
					</div>
					<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
				</form>
				<form action="/loanApplyCommonApi/selectChildrenDetail.htm" id="pageDetais" method="post" target="_blank">
					<input type="hidden" name="id" id="oId" value=""/>
					<input type="hidden" name="orderno" id="orderNo" value=""/>
					<input type="hidden" name="batchid" id="oBatchid" value=""/>
					<input type="hidden" name="subid" id="oSubid" value=""/>
					<input type="hidden" name="url" id="url" value="###"/>
				</form>
			</div>
		</div>
		<script type="text/javascript" src="/ybl4.0/resources/js/factor/collectionManagement/overdue.js"></script>
		<script type="text/javascript">
		$('#payStartDate,#payEndDate,#confirmStartDate,#confirmEndDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		
		$(".details").click(function(){
			var id=$(this).attr("uid");
			var orderno=$(this).attr("orderNo");
			var batchid=$(this).attr("batchId");
			var subid=$(this).attr("subId");
			if(batchid ==null || batchid == 'undefined'){
				batchid = 0;
			}
			$("#oId").val(id);
			$("#orderNo").val(orderno);
			$("#oBatchid").val(batchid);
			$("#oSubid").val(subid);
			$("#pageDetais").submit();
		})
		</script>
	</body>
</html>