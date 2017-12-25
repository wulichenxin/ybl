<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title></title>
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
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：消息中心 > 这是一条预警提示 -->
			<spring:message code="sys.v2.client.location" />
			:
			<spring:message code="sys.v2.client.message.center" />
		</div>
		<!--table-->
		<div class="v2_table_box mt20">
			<div class="v2_table_top">
				<div class="v2_table_nav">
					<ul>
						<li><a href="/v2messageController/messageList.htm"
							class="v2_but_back"><spring:message
									code="sys.v2.client.return" /> <!-- 返回 --></a></li>

							<li><a class="v2_but_bj"
								id='message_details_to_sign_noread_btn'> <spring:message
										code="sys.v2.client.sign.noRead" /> <!-- 标记未读 --></a></li>

						<li><a class="v2_but_del" id='message_details_delete_btn'><spring:message
									code="sys.v2.client.delete" /> <!-- 删除 --></a></li>
					</ul>
				</div>
			</div>
			<div class="v2_letter_con">
				<div class="v2_letter_tittle">
					<input id='id_' value='${id}' type='hidden' />
					<span style='width:60px;'><spring:message
							code="sys.v2.client.sender" />：</span>
					<span
						url="/loginV2Controller/getMemberById-${inbox.senderId}"
						textField="user_name"></span></p>
					<spring:message code="sys.v2.client.title" />
					：${inbox.title}
				</div>
				<div class="v2_letter_lr">
					<p>${inbox.content}</p>
				</div>
			</div>
		</div>
		<!--table-->
	</div>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>