<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
		var webType = "${webType}";
		switch(webType)
		{
		 case "pool": stylesearch("proType",1);break;
		 case "just": stylesearch("proType",2);break;
		 case "100": stylesearch("proMoney",1);break;
		 case "500": stylesearch("proMoney",2);break;
		 case "1000": stylesearch("proMoney",3);break;
		 case "5": stylesearch("proLv",1);break;
		 case "10": stylesearch("proLv",2);break;
		 case "20": stylesearch("proLv",3);break;
		}
		function stylesearch(obj,obj1){
			$("#"+obj+" a").eq(obj1).addClass("now");
			$("#"+obj+" a").eq(obj1).siblings().removeClass("now");
		}
		//列表按钮点击事件
		$("#seach_list_ul li a").live("click", function() {	
			var _aSign = $(this).attr("aSign");
			var _aSign_val = $(this).attr("value");
			$(this).addClass("now").siblings().removeClass("now");
			$("[name="+_aSign+"]").val(_aSign_val);
			//提交表单查询列表信息
    		$("#pageForm").submit();
		});
  	});
</script>
</head>
<body>
<form action="/gatewayController/queryProductList.htm" id="pageForm" method="post">
<div class="factoring_ban h360">
	<div class="v2_top_con">
		<div class="v2_head_top">
			<!--logo+menu-->
		    <%@ include file="/ybl/v2/admin/common/topV2.jsp" %> 
			<div class="v2_head_line"></div>
			<div class="factoring_seach_list">
				<ul id='seach_list_ul'>
				    <input type="hidden" name="type" value='${queryParam.type}'/>
				    <input type="hidden" name="minAmount" value='${queryParam.minAmount}'/>
				    <input type="hidden" name="minRate" value='${queryParam.minRate}'/>
					<li id="proType"
						url="/configController/get-PRODUCT_TYPE" 
						valueFiled="code_"
						textField="value_"
						aSign='type'
						defaultValue="${queryParam.type}"
						isAll="Y" spanField='产品类型'>
					</li>
					<li id="proMoney"
						url="/configController/get-FINANCE_AMOUNT" 
						valueFiled="code_"
						textField="value_"
						aSign='minAmount'
						defaultValue="${queryParam.minAmount}"
						isAll="Y" spanField='融资金额'>
					</li>
					<li id="proLv"
						url="/configController/get-FINANCE_RATE" 
						valueFiled="code_"
						textField="value_"
						aSign='minRate'
						defaultValue="${queryParam.minRate}"
						isAll="Y" spanField='融资利率'>
					</li>
				</ul>
			</div>
		</div>
	</div>	
</div>
<div class="v2_gateway_box">
	<div class="factoring ">
		<h1>保理列表</h1>
		<ul>
		 <c:forEach var="product" items="${list}" varStatus="index" >
			<li>
				<div class="factoring_list_s">
					<dl>
						<dd><div class="factoring_pic">
						<c:if test="${empty product.url_ }">
						<img src="${app.staticResourceUrl}/ybl/resources/images/top_bg2.jpg"/>
						</c:if>
						<c:if test="${!empty product.url_ }">
						<img src="${product.url_}"/>
						</c:if>
						</div></dd>
						<dd>
							<h2><a href="/gatewayController/queryProductById.htm?id=${product.id_ }">${product.name_ }</a></h2>
							<h3>
							<c:choose>
							  <c:when test="${product.min_amount > 10000}">
							  <fmt:formatNumber type="number" value="${product.min_amount/10000 }" pattern="#,##0.0000"/>亿 
							  </c:when>
							  <c:otherwise>
							  <fmt:formatNumber type="number" value="${product.min_amount }" pattern="#,##0.0000" />万 
							  </c:otherwise>
							</c:choose>
							~ 
							<c:choose>
							  <c:when test="${product.max_amount > 10000}">
							  <fmt:formatNumber type="number" value="${product.max_amount/10000 }" pattern="#,##0.0000" />亿 
							  </c:when>
							  <c:otherwise>
							  <fmt:formatNumber type="number" value="${product.max_amount }" pattern="#,##0.0000" />万 
							  </c:otherwise>
							</c:choose>
							<p>融资金额区间</p>
						</dd>
						<dd>
							<h2></h2>
							<h3><fmt:formatNumber type="number" value="${product.min_term }" maxFractionDigits="0"/>个月 ~ <fmt:formatNumber type="number" value="${product.max_term }" maxFractionDigits="0"/>个月</h3>
							<p>融资期限区间</p>
						</dd>
						<dd>
							<h2></h2>
							<h3><fmt:formatNumber value="${product.min_rate }" pattern="#,###.0#"/>%</h3>
							<p>最低融资利率</p>
						</dd>
						<dd><div class="factoring_but"><a href="javascript:view(${product.id_ });">咨询</a></div></dd>
					</dl>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
	<jsp:include page="/ybl/v2/admin/common/page.jsp"></jsp:include>
</div>
</form>
<%@ include file="/ybl/v2/admin/common/bottom.jsp" %> 
<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
</body>
<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox_v2.js"></script>
<script type="text/javascript">
$(function(){   
	view = function(id) {
		$.msgbox({
			height:650,
			width:850,
			content:'/gatewayController/toOrder.htm?id='+id,
			type :'iframe',
			title: '预约'
		});
		$('body').css({overflow:'hidden'});
	}
	
});   

</script>
</html>
