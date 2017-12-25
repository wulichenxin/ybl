<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>权限管理</title>
<jsp:include page="../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
	$(function() {
		view = function(id) {
			$.msgbox({
				height : 546,
				width : 640,
				content : '${app.staticResourceUrl}/ybl/admin/factor/user/permissionEdit.jsp',
				type : 'iframe',
				title : '新增权限'
			});
		}
	});
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<!--top end -->
	<div class="path">当前位置->用户管理 -> 权限管理</div>
	<div class="vip_conbody">
		<!--搜索条件-->
		<div class="seach_box" id="submit_box">
			<div class="switch" onclick="hideform();">
				<a></a>
			</div>
			<div class="fl">
				<ul>
					<li><label>权限组名称:</label><input type="text" /></li>
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
			<div class="table_top ">
				<div class="table_nav">
					<ul>
						<li><a href="javascript:view(1);" class="but_ico7">新增</a></li>
						<li><a class="but_ico3">编缉</a></li>
						<li><a class="but_ico1">删除</a></li>
					</ul>
				</div>
			</div>
			<!--按钮top-->
			<div class="table_con ">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="tb">
					<tr>
						<th width="50"><input type="checkbox" /></th>
						<th width="50">序号</th>
						<th>权限组编号</th>
						<th>权限组名称</th>
						<th>权限组描述</th>

					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1</td>
						<td>001</td>
						<td>系统管理员</td>
						<td>系统管理员权限组</td>

					</tr>
					<tr class="bg_l">
						<td><input type="checkbox" /></td>
						<td>1</td>
						<td>001</td>
						<td>系统管理员</td>
						<td>系统管理员权限组</td>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1</td>
						<td>001</td>
						<td>系统管理员</td>
						<td>系统管理员权限组</td>
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
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
	<!-- 底部jsp -->
</body>
</html>