<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.investBidManage.bidDetail"/></title><!-- 项目详情 -->
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<!-- 表单验证 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
	<!-- 省市区js -->
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/common/address.js"></script>
<script type="text/javascript">

	$(function() {
		
		
		/**
		 * 预览弹出框start
		 */
		view = function(urls) {
			if (urls != null && urls != '') {
				$.msgbox({
					height : 520,
					width : 800,
					content : '/ybl/admin/common/preview.jsp?urls='+urls,
					type : 'iframe',
					title : $.i18n.prop("sys.client.photo")//图片
				});
			}else{
				alert($.i18n.prop("sys.client.no.photo"));//暂无图片！
			}
		}
		// 预览弹出框end
		
		//tab切换
		$('.tabnav dl dd').click(function() {
			var index = $(this).index();
			$('.content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
			$('.tabnav dl dd').eq(index).addClass('now').siblings().removeClass('now');
		});
		
		
		//提交表单 
		$("#Query").click(function(){
			$("#pageForm").submit();
		})
		//格式化省市区
		selectAddress();
	});
	
	$(function(){
		$("#ratio").mouseout(function(){
			$("#max_amount").val($("#bidAmount").val() *  $("#ratio").val() * 0.01 /10000);
		})
		
		//参与竞标
		$("#member_factor_bid_Manage_invest_btn").click(function(){
			var agreement = $('input[name="agreement"]:checked').val();
			if(agreement == '' || agreement == null ){
				alert($.i18n.prop("sys.client.investBidManage.SignFactoringLoanContractAgreement"));/*请签署保理贷款合同合约 ! */
				return false;
			}
			var rate = $("#rate").val();
			/* var repayment_date_rule = $("#repayment_date_rule").val(); */
			var repayment_type = $("#repayment_type").val();
			var count = $("#count").val();
			var max_amount = $("#max_amount").val() * 10000;
			var overdue_rate = $("#overdue_rate").val();
			var advence_rate = $("#advence_rate").val();
			var ratio = $("#ratio").val();
			var loan_sign_id = $("#loan_sign_id").val();
			if(!$("#rate").validationEngine('validate')) {
				return;
			}
			if(!$("#overdue_rate").validationEngine('validate')) {
				return;
			}
			if(!$("#advence_rate").validationEngine('validate')) {
				return;
			}
			if(!$("#ratio").validationEngine('validate')) {
				return;
			}
			
			$.ajax({
		        url: '/bidController/insertBid', 
		        data:{
		        	'loanSignId':loan_sign_id,
		        	'rate':rate,
		        	'maxAmount':max_amount,
		        	'overdueRate':overdue_rate,
		        	'advenceRate':advence_rate,
		        	'ratio':ratio,
		        	//'repaymentDateRule':repayment_date_rule,
		        	'repaymentType':repayment_type,
		        	'count':count
		        	},
		        type: "post", 
		        async: true ,
		        dataType: "json",
		        success: function (data, textStatus, XMLHttpRequest) {
		        	if(data.responseTypeCode=='success'){//新增成功
		        		alert(data.info, callback);
		        	}else{
		        		alert(data.info);
		        	}
		        }
		    });	
		});
		
		callback = function() {
			location.href="/bidController/investManage";
		}
		
		//倒计时
		var EndTime = ${bid.end_date };
		var NowTime = ${date};
		GetRTime(EndTime, NowTime, "count_down_time");
		
	})
	//倒计时
	function GetRTime(EndTime, NowTime, domId){
		if (NowTime == 0) {
			NowTime = new Date().getTime();
		}
		var t = EndTime - NowTime + 86400000;//加一天
		timeShow(t, domId);
	    setInterval(function() {
	    	t = t-1000;
	    	timeShow(t, domId);
	    },1000);
	}
	function timeShow(t, domId){
	    var d=Math.floor(t/1000/60/60/24);
	    var h=Math.floor(t/1000/60/60%24);
	    var m=Math.floor(t/1000/60%60);
	    var s=Math.floor(t/1000%60);
	    $("#"+domId).html('<i class="q-color">'+(d<0?0:d)+'</i>'+'天'+'<i class="q-color">'+(h<0?0:h)+'</i>'+'时'+'<i class="q-color">'+(m<0?0:m)+'</i>'+'分'+'<i class="q-color">'+(s<0?0:s)+'</i>'+'秒');
	}
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=6" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.investBidManage"/> -><spring:message code="sys.client.investBidManage.myInvest"/> <!-- 我要竞投  -->-><spring:message code="sys.client.investBidManage.bidDetail"/></div>
	<div class="p_detail_con ">
		<div class="p_details_l body_cbox">
			<h1>${bid.name_ }</h1>
			<div class="p_detail_sj">
				<ul>
					<li>
						<h2><input type="hidden" id="bidAmount" value="${bid.amount_ }">
							<span class="yellow"><fmt:formatNumber value="${bid.amount_ /10000}" pattern="#,##0.00" maxFractionDigits="2"/></span><spring:message code="sys.client.tenThousand"/>
						</h2>
						<p><spring:message code="sys.client.loanMoney"/></p><!-- 贷款金额 -->
					</li>
					<li>
						<h2>
							<span>${bid.loan_period }</span>
							<c:if test="${bid.period_type == 'day' }"><spring:message code="sys.client.day"/></c:if>
	                		<c:if test="${bid.period_type == 'month' }"><spring:message code="sys.client.month"/></c:if>
	                		<c:if test="${bid.period_type == 'year' }"><spring:message code="sys.client.year"/></c:if>
							
						</h2>
						<p><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 --></p>
					</li>
					<li>
						<h2>
							<span>${bid.count }</span>
						</h2>
						<p><spring:message code="sys.client.investBidManage.investEnterprise"/><!-- 竞标企业 --></p>
					</li>
				</ul>
			</div>
			<div class="p_detail_xx">
				<ul>
					<li><span><spring:message code="sys.client.investBidManage.loanEnterprise"/><!-- 贷款企业 -->：</span><a class="lan">${bid.enterprise_name }</a></li>
					<li><span><spring:message code="sys.client.repaymentType"/><!-- 还款方式 -->：</span><spring:message code="sys.client.product.OneTimePayment"/></li>
					<!-- <li><span>担保方式：</span></li> -->
					<li><span><spring:message code="sys.client.investBidManage.InvestmentDeadline"/><!-- 竞投截止时间 -->：</span>
							<jsp:useBean id="dateValue" class="java.util.Date" />
							<jsp:setProperty name="dateValue" property="time" value="${bid.end_date}" />
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
					</li>
					<li><span><spring:message code="sys.client.phone"/><!-- 联系电话 -->：</span>${bid.fixed_phone }</li>
					<li><span><spring:message code="sys.client.core.enterprise"/><!-- 核心企业 -->：</span>${bid.core_name }</li>
				</ul>
			</div>
			<div class="jbs">
				<spring:message code="sys.client.investBidManage.InvestmentForTheRestOf"/>：<span class="yellow" id="count_down_time"></span>
			</div>
		</div>
		<form action="">
		<div class="p_details_r body_cbox">
			<h1><spring:message code="sys.client.investBidManage.theBiddingData"/><!-- 竞投数据 --></h1>
			
			<input type="hidden" id="count" value="${count }">
			<!-- 已竞投则隐藏 -->
			<c:if test="${count > 0 or bid.end_date < date}">
			<div class="rzzt1">
				<ul>
					<li class=" w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.loanRate"/><!-- 贷款利率 -->：</span>
							<div>
								<spring:message code="sys.client.yearRate"/><!-- 年利率 -->
								<input type="text" class="text_30 w50 mr10 " disabled="disabled" value="<fmt:formatNumber value="${loanSignBid.rate }" pattern="#,##0.00" maxFractionDigits="2"/>"/>%
							</div>
						</div></li>
					<%-- <li class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.managementPercent"/><!-- 管理费百分比 -->：</span>
							<div>
								<spring:message code="sys.client.yearRate"/><!-- 年利率 -->
								<input  type="text" class="text_30 w50 mr10 ml10" disabled="disabled" value="<fmt:formatNumber value="${loanSignBid.managerRate }" pattern="#,##0.00" maxFractionDigits="2"/>" />%
							</div>
						</div></li> --%>
					<li class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.investBidManage.breachOfContractInAdvance"/><!-- 提前还款违约金 -->：</span>
							日利率     &nbsp;<input value="<fmt:formatNumber value="${loanSignBid.overdueRate }" pattern="#,##0.00" maxFractionDigits="2"/>" disabled="disabled" type="text" class="text_30 w50 mr10" />%
						</div></li>
					<li class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.investBidManage.overduePenaltyDueToBreachOfContract"/><!-- 逾期违约金 -->：</span>
							日利率     &nbsp;<input value="<fmt:formatNumber value="${loanSignBid.advenceRate }" pattern="#,##0.00" maxFractionDigits="2"/>" disabled="disabled" type="text" class="text_30 w50 mr10" />%
						</div></li>
					<%-- <li  class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.repaymentRule"/><!-- 还款日规则 -->：</span>
							<div class="select_box">
								<select class="select w80 mr10" name="repayment_date_rule" disabled="disabled">
									<option <c:if test="${loanSignBid.repaymentDateRule == 'greater_than'}">selected="selected"</c:if> >></option>
									<option <c:if test="${loanSignBid.repaymentDateRule == 'less_than'}">selected="selected"</c:if>> < </option>
									<option <c:if test="${loanSignBid.repaymentDateRule == 'equal_to'}">selected="selected"</c:if> >=</option>
								</select>
							</div>贷款凭证最早到期日
						</div></li> --%>
					<li class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.financingProportion"/><!-- 融资比例 -->：</span><input value="<fmt:formatNumber value="${loanSignBid.ratio }" pattern="#,##0.00" maxFractionDigits="2"/>" disabled="disabled" type="text" class="text_30 w50 mr10 " />%
						</div></li>
					<li class="w400 clear"><div class="p_input_box">
							<span><spring:message code="sys.client.maxLoanMoney"/><!-- 最大可贷金额 -->：</span><input value="<fmt:formatNumber value="${loanSignBid.maxAmount /10000}" pattern="#,##0.00" maxFractionDigits="2"/>" disabled="disabled" type="text" class="text_30 w50 mr10 " /><spring:message code="sys.client.tenThousand"/>
						</div></li>
					
					
				</ul>
			</div>
			</c:if>
			<c:if test="${count == 0 && bid.end_date > date}">
				
				<div class="rzzt1">
					<ul>
						<input type="hidden" id="loan_sign_id" value="${bid.id_ }">
						<li class=" w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.loanRate"/><!-- 贷款利率 -->：</span>
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 --><input type="text" class="text_30 w50 mr10  validate[number,required,min[0.01],minSize[1],maxSize[6],max[100]]" id="rate"/>%
								</div>
							</div></li>
						<%-- <li class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.managementPercent"/><!-- 管理费百分比 -->：</span>
								<div>
									<spring:message code="sys.client.yearRate"/><!-- 年利率 --><input  type="text" class="text_30 w50 mr10 ml10" id="manager_rate"/>%
								</div>
							</div></li> --%>
						<li class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.investBidManage.breachOfContractInAdvance"/><!-- 提前还款违约金 -->：</span>
								日利率     &nbsp; <input id="overdue_rate" type="text" class="text_30 w50 mr10 validate[number,required,min[0.01],minSize[1],maxSize[6],max[100]]" />%
							</div></li>
						<li class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.investBidManage.overduePenaltyDueToBreachOfContract"/><!-- 逾期违约金 -->：</span>
								日利率    &nbsp;  <input id="advence_rate" type="text" class="text_30 w50 mr10 validate[number,required,min[0.01],minSize[1],maxSize[6],max[100]]" />%
							</div></li>
						<%-- <li  class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.repaymentRule"/><!-- 还款日规则 -->：</span>
								<div class="select_box">
									<select class="select w80 mr10" name="repayment_date_rule" id="repayment_date_rule">
										<option value="greater_than">></option>
										<option value="less_than">< </option>
										<option value="equal_to">=</option>
									</select>
								</div>贷款凭证最早到期日
							</div></li> --%>
						<li  class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.financingProportion"/><!-- 融资比例 -->：</span><input id="ratio" type="text" class="text_30 w50 mr10 validate[number,required,min[0.01],minSize[1],maxSize[6],max[100]]" />%
							</div></li>
						<li  class="w400 clear"><div class="p_input_box">
								<span><spring:message code="sys.client.maxLoanMoney"/><!-- 最大可贷金额 -->：</span><input id="max_amount" disabled="disabled" type="text" class="text_30 w50 mr10 " /><spring:message code="sys.client.tenThousand"/>
							</div></li>
						<%-- <li><div class="p_input_box">
								<span><spring:message code="sys.client.repaymentType"/><!-- 还款方式 -->：</span>一次性还款
							</div></li> --%>
					  <input type="hidden" value="once" id="repayment_type">
					
						
					
	
					</ul>
					<div class="w_agreen">
						<input name="agreement" type="checkbox" value="1" /><spring:message code="sys.client.investBidManage.AgreedToSignFactoringLoanContractAgreement"/><!-- 同意签署保理贷款合同合约 -->
					</div>
					<div class="but_left">
						<sun:button tag='a' id='member_factor_bid_Manage_invest_btn' i18nValue='sys.client.investBidManage.toParticipateInBidding' /><!-- 参与竞投 -->
					</div>
				</div>
				
			</c:if>
			
			
		</div>
		</form>
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a><spring:message code="sys.client.investBidManage.itemInformation"/><!-- 项目信息 --></a>
					</dd>
					<dd>
						<a><spring:message code="sys.client.investBidManage.financingCompanyProfile"/><!-- 融资公司简介 --></a>
					</dd>
					<!-- <dd>
						<a>安全保障</a>
					</dd> -->
				</dl>
			</div>
			<div>
				<div class="text_box content">
					<div class="rzsq_box">
						<h1><spring:message code="sys.client.FinanceBody" /></h1>
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
								<%-- <li><div class="input_box">
										<span><spring:message code="sys.client.bid.end.date" /><!-- 竞标截止时间 -->：</span><input value='${bid.end_date }' disabled='disabled'
											type="text" class="text_gary w300" />
									</div></li> --%>
							</ul>
						</div>
					</div>
					<div class="rzsq_box">
						<h1><spring:message code="sys.client.subject.apply" /></h1>
						<div class="rzzt">
							<ul>
							<li><div class="input_box">
									<span><spring:message code="sys.client.financeNumber" />：</span>
									<!-- 融资编号 -->
									<input type="text" class="text w300" value="${subject.number}"
										disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.projectName" />：</span>
									<!-- 项目名称 -->
									<input type="text" class="text w300" value="${subject.name}"
										disabled='disabled' />
								</div></li>
							<li class="w472"><div class="input_box">
									<span><spring:message code="sys.client.financeAmount" />：</span>
									<!-- 融资金额 -->
									<input type="text" class="text w200 mr10"
										value="<fmt:formatNumber value="${subject.amount / 10000}" pattern="#,##0.00" maxFractionDigits="2"/>" disabled='disabled' pattern="#,##0.00" maxFractionDigits="2"/>
									<spring:message code="sys.client.tenThousand" />
									<!-- 元 -->
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.investBidManage.LoanPeriod" />：</span>
									<!-- 贷款期限  -->
									<input type="text" class="text w300 mr10"
										value="${subject.loanPeriod}" disabled='disabled'/>
									<c:if test="${subject.periodType == 'day' }">日</c:if>
	                				<c:if test="${subject.periodType == 'month' }">月</c:if>
	                				<c:if test="${subject.periodType == 'year' }">年</c:if>
								</div></li>
							<li class="clear w472"><div class="input_box">
									<span><spring:message code="sys.client.repaymentType" />：</span>
									<!-- 还款方式 -->
									<div class="select_box">
										<select class="select w300"  disabled='disabled'>
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
											<option value=''
												${subject.factoringType==''||subject.factoringType==null?"selected":""}>
												<spring:message code="sys.client.select" /><!-- 请选择 -->
											</option>
											<option value='online_clear_factor'
												${subject.factoringType=='online_factor'?"selected":""}>
												<spring:message code="sys.client.online.clear.facte" /><!-- 明保理 -->
											</option>
											
											<option value='dark_factor'
												${subject.factoringType=='dark_factor'?"selected":""}>
												<spring:message code="sys.client.dark.facte" /><!-- 暗保理 -->
											</option>
										</select>
									</div>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.repaymentTime" />：</span>
									<!-- 还款日期 -->
									<jsp:useBean id="dateValue1" class="java.util.Date" />
									<jsp:setProperty name="dateValue1" property="time" value="${subject.repaymentDate}" />
									<input type="text" class="text w300" disabled='disabled' value='<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd" />' />
								</div></li>
							<li><div class="input_box">
									<span><spring:message
											code="sys.client.predictDisbursementTime" />：</span>
									<!-- 预计放款审批时间 -->
									<input type="text" class="text w300 mr10" value="${subject.id}"
										disabled='disabled'/>
									<spring:message code="sys.client.day" />
									<!-- 天 -->
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bid.end.date" />：</span>
									<!--竞标截止时间  -->
									<jsp:useBean id="dateValue2" class="java.util.Date" />
									<jsp:setProperty name="dateValue2" property="time" value="${subject.endDate}" />
									<input type="text" class="text w300"  disabled='disabled' value='<fmt:formatDate value="${dateValue2}" pattern="yyyy-MM-dd" />' />
								</div></li>
							<%-- <li class="w472"><div class="input_box">
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
								</div></li> --%>
							<li><div class="input_box">
									<span><spring:message code="sys.client.finance.purpose" />：</span>
									<!-- 融资用途 -->
									<textarea class="text_tea w770 h100" disabled='disabled'>${subject.desc}</textarea>
								</div></li>
						</ul>
						</div>
					</div>

					<div class="rzsq_box">
						<h1><spring:message code="sys.client.financeVoucher" /></h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="subject_voucher_tb">
								<tr>
									<th width="50"><spring:message code="sys.client.no" /></th>
									<!-- 序号 -->
									<th><spring:message code="sys.client.voucherNumber" /> <!-- 凭证编码 --></th>
									<th><spring:message code="sys.client.coreCompanyName" /> <!-- 核心企业名称 --></th>
									<th> <spring:message code="sys.client.voucher.amount" /></th>
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
										<td>¥<fmt:formatNumber value="${data.amount /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
										<td>${data.type}</td>
										<jsp:useBean id="dateValue3" class="java.util.Date" />
										<jsp:setProperty name="dateValue3" property="time" value="${data.effectiveDate}" />
										<td><fmt:formatDate value="${dateValue3}" pattern="yyyy-MM-dd" /></td>
										
										<jsp:useBean id="dateValue4" class="java.util.Date" />
										<jsp:setProperty name="dateValue4" property="time" value="${data.expireDate}" />
										<td><fmt:formatDate value="${dateValue4}" pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value="${data.lastUpdateTime}" pattern="yyyy-MM-dd" /></td>
										<td><div class="qy">
												<a href="javascript:view('${data.picUrls}');"><spring:message code="sys.client.preview"/><!-- 预览 --></a>
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>

						</div>
					</div>

					<div class="rzsq_box">
						<h1><spring:message code="sys.client.loanMaterial" /></h1>

						<div class="table_con table_border mt20">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb">
								<tr>
									<th width="50"><spring:message code="sys.client.no" /></th>
									<!-- 序号 -->
									<th width="15%"><spring:message code="sys.client.materialName" /> <!-- 材料名称 --></th>
									<th width="25%"><spring:message code="sys.client.remark" /> <!-- 备注 --></th>
									<th width="20%"><spring:message code="sys.client.uploadTime" /> <!-- 上传时间 --></th>
									<th><spring:message code="sys.client.operation" /> <!-- 操作 --></th>
								</tr>
								<c:forEach var="loanMaterial" items="${loanmaterialList}"
									varStatus="index">
									<tr>
										<td>${index.count}</td>
										<td>${loanMaterial.name}</td>
										<td>${loanMaterial.remark}</td>
										<td><fmt:formatDate value="${loanMaterial.lastUpdateTime}"  pattern="yyyy-MM-dd" /></td>
										<td>
											<div class="qy">
												<a href="javascript:view('${loanMaterial.attribute1}');"><spring:message code="sys.client.preview"/><!-- 预览 --></a>
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>

						</div>
					</div>

				</div>

				<div class="text_box content" style="display: none;">
					<div class="blsjj">
						<h1><spring:message code="sys.client.investBidManage.companyProfile"/><!-- 公司简介 --></h1>
						${enterprise.companyProfile }
					</div>
					<div class="blsjj">
						<h1><spring:message code="sys.client.company.base.message"/><!-- 基本信息 --></h1>
						<ul>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyName"/><!-- 企业名称 -->：</span><input value="${enterprise.enterpriseName }"  type="text"
										class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.companyTelephone"/><!-- 企业固定电话 -->：</span><input value="${enterprise.fixedPhone }"
										type="text" class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.legalPersonName"/><!-- 法定代表人 -->：</span><input value="${enterprise.legalName }" type="text"
										class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.licenseNumber"/><!-- 营业执照注册号 -->：</span><input value="${enterprise.licenseNo }"
										type="text" class="text_gary w300 fl" disabled='disabled'/>
									<div class="checkbox">
										<input type="checkbox" /><spring:message code="sys.client.isThreeOne"/><!-- 是否三证合一企业 -->
									</div>
									<i></i>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.orgCodeNo"/><!-- 机构代码证号 -->：</span><input value="${enterprise.orgCodeNo }" type="text"
										class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.taxNo"/><!-- 税务登记号 -->：</span><input value="${enterprise.taxNo }"
										type="text" class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.financeNo"/><!-- 财务登记证 -->：</span><input value="${enterprise.financeNo }"
										type="text" class="text_gary w600" disabled='disabled'/>
								</div></li>
							<li>
								<div class="input_box">
									<span><spring:message code="sys.client.register.province.area"/><!-- 注册省份地区 -->：</span> 
									<input value="${enterprise.provinceId}" id='provinceId' type="text" class="text_gary w160" disabled='disabled'/> 
									<input value="${enterprise.cityId }" id='cityId' type="text" class="text_gary w160" disabled='disabled'/> 
									<input value="${enterprise.areaId }"  id='areaId'type="text" class="text_gary w160" disabled='disabled'/>
								</div>
							</li>

							<li><div class="input_box">
									<span><spring:message code="sys.client.register.address"/><!-- 注册地址 -->：</span><input value="${enterprise.address }" disabled='disabled'
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span><spring:message code="sys.client.bussiness.scope"/><!-- 经营范围 -->：</span><input value="${enterprise.bussinessScope }" type="text" disabled='disabled'
										class="text_gary w600" />
								</div></li>
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