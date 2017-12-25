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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />收款管理--待收款项目</div>
		</div>
		<form action="/factorCollectionManagementController/unconfirmed/list.htm" id="pageForm" method="post">
			<div class="w1200 ybl-info">
				<div class="btn-found" id="btn-query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form" name="loanApplyOrderNo" value="${dto.loanApplyOrderNo }"/></div>
					<%-- <div class="form-grou"><label class="label-long">保理类型：</label>
						<select class="content-form" name="factoringMode">
							<option value="" <c:if test="${empty dto.factoringMode}">selected="selected"</c:if>>全部</option>
							<option value="1" <c:if test="${dto.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
							<option value="2" <c:if test="${dto.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
						</select>
					</div> --%>
					<div class="form-grou"><label class="label-long">还款状态：</label>
						<select class="content-form" name="repaymentStatus">
							<option value="">全部</option>
							<option value="1" <c:if test="${dto.repaymentStatus eq 1}">selected="selected"</c:if>>未还款</option>
							<option value="2" <c:if test="${dto.repaymentStatus eq 2}">selected="selected"</c:if>>已还款</option>
						</select>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long">还款时间：</label><input id="startDate" class="content-form" name="startDate" value="${dto.startDate }"/></div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40"><input id="endDate" class="content-form" name="endDate" value="${dto.endDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
					<div class="form-grou"><label class="label-long">还款确认：</label>
						<select class="content-form" name="confirmStatus">
							<option value="">全部</option>
							<option value="1" <c:if test="${dto.confirmStatus eq 1}">selected="selected"</c:if>>否</option>
							<option value="2" <c:if test="${dto.confirmStatus eq 2}">selected="selected"</c:if>>是</option>
						</select>
					</div>
				</div>
			</div>
			<div class="w1200 mt40">
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
								<th>本期应还利息(%)</th>
								<th>本期还款状态</th>
								<th>本期实际还款金额(元)</th>
								<th>实际还款日期</th>
								<th>还款确认</th>
								<th>操作</th>
							</tr>
							<c:if test="${empty page.records}">
								<tr><td colspan="13">暂无数据</td></tr>
							</c:if>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
				              	<tr>
									<td class="toggletr">${index.count}</td>
									<td class="maxwidth"><a href="javascript:;" class="order-a subView" lid="${obj.loanApplyId}">${obj.loanApplyOrderNo}</a></td>
									<td class="maxwidth">${obj.financingName}</td>
									<td class="maxwidth">${obj.coreEnterpriseName}</td>
									<td class="maxwidth">${obj.assetNumber}</td>
									<td class="maxwidth">${obj.period}</td>
									<td class="maxwidth"><fmt:formatDate value="${obj.repaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth">
										<c:if test="${obj.repaymentStatus eq 1}">未还款</c:if>
										<c:if test="${obj.repaymentStatus eq 2}">已还款</c:if>
									</td>
									<td class="maxwidth"><fmt:formatNumber value="${obj.actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
									<td class="maxwidth"><fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" /></td>
									<td class="maxwidth">
										<c:if test="${obj.confirmStatus eq 2}">是</c:if>
										<c:if test="${obj.confirmStatus eq 1}">否</c:if>
									</td>
									<td class="maxwidth">
										<c:if test="${obj.confirmStatus eq 1 && obj.repaymentStatus eq 2}">
											<a href="/factorCollectionManagementController/${obj.repaymentId}/1/preConfirmeRepayment.htm" class="btn-modify mr10">确认</a>
										</c:if>
									</td>
								</tr>
			              </c:forEach>
						</table>
					</div>
				</div>
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</form>
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
		/* function preConfirmeRepayment(repaymentId) {
			//调用弹窗
			dialog.open("/factorCollectionManagementController/preConfirmeRepayment.htm?repaymentId=" + repaymentId, '1000px', '800px', 'updateaj', '确定还款');
			close('outClose');
		}
		//关闭弹出窗
		window.close = function(item) {
			var clo = window.parent.document.getElementsByClassName(item);
			$(clo).click(function() {
				dialog.close();
			});
		} */
		$(".subView").click(function(){
			var lid=$(this).attr("lid");
			param={"id":lid,"url":"/factorCollectionManagementController/unconfirmed/list.htm"};
			httpPost('/loanApplyCommonApi/selectChildrenDetail.htm',param);
		})
		</script>
	</body>
</html>