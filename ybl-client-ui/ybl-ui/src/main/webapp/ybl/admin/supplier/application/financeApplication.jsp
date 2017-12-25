<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>融资申请</title>
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>

<!--日期控件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>

<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/supplier/financeApplication.js"></script>
<style>
	.qy a{display:inline-block; margin-left:5px;}
	.qy .none1{display:none;}
</style>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->
	
	<div class="path"><spring:message code='sys.client.location'></spring:message>-><!-- 当前位置 -->
	 <spring:message code='sys.client.loan.apply'></spring:message> -><!--  贷款申请 -->
	<spring:message code='sys.client.facte.service'></spring:message>-> <!-- 保理服务  -->
	<spring:message code='sys.client.factor.details'></spring:message> -> <!-- 保理商详情 -->
	<spring:message code='sys.client.financeApply'></spring:message><!-- 融资申请 -->
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
            	<div class="v_tittle"><h1><i class="v_tittle_2"></i><spring:message code='sys.client.financeApply'></spring:message></h1></div><!-- 融资申请 -->
            	<div class="rzsq_box">
					<h1><spring:message code='sys.client.FinanceBody'></spring:message></h1><!-- 融资主体 -->
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span><spring:message code='sys.client.companyName'></spring:message>：</span><input type="text" class="w300 text_gary" value="${entersh.enterpriseName}" readonly="readonly" /></div></li><!-- 企业名称 -->
						<li><div class="input_box"><span><spring:message code='sys.client.companyTelephone'></spring:message>：</span><input type="text" class="text_gary w300" value="${entersh.fixedPhone}" readonly="readonly"  /></div></li><!-- 企业固定电话 -->
						<li><div class="input_box"><span><spring:message code='sys.client.licenseNumber'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.licenseNo}" readonly="readonly"  /></div></li><!-- 营业执照注册号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPersonName'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.legalName}" readonly="readonly"  /></div></li><!-- 法人代表名称 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPersonIDCard'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.legalCardId}" readonly="readonly"  /></div></li><!-- 法人代表身份证号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPhone'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.legalPhone}" readonly="readonly"  /></div></li><!-- 联系电话号码 -->
						<li><div class="input_box"><span><spring:message code='sys.client.open.bank.name'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.openBank}" readonly="readonly"  /></div></li><!-- 开户银行 -->
						<li><div class="input_box"><span><spring:message code='sys.client.open.bank.account'></spring:message>：</span><input  type="text" class="text_gary w300" value="${entersh.accountNo}" readonly="readonly"  /></div></li><!-- 开户银行账号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.bankBranch'></spring:message>：</span><input type="text" class="text_gary w770" value="${entersh.branchName}" readonly="readonly"  /></div></li><!-- 支行名称 -->
					</ul>
					</div>
				</div>
           		<div class="rzsq_box">
					<h1><spring:message code='sys.client.factorBody'></spring:message></h1><!-- 保理商主体 -->
					<input type="hidden" id="factorId" value="${enterbl.id}">
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span><spring:message code='sys.client.companyName'></spring:message>：</span><input type="text" class="w300 text_gary" value="${enterbl.enterpriseName}" readonly="readonly"  /></div></li><!-- 企业名称 -->
						<li><div class="input_box"><span><spring:message code='sys.client.companyTelephone'></spring:message>：</span><input type="text" class="text_gary w300" value="${enterbl.fixedPhone}" readonly="readonly"  /></div></li><!-- 企业固定电话 -->
						<li><div class="input_box"><span><spring:message code='sys.client.licenseNumber'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.licenseNo}" readonly="readonly"   /></div></li><!-- 营业执照注册号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPersonName'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.legalName}" readonly="readonly"  /></div></li><!-- 法人代表名称 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPersonIDCard'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.legalCardId}" readonly="readonly"  /></div></li><!-- 法人代表身份证号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.legalPhone'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.legalPhone}" readonly="readonly"  /></div></li><!-- 联系电话号码 -->
						<li><div class="input_box"><span><spring:message code='sys.client.open.bank.name'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.openBank}" readonly="readonly"  /></div></li><!-- 开户银行 -->
						<li><div class="input_box"><span><spring:message code='sys.client.open.bank.account'></spring:message>：</span><input  type="text" class="text_gary w300" value="${enterbl.accountNo}" readonly="readonly"  /></div></li><!-- 开户银行账号 -->
						<li><div class="input_box"><span><spring:message code='sys.client.bankBranch'></spring:message>：</span><input type="text" class="text_gary w770" value="${enterbl.branchName}" readonly="readonly"  /></div></li><!-- 支行名称 -->
					</ul>
					</div>
				</div>
           		<div class="rzsq_box">
					<h1><spring:message code='sys.client.productDetail'></spring:message> </h1><!-- 产品详情 -->
					<input type="hidden" id="productId" value="${product.id}"> 
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span><spring:message code='sys.client.productName'></spring:message>：</span><input type="text" class= "w770 text_gary" value="${product.name_}"  readonly="readonly" /></div></li><!-- 产品名称 -->
						<li>
							<div class="input_box"><span><spring:message code='sys.client.factorType'></spring:message>：</span><!-- 保理类型 -->
									<div class="select_box">
										<select class="select w200" disabled="disabled">
											<option <c:if test="${product.type_=='online_factor' }">selected="selected" </c:if> ><spring:message code='sys.client.online.clear.facte'></spring:message> </option><!-- 明保理 -->
											<option <c:if test="${product.type_=='dark_factor' }">selected="selected"</c:if>  ><spring:message code='sys.client.dark.facte'></spring:message> </option><!-- 暗保理 -->
										</select>
									</div>
								</div>
							</li>
						<li class=" w472">
					      <!-- <div class="input_box"><span>还款方式：</span>
						      <div class="radio"><input class="radio_input" type="radio" name="RadioGroup1" value="单选" disabled="disabled" />到期一次性还本付息</div>
						  </div> -->
						 </li>
						<%-- <li class="clear w472">
							<div class="input_box">
								<span><spring:message code='sys.client.repaymentRule'></spring:message>：</span><!-- 还款日规则 -->
									<div class="radio">
										<!-- <input class="radio_input" type="radio" name="RadioGroup1" value="单选" /> -->
											<div class="select_box" >
												<select class="select w55 mr10" disabled="disabled" >
													<option <c:if test="${product.repayment_date_rule =='greater_than' }"> checked="checked" </c:if> >></option>
													<option <c:if test="${product.repayment_date_rule =='equal_to' }"> checked="checked" </c:if> >=</option>
													<option <c:if test="${product.repayment_date_rule =='less_than' }"> checked="checked" </c:if> ><</option>
												</select>
											</div>
											<spring:message code='sys.client.loanVoucherLimiteDay'></spring:message> <!-- 贷款凭证最早到期日 -->
									</div>
							</div>
						</li> --%>
						<li class="clear w472"><div class="input_box"><span><spring:message code='sys.client.loanRate'></spring:message><!-- 贷款利率 -->：</span><div><spring:message code='sys.client.yearRate'></spring:message><!-- 年利率 --><input  id="rate" value='<fmt:formatNumber value="${product.rate_}" pattern="0.00"  />' readonly="readonly" type="text" class="text w50 mr10 ml10"/>%</div></div></li>
						<li class="clear w472"><div class="input_box"><span><spring:message code='sys.client.overdueInterest'></spring:message> <!-- 逾期利率 -->：</span><div><spring:message code='sys.client.dailyInterest'></spring:message><!-- 日利率 --><input value= '<fmt:formatNumber value="${product.overdue_rate }" pattern="0.00"  />' readonly="readonly" type="text" class="text w50 mr10 ml10"/>%</div></div></li>
						<li class="w472"><div class="input_box"><span><spring:message code='sys.client.managementPercent'></spring:message> <!-- 管理费百分比 -->：</span><div><spring:message code='sys.client.yearRate'></spring:message><!-- 年利率 --><input id="manageRatio" value= '<fmt:formatNumber value="${feeVo.value }" pattern="0.00"  />'  readonly="readonly" type="text" class="text w50 mr10 ml10"/>%</div></div></li>
						<li class="w472"><div class="input_box"><span><spring:message code='sys.client.defaultRate'></spring:message><!-- 违约利率 -->：</span><div><spring:message code='sys.client.dailyInterest'></spring:message><!-- 日利率 --><input value= '<fmt:formatNumber value="${product.penalty_rate }" pattern="0.00"  />' readonly="readonly" type="text" class="text w50 mr10 ml10"/>%</div></div></li>
						<li class="w472"><div class="input_box"><span><spring:message code='sys.client.financingProportion'></spring:message> <!-- 融资比例 -->：</span><input id="financeRatio" value='<fmt:formatNumber value="${product.finance_ratio }" pattern="0.00"  />' readonly="readonly" type="text" class="text w50 mr10"/>%</div></li>
					</ul>
					</div>
				</div>
           		<div class="rzsq_box">
					<h1><spring:message code='sys.client.financeApply'></spring:message></h1><!-- 融资申请 -->
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span><spring:message code='sys.client.financeNumber'></spring:message>：</span><input id="applyNum" value="${applyNum}" readonly="readonly" type="text" class= "w300 text_gary"/></div></li><!-- 融资编号 -->
						<!-- <li><div class="input_box"><span>融资申请时间：</span><input id="applyDate" type="text"  date="true"  class="w300 text_gary"/></div></li> -->
						<li class="w472"><div class="input_box"><span><spring:message code='sys.client.financeApplyMoney'></spring:message>：</span><input id="applyAmount" type="text" class="text w100 mr10" onkeyup="value=value.replace(/[^\d.]/g,'')"  
						onblur="value=value.replace(/[^\d.]/g,'')" /><i>*</i>&nbsp;&nbsp; <spring:message code='sys.client.element' ></spring:message><!-- 元 --></div></li><!-- 申请贷款金额 -->
						<li class="w472"><div class="input_box"><span><spring:message code='sys.client.maxLoanMoney'></spring:message>：</span><input id="maxLoanAmount" readonly="readonly" type="text" class="text w100 mr10"/><spring:message code='sys.client.element' ></spring:message><!-- 元 --></div></li><!-- 最大可贷金额 -->
						<li><div class="input_box">
						<span>
							<spring:message code='sys.client.repaymentTime'></spring:message><!-- 还款日期 -->：
						</span>
						<input id="repaymentDate" placeholder=<spring:message code='sys.client.auto.calc'></spring:message>  readonly="readonly" date="true" type="text" class= "w300 text_gary"/><i class="red">*</i></div></li><!-- 填写还款日规则和添加凭证后自动计算 -->
						<li class="">
							<div class="input_box">
								<span><spring:message code='sys.client.repaymentRule'></spring:message>：</span><i class="red">*</i><!-- 还款日规则 -->
									<div class="radio fl mr100"><input class="radio_input" type="radio" name="periodType" value="day" /><b><spring:message code='sys.client.day'></spring:message></b><!-- 日 -->
										<div class="input_box"><input class="text w50 mr10" type="text" id="loanPeriodDay" value=""  
										onkeyup="value=value.replace(/[^\d]/g,'')"  onblur="value=value.replace(/[^\d]/g,'')"><spring:message code='sys.client.day'></spring:message> </div><!-- 天 -->
									</div>
									<div class="radio fl"><input class="radio_input" type="radio" name="periodType" value="month" /><b><spring:message code='sys.client.month'></spring:message></b><!-- 月 -->
										<div class="input_box">
											<input type="text" class="text w50 mr10" id="loanPeriodMonth" value=""  onkeyup="value=value.replace(/[^\d]/g,'')"  onblur="value=value.replace(/[^\d]/g,'')"><spring:message code='sys.client.month'></spring:message><!-- 月 -->
										</div>
									</div>
							</div>
						</li>
						<!-- <li class="clear"><div class="input_box"><span>预计放款审批时间：</span><input id=""  placeholder="请输入放款审批时间" type="text" class= "w300 text"/></div></li> -->
					</ul>
					</div>
				</div>
				
				<div class="rzsq_box">
					<h1><spring:message code='sys.client.financeVoucher'></spring:message></h1><!-- 融资凭证 -->
						<!--按钮top-->
						<div class="table_top mt20 table_border">
							<div class="table_nav">
								<ul>
									<li><a class="but_ico7" id="financeApplyAddVoucher" href="javascript:addFinanceApplyVoucher()" ><spring:message code='ybl.web.department.add'></spring:message></a></li><!-- 添加 -->
									<li><a class="but_ico1" id="financeApplyDeleteVoucher"><spring:message code='sys.admin.delete'></spring:message> </a></li><!-- 删除 -->
								</ul>
							</div>
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="financeApplyVoucherTable">
							  <tr>
							  	<th width="50"><input name="financeApplyVoucher" id='checkAll' type="checkbox" value="" /></th>
							   	<th width="50"><spring:message code='sys.client.no'></spring:message></th><!-- 序号 -->
								<th><spring:message code='sys.client.voucherNumber'></spring:message></th><!-- 凭证编码 -->
								<th><spring:message code='sys.client.coreCompanyName'></spring:message></th><!-- 核心企业名称 -->
								<th><spring:message code='sys.client.voucherAmount'></spring:message></th><!-- 凭证面额（元） -->
								<th><spring:message code='sys.client.voucherType'></spring:message></th><!-- 凭证类型 -->
								<th><spring:message code='sys.client.voucherOverdueTime'></spring:message></th><!-- 凭证到期日 -->
								<th><spring:message code='sys.client.uploadTime'></spring:message></th><!-- 上传时间 -->
								<th><spring:message code='sys.admin.operation'></spring:message></th><!-- 操作 -->
							  </tr>
							</table>
						</div>
				</div>
				
				
           		<div class="rzsq_box">
					<h1><spring:message code='sys.client.loanMaterial'></spring:message></h1><!-- 贷款材料 -->
						<!--按钮top-->
						<!-- <div class="table_top mt20 table_border">
						</div> -->
						<div class="table_con table_border">
							<table width="100%" id=""financeApplyVoucherTable  border="0" cellspacing="0" cellpadding="0" id="tb">
							  <tr>
							   <th width="50"><spring:message code='sys.client.no'></spring:message></th><!-- 序号 -->
								<th><spring:message code='sys.client.materialName'></spring:message></th><!-- 材料名称 -->
								<th><spring:message code='sys.client.remark'></spring:message></th><!-- 备注 -->
								<th><spring:message code='sys.client.uploadTime'></spring:message></th><!-- 上传时间 -->
								<th width="250"><spring:message code='sys.admin.operation'></spring:message> </th><!-- 操作 -->
							  </tr>
							<c:forEach items="${materialList}" var="material" varStatus="varStat" >
							  <tr>
								<td>${varStat.count }</td>
								<td>${material.name }</td>
								<td>${material.remark }</td>
								<%-- <fmt:formatDate value="${material.lastUpdateTime }" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
								<td></td>
								<td>
									<div class="qy">
										<a class="upLoadMaterialPic" materialId="${material.id }" materialSize=${varStat.index} ><spring:message code='sys.client.upload'></spring:message> </a><!-- 上传 -->
										<a class="none1" id="upLoadMaterialPic${material.id}" name="yulan"  materialName="${material.name }" ><spring:message code='sys.client.preview'></spring:message></a><!-- 预览 -->
									</div>
								</td>
							  </tr>
							</c:forEach>
							</table>
						</div>
				</div>
           
           		
           		<!-- <div class="rzsq_box">
					<h1>合同信息</h1>
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span>选择文件：</span><input type="file" class=" f16" style="padding:10px 10px 0px 10px;"/></div></li>
						
					</ul>
					</div>	
						
				</div> -->
           		<div class="but_center_100"><a id="financeApplySubmitBtn"><spring:message code='sys.client.submit'></spring:message></a></div><!-- 提交 -->
           		<div class="but_center_100" style="display: none" ><a id="financeApplySubmitingBtn"><spring:message code='sys.client.submiting'></spring:message></a> </div><!-- 提交中..... -->
           		<div class="but_center_100" style="display: none" ><a id="financeApplySubmitSuccessBtn"><spring:message code='sys.client.submit.success'></spring:message></a></div><!-- 提交成功 -->
            </div>
        
    </div>
    <!-- 文件上传form-->
    <iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>

	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>