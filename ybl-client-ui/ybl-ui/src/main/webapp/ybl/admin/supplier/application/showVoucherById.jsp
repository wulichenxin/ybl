<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理-查看</title>
<jsp:include page="../../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#queryVoucherByIdCheckBtn").click(function(){
			$("#anqu_close").click();
		})
	})
</script>
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
							<span><spring:message code='sys.client.voucherNumber' ></spring:message>：</span><input  type="text"
								class="w300 text"  name="voucherNo" value="${voucher.voucherNo }" readonly="readonly" />
						</div><!-- 凭证编码 -->
					</li>
					<li  class="ww50" >
						<div class="input_box">
							<span><spring:message code='sys.client.voucher.amount'></spring:message>：</span><input placeholder="请选择凭证面额" type="text"
								class="text w300" name="amount"  value="<fmt:formatNumber value='${voucher.amount }' pattern='#,##0.00'></fmt:formatNumber>"  readonly="readonly"/>
						</div></li><!-- 凭证面额 -->
					<li class="ww50 clear" >
						<div class="input_box">
							<span><spring:message code='sys.client.coreCompanyName'></spring:message>：</span><!-- 核心企业名称 -->
							<div class="select_box">
								<select class="select w322" id="enterpriseMemeberId" disabled="disabled">
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
									<c:forEach items="${enterList }" var="enter"  >
										<option value="${enter.createdBy }" <c:if test="${voucher.enterpriseName== enter.enterpriseName}">selected="selected"</c:if> >${enter.enterpriseName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</li>
					<li class="ww50" >
						<div class="input_box">
							<span><spring:message code='sys.client.voucherType'></spring:message>： </span><!-- 凭证类型 -->
							<div class="select_box">
								<select class="select w322" id="type" disabled="disabled" >
									<option value=""><spring:message code='sys.client.select'></spring:message></option><!-- 请选择 -->
									<option value="应收账款单" <c:if test="${voucher.type=='应收账款单'}">selected="selected"</c:if> ><spring:message code='sys.client.account.receivable'></spring:message></option><!-- 应收账款单 -->
									<option value="商票" <c:if test="${voucher.type=='商票'}">selected="selected"</c:if> ><spring:message code='sys.client.account.receivable'></spring:message></option><!-- 商票 -->
									<option value="银票" <c:if test="${voucher.type=='银票'}">selected="selected"</c:if> ><spring:message code='sys.client.bank.notes'></spring:message></option><!-- 银票 -->
								</select>
							</div>
						</div>
					</li>
					
					<li class="ww50"><div class="input_box">
							<span><spring:message code='sys.client.voucher.start.time'></spring:message>：</span><!-- 凭证起始日期 -->
							<jsp:useBean id="effectiveDate" class="java.util.Date" />
							<jsp:setProperty name="effectiveDate" property="time" value="${voucher.effectiveDate}" />
							<input type="text" class="text w300" id="effectiveDate" name="effectiveDate" date="true" value='<fmt:formatDate value="${effectiveDate}" pattern="yyyy-MM-dd" />' readonly="readonly" />
						</div>
					</li>
					<li class="ww50" ><div class="input_box">
							<span><spring:message code='sys.client.voucher.register.time'></spring:message>：</span><!-- 凭证登记日期 -->
							<jsp:useBean id="registerDate" class="java.util.Date" />
							<jsp:setProperty name="registerDate" property="time" value="${voucher.registerDate}" />
							<input type="text" class="text w300" name="registerDate" date="true" value='<fmt:formatDate value="${registerDate}" pattern="yyyy-MM-dd" />' readonly="readonly"/>
						</div></li>
					<li class="ww50" >
						<div class="input_box">
							<span><spring:message code='sys.client.voucher.expire.time'></spring:message>：</span><!-- 凭证到期日期 -->
							<jsp:useBean id="expireDate" class="java.util.Date" />
							<jsp:setProperty name="expireDate" property="time" value="${voucher.registerDate}" />
							<input  type="text" class="text w300" name="expireDate" date="true" value='<fmt:formatDate value="${expireDate}" pattern="yyyy-MM-dd" />' readonly="readonly"/>
						</div>
					</li>
	
					<li class="clear"><div class="input_box">
							<span><spring:message code='sys.client.remarks'></spring:message>：</span><!-- 备注说明 -->
							<textarea class="text_tea w770 h100" id="remark"   readonly="readonly">${voucher.remark }</textarea>
						</div></li>
	
					<li>
						<div class="input_box">
							<span><spring:message code='sys.client.upload.voucher.picture'></spring:message>：</span><!-- 凭证附件上传 -->
							<div class="vip_phone">
								<dl>
									<c:forEach items="${attachmentList}" var="attach"  >
										<dd>
											<a><img src="${attach.url}" value="${attach.id }" ></a>
										</dd> 
									</c:forEach>
								</dl>
							</div>
						</div>
					</li>
				</ul>
				
				<div class="clear"></div>
				<div class="w_bottom">
					<ul>
						<li><a class="now" id="queryVoucherByIdCheckBtn">确认</a></li>
						<li><a id="anqu_close">取消</a></li>
					</ul>
				</div>
	
			</div>
		</form>
	</div>
</body>
</html>