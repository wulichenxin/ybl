<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理</title>
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
$(function(){   
	view = function(id) {
			$.msgbox({
				height:648,
				width:1050,
				content: '/voucherController/addVoucherinit',
				type : 'iframe',
				title : $.i18n.prop('sys.client.add.voucher') /* 添加凭证 */
			});
			
	}

		//查询凭证信息
		$("#queryVocherByConditionBtn").click(function() {
			$("#pageForm").submit();
		})

		//删除凭证
		$("#deleteVoucherByIdsBtn").click(
				function() {
					//获取要删除的凭证id
					var size = $("#pageForm").find("input[type=checkbox]:checked").size();
					if (size < 1) {
						alert($.i18n.prop('sys.client.select.delete.records'));/* 请选择要删除的记录 */
						return;
					}
					var flag = false;
					//要删除的凭证id串,用；分隔
					var ids = "";
					var flag = false;
					for (var i = 0; i < size; i++) {
						var $this = $("#pageForm").find("input[type=checkbox]:checked").eq(i);
						
						if($this.val()){
							if($this.attr("status")!='available'){
								flag = true;
								alert($.i18n.prop('sys.client.can.delete.available.voucher.only'));/* 只能删除状态为可使用的凭证！ */
								return ;
							}else{
								ids += $this.val()+ ";";
							}
						}
					}
					/*删除的凭证使用状态不可用*/
					if(flag){
						return ;
					}
					
					confirm($.i18n.prop('sys.client.confirm.delete.records'),function() {/* 确定要删除数据吗? */
						$.ajax({
							type : "post",
							url : "/voucherController/deleteVoucherByIds?id="+ids,
							dataType:"json",
							success : function(data) {
								if(data.responseTypeCode=="success"){
									alert(data.info,function(){
									$("#pageForm").submit();	
									});
								}else{
									alert(data.info,deletecallback);
								}
							},
							error: function(data){
								alert($.i18n.prop('sys.client.operationFail')); /*操作失败！*/
							}
						});
					});
				
				})
				
		deletecallback = function(){
			window.reload();
		}
				
		//修改凭证
		$("#updateVoucherByIdBtn").click(function(){
			
			var size = $("#pageForm").find("input[type=checkbox]:checked").size();
			if (size != 1) {
				alert($.i18n.prop('sys.client.select.one.record'));/* 请选择一条记录 */
				return false;
			}
			var $this = $("#pageForm").find("input[type=checkbox]:checked");
			
			if($this.attr("status") != 'available'){
				alert($.i18n.prop('sys.client.can.update.available.only'));/*只能修改状态为可使用的凭证！*/
				return ;
			}
			var id = $this.val();
			
			$.msgbox({
				height:648,
				width:1050,
				content:'/voucherController/updatePageInit?id='+id,
							type : 'iframe',
							title :$.i18n.prop('sys.client.edit.voucher')/* 修改凭证 */
				});
			
		})
		
		
		//查看凭证信息
		$("#showVoucherByIdBtn").click(function(){
			var size = $("#pageForm").find("input[type=checkbox]:checked").size();
			if (size != 1) {
				alert($.i18n.prop('sys.client.select.one.record'));/*请选择一条记录*/
				return false;
			}
			var id = $("#pageForm").find("input[type=checkbox]:checked").val();
			
			$.msgbox({
				height:648,
				width:1000,
				content:'/voucherController/showVoucherById?id='+id,
				type : 'iframe',
				title : $.i18n.prop('sys.client.view.voucher') /*查看凭证*/
				});
		})
		
		
		resetForm = function(){
		
			//$("#pageForm")[0].reset();
			$("input[name='voucherNo']").val("");
			$("select[name='enterpriseMemeberId']").val("");
			$("select[name='status']").val("");
			
	}
		
		
	//checkbox全选反选
	 $("#checkAll").click(function() {
          var isCheckAll = $("#checkAll").attr("checked");
          if (isCheckAll) {//全选
              $('input[type="checkbox"]').each(function() {
                   $(this).attr("checked", true);
              });
          } else {//取消全选
              $('input[type="checkbox"]').each(function() {
                   $(this).attr("checked", false);
              });
          }
     });
	});
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->

	<div class="path"><spring:message code='sys.client.location' ></spring:message> -> <!-- 当前位置 -->
					  <spring:message code='sys.client.financeApply' ></spring:message>-> <!-- 融资申请 -->
					  <spring:message code='sys.client.voucher.manage' ></spring:message>-> <!-- 凭证管理 -->
	</div>
	<div class="vip_conbody">


		<!--搜索条件-->
		<form action="/voucherController/voucherManage" id="pageForm" method="post">
			<div class="seach_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				<div class="fl">
					<ul>
						<li><label><spring:message code="sys.client.voucherNumber"></spring:message>:</label><input name="voucherNo" type="text" value="${voucher.voucherNo }" /></li><!-- 凭证编码 -->
						<li><label><spring:message code='sys.client.core.enterprise'></spring:message> :</label> <!-- 核心企业 -->
							<select name="enterId">
								<option value=""><spring:message code="sys.client.queryAll"></spring:message></option><!-- 全部 -->
								<c:forEach items="${enterList }" var="enter">
									<option value="${enter.id }" <c:if test="${voucher.enterId ==enter.id }">selected='selected' </c:if> >${enter.enterpriseName }</option>
								</c:forEach>
							</select>
						</li>
						<li><label><spring:message code='sys.client.voucher.status'></spring:message>:</label> 
							<select name="status"> <!-- 凭证状态 -->
								<option value=""> <spring:message code="sys.client.queryAll"></spring:message> </option><!-- 全部 -->
								<option value="available" <c:if test="${voucher.status =='available' }">selected='selected' </c:if> ><spring:message code='sys.client.available'></spring:message> </option><!-- 可使用 -->
								<option value="using" <c:if test="${voucher.status =='using' }"> selected='selected' </c:if> ><spring:message code='sys.client.using'></spring:message></option><!-- 使用中 -->
								<option value="used" <c:if test="${voucher.status =='used' }">selected='selected' </c:if> ><spring:message code='sys.client.used'></spring:message></option></option><!-- 已使用 -->
							</select>
						</li>
						<li>
							<div class="button_yellow"> <sun:button tag='a' id='queryVocherByConditionBtn' i18nValue="sys.admin.search" /><!-- 查询 -->
							</div>
						</li>
						<li>
						<div class="button_gary">
								<a href="javascript:void(0);" onclick="resetForm()" ><spring:message code='sys.client.reset'></spring:message> </a><!-- 重置 -->
						</div></li>
					</ul>
				</div>
			</div>

			<!--搜索条件-->
			<!--table-->
			<div class="table_box">
				<div class="table_top ">
					<div class="table_nav">
						<ul>
							<li><sun:button tag='a' id='addVoucherBtn' clazz='but_ico7' href="javascript:view(1);" i18nValue='sys.admin.add' /></li> <!-- 添加 -->
							<!-- <a href="javascript:view(1);" class="but_ico7">添加</a></li> -->
							<li><sun:button tag='a' id='deleteVoucherByIdsBtn' clazz='but_ico1' i18nValue='sys.admin.delete' /></li><!-- 删除 -->
							<!-- <a class="but_ico1" id="deleteVoucherByIdsBtn">删除</a></li> -->
							<li><sun:button tag='a' id='updateVoucherByIdBtn' clazz='but_ico3' i18nValue='sys.client.edit' /></li><!-- 修改 -->
							<!-- <a class="but_ico3" id="updateVoucherByIdBtn">修改</a></li> -->
							<li><sun:button tag='a' id='showVoucherByIdBtn' clazz='but_ico4' i18nValue='sys.client.look' /></li><!-- 查看 -->
							<!-- <a class="but_ico4" id="showVoucherByIdBtn">查看</a></li> -->
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
						<tr>
							<th width="50"><input id="checkAll" type="checkbox" value="" /></th>
							<th width="50"><spring:message code='sys.client.no'></spring:message></th><!-- 序号 -->
							<th><spring:message code="sys.client.voucherNumber"></spring:message> </th><!-- 凭证编码 -->
							<th><spring:message code='sys.client.coreCompanyName'></spring:message> </th><!-- 核心企业名称 -->
							<th><spring:message code='sys.client.registe.amount'></spring:message></th><!-- 注册资金/元 -->
							<th><spring:message code='sys.client.voucherType'></spring:message> </th><!-- 凭证类型 -->
							<th><spring:message code='sys.client.voucher.start.time'></spring:message> </th><!-- 凭证起始日 -->
							<th><spring:message code='sys.client.voucherOverdueTime'></spring:message></th><!-- 凭证到期日 -->
							<th><spring:message code='sys.client.relate.voucher.number'></spring:message> </th><!-- 关联贷款编号 -->
							<th><spring:message code='sys.client.voucher.status'></spring:message> </th><!-- 凭证状态 -->
						</tr>

						<c:forEach items="${voucherList}" var="voucher"
							varStatus="status_var">
							<c:if test="${status_var.count % 2 == 0}">
								<tr>
							</c:if>
							<c:if test="${status_var.count % 2 !=0 }">
								<tr class="bg_l">
							</c:if>
							<td><input type="checkbox" value="${voucher.id}" status="${voucher.status}"/></td>
							<td>${status_var.count }</td>
							<td>${voucher.voucherNo}</td>
							<td>${voucher.enterpriseName}</td>
							<td><fmt:formatNumber value="${voucher.amount}" pattern="#,##0.00"></fmt:formatNumber></td>
							<td>${voucher.type}</td>
							<td>
								<!-- 时间戳转换为时间yyyy-mm-dd -->
								<jsp:useBean id="dateValue" class="java.util.Date" />
								<jsp:setProperty name="dateValue" property="time" value="${voucher.effectiveDate}" />
								<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
							</td>
							<td>
								<!-- 时间戳转换为时间yyyy-mm-dd -->
								<jsp:useBean id="expireDateValue" class="java.util.Date" />
								<jsp:setProperty name="expireDateValue" property="time" value="${voucher.expireDate}" />
								<fmt:formatDate value="${expireDateValue}" pattern="yyyy-MM-dd" />
							</td>
							<td>${voucher.number}</td>
							<td>
								<c:if test="${voucher.status=='available'}"><spring:message code='sys.client.available'></spring:message> </c:if><!-- 可使用 -->
								<c:if test="${voucher.status=='using'}"><spring:message code='sys.client.using'></spring:message></c:if><!-- 使用中 -->
								<c:if test="${voucher.status=='used'}"><spring:message code='sys.client.used'></spring:message></c:if><!-- 已使用 -->
							</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../../common/page.jsp" />
			</div>
		</form>
		<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>