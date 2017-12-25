$(function() {

	Date.prototype.format = function(fmt) {
		var o = {
			"M+" : this.getMonth() + 1, // 月份
			"d+" : this.getDate(), // 日
			"h+" : this.getHours(), // 小时
			"m+" : this.getMinutes(), // 分
			"s+" : this.getSeconds(), // 秒
			"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
			"S" : this.getMilliseconds()
		// 毫秒
		};
		if (/(y+)/.test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		}
		for ( var k in o) {
			if (new RegExp("(" + k + ")").test(fmt)) {
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
			}
		}
		return fmt;
	}

	viewMaterial = function(urls, name) {
		materialId = materialId;
		// 获取贷款材料名称
		$.msgbox({
			height : 520,
			width : 800,
			// content : '/loanApplicationController/showMaterialPic?url=' +
			// url,
			content : '/ybl/admin/common/preview.jsp?urls=' + urls,
			type : 'iframe',
			title : name,
		});
	}

	view = function(urls) {
		$.msgbox({
			height : 520,
			width : 800,
			content : '/ybl/admin/common/preview.jsp?urls=' + urls,
			type : 'iframe',
			title : $.i18n.prop('sys.client.voucher.attachment'),/*凭证附件*/
		});
	}
	/**
	 * 图片上传statrt
	 */
	// 监听图片上传按钮
	$("#common_upload_btn")
			.watchProperty(
					"value",
					function() {
						var v = $(this).val();
						if (v == '' || v == null)
							return;
						// 上传
						$("#common_upload_form")
								.attr("action",
										"/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
						$("#common_upload_form").submit();
					});

	var materialId = '';// 当前操作的贷款材料id 保存为添加附件信息使用 business_id
	// 点击图片上传图片
	$(".upLoadMaterialPic").click(function() {
		materialId = $(this).attr("materialId");

		$("#common_upload_btn").click();

	});

	// 保存上传的附件信息和材料id
	var myArray = '';
	// 回调，回显图片
	uploadCallback = function(attachment) {
		var materialName = $("#upLoadMaterialPic" + materialId).attr(
				"materialName");
		attachment = eval("(" + attachment + ")");
		$("#upLoadMaterialPic" + materialId).attr(
				"href",
				"javascript:viewMaterial('" + attachment.url_ + "','"
						+ materialName + "');");
		$("#upLoadMaterialPic" + materialId).parent().parent().prev().text(
				new Date().format("yyyy-MM-dd hh:mm"));
		$("#upLoadMaterialPic" + materialId).removeClass("none1");
		attachment.attribute1 = materialId;

		console.log(" first :" + JSON.stringify(attachment));
		/* 如果重复上传,则删除上次上传的图片 */
		var flag = false;// 是否重复提交标识
		var attacheArray = myArray.split("#");
		if (myArray && attacheArray.length > 0) {
			for (var i = 0; i < attacheArray.length; i++) {
				if (attacheArray[i]) {
					var attach = eval("(" + attacheArray[i] + ")");
					console.log(" second :" + JSON.stringify(attach));
					if (materialId == attach.attribute1) {
						attacheArray.splice(i, 1);
						attacheArray.push(JSON.stringify(attachment));
						myArray = attacheArray.join("#") + "#";
						flag = true;
					}
				} else {// 空 则删除
					attacheArray.splice(i, 1);
				}
			}
		}

		if (!flag) {
			myArray += JSON.stringify(attachment) + "#";
		}

	}
	// 图片上传end

	// 添加融资凭证
	addFinanceApplyVoucher = function() {

		// 已经添加的融资凭证id
		var addedMaterialId = '';
		var addMaterials = $("input[name='financeApplyVoucher']");
		$.each(addMaterials, function(i, item) {
			if ($(item).val()) {
				addedMaterialId += $(item).val() + ",";
			}
		})

		materialId = materialId;
		// 获取贷款材料名称
		$.msgbox({
					height : 648,
					width : 1235,
					content : '/loanApplicationController/addFinanceApplyVoucher?addedMaterialId='+addedMaterialId,
					type : 'iframe',
					title : $.i18n.prop('sys.client.Add.finance.apply.voucher'),/*添加融资凭证*/
				});
	}

	// 添加凭证全选 反选
	$("#checkAll").click(function() {
		var isCheckAll = $("#checkAll").attr("checked");
		if (isCheckAll) {// 全选
			$('input[type="checkbox"]').each(function() {
				$(this).attr("checked", true);
			});
		} else {// 取消全选
			$('input[type="checkbox"]').each(function() {
				$(this).attr("checked", false);
			});
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
		minDate : '1970-01-01',
		maxDate : '2099-12-31',
	};
	// 初始化日期控件
	$('#applyDate').datetimepicker(dmf);
	/* $('#repaymentDate').datetimepicker(dmf); */
	$('#effectiveDate').datetimepicker(dmf);
	var applyDate = $("#applyDate").val();
	var repaymentDate = $("#repaymentDate").val();
	var effectiveDate = $("#effectiveDate").val();
	if (applyDate) {
		var fmtDate = new Date();
		fmtDate.setTime(applyDate);
		$("#applyDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	/*
	 * if (repaymentDate) { var fmtDate = new Date();
	 * fmtDate.setTime(registerDate);
	 * $("#repaymentDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd')); }
	 */
	if (effectiveDate) {
		var fmtDate = new Date();
		fmtDate.setTime(effectiveDate);
		$("#effectiveDate").val(ext.formatDate(fmtDate, 'yyyy-MM-dd'));
	}
	// 初始化日期控件end

	// 删除选中的融资凭证
	$("#financeApplyDeleteVoucher").click(function() {

		var applyVoucher = $("input[name='financeApplyVoucher']");
		$.each(applyVoucher, function(i, item) {

			if ($(item).val() && $(item).attr('checked') == 'checked') {
				$(item).parent().parent().remove();
			}
		})
		CalcmaxLoanAmount();
		calcRepaymentDate();
	})

	/* 还款日规则只能单选 */
	$("input[name='periodType']").click(function() {
		calcRepaymentDate();
		if ($(this).val() == 'day') {
			$("#loanPeriodDay").attr("disabled", false);

			$("#loanPeriodMonth").val("");
			$("#loanPeriodMonth").attr("disabled", true);
		} else {
			$("#loanPeriodDay").val("");
			$("#loanPeriodDay").attr("disabled", true);

			$("#loanPeriodMonth").attr("disabled", false);
		}
	})

	calcRepaymentDate = function() {
		var periodType = $("input[name='periodType']:checked").val();
		var loanPeriod = $("input[name='periodType']:checked").val() == "month" ? $(
				"#loanPeriodMonth").val()
				: $("#loanPeriodDay").val();
		if (periodType && loanPeriod) {
			date = new Date();
			if (periodType == 'day') {
				dateNew = date.setDate(date.getDate() + parseInt(loanPeriod));
			}
			if (periodType == 'month') {
				dateNew = date.setMonth(date.getMonth() + parseInt(loanPeriod));
			}

			// 查询最早到到期的凭证到期日期
			var earliestDate = "3100-01-01";
			if ($("#financeApplyVoucherTable tr").size() > 0) {
				for (var i = 0; i < $("#financeApplyVoucherTable tr").size(); i++) {
					var datevoucher = $("#financeApplyVoucherTable tr").eq(
							i + 1).children().eq(6).text();
					if (new Date(earliestDate) > new Date(datevoucher)) {
						earliestDate = datevoucher;
					}
				}
			}

			if (new Date(dateNew) >= new Date(earliestDate)) {

				$("#repaymentDate").val(
						new Date(earliestDate).format("yyyy-MM-dd"))
			} else {
				$("#repaymentDate").val(new Date(dateNew).format("yyyy-MM-dd"));
			}

			return;

		}
	}
	// 触发计算还款日期
	var date = '';
	var dateNew = '';
	$("#loanPeriodDay").blur(function() {
		calcRepaymentDate();
	});
	$("#loanPeriodMonth").blur(function() {
		calcRepaymentDate();
	});

	/* 计算最大可贷金额 */
	/* 设置最大贷款金额 【最大可贷金额】=【凭证总金额】 * 【融资比例】 */
	var voucherAmount = 0;
	var maxLoanAmount = 0;/* 最大可贷金额 */
	CalcmaxLoanAmount = function() {
		voucherAmount = 0;
		for (var i = 0; i < $("#financeApplyVoucherTable tr").size() - 1; i++) {
			var $voucher = $("#financeApplyVoucherTable tr").eq(i + 1)
					.children().eq(4).text()
			voucherAmount += parseFloat($voucher);
		}
		maxLoanAmount = parseFloat(
				parseFloat(voucherAmount)
						* parseFloat($("#financeRatio").val()) / 100)
				.toFixed(2);
		$("#maxLoanAmount").val(maxLoanAmount);
	}

	// 提交审核
	$("#financeApplySubmitBtn")
			.click(
					function() {
						// 融资信息
						// 保理商id
						// var factorId = $("#factorId").val();
						// 产品id
						var productId = $("#productId").val();
						// 融资申请编号
						var applyNum = $("#applyNum").val();
						// 申请贷款金额
						var applyAmont = $("#applyAmount").val();
						// 贷款期限
						var periodType = $("input[name='periodType']:checked")
								.val();
						// 融资申请期限
						var loanPeriod = $("input[name='periodType']:checked")
								.val() == "month" ? $("#loanPeriodMonth").val()
								: $("#loanPeriodDay").val();
						// 还款时间
						var repaymentDate = $("#repaymentDate").val();
						// 融资申请凭证信息
						var addVoucherIds = "";
						/* 平台管理费比例 */
						var manageRatio = $("#manageRatio").val();

						var applyVoucher = $("input[name='financeApplyVoucher']")
						$.each(applyVoucher, function(i, item) {
							if ($(item).val()) {
								addVoucherIds += $(item).val() + ";";
							}
						});

						// 申请金额不能为空
						if (!applyAmont) {
							alert($.i18n.prop('sys.client.finance.apply.amount.is.empty'));/*申请金额不能为空！*/
							return false;
						}
						if (applyAmont <= 0) {
							alert($.i18n.prop('sys.client.finance.apply.amount.must.greater.than.zero'));/*申请金额要大于0*/
							return false;
						}

						

						// 贷款期限不能为空
						if (!periodType) {
							alert($.i18n.prop('sys.client.repayment.rule.is.empty'));/*还款日规则不能为空！*/
							return false;
						}
						// 融资申请期限 不能为空
						if (!loanPeriod) {
							alert($.i18n.prop('sys.client.repayment.rule.is.empty'));/*还款日规则不能为空！*/
							return false;
						}

						

						

						// 每个贷款材料需要上传图片
						var uploacPic = $("a[name='yulan']");
						var flag = true;
						$.each(uploacPic, function() {
							if (!$(this).attr("href")) {
								alert($.i18n.prop('sys.client.please.upload') + $(this).attr("materialName")+ $.i18n.prop('sys.client.picture'));/*请上传XX图片*/
								flag = false;
								return false;
							}
						})

						if (!flag) {
							return false;
						}
						// 1.上传的凭证不能为空
						if (!addVoucherIds) {
							alert($.i18n.prop('sys.client.please.upload.finance.apply.vopucher'));/*请上传融资申请凭证！*/
							return false;
						}
						
						var vouEnterNamesFlag = false;
						/* 判断添加的凭证只能属于同一个核心企业 */
						var vouEnterNames = $("#financeApplyVoucherTable tr:last td").eq(3).text();
						$.each($("#financeApplyVoucherTable tr"), function(i,item) {
							if (i > 0) {
								if (vouEnterNames != $(item).children("td").eq(3).text()) {
									vouEnterNamesFlag = true;
									alert($.i18n.prop('sys.client.core.enterprise.must.be.same'));/*只能选择核心企业相同的凭证！*/
									return;
								}
							}
						})

						if (vouEnterNamesFlag) {
							return false;
						}

						// 还款时间不能为空
						if (!repaymentDate) {
							alert($.i18n.prop('sys.client.repayment.date.is.empty'));/*还款日期不能为空！*/
							return false;
						}
						
						
						// 【申请融资金额】<= 最大可贷金额
						if (applyAmont > maxLoanAmount) {
							alert($.i18n.prop('sys.client.finance.apply.amount.must.less.than.max.loan.amount'));/*申请融资金额不能大于最大可贷金额!*/
							return false;
						}
						$("#financeApplySubmitBtn").parent().hide();
						$("#financeApplySubmitingBtn").parent().show();

						$.ajax({
									type : 'post',
									traditional : true,
									url : "/loanApplicationController/financeApplySubmit",
									dataType : 'json',
									data : {
										// factorId:factorId,
										productId : productId,
										applyNum : applyNum,
										applyAmont : applyAmont,
										periodType : periodType,
										loanPeriod : loanPeriod,
										manageRatio : manageRatio,
										repaymentDate : repaymentDate,
										myArray : myArray,
										addVoucherIds : addVoucherIds
									},
									success : function(data) {
										if (data.responseTypeCode == "success") {
											alert(
													data.info,
													function() {
														// 保存成功，让上传按钮失效
														$('.upLoadMaterialPic').unbind();
														$('#financeApplyAddVoucher').removeAttr('href');
														$("#financeApplyDeleteVoucher").unbind();

														$("#applyAmount").attr('readonly',true);
														$("#repaymentDate").attr('readonly',true);
														$("input[name='periodType']").attr('disabled',true);
														$("#loanPeriodDay").attr('readonly',true);
														$("input[name='periodType']").attr('disabled',true);
														$("#loanPeriodMonth").attr('readonly',true);

														$("#financeApplySubmitingBtn").parent().hide();
														$("#financeApplySubmitSuccessBtn").parent().show();
														window.location.href = "/financeApplyController/loanEdit"
													});
										} else {
											alert(data.info);
											$("#financeApplySubmitBtn").parent().show();
											$("#financeApplySubmitSuccessBtn").parent().hide();
											$("#financeApplySubmitingBtn").parent().hide();

										}
									},
									error : function(data) {

										alert($.i18n.prop('sys.client.finance.apply.submit.failed'));/*融资申请保存失败！*/
										$("#financeApplySubmitBtn").parent().show();
										$("#financeApplySubmitSuccessBtn").parent().hide();
										$("#financeApplySubmitingBtn").parent().hide();
									}
								})
					})
})
