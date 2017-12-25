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
<title><spring:message code="sys.client.voucher.manage"/></title><!-- 凭证管理 -->
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript">
	$(function() {
		//进入添加凭证界面
		$("#member_supplier_details_voucher_add_btn").click(function(){
			$.msgbox({
				height:648,
				width:1000,
				content: '/voucherController/toVoucherAdd',
					type : 'iframe',
					title : '添加凭证'
				});
		});
		// 添加凭证信息到标的凭证表
		$("#member_supplier_details_voucher_save_btn").click(function() {
			//没有数据的情况
			var subject_voucher_table_length = $("#subject_voucher_table").find("tr").length;
			if(subject_voucher_table_length<=1){
				return ;
			}
			//有数据没选中的情况
			var len =$("input:checkbox[name='checkbox1']:checked").length;
			if(len<1){
				alert($.i18n.prop("sys.client.please.select.fllow.voucher.then.operate"));//请选择以下凭证后，再进行操作。
				return;
			}
			fillToParentPage();
		});
		// 全选 复选框
	$("#checkAll").click(function() {
		var isCheckAll = $("#checkAll").attr("checked");
		if (isCheckAll) {// 选中
			$("[name='checkbox1']").attr("checked", true);
			$("[name='checkbox1']").val("1");
		} else {// 取消全选
			$("[name='checkbox1']").attr("checked", false);
			$("[name='checkbox1']").val("0");
		}
	});
	//判断复选框是否全部勾选，全部勾选则选中全选按钮，否则不勾选全选按钮
	$("[name='checkbox1']").click(function(){
		var allcheckBoxLength = $("[name='checkbox1']").length;
		var allcheckedBoxLength = $("input:checkbox[name='checkbox1']:checked").length;
		if(allcheckBoxLength==allcheckedBoxLength){
			$("#checkAll").attr("checked", true);
		}else{
			$("#checkAll").attr("checked", false);
		}
		if($(this).attr("value")=='0'){
			$("[name='checkbox']").attr("checked",true);
			$(this).attr("value",'1')
		}else{
			$("[name='checkbox']").attr("checked",false);
			$(this).attr("value",'0')
		}
	})
	});
	function fillToParentPage(){
		var subject_voucher_tb_length = parent.$("#subject_voucher_tb").find("tr").length;
		var tb_html_=[];
		var checkArr = $("[name='checkbox1']");
		var index=0;
		var enterprise_member_id_arr=[];
		$.each(checkArr,function(i,item){
			var enterpriseMemeberId = $(this).attr("enterpriseMemeberId")
			if($(this).attr("value")=='1'){
				var no = subject_voucher_tb_length+index;
				var voucherId = $(this).attr("voucherId");
				if($.inArray(enterpriseMemeberId,enterprise_member_id_arr)<0){
					enterprise_member_id_arr.push(enterpriseMemeberId);
				}
				var voucherNo = $(this).parent().parent().find("td").eq(2).html();
				var enterpriseName = $(this).parent().parent().find("td").eq(3).html();
				var amount = $(this).parent().parent().find("td").eq(4).html();
				var type = $(this).parent().parent().find("td").eq(5).html();
				var effectiveDate = $(this).parent().parent().find("td").eq(6).html();
				var expireDate = $(this).parent().parent().find("td").eq(7).html();
				var lastUpdateTime = $(this).parent().parent().find("td").eq(8).html();
				var url = $(this).attr("url");
				tb_html_.push("<tr>");
				tb_html_.push("<td><input type='checkbox' value='0' name='checkbox' ids='-1' voucherId='"+voucherId+"'/></td>");
				tb_html_.push("<td>"+no+"</td>");
				tb_html_.push("<td>"+voucherNo+"</td>");
				tb_html_.push("<td>"+enterpriseName+"</td>");
				tb_html_.push("<td>"+amount+"</td>");
				tb_html_.push("<td>"+type+"</td>");
				tb_html_.push("<td>"+effectiveDate+"</td>");
				tb_html_.push("<td>"+expireDate+"</td>");
				tb_html_.push("<td>"+lastUpdateTime+"</td>");
				tb_html_.push("<td><div class='qy'>");
				tb_html_.push("<a href='javascript:view(\""+url+"\");'>预览</a></div>");
				tb_html_.push("<input type='hidden' name='subjectVoucherList["+no+"].attribute1' value='"+enterpriseMemeberId+"' vou_type_id='vou_type_id'/>");
				tb_html_.push("<input type='hidden' name='subjectVoucherList["+no+"].voucherId' value='"+voucherId+"'/>");
				tb_html_.push("<input type='hidden' name='subjectVoucherList["+no+"].voucherStatus' value='not_certified'/></td>");
				tb_html_.push("</tr>");	
				index++;
			}
		})
		if(enterprise_member_id_arr.length>1){
			alert("请选择同一个核心企业的凭证后，再进行操作！")
			return;
		}else{
			parent.$("#subject_voucher_tb").append(tb_html_.join(""));
			//计算还款日期
			parent.calcRepaymentDate();
			//关闭弹出框
			parent.$(".msgbox_close").mousedown();
		}
	}

</script>
</head>
<body>
	<div class="vip_conbody">
		<form action="/voucherController/toVoucherSelect-${ids}" id="pageForm" method="post">
			<!--table-->
			<div class="table_box">
				<div class="table_top ">
					<div class="table_nav">
						<ul>
							<%-- <li><sun:button id="member_supplier_details_voucher_add_btn"
									tag='a' clazz="but_ico7" i18nValue="sys.client.add" /></li> --%>
							<!-- 添加 -->
							<li><a id="member_supplier_details_voucher_save_btn" class="but_ico7">
									<spring:message code="sys.client.save" />
								</a></li>
							<!-- 保存 -->
						</ul>
					</div>
				</div>
				<!--按钮top-->
				<div class="table_con">
					<input type='hidden' id='subjectId' name='subjectId' />
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="subject_voucher_table">
						<tr>
							<th width="50"><input type="checkbox" value="" id='checkAll'/></th>
							<th width="50"><spring:message code="sys.client.no"/></th><!-- 序号 -->
							<th><spring:message code="sys.client.voucherNumber"/></th><!-- 凭证编码 -->
							<th><spring:message code="sys.client.coreCompanyName"/></th><!-- 核心企业名称 -->
							<th>
								<spring:message code="sys.client.voucherUnit"/>
							</th><!-- 凭证面额（万元） -->
							<th><spring:message code="sys.client.voucherType"/></th><!-- 凭证类型 -->
							<th><spring:message code="sys.client.voucher.start.time"/></th><!-- 凭证起始日 -->
							<th><spring:message code="sys.client.voucherOverdueTime"/></th><!-- 凭证到期日-->
							<th><spring:message code="sys.client.uploadTime"/></th><!-- 上传时间-->
						</tr>

						<c:forEach items="${voucherList}" var="voucher"
							varStatus="status_var">
							<c:if test="${status_var.count % 2 == 0}">
								<tr>
							</c:if>
							<c:if test="${status_var.count % 2 !=0 }">
								<tr class="bg_l">
							</c:if>
							<td><input type="checkbox" value="0" name="checkbox1" url="${voucher.picUrls }"
								voucherId="${voucher.id}" enterpriseMemeberId ="${voucher.enterpriseMemeberId}"/></td>
							<td>${status_var.count }</td>
							<td>${voucher.voucherNo}</td>
							<td>${voucher.enterpriseName}</td>
							<td><fmt:formatNumber value="${voucher.amount/10000}" pattern="#,##0.00" maxFractionDigits="2"/></td>
							<td>${voucher.type}</td>
							<td>
								<!-- 时间戳转换为时间yyyy-mm-dd -->
								<jsp:useBean id="dateValue" class="java.util.Date" />
								<jsp:setProperty name="dateValue" property="time" value="${voucher.effectiveDate}" />
								<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
							</td>
							<td>
								<!-- 时间戳转换为时间yyyy-mm-dd -->
								<jsp:useBean id="dateValue1" class="java.util.Date" />
								<jsp:setProperty name="dateValue1" property="time" value="${voucher.expireDate}" />
								<fmt:formatDate value="${dateValue1}" pattern="yyyy-MM-dd" />
							</td>
							<td>
								<fmt:formatDate value="${voucher.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss" />
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
</body>
</html>