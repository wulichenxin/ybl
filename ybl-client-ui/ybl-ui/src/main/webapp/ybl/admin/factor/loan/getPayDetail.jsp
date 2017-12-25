<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.pay"/></title>
<jsp:include page="../../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script type="text/javascript">

$(function() {
	//结算金额 =融资金额
	var settlementAmount = ${financeApply.apply_amount };
	/* settlement = new Number(settlementAmount/10000).toFixed(2);
	$("#settlementAmount").html(settlement + '万元');//格式化 */ 
	//贷款天数 
	var startTime = new Date().getTime();
	var endTime = ${financeApply.repayment_date};
	var t =  endTime - startTime ;
	var days=Math.floor(t/1000/60/60/24);
	
	var oneDayfinanceFee = ${financeApply.apply_amount * financeApply.finance_ratio / 100 * financeApply.rate_ / 100 / 360 }
	
	//贷款费用
	var financeFee = oneDayfinanceFee * days;
	finance = new Number(financeFee).toFixed(2);//格式化
	$("#financeFee").html(finance + '元');
	//服务费用 
	var Fee = ${financeApply.apply_amount * financeApply.finance_ratio / 100 * financeApply.manage_rate / 100 }
	var fee = new Number(Fee).toFixed(2);//格式化
	$("#Fee").html(fee + '元');
	//放款总金额 
	var disbursementAmount = settlementAmount - financeFee - Fee;
	var disbursement = new Number(disbursementAmount).toFixed(2);
	$("#loanAmount").val(disbursement );
	
	
	$("#save").click(function(){
		//支付时间
		var payTime = $("#pay_time").val();
		var comment = $("#comment_").val();
		var loanAmount = $("#loanAmount").val();
		var financeApplyId = ${financeApply.id}
		
		//定义数组attachement
		var attachmentArray = '';
		var count = $("img").size();
		if(count < 1){
			alert($.i18n.prop("sys.client.upload.information"));
			return;
		}
		if(payTime == '' || payTime == null){
			alert($.i18n.prop("sys.client.paymentTime"));
			return ;
		}
		for(var i=0;i<count; i++){
			attachmentArray += $("img").eq(i).next().attr("value") + "#";
		}
		
		$.ajax({
	        url: '/ProductAuditController/saveDisbursement', 
	        data:{
	        	"balanceAmount":settlementAmount,//结算金额 
	        	"loanFee":financeFee,//贷款费用
	        	"manageFee":Fee,//服务费用
	        	"disbursementAmount":disbursementAmount,//放款总金额
	        	"financeApplyId":financeApplyId,
	        	"payTime":payTime, //支付时间
	        	"comment":comment,//备注
	        	"amount":loanAmount, //本次放款金额
	        	"attachmentArray":attachmentArray
	        	},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//保存成功
	        		alert(data.info,call_back);
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });
	});
	call_back = function(){
		window.location.href ="/ProductAuditController/queryPayList";
	}
	
});

 
$(function(){
	

	//监听图片上传按钮
	$("#common_upload_btn").watchProperty("value",function() {
		var v = $(this).val();
		if(v == '' || v == null) return;
		// 上传
		$("#common_upload_form").attr("action", "/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
		$("#common_upload_form").submit();
	});
	//点击图片上传图片
	$("#addPicture").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
		
	});
	
	//回调，回显图片
	uploadCallback = function(attachment) {
		//atachmentArray += attachment + "#";
		attach = eval("(" + attachment + ")");
		$("#common_upload_btn").val('');
		$(".vip_phone").find("dl").find("dd").last().before("<dd > <a><img src='"+attach.url_ +"'/><i onclick='deleteAttachment(this)' value="+attachment+"></i></a></dd>");
	}
	//图片上传end
	//删除上传的文件
	deleteAttachment = function(_this){
		$(_this).parent().parent().remove();
	}
	
	/**
	 * 初始化日期控件start
	 */
	var dmf = {
		yearOffset : 0,
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '1970-01-01', // yesterday is minimum date
		maxDate : '2099-12-31' // and tommorow is maximum date calendar
	};
	// 初始化日期控件
	$('#pay_time').datetimepicker(dmf);
	
	var pay_time = $("#pay_time").val();
	if (pay_time) {
		var fmtDate = new Date();
		fmtDate.setTime(pay_time);
		$("#pay_time").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	
	//初始化日期控件end
})
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=4" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.financeManage"/> -> <spring:message code="sys.client.payManage"/> -> 支付</div>
	<div class="vip_conbody body_cbox">
		
		<div class="tabnav">
			
			<div class="content">
				<div class="table_con table_border m20">
					<table width="100%">
						<tr>
							<th class="w100"><spring:message code="sys.client.supplier"/><!-- 供应商 --></th>
							<th><spring:message code="sys.client.financeAmount"/><!-- 融资金额 --></th>
							<th><spring:message code="sys.client.financingProportion"/><!-- 融资比例 --></th>
							<%-- <th><spring:message code="sys.client.settlementAmount"/><!-- 结算金额 --></th> --%>
							<th><spring:message code="sys.client.LoanCosts"/><!-- 贷款费用 --></th>
							<th><spring:message code="sys.client.investBidManage.serviceCharge"/><!-- 服务费用 --></th>
							<th><spring:message code="sys.client.amountOfTheLoan"/><!-- 放款金额 --></th>
						</tr>
						<tr>
							<td>${enterprise.enterpriseName }</td>
							<td><fmt:formatNumber value="${financeApply.apply_amount }" pattern="###,##0.00"  />元</td>
							<td><fmt:formatNumber value="${financeApply.finance_ratio }" pattern="###,##0.00"  />%</td>
							<!-- <td id="settlementAmount"></td> -->
							<td id="financeFee"></td>
							<td id="Fee"></td>
							<td><input type="text" class="text"  id="loanAmount" disabled="disabled">元</td>
						</tr>
					</table>
					<div class="rzzt">
						<ul>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.annex"/><!-- 附件 -->：</span>
									<div class="vip_phone" >
										<dl>
											<dd>
												<a id="addPicture"></a>
											</dd>
										</dl>
									</div>
								</div>
							</li>
						
							<li class="w400 clear"><div class="input_box"><span><spring:message code="sys.client.payTime"/><!-- 支付时间 -->：</span><input placeholder="请选择到期日期" name="pay_time" id="pay_time"  class="text"  date="true"/></div></li>
							<li class="w400 clear"><div class="input_box"><span><spring:message code="sys.admin.rank"/><!-- 备注 -->：</span><textarea class="text_tea " id="comment_"></textarea>
						</ul>
					</div>
					
					
				</div>
			</div>
		</div>
		<div class="w_bottom_btn">
			<ul>
				<li>
					<a class="now" id="save"><spring:message code="sys.admin.save"/><!-- 保存 --></a>
				</li>
				<%-- <li>
					<a><spring:message code="sys.client.cancel"/><!-- 取消 --></a>
				</li> --%>
			</ul>
		</div>  
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
	
	<!-- 图片上传 部分 start -->
	<iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>
	<!-- 图片上传 部分 end -->
</body>
</html>