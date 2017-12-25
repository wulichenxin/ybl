<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.auditOperator" /></title> <!-- 审核 -->
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#anqu_close").click(function() {
		parent.parent.$(".v2_msgbox_close").mousedown();
	});
	
	//下载文件
	$(".filedown").click(function(){
		var newName = $(this).attr("value");
		var oldName = $(this).attr("name");
		if(newName == null || oldName == null){
			return;
		}
		$("#newName").val(newName);
		$("#oldName").val(oldName);
		$("#download").submit();
	})
	
})
</script>
</head>
<body class="v2_no_minwidth bg_w">
<!--审核弹出框-->
		<div class="v2_window">
            <div class="v2_window_con">
            	<ul>
                    <li class="clear">
                    	<div class="v2_input_box"><span><spring:message code="sys.client.auditType" />：</span><!-- 提交类型 -->
                    		<c:if test="${auditRecord.status_ == 'first_trial'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.v2.client.riskFirstAudit" />" readonly="readonly" class="v2_text_gary w200" />
                    		</c:if>
                    		<c:if test="${auditRecord.status_ == 'analyze'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.v2.client.analysis" />" readonly="readonly" class="v2_text_gary w200" />
                    		</c:if>
                    		<c:if test="${auditRecord.status_ == 'recheck'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.v2.client.riskReAudit" />" readonly="readonly" class="v2_text_gary w200" />
                    		</c:if>
                    		<c:if test="${auditRecord.status_ == 'business'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.v2.client.businessHandling" />" readonly="readonly" class="v2_text_gary w200" />
                    		</c:if>
                   		</div>
                   	</li>
                   	
                   	<li class="clear">
                    	<div class="v2_input_box"><span><spring:message code="sys.client.auditResult" />：</span><!-- 审核结果 -->
                    		<c:if test="${auditRecord.operation_ == 'agree'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.client.agree" />" readonly="readonly" class="v2_text_gary w200" />
                   			</c:if>
                   			<c:if test="${auditRecord.operation_ == 'disagree'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.client.disagree" />" readonly="readonly" class="v2_text_gary w200" />
                   			</c:if>
                   			<c:if test="${auditRecord.operation_ == 'turn_down'}">
                    			<input type="w300 v2_text" value="<spring:message code="sys.v2.client.rejected" />" readonly="readonly" class="v2_text_gary w200" />
                   			</c:if>
                   		</div>
                   	</li>
                    <li class="clear">
                    	<div class="v2_input_box">
	                    	<span><spring:message code="sys.client.comment" />：</span><!-- 意见描述 -->
	                    	<textarea class="v2_text_tea w300 h100" >${auditRecord.comment_ }</textarea>
                    	</div>
                    </li>                           	
            	</ul>
            	
            	<div class="v2_table_con1">
					<table>
						<tr>
							<th width="50"><spring:message code="sys.v2.client.no" /><!-- 序号 --></th>
							<th width="200"><spring:message code="sys.v2.client.AttachmentName" /><!-- 附件名称 --></th>
							<th><spring:message code="sys.v2.client.remark" /><!-- 备注 --></th>
							<th><spring:message code="sys.v2.client.uploadTime" /><!-- 上传时间 --></th>
							<th><spring:message code="sys.v2.client.operation" /><!-- 操作 --></th>
						</tr>
						<c:forEach var="list" items="${attachmentList}" varStatus="index">
						<tr>
							<td>${index.count }</td>
							<td>${list.old_name }</td>
							<td>${list.attribute1_}</td>
							<td>
								<jsp:useBean id="dateValue2" class="java.util.Date" />
								<jsp:setProperty name="dateValue2" property="time" value="${list.created_time }" />
								<fmt:formatDate value="${dateValue2}" pattern="yyyy-MM-dd HH:mm:ss" />
							</td>
							<td><a class="lan filedown" value="${list.new_name}" name="${list.old_name }"><spring:message code="sys.v2.client.download" /><!-- 下载 --></a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
            	
            	<div class="clear"></div>
	            <div class="v2_but_list" >
					<a class="bg_g" id="anqu_close" onclick="add_close();"><spring:message code="sys.v2.client.cancel" /></a>
				</div>
            </div>
        </div>
<!-- 下载 -->
	<form action="/fileUploadController/fileDownload" id="download" style="disblay:none" target="_hide">
		<input type="hidden" name="newName" id="newName"/>
		<input type="hidden" name="oldName" id="oldName"/>
		<input type="hidden" name="workingDir" value="factorAudit"/>
	</form>
	<iframe name="_hide" style="display: none;"></iframe>
</body>
</html>