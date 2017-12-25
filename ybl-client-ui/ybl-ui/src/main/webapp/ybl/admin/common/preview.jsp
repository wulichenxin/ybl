<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String urls = request.getParameter("urls");
	request.setAttribute("urls", urls);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>预览</title>
<jsp:include page="link.jsp" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/slides.min.jquery.js?v=${maven.build.number}"></script>
<style type="text/css">
.pagination {
	position: relative; ! important;
	right: 50px; ! important;
	top: -30px; ! important;
	width: 150px; ! important;
	z-index: 999; ! important;
	padding-bottom: 0px !important;
	padding-top: 0px !important;
	margin-top: -7px;
	left: 50%;
	margin-left: -40px;
}
.pagination li {
	float: left; ! important;
	margin: 0 4px !important;
}
.pagination li a {
	background-image:
		url('${app.staticResourceUrl}/ybl/resources/images/xx_111.png')
		!important;
	background-position: 0 0;
	display: block;
	float: left;
	height: 0;
	overflow: hidden;
	padding-top: 12px;
	width: 12px;
}
.pagination>li>a, .pagination>li>span {
	padding: 0;
	/* margin-top:20px; */
	height: 10px;
	width: 12px;
	margin-left: 0px;
	text-indent: -10px;
	border-radius: 50%;
}
.pagination>li:first-child>a, .pagination>li:first-child>span,
	.pagination>li:last-child>a, .pagination>li:last-child>span {
	border-radius: 50%;
}
.pagination li.current a {
	background-position: 0 -18px; ! important;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function() {
		var urls = "${urls}";
		var urlArr = urls != null ? urls.split(",") : [];
		if (urlArr != null && urlArr.length > 0) {
			if (urlArr.length == 1) {
				$("#img_").attr("src", urls);
			} else {
				$("#advertisingDiv").show();
				$("#img_").css("display", "none");
				var html_ = [];
				$.each(urlArr,function(i, item) {
					html_.push("<img src='"+urlArr[i]+"' style='width:775px;height:389px;'/>");
				})
				$("#slidesContainer").append(html_.join(""));
				photoSlides();
			}
		} else {
			$("#img_").attr("src",'${app.staticResourceUrl}/ybl/resources/images/login_bg_01.jpg');
		}
	});
	//轮播图片（多张图片时）
	function photoSlides() {
		$('#advertisingDiv').slides({
			preload : true,
			preloadImage : '',
			play : 3000,
			pause : 2500,
			hoverPause : true,
			animationStart : function() {
				$.each($('#advertisingDiv img'), function(i, item) {
					$(item).css({
						width : $('.w_big_pic').width()
					});
					$(item).css({
						height : $('.w_big_pic').height()
					});
				})
			},
			animationComplete : function(current) {

			}
		});
	}
</script>
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="w_big_pic">
			<!-- 单张图片展示区 -->
			<img src="" id='img_' style='width: 775px; height: 382px;' />
			<!-- 多张图片轮播展示区 -->
			<div id="advertisingDiv" style='display: none;'>
				<ul>
					<li>
						<div class="slides_container" id='slidesContainer'></div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>