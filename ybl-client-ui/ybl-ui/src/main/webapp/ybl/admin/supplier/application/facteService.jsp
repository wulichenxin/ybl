<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.facte.service"></spring:message> </title><!-- 保理服务 -->
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
$(function(){   
	view = function(enterprise2Id) {
		$.msgbox({
			height:760,
			width:1000,
			content:"/facteServiceController/facteServiceSign?enterprise2Id="+enterprise2Id,
			type :'iframe',
			title: $.i18n.prop('sys.client.sign.apply.sign.factor'), /* 签约保理商 */ 
		});
	}
	
	$("#enterpriseSignQuery").click(function(){
		$("#pageForm").submit();
	})
	
	
	resetForm = function(){
		
		$("input[name='enterpriseName']").val("");
		$("input[name='registerAmount']").val("");
		$("select[name='provinceId']").val("");
		$("select[name='signStatus']").val("");
	}
	
});   





</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->
	<div class="path">
		<spring:message code="sys.client.location"/>-> <!-- 当前位置 -->
		<spring:message code="sys.client.financeApply"/>-> <!-- 融资申请-->
		<spring:message code="sys.client.facte.service"/>-> <!-- 保理服务 -->
	</div>
	<form action="/facteServiceController/facteService" id="pageForm" method="post">
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.companyName" />:<!-- 企业名称: --></label><input type="text" name="enterpriseName" value="${enterpriseSign.enterpriseName}"/></li>
					<li><label><spring:message code="sys.client.registe.amount" />: <!-- 注册资金: --></label><input type="text" name=registerAmount value="${enterpriseSign.registerAmount}" onkeyup="value=value.replace(/[^\d.]/g,'')"  onblur="value=value.replace(/[^\d.]/g,'')"/>元</li>
					<li><label><spring:message code="sys.client.register.province" />:  <!-- 注册省份: --></label>
							<select name="provinceId">
								<option value=""><spring:message code="sys.client.select" />  <!-- 请选择 --></option>
								<c:forEach items="${proList}" var="pro">
										<option value="${pro.id}" <c:if test='${enterpriseSign.provinceId==pro.id}'>selected ='selected' </c:if>  >${pro.name}</option>
								</c:forEach>
							</select>
					</li>
					<li><label><spring:message code="sys.client.sign.status" ></spring:message>: <!-- 签约动态: --></label>
						<select name="signStatus">
							<option value=""><spring:message code="sys.client.queryAll"></spring:message> <!-- 全部 --></option>
							<option value="notsign" <c:if test="${enterpriseSign.signStatus=='notsign'}">selected ='selected'</c:if> ><spring:message code="sys.client.investBidManage.NotSigned"></spring:message>  <!-- 待签约 --></option>
							<option value="signing" <c:if test="${enterpriseSign.signStatus=='signing'}">selected ='selected'</c:if> ><spring:message code="sys.client.investBidManage.PendingContract"></spring:message> <!-- 签约中 --></option>
							<option value="signed" <c:if test="${enterpriseSign.signStatus=='signed'}">selected ='selected'</c:if> ><spring:message code="sys.client.investBidManage.Signed"></spring:message> <!-- 已签约 --></option>
							<option value="unsign" <c:if test="${enterpriseSign.signStatus=='unsign'}">selected ='selected'</c:if> ><spring:message code="sys.client.investBidManage.unsign"></spring:message> <!-- 已拒绝 --></option>
						</select>
					</li>

					<li><div class="button_yellow">
							<sun:button id="enterpriseSignQuery" tag='a' i18nValue="sys.client.query"/><!-- 查询 -->
						</div></li>
					<li><div class="button_gary">
							<a  href="javascript:void(0);" onclick="resetForm()" ><spring:message code="sys.client.reset"/>  <!-- 重置 --></a>
						</div></li>
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
						<th width="50"><spring:message code="sys.client.no"/></th><!-- 序号 -->
						<th><spring:message code="sys.client.supplier.enterpriseName" /> </th><!-- 保理商名称 -->
						<th><spring:message code="sys.client.register.province" /> </th><!-- 注册省份< --> 
						<th><spring:message code="sys.client.registe.amount" /> </th><!-- 注册资金/元 -->
						<th><spring:message code="sys.client.licenseNumber"/> </th><!-- 营业执照号 -->
						<th><spring:message code="sys.client.phone"/> </th><!-- 联系电话 -->
						<th><spring:message code="sys.client.business.status" /> </th><!-- 营业状态 -->
						<th><spring:message code="sys.client.sign.status" /></th><!-- 签约动态 -->
						<th><spring:message code="sys.client.operation" /></th><!-- 操作 -->
					</tr>
					<c:forEach var="enterprise" items="${enterList}" varStatus="index" >
					<tr>
						<td>${index.count}</td>
						<td><a href="/loanApplicationController/factorDetails?id=${enterprise.enterpriseId}" >${enterprise.enterpriseName }</a></td>
						<td>${enterprise.provinceName}</td>
						<td><fmt:formatNumber value="${enterprise.registerAmount}" type="currency" pattern="#,##0.00" /></td>
						<td>${enterprise.licenseNo}</td>
						<td>${enterprise.fixedPhone}</td>
						<td>
							<c:if test="${enterprise.businessStatus =='normal'}">
								<spring:message code="sys.client.business.status.normal"/> <!-- 正常 -->
							</c:if>
							<c:if test="${enterprise.businessStatus =='freeze'}">
								<spring:message code="sys.client.business.status.freeze"/> <!-- 冻结 -->
							</c:if>  
							<c:if test="${enterprise.businessStatus =='logout'}">
								<spring:message code="sys.client.business.status.logout"/><!-- 注销 -->
							</c:if>
						</td>
						<td>
							<c:if test="${enterprise.signStatus =='signed'}">
								<spring:message code="sys.client.investBidManage.Signed"/><!-- 已签约 -->
							</c:if>  
							<c:if test="${enterprise.signStatus =='unsign'}">
								<spring:message code="sys.client.investBidManage.unsign"/><!-- 拒绝 -->
							</c:if>  
							<c:if test="${enterprise.signStatus =='signing'}">
								<spring:message code="sys.client.investBidManage.PendingContract"/><!-- 待审核 -->
							</c:if>
							<c:if test="${enterprise.signStatus == ''}">
								<spring:message code="sys.client.investBidManage.NotSigned"/><!-- 未签约 -->
							</c:if>
						</td>
						<td>
							<c:if test="${enterprise.signStatus =='signed'}">
								<div class="bqy">
									<sun:button tag='a' id="supplierSignebBtn" i18nValue="sys.client.signOpration" />
								</div>
							</c:if>  
							<c:if test="${enterprise.signStatus =='unsign' || enterprise.signStatus ==''}">
								<div class="qy">
									<sun:button  tag='a' id="supplierApplySignBtn" i18nValue="sys.client.signOpration" href="javascript:view('${enterprise.enterpriseId}');" />
									<%-- <a href="javascript:view('${enterprise.enterpriseId}');">签约</a> --%>
								</div>
							</c:if>
							<c:if test="${enterprise.signStatus =='signing'}">
								<div class="bqy">
									<a><spring:message code="sys.client.signOpration"/></a><!-- 签约 -->
								</div>
							</c:if> 
						</td>
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
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
	
</body>
</html>