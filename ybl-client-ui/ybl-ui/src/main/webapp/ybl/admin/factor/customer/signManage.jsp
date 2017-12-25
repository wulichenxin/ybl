<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>

<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.sign.manage"/></title><!-- 签约管理 -->

<title><spring:message code="sys.client.sign.manage"/></title> <!-- 签约管理 -->

<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
$(function(){
	
	
	$("#member_factor_sign_Manage_look_btn").click(function(){
		var id_ = $('input[name="enterpriseId"]:checked').val();
		var memberSignId= $("input[name='enterpriseId']").attr("memberSignId");
		if(id_ == '' || id_ == null){
			alert($.i18n.prop("sys.client.investBidManage.selectAClient"));
			return false;
		}
			$.msgbox({
				height:610,
				width:1000,
				content:'/signController/queryEnterpriseByCondition?id_='+id_+"&memberSignId="+memberSignId+"&type=look",
				type :'iframe',
				title: '签约'
			});
			$('body').css({overflow:'hidden'});
	})
		
	
		
	$("#member_factor_sign_Manage_sign_btn").click(function(){
		var id_ = $('input[name="enterpriseId"]:checked').val();
		var memberSignId= $("input[name='enterpriseId']").attr("memberSignId");
		if(id_ == '' || id_ == null){
			alert($.i18n.prop("sys.client.investBidManage.selectAClient"));
			return false;
		}
			$.msgbox({
				height:610,
				width:1000,
				content:'/signController/queryEnterpriseByCondition?id_='+id_+"&memberSignId="+memberSignId+"&type=audit",
				type :'iframe',
				title: '签约'
			});
			$('body').css({overflow:'hidden'});
	})
	
	
		
	$("#member_factor_sign_Manage_query_btn").click(function(){
		$("#pageForm").submit();
	})
	//重置
	$("#reset").click(function(){
		$("#enterprise_name").val('');
		/* $("input").val(''); */
		$("#status_").val('');
	})
});
$(document).ready(function(){
    $('#pageForm').find('input[type=checkbox]').bind('click', function(){
        $('#pageForm').find('input[type=checkbox]').not(this).attr("checked", false);
    });
});

</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=7" />
	<!--top end -->
		<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.customer.manage"/> -> <spring:message code="sys.client.sign.manage"/></div>
	<div class="vip_conbody">
	<form action="/signController/myCustomer" id="pageForm" method="post">
	<!--搜索条件-->
	<div class="seach_box" id="submit_box">
    	<div class="switch" onclick="hideform();"><a></a></div>
        <div class="fl">
    	<ul>
        	<li><label><spring:message code="sys.client.clientName"/><!-- 客户名称 -->:</label><input type="text" name="enterprise_name" id="enterprise_name" value="${enterprise_name }"/></li>
            <li><label><spring:message code="sys.client.investBidManage.SigningStatus"/><!-- 签约动态 -->:</label>
            	<select name="status_" id="status_"><option value=""><spring:message code="sys.client.queryAll"/></option>
					<option <c:if test="${status_ =='signed' }">selected="selected" </c:if> value="signed"><spring:message code="sys.client.investBidManage.Signed"/><!-- 已签约 --></option>
					<option <c:if test="${status_ =='signing' }">selected="selected" </c:if> value="signing"><spring:message code="sys.client.investBidManage.PendingContract"/><!-- 待签约 --></option>
					<option <c:if test="${status_ =='unsign' }">selected="selected" </c:if> value="unsign"><spring:message code="sys.client.investBidManage.unsign"/><!-- 拒绝 --></option>
				</select>
            </li>
           
            <li><div class="button_yellow"><sun:button tag='a' id='member_factor_sign_Manage_query_btn' i18nValue='sys.client.query' /></div></li>
            <li><div class="button_gary"><a id="reset"><spring:message code="sys.client.reset"/><!-- 重置 --></a></div></li>
        </ul>
        </div>
    </div>
    <!--搜索条件-->

    <!--table-->
    <div class="table_box">
    	<div class="table_top ">
			<div class="table_nav">
				<ul>
					<li><sun:button tag='a' id='member_factor_sign_Manage_look_btn' i18nValue='sys.client.look' clazz='but_ico2'/><!-- 查看 --></li>
					<li><sun:button tag='a' id='member_factor_sign_Manage_sign_btn' i18nValue='sys.client.investBidManage.ContractAudit' clazz="but_ico3"/><!-- 签约审核 --></li>
				</ul>
			</div>
		</div>
        <!--按钮top-->
        <div class="table_con">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
              <tr>
               <th width="50"></th>
               <th width="50"><spring:message code="sys.client.no"/><!-- 序号 --></th>
                <th width="200"><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
                <th width="150"><spring:message code="sys.client.licenseNumber"/><!-- 营业执照号 --></th>
                <th width="100"><spring:message code="sys.client.registe.amount"/><!-- 注册资金/万 --></th>
				<th width="200"><spring:message code="sys.client.investBidManage.MainBusiness"/><!-- 主营业务 --></th>
                <th width="100"><spring:message code="sys.client.investBidManage.contacts"/><!-- 联系人 --></th>
				<th width="100"><spring:message code="sys.client.phone"/><!-- 联系电话 --></th>
				<th width="100"><spring:message code="sys.client.investBidManage.ApplicationForSigningTime"/><!-- 申请签约时间 --></th>
                <th width="100"><spring:message code="sys.client.investBidManage.SigningStatus"/><!-- 签约状态 --></th>
              </tr>
              <c:forEach var="enterprise" items="${list}" varStatus="index" >
              <tr class="bg_l">
              	<td><input type="checkbox"  name="enterpriseId" value="${enterprise.enterprise_id}" memberSignId="${enterprise.id_1}"/></td>
                <td>${index.count}</td>
                <td>${enterprise.enterprise_name}</td>
				<td>${enterprise.license_no}</td>
				<td><fmt:formatNumber value="${enterprise.register_amount /10000}" pattern="#,##0.00" maxFractionDigits="2"/><spring:message code="sys.client.tenThousand"/></td>
				<td>${enterprise.bussiness_scope}</td>
				<td>${enterprise.legal_name}</td>
				<td>${enterprise.legal_phone}</td>
				<td>
					<jsp:useBean id="dateValue" class="java.util.Date" />
					<jsp:setProperty name="dateValue" property="time" value="${enterprise.created_time}" />
					<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
				</td>
				<td><c:if test="${enterprise.status_ =='signed'}">
						<spring:message code="sys.client.investBidManage.Signed"/><!-- 已签约 -->
					</c:if>  
					<c:if test="${enterprise.status_ =='unsign'}">
						<spring:message code="sys.client.investBidManage.unsign"/><!-- 拒绝 -->
					</c:if>  
					<c:if test="${enterprise.status_ =='signing'}">
						<spring:message code="sys.client.investBidManage.PendingContract"/><!-- 待审核 -->
					</c:if>
					<c:if test="${enterprise.status_ == ''}">
						<spring:message code="sys.client.investBidManage.NotSigned"/><!-- 未签约 -->
					</c:if>
				</td>
              </tr>
              </c:forEach>
            </table>

        </div>
        
    </div>
    <jsp:include page="../../common/page.jsp"></jsp:include>
	<!--table-->
	</form>
        
    </div>
	
<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>