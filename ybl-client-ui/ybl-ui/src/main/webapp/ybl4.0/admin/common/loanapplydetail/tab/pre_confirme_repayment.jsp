<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>还款</title>
</head>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/copy.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl4.0/resources/js/copy.js"></script>
		<!--top end -->
		
<body>
		<p class="protitle"><span></span>还款</p>
	</div>
	<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${rep}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>" id="${obj.id_}">第${index.count}期</li>
				</c:forEach>
			</ul>
	</div>
	<div class="w1200">
		<c:forEach items="${rep}" var="entity" varStatus="index">

		<div class="w1200 ybl-info box box${index.count}">
				
		<div class="bottom-line"></div>
		<div id="datas" class="pd20 mt40">
			<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">放款申请单号：</label><label class="label-long2">${entity.obj.loanApplyOrderNo }</label></div>
						<div class="form-grou mr40"><label class="label-long2">还款期数：</label><label class="label-long2">${entity.obj.period }期</label></div>
						<div class="form-grou mr40"><label class="label-long2">本期应该金额：</label><label class="label-long2"><fmt:formatNumber value="${entity.obj.repaymentPrincipal}" pattern="##0.00" maxFractionDigits="2"/>元</label></div>
					</div>

			<div class="ground-form mb20">
			<div class="form-grou mr40"><label class="label-long2">本期应还利息：</label><label class="label-long2"><fmt:formatNumber value="${entity.obj.repaymentInterest}" pattern="##0.00" maxFractionDigits="2"/>元</label></div>
					<div class="form-grou mr40"><label class="label-long2">逾期天数：</label><label class="label-long2">${entity.obj.overdueDays }天</label></div>
					<div class="form-grou mr40"><label class="label-long2">逾期费用：</label><label class="label-long2"><fmt:formatNumber value="${entity.obj.overdueFee}" pattern="##0.00" maxFractionDigits="2"/>元</label></div>
				</div>
			<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">本次实际支付金额：</label><label class="label-long2"><fmt:formatNumber value="${entity.obj.actualAmount}" pattern="##0.00" maxFractionDigits="2"/>元</label></div>
					<div class="form-grou mr40"><label class="label-long2">支付时间：</label><label class="label-long2"><fmt:formatDate value="${entity.obj.actualRepaymentDate}" pattern="yyyy-MM-dd" /></label></div>
					<div class="form-grou mr40"><label class="label-long2">交易流水号：</label><label class="label-long2">${entity.obj.transactionOrderNo }</label></div>
				</div>
				<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><label class="label-long2">${entity.obj.bank }</label></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><label class="label-long2">${entity.obj.bankAccountName }</label></div>
					<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><label class="label-long2">${entity.obj.bankAccount }</label></div>
				</div>
				
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" disabled="disabled">${entity.attachment.remark }</textarea></div>
				</div>
				<div class="ground-form mb20">
					<div class="form-grou"><label class="label-long2">上传支付凭证：</label>
						<a href="${entity.attachment.url_ }">${entity.attachment.old_name }</a>
					</div>
				</div>

		</div>
		
		<div class="bottom-line"></div>
			<p class="protitleWhite"><span></span>请确认收到投资还款</p>
			
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext w688" name="remark">${entity.attribute3 }</textarea></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long2">上传支付凭证：</label>
							<a href="${entity.attribute1 }">${entity.attribute2 }</a>
						</div>
						
					</div>
				</div>
		
				</div>
		</c:forEach>
		<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab9_1" class="btn-add">上一页</a>
				
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

	</div>


	<div class="mb80"></div>

		<div id="upfile_div"></div>

	<script>
			$(function(){
				//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				
				//上一页，下一页,返回的跳转
					
				$('#tab9_1').click(function(){	
					var url=$('#eight',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})		
				
				$(".btn-return").click(function(){
					window.parent.location.href="/loanapplicationcontroller/list.htm";
				});
			
			
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
			})
		</script>
</body>
</html>