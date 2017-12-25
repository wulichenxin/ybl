<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!-- 		<div class="v2_gateway_con"> -->
<!-- 			<div class="v2_about_b_con"> -->
<!-- 				<h1>走进国信 让财富温暖人生</h1> -->
<!-- 				<h1>是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</h1> -->
<!-- 				<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p> -->
<!-- 				<p>过互联网和技术手段打通金融服务中存在的痛点，在提高金融服务效率的同时降低服务成本，让更多用户享受到简单、规范、高效的金融服务。</p> -->
<!-- 			 </div> -->
<!-- 		</div> -->
		
	</div>	
</div>
<div class="v2_gateway_box">
	<div class="v2_about_box">
		<div class="v2_d_position">首页 > 关于我们 > 团队介绍</div>
		<div class="v2_news_con">
			<div class="v2_about_td mt20">
				<div class="v2_td_pic_d "><img class="teamImg" src="${memberDetail.url}"/></div>
				<div class="v2_td_xx_md">
					<h2>${memberDetail.name}</h2>
					<h3>${memberDetail.position}</h3>
					${memberDetail.desc}
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
