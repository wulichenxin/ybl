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
<title>公告</title>
</head>
<body>
	<div class="v2_about_box">
		<form method="post" id="noticesPageForm">
			<div class="v2_a_news_gg">
				<ul>
					<c:forEach items="${platformNoticeList}" var="entity">
						<li><a href="/gatewayController/noticeDetail.htm/${entity.id }">${entity.title}<font><fmt:formatDate value="${entity.releaseDate}" pattern="yyyy-MM-dd" /></font></a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="v2_pages">
				<%@include file="/ybl/v2/admin/common/noticesPage.jsp" %>
			</div>
		</form>
	</div>
</body>
