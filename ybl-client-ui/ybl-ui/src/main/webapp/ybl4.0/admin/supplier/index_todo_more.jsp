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
		<form action="/supplierIndexController/todo/${category }/more.htm" id="pageForm" method="post">
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class='formli <c:if test="${category == 1}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/1/more.htm'">融资申请待办</li>
				<li class='formli <c:if test="${category == 2}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/2/more.htm'">放款申请待办</li>
				<li class='formli <c:if test="${category == 3}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/3/more.htm'">选择资金方待办</li>
				<li class='formli <c:if test="${category == 4}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/4/more.htm'">确定资金方待办</li>
				<li class='formli <c:if test="${category == 5}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/5/more.htm'">收款确认待办</li>
				<li class='formli <c:if test="${category == 6}">form_cur</c:if>' onclick="javascript:window.location.href='<%=basePath%>supplierIndexController/todo/6/more.htm'">待还款待办</li>
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
							<td>
								<c:if test="${obj.category eq '明保理融资申请待提交' or obj.category eq '暗保理融资申请待提交' }"><a class="btn-modify handle-financing" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
								<c:if test="${obj.category eq '放款申请待提交' }"><a class="btn-modify handle-loan" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
								<c:if test="${obj.category eq '明保理融资申请选择资金方' or obj.category eq '暗保理融资申请选择资金方'}"><a class="btn-modify handle-select-funs" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
								<c:if test="${obj.category eq '明保理融资申请确定资金方' or obj.category eq '暗保理融资申请确定资金方'}"><a class="btn-modify handle-confirm-funs" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
								<c:if test="${obj.category eq '放款申请待收款确认'}"><a class="btn-modify handle-confirm-loan" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
								<c:if test="${obj.category eq '待还款'}"><a class="btn-modify handle-payment-loan" uid="${obj.resourceId }" href="javascript:void(0);">处理</a></c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		
		</form>
		<script type="text/javascript">
			// 处理融资申请
			$('.handle-financing').click(function(){
				var uid = $(this).attr("uid");
				var param = new Array();
				param = {
					"id":uid
				};
				httpPost('/financingApplyV4Controller/financingApply/update.htm', param);
			});
			// 处理放款申请
			$('.handle-loan').click(function(){
				var uid=$(this).attr("uid");
				var param = new Array();
				param = {
					"id":uid,
				};
				httpPost('/loanApplyV4Controller/loanApply/update.htm', param);
			});
			// 处理待选择资金方
			$('.handle-select-funs').click(function(){
				var uid=$(this).attr("uid");
				var param = new Array();
				httpPost('/chooseFundsController/chooseFundsList', param);
			});
			// 处理待确定资金方
			$('.handle-confirm-funs').click(function(){
				var uid=$(this).attr("uid");
				var param = new Array();
				httpPost('/chooseFundsController/confirmFundsList', param);
			});
			// 处理收款确认待办
			$('.handle-confirm-loan').click(function(){
				var uid=$(this).attr("uid");
				var param = new Array();
				param = {
					"id_":uid,
				};
				httpPost('/financingToConfirm/info', param);
			});
			// 处理待还款待办
	        $('.handle-payment-loan').click(function(){
	            var uid=$(this).attr("uid");
	            var param = new Array();
	            param = {
	                "id":uid,
	                "url":"/supplierIndexController/todo/6/more.htm"
	            };
	            httpPost('/rePayMentController/selectChildrenDetail.htm', param);
	        });
		</script>
	</body>
</html>