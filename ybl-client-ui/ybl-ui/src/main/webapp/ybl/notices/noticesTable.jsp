<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
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
<jsp:include page="/ybl/admin/common/noticesPage.jsp"></jsp:include>
