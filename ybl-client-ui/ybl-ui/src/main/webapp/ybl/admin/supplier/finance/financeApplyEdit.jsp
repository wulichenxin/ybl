<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.loanDetail"/></title><!-- 贷款详情 -->
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
	$(function() {
		//图片查看窗口
		view = function(url,name) {
			$.msgbox({
				height : 520,
				width : 800,
				content : url,
				type : 'iframe',
				title : name
			});
		}
		
	});
</script>

<script >
	//刷新页面-给弹出窗口使用
	function callBackRefresh(url){
		window.location.href = url;
	}
</script>

</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=5" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/> -> <spring:message code="sys.client.riskManage"/> -> <spring:message code="sys.client.loanAudit"/>-> <spring:message code="sys.client.loanDetail"/><!-- 贷款详情 --></div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i><spring:message code="sys.client.loanAudit"/><!-- 贷款审核 -->
				</h1>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.FinanceBody"/><!-- 融资主体 --></h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span>
								<input  type="text" class="w300 text_gary" value="${finaceBody.enterpriseName}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input  type="text"
									class="text_gary w300" value="${finaceBody.fixedPhone}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input 
									type="text" class="text_gary w300" value="${finaceBody.licenseNo}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonName"/><!-- 法人代表名称 -->：</span><input  type="text"
									class="text_gary w300" value="${finaceBody.legalName}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonIDCard"/><!-- 法人代表身份证号 -->：</span><input 
									type="text" class="text_gary w300" value="${finaceBody.legalCardId}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">  
								<span><spring:message code="sys.client.phone"/><!-- 联系电话号码 -->：</span><input  type="text"
									class="text_gary w300" value="${finaceBody.legalPhone}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">  
								<span><spring:message code="sys.client.BankofDeposit"/><!-- 开户银行 -->：</span><input  type="text"
									class="text_gary w300" value="${finaceBody.openBank}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bankAccount"/><!-- 开户银行账号 -->：</span><input  type="text"
									class="text_gary w300" value="${finaceBody.accountNo}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bankBranch"/><!-- 支行名称 -->：</span><input  type="text"
									class="text_gary w770" value="${finaceBody.branchName}" readonly="readonly"/>
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.factorBody"/><!-- 保理商主体 --></h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span>
								<input   type="text" class="w300 text_gary" value="${factorBody.enterpriseName}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input type="text"
									class="text_gary w300" value="${factorBody.fixedPhone}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input 
									type="text" class="text_gary w300" value="${factorBody.licenseNo}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonName"/><!-- 法人代表名称 -->：</span><input type="text"
									class="text_gary w300" value="${factorBody.legalName}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonIDCard"/><!-- 法人代表身份证号 -->：</span><input 
									type="text" class="text_gary w300" value="${factorBody.legalCardId}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">  
								<span><spring:message code="sys.client.phone"/><!-- 联系电话号码 -->：</span><input  type="text"
									class="text_gary w300" value="${factorBody.legalPhone}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">  
								<span><spring:message code="sys.client.BankofDeposit"/><!-- 开户银行 -->：</span><input type="text"
									class="text_gary w300" value="${factorBody.openBank}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bankAccount"/><!-- 开户银行账号 -->：</span><input type="text"
									class="text_gary w300" value="${factorBody.accountNo}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bankBranch"/><!-- 支行名称 -->：</span><input  type="text"
									class="text_gary w770" value="${factorBody.branchName}" readonly="readonly"/>
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.productDetail"/><!-- 产品详情 --></h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.productName"/><!-- 产品名称 -->：</span><input  type="text"
									class="w770 text_gary" value="${product.name_}" readonly="readonly"/>
							</div>
						</li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.factorType"/><!-- 保理类型 -->：</span><input  type="text"
									class="w200 text_gary" value="${product.type_}" readonly="readonly"/>
							</div>
							</li>
						<li class=" w472">
							<div class="input_box">
								<span><spring:message code="sys.client.repaymentType"/><!-- 还款方式 -->：</span>
									<input  type="text" class="w200 text_gary"  value="${product.repayment_type}" readonly="readonly"/>
							</div>
						</li>
						<%-- <li class="clear w472">
						     <div class="input_box">
								<span><spring:message code="sys.client.repaymentRule"/><!-- 还款日规则 -->：</span>
								<div>
									<input  type="text" class="text w50 mr10 ml10"  value="${product.repayment_date_rule}" readonly="readonly"/>
								   <spring:message code="sys.client.loanVoucherLimiteDay"/><!-- 贷款凭证最早到期日 -->
								</div>
								
							</div>
						</li> --%>

						<li class=" w472">
						   <div class="input_box">
								<span><spring:message code="sys.client.loanRate"/><!-- 贷款利率 -->：</span>
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 --><input type="text"
										class="text w50 mr10 ml10" value="${product.rate_}" readonly="readonly"/>%
								</div>
							</div>
						</li>
						<li class="clear w472"><div class="input_box">
								<span><spring:message code="sys.client.overdueInterest"/><!-- 逾期利率 -->：</span>
								<div>
									<spring:message code="sys.client.dailyInterest"/><!-- 日利率 --><input  type="text"  
										class="text w50 mr10 ml10" value="${product.overdue_rate}" readonly="readonly"/>%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.managementPercent"/><!-- 管理费百分比 -->：</span>
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 --><input  type="text"
										class="text w50 mr10 ml10" value="${product.manage_rate}" readonly="readonly"/>%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.defaultRate"/><!-- 违约利率 -->：</span>
								<div>
									<spring:message code="sys.client.dailyInterest"/><!-- 日利率 --><input  type="text"
										class="text w50 mr10 ml10" value="${product.penalty_rate}" readonly="readonly"/>%
								</div>
							</div></li>
						<li class="w472"><div class="input_box"> 
								<span><spring:message code="sys.client.financingProportion"/><!-- 融资比例 -->：</span><input  type="text"
									class="text w50 mr10" value="${product.finance_ratio}" readonly="readonly"/>%
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.financeApply"/><!-- 融资申请 --></h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.financeNumber"/><!-- 融资编号 -->：</span><input 
									type="text" class="w300 text_gary" value="${financeApply.number_}" readonly="readonly"/>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.financeApplyTime"/><!-- 融资申请时间 -->：</span><input  type="text"
									class="w300 text_gary" value='<fmt:formatDate value="${data.createdTime}" pattern="yyyy-MM-dd" />' readonly="readonly"/>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.financeApplyMoney"/><!-- 申请贷款金额 -->：</span><input  type="text"
									class="text w100 mr10" value="${financeApply.apply_amount}" readonly="readonly"/><spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.maxLoanMoney"/><!-- 最大可贷金额 -->：</span><input  type="text"
									class="text w100 mr10" value="${maxLoanMoney}" readonly="readonly"/><spring:message code="sys.client.tenThousand"/><!-- 万元 -->
							</div></li>
						<li class="w472">
							<div class="input_box">
								<span><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 -->：</span>
									<div>
										<input  type="text" class="text w50 mr10 ml10" value="${financeApply.loan_period}" readonly="readonly"/>
											<c:if test="${financeApply.period_type == 'year'}">
												<spring:message code="sys.client.year"/>
											</c:if>
											<c:if test="${financeApply.period_type == 'month'}">
												<spring:message code="sys.client.month"/>
											</c:if>
											<c:if test="${financeApply.period_type == 'day'}">
												<spring:message code="sys.client.day"/>
											</c:if>
									</div>
							</div>
						</li>
						<li class="clear" style="display:none;"><div class="input_box" >
								<span><spring:message code="sys.client.predictDisbursementTime"/><!-- 预计放款审批时间 -->：</span><input  type="text"
									class="w300 text" value="" readonly="readonly"/> <spring:message code="sys.client.day"/>
							</div>
						</li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.repaymentTime"/><!-- 还款日期 -->：</span>
								<input  type="text" class="w300 text_gary" value="${financeApply.repayment_date}" readonly="readonly"/>
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1><spring:message code="sys.client.loanMaterial"/><!-- 贷款材料 --></h1>  
				<!--按钮top-->
				<div style="display:none;" class="table_top mt20 table_border">
					<div class="table_nav">
						<ul>
							<li><a class="but_ico7"><spring:message code="sys.admin.add"/><!-- 添加 --></a></li>
							<li><a class="but_ico1"><spring:message code="sys.admin.delete"/><!-- 删除 --></a></li>
						</ul>
					</div>
				</div>
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.admin.serial.number"/> <!-- 序号 --></th>
							<th><spring:message code="sys.client.materialName"/><!-- 材料名称 --></th>
							<th><spring:message code="sys.client.remark"/><!-- 备注 --></th>
							<th><spring:message code="sys.client.uploadTime"/><!-- 上传时间 --></th>
							<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
						</tr>
						<tbody>
							<c:forEach items="${loanMaterialList}" var="bean" varStatus="state">     
			                        <tr>
			                            <td>${state.count}</td>
						                <td>${bean.name_}</td>
						                <td>${bean.remark_}</td>
						                <td><fmt:formatDate value="${bean.createdTime}" pattern="yyyy-MM-dd" /></td>
						                <td>
										   <div class="qy">
												<a href="javascript:view('${bean.url_}','${bean.name_}');"><spring:message code="sys.client.preview"/><!-- 预览 --></a>
											</div>
										</td>
									</div>
						             </tr>
		                     </c:forEach>  
						</tbody>
					</table>

				</div>
			</div>

			<div class="rzsq_box">
				<h1><spring:message code="sys.client.financeVoucher"/><!-- 融资凭证 --></h1>
				<!--按钮top-->
				<div style="display:none;" class="table_top mt20 table_border">
					<div class="table_nav">
						<ul>
							<li><a class="but_ico7"><spring:message code="sys.admin.add"/><!-- 添加 --></a></li>
							<li><a class="but_ico1"><spring:message code="sys.admin.delete"/><!-- 删除 --></a></li>
						</ul>
					</div>
				</div>
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.admin.serial.number"/><!-- 序号 --></th>
							<th><spring:message code="sys.client.financeNumber"/><!-- 凭证编码 --></th>
							<th><spring:message code="sys.client.coreCompanyName"/><!-- 核心企业名称 --></th>
							<th><spring:message code="sys.client.voucherUnit"/><!-- 凭证面额（万元） --></th>
							<th><spring:message code="sys.client.voucherType"/><!-- 凭证类型 --></th>
							<th><spring:message code="sys.client.voucherOverdueTime"/><!-- 凭证到期日 --></th>
							<th><spring:message code="sys.client.uploadTime"/><!-- 上传时间 --></th>
							<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
						</tr>
						<tbody>
							<c:forEach items="${voucherList}" var="bean" varStatus="state">     
			                        <tr>
			                            <td>${state.count}</td>
						                <td>${bean.voucherNo}</td>
						                <td>${bean.enterpriseName}</td>
						                <td>${bean.amount}</td>
						                <td>${bean.type}</td>
						                <td><fmt:formatDate value="${bean.expireDate}" pattern="yyyy-MM-dd" /></td>
						                <td><fmt:formatDate value="${bean.createdTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						                <td>
										   <div class="qy">
												<a href="javascript:view('${bean.url}','${bean.type}');"><spring:message code="sys.client.preview"/><!-- 预览 --></a>
											</div>
										</td>
									</div>
						             </tr>
		                     </c:forEach>  
						</tbody>

					</table>

				</div>
			</div>
			<div class="rzsq_box">
				<h1>合同信息</h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span>选择文件：</span><input type="file" class=" f16"
									style="padding: 10px 10px 0px 10px;" />
							</div></li>

					</ul>
				</div>

			</div>
			
			<c:if test="${not empty auditType && auditType < 4 }">
				<div class="but_center_100">
						<a href="javascript:audit('${auditType}','${ids}');"><spring:message code="sys.client.auditOperator"/><!-- 预览 --></a>
				</div>
			</c:if>
			
		</div>

	</div>

	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>