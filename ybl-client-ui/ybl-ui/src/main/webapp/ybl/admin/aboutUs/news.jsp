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
		<div class="about_box" id="newPageForm">
			<h1><span></span>新闻资讯</h1>
			<div class="a_news">
				<ul id="newsPage">
					<form method="post">
						<c:forEach items="${newsList }" var="bean">
							<li>
								<div class="news_box">
									<h2><a>${bean.title }</a><b><fmt:formatDate value="${bean.releaseDate}" pattern="yyyy-MM-dd" /></b></h2>
									<p>${bean.content }</p>
								</div>
							</li>
						</c:forEach>
                 	</form>
				</ul>
			</div>
			<jsp:include page="../common/newsPage.jsp"></jsp:include>				
		</div>
</div>
<%-- <c:if test="${not empty type && position ne 'bottom'}"> --%>
<!-- 	</div> -->
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