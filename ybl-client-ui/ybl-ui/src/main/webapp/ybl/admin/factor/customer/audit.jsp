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
<jsp:include page="../../common/link.jsp" />
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#member_factor_sign_Manage_AuditConfirm_btn").click(function() {
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
		$("#submit").submit();
	})
	$("#submit").validate({
		submitHandler:function(form){  
       	 	$(form).ajaxSubmit({
        		success:function(resp){
        			if(resp.responseType == 'ERROR'){
        				alert(resp.info);/* 服务器繁忙请稍候重试 */
        			}else{
        				alert(resp.info, callback);/* 数据保存/更新成功 */ 
        			}         		
        		},
        		error:function(){
        			
        			alert("error");/* 服务器繁忙请稍候重试 */
        		}
        	});
   	 	}    
	});
	
	callback = function() {
		parent.parent.$(".msgbox_close").mousedown();
		parent.parent.location.href="/signController/myCustomer";
	}
	
})
</script>
</head>
<body>
<!--审核弹出框-->
	<form action="/signController/auditConfirm" id="submit" method="post">
		<input type="hidden" name="businessId" value="${memberSignId }">
		<input type="hidden" name="type" value="sign">
		<div class="vip_window_con">
            <div class="clear"></div>
            <div class="window_xx">
            	<ul>
                    <li class="clear">
                    	<div class="input_box"><span><spring:message code="sys.client.auditType" />：</span><!-- 提交类型 -->
                    		<input type="text"  placeholder="申请签约" readonly="readonly" class="text_gary w200" />
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="input_box"><span><spring:message code="sys.client.auditResult" />：</span><!-- 审核结果 -->
                    		<div class="select_box">
								<select name="operation" id="operation" class="select w200">
									<option value=""><spring:message code="sys.client.select" /></option><!-- 请选择 -->
									<option value="agree"><spring:message code="sys.client.agree" /></option><!-- 通过 -->
									<option value="disagree"><spring:message code="sys.client.disagree" /></option><!-- 不通过 -->
								</select>
							</div>
                   		</div>
                   	</li>
                    <li class="clear">
                    	<div class="input_box">
	                    	<span><spring:message code="sys.client.comment" />：</span><!-- 意见描述 -->
	                    	<textarea class="text_tea w400 h100" name="comment" id="comment"></textarea>
                    	</div>
                    </li>                           	
            	</ul>
            	<div class="clear"></div>
                <div class="w_bottom">
                	<ul>
                    	<li><sun:button tag='a' id='member_factor_sign_Manage_AuditConfirm_btn' i18nValue='sys.client.submit' clazz='now'/></li><!-- 提交 -->
                		<li><a id="anqu_close" onclick="add_close();"><spring:message code="sys.client.cancel" /></a></li><!-- 取消 -->
                	</ul>
                </div>              
            </div>
        </div>
     </form>
</body>
</html>