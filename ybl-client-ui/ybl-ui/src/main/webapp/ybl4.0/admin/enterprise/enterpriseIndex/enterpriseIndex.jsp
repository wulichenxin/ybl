<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
		
		 <%@include file="/ybl4.0/admin/common/link.jsp" %> 
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/enterprise/enterpriseIndex.js"></script>
	</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp" />
	<body>
		<div class="hometitle"><div class="w1200"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/dbsx_icon.png" class="mr10" />待办事项<span class="ml20">(您有<span class="color-yellow">${toDoNum }</span>件待办事项！)</span><a href="javascript:;" id="more_todo_btn" class="more-a">更多>></a></div></div>
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
		</div>
		
		<div class="hometitle"><div class="w1200"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/index/yjtx_icon.png" class="mr10" />预警提醒<span class="ml20">(您有<span class="color-yellow">${warningRepaymentSize }</span>封新提醒！)</span><a href="javascript:;" id="more_warning_reminder" class="more-a">更多>></a></div></div>
		<div class="w1200">
			<div class="tabD border-none">
				<table>
					<tr>
						<th>序号</th>
						<th>内容</th>
						<th>时间</th>
					</tr>
					<c:forEach var="warningRepaymentData" items="${warningRepayment }" varStatus="status">
						<tr>
						<td>${status.index + 1 }</td>
						<td>待还款信息预警： ${warningRepaymentData.financingName },放款申请，订单号${warningRepaymentData.loanApplyOrderNo }</td>
						<td><fmt:formatDate value='${warningRepaymentData.repaymentDate }' pattern='yyyy-MM-dd' /></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<div class="mb80"></div>
	</body>
</html>