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
	<div style="width: 950px;margin: auto;">
		<input type="hidden" id="repayAmout" value="${repay.repaymentPrincipal + repay.repaymentInterest}"/>
		<input type="hidden" id="id" value="${repay.id}"/><!-- 还款计划的id -->
		<input type="hidden" id="applyId" value="${id}"/><!-- 融资申请id -->
		<input type="hidden" id="repay_attach_upload_info" value=""/><!-- 还款上传的附件信息 -->
		<input type="hidden" id="loanApplyOrderNo" value="${repay.loanApplyOrderNo}" /> <!-- 放款申请单号 -->
		<input type="hidden" id="financingAmount" value="${financingAmount }"/> <!-- 融资申请金额 -->
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label>资金方：</label>${financingName }</div>
			<div class="form-grou"><label>核心企业：</label>${repay.coreEnterpriseName}</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">放款申请单号： </label>${repay.loanApplyOrderNo}</div>
			<div class="form-grou mr40"><label class="label-long">本次应还金额： </label>${repay.repaymentPrincipal + repay.repaymentInterest + overfee}</div>
			<div class="form-grou mr40"><label>还款状态： </label>${repay.repaymentStatus}</div>
			<div class="form-grou"><label>计划还款日：</label><fmt:formatDate value="${repay.repaymentDate}" pattern="yyyy-MM-dd" /></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">待还款金额：</label><fmt:formatNumber value="${total_repay_amout }" pattern="##0.00" maxFractionDigits="2"/></div>
			<div class="form-grou"><label class="label-long">已还款金额：</label><fmt:formatNumber value="${total_payed_amout}" pattern="##0.00" maxFractionDigits="2"/></div>
		</div>
		<div class="bottom-line"></div><br/>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">本次实际还款金额：</label><input name="actualAmount" id="actualAmount" class="content-form" value="${repay.actualAmount}"/></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">实际还款日期：</label><input id="beginDate" name="actualRepaymentDate" id="actualRepaymentDate" class="content-form" value="<fmt:formatDate value="${repay.actualRepaymentDate}" pattern="yyyy-MM-dd" />" /></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long">交易流水号：</label><input name="transactionOrderNo" id="transactionOrderNo" class="content-form" value="${repay.transactionOrderNo}"/></div>
			<div class="form-grou"><label class="label-long2">付款单位账户开户行：</label><input name="bank" id="bank" class="content-form" value="${repay.bank}"/></div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input name="bankAccountName" id="bankAccountName" class="content-form" value="${repay.bankAccountName}"/></div>
			<div class="form-grou"><label class="label-long2">付款单位账户银行账号：</label><input name="bankAccount" id="bankAccount" class="content-form" value="${repay.bankAccount}"/></div>
		</div>
		
		<div class="ground-form mb20">
			<c:if test="${not empty repay.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="receivAmoutRemark"  class="protext w688">${repay.remark }</textarea></div>
			</c:if>
			<c:if test="${empty repay.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="receivAmoutRemark"  class="protext w688"></textarea></div>
			</c:if>
		</div>
		
		<c:if test="${not empty repayAttach.url_}">
			<div class="ground-form mb20">
				<div class="form-grou"><label class="label-long2">收款确认附件：</label>
					<img class="uploadimg" src="${repay.url_ }" />
				</div>
			</div>
		</c:if>
		<c:if test="${empty repayAttach.url_}">
			<div class="ground-form mb20">
				<div class="form-grou"><label class="label-long2">上传凭证：</label>
					<img id='licensePhoto' class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
				<div id='licensePhoto_div'></div>
			</div>
			<div class="bottom-line"></div>

			<div class="process">
					<div class="btn3 clearfix mb80">
						<a href="javascript:;" class="btn-add" id="btn-pay-submit">还款</a> 
						<a href="javascript:;" class="btn-add">取消</a>
					</div>
				</div>
				<!-- </form> -->
			</div>
			
			<!-- 图片上传 部分 start -->
			<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
			<form style="display: none;" id="common_upload_form"
				enctype="multipart/form-data" method="post" target="common_iframe">
				<input id="common_upload_btn" type="file" name="file"
					style="display: none;" />
			</form>
		</c:if>
	</div>	
	<script type="text/javascript">
	$(function(){	
		$('#beginDate,#endDate').datetimepicker({
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		});
		
		//submit form
		$("#btn-pay-submit").click(function(){
			var repayAmout = $("#repayAmout").val();
			var actualAmount = $("#actualAmount").val();
			if(Number(actualAmount) < Number(repayAmout)) {
				alert("实际还款金额不能小于本次应还金额");
				return;
			}
			var actualRepaymentDate = $("#beginDate").val();
			var transactionOrderNo = $("#transactionOrderNo").val();
			var bank = $("#bank").val();
			var bankAccountName = $("#bankAccountName").val();
			var bankAccount = $("#bankAccount").val();
			var remark = $("#remark").val();
			if($("#id").val()) {
				$.ajax({
					url:'/supplierAccountCenterController/updateRepayStatus',
					dataType:'json',
					type:'post',
					data:{
						"id":$("#id").val(),
						"actualAmount":actualAmount,
						"actualRepaymentDate":actualRepaymentDate,
						"transactionOrderNo":transactionOrderNo,
						"bank":bank,
						"bankAccountName":bankAccountName,
						"bankAccount":bankAccount,
						"remark":remark,
						"loanApplyOrderNo":$("#loanApplyOrderNo").val(),
						"repay_attach_upload_info":$("#repay_attach_upload_info").val()
						},
					success:function(data){
						if(data.responseTypeCode == "success"){
							alert(data.info,function(){
								location.href='/supplierAccountCenterController/supplierreceiving.htm';
							});
						}else{
							alert(data.info);
						}					
					}
				}); 
			}	
		});
		
		// 监听图片上传按钮
		$("#common_upload_btn").watchProperty("value",
			function() {
				var v = $(this).val();
				if (v == '' || v == null)
					return;
				// 上传
				$("#common_upload_form").attr("action","/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadCallback");
				$("#common_upload_form").submit();
				$(this).val('');
		});
		// 点击图片上传图片
		$("#licensePhoto").click(function() {
			id = $(this).attr("id");
			$("#common_upload_btn").click();
		});
		// 回调，回显图片
		uploadCallback = function(obj) {
			$("#repay_attach_upload_info").val(obj);
			var attachment = eval('(' + obj + ')');
			$("#licensePhoto").attr('src',attachment.url_); 
		}
		// 图片上传end
	});
		
	</script>
</body>

</html>