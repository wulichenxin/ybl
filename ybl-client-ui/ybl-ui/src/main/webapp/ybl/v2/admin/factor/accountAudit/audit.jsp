<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title><spring:message code="sys.v2.client.account.audit"/>-<spring:message code="sys.v2.client.riskFirstAudit"/></title>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/v2/js/accountAudit.js"></script>
<script type="text/javascript">
$(function() {
	
	//回调，回显图片
	uploadCallback = function(attachment) {
		attach = eval("(" + attachment + ")");
// 		$("#common_upload_btn").val('');
		
		var table_length = $("#table").find("tr").length;
		var input1 = $("<input type='hidden' value='"+ attach.url_ +"' name='attachmentList["+(table_length - 2)+"].url_'/>");
		var input2 = $("<input type='hidden' value='"+ attach.new_name +"' name='attachmentList["+(table_length - 2)+"].new_name'/>");
		var input3 = $("<input type='hidden' value='"+ attach.ext_name +"' name='attachmentList["+(table_length - 2)+"].ext_name'/>");
		var input4 = $("<input type='hidden' value='ybl_v2_accounts_receivable_first_trial' name='attachmentList["+(table_length - 2)+"].type_'/>");
		var td1 = $("<td>"+(table_length-1)+"</td>");
		var td2 = $("<td>"+"<input type='text' class='w200 v2_text'  readonly='readonly' value='"+ attach.old_name +"' name='attachmentList["+(table_length - 2)+"].old_name'/>"+"</td>");
		var td3 = $("<td>"+"<input type='text' class='w200 v2_text validate[maxSize[50]]' name='attachmentList["+(table_length - 2)+"].attribute1'/>"+"</td>");
		var td4 = $("<td>"+"<input type='text' class='w200 v2_text'  readonly='readonly' value='"+ ext.formatDate(new Date(), 'yyyy-MM-dd h:m:s') +"' name='attachmentList["+(table_length - 2)+"].createdTime'/>"+"</td>");
		var td5 = $("<td>"+"<a class='lan' onclick='deleteRow(this,null)'>删除</a>"+"</td>");
		var tr = $("<tr class='attachTr'></tr>");
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		tr.append(input1);
		tr.append(input2);
		tr.append(input3);
		tr.append(input4);
		$("#table tr:eq("+(table_length - 2)+")").after(tr); 
		
		$("#common_upload_btn").remove();
		$("#common_upload_form").append('<input id="common_upload_btn" type="file" name="file" style="display: none;" />');
		listenUpload();
		
	}
	
	callback = function() {
		parent.parent.location.href="/accountsAffirmController/queryFactorList.htm";
	}
})
</script>
</head>
<body>
	<div class="v2_top_bg v2_t_bg2">
		<div class="v2_top_con">
			<!--top start -->
			<%@ include file="/ybl/v2/admin/common/top.jsp"%>
			
			<div class="v2_z_nav now">
				<div class="v2_z_nav_con">
				<div class="v2_z_navbox">
					<a class="w150  now"  href="/accountsAffirmController/queryFactorList.htm"><spring:message code="sys.v2.client.riskFirstAudit"/></a>
					<a class="w150 " href="/accountsAffirmController/queryAnalyzeList.htm"><spring:message code="sys.v2.client.analysis"/></a>
					<a class="w150 " href="/accountsAffirmController/queryRecheckList.htm"><spring:message code="sys.v2.client.riskReAudit"/></a>
					<a class="w150" href="/accountsAffirmController/queryBusinessList.htm"><spring:message code="sys.v2.client.businessHandling"/></a>
				</div>
				</div>
			</div>
			<!--top end -->
		</div>
	</div>
	<!---->
	<form action="/accountsAffirmController/auditAccount" id="submit" method="post">
		<input type="hidden" name="type" value="ybl_v2_accounts_receivable_audit"/>	   			   <!-- 审核表type -->
		<input type="hidden" value="${id }" id="" name="businessId"/>                			   <!-- 账款id -->
		<input type="hidden" name="status" value="first_trial"/>	                                   <!-- 审核表status -->
		<div class="v2_vip_conbody">
			<div class="v2_path_no"><spring:message code="sys.v2.client.location"/>：
				<spring:message code="sys.v2.client.account.audit"/> > 
				<spring:message code="sys.v2.client.riskFirstAudit"/> > 
				<spring:message code="sys.v2.client.audit.detail"/>
			</div>
			<div class="v2_box_border mt20">
				<div class="v2_tab">
					<div class="v2_t_nav">
						<dl>
							<dd class="now">
								<a><spring:message code="sys.v2.client.account.information"/><!-- 账款信息 --></a>
							</dd>
							<dd>
								<a><spring:message code="sys.v2.client.invoice.information"/><!-- 发票信息 --></a>
							</dd>
							<dd>
								<a><spring:message code="sys.v2.client.transportDocument"/><!-- 运输单据 --></a>
							</dd>
							<dd>
								<a><spring:message code="sys.v2.client.other"/><!-- 其他 --></a>
							</dd>
						</dl>
					</div>
					<!--1-->
					<div>
						<div class="v2_tab_con">
							<div class="v2_text_box">
								<h1><spring:message code="sys.v2.client.voucher.informaion"/><!-- 凭证信息 --></h1>
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.voucherNumber"/><!-- 凭证号码 -->：</span><input type="text"
												class="w300 v2_text "
												value="${accountsReceivableVoucher.number_ }" />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.contractNO"/><!-- 合同编号 -->：</span>
											<input
												type="text"
												class="w300 v2_text "
												value="${contract.number_ }" />
											
										</div></li>
									<li class="clear"><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.voucher.amount"/><!-- 凭证票面金额 -->：</span><input
												 type="text"
												class="w300 v2_text "
												value="<fmt:formatNumber value="${accountsReceivableVoucher.amount_ }" pattern="##0.00" maxFractionDigits="2"/>" />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.factor"/><!-- 保理商 -->：</span><input  type="text" disabled="disabled"
												class="w300 v2_text factor_enterprise_name"
												value="${factorEnterprise.enterprise_name }" />
										</div>
									</li>
									<li class="clear"><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceDate"/><!-- 凭证开票日期 -->：</span>
											<div class="v2_date">
												<input date="true" id="invoice_date" name="voucherInvoiceDate" value="${accountsReceivableVoucher.invoice_date }"
													type="text" class="w300 v2_text " /><a
													class="v2_date_text_ico"></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.expectTheReceivable"/><!-- 预计回款日期 -->：</span>
											<div class="v2_date">
												
												<input date="true" id="return_date" name="returnDate" value="${accountsReceivableVoucher.return_date }"
													type="text" class="w300 v2_text"  />
													<a class="v2_date_text_ico"></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.supplier"/><!-- 供应商名称 -->：</span><input  type="text" disabled="disabled"
												class="w300 v2_text supplier_enterprise_name"
												value="${supplierEnterprise.enterprise_name }" />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.core.enterprise"/><!-- 企业名称 -->：</span><input  type="text" disabled="disabled"
												class="w300 v2_text core_enterprise_name"
												value="${coreEnterprise.enterprise_name }" />
										</div>
									</li>
								</ul>
								<div class="v2_table_con1">
									
									<table id="vouTb">
										<tr>
											<th width="50"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
											<th width="200"><spring:message code="sys.v2.client.tradeName"/><!-- 商品名称 --></th>
											<th><spring:message code="sys.v2.client.standard"/><!-- 规格 --></th>
											<th><spring:message code="sys.v2.client.unit"/><!-- 单位 --></th>
											<th><spring:message code="sys.v2.client.quantity"/><!-- 数量 --></th>
											<th><spring:message code="sys.v2.client.unitPrice"/><!-- 单价 --></th>
										</tr>
										<c:forEach var="list" items="${accountsReceivableVoucherCommoditiesList}" varStatus="index">
											<tr>
												<td>${index.count }</td>
												<td>${list.name_ }</td>
												<td>${list.standard_ }</td>
												<td>${list.unit_ }</td>
												<td>${list.quantity_ }</td>
												<td><fmt:formatNumber value="${list.price_ }" pattern="##0.00" maxFractionDigits="2"/></td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<ul>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.remark"/><!-- 备注 -->：</span>
											<textarea class="v2_text_tea h100 w890" readonly="readonly">${accountsReceivableVoucher.remark_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone" >
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableVoucherAttaList}">
							                    		<c:if test="${not empty attachment.url_ }">
														<dd>
							                    			<a rel="group1" href="${attachment.url_ }"><img src="${attachment.url_ }" /><i ></i></a>
														</dd>
							                    		</c:if>
													</c:forEach>
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
							
							<div class="v2_text_box">
								<h1><spring:message code="sys.v2.client.riskFirstAudit"/><!-- 风控初审 --></h1>
								<ul>
									<li class="clear">
										<div class="v2_input_box"><span><spring:message code="sys.v2.client.audit.first"/><!-- 初审结果 -->：</span>
											<div class="v2_select_box">
												<select name="operation" id="operation" class="v2_select w320">
													<option value=""><spring:message code="sys.client.select" /></option><!-- 请选择 -->
													<option value="agree"><spring:message code="sys.client.agree" /></option><!-- 通过 -->
													<option value="disagree"><spring:message code="sys.client.disagree" /></option><!-- 不通过 -->
												</select>
											</div>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box"><span><spring:message code="sys.v2.client.audit.opinion" /><!-- 审核意见 -->：</span><textarea class="v2_text_tea h100 w890" id="comment" name="comment"></textarea></div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.audit.measure" /><!-- 风控措施 -->：</span>
											<div class="v2_table_con1 ml150">
												<table id="table">
													<tr>
														<th width="50"><spring:message code="sys.v2.client.no" /><!-- 序号 --></th>
														<th width="200"><spring:message code="sys.v2.client.AttachmentName" /><!-- 附件名称 --></th>
														<th><spring:message code="sys.v2.client.remark" /><!-- 备注 --></th>
														<th><spring:message code="sys.v2.client.uploadTime" /><!-- 上传时间 --></th>
														<th><spring:message code="sys.v2.client.operation" /><!-- 操作 --></th>
													</tr>
													
													<tr>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td><a class="lan" id="uploading"><spring:message code="sys.v2.client.upload" /><!-- 上传 --></a></td>
													</tr>
												</table>
											</div>
										</div>
									</li>
								</ul>
								
								
						   </div>
						   <div class="v2_text_box">
									<h1><spring:message code="sys.v2.client.audit.history" /><!-- 历史审核记录 --></h1>
									<div class="v2_table_con1">
									<table>
										<tr>
											<th width="50"><spring:message code="sys.v2.client.no" /><!-- 序号 --></th>
											<th width="200"><spring:message code="sys.v2.client.auditType" /><!-- 提交类型 --></th>
											<th><spring:message code="sys.v2.client.auditResult" /><!-- 审核结果 --></th>
											<th><spring:message code="sys.v2.client.audit.time" /><!-- 审核时间 --></th>
											<th><spring:message code="sys.v2.client.auditor" /><!-- 审核人 --></th>
											<th><spring:message code="sys.v2.client.operation" /><!-- 操作 --></th>
										</tr>
										<c:forEach  var="list" items="${auditRecordList}" varStatus="index">
											<tr>
												<td>${index.count }</td>
												<td>
													<c:if test="${list.status_  == 'first_trial'}">风控初审</c:if>
													<c:if test="${list.status_  == 'analyze'}">尽调分析</c:if>
													<c:if test="${list.status_  == 'recheck'}">风控复审</c:if>
													<c:if test="${list.status_  == 'business'}">业务办理</c:if>
												</td>
												<td>
													<c:if test="${list.operation_ == 'agree' }">同意</c:if>
													<c:if test="${list.operation_ == 'disagree' }">不同意</c:if>
													<c:if test="${list.operation_ == 'turn_down' }">驳回</c:if>
													<c:if test="${list.operation_ == 'authstr' }">待审核</c:if>
												</td>
												<td>
													<jsp:useBean id="dateValue1" class="java.util.Date" />
													<jsp:setProperty name="dateValue1" property="time" value="${list.created_time }" />
													<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd HH:mm:ss" />
												</td>
												<td>${list.attribute2_ }</td>
												<td>
													<a class="lan auditDetail" value="${list.id_ }" type="${list.status_ }">
														<spring:message code="sys.v2.client.detail" /><!-- 详情 -->
													</a>
												</td>
											</tr>										
										</c:forEach>
									</table>
									</div>
							   </div>
							<div class="v2_but_list">
								<c:if test="${maxAuditRecord.type_ == 'ybl_v2_accounts_receivable_audit' }">
									<c:if test="${maxAuditRecord.operation_ == 'authstr' && maxAuditRecord.status_ == 'first_trial'}">
										<a class="bg_l" id="factor_accountAffirm_agree_audit_btn"><spring:message code="sys.v2.client.submit"/><!-- 提交 --></a>
										<a class="bg_l none1" ><spring:message code="sys.v2.client.submiting"/><!-- 提交中 --></a>
									</c:if>
								</c:if>
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--2-->
						<div class="v2_tab_con" style="display: none;">
							<div class="v2_text_box">
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceNumber"/><!-- 发票号码 -->：</span>
											<input value="${accountsReceivableBill.number_ }" type="text" name="billNumber" id="bill_number" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoice.amount"/><!-- 发票票面金额 -->：</span>
											<input id="bill_amount" name="billAmount" 
												value="<fmt:formatNumber value="${accountsReceivableBill.amount_ }" pattern="##0.00" maxFractionDigits="2"/>" type="text"
												class="w300 v2_text " />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoice"/><!-- 联次 -->：</span>
											
											<div class="v2_select_box">
												<select class="v2_select w320" onchange="func()"
													name="billType" id="type_"
													url="/configController/get-BILL_TYPE" valueField="code_"
													textField="value_" defaultValue="${accountsReceivableBill.type_ }"
													isSelect="Y" disabled="disabled">
												</select>
											</div>
										</div>
									</li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceDate"/><!-- 开票日期 -->：</span>
											<div class="v2_date">
												<input date="true" id="bill_invoice_date"  value="${accountsReceivableBill.invoice_date }"
													type="text" class="w300 v2_text" /><a
													class="v2_date_text_ico"></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.supplier"/><!-- 供应商 -->：</span><input
												
												value="${supplierEnterprise.enterprise_name }" type="text"
												class="w300 v2_text supplier_enterprise_name " />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.core.enterprise"/><!-- 企业名称 -->：</span> <input 
												value="${coreEnterprise.enterprise_name }" type="text" 
												class="w300 v2_text core_enterprise_name " />
										</div>
									</li>
									<li class="clear"><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceIssuingEntity"/><!-- 开票单位 -->：</span><input 
												value="${accountsReceivableBill.invoice_issuing_entity }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoicePeople"/><!-- 开票负责人 -->：</span><input 
												value="${accountsReceivableBill.invoice_principal }"
												type="text" class="w300 v2_text " />
										</div></li>

								</ul>
								<div class="v2_table_con1">
									<table id="billTb">
										<tr>
											<th width="50"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
											<th width="200"><spring:message code="sys.v2.client.tradeName"/><!-- 商品名称 --></th>
											<th><spring:message code="sys.v2.client.standard"/><!-- 规格 --></th>
											<th><spring:message code="sys.v2.client.unit"/><!-- 单位 --></th>
											<th><spring:message code="sys.v2.client.quantity"/><!-- 数量 --></th>
											<th><spring:message code="sys.v2.client.unitPrice"/><!-- 单价 --></th>
											
										</tr>
										<c:forEach var="list" items="${accountsReceivableBillCommoditiesList}" varStatus="index">
											<tr>
												<td>${index.count }</td>
												<td>${list.name_ }</td>
												<td>${list.standard_ }</td>
												<td>${list.unit_ }</td>
												<td>${list.quantity_ }</td>
												<td><fmt:formatNumber value="${list.price_ }" pattern="##0.00" maxFractionDigits="2"/></td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<ul>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone">
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableBillAttaList}">
							                    		<c:if test="${not empty attachment.url_ }">
														<dd>
							                    			<a rel="group2" href="${attachment.url_ }"><img src="${attachment.url_ }" /><i></i></a>
														</dd>
							                    		</c:if>
													</c:forEach>
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
							<div class="v2_but_list">
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--2-->
						<!--3-->
						<div class="v2_tab_con" style="display: none;">
							<div class="v2_text_box">
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.trackingNumber"/><!-- 运输单号 -->：</span><input 
												value="${accountsReceivableTransportation.number_ }"
												type="text" class="w300 v2_text" />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.deliveryDate"/><!-- 发货日期 -->：</span>
											<div class="v2_date">
												<input date="true" id="transportation_date"
													value="${accountsReceivableTransportation.transportation_date }"
													type="text" class="w300 v2_text" /><a
													class="v2_date_text_ico "></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.descriptionOfGoods"/><!-- 货物名称 -->：</span><input 
												value="${accountsReceivableTransportation.name_ }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.transportationCost"/><!-- 运输费用 -->：</span><input 
												value="<fmt:formatNumber value="${accountsReceivableTransportation.transportation_cost }" pattern="##0.00" maxFractionDigits="2"/>"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.sender"/><!-- 寄件人 -->：</span><input 
												value="${accountsReceivableTransportation.send_name }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.recipients"/><!-- 收件人 -->：</span><input 
												value="${accountsReceivableTransportation.collect_name }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.address"/><!-- 地址 -->：</span><input 
												value="${accountsReceivableTransportation.send_address }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.address"/><!-- 地址 -->：</span><input 
												value="${accountsReceivableTransportation.collect_address }"
												type="text" class="w300 v2_text "  />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.phone"/><!-- 电话 -->：</span><input 
												value="${accountsReceivableTransportation.send_phone }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.phone"/><!-- 电话 -->：</span><input 
												value="${accountsReceivableTransportation.collect_phone }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.carrier"/><!-- 运输人 -->：</span><input 
												value="${accountsReceivableTransportation.transportation_name }"
												type="text" class="w300 v2_text " />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.carrier.phone"/><!-- 运输人电话 -->：</span><input 
												value="${accountsReceivableTransportation.transportation_phone }"
												type="text" class="w300 v2_text" />
										</div></li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.remark"/><!-- 备注 -->：</span>
											<textarea class="v2_text_tea h100 w890" readonly="readonly">${accountsReceivableTransportation.number_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone">
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableTransportationAttaList}">
							                    		<c:if test="${not empty attachment.url_ }">
														<dd>
							                    			<a rel="group3" href="${attachment.url_ }"><img src="${attachment.url_ }" /><i ></i></a>
														</dd>
							                    		</c:if>
							                    	</c:forEach>
												</dl>
											</div>
										</div>
									</li>
								</ul>

							</div>
							<div class="v2_but_list">
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--3-->
						<!--4-->
						<div class="v2_tab_con" style="display: none;">
							<div class="v2_text_box">
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.title"/><!-- 标题 -->：</span><input value="${accountsReceivable.title_ }"
												type="text" class="w300 v2_text" />
										</div></li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.content"/><!-- 内容 -->：</span>
											<textarea class="v2_text_tea h100 w890 " readonly="readonly">${accountsReceivable.content_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone">
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableAttaList}">
							                    		<c:if test="${not empty attachment.url_ }">
														<dd>
							                    			<a rel="group4" href="${attachment.url_ }"><img src="${attachment.url_ }" /><i ></i></a>
														</dd>
							                    		</c:if>
							                    	</c:forEach>
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
							<div class="v2_but_list">
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--4-->
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- 下载 -->
	<form action="/fileUploadController/fileDownload" id="download" style="disblay:none" target="_hide">
		<input type="hidden" name="newName" id="newName"/>
		<input type="hidden" name="oldName" id="oldName"/>
		<input type="hidden" name="workingDir" value="factorAudit"/>
	</form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
	<!-- 图片上传 部分 start -->
	<iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
	<form style="display:none;" id="common_upload_form"
		enctype="multipart/form-data" method="post" target="common_iframe">
		<input id="common_upload_btn" type="file" name="file" style="display:none;" />
	</form>
	<!-- 图片上传 部分 end -->
</body>
</html>