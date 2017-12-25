<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<title>${app.appName }</title>
		<!-- 公共js css -->
		<jsp:include page="/fw/admin/common/link.jsp" />
		<!-- 功能js css -->
		<script src="/fw/resources/js/admin-head.js" type="text/javascript" ></script>
	</head>
<script type="text/javascript">
	$(function() {
		$("#frameList").html(MenuTab.generateFrame(-100, '', '/fw/admin/common/center.jsp'));
		$("#homePage").click(function() {
			// 默认显示的iframe
			MenuTab.show(-100);//隐藏所有的页签  显示首页
			$("#homePage").addClass("now");//首页这个页签要选中状态
		});
		// 默认调用一次
		$("#homePage").click();
	});
</script>
<body>
	<!--  head -->
	<jsp:include page="/fw/admin/common/head.jsp" />
	<!-- content begin -->
	<div id="frameList">
	</div>
	
	<!-- content end -->
	<!-- footer -->
	
	<jsp:include page="/fw/admin/common/footer.jsp" />
</body>
</html>