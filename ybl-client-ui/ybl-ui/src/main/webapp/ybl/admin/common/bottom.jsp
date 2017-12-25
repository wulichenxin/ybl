<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/bottom/bottom.js"></script>
<title>bottom</title>
</head>
<body>
	<div class="foot_bg">
		<div class="foot_con">

			<div class="foot_l foot_lb">
				<h1>
					<span class="nav_pic1"></span>关于我们
				</h1>
				<ul>
					<li><a href="/aboutUsController/companyIntroduction?position=bottom" target="_blank" ><spring:message code="sys.client.company.intrduction"/><!-- 公司介绍 --></a></li>
					<li><a href="/aboutUsController/recruit?position=bottom" target="_blank" ><spring:message code="sys.client.talent.recruit"/><!-- 人才招聘 --></a></li>
					<li><a href="/aboutUsController/news?position=bottom" target="_blank" ><spring:message code="sys.client.news"/><!-- 新闻资讯 --></a></li>
				</ul>
			</div>
			<div class="foot_l foot_lb">
				<h1>
					<span class="nav_pic2"></span>友情链接
				</h1>
				<ul>
					<c:forEach items="${friendLink}" var="bean">
						<li><a href="${bean.href}" target="${bean.openType}">${bean.name}</a></li>
					</c:forEach>
<!-- 					<li><a>深圳聚团网络科技有限公司</a></li> -->
<!-- 					<li><a>惠州华熙制造科技有限公司</a></li> -->
<!-- 					<li><a>汇盛家族</a></li> -->
				</ul>
			</div>
			<div class="foot_l ">
				<h1>
					<span class="nav_pic3"></span>联系我们
				</h1>
				<c:choose>
					<c:when test="${fn:length(contact) >= 2 }">
						<ul class="mo_xx1">
							<c:forEach items="${contact}" var="bean" begin="0" end="0">
								<li>服务热线: ${bean.phone}</li>
								<li>联系邮箱: ${bean.email}</li>
								<li>地址: ${bean.address}</li>
							</c:forEach>
						</ul>
						<div class="b_more"><span>更多</span><b></b><em></em></div>
						<ul class="mo_xx">
							<c:forEach items="${contact}" var="bean" begin="1" end="${fn:length(contact)}">
								<li>服务热线: ${bean.phone}</li>
								<li>联系邮箱: ${bean.email}</li>
								<li>地址: ${bean.address}</li>
							</c:forEach>
						</ul>
					</c:when>
					<c:otherwise>
						<ul>
							<c:forEach items="${contact}" var="bean">
								<li>服务热线: ${bean.phone}</li>
								<li>联系邮箱: ${bean.email}</li>
								<li>地址: ${bean.address}</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
<!-- 				<div class="b_more"><span>更多</span><b></b><em></em></div> -->
<!-- 				<ul class="mo_xx"> -->
<%-- 					<c:forEach items="${contact}" var="bean"> --%>
<%-- 						<li>服务热线: ${bean.phone}</li> --%>
<%-- 						<li>联系邮箱: ${bean.email}</li> --%>
<%-- 						<li>地址: ${bean.address}</li> --%>
<%-- 					</c:forEach> --%>
<!-- 				</ul> -->
			</div>

		</div>
		<div class="foot_bottom">
			<div class="foot_bcon">
				<div class="foot_center">
					<p>版权所有 © 深圳市国信股权投资基金管理有限公司 粤ICP备14072292号</p>
					<ul>
						<li><a class="foot_bottom_ico1"></a></li>
						<li><a class="foot_bottom_ico2"></a></li>
						<li><a class="foot_bottom_ico3"></a></li>
						<li><a class="foot_bottom_ico4"></a></li>
				</div>
				</ul>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function () {
	$('.b_more b').click(function(){
		$('.b_more b').hide();
		$('.b_more em').show();
		$('.mo_xx').show();
	});
	$('.b_more em').click(function(){
		$('.b_more b').show();
		$('.b_more em').hide();
		$('.mo_xx').hide();
	});
  });
    </script>
</body>
</html>