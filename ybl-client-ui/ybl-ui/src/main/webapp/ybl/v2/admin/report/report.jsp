<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>${reportForm.name}</title>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<!-- 时间控件文件 -->
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.css" />
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.datetimepicker/jquery.datetimepicker.min.js"></script>
<script type="text/javascript">
	$(function() {
		//初始化时间 start
		var dmf = {
			yearOffset : 0,
			lang : 'ch',
			timepicker : false,
			format : 'Y-m-d',
			formatDate : 'Y-m-d',
			minDate : '1970-01-01', // yesterday is minimum date
			maxDate : '2099-12-31' // and tommorow is maximum date calendar
		};
		// 初始化日期控件
		$('._date_input').datetimepicker(dmf);
		// 点击日期图标初始化日期控件
		$('._date_input').next().on("click", function() {
			$(this).prev().datetimepicker("show");
		});

		//按条件查询信息
		$("#search_report_data_Btn").click(function() {
			$("#pageForm").submit();
		});

		//导出excel
		$("#exportAll").click(function() {
			$("#exportAllForm").html($(".v2_seach_box").html() + $(".page").html());
			$("#exportAllForm").submit();
		});
		//设置查询条件框的高度
		var _search_height = $(".v2_seach_box").height();
		if(_search_height>90 && _search_height<140){
			$(".v2_top_bg").addClass("h410");
		}
		if(_search_height>140){
			$(".v2_top_bg").height(460);
		}
		if(_search_height==undefined){
			$(".v2_top_bg").height(160);
		}
	});
</script>
</head>
<body>
	<form id="pageForm"
		action="/reportFormController/${code}/queryReportFrom.htm"
		method="post">
		<div class="v2_top_bg v2_t_bg2">
			<div class="v2_top_con">
				<div class="v2_head_top">
					<%@include file="/ybl/v2/admin/common/top.jsp"%>
					<div class="v2_z_nav">
						<div class="v2_z_nav_con">
							<div class="v2_z_navbox">
							</div>
						</div>
					</div>
				</div>
				<!---->
				<div class="v2_path">
					<spring:message code="sys.v2.client.location" />：${reportForm.name}
				</div>
				<!--搜索条件-->
				<c:if test="${parameterList!=null && isExist==true}">
					<div class="v2_seach_box">
						<ul>
							<c:forEach items="${parameterList}" var="parameter">
							<li><label>${parameter.name}:</label> 
								<c:if test="${parameter.type=='DROP_DOWN_BOX'}">
										<select name="${parameter.field}" id="${parameter.field}"
											isSelect="Y"
											url="/configController/get-${parameter.configKey}"
											valueFiled="code_" textField="value_"
											defaultValue="${paramMap[parameter.field][0]}">
										</select>
								</c:if> 
								<c:if test="${parameter.type=='TEXT_BOX'}">
										<input type="text" class="w100" name='${parameter.field}'
											value="${paramMap[parameter.field][0]}" />
								</c:if>
								<c:if test="${parameter.type=='DATE_BOX'}">
										<span> <input id="paln_return_date"
											name="${parameter.field}_1"
											value="${paramMap[parameter.attribute1][0]}" type="text"
											class="w100 _date_input" /><a id="${parameter.field}_1"
											class="v2_date_ico"></a>
										</span>
										<b><spring:message code="sys.v2.client.to" /> <!-- 至 --></b>
										<span> <input id="paln_return_max_date"
											name="${parameter.field}_2"
											value="${paramMap[parameter.attribute2][0]}" type="text"
											class="w100 _date_input" /><a id="${parameter.field}_2"
											class="v2_date_ico"></a>
										</span>
								</c:if>
							</li>
							</c:forEach>
							<li>
								<div class="v2_button_seach">
									<a href='javascript:void(0);' id='search_report_data_Btn'><spring:message
											code="sys.v2.client.query" /> <!-- 查询 --></a>
								</div>
							</li>
						</ul>
					</div>
				</c:if>
				<!--搜索条件-->
			</div>
		</div>
		<div class="v2_vip_conbody">
			<c:if test="${isExist==false}">
				<div style="background:url(/ybl/resources/images/bg_no_exist.png) center  no-repeat;width:1200px;height:250px;">
					<p style=' text-align:center; font-size:20px; color:#686868; margin:0px auto; padding:200px 20px 0px; line-height:30px'>该内容已删除</p>
				</div>
			</c:if>
			<c:if test="${isExist==true}">
			<!--table-->
			<div class="v2_table_box">
				<!-- 按钮区域 -->
				<c:if test="${reportForm.exportType=='Excel'}">
					<div class="v2_table_top">
						<div class="v2_table_nav">
							<ul class="fl">
								<li><a href="javascript:void(0);" class="v2_but_export"
								id="exportAll"><spring:message
										code="sys.v2.client.export.excel" /></a></li>
							</ul>
						</div>
					</div>
				</c:if>
				
				<!--按钮top-->
				<div class="v2_table_con" style="width: 100%; overflow-x: scroll;">
					<table border="0" cellspacing="0" cellpadding="0"
						style="width: 1550px;">
						<thead>
							<tr>
								<th width="80"><spring:message code="sys.v2.client.no" /></th>
								<c:forEach items="${outputParamterList}" var="outputParam">
									<th>${outputParam.name}</th>
								</c:forEach>
							</tr>		
						</thead>
						<tbody>
							<c:forEach items="${list}" var="data" varStatus="index">
								<tr>
									<td>${index.index + 1}</td>
									<c:forEach items="${outputParamterList}" var="outputParam">
										<c:if test="${outputParam.configKey!='' && outputParam.configKey!=null}">
											<td style="text-align:${outputParam.alineWay};"
												url="/configController/get-${outputParam.configKey}/${data[outputParam.field]}"
												textField="value_">
											</td>
										</c:if>
										<c:if test="${outputParam.configKey=='' || outputParam.configKey==null}">
												<td style="text-align:${outputParam.alineWay};">${data[outputParam.field]}</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>		
					</table>
				</div>
			</div>
			<!-- page.jsp -->
			<c:if test="${reportForm!=null && reportForm.isPage==1}">
				<%@include file="/ybl/v2/admin/common/page.jsp"%>
			</c:if>
			<!-- page.jsp -->
			</c:if>
		</div>
	</form>
	<!-- 导出excel start -->
	<form action="/reportFormController/exportReport/${reportForm.code}"
		id="exportAllForm" style="display: none" target="_hide" method="post"></form>
	<iframe name="_hide" style="display: none;"></iframe>
	<!-- 导出excel end -->
	<!-- bottom.jsp -->
	<%@include file="/ybl/v2/admin/common/bottom.jsp"%>
	<!-- bottom.jsp -->
</body>
</html>