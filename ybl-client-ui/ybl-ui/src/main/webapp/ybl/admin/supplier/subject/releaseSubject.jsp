<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.release.subject" /></title>
<!-- 发布标的 -->
<jsp:include page="../../common/link.jsp" />
<!-- 表单验证 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript'
	src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<!-- 日期控件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/subject/editSubject.js"></script>
<style>
	.qy a{display:inline-block;}
	.qy .none1{display:none;}
</style>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">
		<!-- 当前位置->标的管理 -> 普通标管理 -> 发布标的 -->
		<spring:message code="sys.client.location" />
		->
		<spring:message code="sys.client.subject.manage" />
		->
		<spring:message code="sys.client.common.subject.manage" />
		->
		<spring:message code="sys.client.release.subject" />
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i>
					<spring:message code="sys.client.release.subject" />
					<!-- 发布标的 -->
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
			<form action="/subjectController/addOrUpdateSubject" id="subjectForm"
				method="post">
				<div class="rzsq_box">
					<input type='hidden' name='id' value="${subject.id}"
						id='subject_id' /> <input type='hidden' name='status'
						value="${subject.status}" id='subject_status' />
					<h1>
						<spring:message code="sys.client.subject.apply" />
					</h1>
					<!-- 标的申请 -->
					<div class="rzzt">
						<ul>
							<li><div class="input_box">
									<span><spring:message code="sys.client.financeNumber" />：</span>
									<!-- 融资编号 -->
									<input type="text"
										class="text w300 validate[required,maxSize[50],custom[onlyLetterNumber]]"
										value="${subject.number}" name='number' readOnly id='number'/><i>*</i>
									<input type='hidden' value='${subjectNum }' id='subjectNum'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.projectName" />：</span>
									<!-- 项目名称 -->
									<input type="text"
										class="text w300 validate[required,maxSize[255]]" name='name'
										value="${subject.name}" /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.loan.period" />：</span>
									<!-- 贷款期限  -->
									<input type="text"
										class="text w300 validate[required,maxSize[11],custom[onlyNumberSp]]"
										value="${subject.loanPeriod}" name='loanPeriod'
										id='loanPeriod' /><i>*</i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.period.type" />：</span>
									<!-- 期限类型 -->
									<div class="select_box">
										<select class="select w300" name='periodType' id='periodType'>
											<option value='day'
												${subject.periodType=='day'?"selected":"" }><spring:message
													code="sys.client.by.day" /><!-- 按天 --></option>
											<option value='month'
												${subject.periodType=='month'?"selected":"" }><spring:message
													code="sys.client.by.month" /><!-- 按月 --></option>
											<option value='year'
												${subject.periodType=='year'?"selected":"" }><spring:message
													code="sys.client.by.year" /><!-- 按年 --></option>
										</select>
									</div>
								</div></li>
							<li class="clear w472"><div class="input_box">
									<span><spring:message code="sys.client.repaymentType" />：</span>
									<!-- 还款方式 -->
									<div class="select_box">
										<select class="select w300" name='repaymentType'>
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
										<select class="select w300" name='factoringType'>
											<option value='online_factor'>
												<spring:message code="sys.client.online.clear.facte" /><!-- 明保理 -->
											</option>
										</select>
									</div>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.repaymentTime" />：</span>
									<!-- 还款日期 -->
									<input type="text"
										class="text w300 validate[required,custom[date]]"
										id="_repayment_date" name='repaymentDate' readOnly='readOnly' /><i>*</i><input
										type='hidden' id='repayDate' value='${subject.repaymentDate}' />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bid.end.date" />：</span>
									<!--竞标截止时间  -->
									<input type="text"
										class="text w300 validate[required,custom[date],future[now]]"
										id="_end_date" name='endDate' /><i>*</i><input type='hidden'
										id='eDate' value='${subject.endDate}' />
								</div></li>
							<li class="w472"><div class="input_box">
									<span><spring:message code="sys.client.financeAmount" />：</span>
									<!-- 融资金额 -->
									<input type="text"
										class="text w200 validate[required,min[0.01],custom[numberLimit242]]"
										value='<fmt:formatNumber value="${subject.amount}" pattern="0.00" maxFractionDigits="2"/>'
										name='amount' id='amount' />
									<spring:message code="sys.client.element" />
									<i>*</i>
									<!-- 元 -->
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.finance.purpose" />：</span>
									<!-- 融资用途 -->
									<textarea class="text_tea w770 h100" name='desc'>${subject.desc}</textarea>
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
					<div class="table_top mt20 table_border">
						<div class="table_nav">
							<ul>
								<li><a id='member_supplier_subject_finance_voucher_add_btn' class='but_ico7' >
										<spring:message code="sys.client.add" />
									</a><!-- 添加 --></li>
								<li><a id='member_supplier_subject_finance_voucher_delete_btn' class='but_ico1' >
										<spring:message code="sys.client.delete" />
									</a> <!-- 删除--></li>
							</ul>
						</div>
					</div>
					<div class="table_con table_border ">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							id="subject_voucher_tb">
							<tr>
								<th width="50"><input type="checkbox" value="" id='checkAll'/></th>
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
									<td><input type="checkbox" value="0" name="checkbox"
										ids="${data.id}" voucherId="${data.attribute1}" /></td>
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
													code="sys.client.preview" /> <!-- 预览 --></a>
										</div></td>
								</tr>
							</c:forEach>
						</table>

					</div>
				</div>
				<div id='loan_material_div'></div>
			</form>
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
										<a href="javascript:void(0);" names='loan_metarial_upload_btn'
											id='loan_metarial_upload_btn_${index.count}'
											name='${loanMaterial.name}' code="${loanMaterial.code }"
											remark="${loanMaterial.remark}"
											meaId="${loanMaterial.attribute2}"> <spring:message
												code="sys.client.upload" /> <!-- 上传 -->
										</a> <a href="javascript:view('${loanMaterial.attribute1}');"
											class="${loanMaterial.attribute1!=''?'':'none1'}"><spring:message
												code="sys.client.preview" /> <!-- 预览 --></a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<!-- 已选中的贷款材料上传信息 -->
			<div></div>
			<div class="but_left">
				<a id='member_supplier_subject_temporary_btn'>
					<spring:message code="sys.client.temporary"/>
				</a>
				<!-- 暂存 -->
				<a id='member_supplier_subject_submit_btn'>
					<spring:message code="sys.client.submit"/>
				</a>
				<!-- 提交 -->
				<a id="submitingBtn" style="display: none;">
					<spring:message code="sys.client.submiting"/>...
				</a><!-- 提交中 -->
				<a id='member_supplier_subject_cancel_btn' class="qx">
					<spring:message code="sys.client.cancel"/>
				</a>
				<!-- 取消 -->
			</div>
		</div>
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