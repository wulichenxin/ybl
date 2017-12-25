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
	<form action="" id="subPageForm" method="post">
		<input type="hidden" id="financingAmount" value="${financingAmount}"/> <!-- 融资放款金额 -->
		<input type="hidden" id="loan_apply_id" value="${paymentBatch.id}"/> <!-- 放款申请id -->
		<input type="hidden" id="batch_no" value="${paymentBatch.attribute1}"/> <!-- 批次编号 -->
		<input type="hidden" id="rate" value="${platformConfigFree.rate}"/> <!-- 平台费率 -->
		<input type="hidden" id="reductionRate" value="${platformConfigFree.reductionRate}"/> <!-- 减免费率 -->
		<input type="hidden" id="paidPlatformFee" value="${plat_free}"> <!-- 平台费用 -->
		<input type="hidden" id="recevie_confire_attch" value=""/><!-- 收款确认上传附件信息 -->
		<div style="width: 950px;margin: auto;">
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">实际放款金额：</label><input class="content-form2" name="actualLoanAmount" value="${paymentBatch.actualLoanAmount}" readonly="readonly"/><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form2" name="actualLoanDate" value="${paymentBatch.actualLoanDate}" readonly="readonly"/></div>
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
					<div class="form-grou mr40"><label class="label-long2">交易流水号：</label><input class="content-form2"  name="transactionOrderNo" value="${paymentBatch.transactionOrderNo}" readonly="readonly"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><input class="content-form2"  name="bank" value="${paymentBatch.bank}" readonly="readonly"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input class="content-form2"  name="bankAccountName" value="${paymentBatch.bankAccountName}" readonly="readonly"/></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><input class="content-form2"  name="bankAccount" value="${paymentBatch.bankAccount}" readonly="readonly"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark" disabled="disabled">${paymentBatch.remark}</textarea></div>
				</div>
				<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">支付附件：</label>
							<div id='licensePhoto123'>
								<a href="/fileDownloadController/downloadftp?id=${attachment.id }" >
								<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
								<%-- <img class="uploadimg" src="${attachment.url_ }" /> --%>
							</div>
						</div>
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
		
		<div class="bottom-line"></div>
		<br/>
		<div class="ground-form mb20">
			<c:if test="${not empty receiveConfirmAttach.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="receivAmoutRemark" id="receivAmoutRemark" class="protext w688">${receiveConfirmAttach.remark }</textarea></div>
			</c:if>
			<c:if test="${empty receiveConfirmAttach.remark}">
				<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea name="receivAmoutRemark" id="receivAmoutRemark" class="protext w688"></textarea></div>
			</c:if>
		</div>
		<c:if test="${not empty receiveConfirmAttach.id}">
			<div class="ground-form mb20">
				<div class="form-grou"><label class="label-long2">收款确认附件：</label>
					<div id='licensePhoto'>
						<c:if test="${not empty receiveConfirmAttach.id }">
							<a href="/fileDownloadController/downloadftp?id=${receiveConfirmAttach.id }" >
						</c:if>
						<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
					</div>
					<%-- <img class="uploadimg" src="${receiveConfirmAttach.url }" width="182px" height="122px"/> --%>
				</div>
			</div><br/>
			<!-- <div class="btn3 clearfix mb80"> -->
				<a href="#" class="btn-add btn-center" id="btn-19">下一页</a>
				<!-- <a href="#" id="btn-return" class="btn-add" >返回</a> -->
			<!-- </div> -->
		</c:if>
		<c:if test="${empty receiveConfirmAttach.id}">
			<div class="ground-form mb20">
				<div class="form-grou"><label class="label-long2">上传收款确认附件：</label>
					<img id='licensePhoto' class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
				<div id='licensePhoto_div'></div>
			</div>
			<div class="process">
				<div class="btn3 clearfix mb80">
					<a href="javascript:;" class="btn-add" id="btn-confirm-receive">确认</a> 
					<a href="javascript:;" class="btn-add" id="btn-cancel">取消</a>
				</div>
			</div>
			<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
			<form style="display: none;" id="common_upload_form"
				enctype="multipart/form-data" method="post" target="common_iframe">
				<input id="common_upload_btn" type="file" name="file"
					style="display: none;" />
			</form>
		</c:if>
		</div>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#btn-19").click(function(){
					$('.iconlist', parent.document).removeClass('pro_li_cur');
					$('#iconlist2', parent.document).addClass('pro_li_cur');
					var orderNo=$('#orderNo', parent.document).val();
					window.location.href="/tabDetailController/selectRepayPlanByLoanOrderNo?orderNo=" + orderNo;
				});
			});
		</script>
		<script type="text/javascript">
		$(function(){
			//取消
			$("#btn-cancel").click(function(){
				window.parent.location.href="/supplierAccountCenterController/receivingacount.htm";
			});
			
			/**
			* 确认待收款事件
			*/
			$("#btn-confirm-receive").click(function(){
				var loanApplyId=$('#loan_apply_id', parent.document).val();
				var uploadInfo = $("#recevie_confire_attch").val();
				if(uploadInfo == ''){
					alert("请上传收款确认附件");
					return;
				}
				if(loanApplyId) {
					$.ajax({
						url:'/supplierAccountCenterController/updateLoanApplyStatus',
						dataType:'json',
						type:'post',
						data:{
							"id":loanApplyId,//放款申请id
							"batch_no":	$("#batch_no").val(),//批次编号
							"orderNo":	$('#orderNo', parent.document).val(), //放款订单号
							"rate":	$("#rate").val(),//平台费率
							"reductionRate":	$("#reductionRate").val(),//减免费率
							"paidPlatformFee":	$("#paidPlatformFee").val(),//平台费用
							"receivAmoutRemark" : $("#receivAmoutRemark").val(), // 收款确认备注
							"recevie_confire_attch" :$("#recevie_confire_attch").val()//收款确认附件信息
						},
						success:function(data){
							if(data.responseTypeCode == "success"){
								alert(data.info,function(){
									location.href='/supplierAccountCenterController/receivingacount.htm';
								});
							}else{
								alert(data.info);
							}					
						}
					}); 
				}
			});
			/**
			 * 图片上传statrt
			 */
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
				$("#recevie_confire_attch").val(obj);
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