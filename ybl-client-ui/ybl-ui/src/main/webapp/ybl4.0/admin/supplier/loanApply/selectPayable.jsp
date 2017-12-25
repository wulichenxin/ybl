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
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		
	</head>

	<body>
		
		<form action="/loanApplyV4Controller/loanApply/selectPayable.htm" id="pageForm" method="post">
			<input type="hidden" name="selectIds" value="${selectIds }">
			<input type="hidden" name="financingApplyId" value="${accountsPayableVO.financingApplyId }">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>资产编号：</label><input class="content-form" name="assetNumber" value="${accountsPayableVO.assetNumber }"/></div>
					<div class="form-grou mr40"><label>供应商名称：</label><input class="content-form" name="supplierName" value="${accountsPayableVO.supplierName }"/></div>
					<div class="form-grou"><a href="javascript:;" class="btn-modify" id="btn-query">查询</a></div>
				</div>
			</div>
		
			<div class="aj-cont mt40">
				<div class="tabD">
					<table>
						<tr>
							<th></th>
							<th>资产编号</th>
							<th>供应商名称</th>
							<th>合同/订单信息</th>
							<th>合同/订单金额(元)</th>
							<th>合同/订单单价(元)</th>
							<th>合同/订单数量(个)</th>
							<th>应付账款金额(元)</th>
							<th>签署日期</th>
							<th>预支付日期</th>
							<th>发票信息</th>
							<th>备注</th>
						</tr>
						<c:forEach items="${repayableList}" varStatus="index" var="obj">
							<c:if test="${obj.isCheck ne true}"><tr>
								<td>
									<input name="checkId" type="checkbox" 
									<%-- <c:if test="${obj.isCheck == true}">checked="checked"</c:if> --%> 
									value="${obj.id}"
									ubusinessid="${obj.businessId }"
									uassetnumber="${obj.assetNumber }"
									usuppliername="${obj.supplierName }"
									uorderinfo="${obj.orderInfo }"
									uorderamount="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>"
									uorderunitprice="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>"
									uordernumber="${obj.orderNumber  }"
									uamountspayablemoney="<fmt:formatNumber value="${obj.amountsPayableMoney }" pattern="##0.##" maxFractionDigits="2"/>"
									usigndate="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />"
									uexpectedpaymentdate="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />"
									uinvoiceinfo="${obj.invoiceInfo  }"
									uremark="${obj.remark  }"
									ufinancingapplyid="${obj.financingApplyId }"/>
								</td>
								<td><input type="text" class="tdinput" readonly value="${obj.assetNumber }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.supplierName }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.orderInfo }"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.orderNumber }"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.amountsPayableMoney }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatDate value='${obj.expectedPaymentDate }' pattern="yyyy-MM-dd" />"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.invoiceInfo }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.remark }"></td>
							</tr></c:if>
						</c:forEach>
					</table>
				</div>
				<div class="btn2 clearfix mb80 mt40">
					<a href="javascript:;" class="btn-add" id="btn-select-all">确定</a>
					<a onclick="dialog.close();" class="btn-add">取消</a>
				</div>
			</div>
		
		</form>
		
		<script>
			$('#btn-query').click(function(){
				$("#pageForm").submit();
			});
			// 选择确定
			$("#btn-select-all").click(function() {
				var chkIds = [];
				var chkBusinessids = [];
				var chkAssetnumber = [];
				var chkSuppliername = [];
				var chkOrderinfo = [];
				var chkOrderamount = [];
				var chkOrderunitprice = [];
				var chkOrdernumber = [];
				var chkAmountspayablemoney = [];
				var chkSigndate = [];
				var chkExpectedpaymentdate = [];
				var chkInvoiceinfo = [];
				var chkRemark = [];
				var chkFinancingapplyid = [];
				$("input[name='checkId']:checked").each(function() {
					var ubusinessid = $(this).attr("ubusinessid");
					var usuppliername = $(this).attr("usuppliername");
					var uassetnumber = $(this).attr("uassetnumber");
					var uorderinfo = $(this).attr("uorderinfo");
					var uorderamount = $(this).attr("uorderamount");
					var uorderunitprice = $(this).attr("uorderunitprice");
					var uordernumber = $(this).attr("uordernumber");
					var uamountspayablemoney = $(this).attr("uamountspayablemoney");
					var usigndate = $(this).attr("usigndate");
					var uexpectedpaymentdate = $(this).attr("uexpectedpaymentdate");
					var uinvoiceinfo = $(this).attr("uinvoiceinfo");
					var uremark = $(this).attr("uremark");
					var ufinancingapplyid = $(this).attr("ufinancingapplyid");
					chkIds.push($(this).val());
					chkBusinessids.push(ubusinessid);
					chkAssetnumber.push(uassetnumber);
					chkSuppliername.push(usuppliername);
					chkOrderinfo.push(uorderinfo);
					chkOrderamount.push(uorderamount);
					chkOrderunitprice.push(uorderunitprice);
					chkOrdernumber.push(uordernumber);
					chkAmountspayablemoney.push(uamountspayablemoney);
					chkSigndate.push(usigndate);
					chkExpectedpaymentdate.push(uexpectedpaymentdate);
					chkInvoiceinfo.push(uinvoiceinfo);
					chkRemark.push(uremark);
					chkFinancingapplyid.push(ufinancingapplyid);
				});
				var payableIds = window.parent.document.getElementById("payableIds");
				var repayableAfter =window.parent.document.getElementById("repayableAfter");
				// 每次添加先清除
				var repayableTb =window.parent.document.getElementById("repayableTb");
				//$(repayableTb).find(".chkRepayableTr").remove();
				if (chkIds.length > 0) {
					$(payableIds).val(chkIds.join(","));
					
                   	for(var i=0;i<chkIds.length;i++){
                           var appendstr = "";
                           appendstr += "<tr class='chkRepayableTr addRepayable' uid="+chkIds[i]+">";
                           appendstr += "<td><input type='text' class='tdinput chkRepayableAssetNumber' style='color:#666' readonly name='repayableList["+i+"].assetNumber' value='"+chkAssetnumber[i]+"' /></td>";
                           appendstr += "<td>";
                           appendstr += "<input type='hidden' value="+chkIds[i]+" name='repayableList["+i+"].pid' />";
                           appendstr += "<input type='hidden' value="+chkFinancingapplyid[i]+" name='repayableList["+i+"].financingApplyId' />";
                           appendstr += "<input type='hidden' value="+chkBusinessids[i]+" name='repayableList["+i+"].businessId' />";
                           appendstr += "<input type='text' class='tdinput checkRepayable' style='color:#666' readonly name='repayableList["+i+"].supplierName' value='"+chkSuppliername[i]+"' />";
                           appendstr += "</td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].orderInfo' value='"+chkOrderinfo[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].orderAmount' value='"+chkOrderamount[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].orderUnitPrice' value='"+chkOrderunitprice[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].orderNumber' value='"+chkOrdernumber[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].amountsPayableMoney' value='"+chkAmountspayablemoney[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].signDate' value='"+chkSigndate[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].expectedPaymentDate' value='"+chkExpectedpaymentdate[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].invoiceInfo' value='"+chkInvoiceinfo[i]+"'/></td>";
                           appendstr += "<td><input type='text' class='tdinput' style='color:#666' readonly name='repayableList["+i+"].remark' value='"+chkRemark[i]+"'/></td>";
                           appendstr += "<td><a class='btn-modify' onclick='repayableDeleteRow(this,null)'>删除</a></td>";
                           appendstr += "</tr>";
                           $(repayableTb).append(appendstr);
                       }
                       
                       // 循环tr
                       $(repayableTb).find(".addRepayable").each(function(i,item){
                           //循环td
                           $(item).find("input").each(function(){
                               var name=$(this).attr("name");
                               var first=name.indexOf("[");
                               var last =name.indexOf("]");
                               name=name.replace(name.substring(first+1,last),i);
                               $(this).attr("name",name);
                           });
                       });
                       dialog.close();
				} else {
					dialog.close();
				}
				
			});
		</script>
	</body>

</html>