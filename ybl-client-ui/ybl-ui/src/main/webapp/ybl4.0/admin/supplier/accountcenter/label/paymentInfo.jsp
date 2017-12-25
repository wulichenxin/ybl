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
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
	<script type="text/javascript">
		$(function(){ 
			$("#btn-6").click(function(){
				$('.iconlist', parent.document).removeClass('pro_li_cur');
				$('#iconlist2', parent.document).addClass('pro_li_cur');
				var orderNo=$('#orderNo', parent.document).val();
				var financingAmount=$('#financingAmount', parent.document).val();
				var loan_apply_id=$('#loan_apply_id', parent.document).val();
				window.location.href="/tabDetailController/selectReceiveConfirmByOrderNoAndLoanOrderId?orderNo=" + orderNo +"&financingAmount=" + financingAmount + "&loanOrderId=" + loan_apply_id;
			});
		});
	</script>
	<body>
	<form action="/factorLoanManagementController/loanBatchPending/list.htm" id="subPageForm" method="post">
		
		<input type="hidden" id="platformFee" name="platformFee"/>
		<div style="width: 950px;margin: auto;">
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">实际放款金额：</label><input class="content-form2" name="actualLoanAmount" value="${paymentBatch.actualLoanAmount}" /><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form2" name="actualLoanDate" value="${paymentBatch.actualLoanDate}"/></div>
					</div>
					<div class="ground-form mb20">
									<div class="form-grou mr40">
					<label class="label-long2">保理融资费：</label><input readonly="readonly"
						class="content-form2" value="${paymentBatch.factoringFee}" /><span
						class="timeimg">元</span>
				</div>
				<%-- <div class="form-grou mr40">
					<label class="label-long2">融资使用费：</label><input readonly="readonly"
						class="content-form2" value="${paymentBatch.financingFee}" /><span
						class="timeimg">元</span>
				</div> --%>
					</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">交易流水号：</label><input class="content-form2"  name="transactionOrderNo" value="${paymentBatch.transactionOrderNo}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><input class="content-form2"  name="bank" value="${paymentBatch.bank}"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input class="content-form2"  name="bankAccountName" value="${paymentBatch.bankAccountName}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><input class="content-form2"  name="bankAccount" value="${paymentBatch.bankAccount}"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>备注：</label><textarea class="protext w688" name="remark">${paymentBatch.remark}</textarea></div>
				</div>
				<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">支付附件：</label>
							<div id='licensePhoto'>
								<%-- <img class="uploadimg" src="${attachment.url_ }" /> --%>
								<c:if test="${not empty attachment.id }">
									<a href="/fileDownloadController/downloadftp?id=${attachment.id }" >
								</c:if>
								<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
						</div>
						<div id='licensePhoto_div'></div>
					</div>
			</div>
			
			<div class="mb80"></div>
			<p class="protitle"><span>平台费用  = 实际放款金额 × （平台费率 - 减免费率）</span></p>
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>资金方名称</th>
						<th>融资金额</th>
						<th>实际放款金额</th>
						<th>平台费率</th>
						<th>减免费率</th>
						<th>平台费用</th>
					</tr>
					<tr>
						<td>1</td>
						<td>${platformConfigFree.enterpriseName}</td>
						<td>${financingAmount }</td>
						<td>${paymentBatch.actualLoanAmount}</td>
						<td>${platformConfigFree.rate }</td>
						<td>${platformConfigFree.reductionRate }</td>
						<td>${plat_free }</td>
					</tr>
				</table>
			</div>
		</form>	
		<!-- 图片上传 部分 start -->
		<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
		</form>
		<br/>
		<!-- <div class="btn3 clearfix mb80"> -->
			<a href="#"  class="btn-add btn-center" id="btn-6" >下一页</a>
			<!-- <a href="#" class="btn-add" id="btn-return">返回</a> -->
		<!-- </div> -->
			
		<!-- 图片上传 部分 end -->
		<script type="text/javascript">
		
		$(function(){
			/* $('#actualLoanDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			}); */
		})
		</script>
	</body>
</html>