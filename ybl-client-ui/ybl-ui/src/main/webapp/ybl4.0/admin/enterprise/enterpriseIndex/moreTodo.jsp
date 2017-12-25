<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<jsp:include page="/ybl4.0/admin/common/top.jsp" />
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/enterprise/enterpriseIndex.js"></script>
	</head>

	<body>
<div class="hometitle"><div class="w1200"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/dbsx_icon.png" class="mr10" />待办事项<span class="ml20">(您有<span class="color-yellow">${page.recordCount}</span>件待办事项！)</span></div></div>
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
					 <c:forEach var="indexTodoData" items="${indexTodo }" varStatus="status">
						<tr>
						<td>${status.index + 1 }</td>
						<td><c:if test="${indexTodoData.type ne '5' }">待确权信息</c:if><c:if test="${indexTodoData.type eq '5' }">待还款信息</c:if></td>
						<td>${indexTodoData.enterpriseName },融资申请，订单号${indexTodoData.orderNo }</td>
						<td><fmt:formatDate value='${indexTodoData.createdTime }' pattern='yyyy-MM-dd' /></td>
						<td><a class="btn-modify handle_btn" uid="${indexTodoData.id }" utype="${indexTodoData.type }" orderNo="${indexTodoData.orderNo }">处理</a></td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<form action="/enterpriseIndexV4Controller/moreTodo.htm" id="pageForm" method="post">
		<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</form>
		</div>
		<div class="mb80"></div>
		<a href="javascript:;" class="btn-add btn-center mb80" id="go_to_back">返回</a>	
	</body>

</html>