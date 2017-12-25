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
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->
		
		<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			
			<!-- 应收账款start -->
			<div class="w1200">
				<c:if test="${not empty type and type eq '1'}">
					<p class="protitle"><span></span>保理要素表(应收账款)</p>
				</c:if>
				<c:if test="${not empty type and type eq '2'}">
					<p class="protitle"><span></span>保理要素表(应付账款)</p>
				</c:if>
				<c:if test="${not empty type and type eq '3'}">
					<p class="protitle"><span></span>保理要素表(票据)</p>	
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
						<label>卖方名称：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="creditor" value="${ReceivableElementsResult.creditor}"/>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="creditor" value="${payableElementsResult.creditor}"/>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="creditor" value="${billElementsResult.creditor}"/>
						</c:if>
					</div>
					<div class="form-grou mr50">
						<label>买方名称：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="debtor" value="${ReceivableElementsResult.debtor}"/>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="debtor" value="${payableElementsResult.debtor}"/>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="debtor" value="${billElementsResult.debtor}"/>
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
								<option>请选择</option>
								<option value="1" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
								<option value="2" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<select class="content-form2" name="factoringMode">
								<option>请选择</option>
								<option value="1" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
								<option value="2" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<select class="content-form2" name="factoringMode">
								<option>请选择</option>
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
								<option value="1" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 1}">selected="selected"</c:if>>明保理</option>
								<option value="2" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 2}">selected="selected"</c:if>>暗保理</option>
							</select>
						</c:if>
					</div>
					<div class="form-grou">
						<label class="w140">转让应收账款金额：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="transferMoney" value="${ReceivableElementsResult.transferMoney}"/>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="transferMoney" value="${payableElementsResult.transferMoney}"/>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="transferMoney" value="${billElementsResult.transferMoney}"/>
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
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<select class="content-form2 sffs" name="feeMode">
								<option value="1" <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
								<option value="2" <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<select class="content-form2 sffs" name="feeMode">
								<option value="1" <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
								<option value="2" <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
							</select>
						</c:if>
					</div>
					<div class="form-grou mr50">
						<label class="sffs-label">融资利率：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="fee" value="${ReceivableElementsResult.fee}"/><span class="timeimg sffs-sp">%</span>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="fee" value="${payableElementsResult.fee}"/><span class="timeimg sffs-sp">%</span>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="fee" value="${billElementsResult.fee}"/><span class="timeimg sffs-sp">%</span>
						</c:if>
					</div>
					<div class="form-grou">
						<label class="w140">应收账款转让对价：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="transferConsideration" value="${ReceivableElementsResult.transferMoney}"/><span class="timeimg">元</span>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="transferConsideration" value="${payableElementsResult.transferMoney}"/><span class="timeimg">元</span>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="transferConsideration" value="${billElementsResult.transferMoney}"/><span class="timeimg">元</span>
						</c:if>
					</div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou mr50">
						<label>还款方式：</label>
						<c:if test="${not empty type and type eq '1'}">
							<select class="content-form2" name="repaymentMode">
								<option>请选择</option>
								<option value="1" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
								<option value="3" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>利息前置，到期还本</option>
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<select class="content-form2" name="repaymentMode">
								<option>请选择</option>
								<option value="1" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
								<option value="3" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>利息前置，到期还本</option>
							</select>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<select class="content-form2" name="repaymentMode">
								<option>请选择</option>
								<option value="1" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
								<option value="3" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>利息前置，到期还本</option>
							</select>
						</c:if>
					</div>
					<div class="form-grou mr50">
						<label>融资期限：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="financingTermDate" value="${ReceivableElementsResult.financingTerm}"/><span class="timeimg">元</span>
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="financingTermDate" value="${payableElementsResult.financingTerm}"/><span class="timeimg">元</span>
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="financingTermDate" value="${billElementsResult.financingTerm}"/><span class="timeimg">元</span>
						</c:if>
					</div>
					<div class="form-grou">
						<label class="w140">交易方式：</label>
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
				</div>
				<div class="ground-form">
					<div class="form-grou mr50">
						<label class="w140">应收账款转让日期：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="financingTermDate" value="<fmt:formatDate value="${ReceivableElementsResult.transferDate}" pattern="yyyy-MM-dd" />"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="financingTermDate" value="<fmt:formatDate value="${payableElementsResult.transferDate}" pattern="yyyy-MM-dd" />" /><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="financingTermDate" value="<fmt:formatDate value="${billElementsResult.transferDate}" pattern="yyyy-MM-dd" />"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
					</div>
					<div class="form-grou">
						<label class="w140">应收账款到期日期：</label>
						<c:if test="${not empty type and type eq '1'}">
							<input class="content-form2" name="expireDate" value="${ReceivableElementsResult.expireDate}"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
						<c:if test="${not empty type and type eq '2'}">
							<input class="content-form2" name="expireDate" value="${payableElementsResult.expireDate}"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
						<c:if test="${not empty type and type eq '3'}">
							<input class="content-form2" name="expireDate" value="${billElementsResult.expireDate}"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
						</c:if>
					</div>
				</div>
			</div>
			<!-- 应收账款end -->	
				
				
				
				<div class="bottom-line"></div>
				
				<div class="process">
						<p class="protitle"><span></span>风控措施</p>
						
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
											<td>${obj.old_name }</td>
											<td>${obj.remark }</td>
											<td><a href="javascript:;">${obj.new_name }</a></td>
											<td><a href="javascript:;" class="btn-modify">查看</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						
						
		
						
					<p class="protitle"><span></span>备注</p>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：
						<textarea class="protext" name="remark" >
							<c:if test="${not empty type and type eq '1'}">
								${ReceivableElementsResult.remark}
							</c:if>
							<c:if test="${not empty type and type eq '2'}">
								${payableElementsResult.remark}
							</c:if>
							<c:if test="${not empty type and type eq '3'}">
								${billElementsResult.remark}
							</c:if>
						</textarea>
					</div>	
				
				
				<div class="bottom-line"></div>
				
				<div class="shenmin"><input type="checkbox" />申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div>
				
				
				
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
			$('#beginDate,#endDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			/* $('.sffs').change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('.sffs-label').html('融资利率：');
					$('.sffs-sp').html('%');
				}
				else{
					$('.sffs-label').html('服务费：');
					$('.sffs-sp').html('元');
				}
				
			}) */
			})
		</script>
	</body>
</html>