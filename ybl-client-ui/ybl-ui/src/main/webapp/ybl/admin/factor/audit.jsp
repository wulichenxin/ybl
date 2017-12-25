<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><span><spring:message code='sys.client.auditOperator'/><!-- 审核 --></title>   
<jsp:include page="../common/link.jsp" />
</head>
<script src="${app.staticResourceUrl}/ybl/resources/js/factor/audit.js"></script>

<script type="text/javascript">
</script>
<body>
<!--审核弹出框-->
<div class="vip_window_con">

			<input style="display: none;" id="financeId" type="text" value="${ids}"/> 
			<input style="display: none;" id="auditType" type="text" value="${auditType}"/> 
			
            <div class="clear"></div>
            <div class="window_xx">
            	<ul>
                    <li class="clear">
                    	<div class="input_box"><span><spring:message code='sys.client.auditType'/><!-- 提交类型 -->：</span>
                    		<div class="select_box">
										<select class="select w200" id="status_" disabled="disabled">
										${auditTypeHtml }
										</select>
							</div>
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="input_box"><span><spring:message code='sys.client.auditResult'/>：</span>
                    		<div class="select_box">
										<select class="select w200" id="audit_operation">  
										${operationHtml }
										</select>
									</div>
                   		</div>
                   	</li>
                    <li class="clear">
                    <div class="input_box" ><span><spring:message code='sys.client.comment'/><!-- 意见描述 -->：</span>
                    <textarea id="audit_comment" class="text_tea w400 h100"></textarea></div></li>                           	
            	</ul>
            	<div class="clear"></div>
                <div class="w_bottom">
                	<ul>
                    	<li>
                    	
                    	<sun:button id="ybl_facor_risk_audit_btn" tag='a' clazz="now" i18nValue="sys.client.auditOperator" /><!-- 审核 -->
                    	
                    	</li>
                		<li><a  class="close_msg_window" id="anqu_close" ><spring:message code='sys.client.cancel'/><!-- 取消 --></a></li>
                	</ul>
                </div>              
            </div>
        </div>
</body>
</html>