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
			<p class="protitle"><span>合作资方</span></p>
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
						<c:forEach items="${fund}" var="entity" varStatus="xh">
						<tr>
							<td class="toggletr">${xh.count}</td>
							<td><a href="javascript:;" class="order-a">${entity.order_no}</a></td>
							<td>${entity.funder_name}</td>
							<td>${entity.financing_amount}</td>
							<td>${entity.financing_term}</td>
							<td>${entity.financing_rate}</td>
							<td>${entity.audit_date}</td>
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
			
			
			
			
			
			
			
		</div>
	<div class="btn3 clearfix mb80">
				<a href="#" id="tab6_1" class="btn-add">上一页</a>
				<a href="#" id="tab6_2" class="btn-add">下一页</a>
				<a href="#" class="btn-add btn-return">返回</a>
			</div>
		
		
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
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				//上一页，下一页,返回的跳转
				
					
				$('#tab6_1').click(function(){	
					var url=$('#five',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})
				
				$('#tab6_2').click(function(){	
					var url=$('#seven',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url);
				})		
				
				$(".btn-return").click(function(){
					window.parent.location.href="/IntegratedQueryController/list.htm";
				});
			
		
			})
		
		</script>
	</body>

</html>