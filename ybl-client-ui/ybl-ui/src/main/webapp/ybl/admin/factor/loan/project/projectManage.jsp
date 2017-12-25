<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>项目管理</title>
<jsp:include page="../../../common/link.jsp" />
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
	function add_close() {
		clearInterval(timer);
		$('#add').hide();
		$('body').css({
			overflow : ''
		});
	}
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../../common/top.jsp?step=3" />
	<!--top end -->
	<div class="path">当前位置->贷款管理 -> 项目管理</div>
	<div class="vip_conbody">

		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label>贷款编号:</label><input type="text" /></li>
					<li><label>客户名称:</label><input type="text" /></li>
					<li><label>审核状态:</label><select name=""><option>全部</option>
							<option>初审</option>
							<option>复审</option>
							<option>初审不通过</option>
							<option>复审不通过</option>
							<option>终结</option></select></li>
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
		<div class="table_box ">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a>项目列表</a>
					</dd>
				</dl>
			</div>
			<!--按钮top-->
			<div class="table_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="100">序号</th>
						<th>贷款编号</th>
						<th>项目名称</th>
						<th>客户名称</th>
						<th>联系电话</th>
						<th>贷款金额</th>
						<th>年利率</th>
						<th>贷款期限</th>
						<th>保理类型</th>
						<th>操作</th>
					</tr>
					<tr>
						<td>1</td>
						<td>001</td>
						<td><a class="lan" href="${app.staticResourceUrl}/ybl/admin/factor/loan/project/projectDetails.jsp">材料供应商A类贷款</a></td>
						<td>材料供应商</td>
						<td>0755-786567</td>
						<td>5000.00万</td>
						<td>8%</td>
						<td>6个月</td>
						<td>线上明保理</td>
						<td><div class="but_but">
								<a>去融资</a>
							</div></td>

					</tr>
					<tr class="bg_l">
						<td>1</td>
						<td>001</td>
						<td><a class="lan" href="${app.staticResourceUrl}/ybl/admin/factor/loan/project/projectDetails.jsp">材料供应商A类贷款</a></td>
						<td>材料供应商</td>
						<td>0755-786567</td>
						<td>5000.00万</td>
						<td>8%</td>
						<td>6个月</td>
						<td>线上明保理</td>
						<td><div class="but_but">
								<a>去融资</a>
							</div></td>

					</tr>
					<tr>
						<td>1</td>
						<td>001</td>
						<td><a class="lan" href="${app.staticResourceUrl}/ybl/admin/factor/loan/project/projectDetails.jsp">材料供应商A类贷款</a></td>
						<td>材料供应商</td>
						<td>0755-786567</td>
						<td>5000.00万</td>
						<td>8%</td>
						<td>6个月</td>
						<td>线上明保理</td>
						<td><div class="but_but">
								<a>去融资</a>
							</div></td>

					</tr>
					<tr class="bg_l">
						<td>1</td>
						<td>001</td>
						<td><a class="lan" href="${app.staticResourceUrl}/ybl/admin/factor/loan/project/projectDetails.jsp">材料供应商A类贷款</a></td>
						<td>材料供应商</td>
						<td>0755-786567</td>
						<td>5000.00万</td>
						<td>8%</td>
						<td>6个月</td>
						<td>暗保理</td>
						<td><div class="but_but">
								<a>去融资</a>
							</div></td>

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


	</div>
	<!--table-->

	</div>

	<!-- 底部jsp -->
	<jsp:include page="../../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>