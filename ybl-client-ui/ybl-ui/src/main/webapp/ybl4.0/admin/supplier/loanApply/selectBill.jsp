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
		
		<form action="/loanApplyV4Controller/loanApply/selectBill.htm" id="pageForm" method="post">
			<input type="hidden" name="selectIds" value="${selectIds }">
			<input type="hidden" name="financingApplyId" value="${billVO.financingApplyId }">
			<div class="ybl-info">
				<div class="ground-form mb20">
					<div class="form-grou mr40"><label>资产编号：</label><input class="content-form" name="assetNumber" value="${billVO.assetNumber }"/></div>
					<div class="form-grou mr40"><label>承兑人名称：</label><input class="content-form" name="acceptorName" value="${billVO.acceptorName }"/></div>
					<div class="form-grou"><a href="javascript:;" class="btn-modify" id="btn-query">查询</a></div>
				</div>
			</div>
		
			<div class="aj-cont mt40">
				<div class="tabD">
					<table>
						<tr>
							<th></th>
							<th>资产编号</th>
							<th>承兑人名称</th>
							<th>票据号码</th>
							<th>合同/订单信息</th>
							<th>合同/订单金额(元)</th>
							<th>合同/订单单价(元)</th>
							<th>合同/订单数量(个)</th>
							<th>票据金额(元)</th>
							<th>出票日期</th>
							<th>到期日期</th>
							<th>签署日期</th>
							<th>发票信息</th>
							<th>备注</th>
						</tr>
						<c:forEach items="${billList}" varStatus="index" var="obj">
							<c:if test="${obj.isCheck ne true}"><tr>
								<td><input name="checkId" type="checkbox" 
									<%-- <c:if test="${obj.isCheck == true}">checked="checked"</c:if> --%> 
									value="${obj.id}"
									ubusinessid="${obj.businessId }"
									uassetnumber="${obj.assetNumber }"
									uacceptorname="${obj.acceptorName }"
									ubillno="${obj.billNo }"
									uorderinfo="${obj.orderInfo }"
									uorderamount="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>"
									uorderunitprice="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>"
									uordernumber="${obj.orderNumber  }"
									ubillamount="<fmt:formatNumber value="${obj.billAmount }" pattern="##0.##" maxFractionDigits="2"/>"
									uexpiredate="<fmt:formatDate value='${obj.expireDate }' pattern="yyyy-MM-dd" />"
									ubillingdate="<fmt:formatDate value='${obj.billingDate }' pattern="yyyy-MM-dd" />"
									usigndate="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />"
									uinvoiceinfo="${obj.invoiceInfo  }"
									uremark="${obj.remark  }"
									ufinancingapplyid="${obj.financingApplyId }"/>
								</td>
								<td><input type="text" class="tdinput" readonly value="${obj.assetNumber }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.acceptorName }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.billNo }"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.orderInfo }"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.orderAmount }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.orderUnitPrice }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="${obj.orderNumber }"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatNumber value="${obj.billAmount }" pattern="##0.##" maxFractionDigits="2"/>"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatDate value='${obj.expireDate }' pattern="yyyy-MM-dd" />"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatDate value='${obj.billingDate }' pattern="yyyy-MM-dd" />"></td>
								<td><input type="text" class="tdinput" readonly value="<fmt:formatDate value='${obj.signDate }' pattern="yyyy-MM-dd" />"></td>
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
				var chkBusinessIds = [];
				var chkAssetnumber = [];
				var chkAcceptorname = [];
				var chkBillno = [];
				var chkOrderinfo = [];
				var chkOrderamount = [];
				var chkOrderunitprice = [];
				var chkOrdernumber = [];
				var chkBillamount = [];
				var chkExpiredate = [];
				var chkBillingdate = [];
				var chkSigndate = [];
				var chkInvoiceinfo = [];
				var chkRemark = [];
				var chkFinancingapplyid = [];
				$("input[name='checkId']:checked").each(function() {
					var uacceptorname = $(this).attr("uacceptorname");
					var ubusinessid = $(this).attr("ubusinessid");
					var uassetnumber = $(this).attr("uassetnumber");
					var ubillno = $(this).attr("ubillno");
					var uorderinfo = $(this).attr("uorderinfo");
					var uorderamount = $(this).attr("uorderamount");
					var uorderunitprice = $(this).attr("uorderunitprice");
					var uordernumber = $(this).attr("uordernumber");
					var ubillamount = $(this).attr("ubillamount");
					var uexpiredate = $(this).attr("uexpiredate");
					var ubillingdate = $(this).attr("ubillingdate");
					var usigndate = $(this).attr("usigndate");
					var uinvoiceinfo = $(this).attr("uinvoiceinfo");
					var uremark = $(this).attr("uremark");
					var ufinancingapplyid = $(this).attr("ufinancingapplyid");
					chkIds.push($(this).val());
					chkBusinessIds.push(ubusinessid);
					chkAssetnumber.push(uassetnumber);
					chkAcceptorname.push(uacceptorname);
					chkBillno.push(ubillno);
					chkOrderinfo.push(uorderinfo);
					chkOrderamount.push(uorderamount);
					chkOrderunitprice.push(uorderunitprice);
					chkOrdernumber.push(uordernumber);
					chkBillamount.push(ubillamount);
					chkExpiredate.push(uexpiredate);
					chkBillingdate.push(ubillingdate);
					chkSigndate.push(usigndate);
					chkInvoiceinfo.push(uinvoiceinfo);
					chkRemark.push(uremark);
					chkFinancingapplyid.push(ufinancingapplyid);
				});
				var billIds = window.parent.document.getElementById("billIds");
				var billAfter =window.parent.document.getElementById("billAfter");
				// 每次添加先清除
				var billTb =window.parent.document.getElementById("billTb");
				//$(billTb).find(".addBill").remove();
				if (chkIds.length > 0) {
					$(billIds).val(chkIds.join(","));
	                
                    for(var i=0;i<chkIds.length;i++){
                        var appendstr = "";
                        appendstr += "<tr class='chkBillTr addBill' uid="+chkIds[i]+">";
                        appendstr += "<td><input type='text' class='tdinput chkBillAssetNumber' style='color:#666' readonly name='billList["+i+"].assetNumber' value='"+chkAssetnumber[i]+"' /></td>";
                        appendstr += "<td>";
                        appendstr += "<input type='hidden' value="+chkIds[i]+" name='billList["+i+"].pid' />";
                        appendstr += "<input type='hidden' value="+chkFinancingapplyid[i]+" name='billList["+i+"].financingApplyId' />";
                        appendstr += "<input type='hidden' value="+chkBusinessIds[i]+" name='billList["+i+"].businessId' />";
                        appendstr += "<input type='text' class='tdinput checkBill' style='color:#666' readonly name='billList["+i+"].acceptorName' value='"+chkAcceptorname[i]+"' />";
                        appendstr += "</td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].billNo' value='"+chkBillno[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].orderInfo' value='"+chkOrderinfo[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].orderAmount' value='"+chkOrderamount[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].orderUnitPrice' value='"+chkOrderunitprice[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].orderNumber' value='"+chkOrdernumber[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].billAmount' value='"+chkBillamount[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].expireDate' value='"+chkExpiredate[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].billingDate' value='"+chkBillingdate[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].signDate' value='"+chkSigndate[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].invoiceInfo' value='"+chkInvoiceinfo[i]+"' /></td>";
                        appendstr += "<td><input type='text' class='tdinput ' style='color:#666' readonly name='billList["+i+"].remark' value='"+chkRemark[i]+"' /></td>";
                        appendstr += "<td><a class='btn-modify' onclick='billDeleteRow(this,null)'>删除</a></td>";
                        appendstr += "</tr>";
                        $(billTb).append(appendstr);
                    }
                    
                    // 循环tr
                    $(billTb).find(".addBill").each(function(i,item){
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