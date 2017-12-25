<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理-修改</title>
<jsp:include page="../../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/supplier/voucherUpdate.js"></script>
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<form action="/voucherController/updateVoucherById" id="updateVoucherByIdForm" method="post">
			<div class="window_xx">
				<ul>
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucherNumber'></spring:message>：</span><input type="text"
								class="w300 text"  name="voucherNo" value="${voucher.voucherNo }"/><i class='red'>*</i><!-- 凭证编码 -->
						</div>
					</li>
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.amount'></spring:message>：</span><input  type="text" id='falseAmount'
								class="text w300"  value='<fmt:formatNumber value="${voucher.amount }" pattern="#,##0.00"></fmt:formatNumber>' onkeyup="value=value.replace(/[^\d.]/g,''),calcAmount()"  onblur="value=value.replace(/[^\d.]/g,''),calcAmount()"  />元<i class='red'>*</i>
								<input type="hidden" name="amount" value="${voucher.amount }" /> <!-- 凭证面额 -->
						</div></li>
					<li class="ww50 clear">
						<div class="input_box">
							<span><spring:message code='sys.client.coreCompanyName'></spring:message>：</span><!-- 核心企业名称 -->
							<div class="select_box">
								<select class="select w322" id="enterpriseMemeberId">
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
									<c:forEach items="${enterList }" var="enter"  >
										<option value="${enter.createdBy }" <c:if test="${voucher.enterpriseName== enter.enterpriseName}">selected="selected"</c:if> >${enter.enterpriseName }</option>
									</c:forEach>
								</select><i class='red'>*</i>
							</div>
						</div>
					</li>
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucherType'></spring:message>： </span><!-- 凭证类型 -->
							<div class="select_box">
								<select class="select w322" id="type" >
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
									<option value="应收账款单" <c:if test="${voucher.type=='应收账款单'}">selected="selected"</c:if> ><spring:message code='sys.client.account.receivable'></spring:message></option><!-- 应收账款单 -->
									<option value="商票" <c:if test="${voucher.type=='商票'}">selected="selected"</c:if> ><spring:message code='sys.client.commercial.paper'></spring:message></option><!-- 商票 -->
									<option value="银票" <c:if test="${voucher.type=='银票'}">selected="selected"</c:if> ><spring:message code='sys.client.bank.notes'></spring:message></option><!-- 银票 -->
								</select><i class='red'>*</i>
							</div>
						</div>
					</li>
					
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.start.time'></spring:message>：</span><input placeholder="请选择起始日期" type="text"
								class="text w300" id="effectiveDate" name="effectiveDate" date="true" value="${voucher.effectiveDate }" /><i class='red'>*</i>
						</div></li><!-- 凭证起始日期 -->
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.register.time'></spring:message>：</span><input id="registerDate" placeholder="请选择登记日期" type="text"
								class="text w300" name="registerDate" date="true" value="${voucher.registerDate }"/><i class='red'>*</i>
						</div></li><!-- 凭证登记日期 -->
					
					
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucher.expire.time'></spring:message>：</span><input id="expireDate" placeholder="请选择到期日期" type="text"
								class="text w300" name="expireDate" date="true" value="${voucher.expireDate }"/><i class='red'>*</i>
						</div><!-- 凭证到期日期 -->
					</li>
	
					<li class="clear"><div class="input_box">
							<span><spring:message code='sys.client.remarks'></spring:message>：</span><!-- 备注说明 -->
							<textarea class="text_tea w770 h100" id="remark" >${voucher.remark }</textarea>
						</div></li>
	
					<li>
						<div class="input_box">
							<span><spring:message code='sys.client.upload.voucher.picture'></spring:message>：</span><!-- 凭证附件上传 -->
							<div class="vip_phone">
								<dl>
									<c:forEach items="${attachmentList}" var="attach"  >
										<dd>
											<a><img src="${attach.url}" value="${attach.id }" ><i onclick='deleteAttachment(this)' ></i></a>
										</dd> 
									</c:forEach>
										<dd>
											<a id="addPicture"></a>
										</dd>
								</dl>
							</div>
						</div>
					</li>
				</ul>
				<!-- 凭证id -->
				<input type="hidden" name="voucherId" value="${voucher.id }" > 
				<!-- 凭证创建人 -->
				<input type="hidden" name="createdBy" value="${voucher.createdBy }" > 
				<!-- 凭证创建时间 -->
				<input type="hidden" name="createdTime" value="${voucher.createdTime }" > 
				<!-- 凭证所属供应商 -->
				<input type="hidden" name="memberId" value="${voucher.memberId }" >
				
				<div class="clear"></div>
				<div class="w_bottom">
					<ul>
						<li>
							<!-- <a class="now" id="voucherUpdateSubmitBtn">提交</a> -->
							<sun:button tag='a' clazz='now' id='voucherUpdateSubmitBtn' i18nValue='sys.client.submit'/>
							<sun:button tag='a' clazz='now none1' id='voucherUpdateSubmitingBtn' i18nValue='sys.client.submiting' />
							<!-- <a class="now none1" id="voucherUpdateSubmitingBtn">提交中</a> -->
						</li>
						<li><sun:button tag='a' id='anqu_close' i18nValue='sys.client.cancel' />
						<!-- <a id="anqu_close">取消</a> --></li>
					</ul>
				</div>
	
			</div>
		</form>
		
		<iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>
	</div>

</body>
</html>