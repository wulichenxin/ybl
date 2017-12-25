<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>贷款申请</title>
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
	var index;
	var timer;
	// 添加
	function add_start() {
		$('#add').show();
		$('t_window').css({
			overflow : 'hidden'
		});
	}
	function add_close() {
		clearInterval(timer);
		$('#add').hide();
		$('body').css({
			overflow : ''
		});
	}
	$(function(){
		$("#loanApplicationQueryBtn").click(function(){
			$("#pageForm").submit();
		})
		
		$("#loanApplicationReset").click(function(){
			
			$("input[name='enterpriseName']").val("");
			$("input[name='registerAmount']").val("");
			$("select[name='provinceId']").val("");
		})
	})

</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->

	<div class="path"><spring:message code='sys.client.location'></spring:message>-><!-- 当前位置 -->
					<spring:message  code='sys.client.financeApply'></spring:message> -> <!-- 融资申请 -->
					<spring:message  code='sys.client.loan.apply'></spring:message><!-- 贷款申请 -->
					</div>
	<form action="/loanApplicationController/loanApplication" id="pageForm" method="post">
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li>
						<label><spring:message code='sys.client.enterprise.name'></spring:message> :</label><!-- 公司名称 -->
						<input type="text" name="enterpriseName" value="${enterpriseSign.enterpriseName }" />
					</li>
					<li>
						<label><spring:message code='sys.client.registe.amount'></spring:message> :</label><!-- 注册资金 -->
						<input type="text" name="registerAmount" value="${enterpriseSign.registerAmount }" onkeyup="value=value.replace(/[^\d.]/g,'')"  
							onblur="value=value.replace(/[^\d.]/g,'')"/>
					</li>
					<li>
						<label><spring:message code='sys.client.register.province'></spring:message>:</label><!-- 注册省份 -->
						<select name="provinceId">
							<option value="" ><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
							<c:forEach items="${proList }" var="pro">
								<option value="${pro.id }" <c:if test="${pro.id == enterpriseSign.provinceId}">selected ='selected'</c:if>  >${pro.name }</option>
							</c:forEach>
						</select>
					</li>
					<li>
						<div class="button_yellow">
							<a id="loanApplicationQueryBtn">查询</a>
						</div>
					</li>
					<li>
						<div class="button_gary">
							<a id="loanApplicationReset"><spring:message code='sys.client.reset'></spring:message> </a><!-- 重置 -->
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->
		<!--table-->
		<div class="table_box">
			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><spring:message code='sys.client.no'></spring:message></th><!-- 序号 -->
						<th><spring:message code='sys.client.factor.enterpriseName'></spring:message></th><!-- 保理商名称 -->
						<th><spring:message code='sys.client.register.province'></spring:message></th><!-- 注册省份 -->
						<th><spring:message code='sys.client.investBidManage.MainBusiness'></spring:message></th><!-- 主营业务 -->
						<th><spring:message code='sys.client.registe.amount'></spring:message></th><!-- 注册资金/元 -->
						<th><spring:message code='sys.client.licenseNumber'></spring:message></th><!-- 营业执照号 -->
						<th><spring:message code='sys.client.companyTelephone'></spring:message></th><!-- 企业电话 -->
						<th><spring:message code='sys.client.business.status'></spring:message></th><!-- 营业状态 -->
						<!-- <th>服务状态</th> -->
						<th><spring:message code='sys.admin.operation'></spring:message></th><!-- 操作 -->
					</tr>
				<c:forEach items="${enterList}" var="enter" varStatus="varStatus" >
				   <c:if test="${varStatus.count %2 == 0 }">
					 <tr class="bg_1"> 
				   </c:if>	
				   <c:if test="${varStatus.count %2 != 0 }">
					 <tr > 
				   </c:if>	
						<td>${varStatus.count}</td>
						<td><a href="/loanApplicationController/factorDetails?id=${enter.enterpriseId}">${enter.enterpriseName }</a></td>
						<td>${enter.provinceName}</td>
						<td>${enter.bussinessScope}</td>
						<td><fmt:formatNumber value="${enter.registerAmount}" pattern="#,##0.00"></fmt:formatNumber></td>
						<td>${enter.licenseNo}</td>
						<td>${enter.fixedPhone}</td>
						<td>
							<c:if test="${enter.businessStatus =='normal'}">
								<spring:message code='sys.client.business.status.normal'></spring:message><!-- 正常 -->
							</c:if>
							<c:if test="${enter.businessStatus =='freeze'}">
								<spring:message code='sys.client.business.status.freeze'></spring:message><!-- 冻结 -->
							</c:if>  
							<c:if test="${enter.businessStatus =='logout'}">
								<spring:message code='sys.client.business.status.logout'></spring:message><!-- 注销 -->
							</c:if>
						</td>
						<!-- <td>已签约</td> -->
						<td><div class="qy">
								<sun:button tag='a' href="/loanApplicationController/factorDetails?id=${enter.enterpriseId}" id='supplierChoseProductBtn' i18nValue='sys.client.select.product' />
								<%-- <a href="/loanApplicationController/factorDetails?id=${enter.enterpriseId}">选择产品</a> --%>
							</div></td> 
					</tr>
				</c:forEach>
				</table>

			</div>
			<div class="pages">
				<jsp:include page="../../common/page.jsp"></jsp:include>
			</div>
		</div>
		<!--table-->
	</div>
	</form>
	<!-- 底部jsp -->
	<jsp:include
		page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>