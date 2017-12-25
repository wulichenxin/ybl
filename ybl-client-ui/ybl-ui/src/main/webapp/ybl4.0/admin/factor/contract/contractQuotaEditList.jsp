<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
	</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
	<body>
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />额度调整</div>
		</div>
		<form action="/contractQuotaV4Controller/contractQuotaPage" id="pageForm" method="post">
		<div class="w1200 mt40">
			<div class="ground-form mb20">
				<div class="form-grou mr50"><label>融资方名称：</label><input class="content-form" name="enterpriseName" value="${contractQuota.enterpriseName }"/></div>
				<div class="form-grou mr50" ><label style="width: 120px;">融资主合同号：</label><input class="content-form" name="masterContractNo" value="${contractQuota.masterContractNo }"/></div>
				<a href="javascript:void(0);" onclick="searchData()" class="btn-modify ml30">查询</a>
			</div>
			
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>融资方</th>
						<th>初始授信额度(元)</th>
						<th>最新授信额度(元)</th>
						<th>剩余可用金额(元)</th>
						<th>关联主融资合同号</th>
						<th>操作</th>
					</tr>
					<c:if test="${empty contractQuotaList}">
								<tr><td colspan="15">暂无数据</td></tr>
					</c:if>
					<c:forEach var="obj" items="${contractQuotaList}" varStatus="index" >
						<tr>
							<td>${index.count}</td>
							<td>${obj.enterpriseName }</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.creditAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.newCreditAmount }" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.allAmount }" /></td>
							<td> ${obj.masterContractNo } </td>
							
							<%-- <td><a class="linka"  url="" href="#" contractId="${obj.id }" status="1">调整</a>  --%>
							<td><a class="linka" href="#"  onclick="jumpPost('/contractQuotaV4Controller/quotaRecordList.htm',{contractId:${obj.id},status:'1'})">调整</a> 
							
							| 
							<a class="linka" href="#" onclick="jumpPost('/contractQuotaV4Controller/quotaRecordList.htm',{contractId:${obj.id},status:'2'})">查看</a></td>
						</tr>
						</c:forEach>
				</table>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		</form>
		<script type="text/javascript">
			function searchData() {
				$("#pageForm").submit();
			}
			function jumpPost(url,args) {
				var form = $("<form method='post'></form>");
		        form.attr({"action":url});
		        for (arg in args) {
		            var input = $("<input type='hidden'>");
		            input.attr({"name":arg});
		            input.val(args[arg]);
		            form.append(input);
		        }
		        $(document.body).append(form);
		        form.submit();
		    }
		</script>
	</body>

</html>