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
									<input placeholder="债权人" class="content-form2" name="creditor" value="${vo.creditor}"/>
								</div>
								<div class="form-grou mr50">
									<label>买方名称：</label>
									<input placeholder="债务人" class="content-form2" name="debtor" value="${vo.debtor }"/>
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
										<option>请选择</option>
										<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
										<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label>确权方式：</label>
									<select class="content-form2" name="rightMode">
										<option>请选择</option>
										<option value="1" <c:if test="${not empty vo.rightMode and vo.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
										<option value="2" <c:if test="${not empty vo.rightMode and vo.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
									</select>
								</div>
								<div class="form-grou">
									<label class="w140">转让应收账款金额：</label>
									<input class="content-form2" name="transferMoney" value="${vo.transferMoney }"/><span class="timeimg">元</span>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>收费方式：</label>
									<select class="content-form2 sffs" name="feeMode">
										<option value="1">融资利率</option>
										<option value="2">服务费</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label class="sffs-label">融资利率：</label>
									<input class="content-form2" name="fee" value="${vo.fee }"/><span class="timeimg sffs-sp">%</span>
								</div>
								<div class="form-grou">
									<label class="w140">应收账款转让对价：</label>
									<input class="content-form2" name="transferConsideration" value="${vo.transferMoney }"/><span class="timeimg">元</span>
								</div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50">
									<label>还款方式：</label>
									<select class="content-form2" name="repaymentMode">
										<option>请选择</option>
										<option value="1" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
										<option value="3" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 3}">selected="selected"</c:if>>利息前置，到期还本</option>
									</select>
								</div>
								<div class="form-grou mr50">
									<label>融资期限：</label>
									<input id="beginDate" class="content-form2" name="financingTermDate" value="${vo.financingTerm }"/> 
								</div>
								<div class="form-grou">
									<label class="w140">交易方式：</label>
									<select class="content-form2" name="transactionMode">
										<option>请选择</option>
										<option value="1" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
										<option value="2" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
									</select>
								</div>
							</div>
							<div class="ground-form">
								<div class="form-grou mr50">
									<label class="w140">应收账款转让日期：</label>
									<input id="beginDate" class="content-form2" name="transferDate" value="${vo.transferDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
								</div>
								<div class="form-grou">
									<label class="w140">应收账款到期日期：</label>
									<input id="beginDate" class="content-form2" name="expireDate" value="${vo.expireDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
								</div>
							</div>
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
									<c:forEach items="${list}" var="obj" varStatus="index">
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
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" value="${vo.remark }"></textarea>
					</div>	
				
				
				<div class="bottom-line"></div>
				
			<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
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

	$('#tab2_1').click(function(){	
		var url=$('#one',parent.document).attr('url');	
		$('#iframe1',parent.document).attr('src',url);
	})		
	$('#tab2_2').click(function(){	
		var url=$('#three',parent.document).attr('url');	
		$('#iframe1',parent.document).attr('src',url);
	})		
	
	$(".btn-return").click(function(){
		window.parent.location.href="/loanapplicationcontroller/list.htm";
	});
			
			})
		</script>
	</body>
</html>