<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
		
	</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<body>
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />池水位监控</div>
		</div>
		<form action="/contractQuotaV4Controller/contractQuotaPage?path=1" id="pageForm" method="post">
		<div class="w1200 mt40">
			<div class="ground-form mb20">
				<div class="form-grou mr50"><label>融资方名称：</label><input class="content-form" name="enterpriseName" value="${contractQuota.enterpriseName }"/></div>
				<div class="form-grou mr50"><label style="width: 105px;">融资主合同号：</label><input class="content-form" name="masterContractNo" value="${contractQuota.masterContractNo }"/></div>
				<div class="form-grou "><label style="width: 78px;">预警状态：</label><select class="content-form" name="attribute1">
									<option value="" >全部</option>
									<option value="1" <c:if test="${contractQuota.attribute1 eq 1}">selected="selected"</c:if>>正常</option>
									<option value="2" <c:if test="${contractQuota.attribute1 eq 2}">selected="selected"</c:if>>预警</option>
								</select></div>
				<a href="javascript:void(0);" onclick="searchData()" class="btn-modify ml30">查询</a>
			</div>
			
			<p class="cstitle mb30">剩余可用余额=最新授信额度-累计放款金额+累计还款本金</p>
			<div class="tabD">
			<div class="scrollbox">
				<table>
					<tr>
						<th>序号</th>
						<th>融资方</th>
						<th>初始授信额度(元)</th>
						<th>最新授信额度(元)</th>
						<th>累计放款金额(元)</th>
						<th>累计还款本金(元)</th>
						<th>剩余可用金额(元)</th>
						<th>预警伐值(元)</th>
						<th>关联主融资合同号</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
					<c:if test="${empty contractQuotaList}">
								<tr><td colspan="15">暂无数据</td></tr>
					</c:if>
					<c:forEach var="obj" items="${contractQuotaList}" varStatus="index" >
						<tr>
							<td>${index.count}</td>
							<td>${obj.enterpriseName }</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.creditAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.newCreditAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.disbursementAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.repaymentAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.allAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.earlyWarningAmount }" /></td>
							<td> ${obj.masterContractNo } </td>
							<c:if test="${obj.allAmount > obj.earlyWarningAmount }">
								<td>正常</td>
							</c:if>
							<c:if test="${obj.allAmount <= obj.earlyWarningAmount }">
								<td style="color:red">预警 </td>
							</c:if>
							<td><a class="linka btn-modify ml30"  url="/contractQuotaV4Controller/contractQuotaPageByNo?masterContractNo=${obj.masterContractNo }" href="javascript:void(0);">设置预警伐值</a></td>
						</tr>
						</c:forEach>
				</table>
				</div>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		</form>
		<script type="text/javascript">
			function searchData() {
				$("#pageForm").submit();
			}
			$('.linka').click(function() {
			
				//调用弹窗
				var $url = $(this).attr('url');
				dialog.open($url, '600px', '350px', 'updateaj', '设置预警值');
				close('outClose');
			})
			//关闭弹出窗
			window.close = function(item) {
				var clo = window.parent.document.getElementsByClassName(item);
				$(clo).click(function() {
					dialog.close();
				})
			}
		</script>
	</body>

</html>