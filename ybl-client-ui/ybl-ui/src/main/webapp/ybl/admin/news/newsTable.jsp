<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<h1><span></span>新闻资讯</h1>
<div class="a_news">
	<ul id="newsPage">
		<form method="post" id="newPageForm">
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
<jsp:include page="/ybl/admin/common/newsPage.jsp"></jsp:include>
