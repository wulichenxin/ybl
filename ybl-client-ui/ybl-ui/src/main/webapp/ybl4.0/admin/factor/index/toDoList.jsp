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
		<form action="/factorIndexController/todo/${category }/more.htm" id="pageForm" method="post">
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class='formli <c:if test="${category == 1}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/1/more.htm'">风控初审</li>
				<li class='formli <c:if test="${category == 2}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/2/more.htm'">风控终审</li>
				<li class='formli <c:if test="${category == 3}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/3/more.htm'">放款审核</li>
				<li class='formli <c:if test="${category == 4}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/4/more.htm'">资产确权</li>
				<li class='formli <c:if test="${category == 5}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/5/more.htm'">放款管理</li>
				<li class='formli <c:if test="${category == 6}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>factorIndexController/todo/6/more.htm'">收款确认</li>
			</ul>
		</div>
		<div class="w1200">
			<div class="tabD border-none">
				<table>
					<tr>
						<th>序号</th>
						<th>事项</th>
						<th>内容</th>
						<th>时间</th>
						<th>操作</th>
					</tr>
					<c:if test="${empty page.records}">
						<tr><td colspan="5">暂无数据</td></tr>
					</c:if>
					<c:forEach items="${page.records}" var="obj" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${obj.category }</td>
							<td>${obj.content }</td>
							<td><fmt:formatDate value="${obj.dateTime }" pattern="yyyy-MM-dd" /></td>
							<td><a class="btn-modify" href="<%=basePath%>factorIndexController/${obj.resourceId }/${obj.type }/toDeal">处理</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<c:if test="${category != 7}">
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</c:if>
		</div>
		
		</form>
	</body>
</html>