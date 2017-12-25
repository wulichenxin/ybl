<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.core.enterprise"/></title><!-- 核心企业 -->
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=6" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/> -> <spring:message code="sys.client.investBidManage.myInvest"/> -> <spring:message code="sys.client.core.enterprise"/></div>
	<div class="p_detail_con body_cbox">
		<div class="tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a><spring:message code="sys.client.investBidManage.companyProfile"/><!-- 公司简介 --></a>
					</dd>
					
				</dl>
			</div>
			<div>
				<div class="text_box content">
					<div class="blsjj">
						<h1><spring:message code="sys.client.investBidManage.companyProfile"/><!-- 公司简介 --></h1>
						${enterprise.company_profile }
					</div>
					<div class="blsjj">
						<h1><spring:message code="sys.client.company.base.message"/><!-- 基本信息 --></h1>
						<ul>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span><input value="${enterprise.enterprise_name }"  type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input value="${enterprise.fixed_phone }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.legalPersonName"/><!-- 法定代表人 -->：</span><input value="${enterprise.legal_name }" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input value="${enterprise.license_no }"
										type="text" class="text_gary w300 fl" />
									<!-- <div class="checkbox">
										<input type="checkbox" />我是三证合一企业
									</div> -->
									<i></i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.orgCodeNo"/><!-- 机构代码证号 -->：</span><input value="${enterprise.org_code_no }" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.taxNo"/><!-- 税务登记号 -->：</span><input value="${enterprise.tax_no }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.financeNo"/><!-- 财务登记证 -->：</span><input value="${enterprise.finance_no }"
										type="text" class="text_gary w600" />
								</div></li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.register.province.area"/><!-- 注册省份地区 -->：</span> 
									<input value="${provinceName }" type="text" class="text_gary w160" /> 
									<input value="${cityName }" type="text" class="text_gary w160" /> 
									<input value="${areaName }" type="text" class="text_gary w160" />
								</div>
							</li>

							<li><div class="input_box">
									<span><spring:message code="sys.client.register.address"/><!-- 注册地址 -->：</span><input value="${enterprise.address_ }"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bussiness.scope"/><!-- 经营范围 -->：</span><input value="${enterprise.bussiness_scope }" type="text"
										class="text_gary w600" />
								</div></li>
						</ul>
					</div>
				</div>
			</div>
		</div> 
    </div>
<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>