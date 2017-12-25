<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理-添加/修改</title>
<jsp:include page="../common/link.jsp" />
<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->凭证管理 -> 凭证详情</div>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<form action="/voucherController/updateVoucherById" id="updateVoucherByIdForm" method="post">
			<div class="window_xx">
				<ul>
					<li>
						<div class="input_box">
							<span>凭证编码：</span><input placeholder="请输入凭证编码" type="text"
								class="w300 text"  name="voucherNo" value="${voucher.voucherNo }" readonly="readonly" />
						</div>
					</li>
					<li>
						<div class="input_box">
							<span>凭证到期日期：</span><input id="expireDate" placeholder="请选择到期日期" type="text"
								class="text w300" name="expireDate" date="true" value="${voucher.expireDate }" readonly="readonly"/>
						</div>
					</li>
					<li >
						<div class="input_box">
							<span>核心企业名称：</span>
							<input type="text" class="w300 text"  name="voucherNo" value="${voucher.attribute1 }" readonly="readonly" />
						</div>
					</li>
					<li >
						<div class="input_box">
							<span>凭证类型： </span>
							<div class="select_box">
								<select class="select w300" id="type" disabled="disabled" >
									<option value="">请选择</option>
									<option value="应收账款单" <c:if test="${voucher.type=='应收账款单'}">selected="selected"</c:if> >应收账款单</option>
									<option value="商票" <c:if test="${voucher.type=='商票'}">selected="selected"</c:if> >商票</option>
									<option value="银票" <c:if test="${voucher.type=='银票'}">selected="selected"</c:if> >银票</option>
								</select>
							</div>
						</div>
					</li>
					
					<li><div class="input_box">
							<span>凭证面额：</span><input placeholder="请选择凭证面额" type="text"
								class="text w300" name="amount"  value="${voucher.amount }"  readonly="readonly"/>
						</div></li>
					<li><div class="input_box">
							<span>凭证登记日期：</span><input id="registerDate" placeholder="请选择登记日期" type="text"
								class="text w300" name="registerDate" date="true" value="${voucher.registerDate }" readonly="readonly"/>
						</div></li>
					<li><div class="input_box">
							<span>凭证起始日期：</span><input placeholder="请选择起始日期" type="text"
								class="text w300" id="effectiveDate" name="effectiveDate" date="true" value="${voucher.effectiveDate }" readonly="readonly" />
						</div></li>
	
					<li class="clear"><div class="input_box">
							<span>备注说明：</span>
							<textarea class="text_tea w770 h100" id="remark"   readonly="readonly">${voucher.remark }</textarea>
						</div></li>
	
					<li>
						<div class="input_box">
							<span>凭证附件上传：</span>
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
			</div>
		</form>
	</div>
</body>
</html>