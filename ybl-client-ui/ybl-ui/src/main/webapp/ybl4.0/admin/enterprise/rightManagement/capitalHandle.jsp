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
			<ul class="clearfix iconul">
				<li class="iconlist" id="loan_application_details"><div class="proicon bg1 statusTwo"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<li class="iconlist pro_li_cur" id="capital_handle_btn"><div class="proicon bg2 statusTwo"></div>资方办理</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon_min.png" /></li>
				<!-- <li class="iconlist" id="asset_btn"><div class="proicon bg3 statusThree"></div>资产转让确权</li> -->
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
			
		</div>
		<form action="/enterpriseAssetOwnership/assetOwnership" id="pageForm" method="post">
		<input type="hidden" name="loanApplyId" id="loan_apply_id" value="${id }"/>
		<input type="hidden" name="assetsType" id="assetsType" value="${type }"/>
		<input type="hidden" name="returnPage" id="returnPage" value="${returnPage }">
			<div class="w1200">
			<!-- ------------------------------------------------------------------应收账款start -------------------------------------------------------------------------------->
				<c:if test="${not empty type and type eq '1'}">
					<p class="protitle"><span>保理要素表(应收账款)</span></p>
					   <div class="grounpinfo">
                <div class="ground-form mb20">
                    <div class="form-grou">
                        <label class="label-long3">保理要素表编号：</label>
                            <input class="content-form2 contentOnlyread" name="orderNo" style="width:208px" value="${ReceivableElementsResult.orderNo}" readonly/>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>卖方名称：</label>
                            <input class="content-form2 contentOnlyread" name="creditor" value="${ReceivableElementsResult.creditor}" readonly/>
                    </div>
                    <div class="form-grou mr50">
                        <label>买方名称：</label>
                            <input class="content-form2 contentOnlyread" name="debtor" value="${ReceivableElementsResult.debtor}" readonly/>
                    </div>
                    <div class="form-grou">
                        <label class="w140">基础合同及编号：</label>
                            <input class="content-form2 contentOnlyread" name="debtor" value="${ReceivableElementsResult.baseContractNo}" readonly/>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>保理方式：</label>
                            <select class="content-form2 contentOnlyread" name="factoringMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
                                <option value="2" <c:if test="${not empty ReceivableElementsResult.factoringMode and ReceivableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label>确权方式：</label>
                            <select class="content-form2 contentOnlyread" name="rightMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty ReceivableElementsResult.rightMode and ReceivableElementsResult.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
                                <option value="2" <c:if test="${not empty ReceivableElementsResult.rightMode and ReceivableElementsResult.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
                            </select>
                    </div>
                    <div class="form-grou">
                        <label class="w140">转让应收账款金额：</label>
                            <input class="content-form2 contentOnlyread" name="transferMoney" value="<fmt:formatNumber value="${ReceivableElementsResult.attribute1}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>结算比例：</label>
                            <input class="content-form2 contentOnlyread" name="financingTermDate" value="<fmt:formatNumber value="${ReceivableElementsResult.balanceScale}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly/><span class="timeimg sffs-sp">%</span>
                    </div>
                      <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 1}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="1" selected="selected">融资利率</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">融资利率：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${ReceivableElementsResult.financingRate}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly/><span class="timeimg sffs-sp">%</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 2}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">服务费</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">服务费：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${ReceivableElementsResult.serviceFee}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty ReceivableElementsResult.feeMode and ReceivableElementsResult.feeMode eq 3}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">折价转让</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">折价转让：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${ReceivableElementsResult.transferMoney}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>还款方式：</label>
                            <select class="content-form2 contentOnlyread" name="repaymentMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
                                <option value="2" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
                                <option value="3" <c:if test="${not empty ReceivableElementsResult.repaymentMode and ReceivableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label>交易方式：</label>
                            <select class="content-form2 contentOnlyread" name="transactionMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty ReceivableElementsResult.transactionMode and ReceivableElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
                                <option value="2" <c:if test="${not empty ReceivableElementsResult.transactionMode and ReceivableElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
                            </select>
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
                        <tr>
                            <td>${obj.assetNumber}</td>
                            <td><fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
                            <td>${obj.financingTerm }</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            </div>
				</c:if>
			<!-- ----------------------------------------------------------------------- 应收账款end-------------------------------------------------------------------------- -->	
			
				<!-- --------------------------------------------------------------------应付账款start------------------------------------------------------------------------- -->
				<c:if test="${not empty type and type eq '2'}">
					<p class="protitle"><span>保理要素表(应付账款)</span></p>
					<div class="grounpinfo">
                <div class="ground-form mb20">
                    <div class="form-grou">
                        <label class="label-long3">保理要素表编号：</label>
                            <input class="content-form2 contentOnlyread" name="orderNo" style="width:208px" value="${payableElementsResult.orderNo}" readonly/>      
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>卖方名称：</label>
                            <input class="content-form2 contentOnlyread" name="creditor" value="${payableElementsResult.creditor}" readonly/>
                    </div>
                    <div class="form-grou mr50">
                        <label>买方名称：</label>
                            <input class="content-form2 contentOnlyread" name="debtor" value="${payableElementsResult.debtor}" readonly/>
                    </div>
                    <div class="form-grou">
                        <label class="w140">基础合同及编号：</label>
                            <input class="content-form2 contentOnlyread" name="debtor" value="${payableElementsResult.baseContractNo}" readonly/>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>保理方式：</label>
                            <select class="content-form2 contentOnlyread" name="factoringMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
                                <option value="2" <c:if test="${not empty payableElementsResult.factoringMode and payableElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label>确权方式：</label>
                            <select class="content-form2 contentOnlyread" name="rightMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty payableElementsResult.rightMode and payableElementsResult.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
                                <option value="2" <c:if test="${not empty payableElementsResult.rightMode and payableElementsResult.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
                            </select>
                    </div>
                    <div class="form-grou">
                        <label class="w140">转让应付账款金额：</label>
                            <input class="content-form2 contentOnlyread" name="transferMoney" value="<fmt:formatNumber value="${payableElementsResult.attribute1}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>结算比例：</label>
                            <input class="content-form2 contentOnlyread" name="financingTermDate" value="<fmt:formatNumber value="${payableElementsResult.balanceScale}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly /><span class="timeimg sffs-sp">%</span>
                    </div>
                      <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 1}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="1" selected="selected">融资利率</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">融资利率：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${payableElementsResult.financingRate}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly/><span class="timeimg sffs-sp">%</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 2}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">服务费</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">服务费：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${payableElementsResult.serviceFee}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty payableElementsResult.feeMode and payableElementsResult.feeMode eq 3}">
                        <div class="form-grou mr50">
                        <label>收费方式：</label>
                            <select class="content-form2 sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">折价转让</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">折价转让：</label>
                            <input class="content-form2 contentOnlyread" name="fee" value="<fmt:formatNumber value="${payableElementsResult.transferMoney}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label>还款方式：</label>
                            <select class="content-form2 contentOnlyread" name="repaymentMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
                                <option value="2" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
                                <option value="3" <c:if test="${not empty payableElementsResult.repaymentMode and payableElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label>交易方式：</label>
                            <select class="content-form2 contentOnlyread" name="transactionMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty payableElementsResult.transactionMode and payableElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
                                <option value="2" <c:if test="${not empty payableElementsResult.transactionMode and payableElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
                            </select>
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
                        <tr>
                            <td>${obj.assetNumber}</td>
                            <td><fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
                            <td>${obj.financingTerm }</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            </div>
				</c:if>
				 <!-- ------------------------------------------------------------------------------应付账款end----------------------------------------------------------------------------- -->  
				 <!-- ------------------------------------------------------------------------------票据start----------------------------------------------------------------------------- --> 
				<c:if test="${not empty type and type eq '3'}">
					<p class="protitle"><span>保理要素表(票据)</span></p>	
					   <div class="grounpinfo">
                <div class="ground-form mb20">
                    <div class="form-grou">
                        <label class="w140">保理要素表编号：</label>
                            <input class="content-form contentOnlyread" name="orderNo" style="width:208px" value="${billElementsResult.orderNo}" readonly/>    
                    </div>
                </div>
                <div class="ground-form mb20">
                        <div class="form-grou mr50">
                            <label class="w140">基础合同及编号：</label>
                            <input class="content-form contentOnlyread" name="baseContractNo" value="${billElementsResult.baseContractNo}" readonly/>
                        </div>
                        <div class="form-grou mr50">
                            <label class="w140">票据持有人：</label>
                            <input  class="content-form contentOnlyread" name="billHolder" value="${billElementsResult.billHolder }" readonly/>
                        </div>
                        <div class="form-grou">
                            <label class="w140">票据承兑人：</label>
                            <input class="content-form contentOnlyread" name="billAcceptor" value="${billElementsResult.billAcceptor }" readonly/>
                        </div>
                    </div>
                    <div class="ground-form mb20">
                        <div class="form-grou mr50">
                            <label class="w140">票价开票日期：</label>
                            <input class="content-form contentOnlyread" name="billingDate" value="<fmt:formatDate value="${billElementsResult.billingDate}" pattern="yyyy-MM-dd" />" readonly/>
                        </div>
                        <div class="form-grou mr50">
                            <label class="w140">票价到期日期：</label>
                            <input  class="content-form contentOnlyread" name="expireDate" value="<fmt:formatDate value="${billElementsResult.expireDate }" pattern="yyyy-MM-dd" />" readonly/>
                        </div>
                        <div class="form-grou">
                            <label class="w140">票价转让日期：</label>
                            <input class="content-form contentOnlyread" name="transferDte" value="<fmt:formatDate value="${billElementsResult.transferDte }" pattern="yyyy-MM-dd" />" readonly/>
                        </div>
                    </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label class="w140">保理方式：</label>
                            <select class="content-form contentOnlyread" name="factoringMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty billElementsResult.factoringMode and billElementsResult.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
                                <option value="2" <c:if test="${not empty billElementsResult.factoringMode and billElementsResult.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label class="w140">确权方式：</label>
                            <select class="content-form contentOnlyread" name="factoringMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 1}">selected="selected"</c:if>>明保理</option>
                                <option value="2" <c:if test="${not empty billElementsResult.rightMode and billElementsResult.rightMode eq 2}">selected="selected"</c:if>>暗保理</option>
                            </select>
                    </div>
                    <div class="form-grou">
                        <label class="w140">票面金额：</label>
                            <input class="content-form contentOnlyread" name="transferMoney" value="${billElementsResult.attribute1}" readonly/><span class="timeimg sffs-sp">元</span>
                    </div>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label class="w140">结算比例：</label>
                            <input class="content-form contentOnlyread" name="financingTermDate" value="<fmt:formatNumber value="${billElementsResult.balanceScale}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly/><span class="timeimg sffs-sp">%</span>
                    </div>
                      <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 1}">
                        <div class="form-grou mr50">
                        <label class="w140">收费方式：</label>
                            <select class="content-form sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="1" selected="selected">融资利率</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">融资利率：</label>
                            <input class="content-form contentOnlyread" name="fee" value="<fmt:formatNumber value="${billElementsResult.financingRate}" pattern="#,##0.####" maxFractionDigits="4"/>" readonly/><span class="timeimg sffs-sp">%</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 2}">
                        <div class="form-grou mr50">
                        <label class="w140">收费方式：</label>
                            <select class="content-form sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">服务费</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">服务费：</label>
                            <input class="content-form contentOnlyread" name="fee" value="<fmt:formatNumber value="${billElementsResult.serviceFee}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                        <c:if test="${not empty billElementsResult.feeMode and billElementsResult.feeMode eq 3}">
                        <div class="form-grou mr50">
                        <label class="w140">收费方式：</label>
                            <select class="content-form sffs contentOnlyread" name="feeMode" disabled="disabled">
                                <option value="2" selected="selected">折价转让</option>
                            </select>
                        </div>
                        <div class="form-grou">
                        <label class="w140">折价转让：</label>
                            <input class="content-form contentOnlyread" name="fee" value="<fmt:formatNumber value="${billElementsResult.transferMoney}" pattern="#,##0.##" maxFractionDigits="2"/>" readonly/><span class="timeimg sffs-sp">元</span>
                        </div> 
                        </c:if>
                </div>
                <div class="ground-form mb20">
                    <div class="form-grou mr50">
                        <label class="w140">还款方式：</label>
                            <select class="content-form contentOnlyread" name="repaymentMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
                                <option value="2" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 2}">selected="selected"</c:if>>等额本息</option>
                                <option value="3" <c:if test="${not empty billElementsResult.repaymentMode and billElementsResult.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
                            </select>
                    </div>
                    <div class="form-grou mr50">
                        <label class="w140">交易方式：</label>
                            <select class="content-form contentOnlyread" name="transactionMode" disabled="disabled">
                                <option>请选择</option>
                                <option value="1" <c:if test="${not empty billElementsResult.transactionMode and billElementsResult.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
                                <option value="2" <c:if test="${not empty billElementsResult.transactionMode and billElementsResult.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
                            </select>
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
                        <tr>
                            <td>${obj.assetNumber}</td>
                            <td><fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" /></td>
                            <td>${obj.financingTerm }</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            </div>
				</c:if>
				<!-- ------------------------------------------------------------------------------票据end-------------------------------------------------------------------- -->    
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
									<c:forEach items="${list}" var="obj" varStatus="index">
										<tr>
											<td>${index.count}</td>
											<td class="maxwidth200">${obj.attribute1 }</td>
											<td class="maxwidth200">${obj.remark }</td>
											<td class="maxwidth200">${obj.oldName }</td>
											<td><a href='/fileDownloadController/downloadNow?newName=${obj.newName }&oldName=${obj.oldName }&extName=${obj.extName }' class="btn-modify">下载</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：
					<textarea class="protext protextOnlyread" readonly="readonly" name="remark"><c:if test="${not empty type and type eq '1'}">${ReceivableElementsResult.remark}</c:if><c:if test="${not empty type and type eq '2'}">${payableElementsResult.remark}</c:if><c:if test="${not empty type and type eq '3'}">${billElementsResult.remark}</c:if></textarea>
					</div>	
				<div class="bottom-line"></div>
				</div>
				<c:if test="${returnPage ne '2' }">
				<div class="btn2 mt40 clearfix mb80">
				<a class="btn-add btn-center" id="previous_page">上一页</a>
				<a class="btn-add btn-center" id="next_page">下一页</a>
			</div>	
			</c:if>
			<c:if test="${returnPage eq '2' }">
                <div class="btn2 mt40 clearfix mb80">
                <a class="btn-add btn-center" id="previous_page">上一页</a>
                 <a class="btn-add btn-center" id="go_back">返回</a>
            </div>  
            </c:if>
			</div>
		</form>				
	</body>
		<script type="text/javascript">
		$(function(){
			//返回按钮
			$("#anqu_close").click(function(){
				window.location.href='/enterpriseAssetOwnership/assetOwnershipList.htm';
			});
			//资产转让确权跳转
			$("#asset_btn,#next_page").click(function(){
				$("#pageForm").attr("action","/enterpriseAssetOwnership/assetTransfer.htm");
				$("#pageForm").submit();
			});
			//项目详情页面跳转
			$("#loan_application_details,#previous_page").click(function(){
				$("#pageForm").attr("action","/enterpriseAssetOwnership/loanApplicationDetails.htm");
				$("#pageForm").submit();
			});
			$("#go_back").click(function(){
                window.location.href='/enterpriseAssetOwnership/assetOwnershipList.htm';
            });
		});
			
		</script>
</html>