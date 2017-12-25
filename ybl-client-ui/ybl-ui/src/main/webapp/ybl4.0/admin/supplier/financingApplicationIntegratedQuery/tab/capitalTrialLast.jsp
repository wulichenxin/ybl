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
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/copy.css" />
<script language='javascript' src="${app.staticResourceUrl}/ybl4.0/resources/js/copy.js"></script>
		<!--top end -->
		
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
		<div class="w1200 ybl-info box box${index.count}">
			
			<div class="process">
				<img src="${app.staticResourceUrl}/ybl4.0/resources/images/proLine_img.png" />
				<ul class="clearfix proul clearfix">
					<li class="prolist pro_cur">合作要素表<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					<li class="prolist">终审意见表<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					
				</ul>
					<div class="chebox chebox1">
							<form action="" id="subPageForm" method="post">
				<p class="protitle"><span>合作要素表</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label style="width: 114px;">合作要素表编号：</label><input class="content-form2" name="elementsOrderNo" value="${obj.elementsOrderNo}"/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资企业：</label><input class="content-form2" name="elementsFinancingEnterprise" value="${obj.elementsFinancingEnterprise}"/></div>
						<div class="form-grou mr50"><label>批复额度：</label><input class="content-form2" name="elementsGiveQuota" value="<fmt:formatNumber value="${obj.elementsGiveQuota}" pattern="#,##0.##" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						<div class="form-grou"><label>融资期限：</label><input class="content-form" name="elementsFinancingTerm" value="${obj.elementsFinancingTerm}"/><span class="timeimg">天</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>收费方式：</label><select class="content-form2 sffs" name="elementsFeeMode">
						<c:if test="${obj.elementsFeeMode eq 1}" >
						<option value="1">融资利率</option>
						</c:if>
						<c:if test="${obj.elementsFeeMode eq 2}" >
						<option value="2">服务费</option>
						</c:if>
						 <c:if test="${obj.elementsFeeMode eq 3}" >
						<option value="3">折价转让</option>
						</c:if>
						</select></div>
						<c:if test="${obj.elementsFeeMode eq 1}" >
							<div id="financingRate" class="form-grou mr50"><label class="sffs-label">融资利率：</label><input class="content-form2" name="financingRate" value="<fmt:formatNumber value="${obj.elementsFinancingRate}" pattern="##0.####" />"/><span class="timeimg sffs-sp">%</span></div>
						</c:if>
						<c:if test="${obj.elementsFeeMode eq 2}" >
							<div class="form-grou mr50"><label>服务费：</label><input class="content-form2" name="serviceFee" value="<fmt:formatNumber value="${obj.elementsServiceFee}" pattern="#,##0.##" />"/><span class="timeimg sffs-sp">元</span></div>
						</c:if>
						 <c:if test="${obj.elementsFeeMode eq 3}" >
							<div class="form-grou mr50"><label>折价转让费：</label><input class="content-form2" name="elementsTransferMoney" value="<fmt:formatNumber value="${obj.elementsTransferMoney}" pattern="#,##0.##" />"/><span class="timeimg sffs-sp">元</span></div>
						 </c:if>
						<div class="form-grou"><label>还款方式：</label><select class="content-form sffs" name="elementsRepaymentMode">
							<c:if test="${obj.elementsRepaymentMode eq 1}" >
							<option value="1">先息后本</option>
							</c:if>
							<%-- <c:if test="${obj.elementsRepaymentMode eq 2}" >
							<option value="2">等额本息</option>
							</c:if> --%>
							<c:if test="${obj.elementsRepaymentMode eq 3}" >
							<option value="3">到期还本息</option>
							</c:if>
							</select>
						</div>
					
					</div>
					<div class="ground-form mb20">
						
						
						<div class="form-grou mr50"><label>资产类型：</label><select class="content-form2 sffs" name="elementsAssetsType">
							<c:if test="${obj.elementsAssetsType eq 1}" >
							<option value="1">应收账款</option>
							</c:if>
							<c:if test="${obj.elementsAssetsType eq 2}" >
							<option value="2">应付账款</option>
							</c:if>
							<c:if test="${obj.elementsAssetsType eq 3}" >
							<option value="3">票据</option>
							</c:if>
							</select>
						</div>
					</div>
					
				
				</div>
			<p class="protitle"><span>风控措施</span></p>
				<div class="pd20">
					<div class="tabD">
						<table>
							<tr>
								<th>序号</th>
								<th>风控措施名称</th>
								<th>备注</th>
								<th>附件</th>
								<c:if test="${ifHaveRecords=='haveRecords' }"><th>操作</th></c:if>
							</tr>
							<c:forEach items="${attachmentList}" var="attachment" varStatus="index">
								<c:if test="${attachment.resourceId==obj.id }">
									<tr>
										<td>${index.count}</td>
										<td>${attachment.attribute1}</td>
										<td>${attachment.remark }</td>
										<td>${attachment.oldName }</td>
										<c:if test="${ifHaveRecords=='haveRecords' }"><td><a href="/fileDownloadController/downloadftp?id=${attachment.id }" class="icon icon-download">下载</a></td></c:if>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</div>
				</div>	
			<div class="bottom-line"></div>
			
			<div class="process">
				<p class="protitle"><span>放款条件</span></p>
				<div class="pd20">
					<div class="form-grou mr50"><label style="text-align: right;">放款条件：</label><textarea class="protext" name="elementsLoanTerms">${obj.elementsLoanTerms}</textarea></div>
				</div>	
				<p class="protitle"><span>备注</span></p>
				<div class="pd20">
					<div class="form-grou mr50"><label style="text-align: right;">备注：</label><textarea class="protext" name="elementsRemark">${obj.elementsRemark}</textarea></div>
				</div>	
				
				
				<div class="pd20" style="padding-top: 10px;">
					<div class="form-grou mr50"><label style="text-align: right;">日期：</label><input id="elementsAuditDate" class="content-form" name="elementsAuditDate" disabled="disabled" value="<fmt:formatDate value="${obj.elementsAuditDate}" pattern="yyyy-MM-dd" />"/></div>
				</div>	
				
				<p class="protitle"><span>终审结果</span></p>
				<div class="pd20">
					<div class="form-grou mr50"><label style="text-align: right;">终审结果：</label>
						<select class="content-form2" name="auditResult">
						<c:if test="${obj.auditResult eq 1}"><option value="">通过</option></c:if>
						<c:if test="${obj.auditResult eq 2}"><option value="">不通过</option></c:if>
						<c:if test="${obj.auditResult eq 3}"><option value="">驳回</option></c:if>	
				
						</select>
					</div>
				</div>
				<div class="pd20" style="padding-top: 10px;">
					<div class="form-grou mr50"><label style="text-align: right;">备注：</label><textarea class="protext" name="attachmentRemark" >${obj.remark}</textarea></div>
				</div>
				
				<p class="protitle"><span>终审意见表</span></p>
				<c:if test="${obj.attachmentId>0 }">
					<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${obj.attachmentId }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
							<div id='licensePhoto_div'></div>
						</div>
				</c:if>
			</form>	
			

			
			<div class="mt40"></div>
		</div>		
		
		</div>
	</div>
				<div class="chebox chebox2">
								<form action="" id="subPageForm" method="post">
				<input type="hidden" name="subFinancingApplyId" value="${obj.subFinancingApplyId }"/>
				<p class="protitle"><span>终审意见表</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label style="width: 100px;">终审意见编号：</label><input class="content-form2" name="opinionNumber" value="${obj.opinionNumber}"/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资企业：</label><input class="content-form2" name="financingEnterprise" value="${obj.financingEnterprise}"/></div>
						<div class="form-grou mr50"><label>融资金额：</label><input class="content-form2" name="financingAmount" value="<fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" />"/><span class="timeimg">元</span></div>
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
						<option value="3">转让费</option>
						</c:if>
						</select></div>
						<c:if test="${obj.feeMode eq 1}" >
						<div id="financingRate" class="form-grou mr50"><label class="sffs-label">融资利率：</label><input class="content-form2" name="financingRate"  value="<fmt:formatNumber value="${obj.financingRate}" pattern="0.####"/>" /><span class="timeimg">%</span></div>
						</c:if>
						<c:if test="${obj.feeMode eq 2}" >
						<div class="form-grou mr50"><label>服务费：</label><input class="content-form" name="serviceFee"  value="<fmt:formatNumber value="${obj.serviceFee}" pattern="#,##0.##"/>"/><span class="timeimg">元</span></div>
						</c:if>
						 <c:if test="${obj.feeMode eq 3}" >
						
						 
						<div class="form-grou mr50"><label>折价转让费：</label><input class="content-form2" name="transferMoney" value="<fmt:formatNumber value="${obj.transferMoney}" pattern="#,##0.##"/>" /><span class="timeimg">元</span></div>
						
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
					<div class="form-grou mr50"><label style="text-align: right;">审核意见：</label><textarea class="protext" name="auditOpinion">${obj.auditOpinion}</textarea></div>
				</div>	
				<div class="pd20" style="padding-top: 10px;">
					<div class="form-grou mr50"><label style="text-align: right;">日期：</label><input id="auditDate" class="content-form" name="auditDate" disabled="disabled" value="<fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" />"/></div>
				</div>
				<%-- <p class="protitle"><span></span>请选择初方z审结果</p>
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
				
				<p class="protitle"><span></span>上传初审意见表</p>
				
				<div class="pd20">
					<div id='licensePhoto'>
						<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
					</div>
					<div id='licensePhoto_div'></div>
				</div> --%>
			</form>	
			

			
			<div class="mt40"></div>
			</div>
			
		
		</div>
						
				</div>	
				

		
		</div>
		</div>
	</c:forEach>
		<div class="btn3 clearfix mt40 mb80">
				<a href="#" id="tab5_1" class="btn-add">上一页</a>
				<a href="#" id="tab5_2" class="btn-add">下一页</a>
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
				$('#tab5_1').click(function(){
					/*  $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#four',parent.document).addClass('pro_li_cur');
					var url=$('#four',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */ 
					$('#four',parent.document).click();
				})
				
				$('#tab5_2').click(function(){
					/*  $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#six',parent.document).addClass('pro_li_cur');
					var url=$('#six',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */ 
					$('#six',parent.document).click();
				})		
				
				$(".btn-return").click(function(){
					var url=$("#jumpurl",parent.document).val();
					window.parent.location.href=url;
				});
			
		
			})
		
		</script>
		</c:otherwise>
		</c:choose>
	</body>

</html>