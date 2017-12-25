<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
	</head>
	<!--top start -->
        <jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
        <!--top end -->
	<body>
	<c:choose>
			<c:when test="${recordResult == 'noRecords'}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<div class="w1200">
				<c:if test="${not empty type and type eq '1'}">
					<p class="protitle"><span>保理要素表(应收账款)</span></p>
				</c:if>
				<c:if test="${not empty type and type eq '2'}">
					<p class="protitle"><span>保理要素表(应付账款)</span></p>
				</c:if>
				<c:if test="${not empty type and type eq '3'}">
					<p class="protitle"><span>保理要素表(票据)</span></p>	
				</c:if>
				<div class="grounpinfo">
				<div class="ground-form mb20">
								<div class="form-grou">
									<label class="label-long3">保理要素表编号：</label>
									<c:if test="${not empty type and type eq '1'}">
										<input class="content-form2" name="orderNo" value="${ReceivableElementsResult.orderNo}"/>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<input class="content-form2" name="orderNo" value="${payableElementsResult.orderNo}"/>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<input class="content-form2" name="orderNo" value="${billElementsResult.orderNo}"/>	
									</c:if>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<c:if test="${not empty type and type eq '1'}">
										<label>卖方名称：</label>
										<input class="content-form2" name="creditor" value="${ReceivableElementsResult.creditor}"/>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<label>卖方名称：</label>
										<input class="content-form2" name="creditor" value="${payableElementsResult.creditor}"/>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<label>票据持有人：</label>
										<input class="content-form2" name="creditor" value="${billElementsResult.billHolder}"/>
									</c:if>
								</div>
								<div class="form-grou mr50">
									<c:if test="${not empty type and type eq '1'}">
										<label>买方名称：</label>
										<input class="content-form2" name="debtor" value="${ReceivableElementsResult.debtor}"/>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<label>买方名称：</label>
										<input class="content-form2" name="debtor" value="${payableElementsResult.debtor}"/>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<label>票据承兑人：</label>
										<input class="content-form2" name="debtor" value="${billElementsResult.billAcceptor}"/>
									</c:if>
								</div>
								<div class="form-grou">
									<label class="w140">基础合同及编号：</label>
									<c:if test="${not empty type and type eq '1'}">
										<input class="content-form2" name="debtor" value="${ReceivableElementsResult.baseContractNo}"/>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<input class="content-form2" name="debtor" value="${payableElementsResult.baseContractNo}"/>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<input class="content-form2" name="debtor" value="${billElementsResult.baseContractNo}"/>
									</c:if>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>保理方式：</label>
									<c:if test="${not empty type and type eq '1'}">
										<select class="content-form2" name="factoringMode">
											
											<option value="1" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
											<option value="2" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<select class="content-form2" name="factoringMode">
		
											<option value="1" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
											<option value="2" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<select class="content-form2" name="factoringMode">
											
											<option value="1" <c:if test="${not empty billElementsResult.factoringMode and billElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
											<option value="2" <c:if test="${not empty billElementsResult.factoringMode and billElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
										</select>
									</c:if>
								</div>
								<div class="form-grou mr50">
									<label>确权方式：</label>
									<c:if test="${not empty type and type eq '1'}">
										<select class="content-form2" name="rightMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty ReceivableElementsResult.rightMode and ReceivableElementsResult.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
											<option value="2" <c:if test="${not empty ReceivableElementsResult.rightMode and ReceivableElementsResult.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<select class="content-form2" name="rightMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty payableElementsResult.rightMode and payableElementsResult.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
											<option value="2" <c:if test="${not empty payableElementsResult.rightMode and payableElementsResult.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<select class="content-form2" name="factoringMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
											<option value="2" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
										</select>
									</c:if>
									
								</div>
								<div class="form-grou">
									<c:if test="${not empty type and type eq '1'}">
										<label class="w140">结算比例：</label>
										<input class="content-form2" name="balanceScale" value="<fmt:formatNumber value="${ReceivableElementsResult.balanceScale }" pattern="0.####"/>" /><span class="timeimg">%</span>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<label class="w140">结算比例：</label>
										<input class="content-form2" name="balanceScale" value="<fmt:formatNumber value="${payableElementsResult.balanceScale }" pattern="0.####"/>" /><span class="timeimg">%</span>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<label class="w140">结算比例：</label>
										<input class="content-form2" name="balanceScale" value="<fmt:formatNumber value="${billElementsResult.balanceScale }" pattern="0.####"/>" /><span class="timeimg">%</span>
									</c:if>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>收费方式：</label>
									<c:if test="${not empty type and type eq '1'}">
										<select class="content-form2 sffs" name="feeMode">
											<option value="1" <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
											<option value="2" <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
											<option value="3" <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 3}">selected="selected"</c:if>>转让对价</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<select class="content-form2 sffs" name="feeMode">
											<option value="1" <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
											<option value="2" <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
											<option value="3" <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 3}">selected="selected"</c:if>>转让对价</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<select class="content-form2 sffs" name="feeMode">
											<option value="1" <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
											<option value="2" <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
											<option value="3" <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 3}">selected="selected"</c:if>>转让对价</option>
										</select>
									</c:if>
								</div>
								<div class="form-grou mr50">
									<c:if test="${not empty type and type eq '1'}">
										<c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 1}">
											<label class="sffs-label">融资利率：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${ReceivableElementsResult.financingRate}" pattern="#,##0.####" maxFractionDigits="4"/>"/><span class="timeimg">%</span>
										</c:if>
										<c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 2}">
											<label class="sffs-label">服务费：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${ReceivableElementsResult.serviceFee}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
										<c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 3}">
											<label class="sffs-label">转让对价：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${ReceivableElementsResult.transferMoney}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 1}">
											<label class="sffs-label">融资利率：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${payableElementsResult.financingRate}" pattern="#,##0.####" maxFractionDigits="4"/>"/><span class="timeimg sffs-sp">%</span>
										</c:if>
										<c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 2}">
											<label class="sffs-label">服务费：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${payableElementsResult.serviceFee}" pattern="#,##0.##"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
										<c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 3}">
											<label class="sffs-label">转让对价：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${payableElementsResult.transferMoney}" pattern="#,##0.##"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 1}">
											<label class="sffs-label">融资利率：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${billElementsResult.financingRate}" pattern="#,##0.####"/>"/><span class="timeimg sffs-sp">%</span>
										</c:if>
										<c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 2}">
											<label class="sffs-label">服务费：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${billElementsResult.serviceFee}" pattern="#,##0.##"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
										<c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 3}">
											<label class="sffs-label">转让对价：</label>
											<input class="content-form2" value="<fmt:formatNumber value="${billElementsResult.transferMoney}" pattern="#,##0.##"/>"/><span class="timeimg sffs-sp">元</span>
										</c:if>
									</c:if>
								</div>
								<div class="form-grou">
									<c:if test="${not empty type and type eq '1'}">
										<label style="width: 140px;">转让应收账款金额：</label>
										<input class="content-form2" name="transferMoney" value="<fmt:formatNumber value="${totalAmount}" pattern="#,##0.##"/>"/><span class="timeimg">元</span>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<label style="width: 140px;">转让应收账款金额：</label>
										<input class="content-form2" name="transferMoney" value="<fmt:formatNumber value="${totalAmount}" pattern="#,##0.##"/>"/><span class="timeimg">元</span>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<label class="w140">票面金额：</label>
										<input class="content-form2" name="balanceScale" value="<fmt:formatNumber value="${totalAmount}" pattern="#,##0.##"/>" /><span class="timeimg">元</span>
									</c:if>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>还款方式：</label>
									<c:if test="${not empty type and type eq '1'}">
										<select class="content-form2" name="repaymentMode">											
											<option value="1" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
											<option value="2" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
											<option value="3" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<select class="content-form2" name="repaymentMode">						
											<option value="1" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
											<option value="2" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
											<option value="3" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<select class="content-form2" name="repaymentMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
											<option value="2" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
											<option value="3" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
										</select>
									</c:if>
								</div>
								<div class="form-grou mr50">
									<label>交易方式：</label>
									<c:if test="${not empty type and type eq '1'}">
										<select class="content-form2" name="transactionMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty ReceivableElementsResult.transactionMode and ReceivableElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
											<option value="2" <c:if test="${not empty ReceivableElementsResult.transactionMode and ReceivableElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<select class="content-form2" name="transactionMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty payableElementsResult.transactionMode and payableElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
											<option value="2" <c:if test="${not empty payableElementsResult.transactionMode and payableElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
										</select>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<select class="content-form2" name="transactionMode">
											<option>请选择</option>
											<option value="1" <c:if test="${not empty billElementsResult.transactionMode and billElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
											<option value="2" <c:if test="${not empty billElementsResult.transactionMode and billElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
										</select>
									</c:if>
								</div>
								<div class="form-grou">
									<label style="width: 140px;">逾期利率：</label> 
									<c:if test="${not empty type and type eq '1'}">
										<input class="content-form2" name="overdueInterestRate" value="<fmt:formatNumber value="${ReceivableElementsResult.overdueInterestRate }" pattern="#,##0.##"/>" /><span class="timeimg">%</span>
									</c:if>
									<c:if test="${not empty type and type eq '2'}">
										<input class="content-form2" name="overdueInterestRate" value="<fmt:formatNumber value="${payableElementsResult.overdueInterestRate }" pattern="#,##0.##"/>" /><span class="timeimg">%</span>
									</c:if>
									<c:if test="${not empty type and type eq '3'}">
										<input class="content-form2" name="overdueInterestRate" value="<fmt:formatNumber value="${billElementsResult.overdueInterestRate }" pattern="#,##0.##"/>" /><span class="timeimg">%</span>
									</c:if>
								</div>
							</div>
						</div>
				<div class="tabD mt30 mb30">
					<c:if test="${not empty type and type eq '1'}">
						<table>
							<tr>
								<th>资产编号</th>
								<th>应收账款到期日期</th>
								<th>应收账款转让日期</th>
								<th>融资期限(天)</th>
							</tr>
							
							<c:forEach items="${assetslist}" var="obj" varStatus="index">
								<tr class="assets">
									<td>${obj.assetNumber}</td>
									<td><fmt:formatDate value="${obj.expectedPaymentDateActual }" pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
										
									<td>${obj.financingTerm }</td>
								
								</tr>
							</c:forEach>
						</table>
					</c:if>
					<c:if test="${not empty type and type eq '2'}">
						<table>
							<tr>
								<th>资产编号</th>
								<th>应付账款到期日期</th>
								<th>应付账款转让日期</th>
								<th>融资期限(天)</th>
							</tr>
							<c:forEach items="${assetslist}" var="obj" varStatus="index">
								<tr>
									<td>${obj.assetNumber}</td>
									<td><fmt:formatDate value="${obj.expectedPaymentDateActual }" pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
									<td>${obj.financingTerm }</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
					<c:if test="${not empty type and type eq '3'}">
						<table>
						<tr>
							<th>资产编号</th>
							<th>票据到期日期</th>
							<th>票据转让日期</th>
							<th>融资期限(天)</th>
						</tr>
						<c:forEach items="${assetslist}" var="obj" varStatus="index">
							<tr class="assets">
								<td>${obj.assetNumber}</td>
								<td><fmt:formatDate value="${obj.expireDateActual }" pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
								<td>${obj.financingTerm }</td>
							</tr>
						</c:forEach>
					</table>
					</c:if>
			</div>
				<div class="process">
						<p class="protitle"><span>风控措施</span></p>
						
						<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>序号</th>
										<th>风控措施名称</th>
										<th>备注</th>
										<th>附件</th>
										<th>操作</th>
									</tr>
									<c:forEach items="${list}" var="obj" varStatus="index">
										<tr>
											<td>${index.count}</td>
											<td>${obj.attribute1 }</td>
											<td>${obj.remark }</td>
											<td>${obj.oldName}</td>
											<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-modify">下载</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>	
						
		
						
					<p class="protitle"><span>备注</span></p>
					<c:if test="${not empty type and type eq '1'}">
						<div class="pd20">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark">${ReceivableElementsResult.remark }</textarea>
						</div>	
					</c:if>
					<c:if test="${not empty type and type eq '2'}">
						<div class="pd20">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark">${payableElementsResult.remark }</textarea>
						</div>	
					</c:if>
					<c:if test="${not empty type and type eq '3'}">
						<div class="pd20">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark">${billElementsResult.remark }</textarea>
						</div>	
					</c:if>
				<div class="bottom-line"></div>
				<div class="btn3 mt40 clearfix mb80">
					<a href="#" id="tab2_1" class="btn-add">上一页</a>
					<a href="#" id="tab2_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
				
				
				</div>
			</div>
		</form>							
		
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js" ></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
		<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			};
			
		})
		</script>
		<script>
			$(function(){
			
			
			$('.sffs').change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('.sffs-label').html('融资利率：');
					$('.sffs-sp').html('%');
				}
				else{
					$('.sffs-label').html('服务费：');
					$('.sffs-sp').html('元');
				}
				
			})
			
			
			
			//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
	//上一页，下一页,返回的跳转

				//上一页，下一页,返回的跳转
				$('#tab2_1').click(function(){	
					/* var url=$('#one',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#one',parent.document).click();
				})		
				$('#tab2_2').click(function(){	
					/* var url=$('#three',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#three',parent.document).click();
				})		
				
				$(".btn-return").click(function(){
					var url=$("#jumpurl",parent.document).val()
					window.parent.location.href=url;
					
				});
			
			})
		</script>
		</c:otherwise>
		</c:choose>
	</body>
</html>