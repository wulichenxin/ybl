<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
	</head>
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		<form action="/factorIndexController/earlywarning/${category }/more.htm" id="pageForm" method="post">
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class='formli <c:if test="${category == 1}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/earlywarning/1/more.htm'">收款确认预警</li>
			</ul>
		</div>
		<div class="w1200">
			<div class="tabD border-none">
				<table>
					<tr>
						<th>序号</th>
						<th>内容</th>
					</tr>
					<c:if test="${empty page.records}">
						<tr><td colspan="2">暂无数据</td></tr>
					</c:if>
					<c:forEach items="${page.records}" var="obj" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${obj.content }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		</form>
	</body>
</html>