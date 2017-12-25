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

	<body>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<!--top end -->
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">平台审核</li>
			</ul>
		</div>
		<div class="w1200 ybl-info box box1">
			<div class="chebox chebox1">
				<p class="protitle"><span></span>平台审核结果</p>
				<div class="pd20">
				  <div><label>审核结果：</label>
					  <c:if test="${not empty record.platformAudit and record.platformAudit eq 1}">
					  	通过
					  </c:if>
					  <c:if test="${not empty record.platformAudit and record.platformAudit eq 2}">
					  	不通过
					  </c:if>
				  </div>	  
				</div>  
				<br/>
				<div class="pd20">
					<label>备注</label><textarea class="protext btn-center">${record.platformRemark}</textarea>
				</div>
				
				<div class="bottom-line"></div>
			</div>
			
			<!-- <div class="btn3 clearfix mb80">
				<a href="javascript:;" class="btn-add">保存草稿</a>
				<a href="javascript:;" class="btn-add">保存并提交</a>
				<a href="javascript:;" class="btn-add">取消</a>
			</div> -->
			
			</div>
		</div>
		
	
		</div>
		
	</body>

</html>