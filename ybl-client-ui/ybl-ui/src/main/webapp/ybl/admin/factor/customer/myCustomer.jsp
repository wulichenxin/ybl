<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.myCustomer"/></title><!-- 我的客户 -->
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
	$(function() {
		var id_ = $("#id_").val();
		var memberSignId= $("#memberSignId").val();
		
		view = function(id) {
			$.msgbox({
				height : 700,
				width : 1000,
				content : '/signController/queryEnterpriseByCondition?id_='+id+"&memberSignId="+memberSignId,
				type : 'iframe',
				title : $.i18n.prop("sys.client.sign.apply.sign.factor")
			});
			$('body').css({overflow:'hidden'});
		}
		
		
		$("#member_factor_mySignManage_query_btn").click(function(){
			$("#pageForm").submit();
		});
		//重置
		$("#reset").click(function(){
			$("#enterprise_name").val('');
			$("#license_no").val('');
		})
	});
	
</script>
<script type="text/javascript">
	$(function() {
		$("#member_factor_mySignManage_unsign_btn").click(function(){
			var status_ = 'unsign';
			var enterprise_name = $("#enterprise_name").val();
			var license_no = $("#license_no").val();
			window.location.href ="/myCustomerController/myCustomer?status_="+status_+"&enterprise_name="+enterprise_name+"&license_no="+license_no;
			
		})
		
		$("#member_factor_mySignManage_signed_btn").click(function(){
			var status_ = 'signed';
			var enterprise_name = $("#enterprise_name").val();
			var license_no = $("#license_no").val();
			window.location.href ="/myCustomerController/myCustomer?status_="+status_+"&enterprise_name="+enterprise_name+"&license_no="+license_no;
		
		})
		
	});
		$(function(){
			
			var s = $("#status").val();
			if(s == 'unsign'){
				$(".tabnav dl dd").eq(0).removeClass("now");
				$(".tabnav dl dd").eq(1).addClass("now");
			}else{
				$(".tabnav dl dd").eq(0).addClass("now");
			}
		})
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=7" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.customer.manage"/> -> <spring:message code="sys.client.myCustomer"/></div>
	<div class="vip_conbody">
		<form action="/myCustomerController/myCustomer" id="pageForm" method="post">
		<input type="hidden" id=status  value="${status_ }">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.clientName"/><!-- 客户名称 -->:</label><input type="text" name="enterprise_name" id="enterprise_name" value="${enterprise_name }"/></li>
					<li><label><spring:message code="sys.client.licenseNumber"/><!-- 营业执照号 -->:</label><input type="text" name="license_no" id="license_no" value="${license_no }"/></li>

					<li><div class="button_yellow">
							<sun:button tag='a' id='member_factor_mySignManage_query_btn' i18nValue='sys.client.query' />
						</div>
					</li>
					<li><div class="button_gary">
							<a id="reset"><spring:message code="sys.client.reset"/><!-- 重置 --></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->
		<!--table-->
		<div class="table_box tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<sun:button tag='a' id='member_factor_mySignManage_signed_btn' i18nValue='sys.client.investBidManage.SignedCustomer' /><!-- 已签约客户 -->
						
					</dd>
					<dd>
						<sun:button tag='a' id='member_factor_mySignManage_unsign_btn' i18nValue='sys.client.investBidManage.SignedCustomer' /><!-- 已拒绝客户 -->
					</dd>
				</dl>
			</div>
			<div>
				<!--按钮top-->
				<div class="table_con content">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.client.no"/><!-- 序号 --></th>
							<th width="200"><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
							<th width="150"><spring:message code="sys.client.licenseNumber"/><!-- 营业执照号 --></th>
							<th width="100"><spring:message code="sys.client.registe.amount"/><!-- 注册资金/万 --></th>
							<th width="200"><spring:message code="sys.client.investBidManage.MainBusiness"/><!-- 主营业务 --></th>
							<%-- <th width="100"><spring:message code="sys.client.investBidManage.companySize"/><!-- 公司规模/人 --></th> --%>
							<th width="100"><spring:message code="sys.client.investBidManage.contacts"/><!-- 联系人 --></th>
							<th width="100"><spring:message code="sys.client.phone"/><!-- 联系电话 --></th>
							<th width="100"><spring:message code="sys.client.investBidManage.ApplicationForSigningTime"/><!-- 申请签约时间 --></th>
							<th width="100"><spring:message code="sys.client.investBidManage.SigningStatus"/><!-- 签约状态 --></th>
							<th width="100"><spring:message code="sys.client.investBidManage.SigningDetails"/><!-- 签约详情 --></th>
						</tr>
						
						<c:forEach var="enterprise" items="${list}" varStatus="index" >
			            <tr class="bg_l">
			            	<input type="hidden" id="id_" value="${enterprise.enterprise_id}"/>
			            	<input type="hidden" id="memberSignId" value="${enterprise.id_1}"/>
			                <td>${index.count}</td>
			                <td><a class="lan" href="/myCustomerController/queryEnterprise?id_=${enterprise.enterprise_id}">${enterprise.enterprise_name}</a></td>
							<td>${enterprise.license_no}</td>
							<td><fmt:formatNumber value="${enterprise.register_amount /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
							<td>${enterprise.bussiness_scope}</td>
							<td>${enterprise.legal_name}</td>
							<td>${enterprise.legal_phone}</td>
							<td>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${enterprise.created_time}" />
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
							
							</td>
							<td><c:if test="${enterprise.status_ =='signed'}">
									<spring:message code="sys.client.investBidManage.Signed"/><!-- 已签约 -->
								</c:if>  
								<c:if test="${enterprise.status_ =='unsign'}">
									<spring:message code="sys.client.investBidManage.unsign"/><!-- 拒绝 -->
								</c:if>  
								<c:if test="${enterprise.status_ =='signing'}">
									<spring:message code="sys.client.investBidManage.PendingContract"/><!-- 待签约 -->
								</c:if>
								<c:if test="${enterprise.status_ == ''}">
									<spring:message code="sys.client.investBidManage.NotSigned"/><!-- 未签约 -->
								</c:if>
							</td>
							<td><div class="qy">
									<sun:button tag='a' href="javascript:view(${enterprise.enterprise_id});" id='member_factor_mySignManage_look_btn' i18nValue='sys.client.look' />
								</div>
							</td>
						</tr>
						</c:forEach>
						
					</table>
				</div>
				
			</div>
			<jsp:include page="../../common/page.jsp"></jsp:include>
		</div>
		<!--table-->
	</form>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>