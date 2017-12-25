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
		<!-- jquery校验 -->
		<link rel="stylesheet" href="/ybl4.0/resources/css/custom_validate.css"/>
		<script type="text/javascript" src="/ybl4.0/resources/js/common/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/ybl4.0/resources/js/common/messages_zh.js"></script>
		<!--自定义校验规则-->
		<script type="text/javascript" src="/ybl4.0/resources/js/common/validate.expand.js"></script>
		<!-- 日期 -->
		<script type="text/javascript" src="/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
	</head>
	<!--top start -->
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--top end -->
	<body>
	<div class="Bread-nav">
		<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待付款批次--结算</div>
	</div>
	<form action="/factorLoanManagementController/loanBatchPending/list.htm" id="subPageForm" method="post">
		<input type="hidden" name="id" value="${batchId }"/>
		<input type="hidden" id="platformFee" name="platformFee"/>
		<input type="hidden" value="${platformConfigFree.reductionRate }" name="platformReductionRate" id="reductionRate"/>
		<input type="hidden" value="${platformConfigFree.rate }" name="platformRate" id="rate"/>
		<div style="width: 950px;margin: auto;">
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">实际放款金额：</label><input class="content-form2 validate[required,maxSize[28],min[1],custom[number]]" value="<fmt:formatNumber value="${totalAssetsSettlementAmount }" pattern="##0.##" maxFractionDigits="2"/>" name="actualLoanAmount"/><span class="timeimg">元</span></div>
						<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">实际放款时间：</label><input id="actualLoanDate" class="content-form2 validate[required,custom[date]]" name="actualLoanDate"/></div>
					</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">交易流水号：</label><input class="content-form2 validate[required,maxSize[25]]"  name="transactionOrderNo"/></div>
					<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">付款单位账户开户行：</label><input class="content-form2 validate[required,maxSize[25]]""  name="bank"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">付款单位账户开户名称：</label><input class="content-form2 validate[required,maxSize[25]]""  name="bankAccountName"/></div>
					<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">付款单位账户银行账号：</label><input class="content-form2 validate[required,maxSize[25]]""  name="bankAccount"/></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">备注：</label><textarea class="protext w688 validate[required,maxSize[127]]" name="remark"></textarea></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long2">上传支付凭证：</label>
						<div id='licensePhoto'>
							<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
						</div>
					</div>
					<div id='licensePhoto_div'></div>
				</div>
			</div>
			
			<div class="mb80"></div>
			<div class="btn2 mt40 clearfix">
				<a class="btn-add btn-center" id="save_btn">提交</a>
				<a href="/factorLoanManagementController/loanBatchPending/list.htm" class="btn-add btn-center close-out" id="anqu_close">返回</a>
			</div>
			
			<p class="protitle"><span>平台费用  = 实际放款金额 × （平台费率 - 减免费率）</span></p>
			<div class="tabD">
				<table>
					<tr>
						<td>序号</td>
						<td>资金方名称</td>
						<td>融资金额(元)</td>
						<td>实际放款金额(元)</td>
						<td>平台费率(%)</td>
						<td>减免费率(%)</td>
						<td>平台费用(元)</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="maxwidth">${paymentBatch.funderName }</td>
						<td class="maxwidth"><fmt:formatNumber value="${paymentBatch.totalApplyAmount }" pattern="#,##0.##" maxFractionDigits="2"/></td>
						<td class="maxwidth" id="actualLoanAmount">0</td>
						<td class="maxwidth"><fmt:formatNumber value="${platformConfigFree.rate }" pattern="##0.####" maxFractionDigits="4"/></td>
						<td class="maxwidth"><fmt:formatNumber value="${platformConfigFree.reductionRate }" pattern="##0.####" maxFractionDigits="4"/></td>
						<td class="maxwidth" id="platformFeeTD">0</td>
					</tr>
				</table>
			</div>
		</form>	
		<div class="mb80"></div>
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
			//查询表单验证
			$("#subPageForm").validate({
				errorElement: "em", //可以用其他标签，记住把样式也对应修改
				success: function(label) {
					//label指向上面那个错误提示信息标签em
					label.text(" ")        //清空错误提示消息
					.addClass("success");  //加上自定义的success类
				   },
				highlight: function(element, errorClass) {
					$(element).parent().find("." + errorClass).removeClass("success");//表单用户(获取到焦点)操作时如果正确就移除错误的css属性添加正确的css属性
				}//,
				/* rules : {
					actualLoanAmount : {
						maxlength:16,
						minlength:4,
						isZipCode: true
						//isPositiveInteger:$(this).val()
					}
				} */
			});
				
			$("input[name='actualLoanAmount']").change(function(){
				if(!isNaN($(this).val())) {
					$("#actualLoanAmount").html($(this).val());
					$("#platformFeeTD").html(Math.ceil(Number($(this).val()) * (Number($("#rate").val())/100-Number($("#reductionRate").val()/100))*100)/100);
					$("#platformFee").val($("#platformFeeTD").html());
				}
			});
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
			$("#save_btn").click(function(){
				
				/* if(!$("#subPageForm").valid()){
					return false;
				} */
				
				$("input[name='actualLoanAmount']").change();
				
				//数据校验
				if(!$("#subPageForm").validationEngine('validate')) {
					alert("填写的信息有误，请完善信息！");
					return false;
				} 
				if($("#licensePhoto_div").html() == "") {
					alert("请上传支付凭证！");
					return false;
				}
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
								parent.location.href='/factorLoanManagementController/loanBatchPending/list.htm';
								//关闭弹出框
								//dialog.close();
							});
						}else{
							alert(data.info);
						}					
					},
					complete: function( xhr,data ){
						if(xhr.getResponseHeader('sessionstatus') == 'timeOut') {
							alert("登陆已失效，请重新登陆！",function(){
								location.href='/loginV4Controller/toLogin.htm';
							});
						}
					 }
				});
			});
			$('.close-out').click(function(){
				dialog.close();
			})
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
						+ "' name='attachmentList[" + num + "].url'/>"
						+ "<input type='hidden' value='userV2Certificate_" + id
						+ "' name='attachmentList[" + num + "].type'/>"
						+ "<input type='hidden' value='" + attachment.old_name
						+ "' name='attachmentList[" + num + "].oldName'/>"
						+ "<input type='hidden' value='" + attachment.new_name
						+ "' name='attachmentList[" + num + "].newName'/>"
						+ "<input type='hidden' value='" + attachment.ext_name
						+ "' name='attachmentList[" + num + "].extName'/>";
						+ "<input type='hidden' value='" + attachment.file_size
						+ "' name='attachmentList[" + num + "].fileSize'/>";
				if (photoUpdateId && photoUpdateId != '' && photoUpdateId != null) {
					html_ += "<input type='hidden' value='" + photoUpdateId
							+ "' name='attachmentlist[" + num + "].id'/>"// 更新时有图片id
				}
				if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
					$("#"+ id).empty().html("<img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' width='182px' height='122px'/>");
				} else {
					$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				}
				$("#" + id + "_div").empty().html(html_);
			}
			// 图片上传end
		})
		</script>
	</body>
</html>