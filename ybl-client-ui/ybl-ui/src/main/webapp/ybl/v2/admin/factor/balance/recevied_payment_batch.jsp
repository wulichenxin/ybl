<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message
		code="sys.v2.client.batch.amountOfMoneyBack" /></title>
<!-- 批量回款 -->
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<!-- 检验文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
</head>
<body>
	<div class="v2_top_bg v2_t_bg2 h165">
		<div class="v2_top_con">
			<div class="v2_head_top">
				<%@include file="/ybl/v2/admin/common/top.jsp" %>
				<div class="v2_z_nav">
					<div class="v2_z_nav_con">
						<div class="v2_z_navbox">
							<a href="/v2disbursementController/queryGenerateBatchList.htm">
								<spring:message code="sys.v2.client.Loan.outAccount" /> <!-- 放款出账 -->
							</a><a class="w150 now" href="javascript:void(0);"> <spring:message
									code="sys.v2.client.enterprise.repayment" /> <!-- 核心企业回款 -->
							</a><a class="w130" href="/v2BalanceController/queryBuyBackList.htm">
								<spring:message code="sys.v2.client.supplier.buyback" /> <!-- 供应商回购 -->
							</a><a href="/v2BalanceController/queryRefundProcessList.htm">
								<spring:message code="sys.v2.client.refund.process" /> <!-- 退款处理 -->
							</a><a href="/v2BalanceController/queryPlatformReconList.htm"> <spring:message
									code="sys.v2.client.platform.recon" /> <!-- 平台对账 --></a>
						</div>
					</div>
				</div>
			</div>
			<!--搜索条件-->
		</div>
	</div>
	<!---->
	<div class="v2_vip_conbody">
		<div class="v2_path_no">
			<!-- 当前位置：结算中心 >  核心企业回款 >  批量回款 -->
			<spring:message code="sys.v2.client.location" />
			：
			<spring:message code="sys.v2.client.settlement.mamage" />
			>
			<spring:message code="sys.v2.client.enterprise.repayment" />
			>
			<spring:message code="sys.v2.client.batch.amountOfMoneyBack" />
		</div>
		<div class="v2_box_border mt20">
			<div class="v2_tab_con">
				<div class="v2_flow">
					<ul>
						<li class="ww100 clear">第<font class="v2_number">1</font>步，下载<a
							class="lan" href="/v2repaymentController/downloadRepaymentTemplate.htm" >回款记录导入模板EXCEL</a>。
						</li>
						<li class="ww100 clear">第<font class="v2_number">2</font>步，在模板EXCEL中添加回款记录,请填写正确的凭证编号。
						</li>
						<li class="ww100 clear">第<font class="v2_number">3</font>步，上传EXCEL表。
						</li>
						<li class="ww100 clear"><div class="v2_input_box">
								<span>&nbsp;</span>
								<!-- <input placeholder="" type="hidden" 
									class="w300 v2_text fl mr10" /> -->
								<div class="v2_add_but">
									<a href="javascript:void(0);" id="user-payment-import"><spring:message code="sys.v2.client.upload"/><!-- 上传 --></a>
								</div>
								<c:if test="${ msg == 'success'}">
								 	<em class="green">√ 回款记录处理成功！</em>
								 </c:if>
								 <c:if test="${ msg == 'fail'}">
								 	<em class="red">× 回款记录处理失败！</em>
								 </c:if>
							</div>
						</li>

					</ul>
				</div>

				<div class="v2_but_list">
					<a class="bg_g" id="return"><spring:message code="sys.v2.client.return"/><!-- 返回 --></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 隐藏的文件上传表单 begin-->
	<form  id="repayment_upload_form"  action="/v2repaymentController/saveRepayments" method="post" enctype="multipart/form-data" style="display: none;" target="uploadFrame">
	    <input id="payment_file" style="display: none;" type="file" name="paymentfile" class="paymentfile" />
	    <input id="payment_submit" type="submit" class="btn" value="submit" />
	 </form>
<!-- 隐藏的文件上传表单 end -->
	<iframe name="uploadFrame" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
	<script type="text/javascript">
	
	function _callback(msg){
		   alert(msg);
	   }
	
		$(function() {
			$(".je").mousemove(function() {
				$(".v2_back_xx").slideDown();
			});
			$(".je").mouseleave(function() {
				$(".v2_back_xx").slideUp();
			});
			
			$("#return").click(function(){
				history.back(-1);
			});
			
			$("#user-payment-import").click(function() {//点击按钮
				$("#payment_file").click(); //打开资源管理器
			});
			
			
			$("#payment_file").watchProperty("value",function(){//监听#payment_file
				
				$("#payment_submit").click();  //触发上传文件的动作
				
			});
			
			
			
			
		});
	</script>
</body>
</html>
