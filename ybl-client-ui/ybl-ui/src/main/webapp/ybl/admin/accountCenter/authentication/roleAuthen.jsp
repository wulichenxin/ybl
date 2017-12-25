<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.role.auth"/></title><!-- 角色认证 -->
<jsp:include page="../../common/link.jsp" />
<!-- 百度编辑器相关的js -->
<script type="text/javascript" charset="utf-8"
	src="${app.staticResourceUrl}/ybl/resources/ueditor/editor_api.js"></script>	
<!-- 角色认证js -->
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/accountCenter/authSuccess.js"></script>
	<!-- 省市区js -->
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/common/address.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=0" />
	<!--top end -->
	<div class="path"><!-- 当前位置->账户中心 -> 角色认证 -->
		<spring:message code="sys.client.location"/>->
		<spring:message code="sys.client.account.center"/>-> 
		<spring:message code="sys.client.role.auth"/>
	</div>
	<div class="vip_conbody">
		<!--left menu jsp-->
		<jsp:include page="../../common/left.jsp?step=1" />
		<!--left menu jsp-->
		<!--con-->
		<div class="vip_concon">
			<div class="vip_r_con vborder">
				<div class="v_tittle">
					<h1>
						<i class="v_tittle_2"></i>
						<spring:message code="sys.client.role.auth"/><!-- 角色认证 -->
					</h1>
				</div>
				<div class="v_r_box">
					<input type='hidden' id='status' value='${enterprise.status}' /> <input
						type='hidden' id='roleType' value='${roleType}' />
					<div class="jsrz_box">
						<div class="jsrz_li ${roleType=='member'?'':(roleType=='supplier'?'now':'op3 jsrz_gary')}">
							<a  id='supplier_a'>
								<div class="rz_box js_rzico1"></div>
								<p id='supplier_p'><!-- 商户认证 -->
									<spring:message code="sys.client.supplier"/>
									<spring:message code="sys.client.auth"/>
								</p>
							</a>
						</div>
						<div class="jsrz_li ${roleType=='member'?'':(roleType=='factor'?'now':'op3 jsrz_gary')}">
							<a  id='factor_a'>
								<div class="rz_box js_rzico2"></div>
								<p id='factor_p'><!-- 保理商认证 -->
									<spring:message code="sys.client.factor"/>
									<spring:message code="sys.client.auth"/>
								</p>
						</div>
						<div class="jsrz_li ${roleType=='member'?'':(roleType=='enterprise'?'now':'op3 jsrz_gary')}">
							<a id='enterprise_a'>
								<div class="rz_box js_rzico3"></div>
								<p id='enterprise_p'><!--核心企业认证 -->
									<spring:message code="sys.client.core.enterprise"/>
									<spring:message code="sys.client.auth"/>
								</p>
							</a>
						</div>
					</div>
				</div>

				<div class="tabnav" style='display: none;'>
					<div class="v_tit_tab">
						<dl>
							<dd class="now">
								<a><spring:message code="sys.client.company.base.message"/></a><!-- 公司基本信息 -->
							</dd>
							<dd>
								<a><spring:message code="sys.client.company.intrduction"/></a><!-- 公司介绍 -->
							</dd>
						</dl>
					</div>
					<div>
						<div class="text_box content">
							<ul>
								<li><div class="input_box">
										<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span> 
										<input type="text" class="text_gary w600"
											value="${enterprise.enterpriseName }" disabled="disabled" />
									</div></li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span>
										<input type="text" class="text_gary w600"
											value="${enterprise.fixedPhone}" disabled="disabled" />
									</div></li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.legalPersonName"/><!-- 法定代表人 -->：</span>
										<input type="text" class="text_gary w600"
											value="${enterprise.legalName}" disabled="disabled" />
									</div></li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span>
										<input type="text"
											class="text_gary w300 fl" value="${enterprise.licenseNo}"
											disabled="disabled" />
										<div class="checkbox">
											<input type="checkbox"
											value='${enterprise.isThreeInOne}' id='isThreeInOne'
												disabled="disabled" />
												<spring:message code="sys.client.isThreeOne"/><!-- 是否三证合一企业 -->
										</div>
										<i></i>
									</div></li>
								<li id='org_code_li'><div class="input_box">
										<span><spring:message code="sys.client.orgCodeNo"/>：</span><!-- 机构代码证号 -->
										<input type="text" class="text_gary w600"
											value="${enterprise.orgCodeNo}" disabled="disabled" />
									</div></li>
								<li id='tax_li'><div class="input_box">
										<span><spring:message code="sys.client.taxNo"/>：</span><!-- 税务登记号 -->
										<input type="text" class="text_gary w600"
											value="${enterprise.taxNo}" disabled="disabled" />
									</div></li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.financeNo"/>：</span><!-- 财务登记证 -->
										<input type="text" class="text_gary w600"
											value="${enterprise.financeNo}" disabled="disabled" />
									</div></li>
								<li>
									<div class="input_box">
										<span><spring:message code="sys.client.register.province.area"/>：</span> <!-- 注册省份地区 -->
										 <input type="text" class="text_gary w160" disabled="disabled"
											value="${enterprise.provinceId}" id='provinceId'/> <input
											type="text" class="text_gary w160" disabled="disabled"
											value="${enterprise.cityId}" id='cityId'/> <input
											type="text" class="text_gary w160" disabled="disabled"
											value="${enterprise.areaId}" id='areaId'/> 
									</div>
								</li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.register.address"/>：</span><!-- 注册地址 -->
										<input type="text" class="text_gary w600"
											value="${enterprise.address}" disabled="disabled" id='address'/>
									</div></li>
								<li><div class="input_box">
										<span><spring:message code="sys.client.bussiness.scope"/>：</span><!-- 经营范围 -->
										<input type="text" class="text_gary w600"
											value="${enterprise.bussinessScope}" disabled="disabled" />
									</div></li>
							</ul>
						</div>
						<div class="text_box content" style="display: none;">
							<input type='hidden' name='id' id='enterpriseId'
								value="${enterprise.id}" /> <input type='hidden' name='id'
								id='roleType' value="${type}" /> <input type='hidden'
								name='id' id='companyProfile'
								value='${enterprise.companyProfile}' />
							<ul>
								<li><div class="input_box">
										<script id="editor" type="text/plain"
											style="width:900px;height:600px;"></script>
									</div></li>
							</ul>
							<div class="but_center">
								<a id='ybl_admin_account_center_company_profile_btn'><spring:message code="sys.client.submit"/></a>
									<!--提交 -->
								<a id="submitingBtn" style="display: none;"><spring:message code="sys.client.submiting"/>...</a><!-- 提交中 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--conover-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>