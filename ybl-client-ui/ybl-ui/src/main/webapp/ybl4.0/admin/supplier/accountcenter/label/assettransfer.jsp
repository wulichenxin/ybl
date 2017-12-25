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
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
	<script type="text/javascript">
		$(function(){ 
			$("#btn-4").click(function(){
				$('.iconlist', parent.document).removeClass('pro_li_cur');
				$('#iconlist2', parent.document).addClass('pro_li_cur');
				var loanApplyId=$('#loan_apply_id', parent.document).val();
				var type=$('#assetsType', parent.document).val();
				window.location.href="/tabDetailController/selectPlatAudiByLoanOrderId?loanApplyId="+loanApplyId;
			});
		});
	</script>
	<body>
		<div style="width: 950px;margin: auto;">
			
				<p class="protitle"><span>资产转让确权</span></p>
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${attch.remark }</textarea></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">附件：</label>
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${attch.id }" >
								<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
						</div>
						<div id='licensePhoto_div'></div>
					</div>
				</div>
			<div class="mb80"></div>
			<!-- <div class="btn3 clearfix mb80"> -->
				<a href="#" id="btn-4" class="btn-add btn-center">下一页</a>
				<!-- <a href="#" id="btn-return" class="btn-add" >返回</a> -->
			<!-- </div> -->
		</form>	
		<!-- 图片上传 部分 start 
		<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
	
		
		图片上传 部分 end 
		<script type="text/javascript">
			$(function(){
			})
		</script>-->
	</body>
</html>