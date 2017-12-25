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
		$("#btn-3").click(function(){
			$('.iconlist', parent.document).removeClass('pro_li_cur');
			$('#iconlist2', parent.document).addClass('pro_li_cur');
			var loanApplyId=$('#loan_apply_id', parent.document).val();
			var type=$('#assetsType', parent.document).val();
			window.location.href="tabDetailController/selectTotalElemets?type=" + type + "&loanApplyId=" + loanApplyId;
		});
	});
</script>
<body>
	<div style="width: 950px;margin: auto;">
		<input type="hidden" id="repayAmout" value="${repay.repaymentPrincipal + repay.repaymentInterest}"/>
		<input type="hidden" id="id" value="${repay.id}"/><!-- 还款计划的id -->
		<input type="hidden" id="applyId" value="${id}"/><!-- 融资申请id -->
		<input type="hidden" id="repay_attach_upload_info" value=""/><!-- 还款上传的附件信息 -->
		<input type="hidden" id="loanApplyOrderNo" value="${repay.loanApplyOrderNo}" /> <!-- 放款申请单号 -->
		<input type="hidden" id="financingAmount" value="${financingAmount }"/> <!-- 融资申请金额 -->
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">资金方：</label>
				<input class="content-form" value="${financingName }" readonly="readonly"/>
			</div>
			<div class="form-grou"><label class="label-long2">核心企业：</label>
				<input class="content-form" value="${repay.coreEnterpriseName}" readonly="readonly"/>
			</div>
		</div>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">放款申请单号： </label>
				<input class="content-form2" value="${repay.loanApplyOrderNo}" readonly="readonly"/>
			</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">本次应还本金： </label>
				<input class="content-form" value="${repay.repaymentPrincipal }" readonly="readonly"/>
			</div>
			<div class="form-grou"><label class="label-long2">本次应还利息： </label>
				<input class="content-form" value="${repay.repaymentInterest }""  readonly="readonly"/>
			</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">本次逾期费用： </label>
				<input class="content-form" value="${overfee}" readonly="readonly"/>
			</div>
			<div class="form-grou"><label class="label-long2">本次应还金额： </label>
				<input class="content-form" value="${repay.repaymentPrincipal + repay.repaymentInterest + overfee}" readonly="readonly"/>
			</div>
		</div>
		<div class="ground-form-mb20">
			<div class="form-grou mr40"><label class="label-long2">还款状态： </label>
				<c:if test="${repay.repaymentStatus==1 }">
					<input class="content-form" value="待还款" readonly="readonly"/>
				</c:if>
				<c:if test="${repay.repaymentStatus==2 }">
					<input class="content-form" value="已还款" readonly="readonly"/>
				</c:if>
				<c:if test="${repay.repaymentStatus==3 }">
					<input class="content-form" value="已逾期" readonly="readonly"/>
				</c:if>
				<c:if test="${repay.repaymentStatus==4 }">
					<input class="content-form" value="催收中" readonly="readonly"/>
				</c:if>
				<c:if test="${repay.repaymentStatus==5 }">
					<input class="content-form" value="坏账" readonly="readonly"/>
				</c:if>
			</div>
			<div class="form-grou"><label class="label-long2">计划还款日：</label>
				<input id="repaymentDate" class="content-form" value="<fmt:formatDate value="${repay.repaymentDate}" pattern="yyyy-MM-dd" />" readonly="readonly"/>
			</div>
		</div><br/>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">待还款金额：</label>
				<input id="repaymentDate" class="content-form" value="${total_repay_amout }" readonly="readonly"/>
			</div>
			<div class="form-grou"><label class="label-long2">已还款金额：</label>
				<input id="repaymentDate" class="content-form" value="${total_payed_amout}" readonly="readonly"/>
			</div>
		</div>
		<div class="bottom-line"></div><br/>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2"><i style="color:red">*</i>本次实际还款金额：</label>
				<c:if test="${repay.actualAmount eq '0.0000' }">
					<input name="actualAmount" id="actualAmount" class="content-form" value=""/>
				</c:if>
				<c:if test="${repay.actualAmount ne '0.0000' }">
					<input name="actualAmount" id="actualAmount" class="content-form" value="${repay.actualAmount }"/>
				</c:if>
			</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2"><i style="color:red">*</i>实际还款日期：</label>
				<input name="actualRepaymentDate" id="actualRepaymentDate" class="content-form" value="<fmt:formatDate value="${repay.actualRepaymentDate}" pattern="yyyy-MM-dd" />" />
			</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2"><i style="color:red">*</i>交易流水号：</label>
				<input name="transactionOrderNo" id="transactionOrderNo" class="content-form" value="${repay.transactionOrderNo}"/>
			</div>
			<div class="form-grou"><label class="label-long2"><i style="color:red">*</i>付款单位账户开户行：</label>
				<input name="bank" id="bank" class="content-form" value="${repay.bank}"/>
			</div>
		</div>
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2"><i style="color:red">*</i>付款单位账户开户名称：</label>
				<input name="bankAccountName" id="bankAccountName" class="content-form" value="${repay.bankAccountName}"/>
			</div>
			<div class="form-grou"><label class="label-long2"><i style="color:red">*</i>付款单位账户银行账号：</label>
				<input name="bankAccount" id="bankAccount" class="content-form" value="${repay.bankAccount}"/>
			</div>
		</div>
		
		<div class="ground-form mb20">
			<c:if test="${not empty repayAttach.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label>
					<textarea name="remark" id="remark" class="protext w688">${repayAttach.remark }</textarea>
				</div>
			</c:if>
			<c:if test="${empty repayAttach.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label>
					<textarea name="remark" id="remark" class="protext w688"></textarea>
				</div>
			</c:if>
		</div>
		
		<c:if test="${not empty repayAttach.url}">
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long2">还款确认附件：</label>
					<%-- <img class="uploadimg" src="${repay.url_ }" /> --%>
					<a href="/fileDownloadController/downloadftp?id=${repayAttach.id }" >
					<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
				</div>
			</div>
		</c:if>
		<c:if test="${empty repayAttach.url}">
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label><i style="color:red">*</i>上传凭证：</label>
					<img id='licensePhoto' class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
				<div id='licensePhoto_div'></div>
			</div>
			<div class="bottom-line"></div>

			<div class="process">
					<div class="btn3 clearfix mb80">
						<a href="javascript:;" class="btn-add" id="btn-pay-submit">还款</a> 
						<a href="javascript:;" class="btn-add" id="btn-cancel">取消</a>
					</div>
				</div>
			</div>
			
			<!-- 图片上传 部分 start -->
			<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
			<form style="display: none;" id="common_upload_form"
				enctype="multipart/form-data" method="post" target="common_iframe">
				<input id="common_upload_btn" type="file" name="file"
					style="display: none;" />
			</form>
		</c:if>
		<!-- <div class="btn3 clearfix mb80">
			<a href="#" id="btn-3" class="btn-add">下一页</a>
			<a href="/factorLoanAuditController/loanAudit/loanAuditList.htm" class="btn-add" >返回</a>
		</div> -->
	</div>	
	<script type="text/javascript">
	$(function(){	
		
		$('#beginDate,#endDate,#actualRepaymentDate').datetimepicker({
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', 
			maxDate : '2099-12-31' 
		});
		
		//取消
		$("#btn-cancel").click(function(){
			//window.open("about:blank","_top").close();
			
			var pageFlag=$('#pageFlag', parent.document).val();
			if(pageFlag == '8') {
				window.parent.location.href="/supplierAccountCenterController/supplierreceiving.htm"; //待还款页面
			}
			if(pageFlag == '2') {
				window.parent.location.href="/supplierAccountCenterController/supplieroverdue.htm"; //逾期
			}
		});
		
		
		//submit form
		$("#btn-pay-submit").click(function(){
			var repayAmout = $("#repayAmout").val();
			var actualAmount = $("#actualAmount").val();
			if(Number(actualAmount) < Number(repayAmout)) {
				alert("实际还款金额不能小于本金与利息之和");
				return;
			}
			var actualRepaymentDate = $("#actualRepaymentDate").val();
			if(!actualRepaymentDate) {
				alert("请填写实际还款日期");
				return;
			}
			var transactionOrderNo = $("#transactionOrderNo").val();
			var bank = $("#bank").val();
			var bankAccountName = $("#bankAccountName").val();
			var bankAccount = $("#bankAccount").val();
			var remark = $("#remark").val();
			var uploadInfo = $("#repay_attach_upload_info").val();
			if(uploadInfo == '') {
				alert("请上传凭证附件");
				return;
			}
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
						"repaymentDate":$("#repaymentDate").val(),
						"loanApplyOrderNo":$("#loanApplyOrderNo").val(),
						"repay_attach_upload_info":$("#repay_attach_upload_info").val()
						},
					success:function(data){
						if(data.responseTypeCode == "success"){
							alert("还款成功",function(){
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
			//$("#licensePhoto").empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
			$("#licensePhoto").attr('src',attachment.url_); 
			$("#licensePhoto").attr('width','182px'); 
			$("#licensePhoto").attr('height','122px'); 
		}
		// 图片上传end
	});
		
	</script>
</body>

</html>