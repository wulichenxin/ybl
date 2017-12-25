<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<div class="v2_a_news_gg">
	<ul>
		<c:forEach items="${platformNoticeList}" var="entity">
			<li><a href="/gatewayController/noticeDetail.htm/${entity.id }>${entity.title}<font><fmt:formatDate value="${entity.releaseDate}" pattern="yyyy-MM-dd" /></font></a></li>
		</c:forEach>
	</ul>
</div>
<div class="v2_pages">
	<%@include file="/ybl/v2/admin/common/noticesPage.jsp" %>
</div>
