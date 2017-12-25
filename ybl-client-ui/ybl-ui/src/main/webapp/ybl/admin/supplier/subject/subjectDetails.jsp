<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.subject.detail" /></title>
<!-- 标的详情 -->
<jsp:include page="../../common/link.jsp" />
<!-- 日期控件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/js/subject/editSubject.js"></script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">
		<!-- 当前位置->标的管理 -> 普通标管理 -> 标的详情 -->
		<spring:message code="sys.client.location" />
		->
		<spring:message code="sys.client.subject.manage" />
		->
		<spring:message code="sys.client.common.subject.manage" />
		->
		<spring:message code="sys.client.subject.detail" />
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i>
					<spring:message code="sys.client.subject.detail" />
					<!-- 标的详情 -->
				</h1>
			</div>
			<div class="rzsq_box">
				<h1>
					<spring:message code="sys.client.FinanceBody" />
				</h1>
				<!-- 融资主体 -->
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.loan.company.name" />：</span>
								<!-- 贷款公司名称 -->
								<input type="text" class="w300 text_gary"
									value='${enterprise.enterpriseName}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.licenseNumber" />：</span>
								<!-- 营业执照号码 -->
								<input type="text" class="text_gary w300"
									value='${enterprise.licenseNo}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonName" />：</span>
								<!-- 法人代表名称 -->
								<input type="text" class="text_gary w300"
									value='${enterprise.legalName}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.legalPersonIDCard" />：</span>
								<!-- 法人身份证号码 -->
								<input type="text" class="text_gary w300"
									value='${enterprise.legalCardId}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.open.bank.name" />：</span>
								<!-- 开户银行 -->
								<input type="text" class="text_gary text w300"
									value='${enterprise.openBank}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.open.bank.account" />：</span>
								<!-- 开户银行账号 -->
								<input type="text" class="text_gary text w300"
									value='${enterprise.accountNo}' disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bankBranch" />：</span>
								<!-- 支行名称 -->
								<input type="text" class="text_gary text w770"
									value='${enterprise.branchName}' disabled='disabled' />
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1>
					<spring:message code="sys.client.subject.apply" />
				</h1>
				<!-- 标的申请 -->
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span><spring:message code="sys.client.financeNumber" />：</span>
								<!-- 融资编号 -->
								<input type="text" class="text w300" value="${subject.number}"
									disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.projectName" />：</span>
								<!-- 项目名称 -->
								<input type="text" class="text w300" value="${subject.name}"
									disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.loanPeriod" />：</span>
								<!-- 贷款期限  -->
								<input type="text" class="text w300"
									value="${subject.loanPeriod}" disabled='disabled' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.period.type" />：</span>
								<!-- 期限类型 -->
								<div class="select_box">
									<select class="select w300" disabled='disabled'>
										<option value='day'
											${subject.periodType=='day'?"selected":"" }>按天</option>
										<option value='month'
											${subject.periodType=='month'?"selected":"" }>按月</option>
										<option value='year'
											${subject.periodType=='year'?"selected":"" }>按年</option>
									</select>
								</div>
							</div></li>

						<li class="clear w472"><div class="input_box">
								<span><spring:message code="sys.client.repaymentType" />：</span>
								<!-- 还款方式 -->
								<div class="select_box">
									<select class="select w300" disabled='disabled'>
										<option value=''
											${subject.repaymentType==''|| subject.repaymentType==null?"selected":"" }>
											<spring:message code="sys.client.select" /><!-- 请选择 -->
										</option>
										<option value='onePay'
											${subject.repaymentType=='onePay'?"selected":""}>
											<spring:message code="sys.client.oneTime.payment" /><!-- 一次性还付本息 -->
										</option>
									</select>
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.factorType" />：</span>
								<!-- 保理类型 -->
								<div class="select_box">
									<select class="select w300" disabled='disabled'>
										<option value='online_factor'>
											<spring:message code="sys.client.online.clear.facte" /><!-- 明保理 -->
										</option>
									</select>
								</div>
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.repaymentTime" />：</span>
								<!-- 还款日期 -->
								<input placeholder="选择年月日" type="text" class="text w300"
									id="_repayment_date" disabled='disabled' /> <input
									type='hidden' id='repayDate' value='${subject.repaymentDate}' />
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.bid.end.date" />：</span>
								<!--竞标截止时间  -->
								<input type="text" class="text w300" id="_end_date"
									disabled='disabled' /> <input type='hidden' id='eDate'
									value='${subject.endDate}' />
							</div></li>
						<li class="w472"><div class="input_box">
								<span><spring:message code="sys.client.financeAmount" />：</span>
								<!-- 融资金额 -->
								<input type="text" class="text w200"
									value='<fmt:formatNumber value="${subject.amount/10000}" pattern="#,##0.00" maxFractionDigits="2"/>'
									disabled='disabled' id='amount' />
								<spring:message code="sys.client.tenThousand" />
								<!-- 万元 -->
							</div></li>
						<li><div class="input_box">
								<span><spring:message code="sys.client.finance.purpose" />：</span>
								<!-- 融资用途 -->
								<textarea class="text_tea w770 h100" disabled='disabled'>${subject.desc}</textarea>
							</div></li>
					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1>
					<spring:message code="sys.client.financeVoucher" />
				</h1>
				<!-- 融资凭证 -->
				<!--按钮top-->
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="subject_voucher_tb">
						<tr>
							<th width="50"><spring:message code="sys.client.no" /></th>
							<!-- 序号 -->
							<th><spring:message code="sys.client.voucherNumber" /> <!-- 凭证编码 --></th>
							<th><spring:message code="sys.client.coreCompanyName" /> <!-- 核心企业名称 --></th>
							<th><spring:message code="sys.client.voucherUnit" /> <!-- 凭证面额（万元） -->
							</th>
							<th><spring:message code="sys.client.voucherType" /> <!-- 凭证类型 --></th>
							<th><spring:message code="sys.client.voucher.start.time" />
								<!-- 凭证起始日期 --></th>
							<th><spring:message code="sys.client.voucherOverdueTime" />
								<!-- 凭证到期日 --></th>
							<th><spring:message code="sys.client.uploadTime" /> <!-- 上传时间 --></th>
							<th><spring:message code="sys.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach var="data" varStatus="index"
							items="${subjectVoucherList}">
							<tr>
								<td>${index.count}</td>
								<td>${data.voucherNo}</td>
								<td>${data.enterpriseName}</td>
								<td><fmt:formatNumber value="${data.amount/10000}"
										pattern="#,##0.00" maxFractionDigits="2" /></td>
								<td>${data.type}</td>
								<td>
									<!-- 时间戳转换为时间yyyy-mm-dd --> <jsp:useBean id="dateValue"
										class="java.util.Date" /> <jsp:setProperty name="dateValue"
										property="time" value="${data.effectiveDate}" /> <fmt:formatDate
										value="${dateValue}" pattern="yyyy-MM-dd" />
								</td>
								<td>
									<!-- 时间戳转换为时间yyyy-mm-dd --> <jsp:useBean id="dateValue1"
										class="java.util.Date" /> <jsp:setProperty name="dateValue1"
										property="time" value="${data.expireDate}" /> <fmt:formatDate
										value="${dateValue1}" pattern="yyyy-MM-dd" />
								</td>
								<td><fmt:formatDate value="${data.lastUpdateTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><div class="qy">
										<a href="javascript:view('${data.picUrls}');"><spring:message
												code="sys.client.preview" />
											<!-- 预览 --></a>
									</div></td>
							</tr>
						</c:forEach>
					</table>

				</div>
			</div>
			<div class="rzsq_box">
				<h1>
					<spring:message code="sys.client.loanMaterial" />
					<!-- 贷款材料 -->
				</h1>
				<div class="table_con table_border">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><spring:message code="sys.client.no" /></th>
							<!-- 序号 -->
							<th width="15%"><spring:message
									code="sys.client.materialName" /> <!-- 材料名称 --></th>
							<th width="25%"><spring:message code="sys.client.remark" />
								<!-- 备注 --></th>
							<th width="20%"><spring:message code="sys.client.uploadTime" />
								<!-- 上传时间 --></th>
							<th><spring:message code="sys.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach var="loanMaterial" items="${loanmaterialList}"
							varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td>${loanMaterial.name}</td>
								<td>${loanMaterial.remark}</td>
								<td><c:if
										test="${loanMaterial.attribute1!='' && loanMaterial.attribute1!=null}">
										<fmt:formatDate value="${loanMaterial.lastUpdateTime}"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</c:if></td>
								<td>
									<div class="qy">
										<a href="javascript:view('${loanMaterial.attribute1}');"><spring:message
												code="sys.client.preview" />
											<!-- 预览 --></a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="rzsq_box">
				<h1>
					<spring:message code="sys.client.bid.detail" />
				</h1>
				<!-- 竞标明细 -->

				<div class="table_con table_border mt20">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb2">
						<tr>
							<th width="50"><spring:message code="sys.client.no" /></th>
							<!-- 序号 -->
							<th><spring:message code="sys.client.bid.company" /></th>
							<!-- 竞标公司 -->
							<th><spring:message code="sys.client.orgCodeNo" /></th>
							<!-- 组织机构代码 -->
							<th><spring:message code="sys.client.yearRate" /></th>
							<!-- 年利率 -->
							<th><spring:message code="sys.client.max.loan.rate" /></th>
							<!-- 最大贷款比例 -->
							<th><spring:message code="sys.client.sure.bid.time" /></th>
							<!-- 应标时间 -->
							<th><spring:message code="sys.client.compositeScore" /></th>
							<!-- 综合评分 -->
							<th><spring:message code="sys.client.bid.result" /></th>
							<!-- 竞标结果 -->
							<th><spring:message code="sys.client.operation" /> <!-- 操作 --></th>
						</tr>
						<c:forEach var="data" items="${subjectBidList }" varStatus="index">
							<tr ${index.count%2==0?'class="bg_l"':''}>
								<td>${index.count}</td>
								<td><a
									href="/loanApplicationController/factorDetails?id=${data.enterpriseId}">${data.enterpriseName}</a></td>
								<td>${data.orgCodeNo}</td>
								<td><fmt:formatNumber value="${data.rate}"
										pattern="#,##0.00" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${data.ratio}"
										pattern="#,##0.00" maxFractionDigits="2" /></td>
								<td><fmt:formatDate value="${data.createdTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>${data.compositeScore}</td>
								<td><c:if test="${data.status=='unbid'}">
										<spring:message code="sys.client.unbid" />
										<!-- 未中标 -->
									</c:if> <c:if test="${data.status=='bided'}">
										<spring:message code="sys.client.bid" />
										<!-- 中标 -->
									</c:if> <c:if test="${data.status=='biding'}">
										<spring:message code="sys.client.biding" />
										<!-- 竞标中 -->
									</c:if></td>
								<td><div class="qy">
										<a href="/subjectController/toBidPage?id=${data.id}"
											target="_blank"> <spring:message
												code="sys.client.bid.detail" /> <!-- 竞标详情 --></a>
									</div></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>