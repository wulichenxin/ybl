<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

	<head>
		<meta charset="UTF-8">
		<title>业务介绍</title>
		<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/reset.css" />
	</head>

	<body>
	<%@ include file="/ybl4.0/admin/doorl/common/top-business.jsp" %>
		<!-- <div class="headnav">
			<div class="w1200 clearfix">
				<img class="fl logo" src="/ybl4.0/resources/images/logo_img.png" />
				<div class="clearfix fr ml30">
					<a class="fl login-btn btn-cur">登录</a>
					<a class="fl login-btn">注册</a>
				</div>
				<ul class="clearfix fr">
					<li class="navlist">
						<a href="javascript:;">首页</a>
					</li>
					<li class="navlist">
						<a href="javascript:;">保利咨询</a>
					</li>
					<li class="navlist">
						<a href="javascript:;">业务介绍</a>
					</li>
					<li class="navlist">
						<a href="javascript:;">关于我们</a>
					</li>
				</ul>

			</div>
		</div> -->

		<div class="bannertop">
			<img class="imgw100" src="/ybl4.0/resources/images/home/banner03.png" />
		</div>

		<div class="industryline mt50">
			<div></div>
			<div>
				<p class="PSTitle">融资流程</p>
				<p class="PSEng"><span>I</span>NDUSTRY <span>T</span>RENDS</p>
			</div>
		</div>
		
		<div class="w1200 mt40">
			<img class="centerimg" src="/ybl4.0/resources/images/home/mh_rzlc_img.png" />
		</div>
		
		<div class="member">
			<div class="industryline mt50 pt50">
				<div></div>
				<div>
					<p class="PSTitle">角色说明</p>
					<p class="PSEng"><span>I</span>NDUSTRY <span>T</span>RENDS</p>
				</div>
			</div>
			
			<div class="w1054 clearfix">
				<img src="/ybl4.0/resources/images/home/mg_jssm_img.png" class="fl" />
				<div class="fr btt">
					<p class="Noticetitlt colorb"><img src="/ybl4.0/resources/images/home/cpjs_arr_icon.png" />客户</p>
					<p class="color-yellow zkrz">账款融资<span class="smallsize">应收账款转让</span></p>
					<p class="">卖方（供应商）在平台申请由保理机构购买其与买方因商品赊销产生的应收账款，并在账款到期未付时承担回购应收账款的责任。</p>
				</div>
			</div>
		</div>
		<div>
			<div class="w1054 clearfix">
				<img src="/ybl4.0/resources/images/home/mg_hxqy_img.png" class="fr" />
				<div class="fl btt">
					<p class="Noticetitlt colorb"><img src="/ybl4.0/resources/images/home/cpjs_arr_icon.png" />核心企业</p>
					<p class="color-yellow zkrz">账款确权<span class="smallsize">账款到期兑付</span></p>
					<p class="">买方（核心企业）在平台上对自身开具的账款凭证确权，为有合作关系的买方背书，提升买方在平台的融资资信能力。</p>
				</div>
			</div>
		</div>
		<div class="bgblue">
			<div class="w1054 clearfix">
				<img src="/ybl4.0/resources/images/home/mg_bljg_img.png" class="fl" />
				<div class="fr btt">
					<p class="Noticetitlt colorb"><img src="/ybl4.0/resources/images/home/cpjs_arr_icon.png" />保理机构</p>
					<p class="color-yellow zkrz">审核放款<span class="smallsize">尽职调查   风控审核   结算放款</span></p>
					<p class="">卖方（供应商）在平台申请由保理机构购买其与买方因商品赊销产生的应收账款，并在账款到期未付时承担回购应收账款的责任。</p>
				</div>
			</div>
		</div>
		<div class="bottom">
			<div class="w1200 clearfix">
				<ul class="mr50 fl">
					<li class="botlist biglist">
						<a href="javascript:;">关于我们</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">公司简介</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">企业动态</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">人才招聘</a>
					</li>
				</ul>
				<ul class="mr50 fl">
					<li class="botlist biglist">
						<a href="javascript:;">帮助中心</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">常见问题</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">免责说明</a>
					</li>
				</ul>
				<ul class="mr50 fl">
					<li class="botlist biglist">
						<a href="javascript:;">友情链接</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">深圳XX公司</a>
						<a class="ml30" href="javascript:;">深圳XX公司</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">深圳XX公司</a>
						<a class="ml30" href="javascript:;">深圳XX公司</a>
					</li>
				</ul>
				<ul class="fl">
					<li class="botlist biglist">
						<a href="javascript:;">联系我们</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">电话：0755-86726640</a>
					</li>
					<li class="botlist">
						<a href="javascript:;">传真：0755-26604979</a>
						<a class="ml30" href="javascript:;">邮编：518057</a>
					</li>
				</ul>

				<div class="fr smbox">
					<p class="smp">扫码关注吧!</p>
					<img src="/ybl4.0/resources/images/home/code_foot_img.png" />
				</div>
			</div>

		</div>
		<div class="beian">
			©2017-07-03 深圳市长亮科技股份有限公司 保留所有版权 备案号：粤 ICP 备 17092048 号
		</div>

		<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="/ybl4.0/resources/js/home.js"></script>
	</body>

</html>
