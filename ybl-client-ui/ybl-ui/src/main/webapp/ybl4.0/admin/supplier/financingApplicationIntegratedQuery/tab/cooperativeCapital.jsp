<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		
	</head>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<!--top end -->
	<body>

		<c:choose>
			<c:when test="${fn:length(fund) eq 0}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png" height="200px" width="200px"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<div class="w1200 mt40">
			<p class="protitle"><span>合作资方</span></p>
			<div class="tabD">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							<th>资方名称</th>
							<th>意向投资金额(元)</th>
							<th>意向融资期限(天)</th>
							<th>意向投资利率(%)</th>
							<th>竞标时间</th>
							<th>终审意见表</th>
							<th>备注说明</th>
							<th>意向资方</th>
						</tr>
						<c:forEach items="${fund}" var="entity" varStatus="xh">
						<td class="toggletr">${xh.count}</td>
							<td><a href="javascript:;" class="order-a">${entity.order_no}</a></td>
							<td>${entity.funder_name}</td>
							<td><fmt:formatNumber value="${entity.financing_amount }" pattern="#,##0.00" maxFractionDigits="2"/></td>					
							<td>${entity.financing_term}</td>
							<td><fmt:formatNumber value="${entity.financing_rate }" pattern="#,##0.####" maxFractionDigits="4"/></td>
							<td><fmt:formatDate value="${entity.audit_date}" pattern="yyyy-MM-dd" /></td>
							<td><a href="/fileDownloadController/downloadftp?id=${entity.attachmentId }" class="order-a">${entity.oldName}</a></td>
							<td>${entity.remark}</td>
							
							<td>
								<c:choose>
								<c:when test="${entity.selection_status eq 2 }"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/agree_icon.png"></c:when>
								<c:otherwise><img src="${app.staticResourceUrl}/ybl4.0/resources/images/disagree_icon.png"></c:otherwise>
							</c:choose>
							
							
							</td>
						</tr>
						</c:forEach>
					</table>
			</div>
			
			
			
			
			
			
			
		</div>
	<div class="btn3 clearfix mb80 mt40">
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
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>
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
					/* $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#five',parent.document).addClass('pro_li_cur');
					var url=$('#five',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#five',parent.document).click();
				})
				
				$('#tab6_2').click(function(){
					/* $('.iconlist',parent.document).removeClass('pro_li_cur');
					
					$('#seven',parent.document).addClass('pro_li_cur');
					var url=$('#seven',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#seven',parent.document).click();
				})		
				
				$(".btn-return").click(function(){
					var url=$("#jumpurl",parent.document).val();
					window.parent.location.href=url;
				});
			
		
			})
		
		</script>
		</c:otherwise>
		</c:choose>
	</body>

</html>