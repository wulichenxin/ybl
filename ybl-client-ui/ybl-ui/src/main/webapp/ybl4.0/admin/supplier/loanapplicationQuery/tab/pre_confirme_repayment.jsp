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
<title>还款确认</title>
</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/copy.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl4.0/resources/js/copy.js"></script>
		<!--top end -->	
<body>
<c:choose>
			<c:when test="${fn:length(list) eq 0}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<p class="protitle"><span>还款确认</span></p>
	</div>
	<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${list}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>" id="${obj.id}">第${index.count}期</li>
				</c:forEach>
			</ul>
	</div>
	<c:forEach items="${list}" var="obj" varStatus="index">
<div class="w1200 box box${index.count}">
	<form action="" id="subPageForm" method="post">
		<div>
			
			<p class="protitle"><span>还款信息</span></p>
		
				<div class="pd20 mt40">
							<div class="ground-form mb20">
								<div class="form-grou mr40"><label class="label-long2">放款申请单号：</label><input class="content-form2" value="${obj.loanApplyOrderNo }" readonly/></div>
								<div class="form-grou mr40"><label class="label-long2">还款期数：</label><input class="content-form" value="${obj.period }" readonly/><span class="timeimg">期</span></div>
								<div class="form-grou mr40"><label class="label-long">支付时间：</label><input class="content-form" value="<fmt:formatDate value="${obj.actualRepaymentDate}" pattern="yyyy-MM-dd" />" readonly/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr40"><label class="label-long2">付款单位账户银行账号：</label><input class="content-form2" value="${obj.bankAccount }" readonly/></div>
								<div class="form-grou mr40"><label class="label-long2">本期应还金额：</label><input class="content-form" value="<fmt:formatNumber value="${obj.repaymentPrincipal}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
								<div class="form-grou mr40"><label class="label-long">本期应还利息：</label><input class="content-form" value="<fmt:formatNumber value="${obj.repaymentInterest}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>		
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr40"><label class="label-long2">付款单位账户开户行：</label><input class="content-form2" value="${obj.bank }" readonly/></div>
								<div class="form-grou mr40"><label class="label-long2">本次实际支付金额：</label><input class="content-form" value="<fmt:formatNumber value="${obj.actualAmount}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
								<div class="form-grou mr40"><label class="label-long">交易流水号：</label><input class="content-form" value="${obj.transactionOrderNo }" readonly/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr40"><label class="label-long2">付款单位账户开户名称：</label><input class="content-form2" value="${obj.bankAccountName }" readonly/></div>
								<div class="form-grou mr40"><label class="label-long2">逾期费用：</label><input class="content-form" value="<fmt:formatNumber value="${obj.attribute6}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
								<div class="form-grou mr40"><label class="label-long">逾期天数：</label><input class="content-form" value="${obj.overdueDays }" readonly/><span class="timeimg">天</span></div>
							</div>
						<div class="ground-form mb20">
							<div class="form-grou mr40"><label class="label-long2">备注：</label><textarea class="protext" style="width: 915px;" disabled="disabled">${obj.remark }</textarea></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou"><label class="label-long2">支付凭证：</label></div>
							<c:if test="${obj.attribute1!=null&& obj.attribute1!='' }">
								<div class="pd20">
									<div id='licensePhoto'>
										<a href="/fileDownloadController/downloadftp?id=${obj.attribute1 }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
									</div>
									<div id='licensePhoto_div'></div>
								</div>
							</c:if>
						</div>
					</div>
			
			<div class="bottom-line"></div>
			<p class="protitle"><span>确认收到投资还款</span></p>
			
				<div class="pd20 mt40">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label class="label-long">备注：</label><textarea class="protext w688" name="remark">${obj.attribute3 }</textarea></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label class="label-long">上传支付凭证：</label></div>
						<c:if test="${obj.attribute2>0 }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${obj.attribute2 }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
							<div id='licensePhoto_div'></div>
						</div>
					</c:if>
					</div>
				</div>
			<div class="mb80"></div>
			</div>
		</form>	
		
</div>
</c:forEach>
		<div class="bottom-line mb20"></div>
			<div class="btn2 clearfix mb80 mt40">
					<a href="#" id="tab9_1" class="btn-add">上一页</a>
				
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
					
				$('#tab9_1').click(function(){	
					/* var url=$('#eight',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#eight',parent.document).click();
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