<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>

<head>
<meta charset="UTF-8">
<title></title>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>

	
	<!--弹出框-->
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/ajaxfileupload.js"></script> --%>
	<%-- <div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />结算管理<span
				class="mr10 ml10">-</span>融资确认<span class="mr10 ml10">-</span>确认还款
		</div>
	</div> --%>


	<div class="w1200">

		<div class="pd20 mt40">
			<input id="id" type="hidden" value="${entity.id_}">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
				<div class="process process1">
				${entity.content}
				</div>
				</div>
			</div>

			<p class="protitleWhite">
				<span></span>合同附件
			</p>

			<div class="ground-form mb20">
				<div class="form-grou">
					<%-- <a href="${attachment.url_ }">${attachment.old_name }</a> --%>
					<div style="width:175px;height:200px;text-align: center;">
					<a href="/fileDownloadController/downloadftp?id=${attachment.id }" ><img class="uploadimg" id="upfile"  src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" style="width:182px;height:122px;"/></a>
 						<div id="phonename" style="width:175px;text-align: center;word-break: break-all;word-wrap: break-word;">${attachment.oldName }</div>
 					</div>
				</div>
			</div>
		</div>

		
			<a id="cancel" href="javascript:;" class="btn-add btn-center">返回</a>
		

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
	$(function() {
		$("#cancel").click(function() {
			window.history.back(-1);
		});

	});
</script>

</html>