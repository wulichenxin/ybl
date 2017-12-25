<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>

<head>
<meta charset="UTF-8">
<title></title>
</head>
	<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
	<!--弹出框-->
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
	<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
	<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/ajaxfileupload.js"></script> --%>
<body>
<c:choose>
			<c:when test="${entity.id ==null or entity.id==0 }">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png" height="200px" width="200px"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>

	<div>

		<p class="protitle"><span>合同详情</span></p>

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

		<%-- 	<div class="ground-form mb20">
				<div class="form-grou">
					<a href="${attachment.url }">${attachment.oldName }</a>
				</div>
			</div>
		</div> --%>
		<div class="ground-form mb20">
				<div class="form-grou">				
				<c:if test="${attachment.id>0 }">
									<div class="pd20">
										<div id='licensePhoto'>
											<a href="/fileDownloadController/downloadftp?id=${attachment.id }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
										</div>
										<div id='licensePhoto_div'></div>
									</div>
							</c:if>
				<div id="phonename" style="width:175px;text-align: center;word-break: break-all;word-wrap: break-word;">${attachment.oldName }</div>
 				</div>	
				</div>
			</div>
		<div class="bottom-line mb20"></div>
			<div class="btn2 clearfix mb80">
					<a href="#" id="tab8_1" class="btn-add">上一页</a>
					
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

	</div>



</c:otherwise>
</c:choose>
</body>
	<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
	</script>
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
										+ data.object.id);
						if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(data.object.url_)){
							$("#upfile").attr("src", data.object.url_);
						}else{
							$("#upfile").attr("src","/ybl4.0/resources/images/pro/dczc_addDaf_img.png")
						}
					}
				}
			});
		}


		
			//上一页，下一页,返回的跳转
			
				
			$('#tab8_1').click(function(){	
				/* var url=$('#seven',parent.document).attr('url');	
				$('#iframe1',parent.document).attr('src',url); */
				$('#seven',parent.document).click();	
			})
				
			
			$(".btn-return").click(function(){
				var url=$("#jumpurl",parent.document).val();
				window.parent.location.href=url;
				
			});
		

		
		
		

	});
</script>

</html>