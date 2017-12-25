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
	<body>
		<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->
		
		<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<div class="w1200">
				<p class="protitle"><span></span>平台审核结果</p>

				
					<div class="form-grou mb20"><label style="width:82px">审核结果：</label>
					<select class="content-form">
						<option></option>
						<option <c:if test="${records.auditResult==1 }">selected="selected"</c:if> >通过</option>
						<option <c:if test="${records.auditResult==2 }">selected="selected"</c:if> >未通过</option>
						
					</select>

				</div>
					<div class="pd20">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：<textarea class="protext" name="remark" >${records.remark }</textarea>
					</div>	
					<div class="ground-form mb20">
			</div>
				
				
					<div class="bottom-line"></div>
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
				//所有的input设为不可编辑
				$('input').attr("readonly",true);
				$('select').attr("disabled",true);
				$('textarea').attr("readonly",true);
				
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
					window.parent.location.href="/loanapplicationcontroller/list.htm";
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
	</body>
</html>