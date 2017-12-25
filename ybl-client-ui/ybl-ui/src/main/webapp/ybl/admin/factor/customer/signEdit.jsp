<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.sign.manage"/>-<spring:message code="sys.admin.view"/></title><!-- 签约管理 --> <!-- 查看 -->
<jsp:include page="../../common/link.jsp" />

<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
	$(function() {
		var signId = $("#id_1").val();
		$("#member_factor_sign_Manage_Audit_btn").click(function(){
			var agreement = $('input[name="agreement"]:checked').val();
			if(agreement == '' || agreement == null ){
				alert($.i18n.prop("sys.client.investBidManage.SignFactoringLoanContractAgreement"));/*请签署保理贷款合同合约 ! */
				return false;
			}
			$.msgbox({
				height : 430,
				width : 620,
				content : '/signController/audit?signId='+signId,
				type : 'iframe',
				title : $.i18n.prop("sys.client.auditOperator")
			});
			
		})
		$("#member_factor_sign_Manage_cancel_btn").click(function(){
			parent.$(".msgbox_close").mousedown();
		})
	});
	
</script>

</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con" id="a">
		<div class="clear"></div>
		<div class="window_xx">
			<input type="hidden" id="id_1" value="${memberSign.id_ }"/>
			<ul>
				<li><div class="input_box">
						<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span><input value="${enterprise.enterprise_name }" type="text"
							class="w300 text_gary" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input value="${enterprise.fixed_phone}" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input value="${enterprise.license_no}" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.legalPersonName"/><!-- 法人代表名称 -->：</span><input value="${enterprise.legal_name}" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.legalPersonIDCard"/><!-- 法人代表身份证号 -->：</span><input value="${enterprise.legal_card_id}"
							type="text" class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.phone"/><!-- 联系电话号码 -->：</span><input value="${enterprise.legal_phone}" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li class="w472"><div class="input_box">
						<span><spring:message code="sys.client.registe.amount"/><!-- 企业注册资金 -->：</span><input value="<fmt:formatNumber value="${enterprise.register_amount /10000}" pattern="#,##0.00" maxFractionDigits="2"/>" type="text"
							class="text w200" disabled="disabled"/><spring:message code="sys.client.tenThousand"/>
					</div></li>
				<%-- <li>
					<div class="input_box">
						<span><spring:message code="sys.client.look"/>企业规模：</span>
						<div class="select_box">
							<select class="select w200">
								<option><spring:message code="sys.client.look"/>请选择</option>
								<option>北京</option>
								<option>深圳</option>
							</select>
						</div>
					</div>
				</li> --%>
				<li class="clear"><div class="input_box">
						<span><spring:message code="sys.client.investBidManage.ApplicationForSigningTime"/><!-- 申请签约时间 -->：</span>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${memberSign.created_time}" />
							
							<input value="<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.investBidManage.MainBusiness"/><!-- 主营业务范围 -->：</span><input value="${enterprise.bussiness_scope}" type="text"
							class="text_gary w300" disabled="disabled"/>
					</div></li>
				<%-- <li><div class="input_box">
						<span><spring:message code="sys.client.investBidManage.IndustryOwned"/><!-- 所属行业 -->：</span><input value="${enterprise.type_}" type="text"
							class="text w300" disabled="disabled"/>
					</div></li> 
				<li><div class="input_box">
						<span><spring:message code="sys.client.phone"/><!-- 联系电话 -->：</span><input  type="text"
							class="text w300" disabled="disabled"/>
					</div></li>--%>
				<li>
					<div class="input_box">
						<span><spring:message code="sys.client.investBidManage.SignUpAttachment"/><!-- 签约附件 -->：</span>
						<div class="vip_phone">
							<dl>
								<c:forEach var="attach" items="${attachmentList}">
										<dd>
											<a><img src="${attach.url }" /></a>
										</dd>
								</c:forEach>
							</dl>
						</div>
					</div>
				</li>
				
				<c:if test="${type =='audit' }">
					<li class="clear"><div class="w_agreen">
							<input name="agreement" type="checkbox" value="1" /><spring:message code="sys.client.investBidManage.factoringServiceAgreement"/><!-- 同意签署保理服务协议 -->
						</div></li>
				</c:if>
					
			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
				<c:if test="${memberSign.status_ == 'signing' }">
					<li><sun:button tag='a' id='member_factor_sign_Manage_Audit_btn' i18nValue='sys.client.auditOperator' clazz='now'/><!-- 审核 --></a></li>
				</c:if>
			
				<c:if test="${memberSign.status_ == 'signed' || memberSign.status_ == 'unsign'}">
					<li><a><spring:message code="sys.client.auditOperator" /><!-- 审核 --></a></li>
				</c:if>
					<li><a id='member_factor_sign_Manage_cancel_btn'><spring:message code="sys.client.cancel"/><!-- 取消 --></a></li>
				</ul>
			</div>

		</div>
	</div>
</body>
</html>