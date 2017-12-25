<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.auditOperator" /></title> <!-- 审核 -->
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#enterprise_accountAffirm_audit_btn").click(function() {
		//校验 
		var operation = $("#operation").val();
		if(operation == '' || operation == null){
			alert($.i18n.prop("sys.client.investBidManage.selectTheAuditResults"));/* "请选择审核结果! " */
			return false;
		}
		var comment = $("#comment").val();
		if(comment == '' || comment == null){
			alert($.i18n.prop("sys.client.investBidManage.fillInTheAuditOpinion"));/* "请填写审核意见! " */
			return false;
		}
		
		$("#enterprise_accountAffirm_audit_btn").hide();
		$("#enterprise_accountAffirm_auditing_btn").show();
		
		
		$("#submit").submit();
	})
	$("#submit").validate({
		submitHandler:function(form){  
       	 	$(form).ajaxSubmit({
        		success:function(resp){
        			if(resp.responseType == 'ERROR'){
        				$("#enterprise_accountAffirm_audit_btn").show();
        				$("#enterprise_accountAffirm_auditing_btn").hide();
        				alert(resp.info);/* 服务器繁忙请稍候重试 */
        			}else{
        				alert(resp.info, callback);/* 数据保存/更新成功 */ 
        			}         		
        		},
        		error:function(){
        			$("#enterprise_accountAffirm_audit_btn").show();
    				$("#enterprise_accountAffirm_auditing_btn").hide();
        			alert("error");/* 服务器繁忙请稍候重试 */
        		}
        	});
   	 	}    
	});
	
	callback = function() {
		parent.parent.$(".msgbox_close").mousedown();
		parent.parent.location.href="/accountsAffirmController/queryList";
	}
	
	$("#anqu_close").click(function() {
		parent.$(".v2_msgbox_close").mousedown();
	});
	
})
</script>
</head>
<body class="v2_no_minwidth bg_w">
<!--审核弹出框-->
	<form action="/accountsAffirmController/auditConfirm" id="submit" method="post">
		<input type="hidden" name="businessId" value="${accountId }">
		<input type="hidden" name="type" value="ybl_v2_accounts_receivable_submit">
		<input type="hidden" name="accountStatus" value="distribution"/>
		<div class="v2_window">
            <div class="v2_window_con">
            	<ul>
                    <li class="clear">
                    	<div class="v2_input_box"><span><spring:message code="sys.client.auditType" />：</span><!-- 提交类型 -->
                    		<input type="w300 v2_text"  placeholder="账款确认" readonly="readonly" class="v2_text_gary w200" />
                   		</div>
                   	</li>
                   	
                   	<li class="clear">
                    	<div class="v2_input_box"><span><spring:message code="sys.client.auditResult" />：</span><!-- 审核结果 -->
                    		<div class="v2_select_box mb20">
								<select name="operation" id="operation" class="v2_select w220">
									<option value=""><spring:message code="sys.client.select" /></option><!-- 请选择 -->
									<option value="agree"><spring:message code="sys.client.agree" /></option><!-- 通过 -->
									<option value="disagree"><spring:message code="sys.client.disagree" /></option><!-- 不通过 -->
								</select>
							</div>
                   		</div>
                   	</li>
                    <li class="clear">
                    	<div class="v2_input_box">
	                    	<span><spring:message code="sys.client.comment" />：</span><!-- 意见描述 -->
	                    	<textarea class="v2_text_tea w300 h100" name="comment" id="comment"></textarea>
                    	</div>
                    </li>                           	
            	</ul>
            	<div class="clear"></div>
	            <div class="v2_but_list" >
					<a class="bg_l" id="enterprise_accountAffirm_audit_btn"><spring:message code="sys.v2.client.save" /></a>
					<a class="bg_l" id="enterprise_accountAffirm_auditing_btn" style="display:none"><spring:message code="sys.v2.client.saving" /></a>
					<a class="bg_g" id="anqu_close" onclick="add_close();"><spring:message code="sys.v2.client.cancel" /></a>
				</div>
            </div>
        </div>
     </form>
</body>
</html>