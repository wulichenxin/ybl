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
				<p class="protitle"><span>保理要素表(应收账款)</span></p>
				<div class="grounpinfo">
				<div class="ground-form mb20">
						<div class="ground-form mb20">
							<div class="form-grou">
								<label class="label-long3"><a style = "color:red">*</a>保理要素表编号：</label> 
								<input class="content-form2 validate[required]" name="orderNo" value="${vo.orderNo}" />
							</div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>卖方名称：</label> 
								<input placeholder="债权人" class="content-form2 validate[required]" name="creditor" value="${vo.creditor}" />
							</div>
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>买方名称：</label> 
								<input placeholder="债务人" class="content-form2 validate[required]" name="debtor" value="${vo.debtor }" />
							</div>
							<div class="form-grou">
								<label class="w140"><a style = "color:red">*</a>基础合同及编号：</label> 
								<input class="content-form2 validate[required]" name="baseContractNo" value="${vo.baseContractNo }" />
							</div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>保理方式：</label> 
								<select class="content-form2" name="factoringMode" id="factoringMode" disabled="true">
									<option value="">请选择</option>
									<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
									<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
								</select>
							</div>
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>确权方式：</label> 
								<select class="content-form2" name="rightMode" id="rightMode" disabled="true">
									<option value="">请选择</option>
									<option value="1" <c:if test="${not empty vo.rightMode and vo.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
									<option value="2" <c:if test="${not empty vo.rightMode and vo.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
								</select>
							</div>
							<div class="form-grou">
								<label class="w140"><a style = "color:red">*</a>结算比例：</label>
								<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="balanceScale" value="${vo.balanceScale }" /><span class="timeimg">%</span>
							</div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>收费方式：</label> 
								<select class="content-form2 sffs" name="feeMode" id="feeMode" disabled="true">
									<option value="1" <c:if test="${not empty vo.feeMode and vo.feeMode eq 1}">selected="selected"</c:if>>融资利率</option>
									<option value="2" <c:if test="${not empty vo.feeMode and vo.feeMode eq 2}">selected="selected"</c:if>>服务费</option>
									<option value="3" <c:if test="${not empty vo.feeMode and vo.feeMode eq 3}">selected="selected"</c:if>>转让对价</option>
								</select>
							</div>
							<div class="form-grou mr50">
								<c:if test="${vo.feeMode eq 1 }">
									<label class="sffs-label"><a style = "color:red">*</a>融资利率：</label> 
									<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="fee" value="${vo.financingRate }" /><span class="timeimg sffs-sp">%</span>
								</c:if>
								<c:if test="${vo.feeMode eq 2 }">
									<label class="sffs-label"><a style = "color:red">*</a>服务费：</label> 
									<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="fee" value="${vo.serviceFee }" /><span class="timeimg sffs-sp">元</span>
								</c:if>
								<c:if test="${vo.feeMode eq 3 }">
									<label class="sffs-label"><a style = "color:red">*</a>转让对价：</label> 
									<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="fee" value="${vo.transferMoney }" /><span class="timeimg sffs-sp">元</span>
								</c:if>
							</div>
							<div class="form-grou">
								<label class="w140">转让应收账款金额：</label> 
								<input class="content-form2" name="totalAmount" value='<fmt:formatNumber value="${totalAmount }" pattern="#,#00.00#"/>' readonly="readonly"/><span class="timeimg">元</span>
							</div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>还款方式：</label> 
								<select class="content-form2" name="repaymentMode" id="repaymentMode">
									<option value="">请选择</option>
									<option value="1" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
									<option value="3" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
								</select>
							</div>
							<div class="form-grou mr50">
								<label><a style = "color:red">*</a>交易方式：</label> 
								<select class="content-form2" name="transactionMode" id="transactionMode">
									<option value="">请选择</option>
									<option value="1" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
									<option value="2" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
								</select>
							</div>
							<div class="form-grou">
								<label class="w140"><a style = "color:red">*</a>逾期利率：</label> 
								<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="overdueInterestRate" value="${vo.overdueInterestRate }" /><span class="timeimg">%</span>
							</div>
						</div>
				</div>
				<div class="tabD mt30 mb30">
					<table>
						<tr>
							<th>资产编号</th>
							<th>应收账款到期日期</th>
							<th>应收账款转让日期</th>
							<th>融资期限(天)</th>
						</tr>
						
						<c:forEach items="${assetslist}" var="obj" varStatus="index">
							<tr class="assets">
							<script>
									$(function(){
										$("#cancel").click(function(){
											var arr=new Array();
											$(".assets").each(function(){
												var a = $(this).children("td")
												arr.push($(a[0]).text());
											});
											$.ajax({
												url : "/factorLoanAuditController/loanAudit/callBack",
												dataType : "json",
												type : "post",
												data : {assets : arr},
												success : function(data) {
													
												}
											});
											
										})
									})
								</script>
								<td>${obj.assetNumber}</td>
								<input type='hidden' name='assetslist[${index.count-1 }].assetNumber' value='${obj.assetNumber }' />
								<input id="date${index.count-1 }" type="hidden" value='<fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" />'/>
								<td><input id="beginDate${index.count-1 }" name='assetslist[${index.count-1 }].expectedPaymentDateActual' class="content-form beginDate"
									value='<fmt:formatDate value="${obj.expectedPaymentDateActual }" pattern="yyyy-MM-dd" />' /></td>
								<td><a style = "color:red">*</a><input name='assetslist[${index.count-1 }].transferDate' class="content-form endDate validate[required,custom[date]]"
									value='<fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" />' /></td>
									
								<td><div class="form-grou" style="line-height: 30px;"><input name='assetslist[${index.count-1 }].financingTerm' class="content-form financingTerm" value='${obj.financingTerm }' readonly="readonly" /></div></td>
							
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="bottom-line"></div>
				
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
									<c:forEach items="${Attachmentlist}" var="obj" varStatus="index">
										<tr>
											<td>${index.count}</td>
											<td>${obj.attribute1 }</td>
											<td>${obj.remark }</td>
											<td><a href="javascript:;">${obj.oldName }</a></td>
											<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-modify">下载</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark">${vo.remark }</textarea>
					</div>	
				
				
				<div class="bottom-line"></div>
				
				<div class="shenmin"><input type="checkbox" />申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div>
				
				<!-- <div class="btn3 clearfix mb80"> -->
					<a href="#" class="btn-add btn-center" id="tab1_2">下一页</a>
					<!-- <a href="#" id="btn-return" class="btn-add" >返回</a> -->
				<!-- </div> -->
				
				</div>
			</div>
		</form>				
		
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js" ></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
		<script>
			$(function(){
				var loanApplyId=$('#loan_apply_id', parent.document).val();
				var type=$('#assetsType', parent.document).val();
				$("#tab1_2").click(function(){
					window.location.href="/tabDetailController/selectAssetAttach?loanApplyId="+loanApplyId;
				});
				$("#tab1_3").click(function(){
					window.location.href="/tabDetailController/loanappictionitem?loanApplyId="+loanApplyId;
				});
			});
		</script>
	</body>
</html>