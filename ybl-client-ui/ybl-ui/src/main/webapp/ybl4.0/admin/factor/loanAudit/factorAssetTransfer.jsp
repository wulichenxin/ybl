<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<div class="w1200">
		<form action="/enterpriseAssetOwnership/assetOwnership" id="pageForm" method="post">
			<input type="hidden" name="loanApplyId" id="loan_apply_id" value="${lid }"/>
			<input type="hidden" name="assetsType" id="assetsType" value="${assetsType }"/>
			<div>
				<div class="process">
					<p class="protitleWhite"><span></span>请下载资产转让协议模板</p>
			<div class="pd20">
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>资料名称</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${list}" var="obj" varStatus="index">
					<tr>
						<td>${index.count}</td>
						<td class="maxwidth200"><c:if test="${obj.templateType eq '2' }">应收账款转让协议:</c:if><c:if test="${obj.templateType eq '3' }">确认回执:</c:if>${obj.templateName }</td>
						<td><a class="btn-modify download_btn" uid="${obj.id }">下载</a></td>
					</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
		<p class="protitleWhite"><span></span>请上传资产转让函</p>
						<div class="pd20" id='licensePhoto'>
							<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
						</div>
					</div>
					<div id='licensePhoto_div'></div>
		<p class="protitleWhite"><span></span>备注</p>
		<textarea class="protext btn-center" name="remark" style="width: 900px"></textarea>	
		<div class="btn2 mt40 clearfix">
				<a class="btn-add btn-center" id="save_btn">确权</a>
				<a class="btn-add btn-center close-out" id="anqu_close">返回</a>
			</div>		
				</div>
		</form>	
		</div>			
	</body>
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
			$(".download_btn").click(function(){
				var templateId = $(this).attr("uid");
				var loanApplyId = $("#loan_apply_id").val();
				window.open("/enterpriseAssetOwnership/templateDownload?templateId=" + templateId + "&loanApplyId=" +loanApplyId);
			});
			//保存按钮
			$("#save_btn").click(function(){
				if ($("#licensePhoto_div").find("input").length < 1) {
					alert("请上传资产转让函！");
					return false;
				}
				var formdata=$('#pageForm').serialize();//序列化表单
				$.ajax({
					url:'/enterpriseAssetOwnership/assetOwnership',
					dataType:'json',
					type:'post',
					data:formdata,
					success:function(data){
						if(data.responseTypeCode == "success"){
							alert(data.info, function() {
								//列表页刷新
								window.parent.frames.location.href='/factorLoanAuditController/loanAudit/waitAuthorizeList.htm';
							});
						}else{
							alert(data.info);
						}					
					}
				});
			});
			$('.close-out').click(function(){
				dialog.close();
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
			$("#licensePhoto").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			//var num = 0;
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var loan_apply_id =  $("#loan_apply_id").val();
				var photoUpdateId = $("#" + id).attr("attachId");
				//$("#"+id).empty().html(attachment.old_name);
				var newName = attachment.new_name;
				var oldName = attachment.old_name;
				$("#" + id).empty().html("<a href='/fileDownloadController/downloadNow?newName="+newName+"&oldName="+oldName+"'>"+oldName+"</a>");
				var html_ = "<input type='hidden' value='" + attachment.url_ 
						+ "' name='url'/>"
						+ "<input type='hidden' value='48' name='type'/>"
						+ "<input type='hidden' value='" + attachment.old_name 
						+ "' name='oldName'/>"
						+ "<input type='hidden' value='" + attachment.new_name
						+ "' name='newName'/>"
						+ "<input type='hidden' value='" + attachment.ext_name
						+ "' name='extName'/>"
						+ "<input type='hidden' value='" + loan_apply_id
						+ "' name='resourceId'/>"
						+"<input type='hidden' value='6' name='category'/>"
						+ "<input type='hidden' value='" + attachment.file_size
						+ "' name='fileSize'/>" ;
				if (photoUpdateId && photoUpdateId != '' && photoUpdateId != null) {
					html_ += "<input type='hidden' value='" + photoUpdateId
							+ "' name='attachmentlist[" + num + "].id'/>"// 更新时有图片id
				}
				if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
					$("#"+ id).empty().html("<img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' width='182px' height='122px'/>");
				} else {
					$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				}
				$("#licensePhoto_div").empty().html(html_);
			} 
			// 图片上传end
			//返回按钮
			$("#anqu_close").click(function(){
				window.parent.frames.location.href='/factorLoanAuditController/loanAudit/waitAuthorizeList.htm';
			});
			
		});
			
		</script>
</html>