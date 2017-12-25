<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>还款</title>
</head>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/copy.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl4.0/resources/js/copy.js"></script>
		<!--top end -->
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
		<script type="text/javascript">
$(function(){ 
	/* $("#tab8_1").click(function(){
		$('.iconlist', parent.document).removeClass('pro_li_cur');
		$('#iconlist7', parent.document).addClass('pro_li_cur');
		var orderNo=$('#orderNo', parent.document).val();
		window.location.href="/v4PlatforLoanApplicationQueryController/selectRepayPlanByLoanOrderNo?orderNo="+orderNo;
	});
	$("#tab8_2").click(function(){
		$('.iconlist', parent.document).removeClass('pro_li_cur');
		$('#iconlist9', parent.document).addClass('pro_li_cur');
		var orderNo=$('#orderNo', parent.document).val();
		window.location.href="/v4PlatforLoanApplicationQueryController/selectRepayPlanByLoanOrderNoAlreadyConfim?orderNo="+orderNo;
	}); */
});
</script>
<body>
		<p class="protitle"><span>还款</span></p>
	</div>
	<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${hasPayMents}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>" id="${obj.id_}">第${index.count}期</li>
				</c:forEach>
			</ul>
	</div>
	<div class="w1200">
		<c:forEach items="${hasPayMents}" var="entity" varStatus="index">
		<div class="jeout" style="position: absolute;">
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>还款日期</th>
						<th>还款金额(元)</th>
						<th>交易流水号</th>
						<th>还款确认</th>
						<th>还款确认时间</th>
						<th>备注</th>
						<th>操作人</th>
					</tr>
					<c:set var="count" value="0"></c:set>
					<c:forEach items="${hasPayMents}" var="has" varStatus="status" end="${index.count-1 }">
					<c:set var="count" value="${count+has.actual_amount}"></c:set>
					<tr>
						<td>${status.count}</td>
						<td><lzq:date value='${has.repayment_date}' parttern='yyyy-MM-dd'/></td>
						<td><fmt:formatNumber value="${has.actual_amount}" pattern="##0.00" maxFractionDigits="2"/></td>
						<td>${has.transaction_order_no}</td>
						<td><c:if test="${has.confirm_status eq 1}">否</c:if><c:if test="${has.confirm_status eq 2}">是</c:if></td>
						<td><lzq:date value='${has.confirm_repayment_date}' parttern='yyyy-MM-dd'/></td>
						<td>${has.remark}</td>
						<td>${has.real_name}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="w1200 ybl-info box box${index.count}">
				
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">放款申请单号：</label> <input
							readonly="readonly" class="content-form2"
							value="${entity.loan_apply_order_no}" />
					</div>
				</div>
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">资金方：</label> <input readonly="readonly"
							class="content-form2" value="${entity.financing_name}" />
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">核心企业：</label> <input
							readonly="readonly" class="content-form2"
							value="${entity.core_enterprise_name}" />
					</div>
				</div>
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">本次应还本金：</label><input
							id="repayment_principal" readonly="readonly"
							class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_principal}' pattern='##0.##' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">本次应还利息：</label> <input
							id="repayment_interest" readonly="readonly" class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_interest}' pattern='##0.##' maxFractionDigits='2'/>" />
					</div>
				</div>
				
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">本次逾期利息：</label><input readonly="readonly"
							class="content-form2"
							value="<fmt:formatNumber value='${entity.overdue_fee}' pattern='##0.##' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">本次应还款金额：</label> <input
							 readonly="readonly"
							class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_count}' pattern='##0.##' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
				</div>

				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">计划还款日：</label> <input
							readonly="readonly" class="content-form2"
							value="<lzq:date value='${entity.repayment_date}' parttern='yyyy-MM-dd'/>" />
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">还款状态：</label><input
							readonly="readonly" class="content-form2"
							value="<c:if test='${entity.repayment_status eq 1}'>待还款</c:if><c:if test='${entity.repayment_status eq 2}'>已还款</c:if><c:if test='${entity.repayment_status eq 3}'>已逾期</c:if><c:if test='${entity.repayment_status eq 4}'>催收中</c:if><c:if test='${entity.repayment_status eq 5}'>坏账</c:if>"/>
					</div>
				</div>
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">已还款金额：</label> <input
							readonly="readonly" style="color: #DCC28A;"
							class="content-form2 yhkje"
							value="<fmt:formatNumber value='${count}' pattern='##0.00' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">待还款金额：</label> <input
							readonly="readonly" class="content-form2 color-label-blue"
							value="<fmt:formatNumber value='${repayment_wait}' pattern='##0.00' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
				</div>
		<div class="bottom-line"></div>
		<div id="datas" class="pd20 mt40">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">本次实际支付金额：</label><input
						name="actual_amount" readonly="readonly" value="${entity.actual_amount}" class="content-form2" /><span class="timeimg">元</span>
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">交易流水号：</label><input
						name="transaction_order_no" readonly="readonly" value="${entity.transaction_order_no}" class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户行：</label><input
						name="bank" readonly="readonly" value="${entity.bank}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户名称：</label><input
						name="bank_account_name" value="${entity.bank_account_name}" readonly="readonly" class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户银行账号：</label><input
						name="bank_account" readonly="readonly" value="${entity.bank_account}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label>
					<textarea name="remark" readonly="readonly" class="protext w688">${entity.remark}</textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">凭证：</label>
					<c:if test="${not empty entity.attractId }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${entity.attractId }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
							<div id='licensePhoto_div'></div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		
				</div>
		</c:forEach>
		<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
				<!-- <a href="#" id="tab8_1" class="btn-add">上一页</a>
				<a href="#" id="tab8_2" class="btn-add">下一页</a> -->
				<!-- <a href="#" class="btn-add" id="btn-return">返回</a> -->
			</div>

		</div>


	<div class="mb80"></div>

	<div id="upfile_div"></div>

</body>
</html>