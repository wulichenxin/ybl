<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>退款管理</title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->贷款管理 -> 退款管理</div>
	<div class="vip_conbody">

		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label>贷款编号:</label><input type="text" /></li>
					<li><label>保理商名称:</label><input type="text" /></li>
					<li><label>融资状态:</label><select name=""><option>全部</option>
							<option>审核中</option>
							<option>放款中</option>
							<option>还款中</option>
							<option>已完成</option>
							<option>完善资料</option></select></li>
					<li><div class="button_yellow">
							<a>查询</a>
						</div></li>
					<li><div class="button_gary">
							<a>重置</a>
						</div></li>
				</ul>
			</div>
		</div>
		<!--搜索条件-->

		<!--table-->
		<div class="table_box">

			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><input name="" type="checkbox" value="" /></th>
						<th>序号</th>
						<th>贷款编号</th>
						<th>保理商名称</th>
						<th>保理类型</th>
						<th>票面金额/万元</th>
						<th>贷款金额/万元</th>
						<th>服务费用/万元</th>
						<th>退还金额/万元</th>
						<th>退款状态</th>
						<th></th>
					</tr>
					<tr>
						<td><input name="" type="checkbox" value="" /></td>
						<td>1</td>
						<td>001</td>
						<td>深圳保理公司</td>
						<td>线上明保理</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>--</td>
						<td>审核中</td>
						<td><div class="but_ss">
								<a class="open "></a><a class="close" style="display: none;"></a>
							</div></td>
					</tr>
					<tr class="z_table ">
						<td colspan="11">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb1">
								<tr>
									<th width="50"></th>
									<th width="50"></th>
									<th>序号</th>
									<th>凭证编码</th>
									<th>核心企业名称</th>
									<th>凭证面额（万元</th>
									<th>凭证类型</th>
									<th>凭证到期日</th>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td>1</td>
									<td>00002</td>
									<td>京东</td>
									<td>￥5000.00</td>
									<td>应收账款凭证</td>
									<td>2016/12/30</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bg_l">
						<td><input name="" type="checkbox" value="" /></td>
						<td>1</td>
						<td>001</td>
						<td>深圳保理公司</td>
						<td>线上明保理</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>--</td>
						<td>审核中</td>
						<td><div class="but_ss">
								<a class="open "></a><a class="close" style="display: none;"></a>
							</div></td>
					</tr>
					<tr class="z_table">
						<td colspan="14">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb1">
								<tr>
									<th width="50"></th>
									<th width="50"></th>
									<th>序号</th>
									<th>凭证编码</th>
									<th>核心企业名称</th>
									<th>凭证面额（万元</th>
									<th>凭证类型</th>
									<th>凭证到期日</th>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td>1</td>
									<td>00002</td>
									<td>京东</td>
									<td>￥5000.00</td>
									<td>应收账款凭证</td>
									<td>2016/12/30</td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td>1</td>
									<td>00002</td>
									<td>京东</td>
									<td>￥5000.00</td>
									<td>应收账款凭证</td>
									<td>2016/12/30</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><input name="" type="checkbox" value="" /></td>
						<td>1</td>
						<td>001</td>
						<td>深圳保理公司</td>
						<td>线上明保理</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>¥5700.00</td>
						<td>--</td>
						<td>审核中</td>
						<td><div class="but_ss">
								<a class="open "></a><a class="close" style="display: none;"></a>
							</div></td>
					</tr>
					<tr class="z_table">
						<td colspan="14">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb1">
								<tr>
									<th width="50"></th>
									<th width="50"></th>
									<th>序号</th>
									<th>凭证编码</th>
									<th>核心企业名称</th>
									<th>凭证面额（万元</th>
									<th>凭证类型</th>
									<th>凭证到期日</th>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td>1</td>
									<td>00002</td>
									<td>京东</td>
									<td>￥5000.00</td>
									<td>应收账款凭证</td>
									<td>2016/12/30</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>

			</div>
			<div class="pages">
				<div class="pages_l">
					共12条记录,每条显示<select name="">
						<option>10</option>
						<option>20</option>
						<option>50</option>
					</select>条
				</div>
				<div class="pages_r">
					<ul>
						<li><a class="now">上一页</a></li>
						<li><a>首页</a></li>
						<li><a>1</a></li>
						<li><a>2</a></li>
						<li><a>3</a></li>
						<li><a>...</a></li>
						<li><a>9</a></li>
						<li><a>尾页</a></li>
						<li><a class="now">下一页</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!--table-->
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
	<!--弹框start-->
	<div id="add" style="display: none;">
		<div class="t_window"></div>
		<div class="vipwindow_box vip_w1000">
			<div class="l_tittle">
				<h1>提前还款</h1>
				<div class="t_window_close">
					<a id="add_close" onclick="add_close();"><img
						src="../images/w_close_ico.png" /></a>
				</div>
			</div>
			<div class="vip_window_con">
				<div class="clear"></div>
				<div class="hkxx fl border-r">
					<h2>提前还款信息：</h2>
					<ul>
						<li><div class="input_box">
								<span>应还本金：</span><input type="text" placeholder=""
									class="text w100 mr10" />万元
							</div></li>
						<li><div class="input_box">
								<span>违约金：</span><input type="text" placeholder=""
									class="text w100 mr10" />万元
							</div></li>
						<li><div class="input_box">
								<span>截至当前应还利息：</span><input type="text" placeholder=""
									class="text w100 mr10" />万元
							</div></li>
						<li><div class="input_box">
								<span>截至当前应还利息：</span><font class="f28 red">5708</font>万元
							</div></li>
					</ul>
				</div>
				<div class="hkxx fr">
					<h2>原始还款信息：</h2>
					<ul>
						<li><div class="input_box">
								<span>应还本金：</span><input type="text" placeholder=""
									class="text w100 mr10" />万元
							</div></li>
						<li><div class="input_box">
								<span>应还利息：</span><input type="text" placeholder=""
									class="text w100 mr10" />万元
							</div></li>
						<li></li>
						<li><div class="input_box">
								<span>截至当前应还利息：</span><font class="f28 red">5708</font>万元
							</div></li>
					</ul>
				</div>
				<div class="clear"></div>
				<div class="tqhk">
					<h2>提前还款：</h2>
					<div class="tqhkxx">
						<div class="input_box fl mr20">
							<span>还款金额：</span><input type="text" placeholder="请输入提前还款金额"
								class="text w300 mr10 fl" />元
						</div>
						<div class="zf_but fl">
							<a>支付</a><a class="qx">去充值</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--弹框end-->
	<script type="text/javascript">
		var index;
		var timer;
		// 添加
		function add_start() {
			$('#add').show();
			$('t_window').css({
				overflow : 'hidden'
			});
		}
		// 添加
		function add_blank() {
			$('#add_blank').show();
			$('t_window').css({
				overflow : 'hidden'
			});
		}
		function add_close() {
			clearInterval(timer);
			$('#add').hide();
			$('body').css({
				overflow : ''
			});
		}
		function add_bclose() {
			clearInterval(timer);
			$('#add_blank').hide();
			$('body').css({
				overflow : ''
			});
		}
	</script>
	<script>
		$(document).ready(
				function() {
					$(".open").click(
							function() {
								$(this).hide();
								$(this).next(".close").show();
								$(this).parent().parent().parent().next(
										".z_table").slideDown(100);
							});

					$(".close").click(
							function() {
								$(this).hide();
								$(this).prev(".open").show();
								$(this).parent().parent().parent().next(
										".z_table").slideUp(100);
							});
				});
	</script>
</body>
</html>