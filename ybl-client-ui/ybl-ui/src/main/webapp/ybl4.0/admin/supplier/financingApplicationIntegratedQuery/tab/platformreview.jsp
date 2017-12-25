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
	<body>
			<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp?step=7" />
		<!--top end -->		
	<c:choose>
			<c:when test="${fn:length(records) eq 0 }">
				<div class="none_img" style="margin-top: 80px;"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/none_img.png" height="200px" width="200px"/><p>暂无相关数据</p></div>
			</c:when>
			<c:otherwise>
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<c:forEach items="${records}" var="obj" varStatus="index">
				<li class="formli <c:if test="${index.count==1}">form_cur</c:if>">第${index.count}次</li>
				</c:forEach>
			</ul>
		</div>
		<c:forEach items="${records}" var="obj" varStatus="index">
		<div class="w1200 box box${index.count}">
		<form action="/factorLoanAuditController/loanAudit/receivableElementsAudit.htm" id="pageForm" method="post">
			<div class="w1200">
				<p class="protitle"><span>平台终审结果</span></p>

				<%-- 	<div class="form-grou mb20"><label style="width:82px">资方名称：</label>
					<input class="content-form"  value="${obj.recommendFactor}"/>
						
					</div> --%>
				
					<div class="form-grou mb20"><label style="width:82px">审核结果：</label>
					<select class="content-form">
						<option></option>
						<option <c:if test="${obj.auditResult==1 }">selected="selected"</c:if> >通过</option>
						<option <c:if test="${obj.auditResult==2 }">selected="selected"</c:if> >未通过</option>
						
					</select>

				</div>

					<div class="form-grou mb20"><label style="width:82px">备注：</label><textarea class="protext" name="remark" >${obj.remark }</textarea>
					</div>	
					<div class="ground-form mb20">
			</div>
				
				
					<div class="bottom-line"></div>
				
				
				</div>
			</div>
		</form>				
		</div>
		</c:forEach>
		<div class="btn3 clearfix mt40 mb80">
				<a href="#" id="tab7_1" class="btn-add">上一页</a>
				<a href="#" id="tab7_2" class="btn-add">下一页</a>
				<a href="#" class="btn-add btn-return">返回</a>
			</div>
		
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
			///上一页，下一页,返回的跳转
				
			$('#tab7_1').click(function(){	
			$('.iconlist',parent.document).removeClass('pro_li_cur');
				
				/* $('#six',parent.document).addClass('pro_li_cur');
				var url=$('#six',parent.document).attr('url');	
				$('#iframe1',parent.document).attr('src',url); */
				$('#six',parent.document).click();
			})
			
			$('#tab7_2').click(function(){
				/* $('.iconlist',parent.document).removeClass('pro_li_cur');
				
				$('#contract',parent.document).addClass('pro_li_cur');	
				$('#eight',parent.document).addClass('pro_li_cur');
				$('#other',parent.document).hide();
				$('#contractsign',parent.document).show();
				var url=$('#eight',parent.document).attr('url');	
				$('#iframe1',parent.document).attr('src',url); */
				//显示合同签署页面开始
				$('#other',parent.document).hide();
				$('#contractsign',parent.document).show();
				$('.iconlist',parent.document).removeClass('pro_li_cur');
				$('#contract',parent.document).addClass('pro_li_cur');
				//显示合同签署页面结束
				$('#eight',parent.document).click();
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