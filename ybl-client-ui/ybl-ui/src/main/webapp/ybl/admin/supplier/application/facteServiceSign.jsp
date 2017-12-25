
<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.facte.service"></spring:message>--<spring:message code="sys.client.signOpration"></spring:message></title><!-- 保理服务签约 -->
<jsp:include page="../../common/link.jsp" />
<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">
$(function(){
	
	//定义数组attachement
	var attachmentArray = "";
	/**
	 * 图片上传statrt
	 */
	//监听图片上传按钮
	$("#common_upload_btn").watchProperty("value",function() {
		var v = $(this).val();
		if(v == '' || v == null) return;
		// 上传
		$("#common_upload_form").attr("action", "/fileUploadController/uploadFtp?uploadUrl=/supplier/&_callback=uploadCallback");
		$("#common_upload_form").submit();
	});
	//点击图片上传图片
	$("#addPicture").click(function() {
		id=$(this).attr("id");
		$("#common_upload_btn").click();
	});
	//回调，回显图片
	uploadCallback = function(attachment) {
		//attachmentArray += attachment + "#";
		attach = eval("(" + attachment + ")");
		$("#common_upload_btn").val('');
		$(".vip_phone").find("dl").find("dd").last().before("<dd name='addAttach'> <a><img src='"+attach.url_ +"'/><i onclick='deleteAttachment(this)' value="+attachment+"></i></a></dd>");
	}
	//图片上传end
	
	
	
	//删除上传的文件
	deleteAttachment = function(_this){
		
		$(_this).parent().parent().remove();
	}
	
	
	//提交按钮
	$("#signApplyBtn").click(function(){
		if(!$("input[type='checkbox']").is(':checked')){
			alert($.i18n.prop("sys.client.please.sign.facteService.Agreement")); /*请签署保理服务协议 !*/
			return;
		}
		/* 获取附件信息 */
		var count = $("dd[name='addAttach']").size();
		for(var i=0;i<count; i++){
			attachmentArray += $("dd[name='addAttach'] img").eq(i).next().attr("value") + "#";
		}
		
		var enterprise2Id = $("input[name='enterprise2Id']").val();
		$("#signApplyBtn").hide();
		$("#signApplyingBtn").removeClass('none1');
		 $.ajax({
			type:'post',
			dataType:'json',
			url:"/facteServiceController/MemberSignApply",
			data:{
				"enterprise2Id":enterprise2Id,
				"attachmentArray":attachmentArray,
			},
			success:function(data){
				if(data.responseTypeCode=='success'){
					alert(data.info,callbackFacteService);
					
				}else{
					$("#signApplyBtn").show();
					$("#signApplyingBtn").addClass('none1');
					alert(data.info);
				}
			},
			error:function(){
				$("#signApplyBtn").show();
				$("#signApplyingBtn").addClass('none1');
				alert($.i18n.prop("sys.client.sign.apply.fail"));/* 签约申请失败 */
			 } 
		 })  
	})
	
	callbackFacteService=function(){
		
		$("#anqu_close").click();
		parent.window.location.href="/facteServiceController/facteService";
	}
})


</script>
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
			<ul>
				<li><div class="input_box">
						<span><spring:message code="sys.client.companyName"></spring:message> ：</span><input placeholder="" type="text"
							class="w300 text_gary" readonly="readonly" value="${enterprise.enterpriseName}"  /><!-- 企业名称 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.companyTelephone"></spring:message>：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.fixedPhone}"  /> <!-- 企业固定电话 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.licenseNumber"></spring:message> ：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.licenseNo}"  /><!-- 营业执照注册号 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.legalPersonName"></spring:message> ：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.legalName}"  /><!-- 法人代表名称 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.legal.person.Id.card"></spring:message> ：</span><input placeholder=""
							type="text" class="text_gary w300" readonly="readonly" value="${enterprise.legalCardId}"  /><!-- 法人代表身份证号 -->
					</div></li>
				<li><div class="input_box">
						<span><spring:message code="sys.client.legalPhone"></spring:message> ：</span><input placeholder="" type="text"
							class="text_gary w300"  readonly="readonly" value="${enterprise.legalPhone}"  /><!-- 联系电话号码 -->
					</div></li>
				<li class="w472"><div class="input_box">
						<span><spring:message code="sys.client.registe.amount"></spring:message> ：</span><input placeholder="" type="text"
							class="text_gary w200" readonly="readonly" value="${enterprise.registerAmount}" /> <!-- 企业注册资金 -->
					</div></li>
				<%-- <li>
					<div class="input_box">
						<span>企业规模：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.legalPhone}"  />
					</div></li>
				</li> --%>
				<li><div class="input_box">
						<span><spring:message code="sys.client.investBidManage.MainBusiness"></spring:message>：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.bussinessScope}" /><!-- 主营业务范围 -->
					</div></li>
				<%-- <li><div class="input_box">
						<span><spring:message code="sys.client.investBidManage.IndustryOwned"></spring:message> ：</span><input placeholder="" type="text"
							class="text_gary w300" readonly="readonly" value="${enterprise.type}"  /><!-- 所属行业 -->
					</div></li></li> --%>
				<li>
					<div class="input_box">
						<span><spring:message code="sys.cilent.sign.apply.license.upload"></spring:message> ：</span><!-- 证照上传 -->
						<div class="vip_phone">
							<dl>
								<c:forEach var="attache" items="${attachmentLidst}" varStatus="index" >
									<dd>
										<a><img src="${attache.url }"/></a>
									</dd>
								</c:forEach>
									<dd>
										<a id="addPicture"></a>
										<p><spring:message code="sys.client.sign.apply.other.license"></spring:message> </p><!-- 其他资料 -->
									</dd>
							</dl>
						</div>
					</div>
				</li>
				<li class="clear"><div class="w_agreen">
						<input id="agreeMent" type="checkbox" value="" /><spring:message code="sys.client.investBidManage.factoringServiceAgreement"></spring:message> <!-- 同意签署保理服务协议 -->
					</div></li>
			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
					<li><!-- <a id="signApplyBtn" class="now"> </a> -->
						<sun:button tag='a' id="signApplyBtn" clazz="now"  i18nValue="sys.client.sign.apply" /><!-- 签约申请 -->
						<sun:button tag='a' id="signApplyingBtn" clazz="now none1"  i18nValue="sys.client.sign.applying" /><!-- 签约申请中 -->
						
					</li>
					<li><!-- <a id="anqu_close"  >取消</a> -->
						<sun:button tag='a' id="anqu_close" i18nValue="sys.client.cancel" />
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 图片上传 部分 start -->
<iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
	<input id="common_upload_btn" type="file" name="file" style="display:none;" />
</form>
<input type="hidden" name="enterprise2Id" value="${enterprise2Id}">
</body>
</html>