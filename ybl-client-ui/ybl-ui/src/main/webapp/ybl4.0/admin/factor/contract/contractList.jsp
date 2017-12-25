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
	</head>
	<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
		
		<c:if test="${type eq 1}">
			<div class="Bread-nav">
				<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />合同管理</div>
			</div>
		</c:if>
		<c:if test="${type ne 1}">
			<div class="Bread-nav">
				<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />合同查询</div>
			</div>
		</c:if>
		<form action="/contractController/goInfo.htm" id="goContractinfo" method="post">
			<input type="hidden" value="" name="master_contract_no" id="master_contract_no"/>
		</form>
		<form action="/contractQuotaV4Controller/contractQuery/list.htm" id="pageForm" method="post">
			<input type="hidden" name="type" value="${type }"/>
			<div class="w1200 ybl-info">
				<div class="btn-found" id="query">查询</div>
				<div class="ground-form mb20">
					<div class="form-grou mr40">
						<label>融资订单号：</label>
						<input class="content-form" name="orderNo" value="${vo.orderNo }"/>
					</div>
					<div class="form-grou mr40">
						<label  style="width:60px;">融资方：</label>
						<input class="content-form" name="financier" value="${vo.financier }" />
					</div>
					<div class="form-grou">
						<label class="label-long">放款申请时间：</label>
						<input id="beginDate" class="content-form" name="startApplyDate" value="${vo.startApplyDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
					<span class="mr10 ml10">-</span>
					<div class="form-grou mr40">
						<input id="endDate" class="content-form" name="endApplyDate" value="${vo.endApplyDate }"/><img class="timeimg" src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" />
					</div>
				</div>
			</div>
		
		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>融资方名称</th>
							<th>保理类型</th>
							<th>资产类型</th>
							<th>融资方式</th>
							<th>融资申请金额(元)</th>
							<th>批复额度(元)</th>
							<!-- <th>保理服务费(元)</th> -->
							<th>融资期限(天)</th>
							<th>申请日期</th>
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:if test="${empty list}">
								<tr><td colspan="15">暂无数据</td></tr>
							</c:if>
						<c:forEach items="${list}" var="obj" varStatus="index">
			              	<tr>
								<td class="toggletr">${index.count}</td>
								
								<td>
									<c:if test="${empty obj.status}"><a href="#" url="" onclick="jumpPost('/contractQuotaV4Controller/createContract',{id:${obj.id}})">${obj.orderNo}</a></c:if>
									<c:if test="${not empty obj.status and obj.status eq 1 or obj.status eq 2}"><a href="#" url= "" master_contract_no ="${obj.orderNo }"  class="show">${obj.orderNo}</a></c:if>
								</td>
								
								<td>${obj.financier}</td>
								<td>
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 1}">明保理</c:if>
									<c:if test="${not empty obj.factoringMode and obj.factoringMode eq 2}">暗保理</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 1}">应收账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 2}">应付账款</c:if>
									<c:if test="${not empty obj.assetsType and obj.assetsType eq 3}">票据</c:if>
								</td>
								<td>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 1}">签约资方</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 2}">平台推荐</c:if>
									<c:if test="${not empty obj.financingMode and obj.financingMode eq 3}">竞标</c:if>
								</td>
								<td><fmt:formatNumber value="${obj.financingAmount}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<td><fmt:formatNumber value="${obj.giveQuota}" pattern="#,##0.##" maxFractionDigits="2"/></td>
								<%-- <td><fmt:formatNumber value="${obj.serviceFee}" pattern="##0.##" maxFractionDigits="2"/></td> --%>
								<td>${obj.financingTerm}</td>
								<td><fmt:formatDate value="${obj.createdTime}" pattern="yyyy-MM-dd" /></td>
								<td>
									
									<c:if test="${not empty vo.financingStatus and vo.financingStatus eq 8}">待签署合同</c:if>
									<c:if test="${not empty vo.financingStatus and vo.financingStatus eq 9}">融资完成</c:if>
									
								</td>
								<td>
								<c:if test="${not empty obj.status and obj.status eq 1 or obj.status eq 2}"><a href="#" url= "" master_contract_no ="${obj.orderNo }"  class="show">查看</a></c:if>
								<c:if test="${empty obj.status}"><a href="#" url="" onclick="jumpPost('/contractQuotaV4Controller/createContract',{id:${obj.id}})">签署合同</a></c:if>
								
								</td>
							</tr>
		              </c:forEach>
					</table>
				</div>
			</div>
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
		</form>
		<script type="text/javascript">
		$('#beginDate,#endDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
		});
		$('#query').click(function(){
			$('#pageForm').submit();
		});
		$(".show").click(function(){
			var contractId = $(this).attr("master_contract_no");
			var id = $(this).attr("id");
			$("#master_contract_no").val(contractId);
			$("#id").val(id);
			$("#goContractinfo").submit();
		});
		function jumpPost(url,args) {
				console.info(args);
				var form = $("<form method='post'></form>");
		        form.attr({"action":url});
		        for (arg in args) {
		            var input = $("<input type='hidden'>");
		            input.attr({"name":arg});
		            input.val(args[arg]);
		            form.append(input);
		        }
		        $(document.body).append(form);
		        form.submit();
		    }
		
		</script>
	</body>
</html>