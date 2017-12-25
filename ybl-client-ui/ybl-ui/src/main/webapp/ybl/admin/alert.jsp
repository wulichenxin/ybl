<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>弹出框Demo</title>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css" />
<!-- 提示框 -->
<script language='javascript'
	src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.9.1.js'></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<style type="text/css">
.sgBtn {
	width: 135px;
	height: 35px;
	line-height: 35px;
	margin-left: 10px;
	margin-top: 10px;
	text-align: center;
	background-color: #0095D9;
	color: #FFFFFF;
	float: left;
	border-radius: 5px;
}
</style>
<script type="text/javascript">
	$(function() {

		$("#btn1").click(function() {
			var txt = "提示文字，提示文字，提示文字，提示文字，提示文字，提示文字";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		});

		$("#btn2").click(function() {
			var txt = "提示文字，提示文字，提示文字，提示文字，提示文字，提示文字";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.confirm);

		});

		$("#btn3").click(function() {
			var txt = "提示文字，提示文字，提示文字，提示文字，提示文字，提示文字";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.warning);
		});

		$("#btn4").click(function() {
			var txt = "提示文字，提示文字，提示文字，提示文字，提示文字，提示文字";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
		});

		$("#btn5").click(function() {
			var txt = "提示文字，提示文字，提示文字，提示文字，提示文字，提示文字";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.success);
		});

		$("#btn6").click(function() {
			var txt = "请输入";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.input, {
				onOk : function(v) {
					console.log(v);
				}
			});
		});

		$("#btn7").click(function() {
			var txt = "自定义呀";
			var option = {
				title : "自定义",
				btn : parseInt("0011", 2),
				onOk : function() {
					console.log("确认啦");

				}
			}
			window.wxc.xcConfirm(txt, "custom", option);
		});

		$("#btn8").click(function() {
			var txt = "默认";
			window.wxc.xcConfirm(txt);
		});
	});
</script>
</head>
<body>
	<div class="" style="height: 768px;">
		<div class="sgBtn" id="btn1">弹窗1(信息)</div>
		<div class="sgBtn" id="btn2">弹窗2(提示)</div>
		<div class="sgBtn" id="btn3">弹窗3(警告)</div>
		<div class="sgBtn" id="btn4">弹窗4(错误)</div>
		<div class="sgBtn" id="btn5">弹窗5(成功)</div>
		<div class="sgBtn" id="btn6">弹窗6(输入框)</div>
		<div class="sgBtn" id="btn7">弹窗7(自定义)</div>
		<div class="sgBtn" id="btn8">弹窗8(默认)</div>
	</div>
</body>
</html>
