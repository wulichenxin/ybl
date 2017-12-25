<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>还款</title>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<!--top end -->
<body>
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />还款
		</div>
	</div>

	<div class="jeout" style="position: absolute;">
		<div class="tabD">
			<table>
				<tr>
					<th>序号</th>
					<th>还款日期</th>
					<th>还款金额（元）</th>
					<th>交易流水号</th>
					<th>还款确认</th>
					<th>还款确认时间</th>
					<th>备注</th>
					<th>操作人</th>
				</tr>
				<c:set var="count" value="0"></c:set>
				<c:forEach items="${hasPayMents}" var="has" varStatus="status">
					<c:set var="count" value="${count+has.actual_amount}"></c:set>
					<tr>
						<td>${status.count}</td>
						<td><lzq:date value='${has.repayment_date}'
								parttern='yyyy-MM-dd' /></td>
						<td><fmt:formatNumber value="${has.actual_amount}"
								pattern="##0.00" maxFractionDigits="2" /></td>
						<td>${has.transaction_order_no}</td>
						<td><c:if test="${has.confirm_status eq 1}">否</c:if> <c:if
								test="${has.confirm_status eq 2}">是</c:if></td>
						<td><lzq:date value='${has.confirm_repayment_date}'
								parttern='yyyy-MM-dd' /></td>
						<td>${has.remark}</td>
						<td>${has.real_name}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<div class="w1200">
		<p class="protitle">
			<span>还款</span>
		</p>

		<c:forEach items="${noPayMents}" var="entity">
			<c:if test="${entity.id_ eq id}">
				<input id="overdue_days" type="hidden" name="overdue_days"
					value="${entity.overdue_days}" />
					
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">放款申请单号：</label><input
							readonly="readonly" class="content-form2"
							value="${entity.loan_apply_order_no}" />
					</div>
				</div>
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">资金方：</label><input readonly="readonly"
							class="content-form2" value="${entity.financing_name}" />
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">核心企业：</label><input
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
						<label class="label-long2">本次应还利息：</label><input
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
						<label class="label-long2">本次应还款金额：</label><input
							 readonly="readonly"
							class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_count}' pattern='##0.##' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
				</div>

				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">计划还款日：</label><input
							readonly="readonly" class="content-form2"
							value="<lzq:date value='${entity.repayment_date}' parttern='yyyy-MM-dd'/>" />
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">还款状态：</label><input
							readonly="readonly" class="content-form2"
							value="<c:if test='${entity.repayment_status eq 1}'>待还款</c:if><c:if test='${entity.repayment_status eq 2}'>待确认</c:if><c:if test='${entity.repayment_status eq 3}'>已逾期</c:if><c:if test='${entity.repayment_status eq 4}'>催收中</c:if><c:if test='${entity.repayment_status eq 5}'>坏账</c:if><c:if test='${entity.repayment_status eq 6}'>已还款</c:if>"/>
					</div>
				</div>
				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr40">
						<label class="label-long2">已还款金额：</label><input
							readonly="readonly" style="color: #DCC28A;"
							class="content-form2 yhkje"
							value="<fmt:formatNumber value='${count}' pattern='##0.00' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">待还款金额：</label><input
							readonly="readonly" class="content-form2 color-label-blue"
							value="<fmt:formatNumber value='${repayment_wait}' pattern='##0.00' maxFractionDigits='2'/>" />
						<span class="timeimg">元</span>
					</div>
				</div>
			</c:if>
		</c:forEach>


		<div class="bottom-line"></div>
		<div id="datas" class="pd20 mt40">
			<input type="hidden" name="id_" value="${id}" />
			<input type="hidden" id="returnPage" value="${returnPage}" />
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2"><a style="color: red">*</a>本次实际支付金额：</label><input
						name="actual_amount" class="content-form2 required number" /><span
						class="timeimg">元</span>
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2"><a style="color: red">*</a>交易流水号：</label><input
						name="transaction_order_no" class="content-form2 required" />
				</div>
				<div class="form-grou ">
					<label class="label-long2">付款单位账户开户行：</label><input name="bank"
						class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户名称：</label><input
						name="bank_account_name" class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户银行账号：</label><input
						name="bank_account" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label>
					<textarea name="remark" class="protext w688"></textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">上传凭证：</label><img id="upfile"
						class="uploadimg" style="width: 182px; height: 122px;"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
			</div>

			<div class="btn3 mt40 clearfix">
				<a id="per_page" href="javascript:;" class="btn-add btn-center">上一页</a>
				<a id="submit" href="javascript:;" class="btn-add btn-center">确认</a>
				<a id="cancel" href="javascript:;"
					class="btn-add btn-center">返回</a>
			</div>
		</div>

	</div>


	<div class="mb80"></div>
	<!-- 图片上传 部分 start -->
	<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
	<form style="display: none;" id="common_upload_form"
		enctype="multipart/form-data" method="post" target="common_iframe">
		<input id="common_upload_btn" type="file" name="file"
			style="display: none;" />
	</form>

	<div id="upfile_div"></div>


</body>

<script type="text/javascript">
$(function (){
	$("#submit").click(
			function() {repayment_interest
				var data = new Object;
				var days = $("#overdue_days").val();
				var principal = $("#repayment_principal").val();
				
				var interest = $("#repayment_interest").val();

				if ($("#datas").find("input,textarea").length >= 1) {
					$("#datas").find("input,textarea").each(
							function() {
								data["" + $(this).attr("name")] = $(
										this).val();
							});
				}
				if ($("#upfile_div").find("input").length >= 1) {
					$("#upfile_div").find("input").each(
							function() {
								data["" + $(this).attr("name")] = $(
										this).val();
							});
				} else {
					alert("上传附件不成功");
					return false;
				}
				data["loan_apply_order_no"] = "${order_no}";
				data["repayment_principal"] = principal;
				data["overdue_days"] = days;
				if (data["actual_amount"] == null
						|| data["actual_amount"] == "") {
					alert("本次实际支付金额不能为空");
					return false;
				}
				var reg = /^\d+(\.\d+)?$/;
				if (reg.test(data["actual_amount"]) != true) {
					alert("实际支付金额必须为数字");
					return false;
				}
				if (data["transaction_order_no"] == null
						|| data["transaction_order_no"] == "") {
					alert("交易流水号不能为空");
					return false;
				}
				if (Number(data["repayment_principal"])+Number(interest) > Number(data["actual_amount"])) {
					alert("本次实际支付金额不能小于本次应还金额加利息");
					return false;
				}
				$.ajax({
					url : '/rePayMentController/uploadRepay',
					type : 'POST', //GET
					async : true, //或false,是否异步
					data : data,
					timeout : 5000, //超时时间
					dataType : 'json',
					success : function(data) {
						alert(data.info, function(){
							if (data.responseType == "SUCCESS") {
								window.parent.frames.location.href = "/rePayMentController/pendingPayment.htm"
							}else{
								return false;
							}
						});
					}
				});
			});

/**
* 图片上传statrt
*/
// 监听图片上传按钮
$("#common_upload_btn")
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
$("#upfile").click(function() {
id = $(this).attr("id");
$("#common_upload_btn").click();
});
//var num = 0;
// 回调，回显图片
uploadCallback = function(obj) {
var attachment = eval('(' + obj + ')');
$("#common_upload_btn").val('');
var photoUpdateId = $("#" + id).attr("attachId");
if (/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(attachment.url_)) {
	$("#upfile").attr("src", attachment.url_)
} else {
	$("#upfile").attr("src",
			"/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
}
var html_ = "<input type='hidden' value='" + attachment.url_
		+ "' name='url'/>"
		+ "<input type='hidden' value='" + attachment.old_name
		+ "' name='oldName'/>"
		+ "<input type='hidden' value='" + attachment.new_name
		+ "' name='newName'/>"
		+ "<input type='hidden' value='" + attachment.ext_name
		+ "' name='extName'/>"
		+ "<input type='hidden' value='" + attachment.file_size
		+ "' name='fileSize'/>";
$("#upfile_div").empty().html(html_);
}

$("#cancel")
	.click(
			function() {
				var returnPage = $("#returnPage").val();
				if(returnPage != null && returnPage == "enterpriseIndex"){
					window.location.href='/enterpriseIndexV4Controller/enterpriseIndex.htm';
				}else{
					window.parent.frames.location.href = "/rePayMentController/pendingPayment.htm";	
				}
				
			});
});
</script>

</html>