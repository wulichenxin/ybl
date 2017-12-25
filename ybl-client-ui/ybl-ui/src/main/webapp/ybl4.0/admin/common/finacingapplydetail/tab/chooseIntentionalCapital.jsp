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
		

		<div class="w1200 mt40">

			<p class="protitle"><span></span>选择意向资方</p>
			<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资方名称</th>
							<th>意向投资金额（元）</th>
							<th>意向融资期限（天）</th>
							<th>意向投资利率（%）</th>
							<th>竞标时间</th>
							<th>初审意见表</th>
							<th>备注说明</th>
							<th>意向资方</th>
						</tr>
						<c:forEach items="${fund}" var="entity" varStatus="xh">
						<tr>
							<td class="toggletr">${xh.count}</td>
							<td><a href="javascript:;" class="order-a">${entity.order_no}</a></td>
							<td>${entity.funder_name}</td>
							<td>￥<fmt:formatNumber value="${entity.financing_amount }" pattern="##0.00" maxFractionDigits="2"/>元</td>					
							<td>${entity.financing_term}</td>
							<td><fmt:formatNumber value="${entity.financing_rate }" pattern="##0.00" maxFractionDigits="2"/>%</td>
							<td><fmt:formatDate value="${entity.audit_date}" pattern="yyyy-MM-dd" /></td>
							<td><a href="javascript:;" class="order-a">${entity.audit_opinion}</a></td>
							<td>${entity.remark}</td>
							
							<td>
							<c:if test="${entity.audit_result eq 1}"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/agree_icon.png"></c:if> 
							<c:if test="${entity.audit_result ne 1}"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/disagree_icon.png"></c:if>
							</td>
						</tr>
						</c:forEach>
					</table>
			</div>
			
			
			
			
			<div class="bottom-line"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab4_1" class="btn-add">上一页</a>
					<a href="#" id="tab4_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
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
			

			$(function(){
				
				//所有的input设为不可编辑
				$('input').attr("disabled",true);
				$('select').attr("disabled",true);
				$('textarea').attr("disabled",true);
				//上一页，下一页,返回的跳转
				
					
				$('#tab4_1').click(function(){	
					var url=$('#three',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})
				
				$('#tab4_2').click(function(){	
					var url=$('#five',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})		
				
				$(".btn-return").click(function(){
					window.parent.location.href="/IntegratedQueryController/list.htm";
				});
			
		
			})
		
		</script>
	</body>

</html>