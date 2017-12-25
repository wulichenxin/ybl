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
	<!--top start -->
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--top end -->
	<body>
	<div class="Bread-nav">
		<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />确认还款</div>
	</div>
	<form action="" id="subPageForm" method="post">
		<input type="hidden" name="repaymentId" value="${obj.id}"/>
		<div style="width: 950px;margin: auto;">
			
			<p class="protitleWhite"><span></span>还款信息</p>
		
			<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">放款申请单号：</label><input readonly="readonly" class="content-form2" value="${obj.loanApplyOrderNo }"/></div>
						<div class="form-grou mr50"><label class="label-long2">还款期数：</label><input readonly="readonly" class="content-form2" value="${obj.period }"/><span class="timeimg">期</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">付款单位账户开户行：</label><input readonly="readonly" class="content-form2" value="${obj.bank }"/></div>
						<div class="form-grou mr50"><label class="label-long2">本期应还利息：</label><input readonly="readonly" class="content-form2" value="<fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/>" /><span class="timeimg">元</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">逾期天数：</label><input readonly="readonly" class="content-form2" value="${obj.overdueDays }"/><span class="timeimg">天</span></div>
						<div class="form-grou mr50"><label class="label-long2">付款单位账户开户名称：</label><input readonly="readonly" class="content-form2" value="${obj.bankAccountName }"/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">交易流水号：</label><input readonly="readonly" class="content-form2" value="${obj.transactionOrderNo }"/></div>
						<div class="form-grou mr50"><label class="label-long2">支付时间：</label><input readonly="readonly" class="content-form2" value="<fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" />"/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">本次实际支付金额：</label><input readonly="readonly" class="content-form2" value="<fmt:formatNumber value="${obj.actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						<div class="form-grou mr50"><label class="label-long2">本期应还本金：</label><input readonly="readonly" class="content-form2"  value="<fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label class="label-long2">逾期费用：</label><input readonly="readonly" class="content-form2" value="<fmt:formatNumber value="${obj.overdueFee}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						<div class="form-grou mr50"><label class="label-long2">付款单位账户银行账号：</label><input readonly="readonly" class="content-form2" value="${obj.bankAccount }" /></div>
					</div>
					
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" readonly="readonly">${obj.remark }</textarea></div>
					</div>
					<div class="ground-form mb20">
						<c:if test="${not empty attachment }">
							<div class="form-grou"><label class="label-long2">上传支付凭证：</label>
									<a href="/fileDownloadController/downloadftp?id=${attachment.id }"><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
						</c:if>
					</div>
			</div>
			
			<div class="bottom-line"></div>
			<p class="protitleWhite"><span></span>请确认收到投资还款</p>
			
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><strong style="color: red;">*</strong><label class="label-long2">备注：</label><textarea class="protext w688 validate[required,maxSize[127]]" name="remark"></textarea></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long2">上传收款确认附件：</label>
							<div id='licensePhoto' class="mt20">
								<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
							</div>
						</div>
						<div id='licensePhoto_div'></div>
					</div>
				</div>
			<div class="mb80"></div>
			<div class="btn2 mt40 clearfix">
				<a class="btn-add btn-center" id="save_btn">确认</a>
				<a href="${url }" class="btn-add btn-center close-out" id="anqu_close">返回</a>
			</div>
			<div class="mt40"></div>
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
				//数据校验
				if(!$("#subPageForm").validationEngine('validate')) {
					alert("填写的信息有误，请完善信息！");
					return false;
				}
				if($("#licensePhoto_div").html() == "") {
					alert("上传收款确认附件！");
					return false;
				}
				var formdata=$('#subPageForm').serialize();//序列化表单
				$.ajax({
					url:'/factorCollectionManagementController/confirmeRepayment',
					dataType:'json',
					type:'post',
					data:formdata,
					success:function(value){
						if(value.responseTypeCode == "success"){
							alert(value.info,function(){
								//列表页刷新
								parent.location.href='/factorCollectionManagementController/unconfirmed/list.htm';
							})
						}else{
							alert(value.info);
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