<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title>云保理</title>
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />

<%-- <link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/> --%>

</head>
<body>
<div class="business">
	<div class="v2_top_con">
		<%@ include file="/ybl/v2/admin/common/topV2.jsp" %>
		<div class="v2_gateway_con">
			<div class="v2_business_left"></div>
		</div>
		
	</div>	
</div>
<div class="v2_gateway_box">
	<div class="v2_business_bodycon">
   		<div class="v2_business_tittle">
   			<div class="v2_tittle"><span class="bus_tittle_ico1"></span>平台业务流程</div>
   		</div>
   		<div class="v2_business_lc"></div>
    </div>
    <div class="v2_business_bg">
    	<div class="v2_business_bodycon">
   		<div class="v2_business_tittle">
   			<div class="v2_tittle v2_b_bg"><span class="bus_tittle_ico2"></span>平台角色说明</div>
   		</div>
   		<div class="v2_business_sm">
   			<div class="v2_business_pic fl"><img src="${app.staticResourceUrl}/ybl/resources/v2/images/business_pic01.png"/></div>
   			<div class="v2_business_xx fr">
   				<h1>【供应商】账款融资</h1>
   				<div class="v2_business_bz">
   					<ul>
   						<li>应收账款转让</li>
   					</ul>
   				</div>
   				<p>卖方（供应商）在平台申请由保理机构购买其与买方因商品赊销产生的应收账款，并在账款到期未付时承担回购该应收账款的责任。</p>
   			</div>
   		</div>
    	</div>
    </div>
    <div class="v2_business_bodycon">
   		<div class="v2_business_sm">
   			<div class="v2_business_pic fr"><img src="${app.staticResourceUrl}/ybl/resources/v2/images/business_pic02.png"/></div>
   			<div class="v2_business_xx fl">
   				<h1>【核心企业】账款确权</h1>
   				<div class="v2_business_bz">
   					<ul>
   						<li>账款到期兑付</li>
   					</ul>
   				</div>
   				<p>买方（核心企业）在平台上对自身开具的账款凭证确权，为有合作关系的买方背书，提升买方在平台的融资资信能力。</p>
   			</div>
   		</div>
    </div>
    <div class="v2_business_bg">
    	<div class="v2_business_bodycon">
   		
   		<div class="v2_business_sm">
   			<div class="v2_business_pic fl"><img src="${app.staticResourceUrl}/ybl/resources/v2/images/business_pic03.png"/></div>
   			<div class="v2_business_xx fr">
   				<h1>【保理机构】审核放款</h1>
   				<div class="v2_business_bz">
   					<ul>
   						<li>尽职调查</li>
   						<li>风控审核</li>
   						<li>结算放款</li>
   					</ul>
   				</div>
   				<p>资方（保理机构）在平台上维护基于买卖方交易合作的三方融资协议，通过线下尽调、风控审核、财务结算等来完成卖方在平台的账款融资放款。</p>
   			</div>
   		</div>
    	</div>
    </div>
</div>

<%-- <%@include file="/ybl/v2/admin/common/bottom.jsp" %>  --%>
<%@include file="/ybl/admin/common/bottomV2.jsp" %>


<!--弹出窗登录-->


<%-- <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/yuangong_v2.js"></script> --%>

</body>


</html>
