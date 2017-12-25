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
<title><spring:message code="sys.v2.client.contract.quota.edit" /></title>
<!-- 保理商首页 -->
<jsp:include page="/ybl/v2/admin/common/link.jsp" />
	<!-- 日期控件 -->
	<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
	<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
	<script type="text/javascript" src="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
	<script type="text/javascript" src="/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
	<script type='text/javascript' src='/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
<script type="text/javascript">
	$(function(){   
		$('#creditForm_effectiveTime,#depositForm_effectiveTime,#quotaForm_effectiveTime').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			minDate:0,
			maxDate:false
		});
		$(".v2_czls").click(function(){
			$(this).parent().next().next().next().next(".v2_ls_box").slideToggle();
		});
	});
	function addQuotaRecord(formId) {
		if(!$("#"+formId).validationEngine('validate')){
			return;
		}
		var effictiveTime = $("#"+formId + "_effectiveTime").val() + " 00:00:00";
		$("#"+formId + "_effectiveTime").val(effictiveTime);
		$.ajax({
            url:'/contract/quotaEditSave',
            type:'POST',
            data: $("#"+formId).serialize(), 
            dataType:'text',
            success:function(data,textStatus,jqXHR){
            	if(data == "S"){
            		alert('<spring:message code="sys.v2.client.operationSuccess" />',function(){
            			var url = window.location.href + "&time=" + (+new Date());
            			window.location.href = url;
            		});
            	} else {
            		alert('<spring:message code="sys.v2.client.operationFail" />');
            	}
            },
            error:function(xhr,textStatus){
            },
            complete:function(){
            }
        });
	}
</script>
</head>
<body>
<div class="v2_top_bg v2_t_bg2 h165">
	<div class="v2_top_con">
		<div class="v2_head_top">
	<!--top start -->
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	<!--top end -->
	</div>
	</div>
	</div>
	<!--content-->
	<div class="v2_vip_conbody">
		<div class="v2_path_no"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.quota.mamage" /> > <spring:message code="sys.v2.client.quota.mamage" /> > <spring:message code="sys.v2.client.contract.quota.edit" /></div>
		<div class="v2_box_border mt20">
			<div class="v2_tab_con">
				<h3><spring:message code="sys.v2.client.supplier" />：${supplierEnterprise.enterpriseFullName }</h3>
				<div class="v2_text_box">
					<h1>
						<spring:message code="sys.v2.client.contract.fixed.amount" /> <span class="red"><fmt:formatNumber type="number" pattern="##0.00" value="${contract.creditAmount }" /></span>元<a class="v2_czls"><spring:message code="sys.v2.client.contract.fixed.amount.history" />></a>
					</h1>
					<form action="" id="creditForm">
					<input type="hidden" name="type" value="credit">
					<input type="hidden" name="contractId" value="${contract.id }">
					<ul>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.quota.add" />：</span>
								<input name="quota" type="text" class="w300 v2_text validate[required,custom[number]]" /><i>*</i>
							</div>
						</li>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.effect.date" />：</span>
								<input id="creditForm_effectiveTime" name="effectiveTime" type="text" class="w300 v2_text validate[required,custom[date]]"/><i>*</i>
							</div>
						</li>
						<li class="clear ww100">
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.remark" />：</span>
								<textarea name="remark" class="v2_text_tea h100 w890"></textarea>
							</div>
						</li>
					</ul>
					</form>
					<div class="v2_but_list ml150 fl">
						<a class="bg_l" onclick="addQuotaRecord('creditForm');"><spring:message code="sys.v2.client.save" /></a>
					</div>
					<div class="clear"></div>
					<div class="v2_ls_box">
						<h2><spring:message code="sys.v2.client.contract.operate.history" /></h2>
						<div class="v2_table_con">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th width="50"><spring:message code="sys.v2.client.no" /></th>
									<th width="160"><spring:message code="sys.v2.client.contract.time" /></th>
									<th width="200"><spring:message code="sys.v2.client.operator" /></th>
									<th><spring:message code="sys.v2.client.contract.quota.add" /></th>
									<th width="300"><spring:message code="sys.v2.client.remark" /></th>
									<th><spring:message code="sys.v2.client.contract.effect.date" /></th>
								</tr>
								<c:forEach var="obj" items="${creditList}" varStatus="index" >
									<tr>
										<td>${index.count}</td>
										<td class="tl"><fmt:formatDate value="${obj.createdTime }" pattern="yyyy-MM-dd"/></td>
										<td class="tl">${obj.attribute1 }</td>
										<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.quota }" /></td>
										<td>${obj.remark }</td>
										<td><fmt:formatDate value="${obj.effectiveTime }" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
				<div class="v2_text_box">
					<h1>
						<spring:message code="sys.v2.client.contract.provisional.amount.edit" /><span class="red"><fmt:formatNumber type="number" pattern="##0.00" value="${contract.quota }" /> </span><spring:message code="sys.v2.client.element" /><a class="v2_czls"><spring:message code="sys.v2.client.contract.provisional.amount.history" />></a>
					</h1>
					<form action="" id="quotaForm">
					<input type="hidden" name="type" value="quota">
					<input type="hidden" name="contractId" value="${contract.id }">
					<ul>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.quota.add" />：</span>
								<input name="quota" type="text" class="w300 v2_text validate[required,custom[number]]" /><i>*</i>
							</div>
						</li>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.effect.date" />：</span>
								<input id="quotaForm_effectiveTime" name="effectiveTime" type="text" class="w300 v2_text validate[required,custom[date]]"/><i>*</i>
							</div>
						</li>
						<li class="clear ww100">
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.remark" />：</span>
								<textarea name="remark" class="v2_text_tea h100 w890"></textarea>
							</div>
						</li>
					</ul>
					</form>
					<div class="v2_but_list ml150 fl">
						<a class="bg_l" onclick="addQuotaRecord('quotaForm');"><spring:message code="sys.v2.client.save" /></a>
					</div>
					<div class="clear"></div>
					<div class="v2_ls_box">
						<h2><spring:message code="sys.v2.client.contract.operate.history" /></h2>
						<div class="v2_table_con">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th width="50"><spring:message code="sys.v2.client.no" /></th>
									<th width="160"><spring:message code="sys.v2.client.contract.time" /></th>
									<th width="200"><spring:message code="sys.v2.client.operator" /></th>
									<th><spring:message code="sys.v2.client.contract.quota.add" /></th>
									<th width="300"><spring:message code="sys.v2.client.remark" /></th>
									<th><spring:message code="sys.v2.client.contract.effect.date" /></th>
								</tr>
								<c:forEach var="obj" items="${quotaList}" varStatus="index" >
									<tr>
										<td>${index.count}</td>
										<td class="tl"><fmt:formatDate value="${obj.createdTime }" pattern="yyyy-MM-dd"/></td>
										<td class="tl">${obj.attribute1 }</td>
										<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.quota }" /></td>
										<td>${obj.remark }</td>
										<td><fmt:formatDate value="${obj.effectiveTime }" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>

							</table>
						</div>
					</div>
				</div>
				<div class="v2_text_box">
					<h1>
						<spring:message code="sys.v2.client.contract.deposit.amount" /> <span class="red"><fmt:formatNumber type="number" pattern="##0.00" value="${contract.deposit }" /></span>元<a class="v2_czls"><spring:message code="sys.v2.client.contract.deposit.amount.history" />></a>
					</h1>
					<form action="" id="depositForm">
					<input type="hidden" name="type" value="deposit">
					<input type="hidden" name="contractId" value="${contract.id }">
					<ul>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.deposit.add" />：</span>
								<input name="quota" type="text" class="w300 v2_text validate[required,custom[number]]" /><i>*</i>
							</div>
						</li>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.effect.date" />：</span>
								<input id="depositForm_effectiveTime" name="effectiveTime" type="text" class="w300 v2_text validate[required,custom[date]]"/><i>*</i>
							</div>
						</li>
						<li class="clear ww100">
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.remark" />：</span>
								<textarea name="remark" class="v2_text_tea h100 w890"></textarea>
							</div>
						</li>
					</ul>
					</form>
					<div class="v2_but_list ml150 fl">
						<a class="bg_l" onclick="addQuotaRecord('depositForm');"><spring:message code="sys.v2.client.save" /></a>
					</div>
					<div class="clear"></div>
					<div class="v2_ls_box">
						<h2><spring:message code="sys.v2.client.contract.operate.history" /></h2>
						<div class="v2_table_con">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th width="50"><spring:message code="sys.v2.client.no" /></th>
									<th width="160"><spring:message code="sys.v2.client.contract.time" /></th>
									<th width="200"><spring:message code="sys.v2.client.operator" /></th>
									<th><spring:message code="sys.v2.client.contract.deposit.add" /></th>
									<th width="300"><spring:message code="sys.v2.client.remark" /></th>
									<th><spring:message code="sys.v2.client.contract.effect.date" /></th>
								</tr>
								<c:forEach var="obj" items="${depositList}" varStatus="index" >
									<tr>
										<td>${index.count}</td>
										<td class="tl"><fmt:formatDate value="${obj.createdTime }" pattern="yyyy-MM-dd"/></td>
										<td class="tl">${obj.attribute1 }</td>
										<td><fmt:formatNumber type="number" pattern="##0.00" value="${obj.quota }" /></td>
										<td>${obj.remark }</td>
										<td><fmt:formatDate value="${obj.effectiveTime }" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- content end -->
	<!-- bottom.jsp -->
	<jsp:include page="/ybl/v2/admin/common/bottom.jsp" />
	<!-- bottom.jsp -->
	<script type="text/javascript" src="/ybl/resources/js/jquery.dragndrop_v2.js"></script>
</body>
</html>