<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>云保理</title>
		<style type="text/css">
			body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td{
				margin:0; 
				padding:0; 
			}
			
			.nice-select input{
				outline: none;
				width: 100%;
				font-size: 1em;
				padding: 0 10px;
				line-height: 1.8em;
			}
			
			ul{
				list-style: none;
			}
			.nice-select{
				position: relative;
			}
			
			.nice-select ul{
				display: none;
				border: 1px solid #d5d5d5;
				width: 13.9em;
				position: absolute;
				top: 45px;
				overflow: hidden;
				background-color: #fff;
				max-height: 150px;
				overflow-y: auto;
				border-top: 0;
				z-index: 10001;
			}
			
			.nice-select ul li{
				height: 30px;
				line-height: 2em;
				overflow: hidden;
				padding: 0 10px;
				cursor: pointer;
				border-top: 1px solid #d5d5d5;
			}
			
			.nice-select ul li.on{background-color: #e0e0e0;}
			
		</style>
		
	</head>

	<body>
	<%@include file="/ybl4.0/admin/common/link.jsp"%>
	<%-- <div class="w1200">
		<ul class="clearfix iconul">
			<li class="iconlist" url="/financingToConfirm/loanappictionitem?loanApplyId=${loanApply.id}"><div class="proicon bg1 statusOne"></div>项目详情</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectTotalElemets?type=${loanApply.assetsType}&loanApplyId=${loanApply.id}"><div class="proicon bg2 statusTwo"></div>资方办理</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectAssetAttach?loanApplyId=${loanApply.id}"><div class="proicon bg3 statusThree"></div>资产转让确权</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectPlatAudiByLoanOrderId?loanApplyId=${loanApply.id}"><div class="proicon bg4 statusTwo"></div>平台审核</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/selectSettleInfoByLoanOrderNo?orderNo=${loanApply.orderNo }&financingAmount=${loanApply.financing_amount}"><div class="proicon bg5 statusThree"></div>结算放款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist" url="/financingToConfirm/info?id_=${entity.id}&financingAmount=${loanApply.financing_amount}"><div class="proicon bg6 statusThree"></div>收款确认</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg7 statusTwo"></div>还款计划</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg8 statusThree"></div>还款</li>
			<li class="iconlist linelist"><img
				src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
			<li class="iconlist"><div class="proicon bg8 statusThree"></div>还款确认</li>
		</ul>

	</div> --%>
	<form action="">
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">放款申请表</li>
				<li class="formli">资料清单</li>
			</ul>
		</div>
		<div class="w1200 ybl-info box box1">
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form" name="orderNo" value="${loanApplyInfo.orderNo }" readonly/></div>
				<div class="form-grou"><label>申请单位：</label><input class="content-form2" name="enterpriseName" value="${loanApplyInfo.enterpriseName }" readonly/></div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">融资订单号：</label><input class="content-form"  value="${loanApplyInfo.financingOrderNumber }"  readonly/></div>
				<div class="form-grou mr40"><label class="label-long">融资主合同号：</label><input class="content-form" name="masterContractNo"  value="${loanApplyInfo.masterContractNo }"   readonly/></div>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>合同总金额：</label><input class="content-form2" value="${contractQuotaV4Vo.newCreditAmount }" readonly/><span class="timeimgLoan">元</span></div>
				<div class="form-grou"><label class="label-long">剩余可用余额：</label><input class="content-form" id="remainBalance" value="${contractQuotaV4Vo.allAmount }" readonly/><span class="timeimgLoan">元</span></div>
			</div>
			
			<div class="bottom-line"></div>
			
			<div class="processLoan">
				<img src="${app.staticResourceUrl}/ybl4.0/resources/images/proLine_img.png" />
				<ul class="clearfix proul clearfix">
					<li class="prolist pro_cur">融资需求<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					<li class="prolist">底层资产<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
				</ul>
			
			<div class="chebox chebox1">
				<p class="protitle"><span></span>放款申请信息</p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资方：</label><input class="content-form2" name="financier" value="${loanApplyInfo.financier }" readonly/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资金额：</label><input class="content-form2" name="financing_amount" value="${loanApplyInfo.financingAmount }" /><span class="timeimgLoanLoan">元</span></div>
						<div class="form-grou mr50"><label>融资期限：</label><input class="content-form" name="financingTerm" value="${loanApplyInfo.financingTerm }" /><span class="timeimgLoan">天</span></div>
						<div class="form-grou"><label>融资利率：</label><input class="content-form2" name="financingRate" value="${loanApplyInfo.financingRate }" /><span class="timeimgLoan">%</span></div>
					</div>
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span></span>增信措施</p>
				<div class="pd20">
					<textarea class="protext btn-center" name="trustMeasure">${loanApplyInfo.trustMeasure }</textarea>
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span></span>备注</p>
				<div class="pd20">
					<textarea class="protext btn-center" name="financingDemandRemark">${loanApplyInfo.financingDemandRemark }</textarea>
				</div>
				
			</div>
			
			<div class="chebox chebox2">
				<p class="protitle"><span></span>资产类型</p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label>资产类型：</label>
							<select class="content-form sele" id="assetsType" name="assetsType" <%-- <c:if test="${operType == 'query' }">disabled="disabled"</c:if> --%>>
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
						<div class="form-grou"><label class="label-long">选择底层资产：</label><input class="content-form2" readonly/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_search_icon.png" class="timeimgLoan" /></div>
					</div>
				</div>
				
				<div class="bottom-line"></div>
				<c:if test="${loanApplyInfo.assetsType == '1' }">
					<div class="togglebox togglebox1">
					<p class="protitle"><span></span>应收账款信息</p>
					<div class="pd20 clearfix">
						<div class="tabD mt30">
							<table id="receivableTb">
								<tr class="receivableTr">
									<th>客户名称</th>
									<th>合同/订单信息</th>
									<th>合同/订单金额</th>
									<th>合同/订单单价</th>
									<th>合同/订单数量</th>
									<th>应收账款金额</th>
									<th>签署日期</th>
									<th>预支付日期</th>
									<th>发票信息</th>
									<th>备注</th>
								</tr>
								<c:forEach items="${accountsReceivableList}" var="entity" varStatus="index">
									<tr class="addReceivable" style="border:1px">
										<td>${entity.customerName}</td>
										<td>${entity.orderInfo}</td>
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.amountsReceivableMoney}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatDate value='${entity.signDate}' pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value='${entity.expectedPaymentDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<p class="protitle"><span></span>附件</p>
					<c:forEach items="${attachmentList}" var="obj" varStatus="index">
						<c:if test="${obj.type==61 }">
						<div class="pd20">
							<div id='licensePhoto'>
								<a href="/fileDownloadController/downloadftp?id=${obj.id }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
							</div>
						</div>
						</c:if>
					</c:forEach>
					</div>
				</c:if>
				<c:if test="${loanApplyInfo.assetsType == '2' }">
					<div class="togglebox togglebox1">
						<p class="protitle"><span></span>应付账款信息</p>
						<div class="pd20 clearfix">
							<div class="tabD mt30">
								<table id="repayableTb">
									<tr class="repayableTr">
										<th>供应商名称</th>
										<th>合同/订单信息</th>
										<th>合同/订单金额</th>
										<th>合同/订单单价</th>
										<th>合同/订单数量</th>
										<th>应付账款金额</th>
										<th>签署日期</th>
										<th>预支付日期</th>
										<th>发票信息</th>
										<th>备注</th>
									</tr>
									<c:forEach items="${accountsPayableList}" var="entity" varStatus="index">
									<tr class="addReceivable" style="border:1px">
										<td>${entity.supplierName}</td>
										<td>${entity.orderInfo}</td>
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.amountsPayableMoney}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.signDate}" pattern="yyyy-MM-dd"/></td>
										<td><fmt:formatDate value='${entity.expectedPaymentDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
								</table>
							</div>
						</div>
						<p class="protitle"><span></span>附件</p>
						<c:forEach items="${attachmentList}" var="obj" varStatus="index">
							<c:if test="${obj.type==61 }">
							<div class="pd20">
								<div id='licensePhoto'>
									<a href="/fileDownloadController/downloadftp?id=${obj.id }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
								</div>
							</div>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${loanApplyInfo.assetsType == '3' }">
					<div class="togglebox togglebox1">
					<p class="protitle"><span></span>票据信息</p>
					<div class="pd20 clearfix">
						<div class="tabD mt30">
							<table id="billTb">
								<tr class="billTr">
									<th>承兑人名称</th>
									<th>票据号码</th>
									<th>合同/订单信息</th>
									<th>合同/订单金额</th>
									<th>合同/订单单价</th>
									<th>合同/订单数量</th>
									<th>票据金额</th>
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
										<td><fmt:formatNumber value="${entity.orderAmount}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td>${entity.orderNumber}</td>
										<td><fmt:formatNumber value="${entity.billAmount}" pattern="##0.00" maxFractionDigits="2"/></td>
										<td><fmt:formatNumber value="${entity.billingDate}" pattern="yyyy-MM-dd"/></td>
										<td><fmt:formatDate value='${entity.expireDate}' pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value='${entity.signDate}' pattern="yyyy-MM-dd" /></td>
										<td>${entity.invoiceInfo}</td>
										<td>${entity.remark}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<p class="protitle"><span></span>附件</p>
						<c:forEach items="${attachmentList}" var="obj" varStatus="index">
							<c:if test="${obj.type==61 }">
							<div class="pd20">
								<div id='licensePhoto'>
									<a href="/fileDownloadController/downloadftp?id=${obj.id }" ><img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" /></a>
								</div>
							</div>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
			</div>
			<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab1_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div> 
			
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
									<c:forEach items="${attachmentList}" var="obj" varStatus="index">
										<c:if test="${obj.type==41 }">
											<tr>
												<td><i style="color:red">*</i>购销合同</td>
												<td>${obj.oldName }</td>
												<td>原件、复印件、加盖公章、提供扫描件</td>
												<%-- <td><a href="javascript:;">${obj.newName }</a></td> --%>
												<td>${obj.oldName }</td>
												<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
											</tr>
										</c:if>
									</c:forEach>
									<c:forEach items="${attachmentList}" var="obj" varStatus="index">
										<c:if test="${obj.type==42 }">
											<tr>
												<td><i style="color:red">*</i>销售发票(含清单)</td>
												<td>原件、复印件、加盖公章、提供扫描件</td>
												<%-- <td><a href="javascript:;">${obj.newName }</a></td> --%>
												<td>${obj.oldName }</td>
												<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
											</tr>
										</c:if>
									</c:forEach>
									<c:forEach items="${attachmentList}" var="obj" varStatus="index">
										<c:if test="${obj.type==43 }">
											<tr>
												<td>采购订单、出入库清单、库存清单</td>
												<td>原件、复印件、加盖公章、提供扫描件</td>
												<%-- <td><a href="javascript:;">${obj.newName }</a></td> --%>
												<td>${obj.oldName }</td>
												<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
											</tr>
										</c:if>
									</c:forEach>
									<c:forEach items="${attachmentList}" var="obj" varStatus="index">
										<c:if test="${obj.type==44 }">
											<tr>
												<td>其他与融资相关的重要材料</td>
												<td>原件、复印件、加盖公章、提供扫描件</td>
												<%-- <td><a href="javascript:;">${obj.newName }</a></td> --%>
												<td>${obj.oldName }</td>
												<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
					</div>
					
					<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab1_3" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div> 
				</div>
		</div>
		</form>
	</body>

</html>