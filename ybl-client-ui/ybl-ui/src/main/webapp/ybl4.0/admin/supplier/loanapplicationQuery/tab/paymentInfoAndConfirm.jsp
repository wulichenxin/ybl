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
		<!--top end -->
		<script type="text/javascript">
$(function(){
	$('.yhkje2').hover(function(e){
		$('.jeout').toggle();
	})
})


</script>
<style type="text/css">
.yhkje2{
	position: relative;
	line-height: 30px;
	color: #DCC28A !important;
	cursor: pointer;
}
.yhkje3{
	position: relative;
	line-height: 30px;
	color: #045de6 !important;
	cursor: pointer;
}
</style>
<body>
<c:choose>
			<c:when test="${fn:length(hasPayMents) eq 0}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
	<c:otherwise>
		<p class="protitle"><span>还款</span></p>
	</div>
	<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${hasPayMents}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>" id="${obj.id_}">第${index.count}期</li>
				</c:forEach>
			</ul>
	</div>
	<div class="w1200">
		<c:forEach items="${hasPayMents}" var="entity" varStatus="index">
		<div class="w1200 ybl-info box box${index.count}">
				<div class="ground-form mb20 pd20 ground-label">
				<div class="ground-form mb20">
						<div class="form-grou mr30"><label class="w140">资金方：</label><input class="content-form2" value="${entity.financing_name }" readonly/></div>
						<div class="form-grou mr30"><label class="label-long">核心企业：</label><input class="content-form2" value="${entity.core_enterprise_name}" readonly/></div>
						<div class="form-grou"><label class="label-long">放款申请单号：</label><input class="content-form2" value="${entity.loan_apply_order_no}"  readonly/></div>
					</div>
					
				<div class="ground-form mb20">
						<div class="form-grou mr30"><label class="w140">本次应还本金：</label><input class="content-form2" value="<fmt:formatNumber value="${entity.repayment_principal}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/></div>
						<div class="form-grou mr30"><label class="label-long">本次应还利息：</label><input class="content-form2" value="<fmt:formatNumber value="${entity.repayment_interest}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/></div>
						<div class="form-grou"><label class="label-long">本次逾期利息：</label><input class="content-form2" value="<fmt:formatNumber value="${(entity.repayment_principal*(entity.overdue_interest_rate/100))/360*entity.overdue_days}" pattern="#,##0.##" maxFractionDigits="2"/>"  readonly/></div>
					</div>
<%-- 					<div class="form-grou mr40">
						<label class="label-long2">资金方：</label><label>${entity.financing_name}</label>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">核心企业：</label><label>${entity.core_enterprise_name}</label>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">放款申请单号：</label><label>${entity.loan_apply_order_no}</label>
					</div> --%>
				</div>

				<div class="ground-form mb20 pd20 ground-label">
					<%-- <div class="form-grou mr40">
						<label class="label-long2">本次应还款金额：</label><label><fmt:formatNumber value="${entity.repayment_principal+entity.repayment_interest+(entity.repayment_principal*entity.overdue_days*entity.overdue_interest_rate/100)}" pattern="##0.##" maxFractionDigits="2"/>元</label>
					</div>
					<div class="form-grou mr40">
						<label class="label-long2">还款状态：</label><label>
						<c:if test="${entity.repayment_status eq 1}">待还款</c:if>
						<c:if test="${entity.repayment_status eq 2}">待确认</c:if>
						<c:if test="${entity.repayment_status eq 3}">已逾期</c:if>
						<c:if test="${entity.repayment_status eq 4}">催收中</c:if>
						<c:if test="${entity.repayment_status eq 5}">坏账</c:if>
						<c:if test="${entity.repayment_status eq 6}">已还款</c:if>
						</label>
					</div> --%>
						<div class="ground-form mb20">
						
						<div class="form-grou mr30"><label class="w140">本次应还款金额：</label><input class="content-form2" value="<fmt:formatNumber value="${entity.repayment_principal+entity.repayment_interest}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
						<div class="form-grou mr30">
						<label class="label-long">还款状态：</label><select class="content-form2">
						<option <c:if test="${entity.repayment_status eq 1}">selected="selected"</c:if> >待还款</option>
						<option <c:if test="${entity.repayment_status eq 2}">selected="selected"</c:if> >已还款</option>
						<option <c:if test="${entity.repayment_status eq 3}">selected="selected"</c:if> >已逾期</option>
						<option <c:if test="${entity.repayment_status eq 4}">selected="selected"</c:if> >催收中</option>
						<option <c:if test="${entity.repayment_status eq 5}">selected="selected"</c:if> >坏账</option>
					</select>
						
						
						
					</div>
						<div class="form-grou mr30">
						<label class="label-long">计划还款日：</label><label><input class="content-form2" value="<lzq:date value='${entity.repayment_date}' parttern='yyyy-MM-dd'/>"/></label>
					</div>
					
					</div>
					<div class="jeout" style="position: absolute;top: 179px;left: 43px;">
											<div class="tabD">
									<table>
										<tr>
											<th>序号</th>
											<th>还款日期</th>
											<th>还款金额(元)</th>
											<th>交易流水号</th>
											<th>还款确认</th>
											<th>还款确认时间</th>
											<th>备注</th>
											<th>操作人</th>
										</tr>
										<c:set var="count" value="0"></c:set>
										<c:set var="shouldAlsoAmount" value="0"></c:set>
										<c:forEach items="${hasPayMents}" var="has" varStatus="status" end="${index.count-1 }">
										<c:set var="count" value="${count+has.actual_amount}"></c:set>
										<c:set var="shouldAlsoAmount" value="${shouldAlsoAmount+has.repayment_principal+has.repayment_interest+((has.repayment_principal*(has.overdue_interest_rate/100))/360*has.overdue_days)}"></c:set>
										<tr>
											<td>${status.count}</td>
											<td><lzq:date value='${has.repayment_date}' parttern='yyyy-MM-dd'/></td>
											<td><fmt:formatNumber value="${has.actual_amount}" pattern="##0.##" maxFractionDigits="2"/></td>
											<td>${has.transaction_order_no}</td>
											<td><c:if test="${has.confirm_status eq 1}">否</c:if><c:if test="${has.confirm_status eq 2}">是</c:if></td>
											<td><lzq:date value='${has.confirm_repayment_date}' parttern='yyyy-MM-dd'/></td>
											<td>${has.remark}</td>
											<td>${has.real_name}</td>
										</tr>
										</c:forEach>
									</table>
								</div>
		</div>
					
				</div>

				<div class="ground-form mb20 pd20 ground-label">
					<div class="form-grou mr30">
						<label class="w140">已还款金额：</label> <input class="content-form2 yhkje2"
							value="<fmt:formatNumber value="${count}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span>
					</div>
					<div class="form-grou mr40">
						<label class="label-long">待还款金额：</label><input class="content-form2 yhkje3" 
						value="<fmt:formatNumber value='${totalMoney - shouldAlsoAmount}' pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span>

					</div>
				</div>
		


		<div class="bottom-line"></div>
		<div id="datas" class="pd20 mt40">
			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">本次实际支付金额：</label><input
						name="actual_amount" readonly="readonly" value="<fmt:formatNumber value="${entity.actual_amount}" pattern="#,##0.##" maxFractionDigits="2"/>" class="content-form2" /><span class="timeimg">元</span>
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">交易流水号：</label><input
						name="transaction_order_no" readonly="readonly"   value="${entity.transaction_order_no}"  class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户行：</label><input
						name="bank" readonly="readonly" value="${entity.bank}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户开户名称：</label><input
						name="bank_account_name" value="${entity.bank_account_name}" readonly="readonly" class="content-form2" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long2">付款单位账户银行账号：</label><input
						name="bank_account" readonly="readonly" value="${entity.bank_account}" class="content-form2" />
				</div>
			</div>

			<div class="ground-form mb20">
				<div class="form-grou mr40">
					<label class="label-long2">备注：</label>
					<textarea name="remark" readonly="readonly" class="protext w688">${entity.remark}</textarea>
				</div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">凭证：</label>
					<c:if test="${entity.attribute1>0 }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${entity.attribute1 }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
							<div id='licensePhoto_div'></div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		
				</div>
		</c:forEach>
		<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80 mt80">
					<a href="#" id="tab8_1" class="btn-add">上一页</a>
					<a href="#" id="tab8_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

	</div>


	<div class="mb80"></div>

		<div id="upfile_div"></div>
	<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
	</script>

	<script>
			$(function(){
				//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				
				//上一页，下一页,返回的跳转
				$('#tab8_1').click(function(){	
					/* var url=$('#seven',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#seven',parent.document).click();				})		
				$('#tab8_2').click(function(){	
					/* var url=$('#nine',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#nine',parent.document).click();
				})		
				
				$(".btn-return").click(function(){
					var url=$("#jumpurl",parent.document).val()
					window.parent.location.href=url;
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
		</c:otherwise>
		</c:choose>
</body>
</html>