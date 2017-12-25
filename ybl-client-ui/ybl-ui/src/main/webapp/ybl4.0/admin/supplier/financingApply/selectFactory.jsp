<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>云保理</title>
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		
	</head>

	<body>
		
		<form action="/financingApplyV4Controller/financingApply/selectFactory.htm" id="pageForm" method="post">
			<input type="hidden" name="investorName" value="${param.investorName }">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>企业名称：</label><input class="content-form" name="enterpriseName" value="${param.enterpriseName }"/></div>
					<div class="form-grou"><a href="javascript:;" class="btn-modify" id="btn-query">查询</a></div>
				</div>
			</div>
		
			<div class="aj-cont mt40">
				<div class="tabD">
					<table>
						<tr>
							<th>请选择</th>
							<th>企业名称</th>
						</tr>
						<c:if test="${empty list}">
                            <tr><td colspan="12">暂无数据</td></tr>
                        </c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
							<tr>
								<td><input name="checkId" type="checkbox" <c:if test="${obj.isCheck == true}">checked="checked"</c:if> value="${obj.id}" uname="${obj.enterpriseName }"/></td>
								<td>${obj.enterpriseName}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="btn2 clearfix mb80 mt40">
					<a href="javascript:;" class="btn-add" id="btn-select-all">确定</a>
					<a onclick="dialog.close();" class="btn-add">取消</a>
				</div>
			</div>
		
		</form>
		
		<script>
			$('#btn-query').click(function(){
				$("#pageForm").submit();
			});
			// 选择确定
			$("#btn-select-all").click(function() {
				var chkIds = [];
				var chkNames = [];
				$("input[name='checkId']:checked").each(function() {
					var uname = $(this).attr("uname");
					chkIds.push($(this).val()+"-"+uname);
					chkNames.push(uname);
				});
				var val1 = window.parent.document.getElementById("investorName");
				var zfname =window.parent.document.getElementById("zfname");
				
				
				$(val1).val(chkIds.join(","));
				
				$(zfname).empty();
				for(var i=0;i<chkNames.length;i++){
					$(zfname).append('<div class="form-grou mb20 mr40"><label class="label-long">资方名称：</label><input readonly="readonly" class="content-form2" value="'+chkNames[i]+'"  /></div>')
				}
				dialog.close();
			});
		</script>
	</body>

</html>