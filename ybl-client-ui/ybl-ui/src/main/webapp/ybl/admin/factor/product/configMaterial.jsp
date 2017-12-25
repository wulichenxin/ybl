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
	var productId = $("#productId").val();
	$("#add").click(function(){
		var enterpriseId = $("#enterpriseId").val();
		obj = document.getElementsByName("id");
		materials = [];
	    for(k in obj){
	        if(obj[k].checked)
	        	materials.push(obj[k].value);
	    }
	    var material = materials.toString();
		if(material == '' || material == null){
			alert("请选择贷款材料配置 !");
			return false;
		}
		$.ajax({
	        url: '/productManageController/insertProductMateria', 
	        data:{materials:material,productId:productId,enterpriseId:enterpriseId},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){//新增成功
	        		alert(data.info,callback);
	        	}else{
	        		alert(data.info);
	        		$("#anqu_close").click();
	        	}
	        }
	    });	
	});
	
	callback = function(){
		parent.window.location.href ="/productManageController/queryByProductId?id="+ productId;
		parent.$(".msgbox_close").mousedown();
	}
	
	$("#anqu_close").click(function() {
		parent.$(".msgbox_close").mousedown();
	});
	
	//全选
	$("#checkAll").click(function(){
		var isCheckAll = $("#checkAll").attr("checked");
		if(isCheckAll){//全选
			$('input[name="id"]').each(function(){ 
				$(this).attr("checked",true);
			});
		}else{//取消全选
			$('input[name="id"]').each(function(){ 
				$(this).attr("checked",false);
			});
		}		
	});
})
$(function() {
	$("#member_factor_product_Manage_addProductMaterialSave_btn").click(function(){
		var matTb_length = parent.$("#matTb").find("tr").length;
		var tb_html_ = '';
		var checkArr = $("input[type='checkbox']:checked");
		var checkValue  = [];
		$.each(checkArr,function(i,item){
			if($(item).val()){
				checkValue.push($(item));
			}
		})
		
		if(!checkValue){
			alert("请选择要添加的材料");
			return false;
		}
		
		$.each(checkValue, function(i, item) {
			if ($(item).val()) {
				var tb_html_ = '';
				var MatId = $(this).val();
				var name = $(this).parent().parent().find("td").eq(2).html();
				var remark = $(this).parent().parent().find("td").eq(3).html();
				
				tb_html_ += "<tr >";
				tb_html_ += "<td><input type='checkbox' name='checkMat' value="+MatId+" /></td>";
				tb_html_ += "<td>" + (i+matTb_length) + "</td>";
				tb_html_ += "<td>" + name + "</td>";
				tb_html_ += "<td>" + remark + "</td>";
				tb_html_ += "<input type='hidden' name='materialList["+i+"].name' value='"+name+"'/>";
				tb_html_ += "<input type='hidden' name='materialList["+i+"].remark' value='"+remark+"'/>";
				tb_html_+= "</tr>";
	
				parent.$("#matTb").children().children("tr:last-child").after(tb_html_);
			}
		})
		//关闭弹出框
		parent.$(".msgbox_close").mousedown();
		
	})
})
</script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.product.manage"/>-<spring:message code="ybl.web.department.add"/>/<spring:message code="ybl.web.department.modify"/></title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--弹出窗登录-->

<div class="vip_window_con">
	<input type="hidden" id="productId" value="${productId }">
    	<input type="hidden" id="enterpriseId" value="${enterpriseId }">
    <div class="clear"></div>
    <div class="window_xx table_con">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
    		<tr>
	    		<th width="10%"><input type="checkbox" id="checkAll" name="" value=""/></th>
	            <th width="30%"><spring:message code="sys.admin.serial.number"/><!-- 序号 --></th>
	            <th width="30%"><spring:message code="sys.client.materialName"/><!-- 材料名称 --></th>
	            <th width="30%"><spring:message code="sys.client.remark"/><!-- 备注 --></th>
            </tr>
            <c:forEach var="material" items="${list}" varStatus="index" >
            <tr>
	            <td width="10%"><input type="checkbox" name="id" value="${material.id_ }"/></td>
	            <td width="30%">${index.count}</td>
	            <td width="30%">${material.name_ }</td>
	            <td width="30%">${material.remark_ }</td>
	        </tr>
	        </c:forEach>
    	</table>
    	<div class="clear"></div>
        <div class="w_bottom">
        	<ul>
            	<li>
            		<sun:button tag='a' clazz='now' id='member_factor_product_Manage_addProductMaterialSave_btn' i18nValue='sys.client.save' />
            	</li>
        		<li><a id="anqu_close" onclick="add_close();"><spring:message code="sys.client.cancel"/><!-- 取消 --></a></li>
        	</ul>
        </div>
        
    </div>
</div>
</body>
</html>