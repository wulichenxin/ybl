<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->
	<body>
	<c:choose>
			<c:when test="${recordResult == 'noRecords'}">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<div class="w1200">
				<p class="protitle"><span>平台审核结果</span></p>

				
					<div class="form-grou mb20"><label style="width:82px">审核结果：</label>
					<select class="content-form">
						<option></option>
						<option <c:if test="${audit_result==1 }">selected="selected"</c:if> >通过</option>
						<option <c:if test="${audit_result==2 }">selected="selected"</c:if> >未通过</option>
						
					</select>

				</div>
					<div class="form-grou mb20"><label style="width:82px">备注</label><textarea class="protext" name="remark" >${remark }</textarea>
					</div>	
					<div class="ground-form mb20">
			</div>
				
				
					<div class="bottom-line mb20"></div>
			<div class="btn3 clearfix mb80">
					<a href="#" id="tab4_1" class="btn-add">上一页</a>
					<a href="#" id="tab4_2" class="btn-add">下一页</a>
					<a href="#" class="btn-add btn-return">返回</a>
				</div>
				
				
				</div>
			</div>
		</form>				
		
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/index.js" ></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
		<script>
		$(function(){
			var url=$("#jumpurl",parent.document).val();
			if(url == '###'){
				$(".btn-return").attr("style","display:none;");
			}
		})
		</script>
		<script>
			$(function(){
				//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				
				//上一页，下一页,返回的跳转
				$('#tab4_1').click(function(){	
					/* var url=$('#three',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#three',parent.document).click();
				})		
				$('#tab4_2').click(function(){	
					/* var url=$('#five',parent.document).attr('url');	
					$('#iframe1',parent.document).attr('src',url); */
					$('#five',parent.document).click();
				})		
				
				$(".btn-return").click(function(){
					var url=$("#jumpurl",parent.document).val()
					window.parent.location.href=url;
				});
			
			
			$('.sffs').change(function(){
				var $val = $(this).children('option:selected').attr('value');
				if($val=='1'){
					$('.sffs-label').html('融资利率：');
					$('.sffs-sp').html('%');
				}
				else{
					$('.sffs-label').html('服务费：');
					$('.sffs-sp').html('元');
				}
				
			})
			})
		</script>
		</c:otherwise>
		</c:choose>
	</body>
</html>