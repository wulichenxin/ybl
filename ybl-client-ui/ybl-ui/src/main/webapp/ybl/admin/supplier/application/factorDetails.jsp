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
<title>保理商详情</title>
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
$(function () {   
	//tab切换
    $('.tabnav dl dd').click(function () {
        var index = $(this).index();
        $('.content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
        $('.tabnav dl dd').eq(index).addClass('now').siblings().removeClass('now');
    });
});
var index;
var timer;
// 添加
function add_start() {
	$('#add').show();
	$('t_window').css({overflow:'hidden'});
}
function add_close(){
	clearInterval(timer);
	$('#add').hide();
	$('body').css({overflow:''});
}
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->
	<div class="path"><spring:message code='sys.client.location'></spring:message>-><!-- 当前位置 -->
					  <spring:message code='sys.client.financeApply'></spring:message>-><!-- 融资申请 -->	
					  <spring:message code='sys.client.facte.service'></spring:message>-><!-- 保理服务 -->
					<spring:message code='sys.client.factor.details'></spring:message></div> <!-- 保理商详情 -->
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
            	<div class="v_tit_tab">
            		<dl>
            		<c:if test="${memberSign.status_ == 'signed'}">
            			<dd class="now"><a><spring:message code='sys.client.financing.products'></spring:message></a></dd><!-- 融资产品 -->
            		</c:if>
            		<dd class="${memberSign.status_ != 'signed'?'now':''}"><a><spring:message code='sys.client.factoring.profiles'></spring:message> </a></dd><!-- 保理商简介 -->
            		
            		</dl>
            	</div>
            	<div>
            	<div class=" content ${memberSign.status_ != 'signed'?'none1':''}">
						<div class="cz_pro">
							<ul>
							<c:forEach items="${productVos}" var="product">
								<li><%-- ${app.staticResourceUrl}/ybl/resources/images/login_bg_01.jpg" --%>
									<div class="cz_pic"><img src="${product.url_ }" /></div>
									<div class="cz_jj">
										<h1><a href="/productManageController/lookQueryByProductId?id=${product.id }">${product.name_ }</a></h1>
										<p><span><spring:message code='sys.client.productPresentation'></spring:message> :</span>${product.desc_ }</p><!-- 产品介绍 -->
									</div>
									<div class="cz_xx">
										<dl>
											<dd><spring:message code='sys.client.yearRate'></spring:message>:<span><fmt:formatNumber value="${product.rate_ }" pattern="0.00"  />%</span></dd> <!-- 年化利率 -->
											<dd><spring:message code='sys.client.loanPeriod'></spring:message>: <!-- 贷款期限 --> 
												<span>${product.term_ }
													<c:if test="${product.loan_type=='day' }"><spring:message code='sys.client.day'></spring:message></c:if><!-- 日 -->
													<c:if test="${product.loan_type=='month' }"><spring:message code='sys.client.month'></spring:message></c:if> <!-- 月 -->
													<c:if test="${product.loan_type=='year' }"><spring:message code='sys.client.year'></spring:message></c:if> <!--  年 -->
												</span>
											</dd>
											<dd><spring:message code='sys.client.financingProportion'></spring:message> : <span><fmt:formatNumber value="${product.finance_ratio }" pattern="0.00"  />%</span></dd><!-- 融资比例 -->
											<dd><spring:message code='sys.client.factorType'></spring:message> :<!-- 保理类型  -->
												<c:if test="${product.type_ == 'online_factor' }"><spring:message code='sys.client.online.clear.facte'></spring:message></c:if><!-- 明保理 -->
												<%-- <c:if test="${product.type_ == 'offline_factor' }">线下名保理</c:if> --%>
												<c:if test="${product.type_ == 'dark_factor' }"><spring:message code='sys.client.dark.facte'></spring:message></c:if><!-- 暗保理 -->
											</dd>
										</dl>
									</div>
									<div class="cz_li_but">
										<a href="/loanApplicationController/financeApplication?id=${product.enterprise_id}&productId=${product.id}"><spring:message code='sys.client.financeApply'></spring:message> </a>
									</div><!-- 融资申请 -->
								</li>
							</c:forEach>
							</ul>
						</div>
					</div>
					<div class="text_box content " style="${memberSign.status_ == 'signed'?'display:none':''}">
						<div class="blsjj">
							<h1><spring:message code='sys.client.investBidManage.companyProfile'></spring:message></h1><!-- 公司简介 -->
							${enter.companyProfile}
						</div>
						<div class="blsjj">
						<h1><spring:message code='sys.client.company.base.message'></spring:message></h1><!-- 基本信息 -->
						<ul>
							<li><div class="input_box"><span><spring:message code='sys.client.companyName'></spring:message>：</span><input type="text" class="text_gary w600" value="${enter.enterpriseName }" readonly="readonly" /></div></li><!-- 企业名称 -->
							<li><div class="input_box"><span><spring:message code='sys.client.companyTelephone'></spring:message>：</span><input type="text" class="text_gary w600" value="${enter.fixedPhone}" readonly="readonly" /></div></li><!-- 企业固定电话 -->
							<li><div class="input_box"><span><spring:message code='sys.client.legal.representative'></spring:message> ：</span><input  type="text" class="text_gary w600" value="${enter.legalName}" readonly="readonly" /></div></li><!-- 法定代表人 -->
							<li><div class="input_box"><span><spring:message code='sys.client.licenseNumber'></spring:message>：</span><input type="text" class="text_gary w300 fl" value="${enter.licenseNo }" readonly="readonly" /><!-- 营业执照注册号 -->
							<div class="checkbox">
								<input type="checkbox" disabled="disabled" <c:if test="${enter.isThreeInOne==1}"> checked=checked </c:if>  /></div><i><spring:message code='sys.client.is.Three.one'></spring:message></i></div></li><!-- 我是三证合一企业 -->
							<li><div class="input_box"><span><spring:message code='sys.client.orgCodeNo'></spring:message>：</span><input  type="text" class="text_gary w600" value="${enter.orgCodeNo }" readonly="readonly" /></div></li><!-- 机构代码证号 -->
							<li><div class="input_box"><span><spring:message code='sys.client.taxNo'></spring:message>：</span><input type="text" class="text_gary w600" value="${enter.taxNo }" readonly="readonly" /></div></li><!-- 税务登记号 -->
							<li><div class="input_box"><span><spring:message code='sys.client.financeNo'></spring:message>：</span><input type="text" class="text_gary w600" value="${enter.financeNo }"  readonly="readonly" /></div></li><!-- 财务登记证 -->
							<li>
								<div class="input_box">
									<span><spring:message code='sys.client.register.province.area'></spring:message></span><!-- 注册省份地区 -->
									<input  type="text" class="text_gary w160" value="${provinceName}" readonly="readonly" />
									<input  type="text" class="text_gary w160" value="${cityName}"  readonly="readonly"/>
									<input  type="text" class="text_gary w160" value="${areaName}" readonly="readonly" />
								</div></li>
							
							<li><div class="input_box"><span><spring:message code='sys.client.register.address'></spring:message>：</span><input  type="text" class="text_gary w600" value="${enter.address }" readonly="readonly" /></div></li><!-- 注册地址 -->
							<li><div class="input_box"><span><spring:message code='sys.client.bussiness.scope'></spring:message>：</span><input  type="text" class="text_gary w600" value="${enter.bussinessScope }" readonly="readonly" /></div></li><!-- 经营范围 -->
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