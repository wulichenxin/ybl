<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>标的管理</title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=3" />
	<!--top end -->

	<div class="path">当前位置->贷款申请 -> 保理服务 -> 保理商详情 -> 融资产品详情</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tittle">
				<h1>
					<i class="v_tittle_2"></i>融资产品详情
				</h1>
			</div>
			<div class="rzsq_box">
				<h1>产品概述</h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span>产品名称：</span><input placeholder="电子供应商" type="text"
									class="w770 text_gary" />
							</div></li>
						<li><div class="input_box">
								<span>保理类型：</span>
								<div class="select_box">
									<select class="select w200">
										<option>请选择</option>
										<option>线上明保理</option>
										<option>线下明保理</option>
										<option>暗保理</option>
									</select>
								</div>
							</div></li>
						<li><div class="input_box">
								<span>产品描述：</span>
								<textarea class="text_tea w770 h200"></textarea>
							</div></li>

					</ul>
				</div>
			</div>
			<div class="rzsq_box">
				<h1>产品详情</h1>
				<div class="rzzt">
					<ul>
						<li><div class="input_box">
								<span>产品名称：</span><input placeholder="电子供应商" type="text"
									class="w770 text_gary" />
							</div></li>
						<li><div class="input_box">
								<span>保理类型：</span>
								<div class="select_box">
									<select class="select w200">
										<option>请选择</option>
										<option>线上明保理</option>
										<option>线下明保理</option>
										<option>暗保理</option>
									</select>
								</div>
							</div></li>
						<li class=" clear w472">
							<div class="input_box">
								<span>还款方式：</span>
								<div class="radio">
									<input class="radio_input" type="radio" name="RadioGroup1"
										value="单选" />到期一次性还本付息
								</div>
							</div>
						</li>
						<!-- <li class="clear w472"><div class="input_box">
								<span>还款日规则：</span>
								<div class="radio">
									<input class="radio_input" type="radio" name="RadioGroup1"
										value="单选" />
									<div class="select_box">
										<select class="select w50 mr10">
											<option>>=</option>
											<option>></option>
										</select>
									</div>
									贷款凭证最早到期日
								</div>
							</div></li> -->
						<li class=" w472"><div class="input_box">
								<span>贷款利率：</span>
								<div>
									年利率<input placeholder="10" type="text"
										class="text w50 mr10 ml10" />%
								</div>
							</div></li>
						<li class="clear w472"><div class="input_box">
								<span>逾期利率：</span>
								<div>
									日利率<input placeholder="10" type="text"
										class="text w50 mr10 ml10" />%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span>管理费百分比：</span>
								<div>
									年利率<input placeholder="10" type="text"
										class="text w50 mr10 ml10" />%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span>违约利率：</span>
								<div>
									日利率<input placeholder="10" type="text"
										class="text w50 mr10 ml10" />%
								</div>
							</div></li>
						<li class="w472"><div class="input_box">
								<span>融资比例：</span><input placeholder="20" type="text"
									class="text w50 mr10" />%
							</div></li>
					</ul>
				</div>
			</div>



			<div class="rzsq_box">
				<h1>费用收取配置</h1>
				<!--按钮top-->
				<div class="table_top mt20 table_border">
					<div class="table_nav">
						<ul>
							<li><a class="but_ico2">选择基础费用</a></li>
							<li><a class="but_ico1">删除</a></li>
						</ul>
					</div>
				</div>
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><input name="" type="checkbox" value="" /></th>
							<th>序号</th>
							<th>费用类型</th>
							<th>费用比例</th>
						</tr>
						<tr>
							<td><input name="" type="checkbox" value="" /></td>
							<td>001</td>
							<td>提前还款违约金</td>
							<td>1:5</td>
						</tr>
						<tr class="bg_l">
							<td><input name="" type="checkbox" value="" /></td>
							<td>002</td>
							<td>逾期还款违约金</td>
							<td>2:3</td>
						</tr>
					</table>

				</div>
			</div>
			<div class="rzsq_box">
				<h1>贷款材料配置</h1>
				<!--按钮top-->
				<div class="table_top mt20 table_border">
					<div class="table_nav">
						<ul>
							<li><a class="but_ico2">选择基础费用</a></li>
							<li><a class="but_ico1">删除</a></li>
						</ul>
					</div>
				</div>
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><input name="" type="checkbox" value="" /></th>
							<th>序号</th>
							<th>贷款材料名称</th>
							<th>备注</th>
						</tr>
						<tr>
							<td><input name="" type="checkbox" value="" /></td>
							<td>001</td>
							<td>必备材料</td>
							<td>贷款这必须提供的材料</td>
						</tr>
						<tr class="bg_l">
							<td><input name="" type="checkbox" value="" /></td>
							<td>002</td>
							<td>身份证正面</td>
							<td></td>
						</tr>
					</table>

				</div>
			</div>
			<div class="rzsq_box">
				<h1>贷款归档材料配置</h1>
				<!--按钮top-->
				<div class="table_top mt20 table_border">
					<div class="table_nav">
						<ul>
							<li><a class="but_ico2">选择基础费用</a></li>
							<li><a class="but_ico1">删除</a></li>
						</ul>
					</div>
				</div>
				<div class="table_con table_border ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="tb">
						<tr>
							<th width="50"><input name="" type="checkbox" value="" /></th>
							<th>序号</th>
							<th>归档材料名称</th>
							<th>备注</th>
						</tr>
						<tr>
							<td><input name="" type="checkbox" value="" /></td>
							<td>001</td>
							<td>尽职调查报告</td>
							<td></td>
						</tr>
						<tr class="bg_l">
							<td><input name="" type="checkbox" value="" /></td>
							<td>002</td>
							<td>银行流水</td>
							<td></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>