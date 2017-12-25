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
<%@include file="/ybl/v2/admin/common/link.jsp" %> 
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
<div class="v2_about_banner">
	<div class="v2_top_con">
			<%@ include file="/ybl/v2/admin/common/topV2.jsp" %>
		<div class="v2_gateway_con">
			<div class="v2_about_b_con">
				<h1>走进国信 让财富温暖人生</h1>
				<h1>是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</h1>
				<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p>
				<p>过互联网和技术手段打通金融服务中存在的痛点，在提高金融服务效率的同时降低服务成本，让更多用户享受到简单、规范、高效的金融服务。</p>
			 </div>
		</div>
		
	</div>	
</div>

<!---->


	<div class="v2_gateway_box tab">
		<div class="v2_about_nav_box">
			<div class="v2_about_nav">
				<dl>
					<dd class="now"><a><span class="v2_a_ico1"></span>公司介绍</a></dd>
					<dd><a><span class="v2_a_ico2"></span>新闻资讯</a></dd>
					<dd><a><span class="v2_a_ico3"></span>公告</a></dd>
					<dd><a><span class="v2_a_ico6"></span>联系我们</a></dd>
				</dl>
			</div>
		</div>
	<div>
	<!--公司介绍-->
	<div class="v2_content ">
		<div class="v2_about_box">
			<h1><span></span>公司简介</h1>
			<div class="v2_about_lr">
				${companyProfile.content}
			</div>
		</div>
		<div class="v2_about_bg">
		<div class="v2_about_box">
			<h2><span></span>团队介绍</h2>
			<div class="v2_about_td">
				<ul>
				<c:forEach items="${teamIntroductionList}" var="entity">
					<li>
						<div class="v2_td_pic"><img class="teamImg" src="${entity.url}"/></div>
						<div class="v2_td_xx">
							<h2>${entity.name}</h2>
							<h3>${entity.position}</h3>
							<div style="width:800px; height:40px;text-overflow:ellipsis;white-space: nowrap; overflow:hidden; font-size:14px; color:#999;">
								${entity.desc}
							</div>
							<div class="v2_team_more2">
								<a href="/gatewayController/teamDetail.htm/${entity.id }">更多</a>
							</div>
						</div>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
			</div>
		<div class="v2_about_box">
			<h1><span></span>背景介绍</h1>
			<div class="v2_about_lr">
				${companyProfile.background}
			</div>
		</div>
		<div class="v2_about_bg2">
		<div class="v2_about_box">
			<h2><span></span>发展历程</h2>
			<div class="v2_about_lr2">
				${developHistory.content }
			</div>
		</div>
			</div>
	</div>
	<!--新闻资讯-->
		<!--新闻资讯-->
		<!--免责声明-->
		
		<!-- 联系我们-->
</div>
</div>

<!-- <div class="v2_foot_bottom"> -->
<!--      <p>© 2017 深圳市长亮科技股份有限公司 保留所有版权 备案号：粤ICP备11064357号</p> -->
<!-- </div> -->
<%@ include file="/ybl/admin/common/bottomV2.jsp" %>
 
<!--弹出窗登录-->


<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/yuangong_v2.js"></script>
<script type="text/javascript">
     $(function () {
         //tab切换
         $('.tab dl dd').click(function () {
             var index = $(this).index();
             $('.v2_content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
             $('.tab dl dd').eq(index).addClass('now').siblings().removeClass('now');
             
             var index = $(this).index();
             if(index == 0){
     	        $.ajax({
     	        	url : "/gatewayController/companyIntroduction",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 1){
     	        $.ajax({
     	        	url : "/gatewayController/news?currentPage=1&pageSize=10",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 2){
     	        $.ajax({
     	        	url : "/gatewayController/notices?currentPage=1&pageSize=10",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 3){
     	        $.ajax({
     	        	url : "/gatewayController/contact",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             
         });
     });
</script>
</body>
</html>
