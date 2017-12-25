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
<!--日期控件 -->
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/jquery.dragndrop_v2.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/v2/js/jquery.msgbox_v2.js"></script>
<title>云保理</title>
<script type="text/javascript">

	$(function() {
		
		view = function(urls) {
			$.msgbox({
				height : 520,
				width : 800,
				content : '/ybl/v2/admin/common/preview.jsp?urls=' + urls,
				type : 'iframe',
				title : $.i18n.prop('sys.v2.client.voucher.attachment'),/*凭证附件*/
			});
		}

		$("a[rel=group1]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group2]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group3]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		$("a[rel=group4]").fancybox({
			'transitionIn'  :   'elastic',  
	        'transitionOut' :   'elastic',  
	        'speedIn'       :   600,   
	        'speedOut'      :   200,   
	        'overlayShow'   :   false  
		});
		//文本框设为只读
		$("input").attr("readonly","readonly");
		$("select").attr("readonly","readonly");
		
		//tab切换
		$('.v2_t_nav dl dd').click(
			function() {
				index = $(this).index();
				$('.v2_tab_con').eq(index).show().addClass('now').siblings().removeClass('now').hide();
				$('.v2_tab dl dd').eq(index).addClass('now').siblings().removeClass('now');
				//bottom高度
				var min_height = $('.v2_tab_con').eq(index).height();
				$(window).scroll(function() {
					//获取窗口的滚动条的垂直位置      
					var s = $(window).height();
					//当窗口的滚动条的垂直位置大于页面的最小高度时 
					if (s < min_height) {
						$(".v2_foot_bottom").removeClass("v2_foot_pos");
					} else {
					   $(".v2_foot_bottom").addClass("v2_foot_pos");
					};
				});
				if($(".v2_foot_bottom")) {
					$('body').height(min_height + 378);// 60为bottom的高度
				}
			});
		

		/**
		 * 初始化日期控件start
		 */
		var dmf = {
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		};
		
		//初始化日期控件start
		//凭证开票日期
		$('#invoice_date').datetimepicker(dmf);
		var invoice_date = $("#invoice_date").val();
		if (invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(invoice_date);
			$("#invoice_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		// 预计回款日期
		$('#return_date').datetimepicker(dmf);
		var return_date = $("#return_date").val();
		if (return_date) {
			var fmtDate = new Date();
			fmtDate.setTime(return_date);
			$("#return_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		
		//发票开票日期
		$('#bill_invoice_date').datetimepicker(dmf);
		var bill_invoice_date = $("#bill_invoice_date").val();
		if (bill_invoice_date) {
			var fmtDate = new Date();
			fmtDate.setTime(bill_invoice_date);
			$("#bill_invoice_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		
		//运输日期 
		$('#transportation_date').datetimepicker(dmf);
		var transportation_date = $("#transportation_date").val();
		if (transportation_date) {
			var fmtDate = new Date();
			fmtDate.setTime(transportation_date);
			$("#transportation_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		//初始化日期控件end
		
		//审核按钮事件
		$("#voucher_audit,#bill_audit,#transportation_audit,#account_audit").click(function() {
			var accountId = ${id };
			$.msgbox({
				height : 450,
				width : 620,
				content : '/accountsAffirmController/audit?accountId='+accountId,
				type : 'iframe',
				title : $.i18n.prop("sys.v2.client.auditOperator")
			});
			
		});
	})
	
</script>
</head>
<body>
	<div class="v2_top_bg h116 v2_t_bg1">
	<div class="v2_top_con">
		<div class="v2_head_top">
		<!--top start -->
		<%@ include file="/ybl/v2/admin/common/top.jsp"%>
		<!--top end -->
		<div class="v2_head_line"></div>
		</div>
		<!---->
		
	</div>	
</div>

	<!---->
	<form id="pageForm" method="post">
		<div class="v2_vip_conbody">
			<div class="v2_path_no"><spring:message code="sys.v2.client.location"/>：<spring:message code="sys.v2.client.account.input"/> >  <spring:message code="sys.v2.client.addAccount"/></div>
			<div class="v2_box_border mt20">
			
			<input type="hidden" value="${id }" id="" name="accountsReceivableId"/>    <!-- 账款id,用来判断新增还是修改 -->
			
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
													type="text" class="w300 v2_text  />
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
								<h1><spring:message code="sys.v2.client.amountQuery"/><!-- 额度查询 --></h1>
								<div>
									<input id="contract_usable_amount"  type="text" class="w300 v2_text" disabled="disabled" value="<fmt:formatNumber value="${contract.usable_credit_amount }" pattern="##0.00" maxFractionDigits="2"/>"/>&nbsp;<spring:message code="sys.v2.client.element"/>
								</div>
							</div>
							<div class="v2_but_list">
								<a class="bg_l" id="voucher_audit"><spring:message code="sys.v2.client.auditOperator"/><!-- 审核 --></a>
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
								<a class="bg_l" id="bill_audit"><spring:message code="sys.v2.client.auditOperator"/><!-- 审核 --></a>
								
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
								<a class="bg_l" id="transportation_audit"><spring:message code="sys.v2.client.auditOperator"/><!-- 审核 --></a>
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
							                    			<a rel="group4" href="${attachment.url_}"><img src="${attachment.url_ }" /><i ></i></a>
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
								<a class="bg_l" id="account_audit"><spring:message code="sys.v2.client.auditOperator"/><!-- 审核 --></a>
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--4-->
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- bottom.jsp -->
	<jsp:include page="/ybl/v2/admin/common/bottom.jsp" />
	<!-- bottom.jsp -->

	<!--弹出窗登录-->

</body>


</html>
