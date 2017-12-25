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
	<!--top start -->
         <jsp:include page="/ybl4.0/admin/common/top.jsp" /> 
    <!--top end -->
	<body>
		<div class="w1200">
		<%-- <c:if test="${returnPage ne '2' }"> --%>
			<ul class="clearfix iconul">
				<li class="iconlist pro_li_cur"><div class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" id="capital_handle_btn"><div class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist" <c:if test="${returnPage ne '2' }">id="asset_btn"</c:if>><div class="proicon bg3<c:if test="${returnPage ne '2' }"> statusThree</c:if><c:if test="${returnPage ne '2' }"> statusOne</c:if>"></div>资产转让确权</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist"><div class="proicon bg4 statusOne"></div>平台审核</li>
                <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist" ><div class="proicon bg5 statusOne"></div>结算放款</li>
                <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist" ><div class="proicon bg6 statusOne"></div>收款确认</li>
                <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist"><div class="proicon bg7 statusOne"></div>还款计划</li>
                <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist" ><div class="proicon bg8 statusOne"></div>还款</li>
                <li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
                <li class="iconlist"><div class="proicon bg8 statusOne"></div>还款确认</li>
			</ul>	
			<%-- </c:if> --%>
		</div>
		<form action="/enterpriseAssetOwnership/assetOwnership" id="pageForm" method="post">
		<input type="hidden" name="loanApplyId" id="loan_apply_id" value="${id }"/>
		<input type="hidden" name="assetsType" id="assetsType" value="${assetsType }"/>
		<input type="hidden" name="returnPage" id="returnPage" value="${returnPage }">
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">放款申请表</li>
				<li class="formli">资料清单</li>
			</ul>
		</div>
		<div class="w1200 ybl-info box box1">
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form2 contentOnlyread" name="orderNo" value="${loanApplyInfo.orderNo }" readonly/></div>
				<div class="form-grou mr40"><label class="label-long">申请单位：</label><input class="content-form2 contentOnlyread" name="enterpriseName" value="${loanApplyInfo.enterpriseName }" readonly/></div>
				<div class="form-grou"><label class="label-long">融资订单号：</label><input class="content-form2 contentOnlyread"  value="${loanApplyInfo.financingOrderNumber }"  readonly/></div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">融资主合同号：</label><input class="content-form2 contentOnlyread" name="masterContractNo"  value="${loanApplyInfo.masterContractNo }" readonly/></div>
				<div class="form-grou mr40"><label class="label-long">合同总金额：</label><input class="content-form2 contentOnlyread" value="<fmt:formatNumber value="${loanApplyInfo.attribute10 }" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
                <div class="form-grou"><label class="label-long">剩余可用余额：</label><input class="content-form2 contentOnlyread" id="remainBalance" value="<fmt:formatNumber value="${loanApplyInfo.attribute9 }" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg">元</span></div>
			</div>
			
			<div class="processLoan mt80">
				<img src="${app.staticResourceUrl}/ybl4.0/resources/images/proLine_img.png" />
				<ul class="clearfix proul clearfix">
					<li class="prolist pro_cur">融资需求<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					<li class="prolist">底层资产<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
				</ul>
			
			<div class="chebox chebox1">
				<p class="protitle"><span>放款申请信息</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label>融资方：</label><input class="content-form contentOnlyread" name="financier" value="${loanApplyInfo.financier }" readonly/></div>
						<div class="form-grou mr40"><label>融资金额：</label><input class="content-form contentOnlyread" name="financing_amount" value="<fmt:formatNumber value="${loanApplyInfo.financingAmount }" pattern="#,##0.##" maxFractionDigits="2"/>" readonly /><span class="timeimg">元</span></div>
                        <div class="form-grou mr40"><label>融资期限：</label><input class="content-form contentOnlyread" name="financingTerm" value="${loanApplyInfo.financingTerm }" readonly /><span class="timeimg">天</span></div>
                        <div class="form-grou"><label>融资利率：</label><input class="content-form contentOnlyread" name="financingRate" value="<fmt:formatNumber value="${loanApplyInfo.financingRate }" pattern="#,##0.####" maxFractionDigits="4"/>" readonly /><span class="timeimg">%</span></div>
					</div>
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span>增信措施</span></p>
				<div class="pd20">
					<textarea class="protext btn-center contentOnlyread" name="trustMeasure" readonly>${loanApplyInfo.trustMeasure }</textarea>
				</div>
				
				<p class="protitle"><span>备注</span></p>
				<div class="pd20">
					<textarea class="protext btn-center contentOnlyread" name="financingDemandRemark" readonly>${loanApplyInfo.financingDemandRemark }</textarea>
				</div>
				
			</div>
			
			<div class="chebox chebox2">
				<p class="protitle"><span>资产类型</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label>资产类型：</label>
							<select class="content-form sele contentOnlyread" id="assetsType" disabled="disabled">
								<option value="1" <c:if test="${loanApplyInfo.assetsType == '1' }">selected</c:if>>
									应收账款
								</option>
								<option value="2" <c:if test="${loanApplyInfo.assetsType == '2' }">selected</c:if>>
									应付账款
								</option>
								<option value="3" <c:if test="${loanApplyInfo.assetsType == '3' }">selected</c:if>>
									票据
								</option>
							</select>
						</div>
					</div>
				</div>
				
				<c:if test="${loanApplyInfo.assetsType == '1' }">
					<div class="togglebox togglebox1">
					<p class="protitle"><span>应收账款信息</span></p>
					<div class="pd20 clearfix">
						<div class="tabD mt30">
							<table id="receivableTb">
								<tr class="receivableTr">
									<th>客户名称</th>
									<th>合同/订单信息</th>
									<th>合同/订单金额(元)</th>
									<th>合同/订单单价(元)</th>
									<th>合同/订单数量</th>
									<th>应收账款金额(元)</th>
									<th>签署日期</th>
									<th>预支付日期</th>
									<th>发票信息</th>
									<th>备注</th>
								</tr>
								<c:forEach items="${accountsReceivableList}" var="entity" varStatus="index">
									<tr class="addReceivable" style="border:1px">
										<td>${entity.customerName}</td>
										<td>${entity.orderInfo}</td>
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.amountsReceivableMoney}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatDate value='${entity.signDate}' pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value='${entity.expectedPaymentDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<p class="protitle"><span>附件</span></p>
					<c:if test="${not empty attachmentList}">
					<c:forEach items="${attachmentList}" var="obj" varStatus="index">
						<c:if test="${obj.type == '61' }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }'><img class="uploadimg" title="${obj.oldName }" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
						</div>
						</c:if>
					</c:forEach>
					</c:if>
					</div>
				</c:if>
				<c:if test="${loanApplyInfo.assetsType == '2' }">
					<div class="togglebox togglebox1">
						<p class="protitle"><span>应付账款信息</span></p>
						<div class="pd20 clearfix">
							<div class="tabD mt30">
								<table id="repayableTb">
									<tr class="repayableTr">
										<th>供应商名称</th>
										<th>合同/订单信息</th>
										<th>合同/订单金额(元)</th>
										<th>合同/订单单价(元)</th>
										<th>合同/订单数量</th>
										<th>应付账款金额(元)</th>
										<th>签署日期</th>
										<th>预支付日期</th>
										<th>发票信息</th>
										<th>备注</th>
									</tr>
									<c:forEach items="${accountsPayableList}" var="entity" varStatus="index">
									<tr class="addReceivable" style="border:1px">
										<td>${entity.supplierName}</td>
										<td>${entity.orderInfo}</td>
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.amountsPayableMoney}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatDate value="${entity.signDate}" pattern="yyyy-MM-dd"/></td>
										<td><fmt:formatDate value='${entity.expectedPaymentDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
								</table>
							</div>
						</div>
						<p class="protitle"><span>附件</span></p>
						<c:if test="${not empty attachmentList}">
						<c:forEach items="${attachmentList}" var="obj" varStatus="index">
							<c:if test="${obj.type == '61' }">
							<div class="pd20">
								<div id='licensePhoto'>
									<a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }'><img class="uploadimg" title="${obj.oldName }" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
								</div>
							</div>
							</c:if>
						</c:forEach>
						</c:if>
					</div>
				</c:if>
				<c:if test="${loanApplyInfo.assetsType == '3' }">
					<div class="togglebox togglebox1">
					<p class="protitle"><span>票据信息</span></p>
					<div class="pd20 clearfix">
						<div class="tabD mt30">
							<table id="billTb">
								<tr class="billTr">
									<th>承兑人名称</th>
									<th>票据号码</th>
									<th>合同/订单信息</th>
									<th>合同/订单金额(元)</th>
									<th>合同/订单单价(元)</th>
									<th>合同/订单数量</th>
									<th>票据金额(元)</th>
									<th>出票日期</th>
									<th>到期日期</th>
									<th>签署日期</th>
									<th>发票信息</th>
									<th>备注</th>
								</tr>
								<c:forEach items="${billList}" var="entity" varStatus="index">
									<tr class="addReceivable" style="border:1px">
										<td>${entity.acceptorName}</td>
										<td>${entity.billNo}</td>
										<td>${entity.orderInfo}</td>
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.billAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
										<td><fmt:formatDate value="${entity.billingDate}" pattern="yyyy-MM-dd"/></td>
										<td><fmt:formatDate value='${entity.expireDate}' pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value='${entity.signDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<p class="protitle"><span>附件</span></p>
					<c:if test="${not empty attachmentList}">
						<c:forEach items="${attachmentList}" var="obj" varStatus="index">
							<c:if test="${obj.type == '61' }">
							<div class="pd20">
								<div id='licensePhoto'>
									<a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }'><img class="uploadimg" title="${obj.oldName }" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
								</div>
							</div>
							</c:if>
						</c:forEach>
						</c:if>
					</div>
				</c:if>
			</div>
			<div class="bottom-line"></div>
			</div>
		</div>
		
		<div class="w1200 ybl-info box box2">
			<div class="pd20">
						<div class="tabD">
							<table>
									<tr>
										<th>资料名称</th>
										<th>上传说明</th>
										<th>附件</th>
										<th>操作</th>
									</tr>
									<c:if test="${not empty attachmentList}">
									<c:forEach items="${attachmentList}" var="obj" varStatus="index">
										<c:if test="${obj.type == '41' }">
											<tr>
												<td class="maxwidth200">购销合同</td>
												<td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
												<td class="maxwidth200">${obj.oldName }</td>
												<td><a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }' class="btn-modify">下载</a></td>
											</tr>
										</c:if>
										<c:if test="${obj.type == '42' }">
                                            <tr>
                                                <td class="maxwidth200">销售发票(含清单)</td>
                                                <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                                                <td class="maxwidth200">${obj.oldName }</td>
                                                <td><a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }' class="btn-modify">下载</a></td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${obj.type == '43' }">
                                            <tr>
                                                <td class="maxwidth200">采购订单、出入库清单、库存清单</td>
                                                <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                                                <td class="maxwidth200">${obj.oldName }</td>
                                                <td><a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }' class="btn-modify">下载</a></td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${obj.type == '44' }">
                                            <tr>
                                                <td class="maxwidth200">其他与融资相关的重要材料</td>
                                                <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                                                <td class="maxwidth200">${obj.oldName }</td>
                                                <td><a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }' class="btn-modify">下载</a></td>
                                            </tr>
                                        </c:if>
									</c:forEach>
									</c:if>
								</table>
					</div>
					<div class="bottom-line"></div>
				</div>
		</div>
		<c:if test="${returnPage ne '2' }">
		<div class="btn1 mt40 clearfix mb80">
				<a class="btn-add btn-center" id="next_page">下一页</a>
			</div>	
			</c:if>
			<c:if test="${returnPage eq '2' }">
               <div class="btn2 mt40 clearfix mb80">
                <a class="btn-add btn-center" id="next_page">下一页</a>
                <a class="btn-add btn-center" id="go_back">返回</a>
            </div>
            </c:if>
		</form>				
	</body>
		<script type="text/javascript">
		$(function(){
			//返回按钮
			$("#anqu_close").click(function(){
				window.location.href='/enterpriseAssetOwnership/assetOwnershipList.htm';
			});
			//资方办理 详情页面跳转
			$("#capital_handle_btn,#next_page").click(function(){
				$("#pageForm").attr("action","/enterpriseAssetOwnership/capitalHandle.htm");
				$("#pageForm").submit();
			});
			//资产转让确权跳转
			$("#asset_btn").click(function(){
				$("#pageForm").attr("action","/enterpriseAssetOwnership/assetTransfer.htm");
				$("#pageForm").submit();
			});
			$("#go_back").click(function(){
				window.location.href='/enterpriseAssetOwnership/assetOwnershipList.htm';
			});
		});
			
		</script>
</html>