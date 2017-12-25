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
            
            .red-color-font{
                color:red;
            }
            .none1{ display:none!important;}
            
        </style>
    </head>
	<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
	<%@include file="/ybl4.0/admin/common/link.jsp"%>
    <body>
    <form id="pageForm">
        <input type="hidden" id="deleteEnterpriseLoanIdArray" name="deleteEnterpriseLoanIdArray"/>
        <input type="hidden" id="deletePersonDebtIdArray" name="deletePersonDebtIdArray"/>
        <input type="hidden" id="deleteGuaranteeIdArray" name="deleteGuaranteeIdArray"/>
        <input type="hidden" id="deleteReceivableIdArray" name="deleteReceivableIdArray"/>
        <input type="hidden" id="deleteRepayableIdArray" name="deleteRepayableIdArray"/>
        <input type="hidden" id="deleteBillIdArray" name="deleteBillIdArray"/>
        <input type="hidden" id="fileIdArray" name="fileIdArray"/>
        <input type="hidden" id="financingApplyId" name="financingApplyId" value="${financingApply.id }"/>
        <input type="hidden" id="businessId" name="businessId"
          <c:if test="${operType eq 'insert' }"> value="${businessAuth.id }"</c:if>
          <c:if test="${operType ne 'insert' }"> value="${financingApply.businessId }"</c:if> />
        <input type="hidden" id="operType" name="operType" value="${operType }" />
        <input type="hidden" id="subid" name="subid" value="${subid }" />
        <input type="hidden" id="financingStatus" name="financingStatus" value="${financingApply.financingStatus }"/>
        <input type="hidden" id="financing_status" name="financing_status" value="${subFinancingApply.financing_status }"/>
        <input type="hidden" id="factoringMode" name="factoringMode" value="${financingApply.factoringMode }"/>
        <input type="hidden" id="investorName" name="investorName" value="${financingApply.investorName }"/>
        <input type="hidden" id="createdTime" name="createdTime" value="<fmt:formatDate value='${financingApply.createdTime }' pattern="yyyy-MM-dd HH-mm-ss" />"/>
        <input type="hidden" id="createdBy" name="createdBy" value="${financingApply.createdBy }"/>
        
        <div class="w1200 clearfix border-b">
            <ul class="clearfix formul">
                <li class="formli <c:if test="${empty subid or subid eq 0}">form_cur</c:if>">融资需求列表</li>
                <li class="formli">资料清单</li>
                <c:if test="${not empty subid and subid ne 0}"><li class="formli form_cur">被驳回补充资料</li></c:if>
            </ul>
        </div>
        <div class="w1200 ybl-info box box1">
            <div class="ground-form mb20">
                <div class="form-grou mr40"><label class="label-long">融资订单号：</label><input class="content-form2" name="financingOrderNumber" value="${financingApply.financingOrderNumber }" readonly/>
                </div>
                <div class="form-grou mr40"><label class="label-long">申请单位：</label><input class="content-form2" name="enterpriseName" <c:if test="${operType == 'query' }">value="${financingApply.enterpriseName }"</c:if>
                        <c:if test="${operType ne 'query' }">value="${businessAuth.enterpriseName }"</c:if> readonly/>
                </div><div class="form-grou">
                <label class="label-long"><i class="red-color-font">*</i>融资方式：</label><select id="financingMode" name="financingMode" class="content-form2" disabled="true">
                        <option value="1" <c:if test="${financingApply.financingMode eq 1 }">selected="selected"</c:if>>签约资方</option>
                        <option value="2" <c:if test="${financingApply.financingMode eq 2 }">selected="selected"</c:if>>平台推荐</option>
                        <option value="3" <c:if test="${financingApply.financingMode eq 3 }">selected="selected"</c:if>>竞标</option>
                    </select>
                </div>
            </div>
            
            <div class="ground-form mb20">
                <div class="form-grou mr40" id="bidDate"><label class="label-long">竞标截止时间：</label><input class="content-form2 selectDate" name="bidExpireDate" id="bidExpireDate" value="<fmt:formatDate value='${financingApply.bidExpireDate }' pattern="yyyy-MM-dd" />"/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" class="timeimg" />
                </div>
                <div class="form-grou" id="factorySelect"><label class="label-long">资方名称：</label><input readonly class="content-form2" /><img src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_search_icon.png" class="timeimg" <c:if test="${operType ne 'query' }">id="addFactory"</c:if>/></div><%-- <a class="ml10 mr40" id="addFactory" href="javascript:;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_add_icon.png" /></a> --%>
            </div>
            <div class="ground-form" id="zfname">
                <c:forEach items="${factoryList }" var="obj">
                    <div class="form-grou mb20 mr40"><label class="label-long">资方名称：</label><input readonly class="content-form2" value="${obj.enterpriseName }"  /></div>
                </c:forEach>
            </div>
            
            <div class="bottom-line"></div>
            
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
                            <div class="form-grou mr50"><label>企业全称：</label><input class="content-form2" id="enterpriseNameForBusiness" value="${businessAuth.enterpriseName }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>所属行业：</label><input class="content-form2" id="industry" value="${businessAuth.industry }" disabled="disabled"/></div>
                            <div class="form-grou"><label>注册地址：</label><input class="content-form2" id="registerAddress" value="${businessAuth.registerAddress }" disabled="disabled"/></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>注册日期：</label><input class="content-form2" id="registerDate" value="<fmt:formatDate value='${businessAuth.registerDate }' pattern="yyyy-MM-dd" />" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>注册资本：</label><input class="content-form2" id="registerCapital" value="<fmt:formatNumber value="${businessAuth.registerCapital }" pattern="##0.00" maxFractionDigits="2"/>" disabled="disabled"/><span class="timeimg">元</span></div>
                            <div class="form-grou"><label>实缴资本：</label><input class="content-form2" id="paidCapital" value="<fmt:formatNumber value="${businessAuth.paidCapital }" pattern="##0.00" maxFractionDigits="2"/>" disabled="disabled"/><span class="timeimg">元</span></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou"><label>办公地址：</label><input class="content-form2" id="officeAddress" value="${businessAuth.officeAddress }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label class="w140">统一社会信用代码：</label><input class="content-form2" id="socialCreditCode" value="${businessAuth.socialCreditCode }" disabled="disabled"/></div>
                            <div class="form-grou"><label>年检情况：</label><input class="content-form2" id="annualSurveySituation" value="${businessAuth.annualSurveySituation }"  disabled="disabled"/></div>
                        </div>
                        <div class="ground-form">
                            <div class="form-grou mr50"><label>联系人：</label><input class="content-form2" id="contacts" value="${businessAuth.contacts }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>电话：</label><input class="content-form2" id="contactsPhone" value="${businessAuth.contactsPhone }" disabled="disabled"/></div>
                            <div class="form-grou"><label>邮箱：</label><input class="content-form2" id="contactsEmail" value="${businessAuth.contactsEmail }" disabled="disabled"/></div>
                        </div>
                    </div>
                    
                    <p class="protitle"><span>实际控制人信息</span></p>
                    
                    <div class="grounpinfo">
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>姓名：</label><input class="content-form2" id="controllerName" value="${businessAuth.controllerName }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>性别：</label><input class="content-form2" id="controllerGender" value="${businessAuth.controllerGender }" disabled="disabled"/></div>
                            <div class="form-grou"><label>国籍：</label><input class="content-form2" id="controllerNationality" value="${businessAuth.controllerNationality }" disabled="disabled"/></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" id="controllerCardId" value="${businessAuth.controllerCardId }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>年龄：</label><input class="content-form2" id="controllerAge" value="${businessAuth.controllerAge }" disabled="disabled"/><span class="timeimg">岁</span></div>
                            <div class="form-grou"><label>从业年限：</label><input class="content-form2" id="controllerWorkYear" value="${businessAuth.controllerWorkYear }" disabled="disabled"/><span class="timeimg">年</span></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>办公电话：</label><input class="content-form2" id="controllerOfficePhone" value="${businessAuth.controllerOfficePhone }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>婚姻状况：</label><input class="content-form2" id="controllerMaritalStatus" value="${businessAuth.controllerMaritalStatus }" disabled="disabled"/></div>
                            <div class="form-grou"><label>家庭住址：</label><input class="content-form2" id="controllerHomeAddress" value="${businessAuth.controllerHomeAddress }" disabled="disabled"/></div>
                        </div>
                    </div>
                    
                    <p class="protitle"><span>法定代表人信息</span></p>
                    
                    <div class="grounpinfo">
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>姓名：</label><input class="content-form2" id="legalName" value="${businessAuth.legalName }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>性别：</label><input class="content-form2" id="legalGender" value="${businessAuth.legalGender }"   disabled="disabled"/></div>
                            <div class="form-grou"><label>国籍：</label><input class="content-form2" id="legalNationality" value="${businessAuth.legalNationality }" disabled="disabled"/></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>身份证号码：</label><input class="content-form2" id="legalCardId" value="${businessAuth.legalCardId }"/></div>
                            <div class="form-grou mr50"><label>年龄：</label><input class="content-form2" id="legalAge" value="${businessAuth.legalAge }" disabled="disabled"/><span class="timeimg">岁</span></div>
                            <div class="form-grou"><label>从业年限：</label><input class="content-form2" id="legalWorkYear" value="${businessAuth.legalWorkYear }" disabled="disabled"/><span class="timeimg">年</span></div>
                        </div>
                        <div class="ground-form mb20">
                            <div class="form-grou mr50"><label>办公电话：</label><input class="content-form2" id="legalOfficePhone" value="${businessAuth.legalOfficePhone }" disabled="disabled"/></div>
                            <div class="form-grou mr50"><label>婚姻状况：</label><input class="content-form2" id="legalMaritalStatus" value="${businessAuth.legalMaritalStatus }" disabled="disabled"/></div>
                            <div class="form-grou"><label>家庭住址：</label><input class="content-form2" id="legalHomeAddress" value="${businessAuth.legalHomeAddress }" disabled="disabled"/></div>
                        </div>
                    </div>
                    
                    <p class="protitle"><span>经营范围</span></p>
                    <div class="pd20">
                        企业经营范围：<textarea class="protext" id="businessScope" readonly>${businessAuth.businessScope }</textarea>
                    </div>
                    
                    <p class="protitle"><span>股东情况</span></p>
                    <div class="pd20">
                        <div class="tabD">
                            <table id="stockTab">
                                <tr>
                                    <th>股东名称</th>
                                    <th>股权比例</th>
                                    <th>注资方式</th>
                                    <th>法人代表</th>
                                    <th>注册资本(元)</th>
                                    <th>实收资本</th>
                                    <th>注册日期</th>
                                </tr>
                                <tr id="stockTr">
                                    <td><input class="tdinput " type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                    <td><input class="tdinput" type="text" readonly/></td>
                                </tr>
                            </table>
                    </div>
                </div>
                    
                    
                <p class="protitle"><span>历史沿革</span></p>
                <div class="pd20">
                    历史沿革：<textarea class="protext" id="history" readonly>${businessAuth.history }</textarea>
                </div>  
            </div>
            
            <div class="chebox chebox2">
                <p class="protitle"><span>主要财务数据</span></p>
                    <div class="pd20">
                        <div class="tabD">
                            <table>
                                <input type="hidden" id="financialSituationId" name="financialSituationId"/>
                                <tr>
                                    <th>类别</th>
                                    <th>n~2年</th>
                                    <th>n~1年</th>
                                    <th>最新一期</th>
                                </tr>
                                <tr>
                                    <td><i class="red-color-font">*</i>总资产</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalAssetsNewest" name="totalAssetsNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalAssetsN1" name="totalAssetsN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalAssetsN2" name="totalAssetsN2" /></td>
                                </tr>
                                <tr>
                                    <td>总负债</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalDebtsNewest" name="totalDebtsNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalDebtsN1" name="totalDebtsN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="totalDebtsN2" name="totalDebtsN2" /></td>
                                </tr>
                                <tr>
                                    <td>所有者权益</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="ownerEquityNewest" name="ownerEquityNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="ownerEquityN1" name="ownerEquityN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="ownerEquityN2" name="ownerEquityN2" /></td>
                                </tr>
                                <tr>
                                    <td><i class="red-color-font">*</i>营业收入</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="businessIncomeNewest" name="businessIncomeNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="businessIncomeN1" name="businessIncomeN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="businessIncomeN2" name="businessIncomeN2" /></td>
                                </tr>
                                <tr>
                                    <td>营业成本</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessCostNewest" name="businessCostNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessCostN1" name="businessCostN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessCostN2" name="businessCostN2" /></td>
                                </tr>
                                <tr>
                                    <td>营业利润</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessProfitNewest" name="businessProfitNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessProfitN1" name="businessProfitN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number]min[0]]" type="text" id="businessProfitN2" name="businessProfitN2" /></td>
                                </tr>
                                <tr>
                                    <td>利润总额</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="profitAmountNewest" name="profitAmountNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="profitAmountN1" name="profitAmountN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="profitAmountN2" name="profitAmountN2" /></td>
                                </tr>
                                <tr>
                                    <td><i class="red-color-font">*</i>净利润</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="netProfitNewest" name="netProfitNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="netProfitN1" name="netProfitN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="netProfitN2" name="netProfitN2" /></td>
                                </tr>
                                <tr>
                                    <td>经营活动现金流</td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="cashFlowNewest" name="cashFlowNewest" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="cashFlowN1" name="cashFlowN1" /></td>
                                    <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" id="cashFlowN2" name="cashFlowN2" /></td>
                                </tr>
                            </table>
                    </div>
                </div>
            </div>  
            
            <div class="chebox chebox3">
                <p class="protitle"><span>企业借款情况</span></p>
                <div class="pd20 clearfix">
                    <c:if test="${operType ne 'query' }">
                        <a class="btn-modify fr" onclick="enterprsieLoanAdd()">添加行</a>
                    </c:if>
                    <div class="tabD mt30">
                        <table id="enterpriseLoanTb">
                            <tr class="enterpriseLoanTr">
                                <th>借款金额</th>
                                <th>期限</th>
                                <th>债权人</th>
                                <th>借款日期</th>
                                <th>到期日期</th>
                                <th>余额</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addEnterpriseLoan" id="enterpriseLoanFirst">
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="enterpriseLoanList[0].loanAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="enterpriseLoanList[0].term"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="enterpriseLoanList[0].creditor"/></td>
                                <td><input class="tdinput selectDate" type="text" name="enterpriseLoanList[0].loanDate"/></td>
                                <td><input class="tdinput selectDate" type="text" name="enterpriseLoanList[0].expireDate"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="enterpriseLoanList[0].balance"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="enterpriseLoanList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='enterpriseLoanDeleteRow(this,null)'>删除</a><input type="hidden" name="enterpriseLoanList[0].type" value="1" /></td></c:if>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>个人负债情况</span></p>
                <div class="pd20 clearfix">
                    <c:if test="${operType ne 'query' }">
                        <a class="btn-modify fr" onclick="personDebtAdd()">添加行</a>
                    </c:if>
                    <div class="tabD mt30">
                        <table id="personDebtTb">
                            <tr class="personDebtTr">
                                <th>借款金额</th>
                                <th>期限</th>
                                <th>债权人</th>
                                <th>借款日期</th>
                                <th>到期日期</th>
                                <th>余额</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addPersonDebt" id="personDebtFirst">
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="personDebtList[0].loanAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="personDebtList[0].term"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="personDebtList[0].creditor"/></td>
                                <td><input class="tdinput selectDate" type="text" name="personDebtList[0].loanDate"/></td>
                                <td><input class="tdinput selectDate" type="text" name="personDebtList[0].expireDate"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="personDebtList[0].balance"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="personDebtList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='personDebtDeleteRow(this,null)'>删除</a><input type="hidden" name="personDebtList[0].type" value="2" /></td></c:if>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>对外担保情况</span></p>
                <div class="pd20 clearfix">
                    <c:if test="${operType ne 'query' }">
                        <a class="btn-modify fr" onclick="guaranteeAdd()">添加行</a>
                    </c:if>
                    <div class="tabD mt30">
                        <table id="guaranteeTb">
                            <tr class="guaranteeTr">
                                <th>担保金额</th>
                                <th>期限</th>
                                <th>被担保单位</th>
                                <th>担保方式</th>
                                <th>到期日期</th>
                                <th>余额</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addGuarantee" id="guaranteeFirst">
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="guaranteeList[0].guaranteeAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="guaranteeList[0].term"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="guaranteeList[0].guarantor"/></td>
                                <td><input class="tdinput validate[maxSize[10]]" type="text" name="guaranteeList[0].guaranteeMode"/></td>
                                <td><input class="tdinput selectDate" type="text" name="guaranteeList[0].expireDate"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" name="guaranteeList[0].balance"/></td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" name="guaranteeList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='guaranteeDeleteRow(this,null)'>删除</a></td></c:if>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>未决诉讼或仲裁</span></p>
                <div class="pd20">
                    <textarea class="protext btn-center validate[maxSize[120]]" name="lawSituation">${financingApply.lawSituation }</textarea>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>其他或有事项</span></p>
                <div class="pd20">
                    <textarea class="protext btn-center validate[maxSize[120]]" name="other">${financingApply.other }</textarea>
                </div>
                
            </div>
            
            <div class="chebox chebox4">
                <p class="protitle"><span>融资诉求</span></p>
                <div class="grounpinfo">
                    <div class="ground-form mb20">
                        <div class="form-grou mr50"><label>融资人：</label><input class="content-form" name="financier" readonly <c:if test="${operType == 'insert'}">value="${businessAuth.enterpriseName }"</c:if> <c:if test="${operType ne 'insert'}">value="${financingApply.financier }"</c:if>/></div>
                        <div class="form-grou mr50"><label><i class="red-color-font">*</i>融资金额：</label><input class="content-form validate[maxSize[20],custom[number],min[0]]" name="financingAmount" value="<fmt:formatNumber value="${financingApply.financingAmount }" pattern="##0.00" maxFractionDigits="2"/>"/><span class="timeimg">元</span></div>
                    </div>
                    <div class="ground-form">
                        <div class="form-grou mr50"><label><i class="red-color-font">*</i>融资期限：</label><input class="content-form validate[maxSize[20],custom[number],min[0]]" name="financingTerm" value="${financingApply.financingTerm }"/><span class="timeimg">天</span></div>
                        <div class="form-grou mr50"><label><i class="red-color-font">*</i>融资利率：</label><input class="content-form validate[maxSize[20],custom[number],min[0.0001],max[100]]" name="financingRate" value="${financingApply.financingRate }" /><span class="timeimg">%</span></div>
                    </div>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>增信措施</span></p>
                <div class="pd20">
                    <textarea class="protext btn-center validate[maxSize[120]]" name="trustMeasure">${financingApply.trustMeasure }</textarea>
                </div>
                
                <div class="bottom-line"></div>
                
                <p class="protitle"><span>备注</span></p>
                <div class="pd20">
                    <textarea class="protext btn-center validate[maxSize[120]]" name="financingDemandRemark">${financingApply.financingDemandRemark }</textarea>
                </div>
                
            </div>
            
            <div class="chebox chebox5">
                <p class="protitle"><span>选择资产类型</span></p>
                <div class="grounpinfo">
                    <div class="ground-form mb20">
                        <div class="form-grou mr50">
                            <label><i class="red-color-font">*</i>资产类型：</label>
                            <select class="content-form sele" id="assetsType" name="assetsType" disabled="true">
                                <option value="1" <c:if test="${financingApply.assetsType eq 1 }">selected="selected"</c:if>>应收账款</option>
                                <option value="2" <c:if test="${financingApply.assetsType eq 2 }">selected="selected"</c:if>>应付账款</option>
                                <option value="3" <c:if test="${financingApply.assetsType eq 3 }">selected="selected"</c:if>>票据</option>
                            </select>
                        </div>
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
                            <tr class="receivableTr">
                                <th>资产编号</th>
                                <th><i class="red-color-font">*</i>客户名称</th>
                                <th><i class="red-color-font">*</i>合同/订单信息</th>
                                <th><i class="red-color-font">*</i>合同/订单金额</th>
                                <th>合同/订单单价</th>
                                <th>合同/订单数量</th>
                                <th><i class="red-color-font">*</i>应收账款金额</th>
                                <th><i class="red-color-font">*</i>签署日期</th>
                                <th><i class="red-color-font">*</i>预支付日期</th>
                                <th><i class="red-color-font">*</i>发票信息</th>
                                <th>是否使用</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addReceivable" style="border:1px">
                                <td><input class="tdinput" type="text" value="${receivableList[0].assetNumber}" readonly name="receivableList[0].assetNumber"/></td>
                                <td>
                                    <input type="hidden" value="${receivableList[0].id }" name="receivableList[0].id" />
                                    <div class="nice-select">
                                        <input class="tdinput select-enterprise validate[maxSize[20]]" value="${receivableList[0].customerName}" name="receivableList[0].customerName" type="text" oninput="searchList(this.value)" />
                                    </div>
                                </td>
                                <td><input class="tdinput validate[maxSize[120]" type="text" value="${receivableList[0].orderInfo}" name="receivableList[0].orderInfo"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${receivableList[0].orderAmount}" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[0].orderAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${receivableList[0].orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[0].orderUnitPrice"/></td>
                                <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${receivableList[0].orderNumber}" name="receivableList[0].orderNumber"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${receivableList[0].amountsReceivableMoney}" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[0].amountsReceivableMoney"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${receivableList[0].signDate}' pattern="yyyy-MM-dd" />" name="receivableList[0].signDate"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${receivableList[0].expectedPaymentDate}' pattern="yyyy-MM-dd" />" name="receivableList[0].expectedPaymentDate"/></td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${receivableList[0].invoiceInfo}" name="receivableList[0].invoiceInfo"/></td>
                                <td><input type="hidden" <c:if test="${operType eq 'insert' }">value="2"</c:if><c:if test="${operType ne 'insert' }">value="${receivableList[0].isUse}"</c:if> name="receivableList[0].isUse"/>
                                    <input class="tdinput" type="text" readonly
                                        <c:if test="${receivableList[0].isUse eq 1}">value="已使用"</c:if>
                                        <c:if test="${receivableList[0].isUse eq 2}">value="未使用"</c:if>
                                        <c:if test="${receivableList[0].isUse eq 3}">value="已占用"</c:if>
                                    />
                                </td>
                                <td><input class="tdinput  validate[maxSize[120]]" type="text" value="${receivableList[0].remark}" name="receivableList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='receivableDeleteRow(this,receivableList[0].id)'>删除</a></td></c:if>
                            </tr>
                            <c:if test="${operType ne 'insert' }">
                                <c:forEach items="${receivableList}" begin="1" varStatus="index" var="obj">
                                    <tr class="addReceivable">
                                        <td><input class="tdinput" type="text" value="${obj.assetNumber }" readonly name="receivableList[${index.count }].assetNumber"/></td>
                                        <input type="hidden" value="${obj.id }" name="receivableList[${index.count }].id" />
                                        <td>
                                            <div class="nice-select">
                                                <input class="tdinput select-enterprise  validate[maxSize[20]]" type="text" value="${obj.customerName }" oninput="searchList(this.value)" name="receivableList[${index.count }].customerName"/>
                                            </div>
                                        </td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.orderInfo }" name="receivableList[${index.count }].orderInfo"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[${index.count }].orderAmount"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[${index.count }].orderUnitPrice"/></td>
                                        <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${obj.orderNumber }" name="receivableList[${index.count }].orderNumber"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.amountsReceivableMoney }" pattern="##0.00" maxFractionDigits="2"/>" name="receivableList[${index.count }].amountsReceivableMoney"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="receivableList[${index.count }].signDate"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />" name="receivableList[${index.count }].expectedPaymentDate"/></td>
                                        <td><input class="tdinput  validate[maxSize[120]]" type="text" value="${obj.invoiceInfo }" name="receivableList[${index.count }].invoiceInfo"/></td>
                                        <td><input type="hidden" value="${obj.isUse}" name="receivableList[${index.count }].isUse"/>
                                            <input class="tdinput" type="text" readonly
                                                <c:if test="${obj.isUse eq 1}">value="已使用"</c:if>
                                                <c:if test="${obj.isUse eq 2}">value="未使用"</c:if>
                                                <c:if test="${obj.isUse eq 3}">value="已占用"</c:if>
                                            />
                                        </td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.remark }" name="receivableList[${index.count }].remark"/></td>
                                        <c:if test="${operType == 'update' }"><td><a class="btn-modify" onclick='receivableDeleteRow(this,${obj.id })'>删除</a></td></c:if>
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
                            <tr class="repayableTr">
                                <th>资产编号</th>
                                <th><i class="red-color-font">*</i>供应商名称</th>
                                <th><i class="red-color-font">*</i>合同/订单信息</th>
                                <th><i class="red-color-font">*</i>合同/订单金额</th>
                                <th>合同/订单单价</th>
                                <th>合同/订单数量</th>
                                <th><i class="red-color-font">*</i>应付账款金额</th>
                                <th><i class="red-color-font">*</i>签署日期</th>
                                <th><i class="red-color-font">*</i>预支付日期</th>
                                <th><i class="red-color-font">*</i>发票信息</th>
                                <th>是否使用</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addRepayable">
                                <td><input class="tdinput" type="text" value="${repayableList[0].assetNumber}" readonly name="repayableList[0].assetNumber"/></td>
                                <td>
                                    <input type="hidden" value="${repayableList[0].id }" name="repayableList[0].id" />
                                    <div class="nice-select">
                                        <input class="tdinput select-enterprise  validate[maxSize[20]]" value="${repayableList[0].supplierName}" name="repayableList[0].supplierName" type="text" oninput="searchList(this.value)" />
                                    </div>
                                </td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${repayableList[0].orderInfo}" name="repayableList[0].orderInfo"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${repayableList[0].orderAmount}" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[0].orderAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${repayableList[0].orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[0].orderUnitPrice"/></td>
                                <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${repayableList[0].orderNumber}" name="repayableList[0].orderNumber"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${repayableList[0].amountsPayableMoney}" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[0].amountsPayableMoney"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${repayableList[0].signDate}' pattern="yyyy-MM-dd" />" name="repayableList[0].signDate"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${repayableList[0].expectedPaymentDate}' pattern="yyyy-MM-dd" />" name="repayableList[0].expectedPaymentDate"/></td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${repayableList[0].invoiceInfo}" name="repayableList[0].invoiceInfo"/></td>
                                <td><input type="hidden" <c:if test="${operType eq 'insert' }">value="2"</c:if><c:if test="${operType ne 'insert' }">value="${repayableList[0].isUse}"</c:if> name="repayableList[0].isUse"/>
                                    <input class="tdinput" type="text" readonly
                                        <c:if test="${repayableList[0].isUse eq 1}">value="已使用"</c:if>
                                        <c:if test="${repayableList[0].isUse eq 2}">value="未使用"</c:if>
                                        <c:if test="${repayableList[0].isUse eq 3}">value="已占用"</c:if>
                                    />
                                </td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${repayableList[0].remark}" name="repayableList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='repayableDeleteRow(this,repayableList[0].id)'>删除</a></td></c:if>
                            </tr>
                            <c:if test="${operType ne 'insert' }">
                                <c:forEach items="${repayableList}" begin="1" varStatus="index" var="obj">
                                    <tr class="addRepayable">
                                        <td><input class="tdinput" type="text" value="${obj.assetNumber }" readonly name="repayableList[${index.count }].assetNumber"/></td>
                                        <td>
                                            <input type="hidden" value="${obj.id }" name="repayableList[${index.count }].id" />
                                            <div class="nice-select">
                                                <input class="tdinput select-enterprise validate[maxSize[20]]" type="text" value="${obj.supplierName }" oninput="searchList(this.value)" name="repayableList[${index.count }].supplierName"/>
                                            </div>
                                        </td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.orderInfo }" name="repayableList[${index.count }].orderInfo"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[${index.count }].orderAmount"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[${index.count }].orderUnitPrice"/></td>
                                        <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${obj.orderNumber }" name="repayableList[${index.count }].orderNumber"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.amountsPayableMoney }" pattern="##0.00" maxFractionDigits="2"/>" name="repayableList[${index.count }].amountsPayableMoney"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="repayableList[${index.count }].signDate"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />" name="repayableList[${index.count }].expectedPaymentDate"/></td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.invoiceInfo }" name="repayableList[${index.count }].invoiceInfo"/></td>
                                        <td><input type="hidden" value="${obj.isUse}" name="repayableList[${index.count }].isUse"/>
                                            <input class="tdinput" type="text" readonly
                                                <c:if test="${obj.isUse eq 1}">value="已使用"</c:if>
                                                <c:if test="${obj.isUse eq 2}">value="未使用"</c:if>
                                                <c:if test="${obj.isUse eq 3}">value="已占用"</c:if>
                                            />
                                        </td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.remark }" name="repayableList[${index.count }].remark"/></td>
                                        <c:if test="${operType == 'update' }"><td><a class="btn-modify" onclick='repayableDeleteRow(this,${obj.id })'>删除</a></td></c:if>
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
                            <tr class="billTr">
                                <th>资产编号</th>
                                <th><i class="red-color-font">*</i>承兑人名称</th>
                                <th><i class="red-color-font">*</i>票据号码</th>
                                <th>合同/订单信息</th>
                                <th><i class="red-color-font">*</i>合同/订单金额</th>
                                <th>合同/订单单价</th>
                                <th>合同/订单数量</th>
                                <th><i class="red-color-font">*</i>票据金额</th>
                                <th><i class="red-color-font">*</i>出票日期</th>
                                <th><i class="red-color-font">*</i>到期日期</th>
                                <th><i class="red-color-font">*</i>签署日期</th>
                                <th>发票信息</th>
                                <th>是否使用</th>
                                <th>备注</th>
                                <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                            </tr>
                            <tr class="addBill">
                                <td><input class="tdinput" type="text" value="${billList[0].assetNumber}" readonly name="billList[0].assetNumber"/></td>
                                <td>
                                    <input type="hidden" value="${billList[0].id }" name="billList[0].id" />
                                    <div class="nice-select">
                                        <input class="tdinput select-enterprise validate[maxSize[20]]" value="${billList[0].acceptorName}" name="billList[0].acceptorName" type="text" oninput="searchList(this.value)" />
                                    </div>
                                </td>
                                <td><input class="tdinput validate[maxSize[20]]" type="text" value="${billList[0].billNo}" name="billList[0].billNo"/></td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${billList[0].orderInfo}" name="billList[0].orderInfo"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${billList[0].orderAmount}" pattern="##0.00" maxFractionDigits="2"/>" name="billList[0].orderAmount"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${billList[0].orderUnitPrice}" pattern="##0.00" maxFractionDigits="2"/>" name="billList[0].orderUnitPrice"/></td>
                                <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${billList[0].orderNumber}" name="billList[0].orderNumber"/></td>
                                <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${billList[0].billAmount}" pattern="##0.00" maxFractionDigits="2"/>" name="billList[0].billAmount"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${billList[0].billingDate}' pattern="yyyy-MM-dd" />" name="billList[0].billingDate"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${billList[0].expireDate}' pattern="yyyy-MM-dd" />" name="billList[0].expireDate"/></td>
                                <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${billList[0].signDate}' pattern="yyyy-MM-dd" />" name="billList[0].signDate"/></td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${billList[0].invoiceInfo}" name="billList[0].invoiceInfo"/></td>
                                <td><input type="hidden" <c:if test="${operType eq 'insert' }">value="2"</c:if><c:if test="${operType ne 'insert' }">value="${billList[0].isUse}"</c:if> name="billList[0].isUse"/>
                                    <input class="tdinput" type="text" readonly
                                        <c:if test="${billList[0].isUse eq 1}">value="已使用"</c:if>
                                        <c:if test="${billList[0].isUse eq 2}">value="未使用"</c:if>
                                        <c:if test="${billList[0].isUse eq 3}">value="已占用"</c:if>
                                    />
                                </td>
                                <td><input class="tdinput validate[maxSize[120]]" type="text" value="${billList[0].remark}" name="billList[0].remark"/></td>
                                <c:if test="${operType ne 'query' }"><td><a class="btn-modify" onclick='billDeleteRow(this,billList[0].id)'>删除</a></td></c:if>
                            </tr>
                            <c:if test="${operType ne 'insert' }">
                                <c:forEach items="${billList}" begin="1" varStatus="index" var="obj">
                                    <tr class="addBill">
                                        <td><input class="tdinput" type="text" value="${obj.assetNumber }" readonly name="billList[${index.count }].assetNumber"/></td>
                                        <td>    
                                            <input type="hidden" value="${obj.id }" name="billList[${index.count }].id" />
                                            <div class="nice-select">
                                                <input class="tdinput select-enterprise validate[maxSize[20]]" type="text" value="${obj.acceptorName }" oninput="searchList(this.value)" name="billList[${index.count }].acceptorName"/>
                                            </div>
                                        </td>
                                        <td><input class="tdinput validate[maxSize[20]]" type="text" value="${obj.billNo }" name="billList[${index.count }].billNo"/></td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.orderInfo }" name="billList[${index.count }].orderInfo"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.00" maxFractionDigits="2"/>" name="billList[${index.count }].orderAmount"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.00" maxFractionDigits="2"/>" name="billList[${index.count }].orderUnitPrice"/></td>
                                        <td><input class="tdinput validate[maxSize[11],custom[number],min[0]]" type="text" value="${obj.orderNumber }" name="billList[${index.count }].orderNumber"/></td>
                                        <td><input class="tdinput validate[maxSize[20],custom[number],min[0]]" type="text" value="<fmt:formatNumber value="${obj.billAmount }" pattern="##0.00" maxFractionDigits="2"/>" name="billList[${index.count }].billAmount"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.billingDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].billingDate"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.expireDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].expireDate"/></td>
                                        <td><input class="tdinput selectDate" type="text" value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />" name="billList[${index.count }].signDate"/></td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.invoiceInfo }" name="billList[${index.count }].invoiceInfo"/></td>
                                        <td><input type="hidden" value="${obj.isUse}" name="billList[${index.count }].isUse"/>
                                            <input class="tdinput" type="text" readonly
                                                <c:if test="${obj.isUse eq 1}">value="已使用"</c:if>
                                                <c:if test="${obj.isUse eq 2}">value="未使用"</c:if>
                                                <c:if test="${obj.isUse eq 3}">value="已占用"</c:if>
                                            />
                                        </td>
                                        <td><input class="tdinput validate[maxSize[120]]" type="text" value="${obj.remark }" name="billList[${index.count }].remark"/></td>
                                        <c:if test="${operType == 'update' }"><td><a class="btn-modify" onclick='billDeleteRow(this,${obj.id })'>删除</a></td></c:if>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                    </div>
                </div>
                </div>
            </div>
            
            <div class="bottom-line"></div>
            
            <c:if test="${operType ne 'query' }"><div class="shenmin">申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div></c:if>
            
            <c:if test="${operType ne 'query' }">
                <div class="btn3 clearfix mb80 btn-submit">
                        <a href="javascript:;" class="btn-add" onclick="submitFinancing(1)">保存草稿</a>
                        <a href="javascript:;" class="btn-add" onclick="submitFinancing(2)">保存并提交</a>
                        <a href="javascript:history.go(-1);" class="btn-add">取消</a>
                </div>
            </c:if>
            
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
                            <c:if test="${operType ne 'query' }"><th>操作</th></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">营业执照(三证合一)</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file12.url }" title="${file12.oldName }" download="${file12.oldName }" id="file12_a">${file12.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file12" utype="12" uindex="0" uname="营业执照(三证合一)">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file12.id }' name='dataAttachmentList[0].id'/></c:if>
                                <div id="file12_div" >
                                    <input type='hidden' value='${file12.url }' name='dataAttachmentList[0].url'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[0].type'/>
                                    <input type='hidden' value='${file12.remark }' name='dataAttachmentList[0].remark'/>
                                    <input type='hidden' value='${file12.oldName }' name='dataAttachmentList[0].oldName'/>
                                    <input type='hidden' value='${file12.newName }' name='dataAttachmentList[0].newName'/>
                                    <input type='hidden' value='${file12.extName }' name='dataAttachmentList[0].extName'/>
                                    <input type='hidden' value='${file12.fileSize }' name='dataAttachmentList[0].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[0].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">开户许可证</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file13.url }" title="${file13.oldName }" download="${file13.oldName }" id="file13_a">${file13.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file13" utype="13" uindex="1" uname="开户许可证">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file13.id }' name='dataAttachmentList[1].id'/></c:if>
                                <div id="file13_div" >
                                    <input type='hidden' value='${file13.url }' name='dataAttachmentList[1].url'/>
                                    <input type='hidden' value='13' name='dataAttachmentList[1].type'/>
                                    <input type='hidden' value='${file13.remark }' name='dataAttachmentList[1].remark'/>
                                    <input type='hidden' value='${file13.oldName }' name='dataAttachmentList[1].oldName'/>
                                    <input type='hidden' value='${file13.newName }' name='dataAttachmentList[1].newName'/>
                                    <input type='hidden' value='${file13.extName }' name='dataAttachmentList[1].extName'/>
                                    <input type='hidden' value='${file13.fileSize }' name='dataAttachmentList[1].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[1].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">机构信用代码证</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file14.url }" title="${file14.oldName }" download="${file14.oldName }" id="file14_a">${file14.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file14" utype="14" uindex="2" uname="机构信用代码证">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file14.id }' name='dataAttachmentList[2].id'/></c:if>
                                <div id="file14_div" >
                                    <input type='hidden' value='${file14.url }' name='dataAttachmentList[2].url'/>
                                    <input type='hidden' value='14' name='dataAttachmentList[2].type'/>
                                    <input type='hidden' value='${file14.remark }' name='dataAttachmentList[2].remark'/>
                                    <input type='hidden' value='${file14.oldName }' name='dataAttachmentList[2].oldName'/>
                                    <input type='hidden' value='${file14.newName }' name='dataAttachmentList[2].newName'/>
                                    <input type='hidden' value='${file14.extName }' name='dataAttachmentList[2].extName'/>
                                    <input type='hidden' value='${file14.fileSize }' name='dataAttachmentList[2].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[2].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">法人代表人身份证</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file15.url }" title="${file15.oldName }" download="${file15.oldName }" id="file15_a">${file15.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file15" utype="15" uindex="3" uname="法人代表人身份证">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file15.id }' name='dataAttachmentList[3].id'/></c:if>
                                <div id="file15_div" >
                                    <input type='hidden' value='${file15.url }' name='dataAttachmentList[3].url'/>
                                    <input type='hidden' value='15' name='dataAttachmentList[3].type'/>
                                    <input type='hidden' value='${file15.remark }' name='dataAttachmentList[3].remark'/>
                                    <input type='hidden' value='${file15.oldName }' name='dataAttachmentList[3].oldName'/>
                                    <input type='hidden' value='${file15.newName }' name='dataAttachmentList[3].newName'/>
                                    <input type='hidden' value='${file15.extName }' name='dataAttachmentList[3].extName'/>
                                    <input type='hidden' value='${file15.fileSize }' name='dataAttachmentList[3].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[3].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">公司章程</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file16.url }" title="${file16.oldName }" download="${file16.oldName }" id="file16_a"></a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file16" utype="16" uindex="4" uname="公司章程">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file16.id }' name='dataAttachmentList[4].id'/></c:if>
                                <div id="file16_div" >
                                    <input type='hidden' value='${file16.url }' name='dataAttachmentList[4].url'/>
                                    <input type='hidden' value='16' name='dataAttachmentList[4].type'/>
                                    <input type='hidden' value='${file16.remark }' name='dataAttachmentList[4].remark'/>
                                    <input type='hidden' value='${file16.oldName }' name='dataAttachmentList[4].oldName'/>
                                    <input type='hidden' value='${file16.newName }' name='dataAttachmentList[4].newName'/>
                                    <input type='hidden' value='${file16.extName }' name='dataAttachmentList[4].extName'/>
                                    <input type='hidden' value='${file16.fileSize }' name='dataAttachmentList[4].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[4].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">验资报告</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file17.url }" title="${file17.oldName }" download="${file17.oldName }" id="file17_a"></a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file17" utype="17" uindex="5" uname="验资报告">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file17.id }' name='dataAttachmentList[5].id'/></c:if>
                                <div id="file17_div" >
                                    <input type='hidden' value='${file17.url }' id='dataAttachmentList[5].url' name='dataAttachmentList[5].url'/>
                                    <input type='hidden' value='17' name='dataAttachmentList[5].type'/>
                                    <input type='hidden' value='${file17.remark }' name='dataAttachmentList[5].remark'/>
                                    <input type='hidden' value='${file17.oldName }' name='dataAttachmentList[5].oldName'/>
                                    <input type='hidden' value='${file17.newName }' name='dataAttachmentList[5].newName'/>
                                    <input type='hidden' value='${file17.extName }' name='dataAttachmentList[5].extName'/>
                                    <input type='hidden' value='${file17.fileSize }' name='dataAttachmentList[5].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[5].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">企业信用报告</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file18.url }" title="${file18.oldName }" download="${file18.oldName }" id="file18_a">${file18.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file18" utype="18" uindex="6" uname="企业信用报告">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file18.id }' name='dataAttachmentList[6].id'/></c:if>
                                <div id="file18_div" >
                                    <input type='hidden' value='${file18.url }' name='dataAttachmentList[6].url'/>
                                    <input type='hidden' value='18' name='dataAttachmentList[6].type'/>
                                    <input type='hidden' value='${file18.remark }' name='dataAttachmentList[6].remark'/>
                                    <input type='hidden' value='${file18.oldName }' name='dataAttachmentList[6].oldName'/>
                                    <input type='hidden' value='${file18.newName }' name='dataAttachmentList[6].newName'/>
                                    <input type='hidden' value='${file18.extName }' name='dataAttachmentList[6].extName'/>
                                    <input type='hidden' value='${file18.fileSize }' name='dataAttachmentList[6].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[6].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">公司股东介绍(包含实际控制人、股东关系、股权结构)</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file21.url }" title="${file21.oldName }" download="${file21.oldName }" id="file21_a">${file21.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file21" utype="21" uindex="7" uname="公司股东介绍(包含实际控制人、股东关系、股权结构)">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file21.id }' name='dataAttachmentList[7].id'/></c:if>
                                <div id="file21_div" >
                                    <input type='hidden' value='${file21.url }' name='dataAttachmentList[7].url'/>
                                    <input type='hidden' value='21' name='dataAttachmentList[7].type'/>
                                    <input type='hidden' value='${file21.remark }' name='dataAttachmentList[7].remark'/>
                                    <input type='hidden' value='${file21.oldName }' name='dataAttachmentList[7].oldName'/>
                                    <input type='hidden' value='${file21.newName }' name='dataAttachmentList[7].newName'/>
                                    <input type='hidden' value='${file21.extName }' name='dataAttachmentList[7].extName'/>
                                    <input type='hidden' value='${file21.fileSize }' name='dataAttachmentList[7].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[7].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">公司高管介绍(包含董事长、总经理、财务总监等)</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file22.url }" title="${file22.oldName }" download="${file22.oldName }" id="file22_a">${file22.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file22" utype="22" uindex="8" uname="公司高管介绍(包含董事长、总经理、财务总监等)">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file22.id }' name='dataAttachmentList[8].id'/></c:if>
                                <div id="file22_div" >
                                    <input type='hidden' value='${file22.url }' name='dataAttachmentList[8].url'/>
                                    <input type='hidden' value='22' name='dataAttachmentList[8].type'/>
                                    <input type='hidden' value='${file22.remark }' name='dataAttachmentList[8].remark'/>
                                    <input type='hidden' value='${file22.oldName }' name='dataAttachmentList[8].oldName'/>
                                    <input type='hidden' value='${file22.newName }' name='dataAttachmentList[8].newName'/>
                                    <input type='hidden' value='${file22.extName }' name='dataAttachmentList[8].extName'/>
                                    <input type='hidden' value='${file22.fileSize }' name='dataAttachmentList[8].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[8].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">公司业务介绍(说明公司的主要经营业务、营收情况等)</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file23.url }" title="${file23.oldName }" download="${file23.oldName }" id="file23_a">${file23.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file23" utype="23" uindex="9" uname="公司业务介绍(说明公司的主要经营业务、营收情况等)">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file23.id }' name='dataAttachmentList[9].id'/></c:if>
                                <div id="file23_div" >
                                    <input type='hidden' value='${file23.url }' name='dataAttachmentList[9].url'/>
                                    <input type='hidden' value='23' name='dataAttachmentList[9].type'/>
                                    <input type='hidden' value='${file23.remark }' name='dataAttachmentList[9].remark'/>
                                    <input type='hidden' value='${file23.oldName }' name='dataAttachmentList[9].oldName'/>
                                    <input type='hidden' value='${file23.newName }' name='dataAttachmentList[9].newName'/>
                                    <input type='hidden' value='${file23.extName }' name='dataAttachmentList[9].extName'/>
                                    <input type='hidden' value='${file23.fileSize }' name='dataAttachmentList[9].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[9].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>融资申请表</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file11.url }" title="${file11.oldName }" download="${file11.oldName }" id="file11_a">${file11.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file11" utype="11" uindex="10" uname="融资申请表">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file11.id }' name='dataAttachmentList[10].id'/></c:if>
                                <div id="file11_div" >
                                    <input type='hidden' value='${file11.url }' id="file_check_11" name='dataAttachmentList[10].url'/>
                                    <input type='hidden' value='11' name='dataAttachmentList[10].type'/>
                                    <input type='hidden' value='${file11.remark }' name='dataAttachmentList[10].remark'/>
                                    <input type='hidden' value='${file11.oldName }' name='dataAttachmentList[10].oldName'/>
                                    <input type='hidden' value='${file11.newName }' name='dataAttachmentList[10].newName'/>
                                    <input type='hidden' value='${file11.extName }' name='dataAttachmentList[10].extName'/>
                                    <input type='hidden' value='${file11.fileSize }' name='dataAttachmentList[10].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[10].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>应收账款总账及明细账</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file55.url }" title="${file55.oldName }" download="${file55.oldName }" id="file55_a">${file55.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file55" utype="55" uindex="11" uname="应收账款总账及明细账">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file55.id }' name='dataAttachmentList[11].id'/></c:if>
                                <div id="file55_div" >
                                    <input type='hidden' value='${file55.url }' id="file_check_55" name='dataAttachmentList[11].url'/>
                                    <input type='hidden' value='55' name='dataAttachmentList[11].type'/>
                                    <input type='hidden' value='${file55.remark }' name='dataAttachmentList[11].remark'/>
                                    <input type='hidden' value='${file55.oldName }' name='dataAttachmentList[11].oldName'/>
                                    <input type='hidden' value='${file55.newName }' name='dataAttachmentList[11].newName'/>
                                    <input type='hidden' value='${file55.extName }' name='dataAttachmentList[11].extName'/>
                                    <input type='hidden' value='${file55.fileSize }' name='dataAttachmentList[11].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[11].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">应付账款总账及明细账</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file56.url }" title="${file56.oldName }" download="${file56.oldName }" id="file56_a">${file56.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file56" utype="56"  uindex="12" uname="应付账款总账及明细账">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file56.id }' name='dataAttachmentList[12].id'/></c:if>
                                <div id="file56_div" >
                                    <input type='hidden' value='${file56.url }' name='dataAttachmentList[12].url'/>
                                    <input type='hidden' value='56' name='dataAttachmentList[12].type'/>
                                    <input type='hidden' value='${file56.remark }' name='dataAttachmentList[12].remark'/>
                                    <input type='hidden' value='${file56.oldName }' name='dataAttachmentList[12].oldName'/>
                                    <input type='hidden' value='${file56.newName }' name='dataAttachmentList[12].newName'/>
                                    <input type='hidden' value='${file56.extName }' name='dataAttachmentList[12].extName'/>
                                    <input type='hidden' value='${file56.fileSize }' name='dataAttachmentList[12].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[12].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">贷款卡、贷款卡查询授权</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file19.url }" title="${file19.oldName }" download="${file19.oldName }" id="file19_a">${file19.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file19" utype="19" uindex="13" uname="贷款卡、贷款卡查询授权">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file19.id }' name='dataAttachmentList[13].id'/></c:if>
                                <div id="file19_div" >
                                    <input type='hidden' value='${file19.url }' name='dataAttachmentList[13].url'/>
                                    <input type='hidden' value='19' name='dataAttachmentList[13].type'/>
                                    <input type='hidden' value='${file19.remark }' name='dataAttachmentList[13].remark'/>
                                    <input type='hidden' value='${file19.oldName }' name='dataAttachmentList[13].oldName'/>
                                    <input type='hidden' value='${file19.newName }' name='dataAttachmentList[13].newName'/>
                                    <input type='hidden' value='${file19.extName }' name='dataAttachmentList[13].extName'/>
                                    <input type='hidden' value='${file19.fileSize }' name='dataAttachmentList[13].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[13].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>租赁合同及近三个月缴费单据</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file20.url }" title="${file20.oldName }" download="${file20.oldName }" id="file20_a">${file20.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file20" utype="20" uindex="14" uname="租赁合同及近三个月缴费单据">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file20.id }' name='dataAttachmentList[14].id'/></c:if>
                                <div id="file20_div" >
                                    <input type='hidden' value='${file20.url }' id="file_check_20" name='dataAttachmentList[14].url'/>
                                    <input type='hidden' value='20' name='dataAttachmentList[14].type'/>
                                    <input type='hidden' value='${file20.remark }' name='dataAttachmentList[14].remark'/>
                                    <input type='hidden' value='${file20.oldName }' name='dataAttachmentList[14].oldName'/>
                                    <input type='hidden' value='${file20.newName }' name='dataAttachmentList[14].newName'/>
                                    <input type='hidden' value='${file20.extName }' name='dataAttachmentList[14].extName'/>
                                    <input type='hidden' value='${file20.fileSize }' name='dataAttachmentList[14].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[14].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>最近三年经审计的财务报告及最近六个月财务报表</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file24.url }" title="${file24.oldName }" download="${file24.oldName }" id="file24_a">${file24.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file24" utype="24" uindex="15" uname="最近三年经审计的财务报告及最近六个月财务报表">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file24.id }' name='dataAttachmentList[15].id'/></c:if>
                                <div id="file24_div" >
                                    <input type='hidden' value='${file24.url }' id="file_check_24" name='dataAttachmentList[15].url'/>
                                    <input type='hidden' value='24' name='dataAttachmentList[15].type'/>
                                    <input type='hidden' value='${file24.remark }' name='dataAttachmentList[15].remark'/>
                                    <input type='hidden' value='${file24.oldName }' name='dataAttachmentList[15].oldName'/>
                                    <input type='hidden' value='${file24.newName }' name='dataAttachmentList[15].newName'/>
                                    <input type='hidden' value='${file24.extName }' name='dataAttachmentList[15].extName'/>
                                    <input type='hidden' value='${file24.fileSize }' name='dataAttachmentList[15].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[15].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">银行授信及贷款明细</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file25.url }" title="${file25.oldName }" download="${file25.oldName }" id="file25_a">${file25.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file25" utype="25" uindex="16" uname="银行授信及贷款明细">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file25.id }' name='dataAttachmentList[16].id'/></c:if>
                                <div id="file25_div" >
                                    <input type='hidden' value='${file25.url }' name='dataAttachmentList[16].url'/>
                                    <input type='hidden' value='25' name='dataAttachmentList[16].type'/>
                                    <input type='hidden' value='${file25.remark }' name='dataAttachmentList[16].remark'/>
                                    <input type='hidden' value='${file25.oldName }' name='dataAttachmentList[16].oldName'/>
                                    <input type='hidden' value='${file25.newName }' name='dataAttachmentList[16].newName'/>
                                    <input type='hidden' value='${file25.extName }' name='dataAttachmentList[16].extName'/>
                                    <input type='hidden' value='${file25.fileSize }' name='dataAttachmentList[16].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[16].category'/>
                                </div>  
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">对外担保情况说明</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file26.url }" title="${file26.oldName }" download="${file26.oldName }" id="file26_a">${file26.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file26" utype="26" uindex="17" uname="对外担保情况说明">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file26.id }' name='dataAttachmentList[17].id'/></c:if>
                                <div id="file26_div" >
                                    <input type='hidden' value='${file26.url }' name='dataAttachmentList[17].url'/>
                                    <input type='hidden' value='26' name='dataAttachmentList[17].type'/>
                                    <input type='hidden' value='${file26.remark }' name='dataAttachmentList[17].remark'/>
                                    <input type='hidden' value='${file26.oldName }' name='dataAttachmentList[17].oldName'/>
                                    <input type='hidden' value='${file26.newName }' name='dataAttachmentList[17].newName'/>
                                    <input type='hidden' value='${file26.extName }' name='dataAttachmentList[17].extName'/>
                                    <input type='hidden' value='${file26.fileSize }' name='dataAttachmentList[17].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[17].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>近一年的银行账户流水</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file27.url }" title="${file27.oldName }" download="${file27.oldName }" id="file27_a">${file27.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file27" utype="27" uindex="18" uname="近一年的银行账户流水">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file27.id }' name='dataAttachmentList[18].id'/></c:if>
                                <div id="file27_div" >
                                    <input type='hidden' value='${file27.url }' id="file_check_27" name='dataAttachmentList[18].url'/>
                                    <input type='hidden' value='27' name='dataAttachmentList[18].type'/>
                                    <input type='hidden' value='${file27.remark }' name='dataAttachmentList[18].remark'/>
                                    <input type='hidden' value='${file27.oldName }' name='dataAttachmentList[18].oldName'/>
                                    <input type='hidden' value='${file27.newName }' name='dataAttachmentList[18].newName'/>
                                    <input type='hidden' value='${file27.extName }' name='dataAttachmentList[18].extName'/>
                                    <input type='hidden' value='${file27.fileSize }' name='dataAttachmentList[18].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[18].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>近六个月的增值纳税申报表</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file28.url }" title="${file28.oldName }" download="${file28.oldName }" id="file28_a">${file28.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file28" utype="28"  uindex="19" uname="近六个月的增值纳税申报表">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file28.id }' name='dataAttachmentList[19].id'/></c:if>
                                <div id="file28_div" >
                                    <input type='hidden' value='${file28.url }' id="file_check_28" name='dataAttachmentList[19].url'/>
                                    <input type='hidden' value='28' name='dataAttachmentList[19].type'/>
                                    <input type='hidden' value='${file28.remark }' name='dataAttachmentList[19].remark'/>
                                    <input type='hidden' value='${file28.oldName }' name='dataAttachmentList[19].oldName'/>
                                    <input type='hidden' value='${file28.newName }' name='dataAttachmentList[19].newName'/>
                                    <input type='hidden' value='${file28.extName }' name='dataAttachmentList[19].extName'/>
                                    <input type='hidden' value='${file28.fileSize }' name='dataAttachmentList[19].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[19].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>购销合同</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file29.url }" title="${file29.oldName }" download="${file29.oldName }" id="file29_a">${file29.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file29" utype="29"  uindex="20" uname="购销合同">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file29.id }' name='dataAttachmentList[20].id'/></c:if>
                                <div id="file29_div" >
                                    <input type='hidden' value='${file29.url }' id="file_check_29" name='dataAttachmentList[20].url'/>
                                    <input type='hidden' value='29' name='dataAttachmentList[20].type'/>
                                    <input type='hidden' value='${file29.remark }' name='dataAttachmentList[20].remark'/>
                                    <input type='hidden' value='${file29.oldName }' name='dataAttachmentList[20].oldName'/>
                                    <input type='hidden' value='${file29.newName }' name='dataAttachmentList[20].newName'/>
                                    <input type='hidden' value='${file29.extName }' name='dataAttachmentList[20].extName'/>
                                    <input type='hidden' value='${file29.fileSize }' name='dataAttachmentList[20].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[20].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>销售发票(含清单)</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file30.url }" title="${file30.oldName }" download="${file30.oldName }" id="file30_a">${file30.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file30" utype="30"  uindex="21" uname="销售发票(含清单)">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file30.id }' name='dataAttachmentList[21].id'/></c:if>
                                <div id="file30_div" >
                                    <input type='hidden' value='${file30.url }' id="file_check_30" name='dataAttachmentList[21].url'/>
                                    <input type='hidden' value='30' name='dataAttachmentList[21].type'/>
                                    <input type='hidden' value='${file30.remark }' name='dataAttachmentList[21].remark'/>
                                    <input type='hidden' value='${file30.oldName }' name='dataAttachmentList[21].oldName'/>
                                    <input type='hidden' value='${file30.newName }' name='dataAttachmentList[21].newName'/>
                                    <input type='hidden' value='${file30.extName }' name='dataAttachmentList[21].extName'/>
                                    <input type='hidden' value='${file30.fileSize }' name='dataAttachmentList[21].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[21].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200"><i class="red-color-font">*</i>采购订单、出入库清单、库存清单</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file31.url }" title="${file31.oldName }" download="${file31.oldName }" id="file31_a">${file31.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file31" utype="31"  uindex="22" uname="采购订单、出入库清单、库存清单">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file31.id }' name='dataAttachmentList[22].id'/></c:if>
                                <div id="file31_div" >
                                    <input type='hidden' value='${file31.url }' id="file_check_31" name='dataAttachmentList[22].url'/>
                                    <input type='hidden' value='31' name='dataAttachmentList[22].type'/>
                                    <input type='hidden' value='${file31.remark }' name='dataAttachmentList[22].remark'/>
                                    <input type='hidden' value='${file31.oldName }' name='dataAttachmentList[22].oldName'/>
                                    <input type='hidden' value='${file31.newName }' name='dataAttachmentList[22].newName'/>
                                    <input type='hidden' value='${file31.extName }' name='dataAttachmentList[22].extName'/>
                                    <input type='hidden' value='${file31.fileSize }' name='dataAttachmentList[22].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[22].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">其他与融资相关的重要材料</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file32.url }" title="${file32.oldName }" download="${file32.oldName }" id="file32_a">${file32.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file32" utype="32"  uindex="23" uname="其他与融资相关的重要材料">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file32.id }' name='dataAttachmentList[23].id'/></c:if>
                                <div id="file32_div" >
                                    <input type='hidden' value='${file32.url }' name='dataAttachmentList[23].url'/>
                                    <input type='hidden' value='32' name='dataAttachmentList[23].type'/>
                                    <input type='hidden' value='${file32.remark }' name='dataAttachmentList[23].remark'/>
                                    <input type='hidden' value='${file32.oldName }' name='dataAttachmentList[23].oldName'/>
                                    <input type='hidden' value='${file32.newName }' name='dataAttachmentList[23].newName'/>
                                    <input type='hidden' value='${file32.extName }' name='dataAttachmentList[23].extName'/>
                                    <input type='hidden' value='${file32.fileSize }' name='dataAttachmentList[23].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[23].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                        <tr>
                            <td class="maxwidth200">其他补充资料</td>
                            <td class="maxwidth200">原件、复印件、加盖公章、提供扫描件</td>
                            <td class="maxwidth200"><a href="${file33.url }" title="${file33.oldName }" download="${file33.oldName }" id="file33_a">${file33.oldName }</a></td>
                            <c:if test="${operType ne 'query' }"><td>
                                <a href="javascript:;" class="btn-modify upload-file" id="file33" utype="33"  uindex="24" uname="其他补充资料">上传</a>
                                <c:if test="${operType ne 'insert' }"><input type='hidden' value='${file33.id }' name='dataAttachmentList[24].id'/></c:if>
                                <div id="file33_div" >
                                    <input type='hidden' value='${file33.url }' name='dataAttachmentList[24].url'/>
                                    <input type='hidden' value='33' name='dataAttachmentList[24].type'/>
                                    <input type='hidden' value='${file33.remark }' name='dataAttachmentList[24].remark'/>
                                    <input type='hidden' value='${file33.oldName }' name='dataAttachmentList[24].oldName'/>
                                    <input type='hidden' value='${file33.newName }' name='dataAttachmentList[24].newName'/>
                                    <input type='hidden' value='${file33.extName }' name='dataAttachmentList[24].extName'/>
                                    <input type='hidden' value='${file33.fileSize }' name='dataAttachmentList[24].fileSize'/>
                                    <input type='hidden' value='12' name='dataAttachmentList[24].category'/>
                                </div>      
                            </td></c:if>
                        </tr>
                    </table>
            </div>
                
            <div class="bottom-line"></div>
                    
            <div class="shenmin"></div>
            </div>
        </div>
        <c:if test="${not empty subid and subid ne 0}">
            <div class="w1200 ybl-info box box3">
                <div class="pd20">
                    <p class="protitle"><span>补充资料明细</span></p>
                    <c:if test="${operType ne 'query' }">
                        <div class="clearfix mb20"><a class="btn-modify fr" onclick="fileAdd()">添加行</a></div>
                    </c:if>
                    <div class="tabD">
                        <table id="fileTb">
                            <tr class="fileTr">
                                <th>序号</th>
                                <th>附件</th>
                                <th>简要说明</th>
                                <th>操作</th>
                            </tr>
                            <tr class="addFile">
                                <td>1</td>
                                <td class="maxwidth200"><a href="${rejectList[0].url }" title="${rejectList[0].oldName }" download="${rejectList[0].oldName }" id="reject0_a">${rejectList[0].oldName }</a></td>
                                <td class="maxwidth200"><input type="text" class="tdinput" value="${rejectList[0].remark }" name="rejectList[0].remark"/></td>
                                <td>
                                    <a href="javascript:;" class="btn-modify upload-file-reject" id="reject0" uindex="0" utype="34">上传</a>
                                    <c:if test="${operType ne 'query' }"><a href="javascript:;" class="btn-modify delete-one" onclick="fileDeleteRow(this,${rejectList[0].id})">删除</a></c:if>
                                    <input type='hidden' value='${rejectList[0].id }' name='rejectList[0].id'/>
                                    <div id="reject0_div" >
                                        <input type='hidden' value='${rejectList[0].url }' name='rejectList[0].url'/>
                                        <input type='hidden' value='34' name='rejectList[0].type'/>
                                        <input type='hidden' value='${rejectList[0].oldName }' name='rejectList[0].oldName'/>
                                        <input type='hidden' value='${rejectList[0].newName }' name='rejectList[0].newName'/>
                                        <input type='hidden' value='${rejectList[0].extName }' name='rejectList[0].extName'/>
                                        <input type='hidden' value='${rejectList[0].fileSize }' name='rejectList[0].fileSize'/>
                                        <input type='hidden' value='12' name='rejectList[0].category'/>
                                    </div>  
                                </td>
                            </tr>
                            <c:forEach items="${rejectList}" begin="1" varStatus="index" var="obj">
                                <tr class="addFile">
                                    <td>${index.count+1 }<input type="hidden" value="${obj.id }" name="rejectList[${index.count }].id" /></td>
                                    <td class="maxwidth200"><a href="${obj.url }" title="${obj.oldName }" download="${obj.oldName }" id="reject${index.count }_a">${obj.oldName }</a></td>
                                    <td class="maxwidth200"><input type="text" class="tdinput" value="${obj.remark }" /></td>
                                    <td>
                                        <a href="javascript:;" class="btn-modify upload-file-reject" id="reject${index.count }" utype="34">上传</a>
                                        <c:if test="${operType ne 'query' }"><a href="javascript:;" class="btn-modify delete-one" onclick="fileDeleteRow(this,${obj.id})">删除</a></c:if>
                                        <input type='hidden' value='${obj.id }' name='rejectList[0].id'/>
                                        <div id="reject${index.count }_div" >
                                            <input type='hidden' value='${obj.url }' name='rejectList[${index.count }].url'/>
                                            <input type='hidden' value='34' name='rejectList[${index.count }].type'/>
                                            <input type='hidden' value='${obj.oldName }' name='rejectList[${index.count }].oldName'/>
                                            <input type='hidden' value='${obj.newName }' name='rejectList[${index.count }].newName'/>
                                            <input type='hidden' value='${obj.extName }' name='rejectList[${index.count }].extName'/>
                                            <input type='hidden' value='${obj.fileSize }' name='rejectList[${index.count }].fileSize'/>
                                            <input type='hidden' value='12' name='rejectList[${index.count }].category'/>
                                        </div>  
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                </div>
                <p class="protitle"><span>备注说明</span></p>
                <div class="pd20">
                    备注说明:<textarea class="protext" name="ruject_remark">${subFinancingApply.ruject_remark }</textarea>
                </div>
                <div class="bottom-line"></div>
                        
                <div class="shenmin"></div>
                
               <%--  <c:if test="${operType == 'query' }">
                    <div class="btn1 clearfix mb80 mt20">
                    <a href="javascript:history.go(-1);" class="btn-add btn-center">返回</a>
                    </div>
                </c:if> --%>
            </div>
            </div>
        </c:if>
        </form>
        <script type="text/javascript" src="/ybl4.0/resources/js/validate-for-apply/jquery.validationEngine.js"></script>
        <script>
            
	        // 根据融资方式默认隐藏表单
            var val = $("#financingMode").find('option:selected').attr('value');
            if (val == 1) {
                $("#bidDate").hide();
                $("#factorySelect").show();
                $("#zfname").show();
            } else if (val == 2) {
                $("#bidDate").hide();
                $("#factorySelect").hide();
                $("#zfname").hide();
            } else if (val == 3) {
                $("#bidDate").show();
                $("#factorySelect").hide();
                $("#zfname").hide();
            }
            
            // 加载
            $(function(){
                var subid = $("#subid").val();
                var operType = $("#operType").val();
                if (subid != '' && subid != '0') {
                    $(".box1").hide();
                    $(".box3").show();
                }
                // 加载数据
                var businessId = $("#businessId").val();
                var financingApplyId = $("#financingApplyId").val();
                // 加载股东列表
                $.ajax({
                    url:"/financingApplyV4Controller/financingApply/loadStockHolderList",
                    dataType:"json",
                    data:{"businessId":businessId},
                    success:function(data,status){
                        if (data.responseType == "SUCCESS") {
                            // 成功加载
                            var list = data.object;
                            if (list.length > 0) {
                                $("#stockTr").remove();
                                for (var i in list) {
                                    var stockObj = list[i];                                     
                                    var html = "<tr>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.name+" /></td>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.investment_ratio+" /></td>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.investment_mode+" /></td>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.legal_name+" /></td>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.investment_amount.toFixed(2)+" /></td>";
                                    html += "<td><input class='tdinput' type='text' readonly value="+stockObj.received_amount.toFixed(2)+" /></td>";
                                    if (typeof(stockObj.register_date)=="undefined") {
                                        html += "<td><input class='tdinput' type='text' readonly /></td>";
                                    } else {
                                        html += "<td><input class='tdinput' type='text' readonly value="+stockObj.register_date+" /></td>";
                                    }
                                    html += "</tr>";
                                    $("#stockTab").append(html);
                                }
                            }
                        } else {
                            alert("加载股东列表信息错误");
                        }
                    },
                    error:function(){
                        alert("加载股东列表信息异常");
                    }
                });
                if (operType != "insert") {
                    // 加载申请人信息
                    $.ajax({
                        url:"/financingApplyV4Controller/financingApply/loadBusinessAuth",
                        dataType:"json",
                        data:{"businessId":businessId},
                        success:function(data,status){
                            if (data.responseType == "SUCCESS") {
                                // 赋值
                                $("#enterpriseNameForBusiness").val(data.object.enterprise_name);
                                $("#industry").val(data.object.industry);
                                $("#registerAddress").val(data.object.register_address);
                                $("#registerDate").val(data.object.register_date);
                                $("#registerCapital").val(data.object.register_capital.toFixed(2));
                                $("#paidCapital").val(data.object.paid_capital.toFixed(2));
                                $("#officeAddress").val(data.object.office_address);
                                $("#socialCreditCode").val(data.object.social_credit_code);
                                $("#annualSurveySituation").val(data.object.annual_survey_situation);
                                $("#contacts").val(data.object.contacts);
                                $("#contactsPhone").val(data.object.contacts_phone);
                                $("#contactsEmail").val(data.object.contacts_email);
                                $("#controllerName").val(data.object.controller_name);
                                $("#controllerGender").val(data.object.controller_gender);
                                $("#controllerNationality").val(data.object.controller_nationality);
                                $("#controllerCardId").val(data.object.controller_card_id);
                                $("#controllerAge").val(data.object.controller_age);
                                $("#controllerWorkYear").val(data.object.controller_work_year);
                                $("#controllerOfficePhone").val(data.object.controller_office_phone);
                                $("#controllerMaritalStatus").val(data.object.controller_marital_status);
                                $("#controllerHomeAddress").val(data.object.controller_home_address);
                                $("#legalName").val(data.object.legal_name);
                                $("#legalGender").val(data.object.legal_gender);
                                $("#legalNationality").val(data.object.legal_nationality);
                                $("#legalCardId").val(data.object.legal_card_id);
                                $("#legalAge").val(data.object.legal_age);
                                $("#legalWorkYear").val(data.object.legal_work_year);
                                $("#legalOfficePhone").val(data.object.legal_office_phone);
                                $("#legalMaritalStatus").val(data.object.legal_marital_status);
                                $("#legalHomeAddress").val(data.object.legal_home_address);
                                $("#businessScope").val(data.object.business_scope);
                                $("#history").val(data.object.history);
                            } else {
                                alert("加载申请人信息错误");
                            }
                        },
                        error:function(){
                            alert("加载申请人信息异常");
                        }
                    });
                    
                    //加载申请人财务情况
                    $.ajax({
                        url:"/financingApplyV4Controller/financingApply/loadApplicantFinancial",
                        dataType:"json",
                        data:{"id":financingApplyId},
                        success:function(data,status){
                            if (data.responseType == "SUCCESS") {
                            	// 成功加载
                            	$("#financialSituationId").val(data.object.id_);
                                $("#totalAssetsNewest").val(data.object.total_assets_newest.toFixed(2));
                                $("#totalAssetsN1").val(data.object.total_assets_n1.toFixed(2));
                                $("#totalAssetsN2").val(data.object.total_assets_n2.toFixed(2));
                                $("#totalDebtsNewest").val(data.object.total_debts_newest.toFixed(2));
                                $("#totalDebtsN1").val(data.object.total_debts_n1.toFixed(2));
                                $("#totalDebtsN2").val(data.object.total_debts_n2.toFixed(2));
                                $("#ownerEquityNewest").val(data.object.owner_equity_newest.toFixed(2));
                                $("#ownerEquityN1").val(data.object.owner_equity_n1.toFixed(2));
                                $("#ownerEquityN2").val(data.object.owner_equity_n2.toFixed(2));
                                $("#businessIncomeNewest").val(data.object.business_income_newest.toFixed(2));
                                $("#businessIncomeN1").val(data.object.business_income_n1.toFixed(2));
                                $("#businessIncomeN2").val(data.object.business_income_n2.toFixed(2));
                                $("#businessCostNewest").val(data.object.business_cost_newest.toFixed(2));
                                $("#businessCostN1").val(data.object.business_cost_n1.toFixed(2));
                                $("#businessCostN2").val(data.object.business_cost_n2.toFixed(2));
                                $("#businessProfitNewest").val(data.object.business_profit_newest.toFixed(2));
                                $("#businessProfitN1").val(data.object.business_profit_n1.toFixed(2));
                                $("#businessProfitN2").val(data.object.business_profit_n2.toFixed(2));
                                $("#profitAmountNewest").val(data.object.profit_amount_newest.toFixed(2));
                                $("#profitAmountN1").val(data.object.profit_amount_n1.toFixed(2));
                                $("#profitAmountN2").val(data.object.profit_amount_n2.toFixed(2));
                                $("#netProfitNewest").val(data.object.net_profit_newest.toFixed(2));
                                $("#netProfitN1").val(data.object.net_profit_n1.toFixed(2));
                                $("#netProfitN2").val(data.object.net_profit_n2.toFixed(2));
                                $("#cashFlowNewest").val(data.object.cash_flow_newest.toFixed(2));
                                $("#cashFlowN1").val(data.object.cash_flow_n1.toFixed(2));
                                $("#cashFlowN2").val(data.object.cash_flow_n2.toFixed(2));
                            } else {
                                alert("加载申请人财务情况错误");
                            }
                        },
                        error:function(){
                            alert("加载申请人财务情况异常");
                        }
                    });
                    
                    // 加载企业借款和个人负债
                    $.ajax({
                        url:"/financingApplyV4Controller/financingApply/loadLoanDebtSituationList",
                        dataType:"json",
                        data:{"id":financingApplyId},
                        success:function(data,status){
                            if (data.responseType == "SUCCESS") {
                                // 成功加载
                                var enterpriseLoanList = data.object.enterpriseLoanList;
                                var personDebtList = data.object.personDebtList;
                                if (enterpriseLoanList.length > 0) {
                                    $("#enterpriseLoanFirst").remove();
                                    for (var i in enterpriseLoanList) {
                                        var enterpriseLoan = enterpriseLoanList[i];
                                        var html = "<tr class='addEnterpriseLoan'>";
                                        html += "<input type='hidden' value='"+enterpriseLoan.id_+"' name='enterpriseLoanList["+i+"].id' />";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+enterpriseLoan.loan_amount.toFixed(2)+"' name='enterpriseLoanList["+i+"].loanAmount'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+enterpriseLoan.term+"' name='enterpriseLoanList["+i+"].term'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+enterpriseLoan.creditor+"' name='enterpriseLoanList["+i+"].creditor'/></td>";
                                        if (typeof(enterpriseLoan.loan_date)=="undefined") {
                                            html += "<td><input class='tdinput selectDate' type='text' name='enterpriseLoanList["+i+"].loanDate'/></td>";
                                        } else {
                                            html += "<td><input class='tdinput selectDate' type='text' value='"+enterpriseLoan.loan_date+"' name='enterpriseLoanList["+i+"].loanDate'/></td>";
                                        }
                                        if (typeof(enterpriseLoan.expire_date)=="undefined") {
                                        	html += "<td><input class='tdinput selectDate' type='text' name='enterpriseLoanList["+i+"].expireDate'/></td>";
                                        } else {
                                        	html += "<td><input class='tdinput selectDate' type='text' value='"+enterpriseLoan.expire_date+"' name='enterpriseLoanList["+i+"].expireDate'/></td>";
                                        }
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+enterpriseLoan.balance.toFixed(2)+"' name='enterpriseLoanList["+i+"].balance'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+enterpriseLoan.remark+"' name='enterpriseLoanList["+i+"].remark'/></td>";
                                        if (operType == "update") {
	                                        html += "<td><a class='btn-modify' onclick='enterpriseLoanDeleteRow(this,"+enterpriseLoan.id_+")'>删除</a><input type='hidden' value='1' name='enterpriseLoanList["+i+"].type' /></td>";
                                        }
                                        html += "</tr>";
                                        $("#enterpriseLoanTb").append(html);
                                    }
                                }
                                if (personDebtList.length > 0) {
                                    $("#personDebtFirst").remove();
                                    for (var i in personDebtList) {
                                        var personDebt = personDebtList[i];                                     
                                        var html = "<tr class='addPersonDebt'>";
                                        html += "<input type='hidden' value='"+personDebt.id_+"' name='personDebtList["+i+"].id' />";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+personDebt.loan_amount.toFixed(2)+"' name='personDebtList["+i+"].loanAmount'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+personDebt.term+"' name='personDebtList["+i+"].term'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+personDebt.creditor+"' name='personDebtList["+i+"].creditor'/></td>";
                                        if (typeof(personDebt.loan_date)=="undefined") {
                                        	html += "<td><input class='tdinput selectDate' type='text' name='personDebtList["+i+"].loanDate'/></td>";
                                        } else {
                                        	html += "<td><input class='tdinput selectDate' type='text' value='"+personDebt.loan_date+"' name='personDebtList["+i+"].loanDate'/></td>";
                                        }
                                        if (typeof(personDebt.expire_date)=="undefined") {
                                        	html += "<td><input class='tdinput selectDate' type='text' name='personDebtList["+i+"].expireDate'/></td>";
                                        } else {
                                        	html += "<td><input class='tdinput selectDate' type='text' value='"+personDebt.expire_date+"' name='personDebtList["+i+"].expireDate'/></td>";
                                        }
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+personDebt.balance.toFixed(2)+"' name='personDebtList["+i+"].balance'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+personDebt.remark+"' name='personDebtList["+i+"].remark'/></td>";
                                        if (operType == "update") {
                                            html += "<td><a class='btn-modify' onclick='personDebtDeleteRow(this,"+personDebt.id_+")'>删除</a><input type='hidden' value='2' name='personDebtList["+i+"].type' /></td>";
                                        }
                                        html += "</tr>";
                                        $("#personDebtTb").append(html);
                                    }
                                }
                                // 再次调用时间控件给新增行
                                $('.selectDate').datetimepicker({
                                    yearOffset: 0,
                                    lang: 'ch',
                                    timepicker: false,
                                    format: 'Y-m-d',
                                    formatDate: 'Y-m-d',
                                    minDate: '1970-01-01', // yesterday is minimum date
                                    maxDate: '2099-12-31' // and tommorow is maximum date calendar
                                });
                                // 再次设为只读
                                if (operType == "query" || (subid != '' && subid != '0')) {
                                    $(".box1").find("input").attr("readonly","readonly");
                                    $(".box1").find("textarea").attr("readonly","readonly");
                                    $(".box1").find("select").attr("readonly","readonly");
                                    $(".box1").find("img").attr("readonly","readonly");
                                    $(".box1").find("a").attr("readonly","readonly");
                                    $(".box2").find("input").attr("readonly","readonly");
                                    $(".box2").find("textarea").attr("readonly","readonly");
                                    $(".box2").find("select").attr("readonly","readonly");
                                    $(".box2").find("img").attr("readonly","readonly");
                                    $(".box2").find("a").attr("readonly","readonly");
                                }
                                if (operType == "query" && subid != '' && subid != '0') {
                                    $(".box3").find("input").attr("readonly","readonly");
                                    $(".box3").find("textarea").attr("readonly","readonly");
                                    $(".box3").find("select").attr("readonly","readonly");
                                    $(".box3").find("img").attr("readonly","readonly");
                                    $(".box3").find("a").attr("readonly","readonly");
                                }
                            } else {
                                alert("加载企业借款和个人负债错误");
                            }
                        },
                        error:function(){
                            alert("加载企业借款和个人负债异常");
                        }
                    }); 
                    
                 // 加载对外担保情况列表
                    $.ajax({
                        url:"/financingApplyV4Controller/financingApply/loadExternalGuaranteeSituation",
                        dataType:"json",
                        data:{"id":financingApplyId},
                        success:function(data,status){
                            if (data.responseType == "SUCCESS") {
                                // 成功加载
                                var externalGuaranteeList = data.object;
                                if (externalGuaranteeList.length > 0) {
                                    $("#guaranteeFirst").remove();
                                    for (var i in externalGuaranteeList) {
                                        var externalGuarantee = externalGuaranteeList[i];
                                        var html = "<tr class='addGuarantee'>";
                                        html += "<input type='hidden' value='"+externalGuarantee.id_+"' name='guaranteeList["+i+"].id' />";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+externalGuarantee.guarantee_amount.toFixed(2)+"' name='guaranteeList["+i+"].guaranteeAmount'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+externalGuarantee.term+"' name='guaranteeList["+i+"].term'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+externalGuarantee.guarantor+"' name='guaranteeList["+i+"].guarantor'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[10]]' type='text' value='"+externalGuarantee.guarantee_mode+"' name='guaranteeList["+i+"].guaranteeMode'/></td>";
                                        if (typeof(externalGuarantee.expire_date)=="undefined") {
                                            html += "<td><input class='tdinput selectDate' type='text' name='guaranteeList["+i+"].expireDate'/></td>";
                                        } else {
                                            html += "<td><input class='tdinput selectDate' type='text' value='"+externalGuarantee.expire_date+"' name='guaranteeList["+i+"].expireDate'/></td>";
                                        }
                                        html += "<td><input class='tdinput validate[maxSize[20],custom[number],min[0]]' type='text' value='"+externalGuarantee.balance.toFixed(2)+"' name='guaranteeList["+i+"].balance'/></td>";
                                        html += "<td><input class='tdinput validate[maxSize[20]]' type='text' value='"+externalGuarantee.remark+"' name='guaranteeList["+i+"].remark'/></td>";
                                        if (operType == "update") {
                                            html += "<td><a class='btn-modify' onclick='guaranteeDeleteRow(this,"+externalGuarantee.id_+")'>删除</a></td>";
                                        }
                                        html += "</tr>";
                                        $("#guaranteeTb").append(html);
                                    }
                                }
                                // 再次调用时间控件给新增行
                                $('.selectDate').datetimepicker({
                                    yearOffset: 0,
                                    lang: 'ch',
                                    timepicker: false,
                                    format: 'Y-m-d',
                                    formatDate: 'Y-m-d',
                                    minDate: '1970-01-01', // yesterday is minimum date
                                    maxDate: '2099-12-31' // and tommorow is maximum date calendar
                                });
                                // 再次设为只读
                                if (operType == "query" || (subid != '' && subid != '0')) {
                                    $(".box1").find("input").attr("readonly","readonly");
                                    $(".box1").find("textarea").attr("readonly","readonly");
                                    $(".box1").find("select").attr("readonly","readonly");
                                    $(".box1").find("img").attr("readonly","readonly");
                                    $(".box1").find("a").attr("readonly","readonly");
                                    $(".box2").find("input").attr("readonly","readonly");
                                    $(".box2").find("textarea").attr("readonly","readonly");
                                    $(".box2").find("select").attr("readonly","readonly");
                                    $(".box2").find("img").attr("readonly","readonly");
                                    $(".box2").find("a").attr("readonly","readonly");
                                }
                                if (operType == "query" && subid != '' && subid != '0') {
                                    $(".box3").find("input").attr("readonly","readonly");
                                    $(".box3").find("textarea").attr("readonly","readonly");
                                    $(".box3").find("select").attr("readonly","readonly");
                                    $(".box3").find("img").attr("readonly","readonly");
                                    $(".box3").find("a").attr("readonly","readonly");
                                }
                            } else {
                                alert("加载对外担保情况列表错误");
                            }
                        },
                        error:function(){
                            alert("加载对外担保情况列表异常");
                        }
                    }); 
                } 
                if (operType == "query" || (subid != '' && subid != '0')) {
                    $(".box1").find("input").attr("readonly","readonly");
                    $(".box1").find("textarea").attr("readonly","readonly");
                    $(".box1").find("select").attr("disabled","disabled");
                    $(".box1").find("img").attr("disabled","disabled");
                    $(".box1").find("a").attr("disabled","disabled");
                    $(".box2").find("input").attr("readonly","readonly");
                    $(".box2").find("textarea").attr("readonly","readonly");
                    $(".box2").find("select").attr("disabled","disabled");
                    $(".box2").find("img").attr("disabled","disabled");
                    $(".box2").find("a").attr("disabled","disabled");
                }
                if (operType == "query" && subid != '' && subid != '0') {
                    $(".box3").find("input").attr("readonly","readonly");
                    $(".box3").find("textarea").attr("readonly","readonly");
                    $(".box3").find("select").attr("disabled","disabled");
                    $(".box3").find("img").attr("disabled","disabled");
                    $(".box3").find("a").attr("disabled","disabled");
                }
                
            }); 
            
            
            
            
            
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
            
           
            
           
            
           
        </script>
    </body>

</html>