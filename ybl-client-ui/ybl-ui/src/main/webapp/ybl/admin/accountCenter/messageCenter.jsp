<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
	<title><spring:message code="sys.client.message.center"/></title><!-- 消息中心 -->
	<jsp:include page="../common/link.jsp" />
	<script language='javascript'
		src="${app.staticResourceUrl}/ybl/resources/js/accountCenter/messageList.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp" />
	<!--top end -->
	<div class="path"><!-- 当前位置->账户中心 -> 消息中心 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.account.center"/>-> 
		<spring:message code="sys.client.message.center"/>
	</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../common/left.jsp?step=2" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder h700">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_3"></i>
						<spring:message code="sys.client.message.center"/><!-- 消息中心 -->
					</h1>
				</div>
				<div class="v_r_box">
					<div class="xtxx">
						<form action="/messageController/messageList" method="post"
							id="pageForm">
							<input type='hidden' name='isRead' id='isRead' />
							<div class="xtxx_tittle">
								 <a id='member_center_message_query_all_btn'>
								 	<spring:message code="sys.client.queryAll"/>
								 </a><!--全部 -->
								 <a id='member_center_message_query_all_read_btn'>
								 	<spring:message code="sys.client.read"/>
								 </a><!--已读 -->	
								 <a id='member_center_message_query_all_noread_btn'>
								 	<spring:message code="sys.client.noRead"/>
								 </a><!--未读 -->	
								 <sun:button tag='a' id='member_center_message_sign_to_noread_btn' i18nValue='sys.client.sign.noRead' /><!--标记为未读 -->	
								 <sun:button tag='a' id='member_center_message_sign_to_read_btn' i18nValue='sys.client.sign.read' /><!--标记为已读-->	
								 <sun:button tag='a' id='member_center_message_delete_btn' i18nValue='sys.client.delete' /><!--删除 -->	
							</div>
							<table class="xx_table">
								<tr>
									<th><input name="" type="checkbox" id='checkAll' /></th>
									<th><spring:message code="sys.client.sign"/></th><!--标记 -->
									<th><spring:message code="sys.client.sender"/></th><!--发件人 -->
									<th><spring:message code="sys.client.title"/></th><!--标题 -->
									<th><spring:message code="sys.client.send.time"/></th><!-- 发送时间 -->
								</tr>
								<c:forEach var="data" items="${inboxList}" varStatus="index">
									<tr>
										<td><input name="checkbox" type="checkbox" value=""
											ids='${data.id}' /></td>
										<td><c:if test="${data.isRead=='Y'}"><spring:message code="sys.client.read"/><!-- 已读 --></c:if> <c:if
												test="${data.isRead=='N'}"><spring:message code="sys.client.noRead"/><!-- 未读 --></c:if></td>
										<td>${data.attribute1}</td>
										<td>
											<a class='open_content'>${data.title}</a>
											<a class='close_content' style="display: none;">${data.title}</a>
										</td>
										<td><fmt:formatDate value="${data.createdTime}"
												pattern="yyyy-MM-dd" /></td>
									</tr>
									<tr class="inbox_table" style="display: none;">
										<td colspan="5">
											${data.content}
										</td>
									</tr>
								</c:forEach>
							</table>
							<jsp:include page="../common/page.jsp"></jsp:include>
						</form>
					</div>
					<!--1over-->
				</div>
			</div>
		</div>
		<!--conover-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>
