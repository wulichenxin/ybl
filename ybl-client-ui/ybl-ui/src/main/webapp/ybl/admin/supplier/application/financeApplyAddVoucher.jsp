<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理</title>
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
	$(function() {

		$("#financeAddVoucherAddBtn").click(function() {
			location.href = '/voucherController/toVoucherAdd';
		});

		//全选
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

		$("#financeApplyVoucherAddBtn").click(function() {
			fillToParentPage();
		})
		
		//查询凭证信息
		$("#queryVocherByConditionBtn").click(function() {
			$("#pageForm").submit();
		})
		
		
		resetForm = function(){
			$("input[name='voucherNo']").val("");
			$("input[name='enterpriseName']").val("");
			$("select[name='enterpriseName']").val("");
			
		}
	})

	function fillToParentPage() {
		var subject_voucher_tb_length = parent.$("#financeApplyVoucherTable").find("tr").length;
		var tb_html_ = '';
		var checkArr = $("input[type='checkbox']:checked");
		var checkValue  = [];
		$.each(checkArr,function(i,item){
			if($(item).val()){
				checkValue.push($(item));
			}
		})
		
		if(!checkValue){
			alert("请选择要添加的凭证");
			return false;
		}
		
		$.each(checkValue, function(i, item) {
			if ($(item).val()) {
				var tb_html_ = '';
				var voucherId = $(this).val();
				var voucherNo = $(this).parent().parent().find("td").eq(2).html();
				var enterpriseName = $(this).parent().parent().find("td").eq(3).html();
				var amount = $(this).parent().parent().find("td").eq(4).html();
				var type = $(this).parent().parent().find("td").eq(5).html();
				var expireDate = $(this).parent().parent().find("td").eq(6).html();
				var lastUpdateTime = $(this).parent().parent().find("td").eq(7).html();
				var url = $(this).attr("url");
				tb_html_ += "<tr >";
				tb_html_ += "<td><input type='checkbox' name='financeApplyVoucher' value="+voucherId+" /></td>";
				tb_html_ += "<td>" + (i+subject_voucher_tb_length) + "</td>";
				tb_html_ += "<td>" + voucherNo + "</td>";
				tb_html_ += "<td>" + enterpriseName + "</td>";
				tb_html_ += "<td>" + amount + "</td>";
				tb_html_ += "<td>" + type + "</td>";
				tb_html_ += "<td>" + expireDate + "</td>";
				tb_html_ += "<td>" + lastUpdateTime + "</td>";
				tb_html_ += "<td><div class='qy'><a href='javascript:view(\""+url+"\")'>预览</a></div></td>";
				tb_html_+= "</tr>";

				parent.$("#financeApplyVoucherTable").children().children("tr:last-child").after(tb_html_);
			}
		})
		
		/*调用父页面的计算还款日期的方法*/
		parent.calcRepaymentDate();
		parent.CalcmaxLoanAmount();
		
		//关闭弹出框
		parent.$(".msgbox_close").mousedown();
	}
</script>
</head>
<body>
	<div class="vip_conbody">

		<!--搜索条件-->
		<form action="/loanApplicationController/addFinanceApplyVoucher"
			id="pageForm" method="post">
			<div class="seach_box">
				<div class="switch" onclick="hideform();">
					<a></a>
				</div>
				<div class="fl">
					<ul>
						<input type="hidden" name="addedMaterialId" value="${addedMaterialId}" />
						<li><label>凭证编码:</label><input name="voucherNo" type="text" value="${voucher.voucherNo }" /></li>
						<li><label>核心企业:</label> <select name="enterpriseName">
								<option value="">全部</option> 
								<c:forEach items="${enterList}" var="enter">
									<option value="${enter.enterpriseName }" <c:if test="${enter.enterpriseName == voucher.enterpriseName }">selected='selected' </c:if> > ${enter.enterpriseName }</option>
								</c:forEach>
						</select></li>
						<li><div class="button_yellow">
								<a id="queryVocherByConditionBtn">查询</a>
							</div></li>
						<li><div class="button_gary">
								<a onclick="resetForm()">重置</a>
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
							<li><a id="financeApplyVoucherAddBtn" class="but_ico7">保存</a></li>
							<!-- <li><a id="financeAddVoucherAddBtn" class="but_ico7">添加</a></li> -->
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="table_con">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr id="trr">
							<th width="50"><input id="checkAll" name="" type="checkbox"
								value="" /></th>
							<th width="50">序号</th>
							<th>凭证编码</th>
							<th>核心企业名称</th>
							<th>凭证面额(元)</th>
							<th>凭证类型</th>
							<th>凭证到期日</th>
							<th>上传时间</th>
						</tr>

						<c:forEach items="${voucherList}" var="voucher"
							varStatus="status_var">
							<c:if test="${status_var.count % 2 == 0}">
								<tr>
							</c:if>
							<c:if test="${status_var.count % 2 !=0 }">
								<tr class="bg_l">
							</c:if>
							<td><input type="checkbox" value="${voucher.id}"
								url="${voucher.picUrls }" /></td>
							<td>${status_var.count }</td>
							<td>${voucher.voucherNo}</td>
							<td>${voucher.enterpriseName}</td>
							<td><fmt:formatNumber value="${voucher.amount}"  pattern="0.00"></fmt:formatNumber></td>
							<td>${voucher.type}</td>
							<td>
								<!-- 时间戳转换为时间yyyy-mm-dd -->
								<jsp:useBean id="expireDateValue" class="java.util.Date" />
								<jsp:setProperty name="expireDateValue" property="time" value="${voucher.expireDate}" />
								<fmt:formatDate value="${expireDateValue}" pattern="yyyy-MM-dd" />
							</td>
							<td><fmt:formatDate value="${voucher.lastUpdateTime}" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../../common/page.jsp" />
			</div>
		</form>
		<!--table-->
	</div>
</body>
</html>