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
	<%@include file="/ybl4.0/admin/common/link.jsp" %> 		
	<!--top end -->
	<body>
		
		<p class="per_title"><span>逾期项目</span></p>
		<div class="mt40">
			<form action="/factorRepaymentPlanController/overdue.htm" id="pageForm" method="post">
				<div class="ybl-info">
					<div class="btn-found" id="btn-query">查询</div>
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form" name="loanApplyOrderNo" value="${repaymentPlanVo.loanApplyOrderNo }"/></div>
						<div class="form-grou"><label class="label-long">还款状态：</label>
							<select class="content-form" name="repaymentStatus">
									<option value="3">已逾期</option>
							</select>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long">还款时间：</label><input id="startDate" class="content-form" name="startDate" value="${repaymentPlanVo.startDate }"/></div>
						<span class="mr10 ml10">-</span>
						<div class="form-grou mr40"><input id="endDate" class="content-form" name="endDate" value="${repaymentPlanVo.endDate }"/>
						<img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					</div>
				</div>
				<div class="mt40">
					<div class="tabD">
						<div class="scrollbox">
							<table>
								<tr>
									<th>序号</th>
									<th>放款申请订单号</th>
									<th>融资方</th>
									<th>核心企业</th>
									<th>资产编号</th>
									<th>第几期/总期数</th>
									<th>还款日期</th>
									<th>本期应还本金(元)</th>
									<th>本期应还利息(元)</th>
									<th>逾期天数(天)</th>
									<th>逾期费用(元)</th>
									<th>本期还款状态</th>
									<th>本期实际还款金额(元)</th>
									<th>实际还款日期</th>
									<th>还款确认</th>
									<th style="min-width: 200px;">操作</th>
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
										<td title="${obj.loanApplyOrderNo}" class="maxwidth"><a href="#" class="order-a details" uid="${obj.loanId }" orderNo="${obj.loanApplyOrderNo }" batchId="${obj.paymentBatchId }" subId="${obj.subFinancingApplyId }">${obj.loanApplyOrderNo}</a></td>
										<td title="${obj.enterpriseShortName}" class="maxwidth">${obj.enterpriseShortName}</td>
										<td title="${obj.coreEnterpriseName}" class="maxwidth">${obj.coreEnterpriseName}</td>
										<td title="${obj.assetNumber}" class="maxwidth">${obj.assetNumber}</td>
										<td>${obj.period}</td>
										<td class="maxwidth"><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td class="maxwidth"><fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${obj.overdueDays}</td>
										<td><fmt:formatNumber value="${obj.overdueFee}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>
											已逾期
										</td>
										<td><fmt:formatNumber value="${obj.actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td class="maxwidth"><fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" /></td>
										<td>
											<c:if test="${obj.repaymentStatus eq 6}">是</c:if>
											<c:if test="${obj.repaymentStatus eq 2 or dto.repaymentStatus eq 1}">否</c:if>
										</td>
										<td style="min-width: 200px;">
											<a href="/factorCollectionManagementController/preConfirmeRepayment.htm?repaymentId=${obj.id }" class="btn-modify mr10 tip">确认</a>
											<a class="btn-modify mr10 tip" onclick="badDebt(${obj.id})">转坏账</a>
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
		 * 转坏账
		 */
		function badDebt(repaymentId) {
			$.ajax({
				url:'/factorCollectionManagementController/badDebt',
				dataType:'json',
				type:'post',
				data:{"repaymentId":repaymentId},
				success:function(data){
					if(data.responseTypeCode == "success"){
						alert(data.info,function(){
							location.href='/factorRepaymentPlanController/overdue.htm';
						});
					}else{
						alert(data.info);
					}					
				}
			}); 
		}
		
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