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
	<meta charset='utf-8' />
	<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
	<%@include file="/ybl4.0/admin/common/link.jsp"%>
</head>
	<body>
		<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<div class="w1200">
				<p class="protitle"><span></span>保理要素表(应收账款)</p>
				<div class="grounpinfo">
				<div class="ground-form mb20">
								<div class="form-grou">
									<label class="label-long3">保理要素表编号：</label>
									<input class="content-form2" name="orderNo" value="${vo.orderNo}"/>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>卖方名称：</label>
									<input class="content-form2" name="creditor" value="${vo.creditor}"/>
								</div>
								<div class="form-grou mr50">
									<label>买方名称：</label>
									<input class="content-form2" name="debtor" value="${vo.debtor }"/>
								</div>
								<div class="form-grou">
									<label class="w140">基础合同及编号：</label>
									<input class="content-form2" name="baseContractNo" value="${vo.baseContractNo }"/>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>保理方式：</label>
									<select class="content-form2" name="factoringMode">
										<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
										<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label>确权方式：</label>
									<select class="content-form2" name="rightMode">
										<option value="1" <c:if test="${not empty vo.rightMode and vo.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
										<option value="2" <c:if test="${not empty vo.rightMode and vo.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
									</select>
								</div>
								<div class="form-grou">
									<label class="w140">结算比例：</label>
									<input class="content-form2" name="balanceScale" value="${vo.balanceScale}"/><span class="timeimg">元</span>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>收费方式：</label>
									<select class="content-form2 sffs" name="feeMode">
										<option value="1" <c:if test="${not empty vo.feeMode and vo.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
										<option value="2" <c:if test="${not empty vo.feeMode and vo.feeMode eq 2}">selected="selected"</c:if> >服务费</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label class="sffs-label">融资利率：</label>
									<input class="content-form2" name="fee" value="${vo.financingRate }"/><span class="timeimg sffs-sp">%</span>
								</div>
								<div class="form-grou">
									<label class="w140">转让应收账款金额：</label>
									<input class="content-form2" name="" value="${vo.transferMoney }"/><span class="timeimg">元</span>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>还款方式：</label>
									<select class="content-form2" name="repaymentMode">
										<option value="1" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
										<option value="2" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
										<option value="3" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 3}">selected="selected"</c:if>>利息前置，到期还本</option>
									</select>
								</div>
								<div class="form-grou">
									<label class="w140">交易方式：</label>
									<select class="content-form2" name="transactionMode">
										<option value="1" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
										<option value="2" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label class="sffs-label">逾期利率：</label>
									<input class="content-form2" name="fee" value="${vo.overdueInterestRate }"/><span class="timeimg sffs-sp">%</span>
								</div>
							</div>
						</div>
				<div class="tabD mt30 mb30">
				<table>
					<tr>
						<th>资产编号</th>
						<th>应收账款到期日期</th>
						<th>应收账款转让日期</th>
						<th>融资期限</th>
					</tr>
					<c:forEach items="${assetslist}" var="obj" varStatus="index">
						<tr>
							<td>${obj.assetNumber}</td>
							<td><fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
							<td>${obj.financingTerm }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
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
									<c:forEach items="${Attachmentlist}" var="obj" varStatus="index">
										<tr>
											<td>${index.count}</td>
											<td>${obj.old_name }</td>
											<td>${obj.remark }</td>
											<td><a href="javascript:;">${obj.new_name }</a></td>
											<td><a href="javascript:;" class="btn-modify">上传</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						
						
		
						
					<p class="protitle"><span></span>备注</p>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" value="${eceivableElementsVo.remark }"></textarea>
					</div>	
				
				
				<div class="bottom-line"></div>
				
				<div class="shenmin"><input type="checkbox" />申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div>
				
				<div class="btn3 clearfix mb80">
					<a href="项目详情页" class="btn-add" >上一页</a>
					<c:if test="${not empty look and look eq 'look'}"><a href="javascript:;" class="btn-add" id="commit">审核</a></c:if>
					<a href="/factorLoanAuditController/loanAudit/loanAuditList.htm" class="btn-add" >返回</a>
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
				/*$('#beginDate,#endDate').datetimepicker({
					yearOffset: 0,
					lang: 'ch',
					timepicker: false,
					format: 'Y-m-d',
					formatDate: 'Y-m-d',
					minDate: '1970-01-01', 
					maxDate: '2099-12-31' 
				});
			
				 $('.sffs').change(function(){
					var $val = $(this).children('option:selected').attr('value');
					if($val=='1'){
						$('.sffs-label').html('融资利率：');
						$('.sffs-sp').html('%');
					}else if($val=='2'){
						$('.sffs-label').html('服务费：');
						$('.sffs-sp').html('元');
					}else{
						$('.sffs-label').html('折价转让：');
						$('.sffs-sp').html('元');
					}
					
				}) */
			});
		</script>
	</body>
</html>