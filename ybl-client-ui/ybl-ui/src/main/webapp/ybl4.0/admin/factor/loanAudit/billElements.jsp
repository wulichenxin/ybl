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
		<%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>
	<body>
		<form action="<%=basePath%>factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<input type="hidden" id="lid" name="lid" value="${lid }" /> 
			<input type="hidden" id="assetsType" name="assetsType" value="${assetsType }" /> 
			<input type='hidden' id="rightBusinessId" name='rightBusinessId' value='${rightBusinessId }' />
			<div class="w1200">
				<p class="protitle"><span>保理要素表(票据)</span></p>
				<div class="grounpinfo">
				<div class="ground-form mb20">
					<div class="form-grou">
						<label class="label-long3"><a style = "color:red">*</a>保理要素表编号：</label>
						<input class="content-form2 validate[required]" name="orderNo" value="${vo.orderNo}"/>
					</div>
				</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>票据持有人：</label>
							<input class="content-form2 validate[required]" name="billHolder" value="${vo.billHolder }"/>
						</div>
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>票据承兑人：</label>
							<input class="content-form2 validate[required]" name="billAcceptor" value="${vo.billAcceptor }"/>
						</div>
						<div class="form-grou">
							<label class="w140"><a style = "color:red">*</a>基础合同及编号：</label>
							<input class="content-form2 validate[required]" name="baseContractNo" value="${vo.baseContractNo}"/>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>保理方式：</label>
							<select class="content-form2" name="factoringMode" id="factoringMode">
								<option value="">请选择</option>
								<option value="1" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 1}">selected="selected"</c:if>>明保理</option>
								<option value="2" <c:if test="${not empty vo.factoringMode and vo.factoringMode eq 2}">selected="selected"</c:if>>暗保理</option>
							</select>
						</div>
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>确权方式：</label>
							<select class="content-form2" name="rightMode" id="rightMode">
								<option value="">请选择</option>
								<option value="1" <c:if test="${not empty vo.rightMode and vo.rightMode eq 1}">selected="selected"</c:if>>线下确权</option>
								<option value="2" <c:if test="${not empty vo.rightMode and vo.rightMode eq 2}">selected="selected"</c:if>>线上确权</option>
							</select>
							<div id="hidefill" style="width:240px;height:30px;top:0;right:0;position:absolute"></div>
						</div>
						<div class="form-grou">
							<label class="w140">票面金额：</label>
							<input class="content-form2" name="totalAmount" value='<fmt:formatNumber value="${totalAmount }" pattern="#,##0.##"/>' readonly="readonly"/><span class="timeimg">元</span>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50">
						<label><a style = "color:red">*</a>收费方式：</label>
						<select class="content-form2 sffs" name="feeMode" id="feeMode">
							<option value="1" selected="selected">融资利率</option>
							<option value="2">服务费</option>
							<option value="3">折价转让</option>
						</select>
					</div>
					<div id="financingRate" class="form-grou mr50">
						<label class="sffs-label"><a style = "color:red">*</a>融资利率：</label>
						<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="financingRate"/><span class="timeimg sffs-sp">%</span>
					</div>
					<div id="serviceFee" class="form-grou mr50" style="display: none;">
						<label class="sffs-label"><a style = "color:red">*</a>服务费：</label>
						<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],custom[number]]" name="serviceFee"/><span class="timeimg sffs-sp">元</span>
					</div>
					<div id="transferMoney" class="form-grou mr50" style="display: none;">
						<label class="sffs-label"><a style = "color:red">*</a>折后转让：</label>
						<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0],custom[number]]" name="transferMoney"/><span class="timeimg sffs-sp">元</span>
					</div>
						<div class="form-grou">
							<label class="w140"><a style = "color:red">*</a>逾期利率：</label>
							<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="overdueInterestRate" value="${vo.overdueInterestRate }"/><span class="timeimg">%</span>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>交易方式：</label>
							<select class="content-form2" name="transactionMode" id="transactionMode">
								<option value="">请选择</option>
								<option value="1" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 1}">selected="selected"</c:if>>回购</option>
								<option value="2" <c:if test="${not empty vo.transactionMode and vo.transactionMode eq 2}">selected="selected"</c:if>>买断</option>
							</select>
							<div id="hidefill2" style="width:240px;height:30px;top:0;right:0;position:absolute"></div>
						</div>
						<div class="form-grou mr50">
							<label><a style = "color:red">*</a>结算比例：</label>
							<input class="content-form2 validate[required,minSize[1],maxSize[28],min[0.01],max[100],custom[number]]" name="balanceScale" value="${vo.balanceScale }"/><span class="timeimg">%</span>
						</div>
						<div class="form-grou">
							<label class="w140"><a style="color:red">*</a>还款方式：</label>
							<select class="content-form2" name="repaymentMode" id="repaymentMode">
								<option value="">请选择</option>
								<option value="1" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 1}">selected="selected"</c:if>>先息后本</option>
								<option value="3" <c:if test="${not empty vo.repaymentMode and vo.repaymentMode eq 3}">selected="selected"</c:if>>到期还本息</option>
							</select>
							<div id="hidefill3" style="width:240px;height:30px;top:0;right:0;position:absolute"></div>
						</div>
					</div>
				</div>
				
				<div></div>
				<div class="tabD mt30 mb30">
					<table>
						<tr>
							<th>资产编号</th>
							<th>票据到期日期</th>
							<th>票据转让日期</th>
							<th>融资期限</th>
						</tr>
						<c:forEach items="${assetslist}" var="obj" varStatus="index">
							<tr class="assets">
								<td>${obj.assetNumber}</td>
								<input type='hidden' name='assetslist[${index.count-1 }].assetNumber' value='${obj.assetNumber }' />
								<input id="date${index.count-1 }" type="hidden" value='<fmt:formatDate value="${obj.expireDate }" pattern="yyyy-MM-dd" />'/>
								<td><input id="beginDate${index.count-1 }" name='assetslist[${index.count-1 }].expireDateActual'  class="content-form beginDate"
									value='<fmt:formatDate value="${obj.expireDateActual }" pattern="yyyy-MM-dd" />' /></td>
								<script>
									$(function(){
										var dateActual = $("#date${index.count-1 }").val();
										$('#beginDate${index.count-1 }').datetimepicker({
											yearOffset : 0,
											lang : 'ch',
											timepicker : false,
											format : 'Y-m-d',
											formatDate : 'Y-m-d',
											minDate : '1970-01-01', // yesterday is minimum date
											maxDate : dateActual // and tommorow is maximum date calendar
										});
									})
								</script>
								<td><a style = "color:red">*</a><input name='assetslist[${index.count-1 }].transferDate' class="content-form endDate validate[required,custom[date]]"
									value='<fmt:formatDate value="${obj.transferDate }" pattern="yyyy-MM-dd" />' /></td>
								<td><div class="form-grou" style="line-height: 30px;"><input name='assetslist[${index.count-1 }].financingTerm' class="content-form financingTerm" value='${obj.financingTerm }'  readonly="readonly"/><span class="timeimg" style="line-height: 22px;">天</span></div></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				
				<div class="bottom-line"></div>
				
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
									<c:forEach items="${Attachmentlist}" var="obj" varStatus="index">
										<tr id="tr_${obj.id }">
											<td>${index.count}</td>
											<td name="attribute1">${obj.attribute1 }</td>
											<td name="remark_">${obj.remark_ }</td>
											<td class="oldName" name="old_name"><a href="/fileDownloadController/downloadftp?id=${obj.id }">${obj.old_name }</a></td>
											<td><a href="javascript:;" class="btn-modify" id="upload"
												param="${obj.id } ${obj.old_name}">上传</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					<p class="protitle"><span>备注</span></p>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" value="${vo.remark }"></textarea>
					</div>	
				
				
				<div class="bottom-line"></div>
				
				<div class="shenmin"><input id="check" type="checkbox" />申明：以上填报内容及报送的资料属实，如有虚假或隐瞒，产生的任何责任和后果，本单位和法定代表承担一切法律责任。</div>
				
				<div class="btn3 clearfix mb80">
					<a href="javascript:;" class="btn-add" id="commit">通过</a>
					<a href="javascript:;" class="btn-add" id="cancel">不通过</a>
					<a href="javascript:;" class="btn-add" id="back">返回</a>
				</div>
				
				</div>
			</div>
		</form>	
		
		<!-- 文件上传form-->
		<iframe id="common_iframe" name="common_iframe" style="display:none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
		</form>
		
		<script>
			var paramArry;
			$(function(){
				
				var $val = $("#feeMode").val();
				if($val != 1) {
					$('#repaymentMode').val(3);
					$('#hidefill3').show();
				}else{
					$('#hidefill3').hide()
				}
				
				//查询表单验证
				$("#pageForm").validate({
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
				
				$("#back").click(function(){
					window.parent.frames.location.href="/factorLoanAuditController/loanAudit/loanAuditList.htm";
				})
				
				$("#cancel").click(function(){
					var lid= $("#lid").val();
					var assetsType = $("#assetsType").val();
					var arr=new Array();
					$(".assets").each(function(){
						var a = $(this).children("td")
						var b = $(a[0]).text()
						arr.push(b);
					});
					$.ajax({
						url : "/factorLoanAuditController/loanAudit/callBack",
						dataType : "json",
						type : "post",
						data : {"assets":JSON.stringify(arr),"lid":lid,"assetsType":assetsType},
						success : function(data){
							if (data.responseTypeCode == 'success') {
								alert(data.info,function(){
									window.parent.frames.location.href="/factorLoanAuditController/loanAudit/loanAuditList.htm";
								});
	                        } else {
	                        	alert(data.info);
	                        } 
						},
						error : function(){
							alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
						}
					});
					
				})
				
				$("#commit").click(function(){
					if(!$("#pageForm").validationEngine('validate')) {
						alert("填写的信息有误，请完善信息！");
						return false;
					}
					if($("#factoringMode").val()!=null && $("#factoringMode").val() == "") {
						alert("请选择保理方式！");
						return false;
					}
					if($("#rightMode").val()!=null && $("#rightMode").val() == "") {
						alert("请选择确权方式！");
						return false;
					}
					if($("#rightBusinessId").val() == 0) {
						if($("#rightMode").val() == 2) {
							alert("该订单确权方式只能为线下确权！");
							return false;
						}
					}
					if($("#feeMode").val()!=null && $("#feeMode").val() == "") {
						alert("请选择收费方式！");
						return false;
					}
					if($("#repaymentMode").val()!= null && $("#repaymentMode").val() == "") {
						alert("请选择还款方式！");
						return false;
					}
					if($("#transactionMode").val()!=null && $("#transactionMode").val() == "") {
						alert("请选择交易方式！");
						return false;
					}
					var status=0;
					$(".oldName").each(function(index,element){
						var oldName = $(this).text();
						if(oldName == "") {
							status = 1;
						}
					});
					
					if(status==1){
						alert("请上传风控措施附件！");
						return false;
					}
					var check = document.getElementById("check");
					if(check!= null && !check.checked){
				        alert("请先阅读并勾选申明协议！");
				        return false;        
				    }
					var formParam = $('#pageForm').serialize();
					$.ajax({
						type : 'post',
						url : '/factorLoanAuditController/loanAudit/billElementsAudit',
						data : formParam,
						dataType : 'json',
						success : function(data){
							if (data.responseTypeCode == 'success') {
								alert(data.info,function(){
									window.parent.frames.location.href="/factorLoanAuditController/loanAudit/loanAuditList.htm";
								});
	                        } else {
	                        	alert(data.info);
	                        } 
						},
						error : function(){
							alert($.i18n.prop("sys.client.save.error"));/* 服务器繁忙请稍候重试 */
						}
					});
				});
				
				// 监听图片上传按钮
				$("#common_upload_btn").watchProperty(
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

				$(".btn-modify").click(function() {
					var param = $(this).attr("param");
					paramArry = param.split(/\s+|,|-/g);
					$("#common_upload_btn").click();

				})
				
				$(".endDate").blur(function(){
				var sDate1 = $(this).val();
				var sDate2 = $(this).parent().parent("tr").find(".beginDate").val();
				
				var s = ((new Date(sDate2.replace(/-/g,"\/"))) - (new Date(sDate1.replace(/-/g,"\/")))); 
				var day = s/1000/60/60/24
				if(day < 0 ) {
					alert("转让日期必须小于到期日期！");
					return false;
				}
				$(this).parent().parent().find(".financingTerm").val(day);
			}); 
				$(".beginDate").blur(function(){
					var sDate2 = $(this).val();
					var sDate1 = 0;
					if($(this).parent().parent("tr").find(".endDate").val() != "") {
						sDate1 = $(this).parent().parent("tr").find(".endDate").val();
						var s = ((new Date(sDate2.replace(/-/g,"\/"))) - (new Date(sDate1.replace(/-/g,"\/")))); 
						var day = s/1000/60/60/24
						if(day < 0 ) {
							alert("转让日期必须小于到期日期！");
							return false;
						}
					}
					$(this).parent().parent().find(".financingTerm").val(day);
				});
				$('.endDate').datetimepicker({
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
				
				$('#feeMode').change(function(){
					var $val = $(this).val();
					if($val != 1) {
						$('#repaymentMode').val(3);
						$('#hidefill3').show();
					}else{
						$('#hidefill3').hide()
					}
				})
				
				$('#factoringMode').change(function() {
					var $val = $(this).children('option:selected').attr('value');
					if($("#rightBusinessId").val() == 0) {//底层资产对应的核心企业没有入驻平台：确权方式只能为'线下确权' 交易方式为'回购'
						$('#rightMode').val(1);
						$('#transactionMode').val(1);
						$('#hidefill').show()
						$('#hidefill2').show()
					}else{
						if ($val == '2') {//暗保理：确权方式只能为'线下确权' 交易方式为'回购'
							$('#rightMode').val(1);
							$('#transactionMode').val(1);
							$('#hidefill').show()
							$('#hidefill2').show()
						}else{
							$('#hidefill').hide()
							$('#hidefill2').hide()
						}
					}
				})
			});
			uploadCallback = function(obj) {
				var attachment = eval('(' + obj + ')');
				attachment.id_ = paramArry[0];
				$.ajax({
					url : "/factorLoanAuditController/updateAttachment",
					dataType : "json",
					data : attachment,
					type : "post",
					success : function(data) {
						if (data.responseTypeCode == 'success') { 
							$("#tr_"+paramArry[0]).children().each(function(index,value){
								var td = $(this);
								var keys = Object.keys(attachment);
								$.each(keys,function(index,value){
									if(td.attr("name") == value){
										if(value=="old_name"){
											td.find("a").text(attachment[""+value]);
											td.find("a").attr("href","/fileDownloadController/downloadftp?id="+attachment.id_);
										}else{
											td.text(attachment[""+value]);
										}
									}
								});
							});
							
							
					 	} else {
							alert(data.info);
						}
					},
					error : function() {
						alert(
								$.i18n
										.prop("sys.v2.admin.save.error"),
								function() {

								});// 保存失败
					}
				}); 
			}
		</script>
	</body>
</html>