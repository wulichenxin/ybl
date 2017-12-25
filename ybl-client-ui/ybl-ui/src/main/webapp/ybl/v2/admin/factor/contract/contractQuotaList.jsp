<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.contract.warning.amount.monitoring" /></title>
<!-- 保理商首页 -->
<jsp:include page="/ybl/v2/admin/common/link.jsp" />
<script type="text/javascript">
	$(function(){
		$("#selectAll").click(function(){
			$("input[name='contractId']").prop("checked",$(this).prop("checked"));
		});
		view = function(id) {
			var id_array=new Array();
			$('input[name="contractId"]:checked').each(function(){
			    id_array.push($(this).val());//向数组中添加元素
			});
			if(id_array.length < 1) {
				alert('请先选择数据');
				return;
			}
			var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串
			$("#contractIds").val(idstr);
			$.msgbox({
				height:280,
				width:564,
				content:'/contract/contractQuotaEdit',
				type :'iframe',
				title: '<spring:message code="sys.v2.client.contract.warning.amount.edit" />'
			});
			$('body').css({overflow:'hidden'});
		}
	});
	function searchData() {
		$("#pageForm").submit();
	}
</script>
</head>
<body>
	<form action="/contract/contractQuotaPage" id="pageForm" method="post">
		<div class="v2_top_bg v2_t_bg2 ">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<!--top start -->
					<%@include file="/ybl/v2/admin/common/top.jsp" %>
					<!--top end -->
				</div>
				<!---->
				<div class="v2_head_line"></div>
				<div class="v2_z_nav">
					<div class="v2_z_nav_con">
					<div class="v2_z_navbox">
						<a class="now w130" href="/contract/contractQuotaPage"><spring:message code="sys.v2.client.contract.warning.amount.monitoring" /></a><a  href="/contract/quotaPage"><spring:message code="sys.v2.client.quota.mamage" /></a><!-- <a href="强制出池.html">强制出池</a> -->
					</div>
					</div>
				</div>
				<div class="v2_path"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.quota.mamage" /> > <spring:message code="sys.v2.client.contract.warning.amount.monitoring" /></div>
				<!--搜索条件-->
				<div class="v2_seach_box">
					<ul>
						<li><label><spring:message code="sys.v2.client.supplier" />:</label><input type="text"
							name="supplierEnterpriseName"
							value="${contractQuota.supplierEnterpriseName }" /></li>
						<li><label><spring:message code="sys.v2.client.core.enterprise" />:</label><input type="text"
							name="coreEnterpriseName"
							value="${contractQuota.coreEnterpriseName }" /></li>
						<li><div class="v2_checkbox">
								<input type="checkbox" name="attribute1"
									value="yes"  <c:if test="${contractQuota.attribute1 == 'yes' }">checked</c:if> /><spring:message code="sys.v2.client.contract.warning.only" />
							</div></li>
						<li><div class="v2_button_seach">
								<a href="javascript:void(0);" onclick="searchData()"><spring:message code="sys.v2.client.query" /></a>
							</div></li>
					</ul>
				</div>
				<!--搜索条件end-->
			</div>
		</div>
		<div class="v2_vip_conbody">
			<!--table-->
			<div class="v2_table_box">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul class="fl">
							<li><a href="javascript:view(1);" class="v2_but_set"><spring:message code="sys.v2.client.contract.warning.amount.edit" /></a></li>
						</ul>
						<div class="v2_tab_nav_r fr">
							<dd class="gay_9">
								<i><spring:message code="sys.v2.client.contract.credit.amount" /></i> = <spring:message code="sys.v2.client.contract.fixed.amount" />+ <spring:message code="sys.v2.client.contract.provisional.amount" />+ <spring:message code="sys.v2.client.contract.deposit.amount" /> – <spring:message code="sys.v2.client.contract.disbursement.amount" />+ <spring:message code="sys.v2.client.contract.payment.amount" /> + <spring:message code="sys.v2.client.contract.enterprise.buyback.amount" />-
								<spring:message code="sys.v2.client.refund.amount" />
							</dd>
						</div>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<input type="hidden" id="contractIds" value="">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><input type="checkbox" id="selectAll" /></th>
							<th width="50"><spring:message code="sys.v2.client.no" /></th>
							<th width="120"><spring:message code="sys.v2.client.supplier" /></th>
							<th width="120"><spring:message code="sys.v2.client.core.enterprise" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.fixed.amount.yuan" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.provisional.amount.yuan" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.deposit.amount.yuan" /></th>
							<th width="120"><spring:message code="sys.v2.client.contract.disbursement.amount.yuan" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.payment.amount.yuan" /></th>
							<th width="120"><spring:message code="sys.v2.client.contract.buyback.amount.yuan" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.available.amount.yuan" /></th>
							<th width="100"><spring:message code="sys.v2.client.contract.warning.amount.yuan" /><!-- 预警额度 --></th>
							<th width="80"><spring:message code="sys.v2.client.status" /></th>
						</tr>
						<c:forEach var="obj" items="${contractQuotaList}" varStatus="index" >
						<tr>
							<td><input type="checkbox" name="contractId" value="${obj.id }" /></td>
							<td>${index.count}</td>
							<td>${obj.supplierEnterpriseName }</td>
							<td>${obj.coreEnterpriseName }</td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.creditAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.quota }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.deposit }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.disbursementAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.repaymentAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.buybackAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.availableAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.earlyWarningAmount }" /></td>
							<c:if test="${obj.availableAmount > obj.earlyWarningAmount }">
								<td>正常</td>
							</c:if>
							<c:if test="${obj.availableAmount <= obj.earlyWarningAmount }">
								<td class="red">预警 </td>
							</c:if>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<!--page start -->
			<jsp:include page="/ybl/v2/admin/common/page.jsp" />
			<!--page end -->
			<!--table-->
		</div>
	</form>
	<!-- bottom.jsp -->
	<jsp:include page="/ybl/v2/admin/common/bottom.jsp" />
	<!-- bottom.jsp -->
</body>
</html>