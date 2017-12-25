<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理-添加</title>
<jsp:include page="../../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/supplier/voucherAdd.js"></script>
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<form action="/voucherController/addVoucherinfo" id="addVoucherInfoForm" method="post">
			<div class="window_xx">
				<ul>
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucherNumber'></spring:message> ：</span><input  type="text"
								class="w300 text"  maxlength="30" name="voucherNo" /><i class='red'>*</i><!-- 凭证编码 -->
						</div>
					</li>
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.amount'></spring:message> ：</span><input  type="text"
								class="text w300" name="amount" maxlength="10"  onkeyup="value=value.replace(/[^\d.]/g,'')"  onblur="value=value.replace(/[^\d.]/g,'')"  /><i class='red'>*</i><!-- 凭证面额 -->
						</div></li>
					<li class="ww50 clear">
						<div class="input_box">
							<span><spring:message code='sys.client.coreCompanyName'></spring:message> ：</span><!-- 核心企业名称 -->
							<div class="select_box">
								<select class="select w322" id="enterpriseMemeberId" >
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
								<c:forEach items="${enterList }" var="enter" >
									<option value="${enter.createdBy}">${enter.enterpriseName}</option>
								</c:forEach>
								</select><i class='red'>*</i>
							</div>
						</div>
					</li>
					<li class="ww50" >
						<div class="input_box">
							<span><spring:message code='sys.client.voucherType'></spring:message>：</span><!-- 凭证类型 -->
							<div class="select_box">
								<select class="select w322" id="type">
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
									<option value="应收账款单"><spring:message code='sys.client.account.receivable'></spring:message></option><!-- 应收账款单 -->
									<option value="商票"><spring:message code='sys.client.commercial.paper'></spring:message></option><!-- 商票 -->
									<option value="银票"><spring:message code='sys.client.bank.notes'></spring:message></option><!-- 银票 -->
								</select><i class='red'>*</i>
							</div>
						</div>
					</li>
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucher.start.time'></spring:message>：</span><input  type="text"
								class="text w300" id="effectiveDate" name="effectiveDate" date="true"/><i class='red'>*</i><!-- 凭证起始日期 -->
						</div>
					</li>
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.register.time'></spring:message>：</span><input id="registerDate"  type="text"
								class="text w300" name="registerDate" date="true"/><i class='red'>*</i><!-- 凭证登记日期 -->
						</div></li>
						
					<li class="ww50">
						<div class="input_box">
							<span><spring:message code='sys.client.voucher.expire.time'></spring:message>：</span><input id="expireDate"  type="text"
								class="text w300" name="expireDate" date="true" /><i class='red'>*</i><!-- 凭证到期日期 -->
						</div>
					</li>
						
					
	
					<li class="clear"><div class="input_box">
							<span><spring:message code='sys.client.remarks'></spring:message>：</span>
							<textarea class="text_tea w770 h100" id="remark" maxlength="1024" ></textarea><!-- 备注说明 -->
						</div></li>
	
					<li>
						<div class="input_box">
							<span><spring:message code='sys.client.upload.voucher.picture'></spring:message> ：</span><!-- 凭证附件上传 -->
							<div class="vip_phone">
								<dl>
									<%-- <dd>
										<a><img src="${app.staticResourceUrl}/ybl/resources/images/login_bg_01.jpg" /><i></i></a>
									</dd> --%>
									<dd>
										<a id="addPicture"></a>
									</dd>
								</dl>
							</div>
						</div>
					</li>
				</ul>
				<div class="clear"></div>
				<div class="w_bottom">
					<ul>
						<li>
							<sun:button tag='a' clazz='now' id='addVoucherSubmitBtn' i18nValue='sys.client.submit'/>
							<sun:button tag='a' clazz='now none1' id='addVoucherSubmitingBtn' i18nValue='sys.client.submiting' />
						</li>
						
						<li><sun:button tag='a' id='anqu_close' i18nValue='sys.client.cancel' />
						<%-- <a id="anqu_close"><spring:message code=''></spring:message></a> --%></li><!-- 取消 -->
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