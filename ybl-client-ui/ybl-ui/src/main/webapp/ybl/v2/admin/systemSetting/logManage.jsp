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
<title><spring:message code="sys.v2.client.log.manage" /></title>
<!-- 日志管理 -->
<%-- <%@include file="/ybl/v2/admin/common/link.jsp"%> --%>
<!--top start -->
<jsp:include page="/ybl4.0/admin/common/top.jsp" />
<!--top end -->
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/v2/js/systemSetting/logManage.js"></script>
<style type="text/css">
</style>
</head>
<body>
<div class="w1200">
	<form action="/v2LogController/queryUserLoginLog.htm" method="post" id='pageForm'>
	<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />日志管理</div>
		</div>
		<div class="ybl-info">
                <div class="ground-form mb20">
                    <div class="form-grou mr40">
                        <label class="label-long">登录名：</label>
                        <input class="content-form" name="userName" value="${userName }">
                    </div>
                     <div class="btn-modify" id="userlog_serach_btn">查询</div>
                </div>
            </div>
	<div class="mt40">
            <div class="tabD">
                <div>
                    <table>
                       <tr>
                        <th>序号 </th>
                        <th width="300">登录时间</th>
                        <th>登录IP</th>
                        <th>登录名</th>
                        <th>操作终端 </th>
                        <th>操作内容 </th>
                    </tr>
                        <c:if test="${empty list }">
                        <tr><td colspan="6">暂无数据</td></tr>
                        </c:if>
                       <c:forEach items="${list}" var="data" varStatus="index">
                        <tr>
                            <td>${index.count}</td>
                            <td><fmt:formatDate value="${data.createdTime}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td>${data.loginIp}</td>
                            <td>${data.userName}</td>
                            <td>${data.operatorTerminal}</td>
                            <td>${data.context}</td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
            </div>
            <jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
            </div>
	</form>
	</div>
	<script type="text/javascript">
	   $(function(){
		    $(".context").click(function(){
		    	var context = $(this).siblings().html();
		    	dialog.open('/v2LogController/queryUserLoginLogContext.htm?context='+context, '850px', '650px', 'iframe', '请求参数');
				close('outClose');
		    });
	   });
	</script>
</body>
</html>