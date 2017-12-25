<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
		<script type="text/javascript">
		function jumpPost(url,args) {
			var form = $("<form method='post'></form>");
	        form.attr({"action":url});
	        for (arg in args) {
	            var input = $("<input type='hidden'>");
	            input.attr({"name":arg});
	            input.val(args[arg]);
	            form.append(input);
	        }
	        $(document.body).append(form);
	        form.submit();
	    }
		</script>
	</head>
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资申请--详情展示<span class="mr10 ml10"></span></div>
		</div>
		
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">融资需求列表</li>
				<li class="formli">资料清单</li>
				<c:if test="${not empty supplementAttachments}">
					<li class="formli">补充资料</li>
				</c:if>
			</ul>
		</div>
		
		<div class="w1200 ybl-info box box1">
		
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>融资订单号：</label><input class="content-form" value="${financing.financingOrderNumber }"/></div>
				<div class="form-grou"><label>申请单位：</label><input class="content-form2" value="${financing.enterpriseName }"/></div>
				<c:if test="${financing.financingMode eq 3}">
					<div class="form-grou"><label class="label-long">竞标截止时间：</label><input class="content-form2" value="<fmt:formatDate value="${financing.bidExpireDate }" pattern="yyyy-MM-dd" />" /></div>
				</c:if>
			</div>
			
			<div class="ground-form mb20">
				<div class="form-grou mr40"><label>融资方式：</label>
				<select class="content-form">
							<option value="1" <c:if test="${financing.financingMode eq 1}">selected="selected"</c:if>>签约资方</option>
							<option value="1" <c:if test="${financing.financingMode eq 2}">selected="selected"</c:if>>平台推荐</option>
							<option value="1" <c:if test="${financing.financingMode eq 3}">selected="selected"</c:if>>竞标</option>
				</select></div>
				<div class="form-grou"><label>资方名称：</label><input class="content-form2" value="${financing.investorName }"/><img src="images/mbl_search_icon.png" class="timeimg" /></div><a class="ml10 mr40" href="javascript:;"><img src="images/mbl_add_icon.png" /></a>
			</div>
			
			<div class="bottom-line"></div>
		
				<div class="process">
					<img src="images/proLine_img.png" />
					<ul class="clearfix proul clearfix">
						<li class="prolist pro_cur">申请人基本情况<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
						<li class="prolist">申请人财务情况<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
						<li class="prolist">申请人征信情况<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
						<li class="prolist">融资需求<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
						<li class="prolist">底层资产<img class="pro-img-1" src="${app.staticResourceUrl}/ybl4.0/resources/images/proPoint_icon.png" /><img class="pro-img-2" src="${app.staticResourceUrl}/ybl4.0/resources/images/line_img_choose.png" /></li>
					</ul>
					<div class="chebox chebox1">
						<p class="protitle"><span>申请人信息</span></p>
						
						<div class="grounpinfo">
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>企业全称：</label><input class="content-form2" value="${businessAuth.enterpriseName }"/></div>
								<div class="form-grou mr50"><label>所属行业：</label><input class="content-form2" value="${businessAuth.industry }"/></div>
								<div class="form-grou"><label>注册地址：</label><input class="content-form2" value="${businessAuth.registerAddress }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>注册日期：</label><input class="content-form2" value="<fmt:formatDate value="${businessAuth.registerDate }" pattern="yyyy-MM-dd" />"/></div>
								<div class="form-grou mr50"><label>注册资本：</label><input class="content-form2" value="<fmt:formatNumber value="${businessAuth.registerCapital }" pattern="0.00"/>"/><span class="timeimg">元</span></div>
								<div class="form-grou"><label>实缴资本：</label><input class="content-form2" value="<fmt:formatNumber value="${businessAuth.paidCapital }" pattern="0.00"/>"/><span class="timeimg">元</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公地址：</label><input class="content-form2" value="${businessAuth.officeAddress }"/></div>
								<div class="form-grou mr50"><label class="w140">统一社会信用代码：</label><input class="content-form2" value="${businessAuth.socialCreditCode }"/></div>
								<div class="form-grou"><label>年检情况：</label><input class="content-form2" value="${businessAuth.annualSurveySituation }"/></div>
							</div>
							<div class="ground-form">
								<div class="form-grou mr50"><label>联系人：</label><input class="content-form2" value="${businessAuth.contacts }"/></div>
								<div class="form-grou mr50"><label>电话：</label><input class="content-form2" value="${businessAuth.contactsPhone }"/></div>
								<div class="form-grou"><label>邮箱：</label><input class="content-form2" value="${businessAuth.contactsEmail }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>实际控制人信息</span></p>
						
						<div class="grounpinfo">
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>姓名：</label><input class="content-form2" value="${businessAuth.controllerName }"/></div>
								<div class="form-grou mr50"><label>性别：</label>
									<c:if test="${empty businessAuth.controllerGender}"><input class="content-form2" value="未知"/></c:if>
									<c:if test="${businessAuth.controllerGender eq 1}"><input class="content-form2" value="男"/></c:if>
									<c:if test="${businessAuth.controllerGender eq 2}"><input class="content-form2" value="女"/></c:if>
								</div>
								<div class="form-grou"><label>国籍：</label><input class="content-form2" value="${businessAuth.controllerNationality }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" value="${businessAuth.controllerCardId }"/></div>
								<div class="form-grou mr50"><label>年龄：</label><input class="content-form2" value="${businessAuth.controllerAge }"/><span class="timeimg">岁</span></div>
								<div class="form-grou"><label>从业年限：</label><input class="content-form2" value="${businessAuth.controllerWorkYear }"/><span class="timeimg">年</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公电话：</label><input class="content-form2" value="${businessAuth.controllerOfficePhone }"/></div>
								<div class="form-grou mr50"><label class="w140">婚姻状况：</label><input class="content-form2" value="${businessAuth.controllerMaritalStatus }"/></div>
								<div class="form-grou"><label>家庭住址：</label><input class="content-form2" value="${businessAuth.controllerHomeAddress }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>法定代表人信息</span></p>
						
						<div class="grounpinfo">
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>姓名：</label><input class="content-form2" value="${businessAuth.legalName }"/></div>
								<div class="form-grou mr50"><label>性别：</label>
									<c:if test="${empty businessAuth.legalGender}"><input class="content-form2" value="未知"/></c:if>
									<c:if test="${businessAuth.legalGender eq 1}"><input class="content-form2" value="男"/></c:if>
									<c:if test="${businessAuth.legalGender eq 2}"><input class="content-form2" value="女"/></c:if>
								</div>
								<div class="form-grou"><label>国籍：</label><input class="content-form2" value="${businessAuth.legalNationality }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" value="${businessAuth.legalCardId }"/></div>
								<div class="form-grou mr50"><label>年龄：</label><input class="content-form2" value="${businessAuth.legalAge }"/><span class="timeimg">岁</span></div>
								<div class="form-grou"><label>从业年限：</label><input class="content-form2" value="${businessAuth.legalWorkYear }"/><span class="timeimg">年</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公电话：</label><input class="content-form2" value="${businessAuth.legalOfficePhone }"/></div>
								<div class="form-grou mr50"><label class="w140">婚姻状况：</label><input class="content-form2" value="${businessAuth.legalMaritalStatus }"/></div>
								<div class="form-grou"><label>家庭住址：</label><input class="content-form2" value="${businessAuth.legalHomeAddress }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>经营范围</span></p>
						<div class="pd20">
							企业经营范围：<textarea class="protext">${businessAuth.businessScope }</textarea>
						</div>
						
						<p class="protitle"><span>股东情况</span></p>
						<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>股东名称</th>
										<th>出资比例(%)</th>
										<th>注资方式</th>
										<th>法人代表</th>
										<th>注册资本(元)</th>
										<th>实收资本(元)</th>
										<th>注册日期</th>
									</tr>
									<c:forEach items="${stockHolderList}" var="obj" varStatus="index">
										<tr>
											<td><input class="tdinput" type="text" value="${obj.name }"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.investmentRatio*100}" pattern="0.00"/>"/></td>
											<td><input class="tdinput" type="text" value="${obj.investmentMode }"/></td>
											<td><input class="tdinput" type="text" value="${obj.legalName }"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.receivedAmount}" pattern="0.00"/>"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.receivedAmount}" pattern="0.00"/>"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.registerDate }" pattern="yyyy-MM-dd" />"/></td>
										</tr>
									</c:forEach>
								</table>
						</div>
					</div>
						
						
					<p class="protitle"><span>历史沿革</span></p>
					<div class="pd20">
						历史沿革：<textarea class="protext">${businessAuth.history }</textarea>
					</div>	
				</div>
				
				<div class="chebox chebox2">
					<p class="protitle"><span>主要财务数据</span></p>
						<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>类别</th>
										<th>n~2年</th>
										<th>n~1年</th>
										<th>最新一期</th>
									</tr>
									<tr>
										<td>总资产(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>总负债(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>所有者权益(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>营业收入(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>营业成本(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessCostN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessCostN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessCostNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>营业利润(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>利润总额(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>净利润(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.netProfitN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.netProfitN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.netProfitNewest}" pattern="0.00"/>"/></td>
									</tr>
									<tr>
										<td>经营活动现金流(元)</td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowN2}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowN1}" pattern="0.00"/>"/></td>
										<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowNewest}" pattern="0.00"/>"/></td>
									</tr>
								</table>
						</div>
					</div>
				</div>	
				
				<div class="chebox chebox3">
					<p class="protitle"><span>企业借款情况</span></p>
					<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>借款金额(元)</th>
										<th>期限(天)</th>
										<th>债权人</th>
										<th>借款日期</th>
										<th>到期日期</th>
										<th>余额(元)</th>
										<th>备注</th>
									</tr>
									<c:forEach items="${loanDebtSituationList}" var="obj" varStatus="index">
										<%-- 类型1-企业借款 2-个人负债 --%>
										<c:if test="${obj.type == 1 }">
											<tr>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.loanAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.term }"/></td>
												<td><input class="tdinput" type="text" value="${obj.creditor }"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.loanDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>个人负债情况</span></p>
					<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>借款金额(元)</th>
										<th>期限(天)</th>
										<th>债权人</th>
										<th>借款日期</th>
										<th>到期日期</th>
										<th>余额(元)</th>
										<th>备注</th>
									</tr>
									<c:forEach items="${loanDebtSituationList}" var="obj" varStatus="index">
										<%-- 类型1-企业借款 2-个人负债 --%>
										<c:if test="${obj.type == 2 }">
											<tr>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.loanAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.term }"/></td>
												<td><input class="tdinput" type="text" value="${obj.creditor }"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.loanDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>对外担保情况</span></p>
					<div class="pd20">
							<div class="tabD">
								<table>
									<tr>
										<th>担保金额(元)</th>
										<th>期限(天)</th>
										<th>被担保单位</th>
										<th>担保方式</th>
										<th>到期日期</th>
										<th>余额(元)</th>
										<th>备注</th>
									</tr>
									<c:forEach items="${externalGuaranteeSituationList}" var="obj" varStatus="index">
										<tr>
											<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.guaranteeAmount}" pattern="0.00"/>"/></td>
											<td><input class="tdinput" type="text" value="${obj.term }"/></td>
											<td><input class="tdinput" type="text" value="${obj.guarantor }"/></td>
											<td><input class="tdinput" type="text" value="${obj.guaranteeMode }"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
											<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="0.00"/>"/></td>
											<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
										</tr>
									</c:forEach>
								</table>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>未决诉讼或仲裁</span></p>
					<div class="pd20">
						<textarea class="protext btn-center">${financing.lawSituation }</textarea>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>其他或有事项</span></p>
					<div class="pd20">
						<textarea class="protext btn-center">${financing.other }</textarea>
					</div>
					
				</div>
				
				<div class="chebox chebox4">
					<p class="protitle"><span>融资需求</span></p>
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>融资人：</label><input class="content-form" value="${financing.financier }"/></div>
							<div class="form-grou mr50"><label>融资金额：</label><input class="content-form" value="<fmt:formatNumber value="${financing.financingAmount}" pattern="##0.00" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
						</div>
						<div class="ground-form">
							<div class="form-grou mr50"><label>融资期限：</label><input class="content-form" value="${financing.financingTerm }"/><span class="timeimg">天</span></div>
							<div class="form-grou mr50"><label>融资利率：</label><input class="content-form" value="<fmt:formatNumber value="${financing.financingRate}" pattern="##0.0000" maxFractionDigits="4"/>"/><span class="timeimg">%</span></div>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>增信措施</span></p>
					<div class="pd20">
						<textarea class="protext btn-center">${financing.trustMeasure }</textarea>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">
						<textarea class="protext btn-center">${financing.remark }</textarea>
					</div>
					
				</div>
				
				<div class="chebox chebox5">
					<p class="protitle"><span>选择资产类型</span></p>
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>资产类型：</label>
							<select class="content-form" disabled="disabled">
								<option value="1" <c:if test="${financing.assetsType eq 1}">selected="selected"</c:if>>应收账款</option>
								<option value="2" <c:if test="${financing.assetsType eq 2}">selected="selected"</c:if>>应付账款</option>
								<option value="3" <c:if test="${financing.assetsType eq 3}">selected="selected"</c:if>>票据</option>
							</select></div>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					<c:if test="${financing.assetsType eq 1}">
						<p class="protitle"><span>应收账款信息</span></p>
						<div class="pd20">
								<div class="tabD">
									<div class="scrollbox">
									<table>
										<tr>
											<th>客户名称</th>
											<th>合同/订单信息</th>
											<th>合同/订单金额(元)</th>
											<th>合同/订单单价(元)</th>
											<th>合同/订单数量</th>
											<th>应收账款金额(元)</th>
											<th>签署日期</th>
											<th>预支付日期</th>
											<th>发票信息</th>
											<th>是否使用</th>
											<th>备注</th>
										</tr>
										<c:forEach items="${accountsReceivableList}" var="obj" varStatus="index">
											<tr>
												<td><input class="tdinput" type="text" value="${obj.customerName}"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.orderAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.amountsReceivableMoney}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse == 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse == 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse == 3 }">
														占用
													</c:if>
												</td>
												<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
					<c:if test="${financing.assetsType eq 2}">
						<p class="protitle"><span>应付账款信息</span></p>
						<div class="pd20">
								<div class="tabD">
									<div class="scrollbox">
									<table>
										<tr>
											<th>供应商名称</th>
											<th>合同/订单信息</th>
											<th>合同/订单金额(元)</th>
											<th>合同/订单单价(元)</th>
											<th>合同/订单数量</th>
											<th>应付账款金额(元)</th>
											<th>签署日期</th>
											<th>预支付日期</th>
											<th>发票信息</th>
											<th>是否使用</th>
											<th>备注</th>
										</tr>
										<c:forEach items="${accountsPayableList}" var="obj" varStatus="index">
											<tr>
												<td><input class="tdinput" type="text" value="${obj.supplierName}"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.orderAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.amountsPayableMoney}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse == 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse == 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse == 3 }">
														占用
													</c:if>
												</td>
												<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
					<c:if test="${financing.assetsType eq 3}">
						<p class="protitle"><span>票据信息</span></p>
						<div class="pd20">
								<div class="tabD">
									<div class="scrollbox">
									<table>
										<tr>
											<th>承兑人名称</th>
											<th>票据号码</th>
											<th>合同/订单信息</th>
											<th>合同/订单金额(元)</th>
											<th>合同/订单单价(元)</th>
											<th>合同/订单数量</th>
											<th>票据金额(元)</th>
											<th>出票日期</th>
											<th>签署日期</th>
											<th>到期日期</th>
											<th>发票信息</th>
											<th>是否使用</th>
											<th>备注</th>
										</tr>
										<c:forEach items="${billList}" var="obj" varStatus="index">
											<tr>
												<td><input class="tdinput" type="text" value="${obj.acceptorName}"/></td>
												<td><input class="tdinput" type="text" value="${obj.billNo}"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.billAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatNumber value="${obj.billAmount}" pattern="0.00"/>"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.billingDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse == 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse == 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse == 3 }">
														占用
													</c:if>
												</td>
												<td><input class="tdinput" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			
		</div>
		
		<div class="w1200 ybl-info box box2">
			<div class="pd20">
						<div class="tabD">
							<table>
								<tr>
									<th>序号</th>
									<th>资料名称</th>
									<th>上传说明</th>
									<th>附件</th>
									<th>操作</th>
								</tr>
								<c:forEach items="${attachments}" var="obj" varStatus="index">
									<%-- <c:if test="${obj.type_ eq '12' }"> --%>
										<tr>
											<td>${index.count}</td>
											<td>${obj.remark }</td>
											<td>原件、复印件、加盖公章、提供扫描件</td>
											<td><a href="javascript:;">${obj.oldName }</a></td>
											<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
										</tr>
									<%-- </c:if> --%>
								</c:forEach>
							</table>
					</div>
					
					<div class="bottom-line"></div>
							
							<div class="shenmin"></div>
				</div>
		</div>
		<div class="w1200 ybl-info box box3">
			<div class="pd20">
						<div class="tabD">
							<table>
								<tr>
									<th>序号</th>
									<th>资料名称</th>
									<th>上传说明</th>
									<th>附件</th>
									<th>操作</th>
								</tr>
								<c:forEach items="${supplementAttachments}" var="obj" varStatus="index">
									<tr>
										<td>${index.count}</td>
										<td>${obj.oldName }</td>
										<td>原件、复印件、加盖公章、提供扫描件</td>
										<td>${obj.new_name }</td>
										<td><a href="/fileDownloadController/downloadftp?id=${obj.id }" class="btn-supplement">下载</a></td>
									</tr>
								</c:forEach>
							</table>
					</div>
					
					<div class="bottom-line"></div>
							
							<div class="shenmin"></div>
				</div>
		</div>
	</body>
</html>