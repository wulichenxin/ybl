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
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待资方终审<span class="mr10 ml10"></span></div>
		</div>
		
			<div class="w1200">
				<ul class="clearfix iconul">
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/financingApplyDetail.htm');"><div class="proicon bg1 statusTwo"></div>项目详情</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<c:if test="${auditType == 1}">
						<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateAuditHistory.htm');"><div class="proicon bg3 statusThree"></div>资方初审</li>
						<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
						<li class="iconlist" url="/"><div class="proicon bg4 statusOne"></div>选择意向资方</li>
						<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
						<li class="iconlist" url="/"><div class="proicon bg5 statusOne"></div>资方终审</li>
					</c:if>
					<c:if test="${auditType == 2}">
						<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/firstAuditDetail.htm');"><div class="proicon bg3 statusTwo"></div>资方初审</li>
						<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
						<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/intentionalCapitalDetail.htm');" url="/IntegratedQueryController/tab4?id=${id}"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
						<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
						<li class="iconlist pro_li_cur" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateFinalAuditHistory.htm');"><div class="proicon bg5 statusThree"></div>资方终审</li>
					</c:if>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg6 statusOne"></div>合作资方</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg7 statusOne"></div>平台复审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg8 statusOne"></div>签署主合同</li>
				</ul>	
			</div>
		
			<div class="w1200 clearfix border-b">
				<ul class="clearfix formul">
					<li class="formli form_cur">终审意见表</li>
					<li class="formli">合作要素表</li>
				</ul>
			</div>
			
			<form action="" id="subPageForm" method="post">
			<input type="hidden" name="audithistory.subFinancingApplyId" value="${subFinancingApplyId }"/>
			<div class="w1200 ybl-info box box1">
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label class="label-long">融资企业：</label><input class="content-form2 validate[required,minSize[2],maxSize[25]]" name="audithistory.financingEnterprise"/></div>
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label class="label-long">融资金额：</label><input class="content-form2 validate[required,min[1],maxSize[28],custom[number]]" name="audithistory.financingAmount"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long">融资期限：</label><input class="content-form validate[required,minSize[1],maxSize[4],min[1],custom[integer]]" name="audithistory.financingTerm"/><input type="hidden" class="content-form" name="audithistory.financingTermUnit" value="1"/><span class="timeimg">天</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label class="label-long">收费方式：</label><select class="content-form2 sffs" name="audithistory.feeMode"><option value="1">融资利率</option>
							<option value="2">服务费</option>
							<option value="3">折后转让</option>
						</select></div>
						<div id="audithistoryFinancingRate" class="form-grou mr50"><strong style="color: red;">*</strong><label class="sffs-label label-long">融资利率：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],max[100],custom[number]]" name="audithistory.financingRate"/><span class="timeimg">%</span></div>
						<div id="audithistoryServiceFee" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label label-long">服务费：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[1],custom[number]]" name="audithistory.serviceFee"/><span class="timeimg">元</span></div>
						<div id="audithistoryTransferMoney" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label label-long">折后转让：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[1],custom[number]]" name="audithistory.transferMoney"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long">意见编号：</label><input class="content-form validate[required,minSize[1],maxSize[25]]" name="audithistory.opinionNumber"/></div>
					</div>
				</div>
			
				<div class="process">
					<p class="protitle"><span>融资说明</span></p>
					<div class="pd20">
						<strong style="color: red;">*</strong>融资说明：<textarea class="protext validate[required,maxSize[127]]" name="audithistory.financingExplain"></textarea>
					</div>	
					<p class="protitle"><span>交易结构</span></p>
					<div class="pd20">
						<strong style="color: red;">*</strong>交易结构：<textarea class="protext validate[required,maxSize[127]]" name="audithistory.transactionStructure"></textarea>
					</div>	
					<p class="protitle"><span>增信措施</span></p>
					<div class="pd20">
						<strong style="color: red;">*</strong>增信措施：<textarea class="protext validate[required,maxSize[127]]" name="audithistory.trustMeasure"></textarea>
					</div>	
					<p class="protitle"><span>审核意见</span></p>
					<div class="pd20">
						<strong style="color: red;">*</strong>审核意见：<textarea class="protext validate[required,maxSize[127]]" name="audithistory.auditOpinion"></textarea>
					</div>	
					<div class="pd20">
						<strong style="color: red;">*</strong><div class="form-grou mr50  mt20 mb20"><label style="width:70px">日期：</label><input class="content-form2 validate[required,custom[date]]" name="audithistoryAuditDateStr"/>
					</div>	
					
					<%--<p class="protitle" style="display: none;"><span></span>上传终审意见表</p>
					
					 <div class="pd20">
						<div id='licensePhoto'>
							<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
						</div>
						<div id='licensePhoto_div'></div>
					</div> --%>
					<a href="javascript:;" class="btn-add btn-center mb80" id="downPage">下一页</a>
					<p class="protitle"><span>历史审核记录</span></p>
					<div class="tabD">
						<table>
							<tr>
								<th>序号</th>
								<th>提交类型</th>
								<th>审核结果</th>
								<th>审核时间</th>
								<th>审核人</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${page.records}" var="obj" varStatus="index">
								<tr>
									<td>${index.count}</td>
									<td>
										<c:if test="${obj.auditType == 1}">资方风控初审</c:if>
										<c:if test="${obj.auditType == 2}">资方风控终审</c:if>
									</td>
									<td>
										<c:if test="${obj.auditResult == 1}">通过</c:if>
										<c:if test="${obj.auditResult == 2}">不通过</c:if>
										<c:if test="${obj.auditResult == 3}">驳回</c:if>
									</td>
									<th><fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" /></th>
									<th>${obj.auditor }</th>
									<td><a class="btn-modify"  onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/${obj.id}/factorAuditHistoryDetail.htm');">查看</a></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
			</div>
			<div class="w1200 ybl-info box box2">
			
				<div class="grounpinfo">
					<div class="ground-form mb20">
						
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>融资企业：</label><input class="content-form2 validate[required,minSize[2],maxSize[25]]" name="cooperationElements.financingEnterprise"/></div>
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label class="label-long">批复额度：</label><input class="content-form2 validate[required,maxSize[28],custom[number]]" name="cooperationElements.giveQuota"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long">融资期限：</label><input class="content-form2 validate[required,minSize[1],maxSize[4],min[1],custom[integer]]" name="cooperationElements.financingTerm"/><input type="hidden" class="content-form" name="cooperationElements.financingTermUnit" value="1"/><span class="timeimg">天</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>收费方式：</label><select class="content-form2 sffs" name="cooperationElements.feeMode"><option value="1">融资利率</option><option value="2">服务费</option><option value="3">折后转让</option></select></div>
						<div id="cooperationElementsFinancingRate" class="form-grou mr50"><strong style="color: red;">*</strong><label class="sffs-label label-long">融资利率：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="cooperationElements.financingRate"/><span class="timeimg">%</span></div>
						<div id="cooperationElementsServiceFee" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label label-long">服务费：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],custom[number]]" name="cooperationElements.serviceFee"/><span class="timeimg">元</span></div>
						<div id="cooperationElementsTransferMoney" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label label-long">折后转让：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],custom[number]]" name="cooperationElements.transferMoney"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long">合作要素编号：</label><input class="content-form2 validate[required,maxSize[25]]" name="cooperationElements.orderNo"/></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>合同类型：</label><select class="content-form2 sffs" name="cooperationElements.contractType"><option value="1">额度合同</option><option value="2">单笔合同</option></select></div>
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label class="label-long">资产类型：</label><select class="content-form2 sffs" name="cooperationElements.assetsType"><option value="1">应收账款</option><option value="2">应付账款</option><option value="3">票据</option></select></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label class="label-long">还款方式：</label><select class="content-form2 sffs" name="cooperationElements.repaymentMode"><option value="1">先息后本</option><option value="3">到期还本息</option></select></div>
					</div>
				</div>
			
				<div class="bottom-line"></div>
			
				<div class="process">
					<p class="protitle"><span>风控措施</span></p>
					<div class="pd20 mb20">
						<a class="btn-modify" id="dynamicAdd">添加行</a>
					</div>
					<div class="pd20">
						<div class="tabD">
							<table>
								<thead>
									<th>序号</th>
									<th>风控措施名称</th>
									<th>备注</th>
									<th>操作</th>
								</thead>
								<tbody id="tbody"></tbody>
								<%-- <tr>
									<td><input class="tdinput" name="StockHolderList[0].investmentMode" type="text" /></td>
									<td><input class="tdinput" name="StockHolderList[0].legalName" type="text" /></td>
									<td><input class="tdinput" name="StockHolderList[0].investmentAmount" type="text" /></td>
									<td><input class="tdinput" name="StockHolderList[0].receivedAmount" type="text" /></td>
									<td><input class="tdinput registerDate" name="StockHolderList[0].registerDate" id="registerDate" type="text" /><img class="add-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_add_icon.png" /><span class="sp-delete">---</span></td>
								</tr> --%>
							</table>
						</div>
					</div>	
					<p class="protitle"><span>放款条件</span></p>
					<div class="pd20">
					<div  style="position:relative;display:inline-block">
						<strong style="color: red;">*</strong>放款条件：<textarea class="protext validate[required,maxSize[127]]" name="cooperationElements.loanTerms"></textarea>
					</div>	
					</div>
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">
					<div  style="position:relative;display:inline-block">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>备注：<textarea class="protext validate[required,maxSize[127]]" name="cooperationElements.remark"></textarea>
					</div>	
						</div>
					<div class="pd20 mb20">
						<div class="form-grou mr50 mt20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>日期：<input class="content-form2 validate[required,custom[date]]" name="cooperationElementsAuditDateStr"/>
					</div>	
					
					<div class="ground-form mb20 mt20">
						<div class="form-grou mr50">&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>账户名：<input class="content-form2 validate[required,maxSize[25]]" name="cooperationElements.bankAccountName"/></div>
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>账户号：</label><input class="content-form2 validate[required,maxSize[25]]" name="cooperationElements.bankAccount"/></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label>开户行：</label><input class="content-form2 validate[required,maxSize[25]]" name="cooperationElements.bank"/></div>
					</div>
					
					<p class="protitle"><span>请选择资方终审结果</span></p>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label style="text-align: right;"><strong style="color: red;">*</strong>终审结果：</label>
							<select class="content-form2" name="audithistory.auditResult">
								<option value="">请选择</option>
								<option value="1">通过</option>
								<option value="2">不通过</option>
								<!-- <option value="3">驳回</option> -->
							</select>
						</div>
					</div>
					<div class="pd20">
					<div  style="position:relative;display:inline-block">
						&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>备注：<textarea class="protext validate[required,maxSize[127]]" name="audithistory.remark"></textarea>
					</div>
					</div>
					
					<p class="protitle"><span>上传终审意见表</span></p>
					
					<div class="pd20">
						<div id='licensePhoto2'>
							<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
						</div>
						<div id='licensePhoto2_div'></div>
					</div>
				</div>
			</div>
			
				<div class="btn2 clearfix mb80">
					<a href="javascript:;" class="btn-add" id="upPage">上一页</a>
					<a href="javascript:;" class="btn-add" id="submit_btn">提交</a>
				</div>
				</form>	
				<p class="protitle"><span>历史审核记录</span></p>
				<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>提交类型</th>
							<th>审核结果</th>
							<th>审核时间</th>
							<th>审核人</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${page.records}" var="obj" varStatus="index">
						<tr>
							<td class="maxwidth">${index.count}</td>
							<td class="maxwidth">
								<c:if test="${obj.auditType == 1}">资方风控初审</c:if>
								<c:if test="${obj.auditType == 2}">资方风控终审</c:if>
							</td>
							<td class="maxwidth">
								<c:if test="${obj.auditResult == 1}">通过</c:if>
								<c:if test="${obj.auditResult == 2}">不通过</c:if>
								<c:if test="${obj.auditResult == 3}">驳回</c:if>
							</td>
							<td class="maxwidth"><fmt:formatDate value="${obj.auditDate}" pattern="yyyy-MM-dd" /></td>
							<td class="maxwidth">${obj.auditor }</td>
							<td class="maxwidth"><a class="btn-modify"  onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/${obj.id}/factorAuditHistoryDetail.htm');">查看</a></td>
						</tr>
					</c:forEach>
					</table>
				</div>
				<div class="mt40"></div>
		</div>
		<!-- 图片上传 部分 start -->
		<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file" 
				style="display: none;" />
		</form>
		<!-- 图片上传 部分 end -->					
		<script>
			// 动态删除行
			function dynamicRemove(obj){
				$(obj).parent().parent().remove();
				$(".td_index").each(function(index){
					$(this).html(index+1);
				});
			}
			
			$(function(){
				
				var num = 2;
				
				// 动态增加行
				$("#dynamicAdd").click(function(){
					var html = "";
					if(num < 2) num = 2;
					html += "<tr><td class='td_index'>"+($("#tbody").find("tr").length+1)+"</td>";
					html += "<td>"+"<input placeholder='请输入风控措施名称' value='' class='tdinput validate[required,minSize[1],maxSize[25]]' name='attachmentList[" + num + "].attribute1'/>"+"</td>";
					html += "<td>"+"<input placeholder='请输入风控措施备注' value='' class='tdinput validate[maxSize[127]]' name='attachmentList[" + num + "].remark'/><input type='hidden' value='60' name='attachmentList[" + num + "].type'/><input type='hidden' value='4' name='attachmentList[" + num + "].category'/>"+"</td>";
					html += "<td>"+"<a class='btn-modify' onclick='dynamicRemove(this)'>删除</a></td></tr>";
					$("#tbody").append(html);
					// 页面整体添加增加行的高度
					$('body').height($('body').height() + 60);// 60为bottom的高度
					num += 1;
				});
				
				$("#downPage").click(function(){
					if(!$("#subPageForm").validationEngine('validate')) {
						alert("填写的信息有误，请完善信息！");
						return false;
					}
					$(".form_cur").next().trigger("click");
				});
				
				$("#upPage").click(function(){
					$(".form_cur").prev().trigger("click");
				});
				
				//查询表单验证
				$("#subPageForm").validate({
					errorElement: "em", //可以用其他标签，记住把样式也对应修改
					success: function(label) {
						//label指向上面那个错误提示信息标签em
						label.text(" ")        //清空错误提示消息
						.addClass("success");  //加上自定义的success类
					   },
					highlight: function(element, errorClass) {
						$(element).parent().find("." + errorClass).removeClass("success");//表单用户(获取到焦点)操作时如果正确就移除错误的css属性添加正确的css属性
					}//,
					/* rules : {
						actualLoanAmount : {
							maxlength:16,
							minlength:4,
							isZipCode: true
							//isPositiveInteger:$(this).val()
						}
					} */
				});
				
				$("#submit_btn").click(function(){
					/* if(!$("#subPageForm").valid()){
						return false;
					} */
					//数据校验
					if($("input[name='audithistory.financingEnterprise']").val() == "") {
						alert("请完善终审意见表信息！");
						$(".form_cur").prev().trigger("click");
						return false;
					}
					if(!$("#subPageForm").validationEngine('validate')) {
						alert("填写的信息有误，请完善信息！");
						return false;
					}
					if($("select[name='audithistory.auditResult']").val() == "") {
						alert("请选择审核结果！");
						return false;
					}
					/*//需求待确定 
					if($("select[name='audithistory.auditResult']").val() == "1") {
						if($("input[name='audithistory.financingEnterprise']").val() == "") {
							alert("请完善终审意见表信息！");
							$(".form_cur").prev().trigger("click");
							return false;
						}
						if(!$("#subPageForm").validationEngine('validate')) {
							alert("填写的信息有误，请完善信息！");
							return false;
						}
					} */
					if($("#licensePhoto2_div").html() == "") {
						alert("请上传终审意见表！");
						return false;
					}
					
					var formdata=$('#subPageForm').serialize();//序列化表单
					$.ajax({
						url:'/factorRiskManagementController/createFinalAuditHistory',
						dataType:'json',
						type:'post',
						data:formdata,
						success:function(data){
							if(data.responseTypeCode == "success"){
								alert(data.info,function(){
									location.href='/factorRiskManagementController/finalAudit/list.htm';
								});
							}else{
								alert(data.info);
							}					
						},
						complete: function( xhr,data ){
							if(xhr.getResponseHeader('sessionstatus') == 'timeOut') {
								alert("登陆已失效，请重新登陆！",function(){
									location.href='/loginV4Controller/toLogin.htm';
								});
							}
						 }
					}); 
				});
				
			$("input[name='cooperationElementsAuditDateStr']").datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
				
			$("input[name='audithistoryAuditDateStr']").datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			$("select[name='audithistory.feeMode']").change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('#audithistoryFinancingRate').show();
					$('#audithistoryServiceFee').hide();
					$('#audithistoryTransferMoney').hide();
				} else if($val=='2'){
					$('#audithistoryFinancingRate').hide();
					$('#audithistoryServiceFee').show();
					$('#audithistoryTransferMoney').hide();
				} else if($val=='3'){
					$('#audithistoryFinancingRate').hide();
					$('#audithistoryServiceFee').hide();
					$('#audithistoryTransferMoney').show();
				} else {
					$('#audithistoryFinancingRate').hide();
					$('#audithistoryServiceFee').hide();
					$('#audithistoryTransferMoney').hide();
				}
			})
			$("select[name='cooperationElements.feeMode']").change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('#cooperationElementsFinancingRate').show();
					$('#cooperationElementsServiceFee').hide();
					$('#cooperationElementsTransferMoney').hide();
				} else if($val=='2'){
					$('#cooperationElementsFinancingRate').hide();
					$('#cooperationElementsServiceFee').show();
					$('#cooperationElementsTransferMoney').hide();
				} else if($val=='3'){
					$('#cooperationElementsFinancingRate').hide();
					$('#cooperationElementsServiceFee').hide();
					$('#cooperationElementsTransferMoney').show();
				} else {
					$('#cooperationElementsFinancingRate').hide();
					$('#cooperationElementsServiceFee').hide();
					$('#cooperationElementsTransferMoney').hide();
				}
			})
			$(document).on('click','.sp-del',function(){
						$(this).parents('tr').remove();
						var address = $(this).attr("address");
						var index = Number(address);
						$("input[name^='attachmentList[" + index + "]']").remove();
						
			});
			
			/**
			 * 图片上传statrt
			 */
			// 监听图片上传按钮
			$("#common_upload_btn")
					.watchProperty(
							"value",
							function() {
								var v = $(this).val();
								if (v == '' || v == null)
									return;
								// 上传
								$("#common_upload_form")
										.attr("action",
												"/fileUploadController/uploadFtp?uploadUrl=/customer/&_callback=uploadCallback");
								$("#common_upload_form").submit();
								$(this).val('');
							});
			// 点击图片上传图片
			$("#licensePhoto").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			$("#licensePhoto2").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			$("#licensePhoto3").click(function() {
				id = $(this).attr("id");
				$("#common_upload_btn").click();
			});
			var num = 0;
			var num2 = 2;
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var photoUpdateId = $("#" + id).attr("attachId");
				var html_ = "";
				if (id == "licensePhoto") {
					num = 0;
					html_ += "<input type='hidden' value='' name='attachmentList[" + num + "].type'/>";
				} else if (id == "licensePhoto2") {
					num = 1;
					html_ += "<input type='hidden' value='54' name='attachmentList[" + num + "].type'/>";
				} else if (id == "licensePhoto3") {
					num = num2;
					num2++;
					html_ += "<input type='hidden' value='60' name='attachmentList[" + num + "].type'/>";
				}
				html_ += "<input type='hidden' value='" + attachment.url_ + "' name='attachmentList[" + num + "].url'/>"
				+ "<input type='hidden' value='" + attachment.old_name + "' name='attachmentList[" + num + "].oldName'/>"
				+ "<input type='hidden' value='" + attachment.new_name + "' name='attachmentList[" + num + "].newName'/>"
				+ "<input type='hidden' value='" + attachment.ext_name + "' name='attachmentList[" + num + "].extName'/>";
				+ "<input type='hidden' value='" + attachment.file_size + "' name='attachmentList[" + num + "].fileSize'/>";
				if (photoUpdateId && photoUpdateId != '' && photoUpdateId != null) {
					html_ += "<input type='hidden' value='" + photoUpdateId + "' name='attachmentlist[" + num + "].id'/>"// 更新时有图片id
				}
				if (id == "licensePhoto" || id == "licensePhoto2") {
					$("#" + id + "_div").empty().html(html_);
				} else {
					var len = $(this).parents('table').find('tr').length+1;
					var htmlArray = [];
					htmlArray.push("<tr>")
					htmlArray.push("<td><input class='tdinput' value='" + len + "'/></td>");
					htmlArray.push("<td><input class='tdinput' value='" + attachment.old_name + "' name='attachmentList[" + num + "].oldName'/></td>");
					htmlArray.push("<td><input class='tdinput' name='attachmentList[" + num + "].remark'/></td>");
					if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
						$("#"+ id).empty().html("<img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' width='182px' height='122px'/>");
					} else {
						$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
					}
					htmlArray.push("<td><a href=" + attachment.url_ + " target='_blank'><img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' /></td>");
					htmlArray.push("<td><span class='btn-modify' address='" + num + "'>删除</span></td>");
					htmlArray.push("</tr>");
					$("#tbody").append(htmlArray.join(""));
					$("#" + id + "_div").append(html_);
				}
				if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
					$("#"+ id).empty().html("<img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' width='182px' height='122px'/>");
				} else {
					$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				}
				$("#licensePhoto3").empty().html("<img src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png' width='182px' height='122px'/>");
			}
			// 图片上传end
			
			})
		</script>
	</body>
</html>