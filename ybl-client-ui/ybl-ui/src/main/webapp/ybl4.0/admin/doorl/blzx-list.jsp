<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>保理列表</title>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/css/common.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/huitou.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/common.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript">
	$(function() {
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
		$("#seach_list_ul li a").click(function() {	
			var _aSign = $(this).attr("aSign");
			var _aSign_val = $(this).attr("value");
			$(this).addClass("now").siblings().removeClass("now");
			$("[name="+_aSign+"]").val(_aSign_val);
			//提交表单查询列表信息
    		$("#pageForm").submit();
		});
  	});
	function jumpPost(url,args) {
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
<style type="text/css">
.factoring_seach_list ul li a.now{
    background: #1958BC;
}
</style>
</head>
<body>
	<form action="/factorConsultationController/queryProductList.htm" id="pageForm" method="post">
		<%@ include file="/ybl4.0/admin/doorl/common/top-blzx.jsp" %>
		<div class="w1200">
			<div class="contwrap condition factoring_seach_list">
				<h1>筛选条件</h1>
				<ul class="conditionList" id='seach_list_ul'>
					<input type="hidden" name="attribute1" value='${queryParam.attribute1}'/>
				    <input type="hidden" name="minAmount" value='${queryParam.minAmount}'/>
				    <input type="hidden" name="rate" value='${queryParam.rate}'/>
				    <li style="height:50px" id="proType"
						url="/configController/get-PRODUCT_TYPE" 
						valueFiled="code_"
						textField="value_"
						aSign='attribute1'
						defaultValue="${queryParam.attribute1}"
						isAll="Y" spanField='产品类型'>
					</li>
					<li style="height:50px" id="proMoney"
						url="/configController/get-FINANCE_AMOUNT" 
						valueFiled="code_"
						textField="value_"
						aSign='minAmount'
						defaultValue="${queryParam.minAmount}"
						isAll="Y" spanField='融资金额'>
					</li>
					<li style="height:50px" id="proLv"
						url="/configController/get-FINANCE_RATE" 
						valueFiled="code_"
						textField="value_"
						aSign='rate'
						defaultValue="${queryParam.rate}"
						isAll="Y" spanField='融资利率'>
					</li>
					<!-- <li>
						<dl>
							<dt>产品类型：</dt>
							<dd name="money"><span value="0" class="active">不限</span><span value="1">池保理</span><span value="2">明保理</span><span value="3">暗保理</span></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>融资金额：</dt>
							<dd name="deadline"><span value="0" class="active">不限</span><span value="1">100万</span><span value="2">500万</span><span value="3">1000万</span></dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt>融资利率：</dt>
							<dd name="loanType">
								<span value="0" class="active">不限</span>
								<span value="10">5%</span>
								<span value="11">10%</span>
								<span value="13">20%</span>
							</dd>
						</dl>
					</li> -->
				</ul>
				<div class="clear"></div>
			</div>
			<div class="border-b mt30"></div>
			
			<div class="mt40">
				<p class="listtitle mb20">保理公司</p>
			<c:forEach var="product" items="${list}" varStatus="index" >
				<ul>
					<li class="Companylist">
						<%-- <c:if test="${empty product.url_ }">
						<img src="${app.staticResourceUrl}/ybl/resources/images/top_bg2.jpg"/>
						</c:if>
						<c:if test="${!empty product.url_ }">
						<img src="${product.url_}"/>
						</c:if> --%>
						<img src="/ybl4.0/resources/images/blzx/blzx_company_img.png" />
						<span><a href="/factorConsultationController/queryProductById.htm?id=${product.id_ }">${product.name_ }</a></span>
						<%-- <c:choose>
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
						<span>融资金额区间<span>
						<fmt:formatNumber type="number" value="${product.min_term }" maxFractionDigits="0"/>个月
						 ~ 
						 <fmt:formatNumber type="number" value="${product.max_term }" maxFractionDigits="0"/>个月
						<span>融资期限区间<span> --%>
							<span>超低利率，低至年利率<fmt:formatNumber value="${product.rate}" type="percent"/></span>
						<a onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${product.id_}})" style="position: absolute;right: 0; width: 180px;line-height: 40px;
							border-radius: 20px;text-align: center; color: white;background: #1958BC; top: 47px;">查询</a>
					</li>
				</ul>
			</c:forEach>	
			</div>
		<%@ include file="/ybl4.0/admin/common/page.jsp" %> 	
		</div>
	</form>		
</body>
</html>
