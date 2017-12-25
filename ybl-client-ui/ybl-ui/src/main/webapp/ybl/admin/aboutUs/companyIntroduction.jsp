<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top' }">
	<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
	<jsp:include page="/ybl/admin/common/link.jsp" />
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<div class="body_con">
</c:if>
<c:if test="${position eq 'bottom' }">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>关于我们</title>
<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
</head>
<body >
	<div class="head_about">
		<div class="top_head">
			<div class="logo"><a href="javacript:void(0)"></a></div>
			<div class="login_nav">
		    	<ul>
		            <li><a href="/ybl/admin/index/login.jsp"><span>首页</span></a></li>
					<li><a href="javascript:void(0);">业务介绍</a></li>
		            <li class="now"><a href="/aboutUsController/toAboutUs">关于我们</a></li>       
		        </ul>
		    </div>
		</div>
	</div>
	<div class="about_banner">
		<div class="about_b_con">
			<!-- <h1>走进国信 让财富温暖人生</h1>
			<h1>是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</h1>
			<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p>
			<p>过互联网和技术手段打通金融服务中存在的痛点，在提高金融服务效率的同时降低服务成本，让更多用户享受到简单、规范、高效的金融服务。</p> -->
			<h1>${companyProfile.title }</h1>
			<%-- <p>${companyProfile.content }</p> --%>
		 </div>
	</div>
	<div id="content" class="body_con">
</c:if>
<div class="content">
		<div class="about_box">
			<h1><span></span>公司介绍</h1>
			<div class="about_lr">
				<p>${companyProfile.title }</p>
				<p>${companyProfile.content }</p>
				<!-- <p>国信基金牢牢把握当下金融形势，投资方向侧重于“新能源”、“新兴农业”、“工业4.0”、“一带一路基建”四个领域。结合当今金融界最先进金融理念，以“并购投资”、“融资租赁”、“商业保理”、“商业银行”为主要经营方式，为市场提供“财富管理”、“资产管理”、“投资银行”、“家族信托”等业务。国信基金目前管理着多支国信系母基金，并成功完成对新天域资本、联想投资、松禾资本、同创伟业、九鼎投资、青云创投、德同资本、君丰资本、启明创投、达晨创投、天图创投、长江国泓、达泰资本、钟鼎创投等多只基金的投融资工作。</p> -->
			</div>
		</div>
		<div class="about_box">
			<h1><span></span>团队介绍</h1>
			<div class="about_td">
				<ul>
					<c:forEach items="${teamIntroductionList}" var="bean" varStatus="state">
						<li>
						<div class="td_pic"><img src="${bean.url }" height="269px" width="219px"/></div>
						<div class="td_xx">
							<h2>${bean.name }</h2>
							<h3>${bean.position }</h3>
							<p>${bean.desc } </p>
							<p>${bean.achieve } </p>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="about_box">
			<h1><span></span>发展历程</h1>
			<div class="about_lr">
				<p>${developHistory.title }</p>
				<p>${developHistory.content }</p>
			</div>
		</div>
</div>
<%-- <c:if test="${not empty type && position ne 'bottom'}"> --%>
	
<%-- </c:if> --%>
<c:if test="${position eq 'bottom' }">
		</div>
<jsp:include page="/ybl/admin/common/bottom.jsp" />
	</body>
</html>
</c:if>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top' }">
		</div>
<jsp:include page="/ybl/admin/common/bottom.jsp" />
</c:if>