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
<title><spring:message code="sys.v2.client.integrated.query" /></title>
<!-- 保理商首页 -->
<jsp:include page="/ybl/v2/admin/common/link.jsp" />
	<!-- 日期控件 -->
	<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
	<script type="text/javascript" src="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#disbursementDate').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    maxDate:jQuery('#disbursementMaxDate').val()?jQuery('#disbursementMaxDate').val():false
				   });
				  },
			minDate:false
			
		});
		$('#disbursementDate_a').on('click', function () {
		    $('#disbursementDate').datetimepicker('show');
		});
		$('#disbursementMaxDate').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    minDate:jQuery('#disbursementDate').val()?jQuery('#disbursementDate').val():false
				   });
				  },
			maxDate:false
		});
		$('#disbursementMaxDate_a').on('click', function () {
		    $('#disbursementMaxDate').datetimepicker('show');
		});
		$('#returnDate').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    maxDate:jQuery('#returnMaxDate').val()?jQuery('#returnMaxDate').val():false
				   });
				  },
			minDate:false
			
		});
		$('#returnDate_a').on('click', function () {
		    $('#returnDate').datetimepicker('show');
		});
		$('#returnMaxDate').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    minDate:jQuery('#returnDate').val()?jQuery('#returnDate').val():false
				   });
				  },
			maxDate:false
		});
		$('#returnMaxDate_a').on('click', function () {
		    $('#returnMaxDate').datetimepicker('show');
		});
	});

	function searchData(){
		var disbursementDate = $("#disbursementDate").val();
		var disbursementMaxDate = $("#disbursementMaxDate").val();
		var returnDate = $("#returnDate").val();
		var returnMaxDate = $("#returnMaxDate").val();
		if(disbursementDate != ''){
			disbursementDate += ' 00:00:00';
			$("#disbursementDate").val(disbursementDate);
		}
		if(disbursementMaxDate != ''){
			disbursementMaxDate += ' 00:00:00';
			$("#disbursementMaxDate").val(disbursementMaxDate);
		}
		if(returnDate != ''){
			returnDate += ' 00:00:00';
			$("#returnDate").val(returnDate);
		}
		if(returnMaxDate != ''){
			returnMaxDate += ' 00:00:00';
			$("#returnMaxDate").val(returnMaxDate);
		}
		$("#pageForm").submit();
	}
</script>
</head>
<body>
	<form action="/contract/receivableInfoPage" id="pageForm" method="post">
	<div class="v2_top_bg v2_t_bg2 " style="height:410px;">
	<div class="v2_top_con">
		<div class="v2_head_top">
		<!--top start -->
		<%@include file="/ybl/v2/admin/common/top.jsp" %>
		<!--top end -->
		</div>
		<div class="v2_head_line"></div>
	<!---->
	<div class="v2_path"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.integrated.query" /></div>
	<!--搜索条件-->
	<div class="v2_seach_box">
		<ul>
			<li class="ww28"><label><spring:message code="sys.v2.client.contract.voucher.number" />:</label><input type="text" name="number" value="${receivable.number }" /></li>
			<li class="ww28"><label><spring:message code="sys.v2.client.supplier" />:</label><input type="text" name="supplierEnterpriseName" value="${receivable.supplierEnterpriseName }" /></li>
			<li class="ww28"><label><spring:message code="sys.v2.client.core.enterprise" />:</label><input type="text" name="coreEnterpriseName" value="${receivable.coreEnterpriseName }"/></li>
			<li class="clear ww28"><label><spring:message code="sys.v2.client.finance.apply.status" />:</label>
			<select name="status" url="/configController/getExcept-RECEIVABLE_STATUS/draft"
										valueFiled="code_" textField="value_"
										defaultValue="${receivable.status }" isSelect="Y"></select>
			</li>
				<li class="ww28"><label><spring:message code="sys.v2.client.contract.repayment.status" />:</label>
				<select name="repaymentStatus" url="/configController/get-REPAYMENT_STATUS"
										valueFiled="code_" textField="value_"
										defaultValue="${receivable.repaymentStatus }" isSelect="Y"></select>
				</li>
				<li class="ww28"><label><spring:message code="sys.v2.client.contract.buyback.status" />:</label>
				<select name="buybackStatus" url="/configController/get-BUYBACK_STATUS"
										valueFiled="code_" textField="value_"
										defaultValue="${receivable.buybackStatus }" isSelect="Y"></select>
				</li>
				<li class="clear w460"><label><spring:message code="sys.v2.client.settlement.date" />:</label><span><input type="text" id="disbursementDate" name="disbursementDate" value="<fmt:formatDate value='${receivable.disbursementDate }' pattern='yyyy-MM-dd'/>"/><a id="disbursementDate_a" class="v2_date_ico"></a></span><b><spring:message code="sys.v2.client.to" /></b><span><input type="text" id="disbursementMaxDate" name="disbursementMaxDate" value="<fmt:formatDate value='${receivable.disbursementMaxDate }' pattern='yyyy-MM-dd'/>"  /><a id="disbursementMaxDate_a" class="v2_date_ico"></a></span></li>
				<li class="w460"><label><spring:message code="sys.v2.client.expectTheReceivable" />:</label><span><input type="text" id="returnDate" name="returnDate" value="<fmt:formatDate value='${receivable.returnDate }' pattern='yyyy-MM-dd'/>" /><a id="returnDate_a" class="v2_date_ico"></a></span><b><spring:message code="sys.v2.client.to" /></b><span><input type="text" id="returnMaxDate" name="returnMaxDate" value="<fmt:formatDate value='${receivable.returnMaxDate }' pattern='yyyy-MM-dd'/>"  /><a id="returnMaxDate_a" class="v2_date_ico"></a></span></li>
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
	        <!--按钮top-->
	        <div class="v2_table_con" style="width:100%; overflow-x:scroll;">
	        	<table border="0" cellspacing="0" cellpadding="0" style="width:2000px;">
	              <tr>
	               <th width="50"><spring:message code="sys.v2.client.no" /></th>
	                <th width="160"><spring:message code="sys.v2.client.supplier" /></th>
	                <th width="160"><spring:message code="sys.v2.client.core.enterprise" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.voucher.number" /></th>
	                <th width="150"><spring:message code="sys.v2.client.amount.yuan" /></th>
	                <th width="150"><spring:message code="sys.v2.client.expectTheReceivable" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.apply.date" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.confrim.date" /></th>
	                <th width="150"><spring:message code="sys.v2.client.audit.date" /></th>
	                <th width="150"><spring:message code="sys.v2.client.settlement.date" /></th>
	                <th width="150"><spring:message code="sys.v2.client.settlementAmount.yuan" /></th>
	                <th width="150"><spring:message code="sys.v2.client.amountOfMoneyBack" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.buyback.amount.yuan" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.reimburse.amount" /></th>
	                <th width="150"><spring:message code="sys.v2.client.contract.reimbursement.amount" /></th>
	                <th width="100"><spring:message code="sys.v2.client.finance.apply.status" /></th>
	                <th width="100"><spring:message code="sys.v2.client.contract.repayment.status" /></th>
	                <th width="100"><spring:message code="sys.v2.client.contract.buyback.status" /></th>
	              </tr>
	              <c:forEach var="obj" items="${receivableList}" varStatus="index" >
	              <tr>
	                <td>${index.count}</td>
	                <td>${obj.supplierEnterpriseName }</td>
	                <td>${obj.coreEnterpriseName }</td>
	                <td>${obj.number }</td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.amount }" /></td>
	                <td><fmt:formatDate value="${obj.returnDate }" pattern="yyyy-MM-dd"/> </td>
	                <td><fmt:formatDate value="${obj.applyDate }" pattern="yyyy-MM-dd"/></td>
	                <td><fmt:formatDate value="${obj.confirmDate }" pattern="yyyy-MM-dd"/></td>
	                <td><fmt:formatDate value="${obj.auditDate }" pattern="yyyy-MM-dd"/></td>
	                <td><fmt:formatDate value="${obj.disbursementDate }" pattern="yyyy-MM-dd"/></td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.disbursementAmount }" /></td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.repaymentAmount }" /></td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.buybackAmount }" /></td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.reimburseAmount }" /></td>
	                <td class="tr"><fmt:formatNumber type="number" pattern="##0.00" value="${obj.reimbursementAmount }" /></td>
	                <td url="/configController/get-RECEIVABLE_STATUS/${obj.status}" textField="value_"></td>
	                <td url="/configController/get-REPAYMENT_STATUS/${obj.repaymentStatus}" textField="value_"></td>
	                <td url="/configController/get-BUYBACK_STATUS/${obj.buybackStatus}" textField="value_"></td>
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