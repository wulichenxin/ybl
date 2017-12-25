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
		<title></title>
		
	</head>

	<body>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/link.jsp" />
		<!--top end -->
		<div class="w1200 clearfix border-b">
			<ul class="clearfix formul">
				<li class="formli form_cur">平台初审</li>
			</ul>
		</div>
		<div class="w1200 ybl-info box box1">
		
			
			<div class="bottom-line"></div>
			
			<div class="process">
				<img src="images/proLine_img.png" />
				<ul class="clearfix proul clearfix">
					<li class="prolist pro_cur">平台初审<img class="pro-img-1" src="images/proPoint_icon.png" /><img class="pro-img-2" src="images/line_img_choose.png" /></li>
				
				</ul>
			
			
			<div class="chebox chebox1">
				<p class="protitle"><span></span>请选择推荐资方</p>
				<div class="grounpinfo">
					<div class="ground-form mb20">
						<div class="form-grou mr50"><label>资方名称：</label><input class="content-form"  value="${records.recommend_factor}"/></div>
						
					</div>
					
				</div>
				
				<div class="bottom-line"></div>
				
				<p class="protitle"><span></span>请选择平台初审结果</p>
				<div class="pd20">
				   <label>初审结果：</label><input class="content-form" value="${records.audit_result}" />
				<label>备注</label><textarea class="protext btn-center">${records.remark}</textarea>
				</div>
				
				<div class="bottom-line"></div>
				
				
				
			</div>
			
			
			
			<div class="bottom-line"></div>
			
		
			
			<div class="btn3 clearfix mb80">
				<a href="javascript:;" class="btn-add">保存草稿</a>
				<a href="javascript:;" class="btn-add">保存并提交</a>
				<a href="javascript:;" class="btn-add">取消</a>
			</div>
			
			</div>
		</div>
		
	
		</div>
		
		
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