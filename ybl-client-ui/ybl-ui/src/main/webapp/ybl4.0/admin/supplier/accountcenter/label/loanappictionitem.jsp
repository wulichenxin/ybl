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
			
			.v2_vip_phone dl dd a {
			    width: 180px;
			    height: 100px;
			    display: block;
			    background: url(${app.staticResourceUrl}/ybl/resources/v2/images/xx_add_ico.png) center no-repeat;
			    background-color: #fff;
			    border: 1px solid #dde6ef;
			    box-sizing: border-box;
			    position: relative;
			    border-radius: 5px;
			 } 
			
			.nice-select ul li.on{background-color: #e0e0e0;}
			
			.wenjian{
				display: inline-block;
				text-align: center;
				position: relative;
				margin-right:10px;
			}
			.delimg{
				position: absolute;
				top: -10px;
				right: 10px;
				width: 20px;
				cursor: pointer;
			}
			.red-color-font{
                color:red;
            }
			
		</style>
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/supplier/tabDetail.js"></script>
	<script type="text/javascript">
		$(function(){ 
			$("#tab1_2,#tab1_3").click(function(){
				var loanApplyId=$('#loan_apply_id', parent.document).val();
				var type=$('#assetsType', parent.document).val();
				window.location.href="/tabDetailController/selectTotalElemets?loanApplyId="+loanApplyId+"&type="+type;
			});
		});
	</script>
	
	<body>
	<form id="pageForm">
		<input type="hidden" id="deleteReceivableIdArray" name="deleteReceivableIdArray"/>
		<input type="hidden" id="deleteRepayableIdArray" name="deleteRepayableIdArray"/>
		<input type="hidden" id="deleteBillIdArray" name="deleteBillIdArray"/>
		<input type="hidden" id="deleteFileIdArray" name="deleteFileIdArray"/>
		<input type="hidden" id="financingApplyId" name="financingApplyId" value="${financingApplyId }"/>
		<input type="hidden" id="loanApplyId" name="loanApplyId" value="${loanApplyVO.id }"/>
		<input type="hidden" id="businessId" name="businessId" value="${businessAuth.id }" />
		<input type="hidden" id="operType" name="operType" value="${operType }" />
		<input type="hidden" id="order_no" name="order_no" <c:if test="${operType eq 'insert' }">value="${subFinancingApply.order_no}"</c:if><c:if test="${operType ne 'insert' }">value="${loanApplyVO.masterContractNo}"</c:if>/>
		<input type="hidden" id="status" name="status"/>
		<input type="hidden" id="subFinancingApplyId" name="subFinancingApplyId" value="${subFinancingApply.id}">
		
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">放款申请表</li>
				<li class="formli">资料清单</li>
			</ul>
		</div>
		<div class="w1200 ybl-info box box1">
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">放款申请单号：</label><input class="content-form2" name="orderNo" value="${loanApplyVO.orderNo}" readonly/></div>
				<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form2" name="financingOrderNumber" <c:if test="${operType eq 'insert' }">value="${financingApply.financingOrderNumber }"</c:if><c:if test="${operType ne 'insert' }">value="${loanApplyVO.financingOrderNumber }"</c:if> readonly/></div>
				<div class="form-grou"><label class="label-long">申请单位：</label><input class="content-form2" name="enterpriseName" <c:if test="${operType eq 'insert' }">value="${businessAuth.enterpriseName }"</c:if><c:if test="${operType ne 'insert' }">value="${loanApplyVO.enterpriseName }"</c:if> readonly/></div>
			</div>
			
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label class="label-long">融资主合同号：</label><input class="content-form2" name="masterContractNo" <c:if test="${operType eq 'insert' }">value="${subFinancingApply.order_no }"</c:if><c:if test="${operType ne 'insert' }">value="${loanApplyVO.masterContractNo }"</c:if> readonly/></div>
				<div class="form-grou mr40"><label>合同总金额：</label><input class="content-form2" id="contractAmount" placeholder="计算中..." readonly/><span class="timeimg">元</span></div>
				<div class="form-grou"><label class="label-long">剩余可用余额：</label><input class="content-form2" placeholder="计算中..." id="remainBalance" readonly/><span class="timeimg">元</span></div>
			</div>
			
			<div class="bottom-line"></div>
			
			<div class="process">
				<img src="${app.staticResourceUrl}/ybl4.0/resources/images/proLine_img.png" />
				<ul class="clearfix proul clearfix">
					<li class="prolist pro_cur">融资需求<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					<li class="prolist">底层资产<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
				</ul>
			
			<div class="chebox chebox1">
				<p class="protitle"><span>放款申请信息</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>融资方：</label><input class="content-form2" name="financier" <c:if test="${operType == 'insert'}">value="${businessAuth.enterpriseName }"</c:if> <c:if test="${operType ne 'insert'}">value="${loanApplyVO.financier }"</c:if> readonly/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label><i class="red-color-font">*</i>融资金额：</label><input class="content-form2 validate[maxSize[20],custom[number],min[0]]" name="financing_amount" value="<fmt:formatNumber value="${loanApplyVO.financing_amount }" pattern="##0.##" maxFractionDigits="2"/>" id="financing_amount" /><span class="timeimg">元</span></div>
						<div class="form-grou mr50"><label><i class="red-color-font">*</i>融资期限：</label><input class="content-form validate[maxSize[20],custom[number],min[0]]" name="financingTerm" value="${loanApplyVO.financingTerm }" /><span class="timeimg">天</span></div>
						<div class="form-grou"><label><i class="red-color-font">*</i>融资利率：</label><input class="content-form2 validate[maxSize[20],custom[number],min[0],max[100]]" name="financingRate" value="<fmt:formatNumber value="${loanApplyVO.financingRate }" pattern="##0.####" maxFractionDigits="4"/>" /><span class="timeimg">%</span></div>
					</div>
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span>增信措施</span></p>
				<div class="pd20">
					<textarea class="protext btn-center validate[maxSize[120]]" name="trustMeasure">${loanApplyVO.trustMeasure }</textarea>
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span>备注</span></p>
				<div class="pd20">
					<textarea class="protext btn-center validate[maxSize[120]]" name="financingDemandRemark">${loanApplyVO.financingDemandRemark }</textarea>
				</div>
				
			</div>
			
			<div class="chebox chebox2">
				<p class="protitle"><span>选择资产类型</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label><i class="red-color-font">*</i>资产类型：</label>
							<select class="content-form sele" id="assetsType" name="assetsType" <%-- <c:if test="${operType == 'query' }">disabled="disabled"</c:if> --%>>
								<option value="1" 
									<c:if test="${operType eq 'insert' }"><c:if test="${financingApply.assetsType eq '1' }">selected</c:if></c:if>
									<c:if test="${operType ne 'insert' }"><c:if test="${loanApplyVO.assetsType eq '1' }">selected</c:if></c:if>
								>
									应收账款
								</option>
								<option value="2" 
									<c:if test="${operType eq 'insert' }"><c:if test="${financingApply.assetsType eq '2' }">selected</c:if></c:if>
									<c:if test="${operType ne 'insert' }"><c:if test="${loanApplyVO.assetsType eq '2' }">selected</c:if></c:if>
								>
									应付账款
								</option>
								<option value="3" 
									<c:if test="${operType eq 'insert' }"><c:if test="${financingApply.assetsType eq '3' }">selected</c:if></c:if>
									<c:if test="${operType ne 'insert' }"><c:if test="${loanApplyVO.assetsType eq '3' }">selected</c:if></c:if>
								>
									票据
								</option>
							</select>
						</div>
						<div class="form-grou"><label class="label-long">选择底层资产：</label><input class="content-form2" readonly/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_search_icon.png" class="timeimg" <c:if test="${operType ne 'query' }">id="selectAssets"</c:if> /></div>
					</div>
				</div>
				
				<div class="bottom-line"></div>
				
				<div class="togglebox togglebox1">
				<p class="protitle"><span>应收账款信息</span></p>
				<div class="pd20 clearfix">
					<c:if test="${operType ne 'query' }">
						<a class="btn-modify fr" onclick="receivableAdd()">添加行</a>
					</c:if>
					<div class="tabD mt30">
					<div class="scrollbox">
						<table id="receivableTb">
							<tr class="receivableTr" id="receivableAfter">
								<th>资产编号</th>
								<th><i class="red-color-font">*</i>客户名称</th>
								<th><i class="red-color-font">*</i>合同/订单信息</th>
								<th><i class="red-color-font">*</i>合同/订单金额(元)</th>
								<th>合同/订单单价(元)</th>
								<th>合同/订单数量(个)</th>
								<th><i class="red-color-font">*</i>应收账款金额(元)</th>
								<th><i class="red-color-font">*</i>签署日期</th>
								<th><i class="red-color-font">*</i>预支付日期</th>
								<th><i class="red-color-font">*</i>发票信息</th>
								<th>备注</th>
								<c:if test="${operType ne 'query' }"><th>操作</th></c:if>
							</tr>
							<tr class="addReceivable <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">chkReceivableTr</c:if>" 
							     <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">uid="${receivableList[0].pid }"</c:if>>
								<td><input class="tdinput chkReceivableAssetNumber" type="text" readonly style="color:#666" value="${receivableList[0].assetNumber}" name="receivableList[0].assetNumber"/></td>
								<td>
									<input type="hidden" value="${receivableList[0].id }" name="receivableList[0].id" />
									<input type="hidden" value="${receivableList[0].pid }" name="receivableList[0].pid" />
									<div class="nice-select">
										<input class="tdinput <c:if test="${empty receivableList[0].pid or receivableList[0].pid eq 0 }">select-enterprise</c:if> checkReceivable validate[maxSize[20]]"  <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${receivableList[0].customerName}" name="receivableList[0].customerName" type="text" oninput="searchList(this.value)" />
									</div>
								</td>
								<td><input class="tdinput validate[maxSize[120]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${receivableList[0].orderInfo}" name="receivableList[0].orderInfo"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${receivableList[0].orderAmount}" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[0].orderAmount"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${receivableList[0].orderUnitPrice}" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[0].orderUnitPrice"/></td>
								<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${receivableList[0].orderNumber}" name="receivableList[0].orderNumber"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${receivableList[0].amountsReceivableMoney}" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[0].amountsReceivableMoney"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${receivableList[0].signDate}' pattern="yyyy-MM-dd" />" name="receivableList[0].signDate"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${receivableList[0].expectedPaymentDate}' pattern="yyyy-MM-dd" />" name="receivableList[0].expectedPaymentDate"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${receivableList[0].invoiceInfo}" name="receivableList[0].invoiceInfo"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty receivableList[0].pid and receivableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${receivableList[0].remark}" name="receivableList[0].remark"/></td>
								<c:if test="${operType ne 'query' }">
									<td>
										<a class="btn-modify" onclick='receivableDeleteRow(this,${receivableList[0].id })'>删除</a>
									</td>
								</c:if>
							</tr>
							<c:if test="${operType ne 'insert' }">
								<c:forEach items="${receivableList}" begin="1" varStatus="index" var="obj">
									<tr class="addReceivable <c:if test="${not empty obj.pid and obj.pid ne 0 }">chkReceivableTr</c:if>" 
                                        <c:if test="${not empty obj.pid and obj.pid ne 0 }">uid="${obj.pid }"</c:if>>
										<td><input class="tdinput chkReceivableAssetNumber" type="text" readonly style="color:#666" value="${obj.assetNumber}" name="receivableList[${index.count }].assetNumber"/></td>
										<td>
											<input type="hidden" value="${obj.id }" name="receivableList[${index.count }].id" />
											<input type="hidden" value="${obj.pid }" name="receivableList[${index.count }].pid" />
											<div class="nice-select">
												<input class="tdinput  <c:if test="${empty obj.pid or obj.pid eq 0 }">select-enterprise</c:if> checkReceivable validate[maxSize[20]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="${obj.customerName }" oninput="searchList(this.value)" name="receivableList[${index.count }].customerName"/>
											</div>
										</td>
										<td><input class="tdinput validate[maxSize[120]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.orderInfo }" name="receivableList[${index.count }].orderInfo"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[${index.count }].orderAmount"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[${index.count }].orderUnitPrice"/></td>
										<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.orderNumber }" name="receivableList[${index.count }].orderNumber"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.amountsReceivableMoney }" pattern="##0.##" maxFractionDigits="2"/>" name="receivableList[${index.count }].amountsReceivableMoney"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="receivableList[${index.count }].signDate"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />" name="receivableList[${index.count }].expectedPaymentDate"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.invoiceInfo }" name="receivableList[${index.count }].invoiceInfo"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.remark }" name="receivableList[${index.count }].remark"/></td>
										<c:if test="${operType == 'update' }">
											<td>
												<a class="btn-modify" onclick='receivableDeleteRow(this,${obj.id })'>删除</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
					</div>
				</div>
				</div>
				
				<div class="togglebox togglebox2">
				<p class="protitle"><span>应付账款信息</span></p>
				<div class="pd20 clearfix">
					<c:if test="${operType ne 'query' }">
						<a class="btn-modify fr" onclick="repayableAdd()">添加行</a>
					</c:if>
					<div class="tabD mt30">
					<div class="scrollbox">
						<table id="repayableTb">
							<tr class="repayableTr" id="repayableAfter">
								<th>资产编号</th>
								<th><i class="red-color-font">*</i>供应商名称</th>
								<th><i class="red-color-font">*</i>合同/订单信息</th>
								<th><i class="red-color-font">*</i>合同/订单金额(元)</th>
								<th>合同/订单单价(元)</th>
								<th>合同/订单数量(个)</th>
								<th><i class="red-color-font">*</i>应付账款金额(元)</th>
								<th><i class="red-color-font">*</i>签署日期</th>
								<th><i class="red-color-font">*</i>预支付日期</th>
								<th><i class="red-color-font">*</i>发票信息</th>
								<th>备注</th>
								<c:if test="${operType ne 'query' }"><th>操作</th></c:if>
							</tr>
							<tr class="addRepayable <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">chkRepayableTr</c:if>" 
                                 <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">uid="${repayableList[0].pid }"</c:if>>
								<td><input class="tdinput chkRepayableAssetNumber" type="text" readonly style="color:#666" value="${repayableList[0].assetNumber}" name="repayableList[0].assetNumber"/></td>
								<td>
									<input type="hidden" value="${repayableList[0].id}" name="repayableList[0].id" />
									<input type="hidden" value="${repayableList[0].pid}" name="repayableList[0].pid" />
									<div class="nice-select">
										<input class="tdinput validate[maxSize[20]] <c:if test="${empty repayableList[0].pid or repayableList[0].pid eq 0 }">select-enterprise</c:if> checkRepayable" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${repayableList[0].supplierName}" name="repayableList[0].supplierName" type="text" oninput="searchList(this.value)" />
									</div>
								</td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${repayableList[0].orderInfo}" name="repayableList[0].orderInfo"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${repayableList[0].orderAmount}" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[0].orderAmount"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${repayableList[0].orderUnitPrice}" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[0].orderUnitPrice"/></td>
								<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${repayableList[0].orderNumber}" name="repayableList[0].orderNumber"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${repayableList[0].amountsPayableMoney}" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[0].amountsPayableMoney"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${repayableList[0].signDate}' pattern="yyyy-MM-dd" />" name="repayableList[0].signDate"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${repayableList[0].expectedPaymentDate}' pattern="yyyy-MM-dd" />" name="repayableList[0].expectedPaymentDate"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${repayableList[0].invoiceInfo}" name="repayableList[0].invoiceInfo"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty repayableList[0].pid and repayableList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${repayableList[0].remark}" name="repayableList[0].remark"/></td>
								<c:if test="${operType ne 'query' }">
									<td>
										<a class="btn-modify" onclick='repayableDeleteRow(this,${repayableList[0].id })'>删除</a>
									</td>
								</c:if>
							</tr>
							<c:if test="${operType ne 'insert' }">
								<c:forEach items="${repayableList}" begin="1" varStatus="index" var="obj">
									<tr class="addRepayable <c:if test="${not empty obj.pid and obj.pid ne 0 }">chkRepayableTr</c:if>" 
                                        <c:if test="${not empty obj.pid and obj.pid ne 0 }">uid="${obj.pid }"</c:if>>
										<td><input class="tdinput chkRepayableAssetNumber" readonly style="color:#666" type="text"  value="${obj.assetNumber}" name="repayableList[${index.count }].assetNumber"/></td>
										<td>
											<input type="hidden" value="${obj.id }" name="repayableList[${index.count }].id" />
											<input type="hidden" value="${obj.pid }" name="repayableList[${index.count }].pid" />
											<div class="nice-select">
												<input class="tdinput validate[maxSize[20]] <c:if test="${empty obj.pid or obj.pid eq 0 }">select-enterprise</c:if> checkRepayable"  <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="${obj.supplierName }" oninput="searchList(this.value)" name="repayableList[${index.count }].supplierName"/>
											</div>
										</td>
										<td><input class="tdinput validate[maxSize[120]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="${obj.orderInfo }" name="repayableList[${index.count }].orderInfo"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[${index.count }].orderAmount"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[${index.count }].orderUnitPrice"/></td>
										<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="${obj.orderNumber }" name="repayableList[${index.count }].orderNumber"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatNumber value="${obj.amountsPayableMoney }" pattern="##0.##" maxFractionDigits="2"/>" name="repayableList[${index.count }].amountsPayableMoney"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="repayableList[${index.count }].signDate"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />" name="repayableList[${index.count }].expectedPaymentDate"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.invoiceInfo }" name="repayableList[${index.count }].invoiceInfo"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.remark }" name="repayableList[${index.count }].remark"/></td>
										<c:if test="${operType == 'update' }">
											<td>
												<a class="btn-modify" onclick='repayableDeleteRow(this,${obj.id })'>删除</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
					</div>
				</div>
				</div>
				
				
				<div class="togglebox togglebox3">
				<p class="protitle"><span>票据信息</span></p>
				<div class="pd20 clearfix">
					<c:if test="${operType ne 'query' }">
						<a class="btn-modify fr" onclick="billAdd()">添加行</a>
					</c:if>
					<div class="tabD mt30">
					<div class="scrollbox">
						<table id="billTb">
							<tr class="billTr" id="billAfter">
								<th>资产编号</th>
								<th><i class="red-color-font">*</i>承兑人名称</th>
								<th><i class="red-color-font">*</i>票据号码</th>
								<th>合同/订单信息</th>
								<th><i class="red-color-font">*</i>合同/订单金额(元)</th>
								<th>合同/订单单价(元)</th>
								<th>合同/订单数量(个)</th>
								<th><i class="red-color-font">*</i>票据金额(元)</th>
								<th><i class="red-color-font">*</i>出票日期</th>
								<th><i class="red-color-font">*</i>到期日期</th>
								<th><i class="red-color-font">*</i>签署日期</th>
								<th>发票信息</th>
								<th>备注</th>
								<c:if test="${operType ne 'query' }"><th>操作</th></c:if>
							</tr>
							<tr class="addBill <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">chkBillTr</c:if>" 
                                 <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">uid="${billList[0].pid }"</c:if>>
								<td><input class="tdinput chkBillAssetNumber" type="text" readonly style="color:#666" value="${billList[0].assetNumber}" name="billList[0].assetNumber"/></td>
								<td>
									<input type="hidden" value="${billList[0].id }" name="billList[0].id" />
									<input type="hidden" value="${billList[0].pid }" name="billList[0].pid" />
									<div class="nice-select">
										<input class="tdinput validate[maxSize[20]] <c:if test="${empty billList[0].pid or billList[0].pid eq 0 }">select-enterprise</c:if> checkBill" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].acceptorName}" name="billList[0].acceptorName" type="text" oninput="searchList(this.value)" />
									</div>
								</td>
								<td><input class="tdinput validate[maxSize[20]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].billNo}" name="billList[0].billNo"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].orderInfo}" name="billList[0].orderInfo"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${billList[0].orderAmount}" pattern="##0.##" maxFractionDigits="2"/>" name="billList[0].orderAmount"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${billList[0].orderUnitPrice}" pattern="##0.##" maxFractionDigits="2"/>" name="billList[0].orderUnitPrice"/></td>
								<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].orderNumber}" name="billList[0].orderNumber"/></td>
								<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${billList[0].billAmount}" pattern="##0.##" maxFractionDigits="2"/>" name="billList[0].billAmount"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${billList[0].billingDate}' pattern="yyyy-MM-dd" />" name="billList[0].expireDate"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${billList[0].expireDate}' pattern="yyyy-MM-dd" />" name="billList[0].billingDate"/></td>
								<td><input class="tdinput selectDate" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${billList[0].signDate}' pattern="yyyy-MM-dd" />" name="billList[0].signDate"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].invoiceInfo}" name="billList[0].invoiceInfo"/></td>
								<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty billList[0].pid and billList[0].pid ne 0 }">readonly style="color:#666"</c:if> value="${billList[0].remark}" name="billList[0].remark"/></td>
								<c:if test="${operType ne 'query' }">
									<td>
										<a class="btn-modify" onclick='billDeleteRow(this,${billList[0].id })'>删除</a>
									</td>
								</c:if>
							</tr>
							<c:if test="${operType ne 'insert' }">
								<c:forEach items="${billList}" begin="1" varStatus="index" var="obj">
									<tr class="addRepayable <c:if test="${not empty obj.pid and obj.pid ne 0 }">chkBillTr</c:if>" 
                                 <c:if test="${not empty obj.pid and obj.pid ne 0 }">uid="${obj.pid }"</c:if>>
										<td><input class="tdinput chkBillAssetNumber" type="text" readonly style="color:#666" value="${obj.assetNumber}" name="billList[${index.count }].assetNumber"/></td>
										<td>	
											<input type="hidden" value="${obj.id }" name="billList[${index.count }].id" />
											<input type="hidden" value="${obj.pid }" name="billList[${index.count }].pid" />
											<div class="nice-select">
												<input class="tdinput validate[maxSize[20]] <c:if test="${empty obj.pid or obj.pid eq 0 }">select-enterprise</c:if> checkBill" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="${obj.acceptorName }" oninput="searchList(this.value)" name="billList[${index.count }].acceptorName"/>
											</div>
										</td>
										<td><input class="tdinput validate[maxSize[20]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.billNo }" name="billList[${index.count }].billNo"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.orderInfo }" name="billList[${index.count }].orderInfo"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>" name="billList[${index.count }].orderAmount"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>" name="billList[${index.count }].orderUnitPrice"/></td>
										<td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.orderNumber }" name="billList[${index.count }].orderNumber"/></td>
										<td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="<fmt:formatNumber value="${obj.billAmount }" pattern="##0.##" maxFractionDigits="2"/>" name="billList[${index.count }].billAmount"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.billingDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].expireDate"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.expireDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].billingDate"/></td>
										<td><input class="tdinput selectDate" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].signDate"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.invoiceInfo }" name="billList[${index.count }].invoiceInfo"/></td>
										<td><input class="tdinput validate[maxSize[120]]" type="text" <c:if test="${not empty obj.pid and obj.pid ne 0 }">readonly style="color:#666"</c:if> value="${obj.remark }" name="billList[${index.count }].remark"/></td>
										<c:if test="${operType == 'update' }">
											<td>
												<a class="btn-modify" onclick='billDeleteRow(this,${obj.id })'>删除</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
					</div>
				</div>
				</div>
				<div class="bottom-line"></div>
				<p class="protitle"><span><i class="red-color-font">*</i>上传附件</span></p>
					<div class="ground-form mb20">
						<div class="form-grou">
							<c:forEach items="${assetList}" varStatus="uindex" var="obj">
								<div class="wenjian"><c:if test="${operType ne 'query'}"><img uid="${obj.id}" class="delimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/del_icon.png" /></c:if><img width="130" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" />
									<input type="hidden" name="assetList[${uindex.index }].id" value="${obj.id }">
									<input type="hidden" name="assetList[${uindex.index }].url" value="${obj.url }">
									<input type="hidden" name="assetList[${uindex.index }].type" value="61">
									<input type="hidden" name="assetList[${uindex.index }].oldName" value="${obj.oldName }">
									<input type="hidden" name="assetList[${uindex.index }].newName" value="${obj.newName }">
									<input type="hidden" name="assetList[${uindex.index }].extName" value="${obj.extName }">
									<input type="hidden" name="assetList[${uindex.index }].fileSize" value="${obj.fileSize }">
									<input type="hidden" name="assetList[${uindex.index }].category" value="6">
									<p><a class="filemaxwidth" href="${obj.url }" title="${obj.oldName }" download="${obj.oldName }">${obj.oldName }</a></p>
								</div>
							</c:forEach>
							<c:if test="${operType ne 'query'}"><img <c:if test="${operType ne 'query'}">class="uploadimg"</c:if> src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" /></c:if>
						</div>
					</div>
					
				</div>
			
			<div class="bottom-line"></div>
			
			
			<c:if test="${operType ne 'query' }"><div class="shenmin">申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div></c:if>
			
			<c:if test="${operType ne 'query' }">
				<div class="btn3 clearfix mb80 btn-submit">
					<a href="javascript:;" class="btn-add" onclick="submitLoan(1)">保存草稿</a>
					<a href="javascript:;" class="btn-add" onclick="submitLoan(2)">保存并提交</a>
					<a href="javascript:history.go(-1);" class="btn-add">取消</a>
				</div>
			</c:if>
            <div class="btn1 clearfix mb80 mt20 submiting" style="display:none" >
                <a class="btn-add btn-center">提交中</a>
            </div>
			<%-- <c:if test="${operType == 'query' }">
				<div class="clearfix mb80 mt20">
					<a href="javascript:history.go(-1);" class="btn-add btn-center">返回</a>
				</div>
			</c:if> --%>
			
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
									<c:if test="${operType ne 'query'}"><th>操作</th></c:if>
								</tr>
								<tr>
									<td class="maxwidth200"><i style="color:red">*</i>购销合同</td>
									<td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="${file41.url }" title="${file41.oldName }" download="${file41.oldName }" id="file41_a">${file41.oldName }</a></td>
									<c:if test="${operType ne 'query'}"><td>
										<a href="javascript:;" class="btn-modify upload-file" id="file41" utype="41" uindex="1" uname="购销合同">上传</a>
										<c:if test="${operType ne 'insert' }"><input type='hidden' value='${file11.id }' name='dataAttachmentList[1].id'/></c:if>
										<div id="file41_div" >
											<input type='hidden' value='${file41.url }' id="file_check_41" name='dataAttachmentList[1].url'/>
											<input type='hidden' value='41' name='dataAttachmentList[1].type'/>
											<input type='hidden' value='${file41.remark }' name='dataAttachmentList[1].remark'/>
											<input type='hidden' value='${file41.oldName }' name='dataAttachmentList[1].oldName'/>
											<input type='hidden' value='${file41.newName }' name='dataAttachmentList[1].newName'/>
											<input type='hidden' value='${file41.extName }' name='dataAttachmentList[1].extName'/>
											<input type='hidden' value='${file41.fileSize }' name='dataAttachmentList[1].fileSize'/>
											<input type='hidden' value='6' name='dataAttachmentList[1].category'/>
										</div>		
									</td></c:if>
								</tr>
								<tr>
									<td class="maxwidth200"><i style="color:red">*</i>销售发票(含清单)</td>
									<td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="${file42.url }" title="${file42.oldName }" download="${file42.oldName }" id="file42_a">${file42.oldName }</a></td>
									<c:if test="${operType ne 'query'}"><td>
										<a href="javascript:;" class="btn-modify upload-file" id="file42" utype="42" uindex="2" uname="销售发票(含清单)">上传</a>
										<c:if test="${operType ne 'insert' }"><input type='hidden' value='${file42.id }' name='dataAttachmentList[2].id'/></c:if>
										<div id="file42_div" >
											<input type='hidden' value='${file42.url }' id="file_check_42" name='dataAttachmentList[2].url'/>
											<input type='hidden' value='42' name='dataAttachmentList[2].type'/>
											<input type='hidden' value='${file42.remark }' name='dataAttachmentList[2].remark'/>
											<input type='hidden' value='${file42.oldName }' name='dataAttachmentList[2].oldName'/>
											<input type='hidden' value='${file42.newName }' name='dataAttachmentList[2].newName'/>
											<input type='hidden' value='${file42.extName }' name='dataAttachmentList[2].extName'/>
											<input type='hidden' value='${file42.fileSize }' name='dataAttachmentList[2].fileSize'/>
											<input type='hidden' value='6' name='dataAttachmentList[2].category'/>
										</div>		
									</td></c:if>
								</tr>
								<tr>
									<td class="maxwidth200">采购订单、出入库清单、库存清单</td>
									<td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="${file43.url }" title="${file43.oldName }" download="${file43.oldName }" id="file43_a">${file43.oldName }</a></td>
									<c:if test="${operType ne 'query'}"><td>
										<a href="javascript:;" class="btn-modify upload-file" id="file43" utype="43"  uindex="3" uname="采购订单、出入库清单、库存清单">上传</a>
										<c:if test="${operType ne 'insert' }"><input type='hidden' value='${file43.id }' name='dataAttachmentList[3].id'/></c:if>
										<div id="file43_div" >
											<input type='hidden' value='${file43.url }' name='dataAttachmentList[3].url'/>
											<input type='hidden' value='43' name='dataAttachmentList[3].type'/>
											<input type='hidden' value='${file43.remark }' name='dataAttachmentList[3].remark'/>
											<input type='hidden' value='${file43.oldName }' name='dataAttachmentList[3].oldName'/>
											<input type='hidden' value='${file43.newName }' name='dataAttachmentList[3].newName'/>
											<input type='hidden' value='${file43.extName }' name='dataAttachmentList[3].extName'/>
											<input type='hidden' value='${file43.fileSize }' name='dataAttachmentList[3].fileSize'/>
											<input type='hidden' value='6' name='dataAttachmentList[3].category'/>
										</div>		
									</td></c:if>
								</tr>
								<tr>
									<td class="maxwidth200">其他与融资相关的重要材料</td>
									<td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
									<td class="maxwidth200"><a href="${file44.url }" title="${file44.oldName }" download="${file44.oldName }" id="file44_a">${file44.oldName }</a></td>
									<c:if test="${operType ne 'query'}"><td>
										<a href="javascript:;" class="btn-modify upload-file" id="file44" utype="44" uindex="4" uname="其他与融资相关的重要材料">上传</a>
										<c:if test="${operType ne 'insert' }"><input type='hidden' value='${file44.id }' name='dataAttachmentList[4].id'/></c:if>
										<div id="file44_div" >
											<input type='hidden' value='${file44.url }' name='dataAttachmentList[4].url'/>
											<input type='hidden' value='44' name='dataAttachmentList[4].type'/>
											<input type='hidden' value='${file44.remark }' name='dataAttachmentList[4].remark'/>
											<input type='hidden' value='${file44.oldName }' name='dataAttachmentList[4].oldName'/>
											<input type='hidden' value='${file44.newName }' name='dataAttachmentList[4].newName'/>
											<input type='hidden' value='${file44.extName }' name='dataAttachmentList[4].extName'/>
											<input type='hidden' value='${file44.fileSize }' name='dataAttachmentList[4].fileSize'/>
											<input type='hidden' value='6' name='dataAttachmentList[4].category'/>
										</div>		
									</td></c:if>
								</tr>
							</table>
					</div>
					
					<div class="bottom-line"></div>
							
						<div class="shenmin"></div>
						
                        <c:if test="${operType ne 'query' }">
			                <div class="btn3 clearfix mb80 btn-submit">
			                    <a href="javascript:;" class="btn-add" onclick="submitLoan(1)">保存草稿</a>
			                    <a href="javascript:;" class="btn-add" onclick="submitLoan(2)">保存并提交</a>
			                    <a href="javascript:history.go(-1);" class="btn-add">取消</a>
			                </div>
						</c:if>
                        <div class="btn1 clearfix mb80 mt20 submiting" style="display:none" >
                            <a class="btn-add btn-center">提交中</a>
                        </div>
                        <!-- <div class="btn3 clearfix mb80"> -->
							<a href="#" id="tab1_3" class="btn-add btn-center">下一页</a>
							<!-- <a href="#" class="btn-add" id="btn-return">返回</a> -->
					    <!-- </div> --> 
				</div>
		</div>
		</form>
		<!-- 资料清单上传form-->
	    <iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form" enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" style="display:none;" />
		</form>
		
		<!-- 附件上传form-->
	    <iframe id="common_iframe_attachment" name="common_iframe_attachment" style="display:none;"></iframe>
		<form style="display:none;" id="common_upload_form_attachment" enctype="multipart/form-data" method="post" target="common_iframe_attachment">
			<input id="common_upload_btn_attachment" type="file" name="file" style="display:none;" />
		</form>
				
        <script type="text/javascript" src="/ybl4.0/resources/js/validate-for-apply/jquery.validationEngine.js"></script>
		<script>
			// 引入不生效，直接放代码
			$.fn.watchProperty = function( name,handler ){
		 		if(!this.length) return;
				var that = this[0];
				if ( "watch" in that ) {
					// that.watch(name,handler);
					var o = that[name];
					setInterval( function() {
						var n = that[name];
						if(o !== n) {
							o = n;
							handler.call(that);
						}
					}, 300);
				} else if ( "onpropertychange" in that ) {
					name = name.toLowerCase();
					that.onpropertychange = function() {
						if(window.event.propertyName.toLowerCase() === name) {
							handler.call(that);
						}
					}
				} else {
					var o = that[name];
					setInterval( function() {
						var n = that[name];
						if(o !== n) {
							o = n;
							handler.call(that);
						}
					}, 300);
				}
			};
			// 校验插件加载
            $(document).ready(function() { 
                $("#pageForm").validationEngine("attach",{ 
                    promptPosition:"topRight", 
                    scroll:true 
                });
            })
			$(function(){
				var operType = $("#operType").val();
				if (operType == "query") {
					$("input").attr("readonly","readonly");
					$("textarea").attr("readonly","readonly");
					$("select").attr("disabled","disabled");
					$("img").attr("disabled","disabled");
					$("a").attr("disabled","disabled");
				}
			}); 
			$('#beginDate,#endDate,.selectDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			$(function(){
				var order_no = $("#order_no").val();
				$.ajax({
					url:"/loanApplyV4Controller/loanApply/getContractInfo",
					dataType:"json",
					data:{
						masterContractNo:order_no
					},
					type:"post",
					success : function(resp) {
						var obj = resp.object;
						$("#contractAmount").val(parseFloat(obj.new_credit_amount.toFixed(2)));
						$("#remainBalance").val(parseFloat(obj.all_amount.toFixed(2)));
					},
					error : function() {
						console.log("计算合同相关金额失败");/* 服务器繁忙请稍候重试 */
					}
				});
			}); 
			// 保存
			function submitLoan(status) {
                $(".btn-submit").hide();
                $(".submiting").show();
                // 校验表单
                if (!$("#pageForm").validationEngine('validate')) {
                    $(".chebox").hide();
                    $(".chebox").each(function(index){
                        if ($(this).find(".formError").length >= 1) {
                            $(this).show();
                            $("#pageForm").validationEngine("updatePromptsPosition");
                            $(".prolist").removeClass("pro_cur");
                            var prolist = $(".prolist");
                            $(prolist[index]).addClass('pro_cur');
                            alert("请完善放款申请资料");
                            $(".btn-submit").show();
                            $(".submiting").hide();
                            return false;
                        }
                    });
                    return;
                }
                $("#status").val(status);
                if (status == 2) {
                    // 手动校验部分填写
                    // 校验必上传文件
                    var file_check_41 = $("#file_check_41").val();
                    if (null == file_check_41 || file_check_41 == '') {
                       alert("购销合同文件未上传");
                       $(".btn-submit").show();
                       $(".submiting").hide();
                       return;
                    }
                    var file_check_42 = $("#file_check_42").val();
                    if (null == file_check_42 || file_check_42 == '') {
                       alert("销售发票(含清单)文件未上传");
                       $(".btn-submit").show();
                       $(".submiting").hide();
                       return;
                    }
                    
                    var remainBalance = $("#remainBalance").val();
                    var financing_amount = $("#financing_amount").val();
                    if (parseInt(remainBalance) <= 0) {
                        alert("剩余可用余额小于等于0,不能进行放款申请");
                        $(".btn-submit").show();
                        $(".submiting").hide();
                        return;
                    }
                    if (parseInt(financing_amount) > parseInt(remainBalance)) {
                        alert("融资金额不能大于剩余可用余额");
                        $(".btn-submit").show();
                        $(".submiting").hide();
                        return;
                    }
                    var assetsType = $("#assetsType").val();
                    if (assetsType == 1) {
                        // 应收账款
                        var arr = new Array();
                        $(".checkReceivable").each(function(){
                            arr.push($(this).val());
                        });
                        if (arr.length > 1) {
                            for (var i = 0; i < arr.length - 1; i++) {
                                var tempA = arr[i];
                                var tempB = arr[i+1];
                                if (tempA != tempB) {
                                    alert("底层资产的对象不一致");
                                    $(".btn-submit").show();
                                    $(".submiting").hide();
                                    return;
                                } 
                            }
                        }
                    } else if (assetsType == 2) {
                        // 应付账款
                        var arr = new Array();
                        $(".checkRepayable").each(function(){
                            arr.push($(this).val());
                        });
                        if (arr.length > 1) {
                            for (var i = 0; i < arr.length - 1; i++) {
                                var tempA = arr[i];
                                var tempB = arr[i+1];
                                if (tempA != tempB) {
                                    alert("底层资产的对象不一致");
                                    $(".btn-submit").show();
                                    $(".submiting").hide();
                                    return;
                                } 
                            }
                        }
                    } else if (assetsType == 3) {
                        //票据
                        var arr = new Array();
                        $(".checkBill").each(function(){
                            arr.push($(this).val());
                        });
                        if (arr.length > 1) {
                            for (var i = 0; i < arr.length - 1; i++) {
                                var tempA = arr[i];
                                var tempB = arr[i+1];
                                if (tempA != tempB) {
                                    alert("底层资产的对象不一致");
                                    $(".btn-submit").show();
                                    $(".submiting").hide();
                                    return;
                                } 
                            }
                        }
                    }
                }
				
				$.ajax({
					url:"/loanApplyV4Controller/loanApply/saveAll",
					data:$("form").serialize(),
					dataType:"json",
					type:"post",
					success : function(resp) {
						if (resp.responseType == 'ERROR') {
							alert(resp.info);/* 服务器繁忙请稍候重试 */
                            $(".btn-submit").show();
                            $(".submiting").hide();
						} else {
							alert(resp.info,callback);/* 数据保存/更新成功 */
						}
					},
					error : function() {
						alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
                        $(".btn-submit").show();
                        $(".submiting").hide();
					}
				});

				callback = function() {
					location.href= "/loanApplyV4Controller/loanApply/subFinancingApplyList.htm";
				};
			}
			

			$(function() {
				//加载所有核心企业
				allEnterpriseStr = "";
				$.ajax({
					url:"/financingApplyV4Controller/financingApply/selectEnterprise",
					dataType:"json",
					type:"post",
					success : function(resp) {
						if (resp.responseType == 'ERROR') {
							console.log(resp.info);/* 服务器繁忙请稍候重试 */
						} else {
							allEnterpriseStr = allEnterpriseStr + "<ul>";
							for (var i in resp.object) {
								allEnterpriseStr = allEnterpriseStr + "<li>"+resp.object[i].enterprise_name+"</li>";
							}
							allEnterpriseStr = allEnterpriseStr + "</ul>";
							$(".select-enterprise").after(allEnterpriseStr);
							selectClick();
						}
					},
					error : function() {
						console.log($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
					}
				});
			});
			
			// 应收账款增加行
			function receivableAdd(){
				var receivableTb_length = $("#receivableTb").find(".receivableTr").length;
				var receivableTb_tr = $("#receivableTb").find("tr").length;
				var td1 = $("<td>"+"<input type='text' class='tdinput' readonly name='receivableList["+(receivableTb_tr - receivableTb_length)+"].assetNumber'/>"+"</td>");
				var td2 = $("<td>"+"<div class='nice-select'><input type='text' class='tdinput select-enterprise checkReceivable validate[maxSize[20]]' oninput='searchList(this.value)' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].customerName'/>"+allEnterpriseStr+"</div>"+"</td>");
				var td3 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].orderInfo'/>"+"</td>");
				var td4 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].orderAmount'/>"+"</td>");
				var td5 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].orderUnitPrice'/>"+"</td>");
				var td6 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[10],custom[number],min[0]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].orderNumber'/>"+"</td>");
				var td7 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].amountsReceivableMoney'/>"+"</td>");
				var td8 = $("<td>"+"<input type='text' class='tdinput selectDate' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].signDate'/>"+"</td>");
				var td9 = $("<td>"+"<input type='text' class='tdinput selectDate' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].expectedPaymentDate'/>"+"</td>");
				var td10 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].invoiceInfo'/>"+"</td>");
				var td11 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='receivableList["+(receivableTb_tr - receivableTb_length)+"].remark'/>"+"</td>");
				var td12 = $("<td>"+"<a class='btn-modify' onclick='receivableDeleteRow(this,null)'>删除</a></td>");
				var tr = $("<tr class='addReceivable'></tr>");
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
				tr.append(td4);
				tr.append(td5);
				tr.append(td6);
				tr.append(td7);
				tr.append(td8);
				tr.append(td9);
				tr.append(td10);
				tr.append(td11);
				tr.append(td12);
				$("#receivableTb").append(tr);
				// 再次调用时间控件和文本框检索给新增行
				$('.selectDate').datetimepicker({
					yearOffset: 0,
					lang: 'ch',
					timepicker: false,
					format: 'Y-m-d',
					formatDate: 'Y-m-d',
					minDate: '1970-01-01', // yesterday is minimum date
					maxDate: '2099-12-31' // and tommorow is maximum date calendar
				});
				selectClick();
				// 页面整体添加增加行的高度
				$('body').height($('body').height() + 60);// 60为bottom的高度
			}
			
			// 应收账款删除行 
			function receivableDeleteRow(obj,id){
				$(obj).parent().parent().remove();
					if(id){
						var receivableId = $("#deleteReceivableIdArray").val();
						receivableId +=  id + "#";
						$("#deleteReceivableIdArray").val(receivableId);
					}
					 
					// 循环tr
					$("#receivableTb").find(".addReceivable").each(function(i,item){
						//循环td
						$(item).find("input").each(function(){
							var name=$(this).attr("name");
							var first=name.indexOf("[");
							var last =name.indexOf("]");
							name=name.replace(name.substring(first+1,last),i);
							$(this).attr("name",name);
						});
					});
					
			}
			
			// 应付账款增加行
			function repayableAdd(){
				var repayableTb_length = $("#repayableTb").find(".repayableTr").length;
				var repayableTb_tr = $("#repayableTb").find("tr").length;
				var td1 = $("<td>"+"<input type='text' class='tdinput' readonly name='repayableList["+(repayableTb_tr - repayableTb_length)+"].assetNumber'/>"+"</td>");
				var td2 = $("<td>"+"<div class='nice-select'><input type='text' class='tdinput select-enterprise checkRepayable validate[maxSize[20]]' oninput='searchList(this.value)' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].supplierName'/>"+allEnterpriseStr+"</div>"+"</td>");
				var td3 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].orderInfo'/>"+"</td>");
				var td4 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].orderAmount'/>"+"</td>");
				var td5 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].orderUnitPrice'/>"+"</td>");
				var td6 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[10],custom[number],min[0]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].orderNumber'/>"+"</td>");
				var td7 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].amountsPayableMoney'/>"+"</td>");
				var td8 = $("<td>"+"<input type='text' class='tdinput selectDate' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].signDate'/>"+"</td>");
				var td9 = $("<td>"+"<input type='text' class='tdinput selectDate' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].expectedPaymentDate'/>"+"</td>");
				var td10 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].invoiceInfo'/>"+"</td>");
				var td11 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='repayableList["+(repayableTb_tr - repayableTb_length)+"].remark'/>"+"</td>");
				var td12 = $("<td>"+"<a class='btn-modify' onclick='repayableDeleteRow(this,null)'>删除</a></td>");
				var tr = $("<tr class='addRepayable'></tr>");
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
				tr.append(td4);
				tr.append(td5);
				tr.append(td6);
				tr.append(td7);
				tr.append(td8);
				tr.append(td9);
				tr.append(td10);
				tr.append(td11);
				tr.append(td12);
				$("#repayableTb").append(tr);
				// 再次调用时间控件和文本框检索给新增行
				$('.selectDate').datetimepicker({
					yearOffset: 0,
					lang: 'ch',
					timepicker: false,
					format: 'Y-m-d',
					formatDate: 'Y-m-d',
					minDate: '1970-01-01', // yesterday is minimum date
					maxDate: '2099-12-31' // and tommorow is maximum date calendar
				});
				selectClick();
				// 页面整体添加增加行的高度
				$('body').height($('body').height() + 60);// 60为bottom的高度
			}
			
			// 应收账款删除行
			function repayableDeleteRow(obj,id){
				$(obj).parent().parent().remove();
				if(id){
					var repayableId = $("#deleteRepayableIdArray").val();
					repayableId +=  id + "#";
					$("#deleteRepayableIdArray").val(repayableId);
				}
				 
				// 循环tr
				$("#repayableTb").find(".addRepayable").each(function(i,item){
					//循环td
					$(item).find("input").each(function(){
						var name=$(this).attr("name");
						var first=name.indexOf("[");
						var last =name.indexOf("]");
						name=name.replace(name.substring(first+1,last),i);
						$(this).attr("name",name);
					});
				});
				
			}
			
			// 票据增加行
			function billAdd(){
				var billTb_length = $("#billTb").find(".billTr").length;
				var billTb_tr = $("#billTb").find("tr").length;
				var td1 = $("<td>"+"<input type='text' class='tdinput' readonly name='billList["+(billTb_tr - billTb_length)+"].assetNumber'/>"+"</td>");
				var td2 = $("<td>"+"<div class='nice-select'><input type='text' class='tdinput select-enterprise checkBill validate[maxSize[20]]' oninput='searchList(this.value)' name='billList["+(billTb_tr - billTb_length)+"].acceptorName'/>"+allEnterpriseStr+"</div>"+"</td>");
				var td3 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20]]' name='billList["+(billTb_tr - billTb_length)+"].billNo'/>"+"</td>");
				var td4 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='billList["+(billTb_tr - billTb_length)+"].orderInfo'/>"+"</td>");
				var td5 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='billList["+(billTb_tr - billTb_length)+"].orderAmount'/>"+"</td>");
				var td6 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='billList["+(billTb_tr - billTb_length)+"].orderUnitPrice'/>"+"</td>");
				var td7 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[10],custom[number],min[0]]' name='billList["+(billTb_tr - billTb_length)+"].orderNumber'/>"+"</td>");
				var td8 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[20],custom[number],min[0]]' name='billList["+(billTb_tr - billTb_length)+"].billAmount'/>"+"</td>");
				var td9 = $("<td>"+"<input type='text' class='tdinput selectDate' name='billList["+(billTb_tr - billTb_length)+"].billingDate'/>"+"</td>");
				var td10 = $("<td>"+"<input type='text' class='tdinput selectDate' name='billList["+(billTb_tr - billTb_length)+"].expireDate'/>"+"</td>");
				var td11 = $("<td>"+"<input type='text' class='tdinput selectDate' name='billList["+(billTb_tr - billTb_length)+"].signDate'/>"+"</td>");
				var td12 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='billList["+(billTb_tr - billTb_length)+"].invoiceInfo'/>"+"</td>");
				var td13 = $("<td>"+"<input type='text' class='tdinput validate[maxSize[120]]' name='billList["+(billTb_tr - billTb_length)+"].remark'/>"+"</td>");
				var td14 = $("<td>"+"<a class='btn-modify' onclick='billDeleteRow(this,null)'>删除</a></td>");
				var tr = $("<tr class='addBill'></tr>");
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
				tr.append(td4);
				tr.append(td5);
				tr.append(td6);
				tr.append(td7);
				tr.append(td8);
				tr.append(td9);
				tr.append(td10);
				tr.append(td11);
				tr.append(td12);
				tr.append(td13);
				tr.append(td14);
				$("#billTb").append(tr);
				// 再次调用时间控件和文本框检索给新增行
				$('.selectDate').datetimepicker({
					yearOffset: 0,
					lang: 'ch',
					timepicker: false,
					format: 'Y-m-d',
					formatDate: 'Y-m-d',
					minDate: '1970-01-01', // yesterday is minimum date
					maxDate: '2099-12-31' // and tommorow is maximum date calendar
				});
				selectClick();
				// 页面整体添加增加行的高度
				$('body').height($('body').height() + 60);// 60为bottom的高度
			}
			
			// 票据删除行 
			function billDeleteRow(obj,id){
				$(obj).parent().parent().remove();
				if(id){
					var billId = $("#deleteBillIdArray").val();
					billId +=  id + "#";
					$("#deleteBillIdArray").val(billId);
				}
				 
				// 循环tr
				$("#billTb").find(".addBill").each(function(i,item){
					//循环td
					$(item).find("input").each(function(){
						var name=$(this).attr("name");
						var first=name.indexOf("[");
						var last =name.indexOf("]");
						name=name.replace(name.substring(first+1,last),i);
						$(this).attr("name",name);
					});
				});
				
			}
			
			/**
			 * 图片上传statrt
			 */
			// 监听图片上传按钮
			$("#common_upload_btn").watchProperty("value",function() {
				var v = $(this).val();
				if (v == '' || v == null)
					return;
				// 上传
				$("#common_upload_form").attr("action","/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadCallback");
				$("#common_upload_form").submit();
				$(this).val('');
			});
			
			// 点击图片上传图片 
			$(".upload-file").click(function() {
				id = $(this).attr("id");
				utype = $(this).attr("utype");
				uname = $(this).attr("uname");
				uindex = $(this).attr("uindex");
				$("#common_upload_btn").click();
			});
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var uid = $("#" + id).attr("uid");
				var num = 0;
				var num = document.getElementsByClassName("file_index").length;
				$("#" + id +"_a").html(attachment.old_name);//只允许一行一个附件
				$("#" + id +"_a").attr('href',attachment.url_);//供下载
				$("#" + id +"_a").attr('download',attachment.old_name);//供下载
				$("#" + id +"_a").attr('title',attachment.old_name);//展示文件名
				var htmlArray = [];
				htmlArray.push("<input type='hidden' value='" + attachment.url_ + "' name='dataAttachmentList[" + uindex + "].url'/>");
				htmlArray.push("<input type='hidden' value='" + utype+ "'  id='file_check_"+utype+"' name='dataAttachmentList[" + uindex + "].type'/>");
				htmlArray.push("<input type='hidden' value='" + uname+ "' name='dataAttachmentList[" + uindex + "].remark'/>");
				htmlArray.push("<input type='hidden' value='" + attachment.old_name + "' name='dataAttachmentList[" + uindex + "].oldName'/>");
				htmlArray.push("<input type='hidden' value='" + attachment.new_name + "' name='dataAttachmentList[" + uindex + "].newName'/>");
				htmlArray.push("<input type='hidden' value='" + attachment.ext_name + "' name='dataAttachmentList[" + uindex + "].extName'/>");
				htmlArray.push("<input type='hidden' value='" + attachment.file_size + "' name='dataAttachmentList[" + uindex + "].fileSize'/>");
				htmlArray.push("<input type='hidden' value='6' name='dataAttachmentList[" + uindex + "].category'/>");
				$("#" + id + "_div").empty().html(htmlArray.join(""));//只允许一行一个附件
			}
			window.close = function(item) {
				var clo = window.parent.document.getElementsByClassName(item);
				$(clo).click(function() {
					dialog.close();
				});
			}
			
			// 选择资产
			$("#selectAssets").click(function(){
				var assetsType = $("#assetsType").val();
				var financingApplyId = $("#financingApplyId").val();
				if (assetsType == 1) {
					// 应收账款
					var arr = new Array();
					$(".chkReceivableTr").each(function(){
						arr.push($(this).attr("uid"));
					});
					var selectIds = arr.join(",");
					dialog.open('/loanApplyV4Controller/loanApply/selectReceivable.htm?financingApplyId='+financingApplyId+'&selectIds='+selectIds,'1200px','700px','assetMsg','选择资产');
					close('outClose');
				} else if (assetsType == 2) {
					// 应付账款
					var arr = new Array();
					$(".chkRepayableTr").each(function(){
						arr.push($(this).attr("uid"));
					});
					var selectIds = arr.join(",");
					dialog.open('/loanApplyV4Controller/loanApply/selectPayable.htm?financingApplyId='+financingApplyId+'&selectIds='+selectIds,'1200px','700px','assetMsg','选择资产');
					close('outClose');
				} else if (assetsType == 3) {
					//票据
					var arr = new Array();
					$(".chkBillTr").each(function(){
						arr.push($(this).attr("uid"));
					});
					var selectIds = arr.join(",");
					dialog.open('/loanApplyV4Controller/loanApply/selectBill.htm?financingApplyId='+financingApplyId+'&selectIds='+selectIds,'1200px','700px','assetMsg','选择资产');
					close('outClose');
				}
			});
			
			function selectClick(){
				$(".nice-select").click(function(e){
					$(this).find("ul").show();
					e.stopPropagation();
				});
				
				$(".nice-select ul li").hover(function(e){
					$(this).toggleClass("on");
					e.stopPropagation();
				});
				
				$(".nice-select ul li").click(function(e){
					var val = $(this).text();
					$(this).parents('.nice-select').find("input").val(val);
					$(".nice-select").find("ul").hide();
					e.stopPropagation();
				});
				
				$(document).click(function(){
					$(".nice-select").find("ul").hide();
				});
			}
			
			function searchList(strValue) {
				var count = 0;
				if (strValue != "") {
					$(".nice-select ul li").each(function(i) {
						var contentValue = $(this).text();
						if (contentValue.toLowerCase().indexOf(strValue.toLowerCase()) < 0) {
							$(this).hide();
							count++;
						} else {
							$(this).show();
						}
						if (count == (i + 1)) {
							$(".nice-select").find("ul").hide();
						} else {
							$(".nice-select").find("ul").show();
						}
					});
				} else {
					$(".nice-select ul li").each(function(i) {
						$(this).show();
					});
				}
			}
			
			// 根据资产类型默认隐藏表单
			var val = $("#assetsType").find('option:selected').attr('value');
			if (val == 1) {
				$(".togglebox1").show();
				$(".togglebox2").hide();
				$(".togglebox3").hide();
			} else if (val == 2) {
				$(".togglebox1").hide();
				$(".togglebox2").show();
				$(".togglebox3").hide();
			} else if (val == 3) {
				$(".togglebox1").hide();
				$(".togglebox2").hide();
				$(".togglebox3").show();
			}
			
			
			/**
			 * 图片上传statrt
			 */
			// 监听图片上传按钮
			$("#common_upload_btn_attachment").watchProperty("value",function() {
				var v = $(this).val();
				if (v == '' || v == null)
					return;
				// 上传
				$("#common_upload_form_attachment").attr("action","/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadAttachmentCallback");
				$("#common_upload_form_attachment").submit();
				$(this).val('');
			});
			
			// 点击图片上传图片 
			$(".uploadimg").click(function() {
				id = $(this).attr("id");
				utype = $(this).attr("utype");
				uname = $(this).attr("uname");
				uindex = $(this).attr("uindex");
				$("#common_upload_btn_attachment").click();
			});
			// 回调，回显图片
			var num = document.getElementsByClassName("delimg").length;
			uploadAttachmentCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn_attachment").val('');
				var htmlStr = "";
				if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
					htmlStr += '<div class="wenjian"><img class="delimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/del_icon.png" /><img width="130" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png" />';
                } else {
                	htmlStr += '<div class="wenjian"><img class="delimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/del_icon.png" /><img width="130" height="105" src="' + attachment.url_ + '" />';
                }
				
				htmlStr += '<input type="hidden" name="assetList['+num+'].url" value='+attachment.url_+'>';
				htmlStr += '<input type="hidden" name="assetList['+num+'].type" value="61">';
				htmlStr += '<input type="hidden" name="assetList['+num+'].oldName" value="'+attachment.old_name+'">';
				htmlStr += '<input type="hidden" name="assetList['+num+'].newName" value="'+attachment.new_name+'">';
				htmlStr += '<input type="hidden" name="assetList['+num+'].extName" value="'+attachment.ext_name+'">';
				htmlStr += '<input type="hidden" name="assetList['+num+'].fileSize" value="'+attachment.file_size+'">';
				htmlStr += '<input type="hidden" name="assetList['+num+'].category" value="6">';
				htmlStr += '<p><a class="filemaxwidth" href="'+attachment.url_+'" title="'+attachment.old_name+'" download="'+attachment.old_name+'">'+attachment.old_name+'</a></p>';
				htmlStr += '</div>';
				$(".uploadimg").before(htmlStr);
				num++;
				fileDeleteClick();
			}
			
			function fileDeleteClick() {
				$(document).on('click','.delimg',function(){
					var id = $(this).attr("uid");
					if (id) {
						var fileId = $("#deleteFileIdArray").val();
						fileId +=  id + "#";
						$("#deleteFileIdArray").val(fileId);
					}
					$(this).parent().remove();
				})

			}
			fileDeleteClick();
		</script>
	</body>

</html>