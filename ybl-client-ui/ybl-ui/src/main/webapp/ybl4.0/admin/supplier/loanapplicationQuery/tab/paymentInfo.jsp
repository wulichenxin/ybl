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
	<c:choose>
			<c:when test="${recordResult == 'noRecords'}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
	<form action="/factorLoanManagementController/loanBatchPending/list.htm" id="subPageForm" method="post">
		
		<input type="hidden" id="platformFee" name="platformFee"/>
		<div>
			<p class="protitle"><span>结算放款</span></p>
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">实际放款金额：</label><input class="content-form" name="actualLoanAmount" value="<fmt:formatNumber value="${paymentBatch.actualLoanAmount}" pattern="#,##0.##" maxFractionDigits="2"/>" /><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form" name="actualLoanDate" value="${paymentBatch.actualLoanDate}"/></div>
						<div class="form-grou mr40">
					<label class="label-long2">保理融资费：</label><input readonly="readonly"
						class="content-form" value="<fmt:formatNumber value="${paymentBatch.factoringFee}" pattern="#,##0.##" maxFractionDigits="2"/>"  /><span
						class="timeimg">元</span>
				</div>
					</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">交易流水号：</label><input class="content-form"  name="transactionOrderNo" value="${paymentBatch.transactionOrderNo}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><input class="content-form"  name="bank" value="${paymentBatch.bank}"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input class="content-form"  name="bankAccountName" value="${paymentBatch.bankAccountName}"/></div>
					
				</div>
				
				<div class="ground-form mb20">
				
					<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><input class="content-form"  name="bankAccount" value="${paymentBatch.bankAccount}"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${paymentBatch.remark}</textarea></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long2">支付凭证：</label></label></div>
					<c:if test="${attachment.id>0 }">
								<div class="pd20">
									<div id='licensePhoto'>
										<a href="/fileDownloadController/downloadftp?id=${attachment.id }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
									</div>
									<div id='licensePhoto_div'></div>
								</div>
						</c:if>
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
						<th>融资金额(元)</th>
						<th>实际放款金额(元)</th>
						<th>平台费率(%)</th>
						<th>减免费率(%)</th>
						<th>平台费用(元)</th>
					</tr>
					<tr>
						<td>1</td>
						<td>${platformConfigFree.enterpriseName}</td>
						<td><fmt:formatNumber value="${financingAmount }" pattern="#,##0.##" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber value="${paymentBatch.actualLoanAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber value="${platformConfigFree.rate }" pattern="#,##0.####" maxFractionDigits="4"/></td>
						<td><fmt:formatNumber value="${platformConfigFree.reductionRate }" pattern="#,##0.####" maxFractionDigits="4"/></td>
						<td><fmt:formatNumber value="${plat_free }" pattern="#,##0.##" maxFractionDigits="2"/></td>
					</tr>
				</table>
			</div>
			
			</div>
		</form>	
				<div class="bottom-line mt20"></div>
			<div class="btn3 clearfix mb80 mt80">
					<a href="#" id="tab5_1" class="btn-add">上一页</a>
					<a href="#" id="tab5_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
				
	<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>			
	<script>
	$(function(){
		//所有的input设为不可编辑
		$('input').attr("readonly",true);
		$('select').attr("disabled",true);
		$('textarea').attr("readonly",true);
		//上一页，下一页,返回的跳转
		$('#tab5_1').click(function(){	
			/* var url=$('#four',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url); */
			$('#four',parent.document).click();		})		
		$('#tab5_2').click(function(){	
			/* var url=$('#six',parent.document).attr('url');	
			$('#iframe1',parent.document).attr('src',url); */
			$('#six',parent.document).click();
		})		
		
		$(".btn-return").click(function(){
			var url=$("#jumpurl",parent.document).val()
			window.parent.location.href=url;
		});
		

	})
	
	
	</script>
	</c:otherwise>
	</c:choose>
	</body>
</html>