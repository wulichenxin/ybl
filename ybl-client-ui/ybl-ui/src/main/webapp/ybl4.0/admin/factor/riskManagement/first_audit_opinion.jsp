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
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />待资方初审<span class="mr10 ml10"></span></div>
		</div>
			<div class="w1200">
				<ul class="clearfix iconul">
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/financingApplyDetail.htm');"><div class="proicon bg1 statusTwo"></div>项目详情</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');"> <div class="proicon bg2 statusTwo"></div>平台初审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<c:if test="${auditType == 1}">
						<li class="iconlist pro_li_cur" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateAuditHistory.htm');"><div class="proicon bg3 statusThree"></div>资方初审</li>
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
						<li class="iconlist" url="/" onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/preCreateFinalAuditHistory.htm');"><div class="proicon bg5 statusThree"></div>资方终审</li>
					</c:if>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg6 statusOne"></div>合作资方</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg7 statusOne"></div>平台复审</li>
					<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
					<li class="iconlist" url="/"><div class="proicon bg8 statusOne"></div>签署主合同</li>
				</ul>	
			</div>
		
			<div class="w1200">
			<form action="" id="subPageForm" method="post">
				<input type="hidden" name="subFinancingApplyId" value="${subFinancingApplyId }"/>
				<p class="protitle"><span>项目初审意见</span></p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>融资企业：</label><input class="content-form2 validate[required,minSize[2],maxSize[25]]" name="financingEnterprise"/></div>
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>融资金额：</label><input class="content-form2 validate[required,min[1],maxSize[28],custom[number]]" name="financingAmount"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label>融资期限：</label><input class="content-form2 validate[required,minSize[1],maxSize[4],min[1],custom[integer]]" name="financingTerm" /><input type="hidden" class="content-form2" name="financingTermUnit" value="1"/><span class="timeimg">天</span></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50"><strong style="color: red;">*</strong><label>收费方式：</label><select class="content-form2 sffs" name="feeMode"><option value="1">融资利率</option><option value="2">服务费</option><option value="3">折价转让</option></select></div>
						<div id="financingRate" class="form-grou mr50"><strong style="color: red;">*</strong><label class="sffs-label">融资利率：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],max[100],custom[number]]" name="financingRate"/><span class="timeimg">%</span></div>
						<div id="serviceFee" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label">服务费：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[1],custom[number]]" name="serviceFee"/><span class="timeimg">元</span></div>
						<div id="transferMoney" class="form-grou mr50" style="display: none;"><strong style="color: red;">*</strong><label class="sffs-label">折后转让：</label><input class="content-form2 validate[required,minSize[1],maxSize[28],min[1],custom[number]]" name="transferMoney"/><span class="timeimg">元</span></div>
						<div class="form-grou"><strong style="color: red;">*</strong><label>意见编号：</label><input class="content-form2 validate[required,minSize[1],maxSize[25]]" name="opinionNumber"/></div>
					</div>
				</div>
			
			<div class="process">
				<p class="protitle"><span>融资说明</span></p>
				<div class="pd20">
					<strong style="color: red;">*</strong>融资说明：<textarea class="protext validate[required,maxSize[127]]" name="financingExplain"></textarea>
				</div>	
				<p class="protitle"><span>交易结构</span></p>
				<div class="pd20">
					<strong style="color: red;">*</strong>交易结构：<textarea class="protext validate[required,maxSize[127]]" name="transactionStructure"></textarea>
				</div>	
				<p class="protitle"><span>增信措施</span></p>
				<div class="pd20">
					<strong style="color: red;">*</strong>增信措施：<textarea class="protext validate[required,maxSize[127]]" name="trustMeasure"></textarea>
				</div>	
				<p class="protitle"><span>审核意见</span></p>
				<div class="pd20">
					<strong style="color: red;">*</strong>审核意见：<textarea class="protext validate[required,maxSize[127]]" name="auditOpinion"></textarea>
				</div>	
				<div class="pd20 mb20">
					<div class="form-grou mr50 mt20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>日期：<input id="auditDate" class="content-form2 validate[required,custom[date]]" name="auditDateStr"/>
				</div>
				
				<p class="protitle"><span>请选择资方初审结果</span></p>
				<div class="ground-form mb20">
					<div class="form-grou mr50"><label style="text-align: right;"><strong style="color: red;">*</strong>初审结果：</label>
						<select class="content-form2" name="auditResult" id="auditResult">
							<option value="">请选择</option>
							<option value="1">通过</option>
							<option value="2">不通过</option>
							<option value="3">驳回</option>
						</select>
					</div>
				</div>
				<div class="pd20">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color: red;">*</strong>备注：<textarea class="protext validate[required,maxSize[127]]" name="remark"></textarea>
				</div>
				
				<p class="protitle"><span>上传初审意见表</span></p>
				
				<div class="pd20">
					<div id='licensePhoto'>
						<img class="uploadimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
					</div>
					<div id='licensePhoto_div'></div>
				</div>
			</form>	
			
			<div class="btn3 clearfix mb80">
				<a onclick="javascript:window.location.href=('<%=basePath%>factorRiskManagementController/${financingApplyId }/${subFinancingApplyId }/${auditType }/platformFirstAuditDetail.htm');" class="btn-add">上一页</a>
				<a href="javascript:;" class="btn-add" id="submit_btn">提交</a>
				<a onclick="javascript:window.location.href='<%=basePath%>factorRiskManagementController/firstAudit/list.htm'" class="btn-add">返回</a>
			</div>
			
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
			$(function(){
				
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
					if(!$("#subPageForm").validationEngine('validate')) {
						alert("填写的信息有误，请完善信息！");
						return false;
					}
					if($("#auditResult").val() == "") {
						alert("请选择审核结果！");
						return false;
					}
					/*//需求待确定 
					if($("#auditResult").val() == "1") {
						if(!$("#subPageForm").validationEngine('validate')) {
							alert("填写的信息有误，请完善信息！");
							return false;
						}
					} */
					if($("#licensePhoto_div").html() == "") {
						alert("请上传初审意见表！");
						return false;
					}
					var formdata=$('#subPageForm').serialize();//序列化表单
					$.ajax({
						url:'/factorRiskManagementController/createAuditHistory',
						dataType:'json',
						type:'post',
						data:formdata,
						success:function(data){
							if(data.responseTypeCode == "success"){
								alert(data.info,function(){
									location.href='/factorRiskManagementController/firstAudit/list.htm';
								});
							} else {
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
				
			$('#auditDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
			
			$('.sffs').change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('#financingRate').show();
					$('#serviceFee').hide();
					$('#transferMoney').hide();
				} else if($val=='2'){
					$('#financingRate').hide();
					$('#serviceFee').show();
					$('#transferMoney').hide();
				} else if($val=='3'){
					$('#financingRate').hide();
					$('#serviceFee').hide();
					$('#transferMoney').show();
				} else {
					$('#financingRate').hide();
					$('#serviceFee').hide();
					$('#transferMoney').hide();
				}
				
			})
			
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
			var num = 0;
			// 回调，回显图片
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				$("#common_upload_btn").val('');
				var photoUpdateId = $("#" + id).attr("attachId");
				$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				if (id == "licensePhoto") {
					num = 1;
				} else {
					num = 0;
				}
				var html_ = "<input type='hidden' value='" + attachment.url_
						+ "' name='attachmentList[" + num + "].url'/>"
						+ "<input type='hidden' value='userV2Certificate_" + id
						+ "' name='attachmentList[" + num + "].type'/>"
						+ "<input type='hidden' value='" + attachment.old_name
						+ "' name='attachmentList[" + num + "].oldName'/>"
						+ "<input type='hidden' value='" + attachment.new_name
						+ "' name='attachmentList[" + num + "].newName'/>"
						+ "<input type='hidden' value='" + attachment.ext_name
						+ "' name='attachmentList[" + num + "].extName'/>";
						+ "<input type='hidden' value='" + attachment.file_size
						+ "' name='attachmentList[" + num + "].fileSize'/>";
				if (photoUpdateId && photoUpdateId != '' && photoUpdateId != null) {
					html_ += "<input type='hidden' value='" + photoUpdateId
							+ "' name='attachmentlist[" + num + "].id'/>"// 更新时有图片id
				}
				if(attachment.ext_name != "png" && attachment.ext_name != "jpg" && attachment.ext_name != "jepg" && attachment.ext_name != "gif") {
					$("#"+ id).empty().html("<img class='uploadimg' src='${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_addDaf_img.png' width='182px' height='122px'/>");
				} else {
					$("#"+id).empty().html("<img src='" + attachment.url_ + "' width='182px' height='122px'/>");
				}
				$("#" + id + "_div").empty().html(html_);
			}
			// 图片上传end
			
			})
		</script>
	</body>
</html>