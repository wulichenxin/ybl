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
		archives = [];
	    for(k in obj){
	        if(obj[k].checked)
	        	archives.push(obj[k].value);
	    }
	    var archive = archives.toString();
		if(archive == '' || archive == null){
			alert("请选择贷款归档材料配置 !");
			return false;
		}
		$.ajax({
	        url: '/productManageController/insertProductArchive', 
	        data:{archives:archive,productId:productId,enterpriseId:enterpriseId},
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
	$("#member_factor_product_Manage_addProductArcSave_btn").click(function(){
		var arcTb_length = parent.$("#arcTb").find("tr").length;
		var tb_html_ = '';
		var checkArr = $("input[type='checkbox']:checked");
		var checkValue  = [];
		$.each(checkArr,function(i,item){
			if($(item).val()){
				checkValue.push($(item));
			}
		})
		
		if(!checkValue){
			alert("请选择要添加的归档材料");
			return false;
		}
		
		$.each(checkValue, function(i, item) {
			if ($(item).val()) {
				var tb_html_ = '';
				var ArcId = $(this).val();
				var name = $(this).parent().parent().find("td").eq(2).html();
				var remark = $(this).parent().parent().find("td").eq(3).html();
				
				tb_html_ += "<tr >";
				tb_html_ += "<td><input type='checkbox' name='checkArc' value="+ArcId+" /></td>";
				tb_html_ += "<td>" + (i+arcTb_length) + "</td>";
				tb_html_ += "<td>" + name + "</td>";
				tb_html_ += "<td>" + remark + "</td>";
				tb_html_ += "<input type='hidden' name='archiveMaterialList["+i+"].name' value='"+name+"'/>";
				tb_html_ += "<input type='hidden' name='archiveMaterialList["+i+"].remark' value='"+remark+"'/>";
				tb_html_+= "</tr>";
	
				parent.$("#arcTb").children().children("tr:last-child").after(tb_html_);
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
	            <th width="30%"><spring:message code="sys.client.investBidManage.ArchiveMaterialName"/><!-- 归档材料名称 --></th>
	            <th width="30%"><spring:message code="sys.client.remark"/><!-- 备注 --></th>
            </tr>
            <c:forEach var="archives" items="${list}" varStatus="index" >
            <tr>
	            <td width="10%"><input type="checkbox" name="id" value="${archives.id_ }"/></td>
	            <td width="30%">${index.count}</td>
	            <td width="30%">${archives.name_ }</td>
	            <td width="30%">${archives.remark_ }</td>
	        </tr>
	        </c:forEach>
    	</table>
    	<div class="clear"></div>
        <div class="w_bottom">
        	<ul>
            	<li><sun:button tag='a' clazz='now' id='member_factor_product_Manage_addProductArcSave_btn' i18nValue='sys.client.save' /></li>
        		<li><a id="anqu_close" onclick="add_close();"><spring:message code="sys.client.cancel"/><!-- 取消 --></a></li>
        	</ul>
        </div>
        
    </div>
</div>
</body>
</html>