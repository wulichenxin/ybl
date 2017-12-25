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
<title>结算</title>
<jsp:include page="../../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">

//提交表单
function formSubmit(){
		//支付时间
		var payTime = $("#pay_time").val();
		var comment = $("#comment_").val();
		var amount = $("#amount_").val();
		var repaymentId = ${repayLoanPlan.id}
		//定义数组attachement
		var attachmentArray = '';
		var count = $("img").size();
		if(count < 1){
			alert("请上传附件信息 !");
			return;
		} 
		for(var i=0;i<count; i++){
			attachmentArray += $("img").eq(i).next().attr("value") + "#";
		}
		
		if(! payTime) {
			alert("请选择支付时间");
			return;
		}
		
		if( isNaN(amount) ||  amount == "") {
			alert("请输入正确支付金额");
			return;
		}
		
		$.ajax({
	        url: '/loanController/saveRepayment', 
	        data:{
	        	"payTime":payTime, //支付时间
	        	"comment":comment,//备注
	        	"amount":amount, //本次放款金额
	        	"repaymentId":repaymentId,
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
		
		call_back = function(){
			window.location.href ="/loanController/queryAllLoan";
		}
};

 
$(function(){
	//校验初始化
	var pageForm = ext.formValidation("pageForm");
	//保存按钮事件
	$("#save").click(function(){
		var passed = pageForm.validationEngine("validate");
		if(passed){
			formSubmit();
		}
		
	})

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
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->
	<form  id="pageForm" method="post">
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.loan.manage"/> -> <spring:message code="sys.client.repay.manage"/> -> 结算</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			
			<div class="content">
				<div class="table_con table_border m20">
					<ul class="pay">
					<li>供应商名称：<span>${enterprise.enterpriseName }</span></li>
					<li>核心企业：<span>${coreEnterprise.enterpriseName }</span></li>
					<li>凭证总金额：<span><fmt:formatNumber value="${sum / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></span></li>
					<li>已放款金额：<span><fmt:formatNumber value="${disbursementRecord.disbursedAmount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></span></li>
					<li>已还款金额：<span><fmt:formatNumber value="${repayLoanPlan.actualAmount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></span></li>
					<li>回款状态：
						<span>
							<c:if test="${repayLoanPlan.status == 'unrepayment'}">未还款</c:if>
							<c:if test="${repayLoanPlan.status == 'repaymenting'}">还款中</c:if>
							<c:if test="${repayLoanPlan.status == 'repaymented'}">已还款</c:if>
						</span>
					</li>
					<li style="color:red;">待还款金额：
						<span style="color:red;">
							<fmt:formatNumber value="${(repayLoanPlan.amount -  repayLoanPlan.actualAmount) }" pattern="#,##0.00" maxFractionDigits="2"/>元
						</span>
					</li>
					<li>凭证编号：
						<span>
							<c:forEach items="${voucherList }" var="voucher">
								${voucher.voucherNo } &nbsp;&nbsp;&nbsp;
							</c:forEach>
						</span>
					</li>
					<li>计划回款日期：
						<span>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${financeApply.repayment_date }" />
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
						</span>
					</li>
					</ul>
					<div class="rzzt">
						<ul>
							<li>
								<div class="input_box">
									<span>附件：</span>
									<div class="vip_phone" >
										<dl>
											<dd>
												<a id="addPicture"></a>
											</dd>
										</dl>
									</div>
								</div>
							</li>
							<li class="w400 clear"><div class="input_box"><span>本次回款金额：</span><input class="text "  id="amount_" name="amount"/>&nbsp;元</div></li>
							<li class="w400 clear"><div class="input_box"><span>支付时间：</span><input placeholder="请选择到期日期" name="pay_time" id="pay_time"   class="text "  date="true" name="payTime"/></div></li>
							<li class="w400 clear"><div class="input_box"><span>备注：</span><textarea class="text_tea " id="comment_" name="comment"></textarea>
						</ul>
					</div>
					
					
				</div>
			</div>
		</div>
		<div class="w_bottom_btn">
			<ul>
				<li>
					<a class="now" id="save">保存</a>
				</li>
				<!-- <li>
					<a>取消</a>
				</li> -->
			</ul>
		</div>  
	</div>
	</form>
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