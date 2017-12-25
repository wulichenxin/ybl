<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		
	</head>

	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
	<body>

	<c:choose>
			<c:when test="${fn:length(records) eq 0}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png" height="200px" width="200px"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${records}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>">${obj.inverName}</li>
				</c:forEach>
			</ul>
		</div>
		<c:forEach items="${records}" var="obj" varStatus="index">
		<div class="w1200 box box${index.count}">
							<form action="" id="subPageForm" method="post">
				<input type="hidden" name="subFinancingApplyId" value="${obj.subFinancingApplyId }"/>
				<p class="protitle"><span>项目初审意见</span></p>
				<div class="ground-form mb20">
						<div class="form-grou mr50"><label style="width: 120px;">初审意见编号：</label><input class="content-form2" name="opinionNumber" value="${obj.opinionNumber}"/></div>
						
					</div>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资企业：</label><input class="content-form2" name="financingEnterprise" value="${obj.financingEnterprise}"/></div>
						<div class="form-grou mr50"><label>融资金额：</label><input class="content-form2" name="financingAmount" value="<fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						<div class="form-grou"><label>融资期限：</label><input class="content-form" name="financingTerm" value="${obj.financingTerm}"/><span class="timeimg">天</span></div>
					</div>
					
					
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>收费方式：</label><select class="content-form2 sffs" name="feeMode">
						<c:if test="${obj.feeMode eq 1}" >
						<option value="1">融资利率</option>
						</c:if>
						<c:if test="${obj.feeMode eq 2}" >
						<option value="2">服务费</option>
						</c:if>
					  <c:if test="${obj.feeMode eq 3}" >
						<option value="3">折价转让</option>
						</c:if>
						
						</select></div>
						<c:if test="${obj.feeMode eq 1}" >
						<div id="financingRate" class="form-grou mr50"><label class="sffs-label">融资利率：</label><input class="content-form2" name="financingRate" value="<fmt:formatNumber value="${obj.financingRate}" pattern="#,##0.####" maxFractionDigits="2"/>"/><span class="timeimg sffs-sp">%</span></div>
						</c:if>
						<c:if test="${obj.feeMode eq 2}" >
						<div class="form-grou mr50"><label>服务费：</label><input class="content-form2" name="serviceFee" value="<fmt:formatNumber value="${obj.serviceFee}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg sffs-sp">元</span></div>
						</c:if>
						 <c:if test="${obj.feeMode eq 3}" >
						
						 
						<div class="form-grou mr50"><label>折价转让费：</label><input class="content-form2" name="serviceFee" value="<fmt:formatNumber value="${obj.transferMoney}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg sffs-sp">元</span></div>
						
						 </c:if>
						 
					</div>
					
				</div>
			
			<div class="bottom-line"></div>
			
			<div class="process">
				<p class="protitle"><span>融资说明</span></p>
				<div class="pd20">
					融资说明：<textarea class="protext" name="financingExplain">${obj.financingExplain}</textarea>
				</div>	
				<p class="protitle"><span>交易结构</span></p>
				<div class="pd20">
					交易结构：<textarea class="protext" name="transactionStructure">${obj.transactionStructure}</textarea>
				</div>	
				<p class="protitle"><span>增信措施</span></p>
				<div class="pd20">
					增信措施：<textarea class="protext" name="trustMeasure">${obj.trustMeasure}</textarea>
				</div>	
				<p class="protitle"><span>审核意见</span></p>
				<div class="pd20">
					审核意见：<textarea class="protext" name="auditOpinion">${obj.auditOpinion}</textarea>
				</div>	
				<div class="pd20 mt20">
					<div class="form-grou mr50"><label style="text-align: right;">日期：</label><input id="auditDate" class="content-form" name="auditDate" disabled="disabled" value="<fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" />"/>
				</div>	
				
				<p class="protitle"><span>资方初审结果</span></p>
				<div class="ground-form mb20">
					<div class="form-grou mr50"><label style="text-align: right;">初审结果：</label>
						<select class="content-form2" name="auditResult">
						<c:if test="${obj.auditResult eq 1}"><option value="">通过</option></c:if>
						<c:if test="${obj.auditResult eq 2}"><option value="">不通过</option></c:if>
						<c:if test="${obj.auditResult eq 3}"><option value="">驳回</option></c:if>	
				
						</select>
					</div>
				</div>
				<div class="pd20">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark">${obj.remark}</textarea>
				</div>
				
				<p class="protitle"><span>初审意见表</span></p>
				
				<c:if test="${obj.attribute1>0 }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${obj.attribute1 }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
							<div id='licensePhoto_div'></div>
						</div>
					</c:if>
			</form>	
			

			
			<div class="mt40"></div>
			</div>
		</div>
		<!-- 图片上传 部分 start -->
		<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
		</form>

		
		
		</div>
		
		</c:forEach>
			<div class="bottom-line mb30"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab3_1" class="btn-add">上一页</a>
					<a href="#" id="tab3_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

		<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>
		<script>
			$('#beginDate,#endDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			
			$(function(){
				
				//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				//上一页，下一页,返回的跳转
				
					
				$('#tab3_1').click(function(){	
					/* $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#two',parent.document).addClass('pro_li_cur');
					var url=$('#two',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#two',parent.document).click();
				})
				
				$('#tab3_2').click(function(){
/* $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#four',parent.document).addClass('pro_li_cur');
					var url=$('#four',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#four',parent.document).click();
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