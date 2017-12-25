<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>首页</title>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon">
<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/swiper.min.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/icon.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/reset.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script language='javascript' src="/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/swiper.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/home.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-ui-1.8.6.core.widget.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/jqueryui.bannerize.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/countUp.min.js" ></script>
<script type="text/javascript">
	$(function() {
		$('.produ').hover(function() {
			$(this).addClass('produ_cur');
			if($(this).hasClass('produLeft')) {
				$(this).find('.produimg').attr('src', '/ybl4.0/resources/images/home/mh_blgsHov_img.png')
			} else {
				$(this).find('.produimg').attr('src', '/ybl4.0/resources/images/home/mh_qykhHov_img.png')
			}

		}, function() {
			$(this).removeClass('produ_cur');
			if($(this).hasClass('produLeft')) {
				$(this).find('.produimg').attr('src', '/ybl4.0/resources/images/home/mh_blgs_img.png')
			} else {
				$(this).find('.produimg').attr('src', '/ybl4.0/resources/images/home/mh_qykh_img.png')
			}
		})
		$('.cardbox').hover(function() {
			$('.cardbox').find('.card').removeClass('card_cur');
			$(this).find('.card').addClass('card_cur');
		}, function() {
			$('.cardbox').find('.card').removeClass('card_cur');
			$('#card2').addClass('card_cur');
			$(this).find('.hidetxt').css("opacity", '0')
			//					$('#card2').next('.hidetxt').css("opacity",'1')
		})
		$('.card_cur').parent().css('z-index', '100');
		//				$('.card_cur').parent().find('.hidetxt').css("opacity",'1')
		
		var mySwiper = new Swiper('.swiper-container', {
			autoplay: 3000, //可选选项，自动滑动
			loop: true,
			pagination: '.swiper-pagination',
			autoplayDisableOnInteraction: false,
			paginationClickable: true,
			simulateTouch: false,
			observer: true, //修改swiper自己或子元素时，自动初始化swiper
			observeParents: true, //修改swiper的父元素时，自动初始化swiper
		});
		
		$('#banners').bannerize({
			shuffle: 1,
			interval: "5"
		});
		$(".ui-line").hover(function() {
			$(this).addClass("ui-line-hover");
			$(this).find(".ui-bnnerp").addClass("ui-bnnerp-hover");
		}, function() {
			$(this).removeClass("ui-line-hover");
			$(this).find(".ui-bnnerp").removeClass("ui-bnnerp-hover");
		});
		
		var options = {useEasing : true, useGrouping : true, separator : ',', decimal : '.', prefix : '', suffix : '' };
		var demo = new CountUp("myTargetElement", 0, 50, 0, 2.5, options);
		var demo2 = new CountUp("myTargetElement2", 0, 9, 0, 2.5, options);
		var demo3 = new CountUp("myTargetElement3", 0, 20330, 0, 2.5, options);
		var demo4 = new CountUp("myTargetElement4", 0, 64, 0, 2.5, options);
		demo.start();
		demo2.start();
		demo3.start();
		demo4.start();
		
		//行业动态展示
		/* $(".newDetail").click(function(){
			var href = $(this).attr('href');
			window.open(href,'_blank');
		}) */
	})
	
function jumpPost(url,args) {
	if(null == args) {
		return;
	}
 	var form = $("<form method='post' target='_blank'></form>");
    form.attr({"action":url});
    for (arg in args) {
        var input = $("<input type='hidden'>");
        input.attr({"name":arg});
        input.val(args[arg]);
        form.append(input);
    }
    $(document.body).append(form);
    form.submit();
}	
</script>
<style>
.newDetail{
color:#333;
text-decoration: none
}
.ui-line:hover .newDetail{
color:white}
</style>
</head>

	<body>
		<%@ include file="/ybl4.0/admin/doorl/common/top-index.jsp" %>
		<div class="bannertop">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img draggable="false" class="banner-img" src="/ybl4.0/resources/images/home/banner-01.jpg" /></div>
					<div class="swiper-slide"><img draggable="false" class="banner-img" src="/ybl4.0/resources/images/home/banner-02.jpg" /></div>
					<div class="swiper-slide"><img draggable="false" class="banner-img" src="/ybl4.0/resources/images/home/banner05.jpg" /></div>
				</div>
				<div class="swiper-pagination"></div>
			</div>

		</div>

		<div class="BgWhite">
			<div class="w1200">
				<ul class="clearfix">
					<li class="statisticsList clearfix">
						<img class="fl" src="/ybl4.0/resources/images/home/mh_cje_icon.png" />
						<div class="ml20 fl">
							<p><span class="bigsize color-yellow" id="myTargetElement">1</span>亿<span class="bigsize color-yellow">32</span>万元</p>
							<p>累计成交额</p>
						</div>
					</li>
					<li class="statisticsList clearfix">
						<img class="fl" src="/ybl4.0/resources/images/home/mh_cjxm_icon.png" />
						<div class="ml20 fl">
							<p><span class="bigsize color-blue" id="myTargetElement2">9</span>个</p>
							<p>累计成交项目</p>
						</div>
					</li>
					<li class="statisticsList clearfix">
						<img class="fl" src="/ybl4.0/resources/images/home/mh_rzf_icon.png" />
						<div class="ml20 fl">
							<p><span class="bigsize color-yellow2" id="myTargetElement3">20330</span>个</p>
							<p>进驻融资方</p>
						</div>
					</li>
					<li class="statisticsList clearfix">
						<img class="fl" src="/ybl4.0/resources/images/home/mg_tzf_icon.png" />
						<div class="ml20 fl">
							<p><span class="bigsize color-green" id="myTargetElement4">64</span>个</p>
							<p>进驻投资方</p>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<div class="products">

			<p class="PSTitle">产品服务</p>
			<p class="PSEng"><span>P</span>RODUCTS <span>S</span>RRVICE</p>

			<div class="w1200 clearfix">
				<div class="produ produLeft">
					<img class="produimg" src="/ybl4.0/resources/images/home/mh_blgs_img.png" />
					<p class="blt">保理公司</p>
					<ul class="clearfix">
						<li class="blList">
							<p>账户管理：</p>
							支持系统化保理专户，实现实时账户查询、应收账款回款自动核销、保理专户回款监控等功能；提供卖方保理专户托管、自身分户账管理、资金结算及理财增值服务。
						</li>
						<li class="blList">
							<p>风险控制：</p>
							支持基础信息管理、应收账款管理、会计账目管理、预警管理；提供还款锁定功能，保理专户划扣、协议自动扣划融资本金。
						</li>
						<li class="blList">
							<p>在线交易：</p>
							支持保理资产在线交易，对接、撮合与相关资产所有方的资产交易业务；挖掘、分拣、推送平台海量交易信息数据，供集中交易。
						</li>
					</ul>
				</div>
				<div class="produ produRight">
					<img class="produimg" src="/ybl4.0/resources/images/home/mh_qykh_img.png" />
					<p class="blt">企业客户</p>
					<ul class="clearfix">
						<li class="blList">
							<p>在线融资：</p>
							支持全流程线上融资，卖方在线转让应收账款、在线融资申请，买方线上确认；支持各方在线对账，线上审核放款，产品流程自定义设计。
						</li>
						<li class="blList">
							<p>信息管理：</p>
							提供实时融资信息明细、状态跟踪系统支持，应付账款、融资额度、预算、保理比对等多维度分析图表。
						</li>
						<li class="blList">
							<p>在线交易：</p>
							支持保理资产在线交易，对接、撮合与相关资产所有方的资产交易业务；挖掘、分拣、推送平台海量交易信息数据，供集中交易。
						</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="coreCom">
			<div class="bgcore">
				<div></div>
				<p class="PSTitle color-white">核心优势</p>
				<p class="PSEng color-white">CPRE COMPETENCY</p>
			</div>

			<div class="cdbox">
				<div class="clearfix cdbox2">
					<div class="cardbox">
						<div class="card">
							<div>
								<img src="/ybl4.0/resources/images/home/mh_hxys01_icon.png" />
								<p class="iconbt">一体化线上流程</p>

							</div>
						</div>
						<div class="hidetxt">51平台提供便捷的申请引导以及专业的平台审核，提高保理业务实施的效率以及有效性。</div>

					</div>
					<div class="cardbox">
						<div id="card2" class="card card_cur">
							<div>
								<img src="/ybl4.0/resources/images/home/mh_hxys02_icon.png" />
								<p class="iconbt">全自动供需匹配</p>

							</div>
						</div>
						<div class="hidetxt">利用大数据系统实现定向推荐以及竞标系统，为不同的角色匹配最符合条件的对接资源。</div>
					</div>
					<div class="cardbox">
						<div class="card">
							<div>
								<img src="/ybl4.0/resources/images/home/mh_hxys03_icon.png" />
								<p class="iconbt">标准化还款结算</p>

							</div>
						</div>
						<div class="hidetxt">平台数据跟踪，还款日前后自动提醒还款；零人工介入，标准化结果反馈，逾期风险提前获知。</div>
					</div>
				</div>
			</div>

		</div>

		<div class="industry">
			<div class="industryline">
				<div></div>
				<div>
					<p class="PSTitle">行业动态</p>
					<p class="PSEng"><span>I</span>NDUSTRY <span>T</span>RENDS</p>
				</div>
			</div>

		
			<div class="w1200">
				<div class="index-new w1200 mt30">
					<div class="indexadd mt50 mb60">
						<div id="banners" class="ui-banner">
							<ul class="ui-banner-slides">
								<c:forEach var="list" items="${newsList}" varStatus="index" begin="0" end="3" step="1" >
									<li>
										<a style="cursor:pointer" onclick="jumpPost('/gatewayController/newDetail.htm',{id:${list.id}})"><img src="${list.url}"/></a>
									</li>
								</c:forEach>
							</ul>
							<!--ui-banner-slides end-->
							<ul class="ui-banner-slogans">
								<c:forEach var="list" items="${newsList}" varStatus="index" begin="0" end="3" step="1" >
									<li class="ui-line">
										<div class="ullinehover">
											<div class="ui-bnnerimg floatLeft">
												<img src="${list.url}" width="103" height= "83" />
											</div>
											<div class="ui-bnnerp floatRight">
												<h3 style="margin-top: 8px;"><a style="cursor:pointer"  onclick="jumpPost('/gatewayController/newDetail.htm',{id:${list.id}})">${list.title}</a></h3>
												<p>${list.introduction}
												</p>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
							<!--ui-banner-slogans end-->
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="joinyubl">
			<div class="w1200">
				<p class="PSTitle mb30">加入云保理</p>
				<div><img src="/ybl4.0/resources/images/home/joinYBL_img.png" /></div>
			</div>
		</div>

		<div class="bottom">
			<div class="w1200 clearfix">
				<ul class="mr50 fl">
					<li class="botlist biglist">
						<a href="/loginV4Controller/toAboutUs.htm">关于我们</a>
					</li>
					<li class="botlist">
						<a href="/gatewayController/bottomToAboutUs.htm?type=choose">公司简介</a>
					</li>
					<li class="botlist">
						<a href="/gatewayController/bottomToAboutUs.htm?type=pay">企业动态</a>
					</li>
					<li class="botlist">
						<a href="/gatewayController/bottomToAboutUs.htm?type=ship">人才招聘</a>
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
						<a href="http://www.guofubaoli.com/index.php" target="_blank">深圳国富商业保理有限公司</a>
					</li>
					<li class="botlist">
						<a href="http://www.sunline.cn/" target="_blank">深圳市长亮科技股份有限公司</a>
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
	</body>

</html>
