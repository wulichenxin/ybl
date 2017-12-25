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
<title><spring:message code="sys.client.product.manage"/></title><!-- 产品管理 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
  

$(function(){
	//新增产品 
	$("#member_factor_product_Manage_addProduct_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		$.msgbox({
			height:432,
			width:620,
			content:'/ybl/admin/factor/product/productEdit.jsp',
			type :'iframe',
			title: '新增产品'
		});
	})
	
	//配置产品 
	$("#member_factor_product_Manage_ProductConfig_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		if(id == '' || id == null){
			alert($.i18n.prop("sys.client.product.PleaseSelectAProduct"));
			return false;
		}
		//根据id查出当前产品，判断是否已经审核
		$.ajax({
	        url: '/productManageController/queryProductInfoById', 
	        data:{id:id},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){
	        		if(data.object.audit_status == 'authstr' || data.object.audit_status == ''){//产品审核状态为待审核或未提交则可修改
	        			location.href="/productManageController/queryByProductId?id="+id;
	        		}else{
	        			alert("该产品已审核，不能重新编辑");
	        		}
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
		
	});
	//上线
	$("#member_factor_product_Manage_upProduct_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		if(id == '' || id == null || id < 0){
			alert($.i18n.prop("sys.client.product.PleaseSelectAProduct"));
			return false;
		}
		//根据id查出当前产品，判断是否已经审核
		$.ajax({
	        url: '/productManageController/queryProductInfoById', 
	        data:{id:id},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){
	        		if(data.object.audit_status == 'pass_the_audit'){//产品审核状态为审核通过才能做上线下线操作
	        			var status = "online";//状态改为上线
	        			$.ajax({
	        		        url: '/productManageController/updateProduct', 
	        		        data:{id:id,status_:status},
	        		        type: "post", 
	        		        async: true ,
	        		        dataType: "json",
	        		        success: function (data, textStatus, XMLHttpRequest) {
	        		        	if(data.responseTypeCode=='success'){//新增成功
	        		        		alert(data.info,call_back);
	        		        		
	        		        	}else{
	        		        		alert(data.info);
	        		        	}
	        		        }
	        		    });	
	        			
	        		}else{
	        			alert("该产品未审核通过，不能上线");
	        		}
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
	})
	
	//下线 
	$("#member_factor_product_Manage_downProduct_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		if(id == '' || id == null || id < 0){
			alert($.i18n.prop("sys.client.product.PleaseSelectAProduct"));
			return false;
		}
		//根据id查出当前产品，判断是否已经审核
		$.ajax({
	        url: '/productManageController/queryProductInfoById', 
	        data:{id:id},
	        type: "post", 
	        async: true ,
	        dataType: "json",
	        success: function (data, textStatus, XMLHttpRequest) {
	        	if(data.responseTypeCode=='success'){
	        		if(data.object.audit_status == 'pass_the_audit'){//产品审核状态为审核通过才能做上线下线操作
	        			var status = "offline"; //状态改为下线
	        			$.ajax({
	        		        url: '/productManageController/updateProduct', 
	        		        data:{id:id,status_:status},
	        		        type: "post", 
	        		        async: true ,
	        		        dataType: "json",
	        		        success: function (data, textStatus, XMLHttpRequest) {
	        		        	if(data.responseTypeCode=='success'){//新增成功
	        		        		alert(data.info,call_back);
	        		        		
	        		        	}else{
	        		        		alert(data.info);
	        		        	}
	        		        }
	        		    });	
	        			
	        		}else{
	        			alert("该产品未审核通过，不能下线");
	        		}
	        	}else{
	        		alert(data.info);
	        	}
	        }
	    });	
	})
	
	
	//查看产品详情
	$("#member_factor_product_Manage_lookProduct_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		if(id == '' || id == null){
			alert($.i18n.prop("sys.client.product.PleaseSelectAProduct"));
			return false;
		}
		window.location.href ="/productManageController/lookQueryByProductId?id="+ id;
	});
	//删除产品
	$("#member_factor_product_Manage_deleteProduct_btn").click(function(){
		var id = $('input[name="id"]:checked').val();
		if(id == '' || id == null || id < 0){
			alert($.i18n.prop("sys.client.product.PleaseSelectAProduct"));
			return false;
		}
		confirm("确定要删除吗?",function() {
			$.ajax({
		        url: '/productManageController/deleteProduct', 
		        data:{id:id},
		        type: "post", 
		        async: true ,
		        dataType: "json",
		        success: function (data, textStatus, XMLHttpRequest) {
		        	if(data.responseTypeCode=='success'){//新增成功
		        		alert(data.info,call_back);
		        	}else{
		        		alert(data.info);
		        	}
		        }
		    });	
		});
	});
	call_back = function(){
		window.location.href ="/productManageController/queryAllProduct";
	}
	
	
	//提交表单 
	$("#member_factor_product_Manage_query_btn").click(function(){
		$("#pageForm").submit();
	})
	//重置
	$("#reset").click(function(){
		$("input[name='name_']").val('');
		$("#type_").val('');
		$("#status_").val('');
	})
})
	
//限制多选框只能选一个
$(document).ready(function(){
    $('#pageForm').find('input[type=checkbox]').bind('click', function(){
        $('#pageForm').find('input[type=checkbox]').not(this).attr("checked", false);
    });
});
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	

	<div class="path"><spring:message code="sys.client.location"/><!-- 当前位置 -->-><spring:message code="sys.client.product.factory"/><!-- 产品工厂 --> -> <spring:message code="sys.client.product.manage"/><!-- 产品管理 --></div>
	<form action="/productManageController/queryAllProduct" id="pageForm" method="post">
	<div class="vip_conbody">

<!--搜索条件-->
	<div class="seach_box" id="submit_box">
    	<div class="switch" onclick="hideform();"><a></a></div>
        <div class="fl">
    	<ul>
        	<li><label><spring:message code="sys.client.productName"/><!-- 产品名称 -->:</label>
        		<input type="text" name="name_" value="${name_ }"/>
        	</li>
            <li><label><spring:message code="sys.client.factorType"/><!-- 保理类型 -->:</label>
	            <select name="type_" id="type_">
		            <option value=""><spring:message code="sys.client.queryAll"/><!-- 全部 --></option>
		            <option <c:if test="${type_ =='online_factor' }">selected="selected" </c:if> value="online_factor"><spring:message code="sys.client.online.clear.facte"/><!-- 明保理 --></option>
		            <option <c:if test="${type_=='dark_factor' }">selected="selected" </c:if> value="dark_factor"><spring:message code="sys.client.dark.facte"/><!-- 暗保理 --></option>
	            </select>
            </li>
            <li><label><spring:message code="sys.client.product.productStatus"/><!-- 产品状态 -->:</label>
            	<select name="status_" id="status_">
            		<option value=""><spring:message code="sys.client.queryAll"/><!-- 全部 --></option>
            		<option <c:if test="${status_=='online' }">selected="selected" </c:if> value="online"><spring:message code="sys.client.product.Online"/><!-- 上线 --></option>
            		<option <c:if test="${status_=='offline' }">selected="selected" </c:if> value="offline"><spring:message code="sys.client.product.Offline"/><!-- 下线 --></option>
            	</select>
            </li>
            <li><div class="button_yellow"><sun:button tag='a' id='member_factor_product_Manage_query_btn' i18nValue='sys.client.query' /></div></li>
            <li><div class="button_gary"><a id="reset"><spring:message code="sys.client.reset"/><!-- 重置 --></a></div></li>
        </ul>
        </div>
    </div>
    <!--搜索条件-->

    <!--table-->
    <div class="table_box ">
         <div class="table_top ">
         <div class="table_nav">
				<ul>
					<li><sun:button tag='a' id='member_factor_product_Manage_addProduct_btn' i18nValue='sys.client.product.addition' /><!-- 新增产品 --></li>
					<li><sun:button tag='a' id='member_factor_product_Manage_ProductConfig_btn' i18nValue='sys.client.product.productConfiguration' /><!-- 产品配置 --></li>
					<li><sun:button tag='a' id='member_factor_product_Manage_lookProduct_btn' i18nValue='sys.client.look' clazz='but_ico4'/><!-- 查看 --></li>
					<li><sun:button tag='a' id='member_factor_product_Manage_deleteProduct_btn' i18nValue='ybl.web.department.delete' clazz='but_ico1'/><!-- 删除 --></li>
					<li><sun:button tag='a' id='member_factor_product_Manage_upProduct_btn' i18nValue='sys.client.product.Online' clazz='but_ico9'/><!-- 上线 --></li>
					<li><sun:button tag='a' id='member_factor_product_Manage_downProduct_btn' i18nValue='sys.client.product.Offline' clazz='but_ico8'/><!-- 下线 --></li>
				</ul>
			</div>
			 </div>
        <!--按钮top-->
        <div class="table_con ">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
              <tr>
               <th width="50"><input type="checkbox"/></th>
               <th width="50"><spring:message code="sys.client.no"/><!-- 序号 --></th>
                <th><spring:message code="sys.client.productName"/><!-- 产品名称 --></th>
                <th><spring:message code="sys.client.factorType"/><!-- 保理类型 --></th>
                <th><spring:message code="sys.client.yearRate"/><!-- 年利率 --></th>
                <th><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 --></th>
                <th><spring:message code="sys.client.period.type"/><!-- 期限类型 --></th>
                <th><spring:message code="sys.client.financingProportion"/><!-- 融资比例 --></th>
                <th><spring:message code="sys.client.repaymentType"/><!-- 还款方式 --></th>
                <th><spring:message code="ybl.web.createTime"/><!-- 创建时间 --></th>
                <th><spring:message code="sys.client.product.productStatus"/><!-- 产品状态 --></th>
              </tr>
              <c:forEach var="product" items="${list}" varStatus="index" >
	              <tr>
	               	<td><input type="checkbox" name="id" value="${product.id_}"/></td>
	                <td>${index.count}</td>
	                <td>${product.name_ }</td>
	                <td>
                       	<c:if test="${product.type_ == 'online_factor' }"><spring:message code="sys.client.online.clear.facte"/><!-- 明保理 --></c:if>
	                	<c:if test="${product.type_ == 'dark_factor' }"><spring:message code="sys.client.dark.facte"/><!-- 暗保理 --></c:if>
                    </td>
	                <td><fmt:formatNumber value="${product.rate_ }" pattern="#,##0.00" maxFractionDigits="2"/>%</td>
	                <td>${product.term_ }</td>
	                <td>
	                	<c:if test="${product.loan_type == 'day' }"><spring:message code="sys.client.day"/><!-- 日 --></c:if>
	                	<c:if test="${product.loan_type == 'month' }"><spring:message code="sys.client.month"/><!-- 月 --></c:if>
	                	<c:if test="${product.loan_type == 'year' }"><spring:message code="sys.client.year"/><!-- 年 --></c:if>
	                </td>
	                <td><fmt:formatNumber value="${product.finance_ratio }" pattern="#,##0.00" maxFractionDigits="2"/>%</td>
	                <td><c:if test="${product.repayment_type == 'once' }"><spring:message code="sys.client.product.OneTimePayment"/><!-- 一次性还款 --></c:if></td>
	                <td>
	                	<jsp:useBean id="dateValue" class="java.util.Date" />
						<jsp:setProperty name="dateValue" property="time" value="${product.created_time }" />
						<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
	                </td>
	                <td>
	                	<c:if test="${product.status_ == 'online' }"><spring:message code="sys.client.product.Online"/><!-- 上线 --></c:if>
	                	<c:if test="${product.status_ == 'offline' }"><spring:message code="sys.client.product.Offline"/><!-- 下线 --></c:if>
	                	<c:if test="${product.status_ == '' }">
		                	<c:if test="${product.audit_status == 'authstr' }"><spring:message code="sys.client.auditing"/><!-- 审核中 --></c:if>
		                	<c:if test="${product.audit_status == 'audit_not_through' }"><spring:message code="sys.client.auditFail"/><!-- 审核不通过 --></c:if>
	                		<c:if test="${product.audit_status == 'pass_the_audit' }"><spring:message code="sys.client.product.passTheAudit"/><!-- 审核通过 --></c:if>
	                	</c:if>
	                </td>
	                
	              </tr>
              </c:forEach>
            </table>

        </div>
        <jsp:include page="../../common/page.jsp"></jsp:include>
    </div>
	<!--table-->
    
    </div>
    </form>
<!-- 底部jsp -->
<jsp:include page="../../common/bottom.jsp"/>
<!-- 底部jsp -->
</body>
</html>