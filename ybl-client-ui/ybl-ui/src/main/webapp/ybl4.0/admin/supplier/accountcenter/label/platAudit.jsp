<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<script type="text/javascript">
		$(function(){ 
			
		});
	</script>
	<body>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<!--top end -->
		<div class="w1200">
				<p class="protitle"><span>平台审核结果</span></p>
					<div class="form-grou mb20"><label style="width:82px">审核结果：</label>
						<select class="content-form" disabled="true">
							<option <c:if test="${audit_result==1 }">selected="selected"</c:if> >通过</option>
							<option <c:if test="${audit_result==2 }">selected="selected"</c:if> >未通过</option>
						</select>
					</div>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" >${remark }</textarea>
					</div>	
					<div class="ground-form mb20">
					</div>
				
					<div class="bottom-line mb20"></div>
					<!-- <div class="btn3 clearfix mb80"> -->
						<a href="#" class="btn-add btn-center"  id="btn-16">下一页</a>
					<!-- </div> -->
		</div>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#btn-16").click(function(){
					$('.iconlist', parent.document).removeClass('pro_li_cur');
					$('#iconlist2', parent.document).addClass('pro_li_cur');
					var orderNo=$('#orderNo', parent.document).val();
					var financingAmount=$('#financingAmount', parent.document).val();
					window.location.href="/tabDetailController/selectSettleInfoByLoanOrderNo?orderNo=" + orderNo + "&financingAmount=" + financingAmount;
				});
			});
		</script>
	</body>
	
</html>