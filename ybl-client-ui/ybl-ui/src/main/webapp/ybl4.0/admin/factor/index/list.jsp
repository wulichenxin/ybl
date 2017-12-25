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
		<div class="hometitle"><div class="w1200"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/dbsx_icon.png" class="mr10" />待办事项<span class="ml20">(您有<span class="color-yellow">${todoTotalCount }</span>件待办事项！)</span><a href="<%=basePath%>factorIndexController/todo/1/more.htm" class="more-a">更多>></a></div></div>
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
					<c:if test="${empty todoList}">
						<tr><td colspan="5">暂无数据</td></tr>
					</c:if>
					<c:forEach items="${todoList}" var="obj" varStatus="index">
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
		</div>
		<div class="hometitle"><div class="w1200"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/yjtx_icon.png" class="mr10" />预警提醒<span class="ml20">(您有<span class="color-yellow">${earlyWarningTotalCount }</span>封新提醒！)</span><a href="<%=basePath%>/factorIndexController/earlywarning/1/more.htm" class="more-a">更多>></a></div></div>
		<div class="w1200">
			<div class="tabD border-none">
				<table>
					<tr>
						<th>序号</th>
						<th>内容</th>
					</tr>
					<c:if test="${empty earlyWarningList}">
						<tr><td colspan="2">暂无数据</td></tr>
					</c:if>
					<c:forEach items="${earlyWarningList}" var="obj" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${obj.content }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<script>
			$(function(){
				$(".todo").click(function(){
					param={
							"category":1
					};
					httpPost('/factorIndexController/todo/more.htm',param);
				});
				
			})
		</script>
	</body>
</html>