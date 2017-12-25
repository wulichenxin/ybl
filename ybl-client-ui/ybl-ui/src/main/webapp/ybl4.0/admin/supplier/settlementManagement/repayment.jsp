<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>还款</title>
</head>

<body>
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--top end -->
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />还款详情
		</div>
	</div>

	<div class="w1200">
		<p class="protitle">
			<span>还款详情信息</span>
		</p>
		<div class="ground-form mb20 pd20 ground-label">
			<div class="form-grou mr40">
						<label class="label-long2">放款申请单号：</label><input readonly="readonly" class="content-form2"
							value="${entity.loan_apply_order_no}" />
					</div>
			<div class="form-grou mr40">
				<label class="label-long2">还款期数：</label><input readonly="readonly" class="content-form2"
							value="${entity.period}" /><span class="timeimg">期</span>
			</div>
			
		</div>
		
		<div class="ground-form mb20 pd20 ground-label">
		<div class="form-grou mr40">
						<label class="label-long2">本次应还款金额：</label><input readonly="readonly" class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_principal}' pattern='#,##0.##' maxFractionDigits='2'/>"/>
							<span class="timeimg">元</span>
					</div>
			<div class="form-grou mr40">
				<label class="label-long2">本期应还利息：</label><input readonly="readonly" class="content-form2"
							value="<fmt:formatNumber value='${entity.repayment_interest}' pattern='#,##0.##' maxFractionDigits='2'/>"/>
							<span class="timeimg">元</span>
			</div>
		</div>

		<div class="ground-form mb20 pd20 ground-label">
			<div class="form-grou mr40">
				<label class="label-long2">逾期天数：</label><input readonly="readonly" class="content-form2"
							value="${entity.overdue_days}"/>
							<span class="timeimg">天</span>
			</div>
			<div class="form-grou mr40">
				<label class="label-long2">逾期费用：</label><input readonly="readonly" class="content-form2"
							value="<fmt:formatNumber value='${entity.overdue_fee}' pattern='#,##0.##' maxFractionDigits='2'/>"/>
							<span class="timeimg">元</span>
			</div>
		</div>


		<div class="bottom-line"></div>
		<div id="datas" class="pd20 mt40">
			<input id="id" type="hidden" name="id_" value="${entity.id_}" />
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">本次实际支付金额：</label><input class="content-form2" value="<fmt:formatNumber value="${entity.actual_amount}" pattern="#,##0.##" maxFractionDigits="2" />" />
					<span class="timeimg">元</span>
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">支付时间：</label><input class="content-form2" value="<lzq:date value='${entity.actual_repayment_date}' parttern='yyyy-MM-dd'/>"/>
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">交易流水号：</label><input class="content-form2" value="${entity.transaction_order_no}"/>
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户行：</label><input value="${entity.bank}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户名称：</label><input
						value="${entity.bank_account_name}" class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户银行账号：</label><input
						value="${entity.bank_account}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label><textarea class="protext w688">${entity.remark}</textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">上传凭证：</label><a id="down" href="#"><img id="upfile"
						class="uploadimg" style="width: 182px; height: 122px;"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" /></a>
				</div>
			</div>

			<div class="btn1 mt40 clearfix">
				<a id="cancel"
					class="btn-add btn-center">返回</a>
			</div>
		</div>

	</div>


	<div class="mb80"></div>


</body>

<script type="text/javascript">
$('#date').datetimepicker({
	yearOffset: 0,
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
	minDate: '1970-01-01', // yesterday is minimum date
	maxDate: '2099-12-31' // and tommorow is maximum date calendar
});

$(function(){
	var id = $("#id").val();
	$.ajax({
		url : '/rePayMentController/appendixRepayment',
		type : 'POST', //GET
		async : true, //或false,是否异步
		data : {id:id},
		timeout : 5000, //超时时间
		dataType : 'json',
		success : function(data) {
			if(data.responseType == "SUCCESS"){
				if(data.object !=null){
					/* if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(data.info)){
						$("#upfile").attr("src",data.info)	
					}else{ */
						$("#upfile").attr("src","/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
					//}
					$("#down").attr("href","/fileDownloadController/downloadftp?id="+data.object.id_);
				}
				
			}
		}
	});
	
	$("#cancel").click(function(){
		top.history.back();
		//window.parent.frames.location.href="/rePayMentController/pendingPayment.htm";
	});
});

</script>

</html>