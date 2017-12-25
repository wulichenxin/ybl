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
		
		<input type="hidden" id="platformFee" name="platformFee"/>
		<div style="width: 950px;margin: auto;">
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">实际放款金额：</label><input class="content-form2" name="actualLoanAmount" value="${paymentBatch.actualLoanAmount}" /><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form" name="actualLoanDate" value="${paymentBatch.actualLoanDate}"/></div>
					</div>
					<div class="ground-form mb20">
									<div class="form-grou mr40">
					<label class="label-long2">保理手续费：</label><input readonly="readonly"
						class="content-form2" value="${paymentBatch.factoringFee}" /><span
						class="timeimg">元</span>
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">融资使用费：</label><input readonly="readonly"
						class="content-form2" value="${paymentBatch.financingFee}" /><span
						class="timeimg">元</span>
				</div>
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
					<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${paymentBatch.remark}</textarea></div>
				</div>
				<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">支付附件：</label>
							<div id='licensePhoto'>
								<img class="uploadimg" src="${attachment.url_ }" />
							</div>
						</div>
						<div id='licensePhoto_div'></div>
					</div>
			</div>
			
			<div class="mb80"></div>
			<p class="protitle"><span></span>平台费用  = 实际放款金额 × （平台费率 - 减免费率）</p>
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
		<!-- 图片上传 部分 end -->
		<script type="text/javascript">
		
		$(function(){
			/* $("input[name='actualLoanAmount']").change(function(){
				$("#actualLoanAmount").html($(this).val());
				$("#platformFeeTD").html(Math.floor(Number($(this).val()) * (Number(rate)-Number(reductionRate))*100)/100);
				$("#platformFee").val($("#platformFeeTD").html());
			}); */
			$('#actualLoanDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			//保存按钮
			/* $("#save_btn").click(function(){
				var formdata=$('#subPageForm').serialize();//序列化表单
				$.ajax({
					url:'/factorLoanManagementController/loanBatchPending/settlement',
					dataType:'json',
					type:'post',
					data:formdata,
					success:function(data){
						if(data.responseTypeCode == "success"){
							alert(data.info, function() {
								//列表页刷新
								parent.location.href='/factorLoanManagementController//loanBatchPending/list.htm';
								//关闭弹出框
								//dialog.close();
							});
						}else{
							alert(data.info);
						}					
					}
				});
			});
			$('.close-out').click(function(){
				dialog.close();
			}) */
			/**
			 * 图片上传statrt
			 */
			// 监听图片上传按钮
			/* $("#common_upload_btn")
					.watchProperty(
							"value",
							function() {
								var v = $(this).val();
								if (v == '' || v == null)
									return;
								// 上传
								$("#common_upload_form")
										.attr("action",
												"/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadCallback");
								$("#common_upload_form").submit();
								$(this).val('');
							});
			// 点击图片上传图片
			$("#licensePhoto").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			var num = 0; 
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var photoUpdateId = $("#" + id).attr("attachId");
				$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				if (id == "licensePhoto") {
					num = 1;
				} else {
					num = 0;
				}
				var html_ = "<input type='hidden' value='" + attachment.url_
						+ "' name='attachmentList[" + num + "].url_'/>"
						+ "<input type='hidden' value='userV2Certificate_" + id
						+ "' name='attachmentList[" + num + "].type_'/>"
						+ "<input type='hidden' value='" + attachment.old_name
						+ "' name='attachmentList[" + num + "].old_name'/>"
						+ "<input type='hidden' value='" + attachment.new_name
						+ "' name='attachmentList[" + num + "].new_name'/>"
						+ "<input type='hidden' value='" + attachment.ext_name
						+ "' name='attachmentList[" + num + "].ext_name'/>";
						+ "<input type='hidden' value='" + attachment.file_size
						+ "' name='attachmentList[" + num + "].fileSize'/>";
				if (photoUpdateId && photoUpdateId != '' && photoUpdateId != null) {
					html_ += "<input type='hidden' value='" + photoUpdateId
							+ "' name='attachmentlist[" + num + "].id'/>"// 更新时有图片id
				}
				$("#" + id + "_div").empty().html(html_);
			}*/
			// 图片上传end
		})
		</script>
	</body>
</html>