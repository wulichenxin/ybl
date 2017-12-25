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
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<title>云保理</title>
<script type="text/javascript">

function func(){
	 //获取被选中的option标签
	 var  contract_id= $('#contract_id option:selected').val();
	 $.ajax({
	        url: '/accountsReceivableManageController/queryContract', 
	        data:{id:contract_id},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//查询成功
	        		//给保理商、供应商、核心企业赋值
	        		$(".factor_enterprise_name").val(data.object.result.factorEnterprise.enterprise_name);
	        		$(".core_enterprise_name").val(data.object.result.coreEnterprise.enterprise_name);
	        		$(".supplier_enterprise_name").val(data.object.result.supplierEnterprise.enterprise_name);
	        		$("#contract_usable_amount").val(data.object.result.contract.usable_credit_amount);
	        		$("#factoring_enterprise_id").val(data.object.result.factorEnterprise.id_);
	        		$("#core_enterprise_id").val(data.object.result.coreEnterprise.id_);
	        		$("#supplier_enterprise_id").val(data.object.result.supplierEnterprise.id_);
	        		$("#settlement_ratio").val(data.object.result.contract.settlement_ratio);
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
	 
	}

	$(function() {
		//账款录入页面点击图标显示日期
		$('#invoice_date_a').on('click', function () {
		    $('#invoice_date').datetimepicker('show');
		});
		$('#return_date_a').on('click', function () {
		    $('#return_date').datetimepicker('show');
		});
		$('#bill_invoice_date_a').on('click', function () {
		    $('#bill_invoice_date').datetimepicker('show');
		});
		$('#transportation_date_a').on('click', function () {
		    $('#transportation_date').datetimepicker('show');
		});
		
		//先判断是否是详情页，如果是详情页则不做此判断
		var operator = $("#operator").val()
		if(operator != "query"){
			//判断凭证金额是否大于可用余额 
			$("#voucher_amount").mouseout(function(){
				var amount = $("#voucher_amount").val();
				var contract_usable_amount = $("#contract_usable_amount").val();
				var settlement_ratio = $("#settlement_ratio").val();
				if(eval(amount * settlement_ratio / 100) >= eval(contract_usable_amount )){
					alert("结算金额不得大于可用授信额度");
					$("#voucher_amount").val("");
				}
			})
		}
		
		
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
		

		//监听图片上传按钮
		fileInputChange = function() {
			$("#common_upload_btn").watchProperty("value",function() {
				var v = $(this).val();
				if (v == '' || v == null)
					return;
				// 上传
				$("#common_upload_form").attr("action","/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
				$("#common_upload_form").submit();
			});
		};
		fileInputChange();
		//点击图片上传图片
		$("#addPicture1,#addPicture2,#addPicture3,#addPicture4").click(function() {
			id = $(this).attr("id");
			var str = id.charAt(id.length - 1);
			$("#str").val(str);
			$("#common_upload_btn").click();
			
		});

		//回调，回显图片
		uploadCallback = function(attachment) {
			//atachmentArray += attachment + "#";
			attach = eval("(" + attachment + ")");
			$("#"+id).parent().last().before("<dd > <a><img src='"+attach.url_ +"'/><i onclick='deleteAttachment(this,null)' value="+ attachment + id +"></i></a></dd>");
			$("#common_upload_btn").remove();
			$("#common_upload_form").append('<input id="common_upload_btn" type="file" name="file" style="display: none;" />');
			fileInputChange();
		}
		
		
		//图片上传end
		//删除上传的文件
		deleteAttachment = function(_this,id) {
			$(_this).parent().parent().remove();
			if(id){
				var attachmentId = $("#deleteAttachmentIdArray").val();
				attachmentId += id + "#"
				$("#deleteAttachmentIdArray").val(attachmentId);
			}
		}

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
			maxDate : 0 // and tommorow is maximum date calendar
		};
		
		var dmf1 = {
				yearOffset : 0,
				lang : 'ch',
				timepicker : false,
				format : 'Y-m-d',
				formatDate : 'Y-m-d',
				minDate : 0, // yesterday is minimum date
				maxDate : '2050-01-01'  // and tommorow is maximum date calendar
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
		$('#return_date').datetimepicker(dmf1);
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
		
		//运输开票日期
		$('#transportation_date').datetimepicker(dmf);
		var transportation_date = $("#transportation_date").val();
		if (transportation_date) {
			var fmtDate = new Date();
			fmtDate.setTime(transportation_date);
			$("#transportation_date").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
		}
		

		//初始化日期控件end
	})
	
$(function() {
	
	//凭证商品增加行
	$("#voucherAddRow").click(function(){
		var vouTb_length = $("#vouTb").find(".voutr").length;
		var vouTb_tr = $("#vouTb").find("tr").length;
		var td1 = $("<td>"+vouTb_tr+"</td>");
		var td2 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[20]]' name='voucherCommoditiesList["+(vouTb_tr - vouTb_length)+"].voucherCommoditiesName'/>"+"</td>");
		var td3 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[20]]' name='voucherCommoditiesList["+(vouTb_tr - vouTb_length)+"].voucherCommoditiesStandard'/>"+"</td>");
		var td4 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[10]]' name='voucherCommoditiesList["+(vouTb_tr - vouTb_length)+"].voucherCommoditiesUnit'/>"+"</td>");
		var td5 = $("<td>"+"<input type='text' class='w100 v2_text validate[custom[number],maxSize[10]]' name='voucherCommoditiesList["+(vouTb_tr - vouTb_length)+"].voucherCommoditiesQuantity'/>"+"</td>");
		var td6 = $("<td>"+"<input type='text' class='w100 v2_text validate[custom[number],maxSize[10]]' name='voucherCommoditiesList["+(vouTb_tr - vouTb_length)+"].voucherCommoditiesPrice'/>"+"</td>");
		var td7 = $("<td>"+"<a class='lan' onclick='voucherDeleteRow(this,null)'>删除</a>"+"</td>");
		var tr = $("<tr class='addVou'></tr>");
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		tr.append(td6);
		tr.append(td7);
		$("#vouTb").append(tr);
	})
	
	//发票商品增加行
	$("#billAddRow").click(function(){
		var billTb_length = $("#billTb").find(".billTr").length;
		var billTb_tr = $("#billTb").find("tr").length;
		
		var td1 = $("<td>"+billTb_tr+"</td>");
		var td2 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[20]]' name='billCommoditiesList["+(billTb_tr - billTb_length)+"].billCommoditiesName'/>"+"</td>");
		var td3 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[20]]' name='billCommoditiesList["+(billTb_tr - billTb_length)+"].billCommoditiesStandard'/>"+"</td>");
		var td4 = $("<td>"+"<input type='text' class='w100 v2_text validate[maxSize[20]]' name='billCommoditiesList["+(billTb_tr - billTb_length)+"].billCommoditiesUnit'/>"+"</td>");
		var td5 = $("<td>"+"<input type='text' class='w100 v2_text validate[custom[number],maxSize[10]]' name='billCommoditiesList["+(billTb_tr - billTb_length)+"].billCommoditiesQuantity'/>"+"</td>");
		var td6 = $("<td>"+"<input type='text' class='w100 v2_text validate[custom[number],maxSize[10]]' name='billCommoditiesList["+(billTb_tr - billTb_length)+"].billCommoditiesPrice'/>"+"</td>");
		var td7 = $("<td>"+"<a class='lan' onclick='billDeleteRow(this,null)'>删除</a>"+"</td>");
		var tr = $("<tr class='addBill'></tr>");
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		tr.append(td6);
		tr.append(td7);
		$("#billTb").append(tr);
		
		//页面整体添加增加行的高度
		$('body').height($('body').height() + 60);// 60为bottom的高度
	})
	
	//校验初始化
	var pageForm = ext.formValidation("pageForm");
	//保存按钮事件
	$("#voucher_save_all,#bill_save_all,#transportation_save_all,#account_save_all").click(function() {
		if(!validationField){
			return;
		}
		var amount = $("#voucher_amount").val();
		var contract_usable_amount = $("#contract_usable_amount").val();
		if(eval(amount) > eval(contract_usable_amount)){
			alert("凭证面额不得大于可用授信额度");
			return;
		}
		formSubmit(1);//保存提交
	});
	//保存草稿按钮 
	$("#voucher_save,#bill_save,#transportation_save,#account_save").click(function() {
		if(!validationField){
			return;
		}
		formSubmit(0);//保存草稿 
	});
	
})
	//凭证商品删除行 
	function voucherDeleteRow(obj,id){
		$(obj).parent().parent().remove();
		if(id){
			var voucherId = $("#deleteVoucherCommoditiesIdArray").val();
			voucherId +=  id + "#";
			$("#deleteVoucherCommoditiesIdArray").val(voucherId);
		}
		 
		//循环tr
		$("#vouTb").find(".addVou").each(function(i,item){
			//循环td
			$(item).find("input").each(function(){
				var name=$(this).attr("name");
				var first=name.indexOf("[");
				var last =name.indexOf("]");
				name=name.replace(name.substring(first+1,last),i);
				$(this).attr("name",name);
			})
			
			
		})
		//序号排序 
		$("#vouTb").find("tr").each(function(i){
			$(this).find("td").eq(0).html(i);
		})
		
		
	}
	
	//发票商品删除行
	function billDeleteRow(obj,id){
		$(obj).parent().parent().remove();
		if(id){
			var billId = $("#deleteBillCommoditiesIdArray").val();
			billId += id + "#";
			$("#deleteBillCommoditiesIdArray").val(billId);
		}
		
		//循环tr
		$("#billTb").find(".addBill").each(function(i,item){
			//循环td
			$(item).find("input").each(function(){
				var name=$(this).attr("name");
				var first=name.indexOf("[");
				var last =name.indexOf("]");
				name=name.replace(name.substring(first+1,last),i);
				$(this).attr("name",name);
			})
			
			
		})
		//序号排序 
		$("#billTb").find("tr").each(function(i){
			$(this).find("td").eq(0).html(i);
		})
		
		//每删除一行  减去一行的高度
		$('body').height($('body').height()-60);
	}

function formSubmit(obj){
	$("#sta").val(obj);
	var addPicture = $(".v2_vip_phone").eq(0).find("img").attr("src");
	if(addPicture == null){
		alert($.i18n.prop("sys.v2.client.upload.voucher.picture"));
		return;
	} 
	var  contract_id= $('#contract_id option:selected').val();
	
	if(contract_id == "" || contract_id == null){
		alert($.i18n.prop("sys.v2.client.pleaseSelectAcontract"));
		return;
	} 
	//定义数组attachement
	var attachmentArray = '';
	var count = $("img").size();
	for(var i=0;i<count; i++){
		attachmentArray += $("img").eq(i).next().attr("value") + "#";
	}
	$("#attachmentArray").val(attachmentArray);
	
	if(!$("#voucher_number").validationEngine('validate')) {
		return;
	}
	if(!$("#contract_id").validationEngine('validate')) {
		return;
	}
	if(!$("#voucher_amount").validationEngine('validate')) {
		return;
	}
	if(!$("#invoice_date").validationEngine('validate')) {
		return;
	}
	if(!$("#return_date").validationEngine('validate')) {
		return;
	}
	$("#voucher_save,#bill_save,#transportation_save,#account_save").hide();
	$("#voucher_save_all,#bill_save_all,#transportation_save_all,#account_save_all").hide();
	$(".subminting").removeClass('none1');
	$.ajax({
		url:"/accountsReceivableManageController/saveAll",
		data:$("form").serialize(),
		dataType:"json",
		type:"post",
		success : function(resp) {
			if (resp.responseType == 'ERROR') {
				alert(resp.info);/* 服务器繁忙请稍候重试 */
				$("#voucher_save,#bill_save,#transportation_save,#account_save").show();
				$("#voucher_save_all,#bill_save_all,#transportation_save_all,#account_save_all").show();
				$(".subminting").addClass('none1');
			} else {
				alert(resp.info,callback);/* 数据保存/更新成功 */
			}
		},
		error : function() {
			alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
			$("#voucher_save,#bill_save,#transportation_save,#account_save").show();
			$("#voucher_save_all,#bill_save_all,#transportation_save_all,#account_save_all").show();
			$(".subminting").addClass('none1');
		}
	});
	

	callback = function() {
		location.href="/accountsReceivableManageController/queryList.htm";
	}
}
</script>
</head>
<body>

	<!--top start -->
	<div class="v2_top_bg h116">
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	</div>
	<!--top end -->

	<!---->
	<form id="pageForm" method="post">
		<div class="v2_vip_conbody">
			<div class="v2_path_no"><spring:message code="sys.v2.client.location"/>：<spring:message code="sys.v2.client.account.input"/> >  <spring:message code="sys.v2.client.addAccount"/></div>
			<div class="v2_box_border mt20">
			
			<input type="hidden" id="factoring_enterprise_id" name="factoringEnterpriseId" value="${factorEnterprise.id_ }"/> 	<!-- 保理商id -->
			<input type="hidden" id="core_enterprise_id" name="coreEnterpriseId" value="${coreEnterprise.id_ }" />   	    <!-- 核心企业id -->
			<input type="hidden" id="supplier_enterprise_id" name="supplierEnterpriseId" value="${supplierEnterprise.id_ }"/>	<!-- 供应商id -->
			<input type="hidden" id="attachmentArray" name="attachmentArray"/>               <!-- 所有附件 --> 
			<input type="hidden" id="deleteAttachmentIdArray" name="deleteAttachmentIdArray">  <!-- 要删除的附件id -->
			<input type="hidden" id="deleteBillCommoditiesIdArray" name="deleteBillCommoditiesIdArray">  <!-- 要删除的发票商品id -->
			<input type="hidden" id="deleteVoucherCommoditiesIdArray" name="deleteVoucherCommoditiesIdArray">  <!-- 要删除的凭证商品id -->
			<input type="hidden" value="${id }" name="accountsReceivableId"/>                  <!-- 账款id,用来判断新增还是修改 -->
			<input type="hidden" value="${accountsReceivableBill.accounts_receivable_id }" name="accountsReceivableBillId"/>     <!-- 账款发票id,用来判断新增还是修改 -->
			<input type="hidden" value="${accountsReceivableVoucher.accounts_receivable_id }" name="accountsReceivableVoucherId"/>  <!-- 账款凭证id,用来判断新增还是修改 -->
			<input type="hidden" value="${accountsReceivableTransportation.accounts_receivable_id }" name="accountsReceivableTransportationId"/>  <!-- 账款运输id,用来判断新增还是修改 -->
			<input type="hidden" name="sta" id="sta"/>
			<input type="hidden" name="operator" id="operator" value="${operator}"/>
			<input type="hidden" id="str" ><!-- 获取点击上传图片的顺序 -->
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
											<span><spring:message code="sys.v2.client.voucherNumber"/><!-- 凭证号码 -->：</span><input id="voucher_number" name="voucherNumber" type="text"
												class="w300 v2_text validate[required]"
												value="${accountsReceivableVoucher.number_ }" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.contractNO"/><!-- 合同编号 -->：</span>
											<select class="v2_select w320 validate[required]" onchange="func()" <c:if test="${operator eq 'query' }">disabled=disabled</c:if>
												name="contractId" id="contract_id"
												url="/accountsReceivableManageController/toSaveaccountsReceivable" valueField="id_"
												textField="number_" defaultValue="${contract.id_ }"
												isSelect="Y">
											</select>
											
										</div></li>
									<li class="clear"><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.voucher.amount"/><!-- 凭证票面金额 -->：</span><input
												id="voucher_amount" name="voucherAmount" type="text"
												class="w300 v2_text validate[custom[number],required,min[0.01],minSize[1],maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if>
												value="<fmt:formatNumber value="${accountsReceivableVoucher.amount_ }" pattern="##0.00" maxFractionDigits="2"/>" /><spring:message code="sys.v2.client.element" />
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
													type="text" class="w300 v2_text validate[required,past[now]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> /><a
													class="v2_date_text_ico"   <c:if test="${operator ne 'query' }">id="invoice_date_a"</c:if>></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.expectTheReceivable"/><!-- 预计回款日期 -->：</span>
											<div class="v2_date">
												
												<input date="true" id="return_date" name="returnDate" value="${accountsReceivableVoucher.return_date }"
													type="text" class="w300 v2_text validate[required,future[now]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
													<a class="v2_date_text_ico" <c:if test="${operator ne 'query' }">id="return_date_a"</c:if> ></a>
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
									<div class="table_top ">
								         <div class="v2_table_nav mb10">
								         		<c:if test="${operator ne 'query' }">
													<ul>
														<li><a id="voucherAddRow" class="v2_but_add"><spring:message code="sys.v2.client.addRow"/><!-- 添加行 --></a></li>
													</ul>
								         		</c:if>
											</div>
									 </div>
									
									<table id="vouTb">
										<tr class="voutr">
											<th width="50"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
											<th width="200"><spring:message code="sys.v2.client.tradeName"/><!-- 商品名称 --></th>
											<th><spring:message code="sys.v2.client.standard"/><!-- 规格 --></th>
											<th><spring:message code="sys.v2.client.unit"/><!-- 单位 --></th>
											<th><spring:message code="sys.v2.client.quantity"/><!-- 数量 --></th>
											<th><spring:message code="sys.v2.client.unitPrice"/><!-- 单价 --></th>
											<c:if test="${operator ne 'query' }">
												<th width="200"><spring:message code="sys.v2.client.operation"/><!-- 操作 --></th>
											</c:if>
										</tr>
										<c:forEach var="list" items="${accountsReceivableVoucherCommoditiesList}" varStatus="index">
											<tr class="voutr">
												<td>${index.count }</td>
												<td>${list.name_ }</td>
												<td>${list.standard_ }</td>
												<td>${list.unit_ }</td>
												<td>${list.quantity_ }</td>
												<td><fmt:formatNumber value="${list.price_ }" pattern="##0.00" maxFractionDigits="2"/></td>
												<c:if test="${operator ne 'query' }">
													<td><a class='lan' onclick='voucherDeleteRow(this,${list.id_ })' ><spring:message code="sys.v2.client.delete"/></a></td>
												</c:if>
											</tr>
										</c:forEach>
									</table>
								</div>
								<ul>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.remark"/><!-- 备注 -->：</span>
											<textarea class="v2_text_tea h100 w890" name="voucherRemark" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> id="voucher_remark">${accountsReceivableVoucher.remark_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone" >
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableVoucherAttaList}">
													<dd>
							                    		<c:if test="${not empty attachment.url_ }">
							                    			<a><img src="${attachment.url_ }" /> <c:if test="${operator ne 'query' }"><i onclick='deleteAttachment(this,${attachment.id_ })'></i></c:if></a>
							                    		</c:if>
													</dd>
													</c:forEach>
													<c:if test="${operator ne 'query' }">
														<dd><a id="addPicture1" ></a></dd>
													</c:if>
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
							<div class="v2_text_box">
								<h1 class="red"><spring:message code="sys.v2.client.useable.amount"/><!-- 可用额度 --></h1>
								<div>
									<input id="contract_usable_amount"  type="text" class="w300 v2_text" disabled="disabled" value="<fmt:formatNumber value="${contract.usable_credit_amount }" pattern="##0.00" maxFractionDigits="2"/>"/>&nbsp;<spring:message code="sys.v2.client.element"/>
									<input id="settlement_ratio" type="hidden" value="${contract.settlement_ratio }">
								</div>
							</div>
							<div class="v2_but_list">
								<c:if test="${accountsReceivable.status_ == '' || accountsReceivable.status_ == null || accountsReceivable.status_ == 'draft'}">
									<a class="bg_l" id="voucher_save"><spring:message code="sys.v2.client.saveDraft"/><!-- 保存草稿 --></a>
									<a class="bg_l" id="voucher_save_all"><spring:message code="sys.v2.client.saveAndSubmit"/><!-- 保存并提交 --></a>
									<a class="bg_l subminting none1" ><spring:message code="sys.v2.client.submiting"/><!-- 保存并提交 --></a>
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
											<input value="${accountsReceivableBill.number_ }" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> type="text" name="billNumber" id="bill_number" class="w300 v2_text validate[maxSize[50]]" />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoice.amount"/><!-- 发票票面金额 -->：</span>
											<input id="bill_amount" name="billAmount" <c:if test="${operator eq 'query' }">disabled=disabled</c:if>
												value="<fmt:formatNumber value="${accountsReceivableBill.amount_ }"  pattern="##0.00" maxFractionDigits="2"/>" type="text"
												class="w300 v2_text validate[custom[number],min[0.01],maxSize[20]]" /><spring:message code="sys.v2.client.element" />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoice"/><!-- 联次 -->：</span>
											<div class="v2_select_box">
												<select class="v2_select w320" onchange="func()" <c:if test="${operator eq 'query' }">disabled=disabled</c:if>
													name="billType" id="type_"
													url="/configController/get-BILL_TYPE" valueField="code_"
													textField="value_" defaultValue="${accountsReceivableBill.type_ }"
													isSelect="Y">
												</select>
											</div>
										</div>
									</li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceDate"/><!-- 开票日期 -->：</span>
											<div class="v2_date">
												<input date="true" id="bill_invoice_date" name="billInvoiceDate" value="${accountsReceivableBill.invoice_date }"
													type="text" class="w300 v2_text validate[past[now]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> /><a
													class="v2_date_text_ico" <c:if test="${operator ne 'query' }">id="bill_invoice_date_a"</c:if> ></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.supplier"/><!-- 供应商 -->：</span><input
												disabled="disabled"
												value="${supplierEnterprise.enterprise_name }" type="text"
												class="w300 v2_text_gary supplier_enterprise_name validate[maxSize[50]]" />
										</div></li>
									<li>
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.core.enterprise"/><!-- 企业名称 -->：</span> <input disabled="disabled"
												value="${coreEnterprise.enterprise_name }" type="text" 
												class="w300 v2_text_gary core_enterprise_name validate[maxSize[50]]" />
										</div>
									</li>
									<li class="clear"><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoiceIssuingEntity"/><!-- 开票单位 -->：</span><input id="invoice_issuing_entity" name="invoiceIssuingEntity"
												value="${accountsReceivableBill.invoice_issuing_entity }"
												type="text" class="w300 v2_text validate[maxSize[50]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.invoicePeople"/><!-- 开票负责人 -->：</span><input id="invoice_principal" name="invoicePrincipal"
												value="${accountsReceivableBill.invoice_principal }"
												type="text" class="w300 v2_text validate[maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>

								</ul>
								<div class="v2_table_con1">
									<table id="billTb">
										<div class="table_top ">
									         <div class="v2_table_nav mb10">
									         	<c:if test="${operator ne 'query' }">
													<ul>
														<li><a class="v2_but_add" id="billAddRow"><spring:message code="sys.v2.client.addRow"/><!-- 添加行 --></a></li>
													</ul>
									         	</c:if>	
												</div>
										 </div>
										
										<tr class="billTr">
											<th width="50"><spring:message code="sys.v2.client.no"/><!-- 序号 --></th>
											<th width="200"><spring:message code="sys.v2.client.tradeName"/><!-- 商品名称 --></th>
											<th><spring:message code="sys.v2.client.standard"/><!-- 规格 --></th>
											<th><spring:message code="sys.v2.client.unit"/><!-- 单位 --></th>
											<th><spring:message code="sys.v2.client.quantity"/><!-- 数量 --></th>
											<th><spring:message code="sys.v2.client.unitPrice"/><!-- 单价 --></th>
											<c:if test="${operator ne 'query' }">
												<th width="200"><spring:message code="sys.v2.client.operation"/><!-- 操作 --></th>
											</c:if>
										</tr>
										<c:forEach var="list" items="${accountsReceivableBillCommoditiesList}" varStatus="index">
											<tr class="billTr">
												<td>${index.count }</td>
												<td>${list.name_ }</td>
												<td>${list.standard_ }</td>
												<td>${list.unit_ }</td>
												<td>${list.quantity_ }</td>
												<td><fmt:formatNumber value="${list.price_ }" pattern="##0.00" maxFractionDigits="2"/></td>
												<c:if test="${operator ne 'query' }">
													<td><a class='lan' onclick='billDeleteRow(this,${list.id_ })'><spring:message code="sys.v2.client.delete"/></a></td>
												</c:if>
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
													<dd>
							                    		<c:if test="${not empty attachment.url_ }">
							                    			<a><img src="${attachment.url_ }" /><c:if test="${operator ne 'query' }"><i onclick='deleteAttachment(this,${attachment.id_ })'></i></c:if></a>
							                    		</c:if>
													</dd>
													</c:forEach>
													<c:if test="${operator ne 'query' }">
														<dd><a id="addPicture2" class='add_picture_a'></a></dd>
													</c:if>
													
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
							<div class="v2_but_list">
							<c:if test="${accountsReceivable.status_ == '' || accountsReceivable.status_ == null || accountsReceivable.status_ == 'draft'}">
								<a class="bg_l" id="bill_save"><spring:message code="sys.v2.client.saveDraft"/><!-- 保存草稿 --></a>
								<a class="bg_l" id="bill_save_all"><spring:message code="sys.v2.client.saveAndSubmit"/><!-- 保存并提交 --></a>
								<a class="bg_l subminting none1" ><spring:message code="sys.v2.client.submiting"/><!-- 提交中 --></a>
							</c:if>
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--2-->
						<!--3-->
						<div class="v2_tab_con" style="display: none;">
							<div class="v2_text_box">
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.trackingNumber"/><!-- 运输单号 -->：</span><input id="transportation_number" name="transportationNumber"
												value="${accountsReceivableTransportation.number_ }"
												type="text" class="w300 v2_text validate[maxSize[50]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if>/>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.deliveryDate"/><!-- 发货日期 -->：</span>
											<div class="v2_date">
												<input date="true" id="transportation_date" name="transportationDate"
													value="${accountsReceivableTransportation.transportation_date }"
													type="text" class="w300 v2_text validate[past[now]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
													<a class="v2_date_text_ico"></a>
											</div>
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.descriptionOfGoods"/><!-- 货物名称 -->：</span><input id="transportation_name" name="transportationName"
												value="${accountsReceivableTransportation.name_ }"
												type="text" class="w300 v2_text validate[maxSize[50]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.transportationCost"/><!-- 运输费用 -->：</span><input id="transportation_cost" name="transportationCost"
												value="<fmt:formatNumber value="${accountsReceivableTransportation.transportation_cost }" pattern="##0.00" maxFractionDigits="2"/>"
												type="text" class="w300 v2_text validate[custom[number],min[0.01],minSize[1],maxSize[10]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.sender"/><!-- 寄件人 -->：</span><input id="send_name" name="sendName"
												value="${accountsReceivableTransportation.send_name }"
												type="text" class="w300 v2_text validate[maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.recipients"/><!-- 收件人 -->：</span><input id="collect_name" name="collectName"
												value="${accountsReceivableTransportation.collect_name }"
												type="text" class="w300 v2_text validate[maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.sender"/><spring:message code="sys.v2.client.address"/><!-- 地址 -->：</span><input id="send_address" name="sendAddress"
												value="${accountsReceivableTransportation.send_address }"
												type="text" class="w300 v2_text validate[maxSize[50]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.recipients"/><spring:message code="sys.v2.client.address"/><!-- 地址 -->：</span><input id="collect_address" name="collectAddress"
												value="${accountsReceivableTransportation.collect_address }"
												type="text" class="w300 v2_text validate[maxSize[50]]"  <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.sender"/><spring:message code="sys.v2.client.phone"/><!-- 电话 -->：</span><input id="send_phone" name="sendPhone"
												value="${accountsReceivableTransportation.send_phone }"
												type="text" class="w300 v2_text validate[phone]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.recipients"/><spring:message code="sys.v2.client.phone"/><!-- 电话 -->：</span><input id="collect_phone" name="collectPhone"
												value="${accountsReceivableTransportation.collect_phone }"
												type="text" class="w300 v2_text validate[phone]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.carrier"/><!-- 运输人 -->：</span><input id="transportation_people_name" name="transportationPeopleName"
												value="${accountsReceivableTransportation.transportation_name }"
												type="text" class="w300 v2_text validate[maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.carrier.phone"/><!-- 运输人电话 -->：</span><input id="transportation_phone" name="transportationPhone"
												value="${accountsReceivableTransportation.transportation_phone }"
												type="text" class="w300 v2_text validate[phone]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.remark"/><!-- 备注 -->：</span>
											<textarea class="v2_text_tea h100 w890  validate[maxSize[500]]" id="transportation_remark" name="transportationRemark" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> >${accountsReceivableTransportation.number_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone">
												<dl>
													<c:forEach var="attachment" items="${accountsReceivableTransportationAttaList}">
													<dd>
							                    		<c:if test="${not empty attachment.url_ }">
							                    			<a><img src="${attachment.url_ }" /><c:if test="${operator ne 'query' }"><i onclick='deleteAttachment(this,${attachment.id_ })'></i></c:if></a>
							                    		</c:if>
													</dd>
													</c:forEach>
													<c:if test="${operator ne 'query' }">
														<dd><a id="addPicture3" class='add_picture_a'></a></dd>
													</c:if>
													
												</dl>
											</div>
										</div>
									</li>
								</ul>

							</div>
							<div class="v2_but_list">
								<c:if test="${accountsReceivable.status_ == '' || accountsReceivable.status_ == null || accountsReceivable.status_ == 'draft'}">
								<a class="bg_l" id="transportation_save"><spring:message code="sys.v2.client.saveDraft"/><!-- 保存草稿 --></a>
								<a class="bg_l" id="transportation_save_all"><spring:message code="sys.v2.client.saveAndSubmit"/><!-- 保存并提交 --></a>
								<a class="bg_l subminting none1" ><spring:message code="sys.v2.client.submiting"/><!-- 提交中 --></a>
								</c:if>
								<a class="bg_g" href="javascript:history.go(-1);"><spring:message code="sys.v2.client.cancel"/><!-- 取消 --></a>
							</div>
						</div>
						<!--3-->
						<!--4-->
						<div class="v2_tab_con" style="display: none;">
							<div class="v2_text_box">
								<ul>
									<li><div class="v2_input_box">
											<span><spring:message code="sys.v2.client.title"/><!-- 标题 -->：</span><input id="title" name="title" value="${accountsReceivable.title_ }"
												type="text" class="w300 v2_text validate[maxSize[20]]" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> />
										</div></li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.content"/><!-- 内容 -->：</span>
											<textarea id="content" name="content" <c:if test="${operator eq 'query' }">disabled=disabled</c:if> class="v2_text_tea h100 w890 validate[maxSize[500]]">${accountsReceivable.content_ }</textarea>
										</div>
									</li>
									<li class="ww100">
										<div class="v2_input_box">
											<span><spring:message code="sys.v2.client.uploadAttachment"/><!-- 上传附件 -->：</span>
											<div class="v2_vip_phone">
												<dl>
													
													<c:forEach var="attachment" items="${accountsReceivableAttaList}">
													<dd>
							                    		<c:if test="${not empty attachment.url_ }">
							                    			<a><img src="${attachment.url_ }" /><c:if test="${operator ne 'query' }"><i onclick='deleteAttachment(this,${attachment.id_ })'></i></c:if></a>
							                    		</c:if>
													</dd>
													</c:forEach>
													<c:if test="${operator ne 'query' }">
														<dd><a id="addPicture4" class='add_picture_a'></a></dd>
													</c:if>
												</dl>
											</div>
										</div>
									</li>
								</ul>
							</div>
								<div class="v2_but_list">
									<c:if test="${accountsReceivable.status_ == '' || accountsReceivable.status_ == null || accountsReceivable.status_ == 'draft'}">
										<a class="bg_l" id="account_save"><spring:message code="sys.v2.client.saveDraft"/><!-- 保存草稿 --></a>
										<a class="bg_l" id="account_save_all"><spring:message code="sys.v2.client.saveAndSubmit"/><!-- 保存并提交 --></a>
										<a class="bg_l subminting none1" ><spring:message code="sys.v2.client.submiting"/><!-- 提交中 --></a>
									</c:if>
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
	<%@include file="/ybl/v2/admin/common/bottom.jsp" %>
	<!-- bottom.jsp -->

	<!--弹出窗登录-->

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
