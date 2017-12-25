<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String step = request.getParameter("step");
	request.setAttribute("step", step);
%>
<!-- 供应商头部 -->
<div class="v2_head">
	<div class="v2_top_head">
		<div class="v2_logo">
			<a href="/indexV2Controller/supplierIndex.htm"></a>
		</div>
		<div class="v2_nav">
			<ul>
			</ul>
		</div>
	</div>
</div>
<div class="v2_head_line"></div>

<script type="text/javascript">
	$(document).ready(function() {
		/* ABGIN我的菜单 */
		$('.navmenu').mouseover(function() {
			$(this).find('.navmenu-list').slideDown();
		}).mouseleave(function() {
			$(this).find('.navmenu-list').slideUp();
		});
		/* END我的菜单 */
	});
</script>