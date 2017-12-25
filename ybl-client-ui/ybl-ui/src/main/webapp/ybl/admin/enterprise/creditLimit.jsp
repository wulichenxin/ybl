<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ page contentType="text/html;charset=utf-8"
	deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>额度授信</title>
<jsp:include page="../common/link.jsp"/>
<script src="${app.staticResourceUrl}/ybl/resources/js/navlist.js"
	type="text/javascript"></script>
<!-- 进度条 -->
<script src="${app.staticResourceUrl}/ybl/resources/js/underscore.js"
	type="text/javascript"></script>
<!-- 进度条 -->
<script src="${app.staticResourceUrl}/ybl/resources/js/highcharts.js"
	type="text/javascript"></script>
<!-- 进度条 -->
</head>
<body>
	<!--top start -->
	<jsp:include page="../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">当前位置->授信管理 -> 额度授信</div>
	<div class="vip_conbody ">
		<div class="vip_r_con vborder">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i>额度授信
				</h1>
			</div>
			<div class="edsx_left">
				<ul>
					<li><span>授信额度：</span><font class="yellow">200000000.00元</font>
						<div class="but_but edsx_r">
							<a href="#">申请授权</a>
						</div></li>
					<li><span>可用额度：</span><font class="yellow">200000000.00元</font></li>
				</ul>
			</div>
			<div class="edrs_right">
				<div class="rzzt">
					<div class="basic_tb">
						<div class="prel2">
							<script type="text/javascript">
								$(document).ready(
										function() {
											var has_borrow = 18111.00;
											var need = 81889;
											var report = {
												"section_412" : [ {
													"label" : "",
													"data" : has_borrow
												}, {
													"label" : "",
													"data" : need
												} ]
											}
											customizeHighcharts();
											initDistribution_small(
													report.section_412,
													'maturity_412', '');
										});
							</script>

							<div data-highcharts-chart="1"
								style="height: 200px; width: 200px;" class="maturity_412">
							</div>
							<div class="progress_div2">
								<div class="tjd2">
									<div class="round">
										<span>已使用额度</span>
										<p>90</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="zhxx_box">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_1"></i>已使用额度明细
				</h1>
			</div>
			<!--1-->
			<div class="vip_table">
				<table>
					<tr>
						<th class="w100">序号</th>
						<th>贷款编号</th>
						<th>客户名称</th>
						<th>营业执照号</th>
						<th>联系电话</th>
						<th>保理商名称</th>
						<th>贷款金额</th>
						<th>贷款期限</th>
						<th>贷款状态</th>
					</tr>
					<tr>
						<td>1</td>
						<td>001</td>
						<td>电子供应商</td>
						<td>23435344</td>
						<td>0755-786567</td>
						<td>深圳保理公司</td>
						<td>5000.00万</td>
						<td>6个月</td>
						<td>贷款中</td>
					</tr>

				</table>
			</div>
		</div>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>