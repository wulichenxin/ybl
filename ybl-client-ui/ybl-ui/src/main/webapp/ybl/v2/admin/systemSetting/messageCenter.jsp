<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
	<title><spring:message code="sys.v2.client.message.center" /></title>
	<!-- 消息中心 -->
	<%@include file="/ybl/v2/admin/common/link.jsp"%>
	<script language='javascript'
		src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/messageList.js"></script>
</head>
<body>
	<div class="v2_top_bg v2_t_bg2 h165">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp"%>
			</div>
		</div>
	</div>
	<form action="/v2messageController/messageList.htm" method="post"
		id="pageForm">
		<div class="v2_vip_conbody">
			<div class="v2_path_no">
				<!-- 当前位置：消息中心 -->
				<spring:message code="sys.v2.client.location" />
				:
				<spring:message code="sys.v2.client.message.center" />
			</div>
			<!--table-->
			<div class="v2_table_box mt20">
				<div class="v2_table_top">
					<div class="v2_table_nav">
						<ul>
							<li><a class="v2_but_all "
								id='member_center_message_query_all_btn'> <spring:message
										code="sys.v2.client.queryAll" /> <!-- 全部 --></a></li>
							<li><a class="v2_but_yd"
								id='member_center_message_query_all_read_btn'><spring:message
										code="sys.v2.client.read" /> <!-- 已读 --></a></li>
							<li><a class="v2_but_wd"
								id='member_center_message_query_all_noread_btn'><spring:message
										code="sys.v2.client.noRead" /> <!-- 未读 --></a></li>
							<li><sun:button tag='a' clazz='v2_but_bj'
									id='member_center_message_sign_to_noread_btn'
									i18nValue='sys.v2.client.sign.noRead' /> <!--标记为未读 --></li>
							<li><sun:button tag='a'
									id='member_center_message_sign_to_read_btn'
									i18nValue='sys.client.sign.read' clazz='v2_but_bj' />
								<!--标记为已读--></li>
							<li><sun:button tag='a'
									id='member_center_message_delete_btn' clazz='v2_but_del'
									i18nValue='sys.v2.client.delete' /></li>
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="v2_table_con">
					<input type='hidden' name='isRead' id='isRead' />
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="50"><input type="checkbox" id='checkAll' /></th>
							<th><spring:message code="sys.v2.client.sign" /></th>
							<!--标记 -->
							<th width="700"><spring:message code="sys.v2.client.title" /></th>
							<!--标题 -->
							<th><spring:message code="sys.v2.client.sender" /></th>
							<!--发件人 -->
							<th><spring:message code="sys.v2.client.send.time" /></th>
							<!-- 发送时间 -->
						</tr>
						<c:forEach var="data" items="${inboxList}" varStatus="index">
							<tr class="${data.isRead=='N'?'noread_tr':'isread_tr'}">
								<td><input name="checkBox" type="checkbox" ids='${data.id}' /></td>
								<td><c:if test="${data.isRead=='Y'}">
										<spring:message code="sys.v2.client.read" />
										<!-- 已读 -->
									</c:if> <c:if test="${data.isRead=='N'}">
										<spring:message code="sys.v2.client.noRead" />
										<!-- 未读 -->
									</c:if></td>
								<td class="tl"><a class="lan"
									href="/v2messageController/messageDetails.htm-${data.id}">${data.title}</a>
								</td>
								<td url="/loginV2Controller/getMemberById-${data.senderId}" textField="user_name"></td>
								<td><fmt:formatDate value="${data.createdTime}"
										pattern="yyyy-MM-dd hh:mm:ss" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- page.jsp -->
			<%@include file="/ybl/v2/admin/common/page.jsp"%>
			<!-- page.jsp -->
			<!--table-->
		</div>
	</form>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>
