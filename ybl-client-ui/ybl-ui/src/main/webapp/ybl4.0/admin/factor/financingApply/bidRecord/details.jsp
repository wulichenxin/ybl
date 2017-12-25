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
		<style>
		*{margin: 0;padding: 0;}
		.timedown div{
		    color: #333;
		    text-align: center;
		    margin-right: 6px;
		    display: inline-block;
		}
	</style>
	</head>
	<jsp:include page="/ybl4.0/admin/common/top.jsp" />	
	<body>
		<script type="text/javascript" src="/ybl4.0/resources/js/countdown/Countdown.js"></script>
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.css">
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.css">
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/dialog.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/messagebox/messagebox.js"></script>
		<!--top end -->
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />竞标管理产品列表</div>
		</div>
		<div class="w1200 mt40">
			<form action="/financingApplyController//bidRecord/list.htm" id="pageForm" method="post"></form>
			<div class="w1200 clearfix border-b">
				<div class="clearfix mt30 mb80">
					<p class="listname"><span class="mr30">融资订单号</span><span class="mr30">${financing.financingOrderNumber}</span></p>
					<div class="fl clearfix">
						<div class="fl jbbox">
							<img src="${app.staticResourceUrl}/ybl4.0/resources/images/jingbiao_icon.png" />
							<p>已竞标</p>
							<p>
							<span>
								<c:if test="${obj.count eq 0 }">0</c:if>
								<c:if test="${obj.count ne 0 }">${financing.count}</c:if>	
							</span>家
							</p>
						</div>
						<div class="fl">
							<div class="morecont clearfix">
								<div class="xm_d">
									<p>融资利率</p>
									<p class="color-yellow"><fmt:formatNumber value="${financing.financingRate}" pattern="0.####"/>%</p>
								</div>
								<div class="xm_d">
									<p>融资金额(元)</p>
									<p><fmt:formatNumber value="${financing.financingAmount}" pattern="#,##0.##"/></p>
								</div>
								<div class="xm_d">
									<p>融资期限(天)</p>
									<p>
										${financing.financingTerm }	
									</p>
								</div>
							</div>
							<div class="clearfix contP">
								<p class="fl">距离竞标截止时间：<span style="display: none" id="clock" bigExpireDate="<fmt:formatDate value="${financing.bigExpireDate }" pattern="yyyy-MM-dd" />"><fmt:formatDate value="${financing.bidExpireDate }" pattern="yyyy-MM-dd" /></span></p>
									<div class="timedown clearfix fl">
										<div id="oDays" style="">
											<div class="day">--</div><div>天</div>
										</div>
										<div class="hours">--</div>
										<div>时</div>
										<div class="minutes">--</div>
										<div>分</div>
										<div class="seconds">--</div>
										<div>秒</div>
									</div>
								
								<p class="fr">项目来源：${financing.enterpriseName }</p>
							</div>
						</div>
					</div>
					<div class="fr contright">
						<div class="btn-center">
							<button href="javascript:;" class="xm_btn join-btn" id="a-join" style="background-color: gray;" numcount = "${financing.count }" appId = "${financing.id }" orderNo="${financing.financingOrderNumber }">我要参与</button>
						</div>
					</div>
				</div>
				<div class="process">
					<img src="${app.staticResourceUrl}/ybl4.0/resources/images/proLine_img.png" />
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
								<div class="form-grou mr50"><label>企业全称：</label><input class="content-form2" readonly="readonly" value="${businessAuth.enterpriseName }"/></div>
								<div class="form-grou mr50"><label>所属行业：</label><input class="content-form2" readonly="readonly" value="${businessAuth.industry }"/></div>
								<div class="form-grou"><label>注册地址：</label><input class="content-form2" readonly="readonly" value="${businessAuth.registerAddress }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>注册日期：</label><input class="content-form2" readonly="readonly" value="<fmt:formatDate value="${businessAuth.registerDate }" pattern="yyyy-MM-dd" />"/></div>
								<div class="form-grou mr50"><label>注册资本：</label><input class="content-form2" readonly="readonly" value="<fmt:formatNumber value="${businessAuth.registerCapital }" pattern="#,##0.##"/>"/><span class="timeimg">元</span></div>
								<div class="form-grou"><label>实缴资本：</label><input class="content-form2" readonly="readonly" value="<fmt:formatNumber value="${businessAuth.paidCapital }" pattern="#,##0.##"/>"/><span class="timeimg">元</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公地址：</label><input class="content-form2" readonly="readonly" value="${businessAuth.officeAddress }"/></div>
								<div class="form-grou mr50"><label class="w140">统一社会信用代码：</label><input class="content-form2" readonly="readonly" value="${businessAuth.socialCreditCode }"/></div>
								<div class="form-grou"><label>年检情况：</label><input class="content-form2" readonly="readonly" value="${businessAuth.annualSurveySituation }"/></div>
							</div>
							<div class="ground-form">
								<div class="form-grou mr50"><label>联系人：</label><input class="content-form2" readonly="readonly" value="${businessAuth.contacts }"/></div>
								<div class="form-grou mr50"><label>电话：</label><input class="content-form2" readonly="readonly" value="${businessAuth.contactsPhone }"/></div>
								<div class="form-grou"><label>邮箱：</label><input class="content-form2" readonly="readonly" value="${businessAuth.contactsEmail }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>实际控制人信息</span></p>
						
						<div class="grounpinfo">
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>姓名：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerName }"/></div>
								<div class="form-grou mr50"><label>性别：</label>
								<input class="content-form2" readonly="readonly" value="<c:if test='${businessAuth.controllerGender==1 }'>男</c:if><c:if test='${businessAuth.controllerGender==2 }'>女</c:if>"/></div>
								<div class="form-grou"><label>国籍：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerNationality }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerCardId }"/></div>
								<div class="form-grou mr50"><label>年龄：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerAge }"/><span class="timeimg">岁</span></div>
								<div class="form-grou"><label>从业年限：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerWorkYear }"/><span class="timeimg">年</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公电话：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerOfficePhone }"/></div>
								<div class="form-grou mr50"><label class="w140">婚姻状况：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerMaritalStatus }"/></div>
								<div class="form-grou"><label>家庭住址：</label><input class="content-form2" readonly="readonly" value="${businessAuth.controllerHomeAddress }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>法定代表人信息</span></p>
						
						<div class="grounpinfo">
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>姓名：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalName }"/></div>
								<div class="form-grou mr50"><label>性别：</label>
								<input class="content-form2" readonly="readonly" value="<c:if test='${businessAuth.legalGender==1 }'>男</c:if><c:if test='${businessAuth.legalGender==2 }'>女</c:if>"/></div>
								<div class="form-grou"><label>国籍：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalNationality }"/></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalCardId }"/></div>
								<div class="form-grou mr50"><label>年龄：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalAge }"/><span class="timeimg">岁</span></div>
								<div class="form-grou"><label>从业年限：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalWorkYear }"/><span class="timeimg">年</span></div>
							</div>
							<div class="ground-form mb20">
								<div class="form-grou"><label>办公电话：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalOfficePhone }"/></div>
								<div class="form-grou mr50"><label class="w140">婚姻状况：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalMaritalStatus }"/></div>
								<div class="form-grou"><label>家庭住址：</label><input class="content-form2" readonly="readonly" value="${businessAuth.legalHomeAddress }"/></div>
							</div>
						</div>
						
						<p class="protitle"><span>经营范围</span></p>
						<div class="pd20">
							企业经营范围：<textarea class="protext" readonly="readonly">${businessAuth.businessScope }</textarea>
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
											<td class="maxwidth100"><input class="tdinput" type="text" readonly="readonly" value="${obj.name }"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="<fmt:formatNumber value="${obj.investmentRatio*100}" pattern="0.##"/>"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="${obj.investmentMode }"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="${obj.legalName }"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="<fmt:formatNumber value="${obj.receivedAmount}" pattern="#,##0.##"/>"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="<fmt:formatNumber value="${obj.receivedAmount}" pattern="#,##0.##"/>"/></td>
											<td><input class="tdinput" type="text" readonly="readonly" value="<fmt:formatDate value="${obj.registerDate }" pattern="yyyy-MM-dd" />"/></td>
										</tr>
									</c:forEach>
								</table>
						</div>
					</div>
						
						
					<p class="protitle"><span>历史沿革</span></p>
					<div class="pd20">
						历史沿革：<textarea class="protext" readonly="readonly">${businessAuth.history }</textarea>
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
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalAssetsNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>总负债(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.totalDebtsNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>所有者权益(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.ownerEquityNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>营业收入(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessIncomeNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>营业成本(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessCostN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessCostN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessCostNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>营业利润(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.businessProfitNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>利润总额(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.profitAmountNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>净利润(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.netProfitN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.netProfitN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.netProfitNewest}" pattern="#,##0.##"/>"/></td>
									</tr>
									<tr>
										<td>经营活动现金流(元)</td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowN2}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowN1}" pattern="#,##0.##"/>"/></td>
										<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${situationVo.cashFlowNewest}" pattern="#,##0.##"/>"/></td>
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
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.loanAmount}" pattern="#,##0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.term }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.creditor }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.loanDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="#,##0.##"/>"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
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
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.loanAmount}" pattern="#,##0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.term }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.creditor }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.loanDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="#,##0.##"/>"/></td>
												<td  class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
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
											<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.guaranteeAmount}" pattern="#,##0.##"/>"/></td>
											<td><input class="tdinput" readonly="readonly" type="text" value="${obj.term }"/></td>
											<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.guarantor }"/></td>
											<td><input class="tdinput" readonly="readonly" type="text" value="${obj.guaranteeMode }"/></td>
											<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
											<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.balance}" pattern="#,##0.##"/>"/></td>
											<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
										</tr>
									</c:forEach>
								</table>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>未决诉讼或仲裁</span></p>
					<div class="pd20">
						<textarea class="protext btn-center" readonly="readonly">${financing.lawSituation }</textarea>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>其他或有事项</span></p>
					<div class="pd20">
						<textarea class="protext btn-center" readonly="readonly">${financing.other }</textarea>
					</div>
					
				</div>
				
				<div class="chebox chebox4">
					<p class="protitle"><span>融资需求</span></p>
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label style="widtth:96px;">融资人：</label><input class="content-form" readonly="readonly" value="${financing.financier }"/></div>
							<div class="form-grou mr50"><label style="widtth:96px;">融资金额：</label><input class="content-form" readonly="readonly" value="<fmt:formatNumber value="${financing.financingAmount}" pattern="#,##0.##"/>"/><span class="timeimg">元</span></div>
						</div>
						<div class="ground-form">
							<div class="form-grou mr50"><label style="widtth:96px;">融资期限：</label><input class="content-form" readonly="readonly" value="${financing.financingTerm }"/><span class="timeimg">年</span></div>
							<div class="form-grou mr50"><label style="widtth:96px;">融资利率：</label><input class="content-form" readonly="readonly" value="<fmt:formatNumber value="${financing.financingRate}" pattern="#,##0.####"/>"/><span class="timeimg">%</span></div>
						</div>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>增信措施</span></p>
					<div class="pd20">
						<textarea class="protext btn-center" readonly="readonly">${financing.trustMeasure }</textarea>
					</div>
					
					<div class="bottom-line"></div>
					
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">
						<textarea class="protext btn-center" readonly="readonly">${financing.remark }</textarea>
					</div>
					
				</div>
				
				<div class="chebox chebox5">
					<p class="protitle"><span>选择资产类型</span></p>
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>资产类型：</label>
								<%-- <select class="content-form sele" id="assetsType" name="assetsType" <c:if test="${operType == 'query' }">disabled="disabled"</c:if>>
									<option value="1" <c:if test="${financingApply.assetsType eq 1 }">selected="selected"</c:if>>应收账款</option>
									<option value="2" <c:if test="${financingApply.assetsType eq 2 }">selected="selected"</c:if>>应付账款</option>
									<option value="3" <c:if test="${financingApply.assetsType eq 3 }">selected="selected"</c:if>>票据</option>
								</select> --%>
								<c:if test="${financing == null }">
									该融资申请没有提交底层资产信息
								</c:if>
								<c:if test="${financing.assetsType eq 1 }">
									<input class="content-form" value="应收账款" readonly="readonly"/>
								</c:if>
								<c:if test="${financing.assetsType eq 2 }">
									<input class="content-form" value="应付账款" readonly="readonly"/>
								</c:if>
								<c:if test="${financing.assetsType eq 3 }">
									<input class="content-form" value="票据" readonly="readonly"/>
								</c:if>
							</div>
						</div>
					</div>
					<c:if test="${financing.assetsType eq 1 }">
					<div class="bottom-line"></div>
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
												<td width="150px"><input class="tdinput" readonly="readonly" type="text" value="${obj.customerName}"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.orderAmount}" pattern="#,##0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="#,##0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.amountsReceivableMoney}" pattern="#,##0.##"/>"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse eq 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse eq 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse eq 3 }">
														占用
													</c:if>
												</td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
					<c:if test="${financing.assetsType eq 2 }">
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
												<td width="150px"><input class="tdinput" readonly="readonly" type="text" value="${obj.supplierName}"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.orderAmount}" pattern="0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.amountsPayableMoney}" pattern="0.##"/>"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expectedPaymentDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse eq 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse eq 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse eq 3 }">
														占用
													</c:if>
												</td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
					<c:if test="${financing.assetsType eq 3 }">
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
												<td width="150px"><input class="tdinput" readonly="readonly" type="text" value="${obj.acceptorName}"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.billNo}"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.orderInfo }"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.billAmount}" pattern="0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice}" pattern="0.##"/>"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="${obj.orderNumber}"/></td>
												<td><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatNumber value="${obj.billAmount}" pattern="0.##"/>"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.billingDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.signDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />"/></td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.invoiceInfo }"/></td>
												<td>
													<!-- 是否使用1-已使用2-未使用3-占用 -->
													<c:if test="${obj.isUse eq 1 }">
														已使用
													</c:if>
													<c:if test="${obj.isUse eq 2 }">
														未使用
													</c:if>
													<c:if test="${obj.isUse eq 3 }">
														占用
													</c:if>
												</td>
												<td class="maxwidth100"><input class="tdinput" readonly="readonly" type="text" value="${obj.remark }"/></td>
											</tr>
										</c:forEach>
									</table>
									</div>
							</div>
						</div>
					</c:if>
				</div>
				
				<div class="bottom-line"></div>
				
				</div>
			</div>
		</div>
	</body>
	
	<script>
	$(function(){
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
	})
	
	$(".join-btn").click(function(){
			var numcount = $(this).attr("numcount");
			var appId = $(this).attr("appId");
			var orderNo = $(this).attr("orderNo");
			if(null != numcount){
				if(numcount >= 10){
					//不能参与
					alert("啊哦，您下手太慢了，该融资申请已投满");
				}else{
					if(null == appId){
						alert("参数数据有误，参与失败~");
						/* $("#pageForm").submit();//刷新界面 */
						return false;
					}else{
						//可以参与
						$.ajax({url : "/financingApplyController/insertSubFinancingApply",
							dataType : "json",
							type : "post",
							data : {appId:appId,orderNo:orderNo},
							success : function(response) {
								//数据插入成功
								if(response.responseType == 'SUCCESS'){
									/* alert(response.info); */
									alert(response.info, function() {
										window.location.href = "/financingApplyController/bidRecord/details.htm?id="+appId;
									});
								}
								if (response.responseType == 'FAILURE') {
										alert(response.info);
										/* $("#pageForm").submit();//刷新界面 */
								}
								if (response.responseType == 'ERROR') {
									alert(response.info);
									/* $("#pageForm").submit();//刷新界面 */
								}
							},
							error : function() {
								alert("参与失败");
								/* $("#pageForm").submit();//刷新界面 */
							}
						});
					}
				}
			}
		})
	</script>

<script>
	//此处为借助jQuery方法;
	$(function(){
		var expireDate = $("#clock").attr("bigExpireDate")+" 00:00:00";
		console.info(expireDate);
		setInterval("t('"+expireDate+"')", 1000);
	})
</script>


</html>