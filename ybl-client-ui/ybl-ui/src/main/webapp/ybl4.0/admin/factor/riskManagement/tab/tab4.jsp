<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		
	</head>

	<body>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<!--top end -->
		
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="images/rzf_bre_icon.png" />融资综合查询<span class="mr10 ml10">-</span>选择意向资方</div>
		</div>

		
		<div class="w1200 mt40">

			<p class="protitleWhite"><span></span>选择意向资方</p>
			<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资方名称</th>
							<th>意向投资金额</th>
							<th>意向融资期限</th>
							<th>意向投资利率</th>
							<th>竞标时间</th>
							<th>初审意见表</th>
							<th>备注说明</th>
							<th>意向资方</th>
						</tr>
						<c:forEach items="${page.records}" var="entity" varStatus="xh">
						<tr>
							<td class="toggletr">${xh.count}</td>
							<td><a href="javascript:;" class="order-a">${entity.order_no}</a></td>
							<td>${entity.real_name}</td>
							<td>${entity.financing_amount}</td>
							<td>${entity.financing_term}</td>
							<td>${entity.financing_rate}</td>
							<td>${entity.audit_date}</td>
							<td><a href="javascript:;" class="order-a">${entity.audit_opinion}</a></td>
							<td>${entity.financing_rate}</td>
						
							<td><input type="checkbox" /></td>
							
							
						</tr>
						</c:forEach>
					</table>
			</div>
			
			
			
			
			<div class="btn2 mt40 clearfix">
				
				<a href="javascript:;" class="btn-add btn-center">取消</a>
			</div>
			
			
		</div>
		<div class="mb80"></div>
		
		<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="js/index.js" ></script>
		<script type="text/javascript" src="jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/bootsnav.js"></script>
		<script>
			$('#beginDate,#endDate').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
		</script>
	</body>

</html>