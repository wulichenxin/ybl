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

	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<!--弹出框-->
        <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
        <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/ajaxfileupload.js"></script> --%>
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />合同管理<span
				class="mr10 ml10">-</span>合同签署<span class="mr10 ml10">-</span>签约
		</div>
	</div>


	<div class="w1200">

<input type="hidden"  id="appid" value="${appid}">
<input type="hidden"  id="applid" value="${applid}">
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
				<span></span>上传合同附件
			</p>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">合同模板下载：</label><a id="downcontract" href="#">保理融资主合同</a>
				</div>
			</div>
			
			<div class="ground-form mb20">
				<div style="width: 182px; height: 122px; text-align: center;">
				<img id="upfile" class="uploadimg" width="175px" height="175px" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
				<div id="contractname" style="width:175px;text-align: center;word-break: break-all;word-wrap: break-word;"></div>
				</div>
			</div>
		</div>

		<div class="btn2 mt40 clearfix">
			<a id="cancel" href="javascript:;" class="btn-add btn-center">取消</a>
			<a id="submit" href="javascript:;" class="btn-add btn-center">签署</a>
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
		
		<div id="upfile_div">
		</div>


</body>

<script type="text/javascript">

	$(function(){
		var attachment;
		
		var id = $('#id').val();
		$.ajax({
			url : '/contractController/getContractDocument',
			type : 'POST', //GET
			async : true, //或false,是否异步
			data : {id:id},
			timeout : 5000, //超时时间
			dataType : 'json',
			success : function(data) {
				if(data.responseType == "SUCCESS"){
					$("#downcontract").attr("href","/fileDownloadController/downloadftp?id="+data.object.id_);
					attachment = data.object;
				}else{
					alert("获取合同文件失败");
				}
			}
		});
		
			
			$("#per_page").click(function(){
				
			});
			
			$("#cancel").click(function(){
				window.history.back(-1); 
			});
			
			$("#submit").click(function(){
				var downcontract=	$("#downcontract").attr("href");
				var appid=$("#appid").val();
				var applid=$("#applid").val();
				if(downcontract==""){
					alert("合同模版找不到指定路径");
				}
				var contract_id = $('#id').val();
				if($("#upfile_div").find("input").length >=1){
					$("#upfile_div").find("input").each(function(){
						attachment[""+$(this).attr("name")] = $(this).val();
					});
				}else{
					alert("请先上传文件");
					return false;
				}
				attachment["id"] = attachment["id_"];
				attachment["contract_id"] = contract_id;
				attachment["appid"] = appid;
				attachment["applid"] = applid;
				$.ajax({
					url : '/contractController/updateContractInfo',
					type : 'POST', //GET
					async : true, //或false,是否异步
					data : attachment,
					timeout : 5000, //超时时间
					dataType : 'json',
					success : function(data) {
						alert(data.info,function(){
							if(data.responseType == "SUCCESS"){
								
								window.location.href="/contractController/contractSure.htm";
							}else{
								return false;
							}
						});
						
					}
				});
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
			$("#upfile").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			//var num = 0;
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var photoUpdateId = $("#" + id).attr("attachId");
				/* //$("#upfile").attr("src",attachment.url_) */
				if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(attachment.url_)){
					$("#upfile").attr("src",attachment.url_)	
				}else{
					$("#upfile").attr("src","/ybl4.0/resources/images/pro/dczc_addDaf_img.png");
				}
				$("#contractname").html(attachment.old_name);
				var html_ = "<input type='hidden' value='" + attachment.url_
						+ "' name='url'/>"
						+ "<input type='hidden' value='" + attachment.old_name
						+ "' name='oldName'/>"
						+ "<input type='hidden' value='" + attachment.new_name
						+ "' name='newName'/>"
						+ "<input type='hidden' value='" + attachment.ext_name
						+ "' name='extName'/>"
						+"<input type='hidden' value='" + attachment.file_size
						+ "' name='fileSize'/>";
				$("#upfile_div").empty().html(html_);
				
			}
		
		
		
	});

</script>

</html>