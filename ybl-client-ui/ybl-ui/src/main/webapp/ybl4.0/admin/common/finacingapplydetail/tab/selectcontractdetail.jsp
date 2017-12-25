<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>

	<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
	<!--弹出框-->
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/ajaxfileupload.js"></script> --%>


	<div>

		<div class="bottom-line"></div>

		<div class="pd20 mt40">
			<input id="id" type="hidden" value="${entity.id}">
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
					<a href="${attachment.url}">${attachment.oldName }</a>
				</div>
			</div>
		</div>

		<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab8_1" class="btn-add">上一页</a>
					
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

	</div>




</body>

<script type="text/javascript">
	$(function() {
		var attachment;
		var id = $('#id').val();
		if (id != null && id != "") {
			$.ajax({
				url : '/contractController/getContractDocument',
				type : 'POST', //GET
				async : true, //或false,是否异步
				data : {
					id : id
				},
				timeout : 5000, //超时时间
				dataType : 'json',
				success : function(data) {
					if (data.responseType == "SUCCESS") {
						$("#downcontract").attr(
								"href",
								"/fileDownloadController/downloadftp?id="
										+ data.object.id_);
						$("#upfile").attr("src", data.object.url_);
					}
				}
			});
		}

		$("#cancel").click(function() {
			window.history.back(-1);
		});
			//上一页，下一页,返回的跳转
			
				
			$('#tab8_1').click(function(){	
				var url=$('#seven',parent.document).attr('url');	
				$('#iframe1',parent.document).attr('src',url);
			})
				
			
			$(".btn-return").click(function(){
				window.parent.location.href="/IntegratedQueryController/list.htm";
			});
		

		
		
		

	});
</script>

</html>