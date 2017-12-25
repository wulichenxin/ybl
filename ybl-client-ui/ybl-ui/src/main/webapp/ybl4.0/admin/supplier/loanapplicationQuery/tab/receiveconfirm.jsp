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
<title></title>
</head>
<!--弹出框-->
	<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css"/>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<!--top end -->
<body>
	<div class="w1200 clearfix border-b">
		<ul class="clearfix formul">
			<li class="formli form_cur">收款确认</li>
			<!-- <li class="formli">还款计划</li>
			<li class="formli">还款</li>
			<li class="formli">还款确认</li> -->
		</ul>
	</div>
	
	<!-- tab1 end -->
	<!-- tab2 start -->

	<!-- tab2 end -->
	<!-- tab还款start -->
	<div class="w1200 ybl-info box box6 " style="display:block;">
		<div class="ground-form mb20">
			<!-- 放款申请的ID -->
			<input type="hidden" id="loan_apply_id" value="${factorLoanVo.id}">
			<div class="form-grou mr40"><label class="label-long">实际放款金额：</label><input name="actualLoanAmount" class="content-form" value="${factorLoanVo.actualLoanAmount}" /></div>
			<div class="form-grou"><label class="label-long">实际放款时间：</label>
			<input id="beginDate" name="actualLoanDate" class="content-form" value="${factorLoanVo.actualLoanDate}" /></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">保理手续费：</label><input class="content-form" name="factoringFee" value="${factorLoanVo.factoringFee}"/></div>
			<div class="form-grou"><label class="label-long">融资手续费：</label><input class="content-form" name="financingFee" value="${factorLoanVo.financingFee}"/></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">交易流水号：</label><input name="financingFee" class="content-form" value="${factorLoanVo.financingFee}"/></div>
			<div class="form-grou"><label class="label-long2">付款单位账户开户行：</label><input name="transactionOrderNo" class="content-form" value="${factorLoanVo.transactionOrderNo}"/></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input name="bankAccountName" class="content-form" value="${factorLoanVo.bankAccountName}"/></div>
			<div class="form-grou"><label class="label-long2">付款单位账户银行账号：</label><input name="bankAccount" class="content-form" value="${factorLoanVo.bankAccount}"/></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="remark" class="protext w688">${factorLoanVo.remark}</textarea></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou"><label class="label-long2">上传收款确认附件：</label><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" /></div>
		</div>
		<div class="bottom-line"></div><br/>
		
		平台费用 = 实际放款金额 x (平台费率 - 减免费率)
		
		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>资金方名称</th>
							<th>融资金额</th>
							<th>实际放款金额</th>
							<th>平台费率</th>
							<th>减免费率</th>
							<th>平台费用(元)</th>
						</tr>
							<tr>
								<td class="toggletr">1</td>
								<td>${configFreeReturnPage.enterpriseName}</td>
								<td>xxx</td>
								<td>${factorLoanVo.actualLoanAmount}</td>
								<td>${configFreeReturnPage.rate}</td>
								<td>${configFreeReturnPage.reductionRate}</td>
								<td>${factorLoanVo.actualLoanAmount * (configFreeReturnPage.rate - configFreeReturnPage.reductionRate)}</td>
							</tr>
					</table>
				</div>
			</div>
		</div><br/>
		<div class="bottom-line"></div>
		<br/>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="xxx" class="protext w688"></textarea></div>
		</div>
		<div class="ground-form mb20">
				<div class="form-grou"><label class="label-long2">上传凭证：</label>
					<img id='licensePhoto' class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
				
				<div id='licensePhoto_div'></div>
			</div>
		</div>
		
		
				<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab8_1" class="btn-add">上一页</a>
					<a href="#" id="tab8_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
	</div>
	
</body>
		<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>
</html>