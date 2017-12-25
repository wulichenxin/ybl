<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>我的消息</title>
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<body>
		<p class="per_title mb30"><span>我的消息</span></p>
		<form action="/myMessageV4Controller/messageList.htm" id="pageForm" method="post">
					<div class="pd20">
						<div class="tabD">
							<table>
								<tr>
									<th>序号</th>
									<th>标题</th>
									<th>发送时间</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								<c:if test="${empty stationMessageList}">
								<tr><td colspan="15">暂无数据</td></tr>
							</c:if>
								<c:forEach var="data" items="${stationMessageList}" varStatus="index">
							<tr >
							<td>${index.count}</td>
							<td>${data.title}</td>
							<td><fmt:formatDate value="${data.createdTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><c:if test="${data.status=='1'}">
										已读
										<!-- 已读 -->
									</c:if> <c:if test="${data.status=='2'}">
										未读
										<!-- 未读 -->
									</c:if></td>
							<td><a  onclick="jumpPost('/myMessageV4Controller/messageDetails.htm',{id:${data.id}})"  href="#" url = "">查看</a></td>
							</tr>
						</c:forEach>
								
								
							</table>
						</div>
					</div>
					<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
					</form>
					<script type="text/javascript">
		
		function jumpPost(url,args) {
				console.info(args);
				var form = $("<form method='post'></form>");
		        form.attr({"action":url});
		        for (arg in args) {
		            var input = $("<input type='hidden'>");
		            input.attr({"name":arg});
		            input.val(args[arg]);
		            form.append(input);
		        }
		        $(document.body).append(form);
		        form.submit();
		    }
		
		</script>
	</body>
</html>
