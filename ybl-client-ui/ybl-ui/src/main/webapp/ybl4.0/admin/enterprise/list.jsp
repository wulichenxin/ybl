<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>放款综合查询</title>



</head>

<body>

	<!--top start -->
	<jsp:include page="/ybl4.0/admin/common/top.jsp?step=9" />
	<!--top end -->



	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />放款申请综合查询
		</div>
	</div>
	<form action="/enterpriseLoanapplicationcontroller/list.htm" id="pageForm"
		method="post">
		<div class="w1200 ybl-info">

			<div class="ground-form mb20">

				<div class="form-grou mr40">
					<label>融资订单号：</label><input class="content-form"
						name="financing_order_number"
						value="${financinapply.financing_order_number}" />
				</div>

				<div class="form-grou mr40">
					<label>资金方：</label><input class="content-form" name="financier"
						value="${financinapply.financier}" />
				</div>
				<div class="form-grou mr40">
					<label class="label-long">融资方式：</label><select
						name="financing_mode" class="content-form">
						<option
							<c:if test="${empty financinapply.financing_mode}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${financinapply.financing_mode eq 1}">selected="selected"</c:if>
							value="1">签约资方</option>
						<option
							<c:if test="${financinapply.financing_mode eq 2}">selected="selected"</c:if>
							value="2">平台推荐</option>
						<option
							<c:if test="${financinapply.financing_mode eq 3}">selected="selected"</c:if>
							value="3">竞标</option>
					</select>
				</div>
				<div class="form-grou">
					<label>资产类型：</label><select name="assets_type" class="content-form">
						<option
							<c:if test="${empty financinapply.assets_type}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${financinapply.assets_type eq 1}">selected="selected"</c:if>
							value="1">应收账款</option>
						<option
							<c:if test="${financinapply.assets_type eq 2}">selected="selected"</c:if>
							value="2">应付账款</option>
						<option
							<c:if test="${financinapply.assets_type eq 3}">selected="selected"</c:if>
							value="3">票据</option>

					</select>
				</div>
			</div>

			<div class="ground-form mb20">


				<div class="form-grou mr40">
					<label>保理类型：</label><select name="factoring_mode"
						class="content-form">
						<option
							<c:if test="${empty financinapply.factoring_mode}">selected="selected"</c:if>
							value="">全部</option>
						<option
							<c:if test="${financinapply.factoring_mode eq 1}">selected="selected"</c:if>
							value="1">明保</option>
						<option
							<c:if test="${financinapply.factoring_mode eq 2}">selected="selected"</c:if>
							value="2">暗保</option>
					</select>
				</div>

				<div class="form-grou mr40">
					<label>融资状态：</label><select name="financing_status"
						class="content-form">
						<option value="9">融资完成</option>
					</select>
				</div>
				<div class="form-grou">
					<label class="label-long">申请时间：</label><input id="begin_date"
						class="content-form" name="begin_date"
						value="${financinapply.begin_date }" />
				</div>
				<span class="mr10 ml10">-</span>
				<div class="form-grou mr30">
					<input id="end_date" class="content-form" name="end_date"
						value="${financinapply.end_date }" 
						 />
				</div>
				<div class="btn-modify query">查询</div>
			</div>

			<div class="ground-form"></div>
		</div>

		<div class="w1200 mt40">
			<div class="tabD">
				<div class="scrollbox">
					<table>
						<tr>
							<th>序号</th>
							<th>融资订单号</th>
							
							<th>资金方</th>
							<th>保理类型</th>
							<th>资产类型</th>
							<th>融资方式</th>
							<th>融资金额(元)</th>
							<th>融资期限（天）</th>
							<th>融资利率（%）</th>
							<th>申请日期</th>
							<th>融资状态</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${page.records}" var="entity" varStatus="status">
							<tr>
								<td class="toggletr" uid="${entity.financing_apply_id}"
									pid="${entity.id}">${status.count}<img alt="" id="imgs"
									src="${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png"></td>
								<td class="maxwidth"><a href="javascript:;" class="order-a mr10 viewinfo"
									pid="${entity.id}" uid="${entity.financing_apply_id}"
									statue="${entity.financing_status}">${entity.financing_order_number}</a></td>
								<td class="maxwidth">${entity.financier}</td>
								<td><c:if test="${entity.factoring_mode eq 1}">明保</c:if> <c:if
										test="${entity.factoring_mode eq 2}">暗保</c:if></td>
								<td><c:if test="${entity.assets_type eq 1}">应收账款</c:if> <c:if
										test="${entity.assets_type eq 2}">应付账款</c:if> <c:if
										test="${entity.assets_type eq 3}">票据</c:if></td>

								<td><c:if test="${entity.financing_mode eq 1}">签约资方</c:if>
									<c:if test="${entity.financing_mode eq 2}">平台推荐</c:if> <c:if
										test="${entity.financing_mode eq 3}">竞标</c:if></td>

								<td><fmt:formatNumber value="${entity.financing_amount }"
										pattern="#,##0.00" maxFractionDigits="2" /></td>
								<td>${entity.financing_term }</td>
								<td><fmt:formatNumber value="${entity.financing_rate }"
										pattern="#,##0.####" maxFractionDigits="4" /></td>

								<td><fmt:formatDate value="${entity.createdTime}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:if test="${entity.financing_status eq 1}">待提交</c:if>
									<c:if test="${entity.financing_status eq 2}">待平台初审</c:if> <c:if
										test="${entity.financing_status eq 3}">待资方初审</c:if> <c:if
										test="${entity.financing_status eq 4}">待选择资方</c:if> <c:if
										test="${entity.financing_status eq 5}">待资方终审</c:if> <c:if
										test="${entity.financing_status eq 6}">待确定资方</c:if> <c:if
										test="${entity.financing_status eq 7}">待平台复核</c:if> <c:if
										test="${entity.financing_status eq 8}">待签署合同</c:if> <c:if
										test="${entity.financing_status eq  9}">融资完成</c:if> <c:if
										test="${entity.financing_status eq 10}">资金方驳回</c:if> <c:if
										test="${entity.financing_status eq  11}">平台驳回</c:if> <c:if
										test="${entity.financing_status eq 99}">融资失败</c:if></td>

								<td><a href="javascript:;" class="btn-modify mr10 viewinfo"
									pid="${entity.id}" uid="${entity.financing_apply_id}"
									statue="${entity.financing_status}">查看</a></td>
							</tr>
						</c:forEach>

					</table>

				</div>
			</div>
			<!-- <div class="center-btn mt40">
				<a href="javascript:;" class="btn-add btn-center">新增</a>
			</div> -->
			<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
		</div>
	</form>


</body>
<script type="text/javascript">
	Date.prototype.Format = function(fmt) { //author: meizz   
		var o = {
			"M+" : this.getMonth() + 1, //月份   
			"d+" : this.getDate(), //日   
			"h+" : this.getHours(), //小时   
			"m+" : this.getMinutes(), //分   
			"s+" : this.getSeconds(), //秒   
			"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
			"S" : this.getMilliseconds()
		//毫秒   
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}

	$('#begin_date,#end_date').datetimepicker({
		yearOffset : 0,
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '1970-01-01', // yesterday is minimum date
		maxDate : '2099-12-31' // and tommorow is maximum date calendar
	});

	$(function() {

		// 查询
		$(".query").click(function() {

			$("#pageForm").submit();
		});

		//跳转到融资申请综合查询详情
		$(".viewinfo").click(function() {
			var id = $(this).attr("uid");
			var childrenId = $(this).attr("pid");
			var statue = $(this).attr("statue");
			param = {
				"id" : id,
				"childrenId" : childrenId,
				"statue" : statue
			};
			httpPost('/IntegratedQueryController/view.htm', param);
			//	window.open('/IntegratedQueryController/view.htm?id='+id+'&childrenId='+childrenId, '_blank', '');

		});
		

		// 查看功能，跳转到详情页面

		//查询子融资列表
		jQuery(".toggletr")
				.click(
						function() {
							var id = $(this).attr("pid");
							var type="1";
							var $this = $(this);
							var aa = $(this).parent();
							var sign = aa.attr("sign");
							if (sign != "success") {
								$
										.ajax({
											url : "/loanapplicationcontroller/getlist",
											type : "post",
											dataType : "json",
											data : {
												id : id,
												type:type
												
											},
											success : function(data, status) {
												if (status == "success") {
													//虚幻拼接字符串作为子列表展示子融资订单
													var arrayResult = data.object;
													var htmlResult = '';
													var html = "<tr class='trchrild' uid='"+id+"'>"
															+ "<td colspan='12'><table><tr>"
															+ "<th>序号</th>"
															+ "<th>放款申请单号</th>"
															
															+ "<th>资产类型</th>"
															+ "<th>申请放款金额（元）</th>"
															+ "<th>融资期限（天）</th>"
															+ "<th>融资利率(%)</th>"
															+ "<th>申请日期</th>"
															+ "<th>实际放款金额(元)</th>"
															+ "<th>累计还款本息(元)</th>"
															+ "<th>最后一次还款时间</th>"
															
															+ "<th>放款状态</th>"
															+ "<th>还款状态</th>"
															+ "<th>平台费用(元)</th>"
															+ "<th>操作</th></tr>";
													if (arrayResult.length > 0) {
														$.each( arrayResult, function( index, value) {
																			var assets_type = '';
																			var confirmation = '';
																			var status = '';
																			var repayment_status = '';
																			var createtime = '';
																			var lasttime = '';
																			var lasttimes = value.lasttime;
																			if (lasttimes != "undefined"
																					&& lasttimes != null) {
																				lasttime = new Date(lasttimes).Format('yyyy-MM-dd')
																			}
																			if (value.created_time != null
																					&& value.created_time != '') {
																				createtime = value.created_time
																						.substr(
																								0,
																								10);
																			}

																			if (value.assets_type == 1) {
																				assets_type = '应收账款'
																			} else if (value.assets_type == 2) {
																				assets_type = '应付账款'
																			} else if (value.assets_type == 3) {
																				assets_type = '票据'
																			}
																			if (value.status == 9) {
																				confirmation = '是'
																			} else {
																				confirmation = '否'}
																			
																			if (value.status == 1) {
																				status = '待提交';
																			} else if (value.status == 2) {
																				status = '待资方办理';
																			} else if (value.status == 3) {
																				status = '待确权';
																			} else if (value.status == 4) {
																				status = '待平台审核';
																			} else if (value.status == 5) {
																				status = '待放款';
																			}  else if (value.status == 8) {
																				status = '待放款确认';
																			} else if (value.status == 9) {
																				status = '已确认收款';
																			} else if (value.status == 99) {
																				status = '放款失败';
																			}

																			if (value.repayment_status == 1) {
																				repayment_status = '待还款';
																			} else if (value.repayment_status == 2) {
																				repayment_status = '还款中';
																			} else if (value.repayment_status == 3) {
																				repayment_status = '已完成'
																			}

																			var htmlString =
																				"<tr class='trchrild' uid='"+id+"'>"
																				+ "<td class='toggletr rightTextalign'>"
																				+ (index + 1)
																				+ "</td>"
																				/* + "<td><a href='javascript:;' class='order-a'>"
																				+ value.order_no
																				+ "</a></td>" */
																				+"<td><a href='javascript:void(0);' class=' order-a mr10 subView' uid='"
																				+ value.id_
																				+ "' pid='"
																				+ value.order_no
																				+ "' batchid='"
																				+ value.payment_batch_id
																				+ "' subid='"
																				+ value.subid
																				+ "' financingAmount='"+parseFloat(value.financing_amount)+"' financingstatus='"+value.status+"' type='"+value.assets_type+"' attribute1='"+value.attribute1_+"' attribute2='"+value.attribute2_+"' >"+value.order_no+"</a></td>"
																				+ //子订单号
																				
																				

																				"<td>"
																				+ assets_type
																				+ "</td>"
																				+ //意向融资期限
																				"<td>"
																				+ toThousandNum(parseFloat(value.financing_amount.toFixed(2)))
																				+ "</td>"
																				+ //意向投资利率
																				"<td>"
																				+ value.financing_term
																				+ "</td>"
																				+ "<td>"
																				+ parseFloat(value.financing_rate)
																				+ "</td>"
																				+
																				"<td>"
																				+ createtime
																				+ "</td>"
																				+ "<td>"
																				+ toThousandNum(parseFloat(value.actual_loan_amount.toFixed(2)))
																				+ "</td>"
																				+ "<td>"
																				+ toThousandNum(parseFloat(value.totalrepaymoney.toFixed(2)))
																				+ "</td>"
																				+ "<td>"
																				+ lasttime
																				+ "</td>"
																				
																				+ "<td>"
																				+ status
																				+ "</td>"
																				+ "<td>"
																				+ repayment_status
																				+ "</td>"
																				+ "<td>"
																				+  toThousandNum(parseFloat(value.paid_platform_fee.toFixed(2)))
																				+ "</td>"
																				+ "<td><a href='javascript:void(0);' class='btn-modify mr10 subView' uid='"
																				+ value.id_
																				+ "' pid='"
																				+ value.order_no
																				+ "' batchid='"
																				+ value.payment_batch_id
																				+ "' subid='"
																				+ value.subid
																				+ "' financingAmount='"+parseFloat(value.financing_amount)+"' financingstatus='"+value.status+"' type='"+value.assets_type+"' attribute1='"+value.attribute1_+"' attribute2='"+value.attribute2_+"' >查看</a></td>"
																				+ "</tr>"
																					htmlResult = htmlResult + htmlString;
																		});
														htmlResult = htmlResult + "</table></td></tr>";
														var htmls = html + htmlResult;
														$(aa).after(htmls);
														//aa.attr(".trchrild").show();
														aa.attr("sign",
																"success");
														$(".subView")
																.click(
																		function() {
																			var id = $(
																					this)
																					.attr(
																							"uid");
																			var orderno = $(
																					this)
																					.attr(
																							"pid");
																			var batchid = $(
																					this)
																					.attr(
																							"batchid");
																			var subid = $(
																					this)
																					.attr(
																							"subid");
																			var financingAmount=$(
																					this)
																					.attr(
																							"financingAmount");
																			
																			var financingstatus=$(
																					this)
																					.attr(
																							"financingstatus");
																			
																			var type=$(
																					this)
																					.attr(
																							"type");
																			var attribute1=$(
																					this)
																					.attr(
																							"attribute1");
																			var attribute2=$(
																					this)
																					.attr(
																							"attribute2");
																			var isenterprise="enterprise";
																			param = {
																				"id" : id,
																				"orderno" : orderno,
																				"batchid" : batchid,
																				"subid" : subid,
																				"financingAmount":financingAmount,
																				"financingstatus":financingstatus,
																				"type":type,
																				"attribute1":attribute1,
																				"attribute2":attribute2,
																				"isenterprise":isenterprise

																			};
																			httpPost(
																					'/loanapplicationcontroller/view.htm',
																					param);
																			//window.open('/loanapplicationcontroller/view.htm?id='+id+'&orderno='+orderno+'&batchid='+batchid+'&subid='+subid, '_blank', '');

																		});

													}

												} else {
													alert("暂无子融资订单");
												}

											},

										});

							}
							var childer = document
									.getElementsByClassName('trchrild');
							for (var i = 0; i < childer.length; i++) {
								if (childer[i].getAttribute('uid') == $this
										.attr('pid')) {
									$(childer[i]).toggle();
								}
							}
							var src = $this.find('img').attr("src");
							if (src == "${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png") {
								$this
										.find('img')
										.attr("src",
												"${app.staticResourceUrl}/ybl4.0/resources/images/downList_icon.png");
							} else {
								$this
										.find('img')
										.attr("src",
												'${app.staticResourceUrl}/ybl4.0/resources/images/upList_icon.png');
							}

						});

	});
</script>
</html>