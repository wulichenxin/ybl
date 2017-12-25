<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title><spring:message code="sys.v2.client.contract.edit" /></title>
	<!-- 保理商首页 -->
	<%@include file="/ybl/v2/admin/common/link.jsp" %>
	<link href="/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
	<!-- 日期控件 -->
	<link rel="stylesheet" type="text/css"
	href="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
</head>
<body>
	<div class="v2_top_bg v2_t_bg2 h116">
	<div class="v2_top_con">
		<div class="v2_head_top">
	<!--top start -->
	<%@include file="/ybl/v2/admin/common/top.jsp" %>
	</div>
	</div>
	</div>
	<!--top end -->
	<div class="v2_vip_conbody">
		<div class="v2_path_no"><spring:message code="sys.v2.client.location" />：<spring:message code="sys.v2.client.contract" /> ><spring:message code="sys.v2.client.contract.edit" /></div>
		<div class="v2_box_border mt20">
			<form action="/contract/contractAddSave" id="contractAddSave" method="post">
			<input type="hidden" name="id" value="${contract.id }">
			<div class="v2_tab_con">
				<div class="v2_text_box">
					<h1><spring:message code="sys.v2.client.base.message" /></h1>
					<div class="clear"></div>
					<ul>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.number" />：</span><input placeholder="" type="text" name="number" value="${contract.number }"
								<c:if test="${!empty contract.id }">readonly="readonly"</c:if> 	class="w300 v2_text validate[required]" /><i>*</i>
							</div></li>

						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.efficient.date" />：</span>
								<div class="v2_date">
									<input id="beginTime" name="beginTime" <c:if test="${!empty contract.id }">readonly="readonly"</c:if> value="<fmt:formatDate value='${contract.beginTime }' pattern='yyyy-MM-dd'/>" type="text" class="w120 v2_text validate[required,date]" /><a
										id="begin_time_a" class="v2_date_text_ico"></a>
								</div>
								<b><spring:message code="sys.v2.client.to" /></b>
								<div class="v2_date">
									<input id="endTime" name="endTime" <c:if test="${!empty contract.id }">readonly="readonly"</c:if> value="<fmt:formatDate value='${contract.endTime }' pattern='yyyy-MM-dd'/>" type="text" class="w120 v2_text validate[required,date]" /><a
										id="end_time_a" class="v2_date_text_ico"></a>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.supplier" />：</span>
								<div class="v2_i_seach">
									<input type="hidden" id="supplierEnterpriseId" name="supplierEnterpriseId" value="${supplierEnterprise.id }">
									<input id="supplierEnterpriseName" name="supplierEnterpriseName" value="${supplierEnterprise.enterpriseFullName }" type="text" readonly="readonly" class="w300 v2_text validate[required]" />
									<c:if test="${empty contract.id }"><a href="javascript:view1(1);" class="v2_i_seach_ico"></a></c:if>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.credit.quota" />：</span><input name="creditAmount" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.creditAmount }' />" type="text"
									 <c:if test="${!empty contract.id }">readonly="readonly"</c:if> class="w300 v2_text fl validate[required,custom[number]]" /><b><spring:message code="sys.v2.client.contract.yuan" /></b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.core.enterprise" />：</span>
								<div class="v2_i_seach">
									<input type="hidden" id="coreEnterpriseId" name="coreEnterpriseId" value="${coreEnterprise.id }">
									<input id="coreEnterpriseName" readonly="readonly" name="coreEnterpriseName" value="${coreEnterprise.enterpriseFullName }" type="text" class="w300 v2_text validate[required]" />
									<c:if test="${empty contract.id }"><a href="javascript:view2(1);" class="v2_i_seach_ico"></a></c:if>
								</div>
								<i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.fund.source" />：</span>
								<div class="v2_select_box">
									<select id="fundsSourceId" name="fundsSourceId" class="v2_select w200 fl validate[required]">
									</select>
								</div>
								<div class="v2_add_but">
									<a href="javascript:view(1);"><spring:message code="sys.v2.client.add" /></a>
								</div>
								<i>*</i>
							</div></li>
						<li class="clear"><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.person" />：</span><input name="contractPerson" value="${contract.contractPerson }" type="text"
									class="w300 v2_text" />
							</div></li>
					</ul>
					
				</div>
				<div class="clear"></div>
				<div class="v2_text_box">
					<h1><spring:message code="sys.v2.client.contract.supplier.settlement" /></h1>
					<ul>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.proportion" />：</span>
								<input name="settlementRatio" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.settlementRatio }' />" type="text" class="w300 v2_text fl validate[required,custom[number]]" /><b>%</b><i>*</i>
							</div>
						</li>
						<li>
							<div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.time" />：</span><b>T+</b><input name="settlementTime" value="${contract.settlementTime }" type="text"
									class="w200 v2_text fl validate[required,custom[number]]" /><b><spring:message code="sys.v2.client.contract.day" />(<spring:message code="sys.v2.client.contract.t" />)</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.factoring.rate" />：</span><input name="factoringFees" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.factoringFees }' />" type="text"
									<c:if test="${!empty contract.id }">readonly="readonly"</c:if> class="w300 v2_text fl validate[required,custom[number]]" /><b>%</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.loanRate" />：</span><input name="lendingRates" value="<fmt:formatNumber type='number' pattern='##0.00' value='${contract.lendingRates }' />" type="text"
									class="w300 v2_text fl validate[required,custom[number]]" /><b>%</b><i>*</i>
							</div></li>
						<li><div class="v2_input_box">
								<span><spring:message code="sys.v2.client.contract.settlement.type" />：</span>
								<div class="v2_select_box">
									<select class="v2_select w320 validate[required]" name="settlementType" url="/configController/get-CONTRACT_SETTLEMENT_TYPE"
										valueFiled="code_" textField="value_"
										defaultValue="${contract.settlementType }" isSelect="Y"></select>
								</div>
								<i>*</i>
							</div></li>
					</ul>
				</div>
				<div class="clear"></div>
				<div class="v2_but_list">
					<c:if test="${!empty contract.id }"><a class="bg_l" id='save_contract_end_btn' onclick="contractEndSave();"><spring:message code="sys.v2.client.contract.end" /></a></c:if>
					<a class="bg_l" onclick="contractAddSave();" id='save_contract_add_btn'><spring:message code="sys.v2.client.save" /></a>
					<a class="bg_l" id="save_contract_adding_btn" style="display:none;"><spring:message code="sys.v2.client.saving" /></a>
					<a href="javascript:history.back(-1);" class="bg_g">返回</a>
				</div>
			</div>
			</form>
		</div>
	</div>

	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp" %>
	<!-- bottom.jsp -->
	
	<script type="text/javascript"
	src="/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
	<script type="text/javascript" src="/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
	<script language='javascript'  src='/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js'></script>
	<script type="text/javascript">
	$(function(){
		$('#contractAddSave').validationEngine();
		getFundSources();
		view = function(id) {
			$.msgbox({
				height:280,
				width:564,
				content:'/contract/fundSourceAdd',
				type :'iframe',
				title: '<spring:message code="sys.v2.client.contract.fund.source.add" />'
			});
			$('body').css({overflow:'hidden'});
		}
		view1 = function(id) {
			$.msgbox({
				height:480,
				width:600,
				content:'/contract/enterprisePage?type=supplier',
				type :'iframe',
				title: '<spring:message code="sys.v2.client.supplier" />'
			});
			$('body').css({overflow:'hidden'});
		}
		view2 = function(id) {
			$.msgbox({
				height:480,
				width:600,
				content:'/contract/enterprisePage?type=enterprise',
				type :'iframe',
				title: '<spring:message code="sys.v2.client.core.enterprise" />'
			});
			$('body').css({overflow:'hidden'});
		}
		
		$('#beginTime').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			formatDate:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    maxDate:jQuery('#endTime').val()?jQuery('#endTime').val():false
				   });
				  },
			minDate:0
			
		});
		$('#begin_time_a').on('click', function () {
		    $('#beginTime').datetimepicker('show');
		});
		$('#endTime').datetimepicker({
			yearOffset:0,
			lang:'ch',
			timepicker:false,
			format:'Y-m-d',
			onShow:function( ct ){
				   this.setOptions({
				    minDate:jQuery('#beginTime').val()?jQuery('#beginTime').val():0
				   });
				  },
			maxDate:'2099-12-31'
		});
		$('#end_time_a').on('click', function () {
		    $('#endTime').datetimepicker('show');
		});
	});   
	
	function getFundSources(){
		$.ajax({
            url:'/contract/fundSourceList',
            type:'POST',
            dataType:'json',
            success:function(data,textStatus,jqXHR){
            	$("#fundsSourceId").empty();
            	var optionStr = "<option value=''>请选择</option>";
            	if(data){
            		$.each(data,function(index, obj){
            			if(obj.id_ == "${contract.fundsSourceId}") {
                			optionStr += "<option value='"+obj.id_+"' selected>"+obj.name_+"</option>";
                		} else {
                			optionStr += "<option value='"+obj.id_+"'>"+obj.name_+"</option>";
                		}
            		});
            	}
            	$("#fundsSourceId").html(optionStr);
            },
            error:function(xhr,textStatus){
            },
            complete:function(){
            }
        });
	}
	
	function contractAddSave(){
		if(!$('#contractAddSave').validationEngine('validate')){
			return;
		}
		var beginTime = $("#beginTime").val() + " 00:00:00";
		var endTime = $("#endTime").val() + " 00:00:00";
		$("#beginTime").val(beginTime);
		$("#endTime").val(endTime);
		$("#save_contract_add_btn").hide();
		$("#save_contract_adding_btn").show();
		 $.ajax({
            url:'/contract/contractAddSave',
            type:'POST',
            data: $("#contractAddSave").serialize(), 
            dataType:'json',
            success:function(data,textStatus,jqXHR){
            	if(data.responseTypeCode == "success"){
            		alert(data.info,function(){
            			window.location.href = "/contract/contractPage";
            			$("#save_contract_add_btn").show();
               		    $("#save_contract_adding_btn").hide();
            		});
            	} else {
            		alert(data.info,function(){
            			$("#save_contract_add_btn").show();
               		    $("#save_contract_adding_btn").hide();
            		});
            	}
            },
            error:function(xhr,textStatus){
            	$("#save_contract_add_btn").show();
       		    $("#save_contract_adding_btn").hide();
            },
            complete:function(){
            }
        });
	}
	
	function contractEndSave(){
		 $("#save_contract_add_btn").hide();
		 $("#save_contract_adding_btn").show();
		 $("#save_contract_end_btn").hide();
		 $.ajax({
            url:'/contract/contractEndSave',
            type:'POST',
            data: {contractId : '${contract.id}'}, 
            dataType:'json',
            success:function(data,textStatus,jqXHR){
            	if(data.responseTypeCode == "success"){
            		alert(data.info,function(){
            			$("#save_contract_add_btn").show();
               		    $("#save_contract_adding_btn").hide();
               		 	$("#save_contract_end_btn").show();
            			window.location.href = "/contract/contractPage";
            		});
            	} else {
            		alert(data.info,function(){
            			$("#save_contract_add_btn").show();
               		    $("#save_contract_adding_btn").hide();
               		 	$("#save_contract_end_btn").show();
            		});
            	}
            },
            error:function(xhr,textStatus){
            	$("#save_contract_add_btn").show();
       		    $("#save_contract_adding_btn").hide();
       		 	$("#save_contract_end_btn").show();
            },
            complete:function(){
            }
        });
	}
	
	</script>
</body>
</html>