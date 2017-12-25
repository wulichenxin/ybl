<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"
	deferredSyntaxAllowedAsLiteral="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证确认</title>
<jsp:include page="../common/link.jsp"/>
<!--弹出框-->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/form.js"></script>
<script type="text/javascript">
$(function(){   
	var status = "${status}";
	$("#status").val(status);
	
	/* 加减按钮展示隐藏列表 */
	$(".open").click(function(){
		$(this).hide();
		$(this).next(".close").show();
		$(this).parent().parent().parent().next(".z_table").slideDown(100);
	  });
		
	$(".close").click(function(){
		$(this).hide();
		$(this).prev(".open").show();
		$(this).parent().parent().parent().next(".z_table").slideUp(100);
	  });
	
	$("#selectAll").click(function(){
		$("input[name='financeApplyId']").prop("checked",$(this).prop("checked"));
	});
}); 

function voucherComfirm() {
	var id_array=new Array();
	$('input[name="financeApplyId"]:checked').each(function(){
	    id_array.push($(this).val());//向数组中添加元素
	});
	if(id_array.length < 1) {
		alert('请先选择数据');
		return;
	}
	$.msgbox({
		height:430,
		width:620,
		content:'/ybl/admin/enterprise/audit.jsp',
		type :'iframe',
		title: '审核'
	});
	var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串
	$("#financeIds").val(idstr);
}

</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp?step=1" />
	<!--top end -->
	<div class="path"><spring:message code="sys.client.location"/>-><spring:message code="sys.client.voucher.manage"/> -> <spring:message code="sys.client.loan.sure"/></div>
	<div class="vip_conbody">

		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<form action="/voucherAudit/voucherConfirm" id="pageForm" method="post">
				<input type="hidden" id="pageNumber" name="currentPage" value="1" />
				<input type="hidden" id="pageSize" name="pageSize" value="10"/>
				<ul>
					<li><label>融资编号:</label><input type="text" name="number" value="${number }" /></li>
					<li><label>客户名称:</label><input type="text" name="enterpriseName" value="${enterpriseName }" /></li>
					<li><label>确认状态:</label><select id="status" name="status">
							<option value="">全部</option>
							<option value="not_certified">待确认</option>
							<option value="certified">已通过</option>
							<option value="certify_fail">已拒绝</option>
							</select></li>
					<li><div class="button_yellow">
							<a id="searchBtn">查询</a>
						</div></li>
					<li><div class="button_gary">
							<a id="resetBtn">重置</a>
						</div></li>
				</ul>
				</form>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box">
			<div class="table_top">
				<div class="table_nav">
					<ul>
						<!-- <li><a class="but_ico3">查看</a></li> -->
						<li><a class="but_ico2" href="javascript:voucherComfirm();">确认</a></li>
						<input id="financeIds" type="hidden" value=""/> 
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><input id="selectAll" name="" type="checkbox" value="" /></th>
						<th>序号</th>
						<th>融资编号</th>
						<th>客户名称</th>
						<th>营业执照号</th>
						<th>企业法人</th>
						<th>联系电话</th>
						<th>保理商名称</th>
						<th>保理类型</th>
						<th>融资金额/万元</th>
						<th>贷款利率</th>
						<th>确认状态</th>
						<th></th>
					</tr>
					<c:forEach var="voucher" items="${vouchers}" varStatus="index" >
						<tr>
							<td>
								<c:if test="${voucher.status == 'not_certified' }">
		                        	<input name="financeApplyId" type="checkbox" value="${voucher.isLoan}_${voucher.id}" />
	                        	</c:if>
	                        	<c:if test="${voucher.status != 'not_certified' }">
	                        		<input type="checkbox" value="${voucher.isLoan}_${voucher.id}" disabled="disabled" />
	                        	</c:if>
							</td>
							<td>${index.count}</td>
							<td>
								<c:if test="${voucher.isLoan == 'loansign' }">
									<a href="/subjectController/lookSubject-${voucher.id}" target="_blank">${voucher.number }</a>
								</c:if>
								<c:if test="${voucher.isLoan != 'loansign' }">
									<a href="/voucherAudit/queryDetail?id=${voucher.id}" target="_blank">${voucher.number }</a>
								</c:if>
							</td>
							<td>${voucher.enterpriseName }</td>
							<td>${voucher.licenseNo }</td>
							<td>${voucher.legalName }</td>
							<td>${voucher.legalPhone }</td>
							<td>${voucher.fEnterpriseName }</td>
							<td>
								<c:if test="${voucher.type == 'online_factor' }">
									明保理
								</c:if>
								<c:if test="${voucher.type == 'dark_factor' }">
									暗保理
								</c:if>
							</td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${voucher.applyAmount/10000 }" /> </td>
							<td><fmt:formatNumber type="number" pattern="##0.00" value="${voucher.rate }" />%</td>
							<td>
								<c:if test="${voucher.status == 'not_certified' }">
									待确认
								</c:if>
								<c:if test="${voucher.status == 'certified' }">
									已通过
								</c:if>
								<c:if test="${voucher.status == 'certify_fail' }">
									已拒绝
								</c:if>
							</td>
							<td><div class="but_ss">
								<a class="open "></a><a class="close" style="display: none;"></a>
							</div></td>
						</tr>
						<tr class="z_table ">
						<td colspan="14">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb1">
								<tr>
									<th width="50"></th>
									<th width="50"></th>
									<th>序号</th>
									<th>凭证编码</th>
									<th>核心企业名称</th>
									<th>凭证面额（万元）</th>
									<th>凭证类型</th>
									<th>凭证到期日</th>
								</tr>
								<c:forEach var="favoucher" items="${voucher.faVouchers}" varStatus="faindex" >
								<tr>
									<td></td>
									<td></td>
									<td>${faindex.count}</td>
									<td>${favoucher.voucherNo }</td>
									<td>${favoucher.enterpriseName }</td>
									<td>￥<fmt:formatNumber type="number" pattern="##0.00" value="${favoucher.amount/10000 }" /></td>
									<td>${favoucher.type }</td>
									<td>
									<fmt:parseDate var="newDate" value="${favoucher.expireDate }" pattern="yyyy-MM-dd" />
									<fmt:formatDate value="${newDate }" pattern="yyyy-MM-dd" />
									</td>
								</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					</c:forEach>
				</table>

			</div>
			<jsp:include page="../common/page.jsp"></jsp:include>
		</div>
		<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>