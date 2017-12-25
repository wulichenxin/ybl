<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<html>

<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>

	<%@include file="/ybl4.0/admin/common/link.jsp"%>
	<!--弹出框-->
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/ajaxfileupload.js"></script> --%>

	<%-- <div class="w1200">
		<ul class="clearfix iconul">
			<li class="iconlist" url="/financingToConfirm/loanappictionitem?loanApplyId=${loanApply.id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectTotalElemets?type=${loanApply.assetsType}&loanApplyId=${loanApply.id}"><div class="proicon bg2 statusTwo"></div>资方办理</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectAssetAttach?loanApplyId=${loanApply.id}"><div class="proicon bg3 statusThree"></div>资产转让确权</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectPlatAudiByLoanOrderId?loanApplyId=${loanApply.id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectSettleInfoByLoanOrderNo?orderNo=${loanApply.orderNo }&financingAmount=${loanApply.financing_amount}"><div class="proicon bg5 statusThree"></div>结算放款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/info?id_=${entity.id}&financingAmount=${loanApply.financing_amount}"><div class="proicon bg6 statusThree"></div>收款确认</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg7 statusTwo"></div>还款计划</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg8 statusThree"></div>还款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg8 statusThree"></div>还款确认</li>
		</ul>

	</div> --%>


	<div class="w1200">
		<p class="protitle">
			<span>结算放款信息</span>
		</p>

		<div class="bottom-line"></div>

		<div class="pd20 mt40">
			<input type="hidden" id="confirm_id" value="${entity.id}">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">实际放款金额：</label><input
						readonly="readonly" class="content-form2"
						value="<fmt:formatNumber value='${entity.actualLoanAmount}' pattern='#,##0.##' maxFractionDigits='2'/>" /><span class="timeimg">元</span>
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">保理融资费：</label><input readonly="readonly"
						class="content-form2" value="<fmt:formatNumber value='${entity.factoringFee}' pattern='#,##0.##' maxFractionDigits='2'/>" /><span
						class="timeimg">元</span>
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">实际放款时间：</label><input
						readonly="readonly" class="content-form2"
						value="<lzq:date value='${entity.actualLoanDate}' parttern='yyyy-MM-dd'/>" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">交易流水：</label><input readonly="readonly"
						class="content-form2" value="${entity.transactionOrderNo}" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户行：</label><input
						readonly="readonly" class="content-form2" value="${entity.bank}" />
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户名称：</label><input
						readonly="readonly" class="content-form2"
						value="${entity.bankAccountName}" />
				</div>
				<div class="form-grou">
					<label class="label-long2">付款单位账户银行账号：</label><input
						readonly="readonly" class="content-form2"
						value="${entity.bankAccount}" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label>
					<textarea readonly="readonly" class="protext w688">${entity.remark}</textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">上传凭证：</label><a href="/fileDownloadController/downloadftp?id=${attachment.id}"><img id="enfile"
						style="width: 182px; height: 122px;" class="uploadimg" src="${attachment.url}"/></a>
				</div>
			</div>
			<div class="mb80"></div>
			<p class="protitle">
				<span>平台费用 = 实际放款金额 × （平台费率 - 减免费率）</span>
			</p>
			<div class="tabD">
				<table>
					<tr>
						<td>序号</td>
						<th>融资方名称</th>
						<th>融资金额</th>
						<th>实际放款金额</th>
						<th>平台费率</th>
						<th>减免费率</th>
						<th>平台使用费</th>
					</tr>
					<tr>
						<td>1</td>
						<td>${platformConfigFree.enterpriseName}</td>
						<td><fmt:formatNumber value='${loanApply.financing_amount}' pattern='#,##0.##' maxFractionDigits='2'/></td>
						<td><fmt:formatNumber value='${entity.actualLoanAmount}' pattern='#,##0.##' maxFractionDigits='2'/></td>
						<td><fmt:formatNumber value='${platformConfigFree.rate}' pattern='#,##0.####' maxFractionDigits='4'/></td>
						<td><fmt:formatNumber value='${platformConfigFree.reductionRate}' pattern='#,##0.####' maxFractionDigits='4'/></td>
						<td><fmt:formatNumber value='${plat_free}' pattern='#,##0.##' maxFractionDigits='2'/></td>
					</tr>
				</table>
			</div>

		</div>

		<p class="protitle">
			<span>请确认收到融资款</span>
		</p>
		<div class="pd20 mt40">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label>
					<textarea name="remark" id="remark" class="protext w688"></textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">上传收款确认附件：</label>
					<!-- <input id="upfileIn"
						type="file" style="display: none;"> -->
					<img id="upfile"  style="width: 182px; height: 122px;" class="uploadimg"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				</div>
			</div>
		</div>

		<div class="btn3 mt40 clearfix">
			<a id="per_page" href="javascript:;" class="btn-add btn-center">上一页</a>
			<a id="submit" href="javascript:;" class="btn-add btn-center">确认</a>
			<a id="cancel" href="javascript:;"
				class="btn-add btn-center">返回</a>
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

	<%-- <div class="w1200 ybl-info" style="display:none;">
		<form id="pageForm" action="/financingToConfirm/list" method="post">
			<div id="query" class="btn-found">查询</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>放款单号：</label><input class="content-form" name="order_no" value="${parm.order_no}"/></div>
				<div class="form-grou"><label class="label-long">申请时间：</label><input name="begin_date" value="${parm.begin_date}" id="beginDate" class="content-form" /><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr40"><input name="end_date" value="${parm.end_date}" id="endDate" class="content-form" /><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" /></div>
			</div>
			
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>保理类型：</label>
				<select name="factoring_mode" class="content-form">
					<option <c:if test="${empty parm.factoring_mode}">selected="selected"</c:if> value="">全部</option>
					<option <c:if test="${parm.factoring_mode eq 1}">selected="selected"</c:if> value="1">明保</option>
					<option <c:if test="${parm.factoring_mode eq 2}">selected="selected"</c:if> value="2">暗保</option>
				</select></div>
			</div>
			</form>
		</div> --%>


</body>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/serviceAuth.js"></script>

<script type="text/javascript">
	$(".iconlist").click(function() {
		window.location.href = "" + $(this).attr("url");
	});

	$("#per_page").click(function() {

	});

	$("#cancel").click(function() {
		window.history.back(-1);
	});

	$(function() {
		/* if (/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test('${attachment.url}')) {
			$("#enfile").attr("src", '${attachment.url}')
		} else { */
		$("#enfile").attr("src","/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
		//}
	});

	$("#submit")
			.click(
					function() {
						var id = "${loanApply.id}";
						var remark = $("#remark").val();
						var data = new Object;
						data["id"] = id;
						if ($("#upfile_div").children().length >= 1) {
							$("#upfile_div").children().each(
									function() {
										data["" + $(this).attr("name")] = $(
												this).val();
									});
							data["remark"] = remark;
						} else {
							alert("上传附件不成功");
							return false;
						}
						data["batch_no"] = "${entity.batch_no}";
						data["orderNo"] = "${loanApply.orderNo}";
						data["rate"] = ${platformConfigFree.rate};
						data["reductionRate"] = ${platformConfigFree.reductionRate};
						data["paidPlatformFee"] = ${plat_free};
						$.ajax({
							url : '/financingToConfirm/uploadConfirm',
							type : 'POST', //GET
							async : true, //或false,是否异步
							data : data,
							timeout : 5000, //超时时间
							dataType : 'json',
							success : function(data) {
								alert(data.info,function(){
									if (data.responseType == "SUCCESS") {
										window.parent.frames.location.href = "/financingToConfirm/list"
									}else{
										return false;
									}
								});
							}
						});
					});
</script>

</html>