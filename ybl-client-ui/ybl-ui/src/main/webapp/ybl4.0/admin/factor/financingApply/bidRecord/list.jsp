<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
	<!--top start -->
	<jsp:include page="/ybl4.0/admin/common/top.jsp" />		
	<!--top end -->
	<body class="bgf5">
		
		<div class="w1200 mt40">
			<form action="/financingApplyController/bidRecord/list.htm" id="pageForm" method="post">
				<input type="hidden" value="" name="flag" id="flag"/>
			</form>
			<form action="/financingApplyController/bidRecord/details.htm" id="pageForm2" method="post">
				<input type="hidden" value="" name="id" id="id"/>
			</form>
			<div class="contlist">
				<c:if test="${list.size() ne 0 }">
				<div class="xmtitle clearfix">
					<ul class="clearfix">
						<li class="sortlist"><a class="getFlag" href="#" flag="0">默认排序</a></li>
						<li class="sortlist"><a class="getFlag" href="#" flag="1">融资利率</a></li>
						<li class="sortlist"><a class="getFlag" href="#" flag="2">融资期限</a></li>
						<li class="sortlist"><a class="getFlag" href="#" flag="3">融资金额</a></li>
					</ul>
				</div>
				</c:if>
				<ul class="xmul">
					<c:if test="${list.size() eq 0 }">
						<div class="none_img"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
					</c:if>
					<c:forEach items="${list}" var="obj" varStatus="index">
						<li class="xmli">
							<p class="listname"><span class="mr30">融资订单号</span><span class="mr30">${obj.financingOrderNumber}</span><span class="mr20 jgname">(融资机构：${obj.enterpriseName })</span></p>
							<div class="clearfix outd">
								<div class="leftimg">
									<img src="${app.staticResourceUrl}/ybl4.0/resources/images/jingbiao_icon.png" />
									<p>已竞标</p>
									<p>
									<span>
										<c:if test="${obj.count eq 0 }">0</c:if>
										<c:if test="${obj.count ne 0 }">${obj.count}</c:if>	
									</span>家
									</p>
								</div>
								
								<div class="xm_d">
									<p>融资利率(%)</p>
									<p class="color-yellow"><fmt:formatNumber value="${obj.financingRate }" pattern="0.####"/></p>
								</div>
								<div class="xm_d">
									<p>融资金额(元)</p>
									<p><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##"/></p>
								</div>
								<div class="xm_d">
									<p>融资期限(天)</p>
									<p>
										${obj.financingTerm}
									</p>
								</div>
								<div class="xm_d">
									<p>融资截止日期</p>
									<p><fmt:formatDate value="${obj.bidExpireDate }" pattern="yyyy-MM-dd" /></p>
								</div>
								<div class="xm_d">
									<a href="#" class="xm_btn" id = "${obj.id }">我要参与</a>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<c:if test="${list.size() ne 0 }">
				<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
			</c:if>
		</div>
	</body>
	
	<script>
		$(function(){
			//排序规则绑定点击事件
			$(".getFlag").click(function(){
				var flag = $(this).attr("flag");
				$("#flag").val(flag);
				$("#pageForm").submit();
			})
			
			//详情页绑定点击事件
			$(".xm_btn").click(function(){
				var id = $(this).attr("id");
				$("#id").val(id);
				$("#pageForm2").submit();
			});
			
			
		})
	</script>
</html>