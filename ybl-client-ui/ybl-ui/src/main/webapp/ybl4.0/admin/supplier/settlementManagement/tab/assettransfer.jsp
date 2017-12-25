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
	

	
		<div style="width: 950px;margin: auto;">
			
	
		
			
			
			<div class="bottom-line"></div>
					<p class="protitleWhite"><span></span>资产转让确权</p>
			
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${attch.remark }</textarea></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">附件：</label>
							<div id='licensePhoto'>
								<img class="uploadimg" src="${attch.url_ }" />
							</div>
						</div>
						<div id='licensePhoto_div'></div>
					</div>
				</div>
			<div class="mb80"></div>
			<!-- <div class="btn2 mt40 clearfix">
				<a class="btn-add btn-center" id="save_btn">确认</a>
				<a class="btn-add btn-center close-out" id="anqu_close">返回</a>
			</div> -->
		</form>	
		<!-- 图片上传 部分 start -->
		<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
	
		

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
			/* $("#save_btn").click(function(){
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
							}); */
			// 点击图片上传图片
			/* $("#licensePhoto").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			var num = 0; */
			// 回调，回显图片
			/* uploadCallback = function(obj) {
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
			} */
			// 图片上传end
		})
		</script>
	</body>
</html>