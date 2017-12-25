<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>关于我们</title>
</head>
<body>
	<div class="v2_about_box">
		<form method="post" id="newPageForm">
			<div class="v2_a_news">
				<ul>
					
					<c:forEach items="${newsList}" var="entity">
						<li>
							<div class="v2_news_box">
								<div class="v2_news_pic"><img src="${entity.url}"/></div>
								<div class="v2_news_xx">
								<h3><a href="/gatewayController/newDetail.htm/${entity.id }">${entity.title}</a><b><fmt:formatDate value="${entity.releaseDate}" pattern="yyyy-MM-dd" /></b></h3>
								<div style="width:800px; height:40px;text-overflow:ellipsis;white-space: nowrap; overflow:hidden; font-size:14px; color:#999;">
									${entity.content}
								</div>
								</div>
							</div>
						</li>
					</c:forEach>
					
				</ul>
			</div>
			<div class="v2_pages">
				<%@include file="/ybl/v2/admin/common/newsPage.jsp" %>
			</div>
		</form>
	</div>
</body>
