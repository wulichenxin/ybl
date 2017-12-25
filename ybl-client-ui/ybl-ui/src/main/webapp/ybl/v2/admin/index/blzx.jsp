<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%><!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
		
		$("#search").click(function(){
			$("#pageForm").submit();
		});
	})
</script>
</head>
<body>

   <div class="factoring_ban">
	<div class="v2_top_con">
		<%@ include file="/ybl/v2/admin/common/topV2.jsp" %> 
		<!---->
		
		<div class="v2_gateway_con">
		<form action="/gatewayController/queryProductList.htm" id="pageForm" method="post">
			<div class="factoring_seach fr">
				<ul>
					<li><div class="factoring_seach_input"><label>贷款金额</label><input type="text" name="minAmount" /><span>万元</span></div></li>
					<li><div class="factoring_seach_input"><label>贷款期限</label><input type="text" name="minTerm"/><span>月</span></div></li>
					<li><div class="factoring_seach_input"><label>贷款利率</label><input type="text" name="minRate"/><span>%</span></div></li>
					<li><div class="factoring_seach_but"><a href="javascript:;" id="search">搜索保理</a></div></li>
				</ul>
			</div>
		</form>
			<div class="factoring_banner fl">
				<h1>快速融资</h1>
				<h2>就上云保理</h2>
				<div class="factoring_bxx ">
					<ul>
						<li>
							<div class="factoring_td">
								<h3>1180亿</h3>
								<p>获批融资</p>
							</div>
						</li>
						<li>
							<div class="factoring_td">
								<h3>2000家</h3>
								<p>入驻平台</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
	</div>	
</div>

<!---->


<div class="v2_gateway_box">
	<div class="factoring">
		<h1>热门保理<span><a href="/gatewayController/queryProductList.htm">更多>></a></span></h1>
		<ul>
		
		 <c:forEach var="product" items="${list}" varStatus="index" >
			<li>
				<div class="factoring_list">
					<dl>
						<dd><div class="factoring_pic"><c:if test="${empty product.url_ }">
						<img src="${app.staticResourceUrl}/ybl/resources/images/top_bg2.jpg"/>
						</c:if>
						<c:if test="${!empty product.url_ }">
						<img src="${product.url_}"/>
						</c:if></div></dd>
						<dd>${product.name_ }</dd>
						<dd>${product.desc_ }</dd>
						<dd><div class="factoring_but"><a href="/gatewayController/queryProductById.htm?id=${product.id_ }">查看</a></div></dd>
					</dl>
				</div>
			</li>
		</c:forEach>
		
		</ul>
	</div>
</div>

<%@ include file="/ybl/v2/admin/common/bottom.jsp" %> 
<%-- <%@include file="/ybl/admin/common/bottomV2.jsp" %> --%>

<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
</body>
</html>
