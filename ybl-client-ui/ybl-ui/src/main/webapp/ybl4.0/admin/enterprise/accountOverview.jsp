<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link
	href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet">
 <%@include file="/ybl4.0/admin/common/link.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl4.0/resources/calendar/index.css">
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl4.0/resources/echarts/echarts.js"></script>
	<link rel="stylesheet" href="/ybl4.0/resources/css/vip_center.css" />

</head>
<body>
	<p class="per_title">
		<span>账户总览</span>
	</p>
	<input type="hidden" id="actualAmount" <c:choose><c:when test="${empty actualAmount or actualAmount eq '' }">value="0"</c:when>
             		<c:otherwise>value="<fmt:formatNumber value="${actualAmount}" pattern="##0.##" maxFractionDigits="2"/>"</c:otherwise></c:choose> >
	<input type="hidden" id="repaymentInterest" <c:choose><c:when test="${empty actualAmount or actualAmount eq '' }">value="0"</c:when>
             		<c:otherwise>value="<fmt:formatNumber value="${repaymentInterest}" pattern="##0.##" maxFractionDigits="2"/>"</c:otherwise></c:choose>>
	<table class="tabD2">
		<tr>
			<td>累计还款</td>
			<td>累计保理融资费</td>
		</tr>
		<tr>
			<td class="color-yellow"> 
				<c:choose>
             		<c:when test="${empty actualAmount or actualAmount eq '' }">
                    	0
              		</c:when>
             		<c:otherwise>
              			<fmt:formatNumber value="${actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/>
             		</c:otherwise>
          		</c:choose>
          		元
          	</td>
			<td class="color-blue">
				<c:choose>
					<c:when test="${empty repaymentInterest or repaymentInterest eq '' }">
                    	0
              		</c:when>
             		<c:otherwise>
             		<fmt:formatNumber value="${repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/>
             		</c:otherwise>
          		</c:choose>
          		元
			</td>
		</tr>
	</table>
	<div class="vip_right_content" style="width:945px">
	<div class="assets_chart">
		<div id="main" style="width: 340px;height:240px;top:-20px;"></div>
	</div>
	<div class="assets_chart_content" style="margin-left:250px;">
                    <ul>
                        <li>
                            <i class="ic1"></i>累计还款
                            <span style="margin-right:70px;"><em id='totalPrincipal'><c:choose>
                    <c:when test="${empty actualAmount or actualAmount eq '' }">
                        0
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/>
                    </c:otherwise>
                </c:choose></em>元</span>
                        </li>
                        <li>
                            <i style="background:#ff8111"></i>累计保理融资费
                            <span style="margin-right:70px;"><em id='totalUnInterest'><c:choose>
                    <c:when test="${empty repaymentInterest or repaymentInterest eq '' }">
                        0
                    </c:when>
                    <c:otherwise>
                    <fmt:formatNumber value="${repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/>
                    </c:otherwise>
                </c:choose></em>元</span>
                        </li>
                    </ul>
                </div>
    </div>
	<div class="bottom-line"></div>

	<p class="per_title mt40">
		<span>还款日历</span>
	</p>

	<div class="calendar">
		<!-- 账户主要表格 -->
		<input type="hidden" value="${repaymentPlan}" id="repaymentPlan">
		<div class="account-box">
			<h2 class="account-title">
				<span class="left c3">还款计划</span> <a href="###"
					class="f-btn-fhby right">返回本月</a>
				<div class="clearfix right">
					<div class="f-btn-jian left">&lt;</div>
					<div class="left f-riqi">
						<span class="f-year">2017</span>年<span class="f-month">1</span>月
					</div>
					<div class="f-btn-jia left">&gt;</div>
					<!-- 一定不能换行-->
				</div>
			</h2>
			<div class="f-rili-table">
				<div class="f-rili-head celarfix">
					<div class="f-rili-th">周日</div>
					<div class="f-rili-th">周一</div>
					<div class="f-rili-th">周二</div>
					<div class="f-rili-th">周三</div>
					<div class="f-rili-th">周四</div>
					<div class="f-rili-th">周五</div>
					<div class="f-rili-th">周六</div>
					<div class="clear"></div>
				</div>
				<div class="f-tbody clearfix"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
</script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl4.0/resources/js/enterprise/accountOverview.js"></script>
</html>
