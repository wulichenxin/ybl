<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.client.loanAudit"/></title><!-- 贷款审核 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script src="${app.staticResourceUrl}/ybl/resources/js/factor/loan_audit.js"></script>
<script >
	//刷新页面-给弹出窗口使用
	function callBackRefresh(url){
		window.location.href = url;
	}
</script>

</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=5" />
	<!--top end -->

	<div class="path"><spring:message code="sys.client.location"/> -> <spring:message code="sys.client.riskManage"/> -> <spring:message code="sys.client.loanAudit"/></div>
	<div class="vip_conbody">

		<!--搜索条件-->
		<form  id="pageForm" method="post" action="/ProductAuditController/queryRiskList">
			<input id="status_"  name="status_" type="hidden"/>
			<input id="operation_" name="operation_" type="hidden"></input>
			<input id="audit_current_index"  name="audit_current_index" value="${audit_current_index}" type="hidden"/>
			<input id="statusInputId" value="${statusIndex}" type="hidden"/>
		
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label><spring:message code="sys.client.financeNumber"/>:</label><input id="number_" name="number_" value ="${number_ }" type="text" /></li>
					<li><label><spring:message code="sys.client.clientName"/>:</label><input id="user_name" name="user_name" value="${ user_name}" type="text" /></li>
					<li><label><spring:message code="sys.client.auditStatus"/>:</label>
					<select name="statusIndex" id="select_status" >
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
		<div class="table_box tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now" >
						<a><spring:message code="sys.client.riskFirstAudit"/><!-- 风控初审 --></a>
					</dd>
					<dd >
						<a><spring:message code="sys.client.riskReAudit"/><!-- 风控复审 --></a>
					</dd>
				</dl>
			</div>
			<div>
				<div class="content">
					<div class="table_top ">
						<div class="table_nav">
							<ul>
								<li>
								
								<!-- 审核 --></a>
								<sun:button id="ybl_risk_audit_first_audit" tag='a' clazz="but_ico3" i18nValue="sys.client.auditOperator" />
								
								</li>
							</ul>
						</div>
					</div>
					<!--按钮top-->
					<div class="table_con " >
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							id="tb">
							<tr>
								<th width="50"><input id="firstAudit-checkAll" type="checkbox" />
								 </th>
									<th width="50"><spring:message code="sys.admin.serial.number"/> <!-- 序号 --></th>
									<th><spring:message code="sys.client.financeNumber"/><!-- 融资编号 --></th>
									<th><spring:message code="sys.client.projectName"/><!-- 项目名称 --></th>
									<th><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
									<th><spring:message code="sys.client.phone"/><!-- 联系电话 --></th>
									<th><spring:message code="sys.client.loanMoney"/>/<spring:message code="sys.client.tenThousand"/><!-- 贷款金额 --></th>
									<th><spring:message code="sys.client.yearRate"/><!-- 年利率 --></th>
									<th><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 --></th>
									<th><spring:message code="sys.client.factorType"/><!-- 保理类型 --></th>
									<th><spring:message code="sys.client.auditStatus"/><!-- 审核状态 --></th>
									<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
							</tr>
							
							<tbody>
								<c:forEach items="${productAuditList}" var="bean" varStatus="state">     
									 <c:if test="${bean.status_=='1000_auditing'}">                  
				                        <tr>
				                        
				                        	<td>
					                        	<c:if test="${bean.operation_=='waiting'}">
					                        		<input name="checkbox-first-audit"  type="checkbox" value="${bean.id}" />
					                        	</c:if>
					                        	<c:if test="${bean.operation_!='waiting'}">
					                        		<input name=""  type="checkbox" value="${bean.id}" disabled="disabled"/>
					                        	</c:if>
				                        	</td>
				                            <td>${state.count}</td>
							                <td>${bean.number_}</td>
							                <td>${bean.name_}</td>
							                <td>${bean.enterprise_name}</td>
							                <td>${bean.telephone_}</td>
							                
							                <td>
							               	 <fmt:formatNumber value="${bean.apply_amount / 10000}" pattern="###,##0.00"  />
							                </td>
							                <td>${bean.rate_}</td>
							                
							                <td>${bean.loan_period} 
							               		<c:if test="${bean.period_type == 'day'}">
								                     <spring:message code="sys.client.day"/>
								                 </c:if>
								                 <c:if test="${bean.period_type == 'month'}">
								                     <spring:message code="sys.client.month"/>
								                 </c:if>
								                 <c:if test="${bean.period_type == 'year'}">
								                     <spring:message code="sys.client.year"/>
								                 </c:if>
							                </td>
							                
							                <td>
							                    <c:if test="${bean.factor_type == 'online_factor'}">
							                	    <spring:message code="sys.client.online.clear.facte"/>
							                	</c:if>
							                
							                	<c:if test="${bean.factor_type == 'dark_factor'}">
							                	    <spring:message code="sys.client.dark.facte"/>
							                	</c:if>
							                </td>
							                <c:if test="${bean.operation_=='waiting'}"><!-- 初审中 -->
												<td><spring:message code="sys.client.auditing"/></td>
											</c:if>
											<c:if test="${bean.operation_=='disagree'}"><!-- 初审不通过 -->
												<td><spring:message code="sys.client.first_audit_fail"/></td>
											</c:if>
							                <td>
							                <div class="qy">
							                  <c:if test="${bean.operation_=='waiting'}">
												<a  href="/ProductAuditController/queryDetail?step=5&auditType=0&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
											  </c:if>
											  <c:if test="${bean.operation_!='waiting'}">
												<a  href="/ProductAuditController/queryDetail?step=5&auditType=-2&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
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
				<div class="content" style="display: none;">
					<div class="table_top ">
						<div class="table_nav">
							<ul>
								<li>
								<!-- 审核 --></a>
								<sun:button id="ybl_risk_audit_reaudit" tag='a' clazz="but_ico3" i18nValue="sys.client.auditOperator" />
								</li>
							</ul>
						</div>
					</div>
					<div class="table_con ">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							id="tb">
							<tr>
								<th width="50"><input id="reAudit-checkAll" type="checkbox" />
								</th>
									<th width="50"><spring:message code="sys.admin.serial.number"/> <!-- 序号 --></th>
									<th><spring:message code="sys.client.financeNumber"/><!-- 融资编号 --></th>
									<th><spring:message code="sys.client.projectName"/><!-- 项目名称 --></th>
									<th><spring:message code="sys.client.clientName"/><!-- 客户名称 --></th>
									<th><spring:message code="sys.client.phone"/><!-- 联系电话 --></th>
									<th><spring:message code="sys.client.loanMoney"/>/<spring:message code="sys.client.tenThousand"/><!-- 贷款金额 --></th>
									<th><spring:message code="sys.client.yearRate"/><!-- 年利率 --></th>
									<th><spring:message code="sys.client.loanPeriod"/><!-- 贷款期限 --></th>
									<th><spring:message code="sys.client.factorType"/><!-- 保理类型 --></th>
									<th><spring:message code="sys.client.auditStatus"/><!-- 审核状态 --></th>
									<th><spring:message code="sys.admin.operation"/><!-- 操作 --></th>
							</tr>
							
							<tbody>
								<c:forEach items="${productAuditList}" var="bean" varStatus="state">     
								     <c:if test="${bean.status_=='1020_reauditing'}">       
				                        <tr>
				                        
				                         <c:if test="${bean.operation_=='waiting'}">
				                        	<td><input name="checkbox-reaudit"  type="checkbox" value="${bean.id}" /></td>
				                        </c:if>
				                        
				                        <c:if test="${bean.operation_!='waiting'}">
				                        	<td><input name=""  type="checkbox" value="${bean.id}" disabled="disabled" /></td>
				                        </c:if>
				                        
				                            <td>${state.count}</td>
							                <td>${bean.number_}</td>
							                <td>${bean.name_}</td>
							                <td>${bean.enterprise_name}</td>
							                <td>${bean.telephone_}</td>
							                
							                <td>
							                	<fmt:formatNumber value="${bean.apply_amount / 10000}" pattern="###,##0.00"  />
							                </td>
							                
							                <td>${bean.rate_}</td>
							                 <td>${bean.loan_period} 
								                 <c:if test="${bean.period_type == 'day'}">
								                     <spring:message code="sys.client.day"/>
								                 </c:if>
								                 <c:if test="${bean.period_type == 'month'}">
								                     <spring:message code="sys.client.month"/>
								                 </c:if>
								                 <c:if test="${bean.period_type == 'year'}">
								                     <spring:message code="sys.client.year"/>
								                 </c:if>
							                 </td>
							                <td>
							                	<c:if test="${bean.factor_type == 'online_factor'}">
							                	    <spring:message code="sys.client.online.clear.facte"/>
							                	</c:if>
							                	<c:if test="${bean.factor_type == 'dark_factor'}">
							                	    <spring:message code="sys.client.dark.facte"/>
							                	</c:if>
							                </td>
							                <c:if test="${bean.operation_=='waiting'}"><!-- 复审中 -->
												<td><spring:message code="sys.client.reauditing"/></td>
											</c:if>
											
											<c:if test="${bean.operation_=='disagree'}"><!-- 复审不通过 -->
												<td><spring:message code="sys.client.reaudit_fail"/></td>
											</c:if>
							                <td><div class="qy">
												<c:if test="${bean.operation_=='waiting'}">
												<a  href="/ProductAuditController/queryDetail?step=5&auditType=1&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
											  </c:if>
											  <c:if test="${bean.operation_!='waiting'}">
												<a  href="/ProductAuditController/queryDetail?step=5&auditType=-2&id=${bean.id}"><spring:message code="sys.admin.view"/><!-- 查看 --></a>  
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