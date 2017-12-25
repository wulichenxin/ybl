<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.client.role.auth" /></title>
<!-- 商户认证 -->
<jsp:include page="../../common/link.jsp" />
<!-- 表单验证 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/jquery-form.js"></script>
<!-- 日期控件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<!-- 省市区js -->
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/common/address.js"></script>
<!-- 角色认证js -->
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/accountCenter/roleAuth.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=0" />
	<!--top end -->
	<div class="path">
		<!-- 当前位置->账户中心 -> 角色认证 -->
		<spring:message code="sys.client.location" />
		->
		<spring:message code="sys.client.account.center" />
		->
		<spring:message code="sys.client.role.auth" />
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
						<i class="v_tittle_4"></i>
						<c:if test="${roleType=='factor'}">
							<spring:message code="sys.client.factor.auth.message" />
							<!-- 保理商认证信息 -->
						</c:if>
						<c:if test="${roleType=='enterprise'}">
							<spring:message code="sys.client.core.enterprise.auth.message" />
							<!-- 核心企业认证信息 -->
						</c:if>
						<c:if test="${roleType=='supplier'}">
							<spring:message code="sys.client.supplier.auth.message" />
							<!-- 供应商认证信息 -->
						</c:if>
					</h1>
				</div>
				<div class="text_box content">
					<ul>
						<form action="/enterpriseController/addOrUpdateEnterprise"
							id="roleAuthForm" method="post">
							<input type='hidden' id='roleType' name='roleType'
								value='${roleType}' />
							<input type='hidden' id='id' name='id'
								value='${enterprise.id}' />
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.companyName" />：</span>
									<!-- 企业名称 -->
									<input type="text" class="text w600 validate[required,maxSize[50],custom[enterpriseName]]" name='enterpriseName'
										value='${enterprise.enterpriseName }' /> <i>*</i>
								</div>
							</li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.companyTelephone" />：</span>
									<!-- 企业固定电话 -->
									<input type="text" class="text w600 validate[required,maxSize[20],custom[telePhone]]" name='fixedPhone'
										value='${enterprise.fixedPhone }' /> <i>*</i>
								</div>
							</li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.licenseNumber" />：</span>
									<!-- 营业执照注册号 -->
									<input type="text" class="text w300 fl validate[required,custom[business_registration_code]]" name='licenseNo'
										value='${enterprise.licenseNo }' />
									<div class="checkbox">
										<input type="checkbox" name='isThreeInOne'
											value='${enterprise.isThreeInOne==""?1:enterprise.isThreeInOne}'
											id='isThreeInOne' />
										<spring:message code="sys.client.isThreeOne" />
										<!-- 是否三证合一企业 -->
									</div>
									<i>*</i>
								</div>
							</li>
							<li id='org_code_li'>
								<div class="input_box">
									<span><spring:message code="sys.client.orgCodeNo" />：</span>
									<!-- 机构代码证号 -->
									<input type="text" class="text w600 validate[required,custom[orgCode]]" name='orgCodeNo'
										value='${enterprise.orgCodeNo }' /> <i>*</i>
								</div>
							</li>
							<li id='tax_li'>
								<div class="input_box">
									<span><spring:message code="sys.client.taxNo" />：</span>
									<!-- 税务登记号 -->
									<input type="text" class="text w600 validate[required,custom[taxCode]]" name='taxNo'
										value='${enterprise.taxNo }' />
									<i>*</i>
								</div>
							</li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.financeNo" />：</span>
									<!-- 财务登记证 -->
									<input type="text" class="text w600 validate[required,maxSize[50]]" name='financeNo'
										value='${enterprise.financeNo }' /> <i>*</i>
								</div>
							</li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.register.capital" />(<spring:message code="sys.client.element" />)：</span>
									<!-- 注册资本(元)-->
									<input type="text" class="text w600 validate[required,custom[numberLimit242]]" name='registerAmount'
									 value='${enterprise.registerAmount }' id='registerAmount'/><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.paid.capital" />(<spring:message code="sys.client.element" />)：</span>
									<!-- 实缴资本(元)-->
									<input type="text" class="text w600 validate[required,custom[numberLimit242]]" name='factAmount'
										value='${enterprise.factAmount }' id='factAmount'/><i>*</i>
								</div></li>
							<li>
								<div class="input_box">
									<span><spring:message
											code="sys.client.register.province.area" />：</span>
									<!-- 注册省份地区 -->
									<div class="select_box">
										<select class="select w200 validate[required]" name='provinceId'
											onchange="selectProvince(this,'cityId','','')"
											id="provinceId"></select>
											<input type='hidden' value='${enterprise.provinceId }' id='provinceId_code'/>
									</div>
									<div class="select_box">
										<select class="select w200 validate[required]" name='cityId'
											onchange="selectCity(this,'areaId','')" id="cityId"></select>
											<input type='hidden' value='${enterprise.cityId }' id='cityId_code'/>
									</div>
									<div class="select_box mr0">
										<select class="select w200 validate[required]" name='areaId' id="areaId"></select>
											<input type='hidden' value='${enterprise.areaId }' id='areaId_code'/>
									</div>
									<i>*</i>
								</div>
							</li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.register.address" />：</span>
									<!-- 注册地址 -->
									<input type="text" class="text w600 validate[required,maxSize[255]]" name='address'
										value='${enterprise.address}' /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bussiness.scope" />：</span>
									<!-- 经营范围 -->
									<input type="text" class="text w600 validate[required,maxSize[500]]" name='bussinessScope'
										value='${enterprise.bussinessScope }' /><i>*</i>
								</div></li>

							<li><div class="input_box">
									<span><spring:message
											code="sys.client.effective.operate.period" />：</span>
									<!-- 有效经营期限-->
									<input type="text" class="text w200 fl validate[required]" id="_begin_date"
										name='beginDate' /> <input type='hidden'
										id='bDate' value='${enterprise.beginDate}' /> <b>-</b> <input
										type="text" class="text w200 fl  validate[custom[future_date]]" name='endDate' id="_end_date"
										date='true' /> <input type='hidden' id='eDate'
										value='${enterprise.endDate}' />
									<div class="checkbox">
										<input type="checkbox" id='ifEffective' />
										<spring:message code="sys.client.permanent.effective" />
										<!-- 永久有效 -->
									</div>
									<i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.legalPersonName" />：</span>
									<!-- 法定代表人 -->
									<input type="text" class="text w600 validate[required,maxSize[50]]" name='legalName'
										value='${enterprise.legalName}' /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message
											code="sys.client.legalPersonIDCard" />：</span>
									<!-- 法定代表人身份证号 -->
									<input type="text" class="text w600 validate[required,maxSize[20],custom[cardid]]" 
										value='${enterprise.legalCardId }' name='legalCardId'/><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.phone" />：</span>
									<!-- 联系电话号码 -->
									<input type="text" class="text w600 validate[required,custom[mobilePhone]]" name='legalPhone'
										value='${enterprise.legalPhone}' /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.open.bank.name" />：</span>
									<!-- 开户银行 -->
									<input type="text" class="text w600 validate[required,maxSize[50]]" name='openBank'
										value='${enterprise.openBank }' /><i>*</i>
								</div></li>
							<li>
								<div class="input_box">
									<span><spring:message
											code="sys.client.open.province.area" />：</span>
									<!-- 开户省份地区 -->
									<div class="select_box">
										<select class="select w200 validate[required]" name='accountProvinceId'
											onchange="selectProvince(this,'accountCityId','','')"
											id="accountProvinceId"></select>
											<input type='hidden' value='${enterprise.accountProvinceId }' id='accountProvinceId_code'/>
									</div>
									<div class="select_box">
										<select class="select w200 validate[required]" name='accountCityId'
											onchange="selectCity(this,'accountAreaId','')" id="accountCityId"></select>
											<input type='hidden' value='${enterprise.accountCityId }' id='accountCityId_code'/>
									</div>
									<div class="select_box mr0">
										<select class="select w200 validate[required]" name='accountAreaId' id="accountAreaId"></select>
											<input type='hidden' value='${enterprise.accountAreaId }' id='accountAreaId_code'/>
									</div>
									<i>*</i>
								</div>
							</li>
							<li><div class="input_box">
									<span><spring:message
											code="sys.client.open.bank.account" />：</span>
									<!-- 开户银行账号 -->
									<input type="text" class="text w600 validate[required,maxSize[50],custom[onlyNumberSp]]" name='accountNo'
										value='${enterprise.accountNo }' /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bankBranch" />：</span>
									<!-- 支行名称 -->
									<input type="text" class="text w600 validate[required,maxSize[50]]" name='branchName'
										value='${enterprise.branchName }' /><i>*</i>
								</div></li>
							<div id='cardFullFacePhoto_div'></div>
							<div id='cardOppositePhoto_div'></div>
							<div id='orgCodePhoto_div'></div>
							<div id='licensePhoto_div'></div>
							<div id='taxPhoto_div'></div>
						</form>
						<li>
							<div class="input_box">
								<span><spring:message
										code="sys.client.certificate.upload" />：</span>
								<!-- 证照上传 -->
								<div class="vip_phone">
									<dl>
										<dd>
											<a href="javascript:void(0);" id="cardFullFacePhoto"> <c:forEach
													var="data" items="${attachmentList }">
													<c:if test="${data.type=='userCertificate_cardFullFacePhoto'}">
														<img src="${data.url}" photoId='${data.id}'>
													</c:if>
												</c:forEach>
											</a>
											<p>
												<spring:message code="sys.client.hand.front.photo" />
												<!-- 手持正面照 -->
											</p>
										</dd>
										<dd>
											<a href="javascript:void(0);" id="cardOppositePhoto"> <c:forEach
													var="data" items="${attachmentList }">
													<c:if test="${data.type=='userCertificate_cardOppositePhoto'}">
														<img src="${data.url}" photoId='${data.id}'>
													</c:if>
												</c:forEach>
											</a>
											<p>
												<spring:message code="sys.client.hand.opposite.photo" />
												<!-- 手持反面照 -->
											</p>
										</dd>
										<dd>
											<a href="javascript:void(0);" id="orgCodePhoto"> <c:forEach
													var="data" items="${attachmentList }">
													<c:if test="${data.type=='userCertificate_orgCodePhoto'}">
														<img src="${data.url}" photoId='${data.id}'>
													</c:if>
												</c:forEach>
											</a>
											<p>
												<spring:message code="sys.client.orgCode.certificate" />
												<!-- 组织机构代码证 -->
											</p>
										</dd>
										<dd>
											<a href="javascript:void(0);" id="licensePhoto"> <c:forEach
													var="data" items="${attachmentList }">
													<c:if test="${data.type=='userCertificate_licensePhoto'}">
														<img src="${data.url}" photoId='${data.id}'>
													</c:if>
												</c:forEach>
											</a>
											<p>
												<spring:message code="sys.client.business.license" />
												<!-- 营业执照 -->
											</p>
										</dd>
										<dd>
											<a href="javascript:void(0);" id="taxPhoto"> <c:forEach
													var="data" items="${attachmentList }">
													<c:if test="${data.type=='userCertificate_taxPhoto'}">
														<img src="${data.url}" photoId='${data.id}'>
													</c:if>
												</c:forEach>
											</a>
											<p>
												<spring:message code="sys.client.tax.certificate" />
												<!-- 税务登记证 -->
											</p>
										</dd>
									</dl>
								</div>
							</div>
						</li>
					</ul>
					<div class="but_center">
						<a id='ybl_admin_account_center_role_auth_btn' class='lan' >
							<spring:message code="sys.client.submit"/></a>
						<!--提交 -->
						<a id="submitingBtn" style="display: none;"><spring:message code="sys.client.submiting"/>...</a><!-- 提交中 -->
					</div>
				</div>
			</div>
		</div>
		<!--conover-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->

	<!-- 图片上传 部分 start -->
	<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
	<form style="display: none;" id="common_upload_form"
		enctype="multipart/form-data" method="post" target="common_iframe">
		<input id="common_upload_btn" type="file" name="file"
			style="display: none;" />
	</form>
	<!-- 图片上传 部分 end -->
</body>
</html>
