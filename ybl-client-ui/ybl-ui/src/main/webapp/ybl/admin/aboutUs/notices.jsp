<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top'}">
	<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
	<jsp:include page="/ybl/admin/common/link.jsp" />
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<div class="body_con">
</c:if>
<div class="content">
	<div class="about_box" id="noticesPage">
		<h1><span></span>公告</h1>
		<div class="a_news_gg">
			<ul>
				<form method="post" id="noticesPageForm">
					<c:forEach items="${platformNoticeList }" var="bean">
						<li><a>${bean.title }<font><fmt:formatDate value="${bean.releaseDate}" pattern="yyyy-MM-dd" /></font></a></li>
					</c:forEach>
                </form>
			</ul>
		</div>
		<jsp:include page="../common/noticesPage.jsp"></jsp:include>
	</div>
</div>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top'}">
	</div>
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
</c:if>