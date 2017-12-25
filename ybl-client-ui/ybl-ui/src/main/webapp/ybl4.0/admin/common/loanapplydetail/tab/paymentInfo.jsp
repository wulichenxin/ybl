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
	<body>
	
	<form action="/factorLoanManagementController/loanBatchPending/list.htm" id="subPageForm" method="post">
		<p class="protitle"><span></span>结算放款</p>
		<input type="hidden" id="platformFee" name="platformFee"/>
		<div>
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">实际放款金额：</label><input class="content-form2" name="actualLoanAmount" value="${entity.actual_loan_amount}" /><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form" name="actualLoanDate" value="${entity.actual_loan_date}"/></div>
					</div>
					<div class="ground-form mb20">
									<div class="form-grou mr40">
					<label class="label-long2">保理手续费：</label><input readonly="readonly"
						class="content-form2" value="${entity.factoring_fee}" /><span
						class="timeimg">元</span>
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">融资使用费：</label><input readonly="readonly"
						class="content-form2" value="${entity.financing_fee}" /><span
						class="timeimg">元</span>
				</div>
					</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">交易流水号：</label><input class="content-form2"  name="transactionOrderNo" value="${entity.transaction_order_no}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><input class="content-form2"  name="bank" value="${entity.bank}"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input class="content-form2"  name="bankAccountName" value="${entity.bank_account_name}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><input class="content-form2"  name="bankAccount" value="${entity.bank_account}"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${entity.remark}</textarea></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long2">上传支付凭证：</label>
						
						<a href="${attachment.url_ }">${attachment.old_name }</a>
	
					</div>
					<div id='licensePhoto_div'></div>
				</div>
			
			
			<div class="mb80"></div>
			
			
			<p class="protitle"><span></span>平台费用  = 实际放款金额 × （平台费率 - 减免费率）</p>
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>融资金额</th>
						<th>实际放款金额</th>
						<th>平台费率</th>
						<th>减免费率</th>
						<th>平台费用</th>
					</tr>
					<tr>
						<td>1</td>
						<td>${paymentBatch.totalApplyAmount }</td>
						<td id="actualLoanAmount"></td>
						<td>${rate }<input value="${rate }" name="platformRate"/><td>
						<td>${reductionRate }<input value="${reductionRate }" name="platformReductionRate"/></td>
						<td id="platformFeeTD"></td>
					</tr>
				</table>
			</div>
		</form>	
				<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab5_1" class="btn-add">上一页</a>
					<a href="#" id="tab5_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
				
				
	<script>
	$(function(){
		//所有的input设为不可编辑
		$('input').attr("readonly",true);
		$('select').attr("disabled",true);
		$('textarea').attr("readonly",true);
		//上一页，下一页,返回的跳转
		$('#tab5_1').click(function(){	
			var url=$('#four',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url);
		})		
		$('#tab5_2').click(function(){	
			var url=$('#six',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url);
		})		
		
		$(".btn-return").click(function(){
			window.parent.location.href="/loanapplicationcontroller/list.htm";
		});
		

	})
	
	
	</script>
	</body>
</html>