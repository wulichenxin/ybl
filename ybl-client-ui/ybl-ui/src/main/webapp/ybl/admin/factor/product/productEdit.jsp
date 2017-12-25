<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
$(function() {
	$("#member_factor_product_Manage_addProductSave_btn").click(function(){
		var name_= $("#name_").val();
		var type_= $("#type_").val();
		var desc_= $("#desc_").val();
		var initiator_ = $("#initiator_").val();
		if(name_ == '' || name_ == null){
			alert($.i18n.prop("sys.client.ProductNameCannotBeEmpty"));
			return false;
		}
		if(type_ == '' || type_ == null){
			alert($.i18n.prop("sys.client.PleaseSelectTheProductType"));
			return false;
		}
		if(desc_ == '' || desc_ == null){
			alert($.i18n.prop("sys.client.TheProductDescriptionCannotBeEmpty"));
			return false;
		}
		$.ajax({
	        url: '/productManageController/insertProduct', 
	        data:{name_:name_,type_:type_,desc_:desc_,initiator_:initiator_},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//新增成功
	        		alert(data.info, callback);
	        		
	        	}else{
	        		alert(data.info);
	        		$("#anqu_close").click();
	        	}
	        }
	    });	
	});
	
	callback = function() {
		parent.$(".msgbox_close").mousedown();
		parent.window.location.href ="/productManageController/queryAllProduct";
	}
	
	$("#anqu_close").click(function() {
		parent.$(".msgbox_close").mousedown();
	});
})

</script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.product.manage"/>-<spring:message code="ybl.web.department.add"/>/<spring:message code="ybl.web.department.modify"/></title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--弹出窗登录-->

<div class="vip_window_con">
    <div class="clear"></div>
    <div class="window_xx">
    	<ul>
    		<input type="hidden" id="initiator_" value="factor"/><!-- 产品发起方：后台发起为factor -->
            <li class="clear">
            	<div class="input_box"><span><spring:message code="sys.client.productName"/><!-- 产品名称 -->：</span>
            		<input type="text" placeholder="" maxlength="30" class="text w300" id="name_"/>
           		</div>
           	</li>
           	<li class="clear">
            	<div class="input_box"><span><spring:message code="sys.client.factorType"/><!-- 保理类型 -->：</span>
            		<div class="select_box">
						<select class="select w200" id="type_">
							<option value=""><spring:message code="sys.client.select"/><!-- 请选择 --></option>
							<option value="online_factor"><spring:message code="sys.client.online.clear.facte"/><!-- 明保理 --></option>
				            <option value="dark_factor"><spring:message code="sys.client.dark.facte"/><!-- 暗保理 --></option>
						</select>
					</div>
           		</div>
           	</li>
            <li class="clear">
            	<div class="input_box">
            		<span><spring:message code="sys.client.productPresentation"/><!-- 产品介绍 -->：</span><textarea class="text_tea w400 h100" id="desc_" maxlength="500"></textarea>
            	</div>
            </li>
            
   	
    	</ul>
    	<div class="clear"></div>
        <div class="w_bottom">
        	<ul>
        		<li>
        			<sun:button tag='a' clazz='now' id='member_factor_product_Manage_addProductSave_btn' i18nValue='sys.client.save' />
        		</li>
        		<li><a id="anqu_close" onclick="add_close();"><spring:message code="sys.client.cancel"/><!-- 取消 --></a></li>
        	</ul>
        </div>
        
    </div>
</div>
</body>
</html>