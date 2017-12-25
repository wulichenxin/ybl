<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/css/index.css" />
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
		<link rel="stylesheet" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootstrap.min.css" />
		<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/htmleaf-demo.css">
		<link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootsnav.css">
	</head>

	<body>

		<div class="ybl-head">
			<div class="w1200 clearfix">
				<div class="fl">
					欢迎您！<span class="username">15814435455</span><span class="notice-sp"><img class="notice-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span>
				</div>
				<div class="fr">
					<img class="userAvatar" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span>
					<a class="dropOut" href="javascript:;">退出</a><img class="ml30 mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/tel_icon.png" />0755-12345678
				</div>
			</div>
		</div>

		<div class="ybl-nav">
			<div class="w1200">
				<img src="${app.staticResourceUrl}/ybl4.0/resources/images/com-logo.png" class="logo" />
								<nav class="navbar navbar-default navbar-mobile bootsnav fr">
									<div class="collapse navbar-collapse" id="navbar-menu">
										<ul class="nav navbar-nav" data-in="fadeInDown" data-out="fadeOutUp">
											<li>
												<a href="#">首页</a>
											</li>
											<li class="dropdown">
												<a href="#" class="dropdown-toggle" data-toggle="dropdown">业务办理</a>
												<ul class="dropdown-menu">
													<li>
														<a href="#">明保理</a>
													</li>
													<li>
														<a href="#">暗保理</a>
													</li>
													<li class="dropdown">
														<a href="#" class="" data-toggle="dropdown">放款申请</a>
														<!--<ul class="dropdown-menu">
															<li>
																<a href="#">Custom Menu</a>
															</li>
															<li>
																<a href="#">Custom Menu</a>
															</li>
															<li class="dropdown">
																<a href="#" class="dropdown-toggle" data-toggle="dropdown">Sub Menu</a>
																<ul class="dropdown-menu multi-dropdown">
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																</ul>
															</li>
															<li>
																<a href="#">Custom Menu</a>
															</li>
														</ul>-->
													</li>
												</ul>
											</li>
											<li>
												<a>风控管理</a>
											</li>
											<li class="dropdown">
												<a href="#" class="" data-toggle="dropdown">结算管理</a>
												<!--<ul class="dropdown-menu">
													<li>
														<a href="#">Custom Menu</a>
													</li>
													<li>
														<a href="#">Custom Menu</a>
													</li>
													<li class="dropdown">
														<a href="#" class="dropdown-toggle" data-toggle="dropdown">综合管理</a>
														<ul class="dropdown-menu">
															<li>
																<a href="#">Custom Menu</a>
															</li>
															<li>
																<a href="#">Custom Menu</a>
															</li>
															<li class="dropdown">
																<a href="#" class="dropdown-toggle" data-toggle="dropdown">合同管理</a>
																<ul class="dropdown-menu multi-dropdown">
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																	<li>
																		<a href="#">Custom Menu</a>
																	</li>
																</ul>
															</li>
															<li>
																<a href="#">Custom Menu</a>
															</li>
														</ul>
													</li>
													<li>
														<a href="#">Custom Menu</a>
													</li>
													<li>
														<a href="#">Custom Menu</a>
													</li>
													<li>
														<a href="#">Custom Menu</a>
													</li>
													<li>
														<a href="#">Custom Menu</a>
													</li>
												</ul>-->
											</li>
											<li>
												<a href="#">综合管理</a>
											</li>
											<li>
												<a href="#">合同管理</a>
											</li>
											<li>
												<a href="#">账户中心</a>
											</li>
										</ul>
									</div>
								</nav>
			</div>
		</div>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span class="mr10 ml10">-</span>放款申请<span class="mr10 ml10">-</span>新增</div>
		</div>
		
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist"><div class="proicon bg1 statusOne"></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg2 statusTwo"></div>平台初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg3 statusThree"></div>资方初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg4 statusTwo"></div>选择意向资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg5 statusThree"></div>资方终审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg6 statusThree"></div>合作资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg7 statusTwo"></div>平台复审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist"><div class="proicon bg8 statusThree"></div>签署主合同</li>
			</ul>	
			
		</div>
		
	
		
		<div class="w1200">
		<p class="protitleWhite"><span></span>选择意向资方</p>
			<div class="tabD">
				<table>
					<tr>
						<th>序号</th>
						<th>融资订单号</th>
						<th>资方名称</th>
						<th>意向投资金额</th>
						<th>意向融资期限</th>
						<th>意向投资利率</th>
						<th>竞标时间</th>
						<th>初审意见表</th>
						<th>备注说明</th>
						<th>意向资方</th>
					</tr>
					<tr>
						<td>1</td>
						<td>明保理需求订单待提交</td>
						<td>供应商1，融资申请，</td>
						<td>2017-02-20</td>
						<td></td>
						<th>意向投资利率</th>
						<th>竞标时间</th>
						<th>初审意见表</th>
						<th>备注说明</th>
						<th><img src="${app.staticResourceUrl}/ybl4.0/resources/images/agree_icon.png" /></th>
					</tr>
					<tr>
						<td>1</td>
						<td>明保理需求订单待提交</td>
						<td>供应商1，融资申请，</td>
						<td>2017-02-20</td>
						<td></td>
						<th>意向投资利率</th>
						<th>竞标时间</th>
						<th>初审意见表</th>
						<th>备注说明</th>
						<th><img src="${app.staticResourceUrl}/ybl4.0/resources/images/disagree_icon.png" /></th>
					</tr>
					<tr>
						<td>1</td>
						<td>明保理需求订单待提交</td>
						<td>供应商1，融资申请，</td>
						<td>2017-02-20</td>
						<td></td>
						<th>意向投资利率</th>
						<th>竞标时间</th>
						<th>初审意见表</th>
						<th>备注说明</th>
						<th><img src="${app.staticResourceUrl}/ybl4.0/resources/images/disagree_icon.png" /></th>
					</tr>
				</table>
			</div>
			
			<div class="btn2 mt40 clearfix mb80">
				<a href="javascript:;" class="btn-add">上一页</a>
				<a href="javascript:;" class="btn-add">返回</a>
			</div>
			
		</div>
		
		
		
		<div class="mb80"></div>
		
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/bootsnav.js"></script>
	</body>

</html>