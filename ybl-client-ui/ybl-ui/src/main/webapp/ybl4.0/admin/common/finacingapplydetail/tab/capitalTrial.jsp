<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<body>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />

	
	
		
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
				<p class="protitle"><span></span>项目初审意见</p>
				<div class="ground-form mb20">
						<div class="form-grou mr50"><label style="width: 110px;">初审意见编号：</label><input class="content-form2" name="opinionNumber" value="${obj.opinionNumber}"/></div>
						
					</div>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资企业：</label><input class="content-form2" name="financingEnterprise" value="${obj.financingEnterprise}"/></div>
						<div class="form-grou mr50"><label>融资金额：</label><input class="content-form2" name="financingAmount" value="<fmt:formatNumber value="${obj.financingAmount}" pattern="##0.00" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						<div class="form-grou"><label>融资期限：</label><input class="content-form" name="financingTerm" value="${obj.financingTerm}"/>天</div>
					</div>
					
					
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>收费方式：</label><select class="content-form2 sffs" name="feeMode">
						<c:if test="${obj.feeMode eq 1}" >
						<option value="1">融资利率</option>
						</c:if>
						<c:if test="${obj.feeMode eq 2}" >
						<option value="2">服务费</option>
						</c:if>
						
						</select></div>
						
						<div id="financingRate" class="form-grou mr50"><label class="sffs-label">融资利率：</label><input class="content-form2" name="financingRate" value="${obj.financingRate}"/><span class="timeimg sffs-sp">%</span></div>
						<div id="serviceFee" class="form-grou mr50" style="display: none;"><label class="sffs-label">服务费：</label><input class="content-form2" name="serviceFee" value="${obj.serviceFee}"/><span class="timeimg sffs-sp">元</span></div>
						<div class="form-grou mr50"><label>服务费：</label><input class="content-form2" name="serviceFee" value="${obj.serviceFee}"/></div>
					</div>
					
				</div>
			
			<div class="bottom-line"></div>
			
			<div class="process">
				<p class="protitle"><span></span>融资说明</p>
				<div class="pd20">
					融资说明：<textarea class="protext" name="financingExplain">${obj.financingExplain}</textarea>
				</div>	
				<p class="protitle"><span></span>交易结构</p>
				<div class="pd20">
					交易结构：<textarea class="protext" name="transactionStructure">${obj.transactionStructure}</textarea>
				</div>	
				<p class="protitle"><span></span>增信措施</p>
				<div class="pd20">
					增信措施：<textarea class="protext" name="trustMeasure">${obj.trustMeasure}</textarea>
				</div>	
				<p class="protitle"><span></span>审核意见</p>
				<div class="pd20">
					审核意见：<textarea class="protext" name="auditOpinion">${obj.auditOpinion}</textarea>
				</div>	
				<div class="pd20">
					<div class="form-grou mr50"><label style="text-align: right;">日期：</label><input id="auditDate" class="content-form" name="auditDate" disabled="disabled" value="<fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" />"/>"
				</div>	
				
				<p class="protitle"><span></span>资方初审结果</p>
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
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" value="${obj.remark}"></textarea>
				</div>
				
				<p class="protitle"><span></span>初审意见表</p>
				
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
			<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab3_1" class="btn-add">上一页</a>
					<a href="#" id="tab3_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>

		
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
					var url=$('#two',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})
				
				$('#tab3_2').click(function(){	
					var url=$('#four',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})		
				
				$(".btn-return").click(function(){
					window.parent.location.href="/IntegratedQueryController/list.htm";
				});
			
			
			})
		
		</script>
	
		
	</body>


</html>