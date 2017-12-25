<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> --%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
		 <script type='text/javascript' src="${app.staticResourceUrl}/ybl4.0/resources/js/validate-for-apply/jquery.validationEngine.js"></script>
	</head>

	<body>
		<%-- <div class="Bread-nav">
			<div ><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务认证<span class="mr10 ml10">-</span>资金方业务认证</div>
		</div> --%>
		<div class=" clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">机构基本情况</li>
				<li class="formli">资料清单</li>
			</ul>
		</div>
		
 		<form action="/serviceAuthenticationController/addOrUpdateAuth" id="supplierDateForm" method="post">
 		<input type="hidden" value="${authType }" name="authType" id="authType">
		<!-- commom start -->
	    <jsp:include page="/ybl4.0/admin/doorl/serviceAuth/authCommon.jsp" />
		<!-- commom end -->
		
		<!-- attchment start -->
			<div class=" ybl-info box box2">
			<div class="pd20">
						<div class="tabD">
							<table>
								<tr>
									<th>序号</th>
									<th>资料名称</th>
									<th>上传附件</th>
									<th>操作</th>
								</tr>
								<c:if test="${empty attachmentList }">
								<tr>
									<td>1</td>
									<td class="maxwidth200"><span style="color:red">*</span>营业执照(三证合一)</td>
									<td class="maxwidth200" id="business_license_td" >原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='business_license' utype="12" uname="营业执照(三证合一)" class="btn-modify mr10">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="business_license_div"></div>
									</td>
								</tr>
								<tr>
									<td>2</td>
									<td class="maxwidth200"><span style="color:red">*</span>开户许可证</td>
									<td class="maxwidth200" id="license_account_td">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='license_account' utype="13" uname="开户许可证" class="btn-modify">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="license_account_div"></div>
									</td>
								</tr>
								<tr>
									<td>3</td>
									<td class="maxwidth200"><span style="color:red">*</span>机构信用代码证</td>
									<td class="maxwidth200" id="credit_code_td">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='credit_code' utype="14" uname="机构信用代码证" class="btn-modify">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="credit_code_div"></div>
									</td>
								</tr>
								<tr>
									<td>4</td>
									<td class="maxwidth200"><span style="color:red">*</span>法人代表人身份证</td>
									<td class="maxwidth200" id="legal_representative_identity_card_td">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='legal_representative_identity_card' utype="15" uname="法人代表人身份证" class="btn-modify">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="legal_representative_identity_card_div"></div>
									</td>
								</tr>
								<tr>
									<td>5</td>
									<td class="maxwidth200">公司章程</td>
									<td class="maxwidth200" id="association_articles_td">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='association_articles' utype="16" uname="公司章程" class="btn-modify">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="association_articles_div"></div>
									</td>
								</tr>
								<tr>
									<td>6</td>
									<td class="maxwidth200">验资报告</td>
									<td class="maxwidth200" id="capital_verification_report_td">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="javascript:;" id='capital_verification_report' utype="17" uname="验资报告" class="btn-modify">上传</a>
										<%-- 附件对象隐藏域  --%>  
										<div id="capital_verification_report_div"></div>
									</td>
								</tr>
								</c:if>
								<c:if test="${not empty attachmentList }">
								<c:forEach var="attachmentListData" items="${attachmentList }" varStatus="status">
								<tr>
									<td>${status.index + 1 }</td>
									<td class="maxwidth200">${attachmentListData.remark }</td>
									<td class="maxwidth200">${attachmentListData.oldName }</td>
									<td><a href='/fileDownloadController/downloadNow?newName=${attachmentListData.newName }&oldName=${attachmentListData.oldName }&extName=${attachmentListData.extName }' class="btn-modify">下载</a>
									</td>
								</tr>
								</c:forEach>
								</c:if>
							</table>
					</div>
				</div>
			</div>
			<!-------------------------------------------------- attchment end ----------------------------------------------------------------------->	
				
			<div class="bottom-line"></div>
			<div class="shenmin"><input id="check" type="checkbox" <c:if test="${looktype eq 'look' }">checked="checked" readonly="readonly"</c:if> />申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div>
		    <div class="btn2 clearfix mb80">
		    	<c:if test="${looktype ne 'look' }">
				<a href="javascript:;" class="btn-add" id='supplier_auth_message_save_btn'>提交</a>
				<a href="javascript:;" class="btn-add" id="go_to_back">返回</a>
				</c:if>
			</div>	
			<c:if test="${looktype eq 'look' }">
				<a href="javascript:;" class="btn-add btn-center mb80" id="go_to_back">返回</a>	
				</c:if>			
		</form>
		
		<!-- 文件上传form-->
    <iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>
		
	</body>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/doorl/serviceAuth.js"></script>
	<!--弹出框-->
        <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
        <script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
        
</html>