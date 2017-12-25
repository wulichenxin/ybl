<!-- 新闻详情页 -->
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理2.0">
<meta name="Description" content="云保理2.0">
<meta name="Copyright" content="云保理2.0" />
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css" />
<!-- 提示框 -->
<script language='javascript'
	src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.9.1.js'></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	})
	
</script>
<style type="text/css">
.teamImg{
	width:217px;
	height:269px;
}
</style>
</head>
<body>
<div class="v2_about_banner h76">
	<div class="v2_top_con">
			<%@ include file="/ybl/v2/admin/common/topV2.jsp" %>
	</div>	
</div>
<div class="v2_about_box">
	<div class="v2_d_position"> <a href="/gatewayController/index.htm">首页</a> > <a href="/gatewayController/toAboutUs.htm">行业动态 </a> >  ${currentNews.title }</div>
	<div class="v2_news_con">
		<div class="v2_news_tittle">
			<h3>${currentNews.title }</h3>
			<fmt:formatDate value="${currentNews.releaseDate }" pattern="yyyy-MM-dd"/>
		</div>
		<div class="v2_news_contact">
			${currentNews.content}	
		</div>
		<div class="v2_news_bottom">
			<div class="v2_news_prve">
				<div class="v2_news_l_img"></div>
				<div class="v2_news_dxx">
					<c:if test="${not empty prevNews }">
					<h5>上一篇</h5>
					<p><a href="/gatewayController/newDetail.htm/${prevNews.id }">${prevNews.title}</a></p>
					</c:if>
				</div>
			</div>
			<div class="v2_news_next">
				<div class="v2_news_r_img"></div>
				<div class="v2_news_dxx fr">
					<c:if test="${not empty nextNews }">
					<h5>下一篇</h5>
					<p><a href="/gatewayController/newDetail.htm/${nextNews.id }">${nextNews.title}</a></p>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
