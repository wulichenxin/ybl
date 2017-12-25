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
<title>产品配置</title>
<jsp:include page="../../common/link.jsp" />
<!-- 表单验证 -->
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">
//提交表单
function formSubmit(){
	var addBtn = $(".vip_phone").find("img").attr("src");
	if(addBtn == null){
		alert("请选择产品图片!");
		return;
	}
	if(!$("#rate_").validationEngine('validate')) {
		return;
	}
	if(!$("#overdue_rate").validationEngine('validate')) {
		return;
	}
	if(!$("#manage_rate").validationEngine('validate')) {
		return;
	}
	if(!$("#penalty_rate").validationEngine('validate')) {
		return;
	}
	if(!$("#finance_ratio").validationEngine('validate')) {
		return;
	}
	if(!$("#term_").validationEngine('validate')) {
		return;
	}
	if($("#matTb tr").length <= 1){
		alert("请选择贷款材料!");
		return;
	}
	/* if($("#arcTb tr").length <= 1){
		alert("请选择归档材料!");
		return;
	} */
	$.ajax({
		url:"/productManageController/updateProductConfig",
		data:$("form").serialize(),
		dataType:"json",
		type:"post",
		success : function(resp) {
			if (resp.responseType == 'ERROR') {
				alert(resp.info);/* 服务器繁忙请稍候重试 */
				/* var id = resp.object != null ? resp.object.id : "";
				$("#subject_id").val(id); */
			} else {
				alert(resp.info,callback);/* 数据保存/更新成功 */
			}
		},
		error : function() {
			alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
		}
	});
	

	callback = function() {
		location.href="/productManageController/queryAllProduct";
	}
}

$(function(){
	//返回列表
	$("#member_factor_product_Manage_goback_btn").click(function(){
		location.href="/productManageController/queryAllProduct";    	
	});
	//校验初始化
	var pageForm = ext.formValidation("pageForm");
	//保存按钮事件
	$("#member_factor_product_Manage_saveProductSubmit_btn").click(function(){
		var passed = pageForm.validationEngine("validate");
		if(passed){
			formSubmit();
		}
		
	})
	
	
	
	var productId = $("#product_id").val();
	var enterpriseId = $("#enterprise_id").val();
	//添加费用配置
	$("#fee").click(function(){
		var id = $('input[name="id"]:checked').val();
		$.msgbox({
			height:432,
			width:620,
			content:'/productManageController/queryAllConfigFee?productId='+ productId + '&enterpriseId=' + enterpriseId,
			type :'iframe',
			title: '添加费用配置'
		});
	})
	//添加贷款材料配置
	$("#member_factor_product_Manage_selectMat_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		$.msgbox({
			height:432,
			width:620,
			content:'/productManageController/queryAllConfigMaterial?productId='+ productId + '&enterpriseId=' + enterpriseId,
			type :'iframe',
			title: '添加贷款材料'
		});
	})
	//添加归档材料
	$("#member_factor_product_Manage_selectArc_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		$.msgbox({
			height:432,
			width:620,
			content:'/productManageController/queryAllConfigPigeonhole?productId='+ productId + '&enterpriseId=' + enterpriseId,
			type :'iframe',
			title: '添加归档材料'
		});
	})
	//删除选中的费用配置
	$("#deleteFee").click(function(){
		obj = document.getElementsByName("checkFee");
	    fees = [];
	    for(k in obj){
	        if(obj[k].checked)
	            fees.push(obj[k].value);
	    }
		var fee = fees.toString();
	    $.ajax({
	        url: '/productManageController/deleteProductFee', 
	        data:{fees:fee},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//删除成功
	        		alert(data.info,call_back);
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
	})
	
	//删除所选材料配置
	$("#member_factor_product_Manage_deleteMat_btn").click(function(){
		obj = document.getElementsByName("checkMat");
		materials = [];
	    for(k in obj){
	        if(obj[k].checked)
	        	materials.push(obj[k].value);
	    }
		var material = materials.toString();
	    $.ajax({
	        url: '/productManageController/deleteProductMaterial', 
	        data:{materials:material},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//删除成功
	        		alert(data.info,call_back1);
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
	})
	
	//删除选中的归档材料配置
	$("#member_factor_product_Manage_deleteArc_btn").click(function(){
		
		obj = document.getElementsByName("checkArc");
		archives = [];
	    for(k in obj){
	        if(obj[k].checked)
	        	archives.push(obj[k].value);
	    }
		var archive = archives.toString();
	    $.ajax({
	        url: '/productManageController/deleteProductArchive', 
	        data:{archives:archive},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//删除成功
	        		alert(data.info,call_back);
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });
	})
	
	call_back = function(){
		$("input[name='checkArc']:checked").each(function() { // 遍历选中的checkbox
            n = $(this).parents("tr").index();  // 获取checkbox所在行的顺序
            $("#arcTb").find("tr:eq("+n+")").remove();
        });
	}
	
	call_back1 = function(){
		$("input[name='checkMat']:checked").each(function() { // 遍历选中的checkbox
            n = $(this).parents("tr").index();  // 获取checkbox所在行的顺序
            $("#matTb").find("tr:eq("+n+")").remove();
        });
	}
	
	//全选费用
	$("#checkFeeAll").click(function(){
		var isCheckAll = $("#checkFeeAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkFee"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkFee"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
	//全选材料
	$("#checkMatAll").click(function(){
		var isCheckAll = $("#checkMatAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkMat"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkMat"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
	//全选归档材料
	$("#checkArcAll").click(function(){
		var isCheckAll = $("#checkArcAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="checkArc"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="checkArc"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
	
}); 

$(function(){

	//监听图片上传按钮
	$("#common_upload_btn").watchProperty("value",function() {
		var v = $(this).val();
		if(v == '' || v == null) return;
		// 上传
		$("#common_upload_form").attr("action", "/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
		$("#common_upload_form").submit();
	});
	//点击图片上传图片
	$("#addBtn").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
		
	});
	
	//回调，回显图片
	uploadCallback = function(_voJson) {
		var json = eval("(" + _voJson + ")");
		$("#common_upload_btn").val('');
		$("#url").val(json.url_);
		$("#old_name").val(json.old_name);
		$("#new_name").val(json.new_name);
		$("#ext_name").val(json.ext_name);
		$(".addBtn i").css('display','none')
		$("#" + id).html("<img src='" + json.url_ + "'/>");
	}
	//图片上传end
	
})
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">当前位置->产品工厂 -> 产品管理 -> 产品配置</div>
	<form action="/productManageController/updateProductConfig" id="pageForm" method="post">
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
            	<div class="v_tittle"><h1><i class="v_tittle_2"></i>产品详情</h1></div>
            	<div class="rzsq_box">
					<h1>产品概述</h1>
					
					
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span>产品名称：</span><input value="${product.name_ }" type="text" disabled="disabled" class= "w770 text_gary"/></div></li>
						<li><div class="input_box"><span>保理类型：</span>
							<c:if test="${product.type_ == 'online_factor' }">
								<input value="线上明保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							<c:if test="${product.type_ == 'offline_factor' }">
								<input value="线下明保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							<c:if test="${product.type_ == 'dark_factor' }">
								<input value="暗保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							
							</div>
						</li>
									<!-- <div class="select_box">
										<select class="select w200">
											<option>请选择</option>
											<option>线上明保理</option>
											<option>线下明保理</option>
											<option>暗保理</option>
										</select>
									</div></div> -->
						<li><div class="input_box"><span>产品描述：</span><textarea class="text_tea w770 h200" >${product.desc_ }</textarea></div></li>
						
					</ul>
					</div>
				</div>
				
				<input type="hidden" value="${product.id_ }" id="product_id" name="id">
				<input type="hidden" value="${product.enterprise_id }" id="enterprise_id" name="enterprise_id">
				<input type="hidden" value="authstr" name="audit_status"><!-- 审核状态默认为待审核，产品审核完不能再编辑 -->
           		<input type="hidden" id="url" name="url_"/>
				<input type="hidden" id="old_name" name="old_name"/>
				<input type="hidden" id="new_name" name="new_name"/>
				<input type="hidden" id="ext_name" name="ext_name"/>	
           		<div class="rzsq_box">
					<h1>产品详情</h1>
					<div class="rzzt">
						<ul>
							<li class="clear w472">
								<div class="input_box">
									<span>产品logo：</span>
									<div class="vip_phone" style="width:300px;">
										<dl>
											<dd>
												<a id="addBtn" >
													<c:if test="${empty attachment.url_ }">
						                    			<i>+</i>
						                    		</c:if>
						                    		<c:if test="${not empty attachment.url_ }">
						                    			<img src="${attachment.url_ }" />
						                    		</c:if>
												</a>
											</dd>
										</dl>
									</div>
								</div>
							</li>
						<!-- <li><div class="input_box"><span>产品名称：</span><input placeholder="电子供应商" type="text" class= "w770 text_gary"/></div></li> 
						 <li><div class="input_box"><span>保理类型：</span>
									<div class="select_box">
										<select class="select w200">
											<option>请选择</option>
											<option>线上明保理</option>
											<option>线下明保理</option>
											<option>暗保理</option>
										</select>
									</div></div></li> -->
							<li class=" clear w472">
						      <div class="input_box"><span>还款方式：</span>
							      到期一次性还本付息
							  </div>
							  <input type="hidden" name="repayment_type" value="once"/>
							 </li>
							<%-- <li class="clear w472">
								<div class="input_box"><span>还款日规则：</span>
									<div class="select_box">
										<select class="select w80 mr10" name="repayment_date_rule" value="${product.repayment_date_rule }">
											<option <c:if test="${product.repayment_date_rule=='greater_than' }">selected="selected" </c:if> value="greater_than">></option>
											<option <c:if test="${product.repayment_date_rule=='less_than' }">selected="selected" </c:if> value="less_than">< </option>
											<option <c:if test="${product.repayment_date_rule=='equal_to' }">selected="selected" </c:if> value="equal_to">=</option>
										</select>
									</div>贷款凭证最早到期日
								</div>
								
							</li> --%>
							<li class=" w472"><div class="input_box"><span>贷款利率：</span><div>年利率<input name="rate_" id="rate_" value="<fmt:formatNumber value="${product.rate_ }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10  validate[number,required,min[0.01],minSize[1],maxSize[8],max[100]]"/>%</div></div></li>
							<li class="clear w472"><div class="input_box"><span>逾期利率：</span><div>日利率<input name="overdue_rate" id="overdue_rate" value="<fmt:formatNumber value="${product.overdue_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10  validate[number,required,min[0.01],max[100],minSize[1],maxSize[8]]"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>管理费百分比：</span><div>年利率<input name="manage_rate"  id="manage_rate" value="<fmt:formatNumber value="${product.manage_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10  validate[required,number,min[0.01],max[100],minSize[1],maxSize[8]]"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>违约利率：</span><div>日利率<input name="penalty_rate" id="penalty_rate" value="<fmt:formatNumber value="${product.penalty_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10  validate[required,number,min[0.01],minSize[1],max[100],maxSize[8]]"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>融资比例：</span><input name="finance_ratio" id="finance_ratio" value="<fmt:formatNumber value="${product.finance_ratio }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10  validate[required,number,minSize[1],min[0.01],maxSize[8]],max[100]"/>%</div></li>
							<li class="w472">
							<div class="input_box"><span>贷款期限：</span>
							<input name="term_" id="term_" value="${product.term_ }" type="text" class="text w50 mr10 fl  validate[required,min[1],max[30],number,minSize[1],maxSize[8]]"/>
								<select class="select w80 mr10 " name="loan_type" >
									<option <c:if test="${product.loan_type=='day' }">selected="selected" </c:if> value="day">日</option>
									<option <c:if test="${product.loan_type=='month' }">selected="selected" </c:if> value="month">月</option>
									<option <c:if test="${product.loan_type=='year' }">selected="selected" </c:if> value="year">年</option>
								</select>
							</div>
							</li>
						</ul>
					</div>
				</div>
           		
           		
           
           		<%-- <div class="rzsq_box">
					<h1>费用收取配置</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
							<div class="table_nav">
								<ul>
									<li><a class="but_ico2" href="javascript:;" id="fee">选择基础费用</a></li>
									<li><a class="but_ico1" id="deleteFee">删除</a></li>
								</ul>
							</div>
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="feeTb">
							  <tr>
							   <th width="50"><input name="" type="checkbox" value="" id="checkFeeAll"/></th>
								<th>序号</th>
								<th>费用类型</th>
								<th>费用比例</th>
							  </tr>
							  <c:forEach var="fee" items="${feeList}" varStatus="index">
							  <tr>
							   <td><input name="checkFee" type="checkbox" value="${fee.id_ }" /></td>
								<td>${index.count}</td>
								<td>${fee.type_}</td>
								<td>${fee.ratio_}</td>
							  </tr>
							  </c:forEach>
							</table>

						</div>
				</div> --%>
          		<div class="rzsq_box">
					<h1>贷款材料配置</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
							<div class="table_nav">
								<ul>
									<li>
										<sun:button tag='a' clazz='but_ico2' id='member_factor_product_Manage_selectMat_btn' value='选择贷款材料' />
									</li>
									<li>
										<sun:button tag='a' clazz='but_ico1' id='member_factor_product_Manage_deleteMat_btn' i18nValue='sys.client.delete' />
									</li>
								</ul>
							</div>
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="matTb">
							  <tr>
							   <th width="50"><input name="" type="checkbox" value="" id="checkMatAll"/></th>
								<th>序号</th>
								<th>贷款材料名称</th>
								<th>备注</th>
							  </tr>
							  <c:forEach var="mat" items="${matList}" varStatus="index">
							  <tr>
							   <td><input name="checkMat" type="checkbox" value="${mat.id_}" /></td>
								<td>${index.count}</td>
								<td>${mat.name_}</td>
								<td>${mat.remark_}</td>
							  </tr>
							  </c:forEach>
							  
							</table>

						</div>
				</div>
          		<%-- <div class="rzsq_box">
					<h1>贷款归档材料配置</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
							<div class="table_nav">
								<ul>
									<li>
										<sun:button tag='a' clazz='but_ico2' id='member_factor_product_Manage_selectArc_btn' value='选择归档材料' />
									</li>
									<li>
										<sun:button tag='a' clazz='but_ico1' id='member_factor_product_Manage_deleteArc_btn' i18nValue='sys.client.delete' />
									</li>
								</ul>
							</div>
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="arcTb">
							  <tr>
							   <th width="50"><input name="" type="checkbox" value="" id="checkArcAll"/></th>
								<th>序号</th>
								<th>归档材料名称</th>
								<th>备注</th>
							  </tr>
							  <c:forEach var="arc" items="${arcList}" varStatus="index">
							  <tr>
							   <td><input name="checkArc" type="checkbox" value="${arc.id_}" /></td>
								<td>${index.count}</td>
								<td>${arc.name_}</td>
								<td>${arc.remark_}</td>
							  </tr>
							  </c:forEach>
							</table>
						</div>
				</div>   --%>
            </div>        
				<div class="w_bottom_btn">
					<ul>
						<li>
							<sun:button tag='a' clazz='now' id='member_factor_product_Manage_saveProductSubmit_btn' i18nValue='sys.client.submit' />
						</li>
						<li>
							<sun:button tag='a' clazz='now' id='member_factor_product_Manage_goback_btn' value='返回列表' />
						</li>
					</ul>
				</div>         		          		
    </div>
    </form>
<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
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