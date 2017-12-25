<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.financeAudit"/></title><!-- 财务审核 -->  
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script src="${app.staticResourceUrl}/ybl/resources/js/factor/finance_audit.js"></script>


<script>
	//刷新页面
	function callBackRefresh(url){
		window.location.href = url;
	}

	
</script>

</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=4" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.financeManage"/> -> <spring:message code="sys.client.financeAudit"/><!-- 财务审核 --></div>
	<div class="vip_conbody">

		<!--搜索条件-->
	<form  id="pageForm" method="post">
			<input id="status_"  name="status_" type="hidden"/>
			<input id="operation_" name="operation_" type="hidden"></input>
			<input id="status_index" value="${statusIndex}" type="hidden">
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.financeNumber"/>:</label><input id="number_" name="number_" value="${number_ }"type="text" /></li>
					<li><label><spring:message code="sys.client.clientName"/>:</label><input id="user_name" name="user_name" value="${user_name }"type="text" /></li>
					<li><label><spring:message code="sys.client.auditStatus"/>:</label>
					<select name="statusIndex" id="select_status" >
						<option value="0"><spring:message code="sys.client.queryAll"/></option>
						<option value="1"><spring:message code="sys.client.financeAuditing"/></option>
						<option value="2"><spring:message code="sys.client.disagree"/></option>
					</select>
					</li>
					<li><div class="button_yellow" id="query_list">
							<a ><spring:message code="sys.admin.search"/><!-- 查询 --></a>
						</div></li>
					<li><div class="button_gary" id="query_reset">
							<a><spring:message code="sys.client.reset"/><!-- 重置 --></a>
						</div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box ">
			<div class="table_top ">
				<div class="table_nav">
					<ul>
						<li>
						<!-- 审核 -->
					   <sun:button id="ybl_audit_finance_audit" tag='a' clazz="but_ico3" i18nValue="sys.client.auditOperator" />
						</li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div class="table_con ">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><input type="checkbox" id="checkAll" /></th>
						<th width="50"><spring:message code="sys.admin.serial.number"/><!-- 序号 --></th>
						<th><spring:message code="sys.client.financeNumber"/><!-- 融资编号 --></th>
						<th><spring:message code="sys.client.projectName"/><!-- 项目名称 --></th>
						<th><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
						<th><spring:message code="sys.client.legalName"/><!-- 法人姓名 --></th>
						<th><spring:message code="sys.client.licenseNumber"/><!-- 营业执照号 --></th>
						<th><spring:message code="sys.client.loanMoney"/>/<spring:message code="sys.client.tenThousand"/><!-- 贷款金额 --></th>
						<th><spring:message code="sys.client.BankofDeposit"/><!-- 开户行 --></th> 
						<th><spring:message code="sys.client.bankAccount"/><!-- 银行账号 --></th>
						<th><spring:message code="sys.client.financeApplyTime"/><!-- 融资申请时间 --></th>
						<th><spring:message code="sys.client.auditStatus"/><!-- 审核状态 --></th>
						<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
					</tr>
					
					<tbody>
						<c:forEach items="${productAuditList}" var="bean" varStatus="state">     
							 <c:if test="${bean.status_=='1030_finance_audit'}">                  
		                        <tr>
		                        	<td>
		                        		<c:if test="${bean.operation_=='waiting'}"><!-- 审核中 -->
		                        			<input name="checkbox"  type="checkbox" value="${bean.id}" />
		                        		</c:if>
		                        		<c:if test="${bean.operation_!='waiting'}"><!-- 审核中 -->
		                        			<input name=""  type="checkbox" value="${bean.id}" disabled="disabled"/>
		                        		</c:if>
		                        	</td>
		                            <td>${state.count}</td>
					                <td>${bean.number_}</td>
					                <td>${bean.name_}</td>
					                <td>${bean.enterprise_name}</td>
					                <td>${bean.legal_name}</td>
					                <td>${bean.license_no}</td>
					                <td> <fmt:formatNumber value="${bean.apply_amount / 10000}" pattern="###,##0.00"  /></td>
					                <td>${bean.open_name}</td>
					                <td>${bean.account_no}</td>
					                <td><fmt:formatDate value="${bean.created_time}" pattern="yyyy/MM/dd" /></td>
					                <c:if test="${bean.operation_=='waiting'}"><!-- 审核中 -->
										<td><spring:message code="sys.client.financeAuditing"/></td>
									</c:if>
									<c:if test="${bean.operation_=='disagree'}"><!-- 审核不通过 -->
										<td><spring:message code="sys.client.auditFail"/></td>
									</c:if>
					                <td><div class="qy">
										<c:if test="${bean.operation_=='waiting'}">
											<a  href="/ProductAuditController/queryDetail?step=4&auditType=2&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
										  </c:if>
										  <c:if test="${bean.operation_!='waiting'}">
											<a  href="/ProductAuditController/queryDetail?step=4&auditType=-2&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
										  </c:if>
									</td>
								</div>
					             </tr>
					        </c:if>
	                     </c:forEach>  
					</tbody>
				</table>
				
				

			</div>
		</div>
		<jsp:include page="../../common/page.jsp"></jsp:include>
	  </form>
	</div>
	<!--table-->

	</div>

	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>