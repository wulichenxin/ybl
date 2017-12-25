<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>身份认证</title>
<%@include file="/ybl4.0/admin/common/link.jsp" %>
<script type="text/javascript" src="/ybl4.0/resources/js/doorl/cardAuth.js"></script>
</head>
<body>
	<div>
		<form action="/accountInfoController/saveCardInfo" id="DateForm" method="post">
		<input type="hidden" id="authType" value="${parameters.authStatus }"/>
		<c:forEach var="data" items="${attachmentList }">
			<c:if test="${data.type==1}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='legal_card_front_look' />
			</c:if>
			<c:if test="${data.type==2}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='legal_card_behind_look' />
			</c:if>
			<c:if test="${data.type==3}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='applicant_card_front_look' />
			</c:if>
			<c:if test="${data.type==4}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='applicant_card_behind_look' />
			</c:if>
			<c:if test="${data.type==5}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='company_authorization_id' />
			</c:if>
			<c:if test="${data.type==9}">
				<input type="hidden" value="${data.oldName}" attachUrl="${data.id}" id='business_license_look' />
			</c:if>
		</c:forEach>
		
		<p class="protitleWhite mb0"><span></span>机构信息认证</p>
		<div class="bottom-line"></div>
		<div class=" mt40 ml30">
			<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long3"><span style="color:red">*</span>企业全称：</label><input class="content-form2 validate[required,maxSize[20]]" id="enterpriseName" name="enterpriseName" value="${parameters.enterpriseName }" /></div>
			<div class="form-grou mr40"><label class="label-long2"><span style="color:red">*</span>统一社会信用代码：</label><input class="content-form2 validate[required,custom[social_credit_code]]" id="socialCreditCode" name="socialCreditCode" value="${parameters.socialCreditCode }"/></div>
		</div>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long3"><span style="color:red">*</span>企业简称：</label><input class="content-form2 validate[required,maxSize[20]]" id="enterpriseShortName" name="enterpriseShortName" value="${parameters.enterpriseShortName }"/></div>
			<div class="form-grou mr40"><label class="label-long2"><span style="color:red">*</span>法人手机号：</label><input class="content-form2 validate[required,custom[mobilePhone]]" id="legalPhone" name="legalPhone" value="${parameters.legalPhone }"/></div>
		</div>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long3"><span style="color:red">*</span>法人姓名：</label><input class="content-form2 validate[required,maxSize[20]]" id="legalName" name="legalName" value="${parameters.legalName }"/></div>
			<div class="form-grou mr40"><label class="label-long2"><span style="color:red">*</span>法人身份证号：</label><input class="content-form2 validate[required,custom[cardid]]" id="legalCardId" name="legalCardId" value="${parameters.legalCardId }"/></div>
		</div>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long3">申请人姓名：</label><input class="content-form2 validate[maxSize[20]]" id="applicantName" name="applicantName" maxlength="20" value="${parameters.applicantName }"/></div>
			<div class="form-grou mr40"><label class="label-long2">申请人手机号：</label><input class="content-form2 validate[custom[mobilePhone]]" id="applicantPhone" name="applicantPhone" maxlength="20" value="${parameters.applicantPhone }"/></div>
		</div>
		
		<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long3">申请人身份证号：</label><input class="content-form2 validate[custom[cardid]]" id="applicantCardId" name="applicantCardId" maxlength="20" value="${parameters.applicantCardId }"/></div>
			<div class="form-grou mr40"><label class="label-long2">申请人邮箱：</label><input class="content-form2 validate[custom[email]]" id="applicantEmail" name="applicantEmail" maxlength="20" value="${parameters.applicantEmail }"/></div>
		</div>
		
		</div>
		
		<p class="protitleWhite mb0"><span></span>上传附件</p>
		<div class="bottom-line"></div>
		<div class="pd20 mt30">
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>资料名称</th>
						<th>附件</th>
						<th class="fff">操作</th>
					</tr>
					<tr>
						<td>1</td>
						<td><span style="color:red">*</span>营业执照</td>
						<td id="business_license_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="business_license" utype="9" uname="营业执照" class="btn-modify">上传</a>
							<div id="business_license_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>2</td>
						<td style="left: 26px;"><span style="color:red">*</span>法人身份证正面照</td>
						<td id="legal_card_front_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="legal_card_front" utype="1" uname="法人身份证正面照" class="btn-modify">上传</a>
							<div id="legal_card_front_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>3</td>
						<td style="left: 26px;"><span style="color:red">*</span>法人身份证反面照</td>
						<td id="legal_card_behind_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="legal_card_behind" utype="2" uname="法人身份证反面照" class="btn-modify">上传</a>
							<div id="legal_card_behind_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>4</td>
						<td style="left: 30px;">申请人身份证正面照</td>
						<td id="applicant_card_front_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="applicant_card_front" utype="3" uname="申请人身份证正面照" class="btn-modify">上传</a>
							<div id="applicant_card_front_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>5</td>
						<td style="left: 30px;">申请人身份证反面照</td>
						<td id="applicant_card_behind_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="applicant_card_behind" utype="4" uname="申请人身份证反面照" class="btn-modify">上传</a>
							<div id="applicant_card_behind_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>6</td>
						<td>公司授权书</td>
						<td id="company_authorization_td">原件、复印件、加盖公章、提供扫描件</td>
						<td class="fff"><a href="javascript:;" id="company_authorization" utype="5" uname="公司授权书" class="btn-modify">上传</a>
							<div id="company_authorization_div" ><!-- 附件对象隐藏域 -->
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="shenmin"></div>
			<c:choose>
				<c:when test="${parameters.authStatus == 1}">
				<div style="text-align:center">
					<a href="javascript:;" class="btn-add close-out" >审核中</a>
				</div>
				</c:when>
				<c:when test="${parameters.authStatus == 2}">
				<div style="text-align:center">
					<a href="javascript:;" class="btn-add close-out" >已认证</a>
				</div>
				</c:when>
				<c:when test="${parameters.authStatus == 3}">
				<div class="btn2 clearfix mb80">
					<a href="javascript:;" class="btn-add" >审核失败</a>
					<a href="javascript:;" class="btn-add" id="submit_info">重新提交</a>
				</div>
				</c:when>
				<c:otherwise>
				<div class="btn2 clearfix mb80">
					<a href="javascript:;" class="btn-add" id="submit_info">提交</a>
					<a href="javascript:;" class="btn-add close-out" id="close_info">取消</a>
				</div>
				</c:otherwise>
			</c:choose>	
		</div>
		</form>
	</div>
	
	<!-- 文件上传form-->
    <iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>
</body>
</html>
