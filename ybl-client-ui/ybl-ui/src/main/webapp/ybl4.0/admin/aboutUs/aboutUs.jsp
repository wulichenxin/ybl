<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>关于我们</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="${app.staticResourceUrl}/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	})
</script>
<link rel="stylesheet" href="/ybl4.0/resources/css/aboutUs.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/swiper/swiper.min.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/icon.css" />
</head>
<body style="background-color: white;">
		<%@ include file="/ybl4.0/admin/doorl/common/top-business.jsp" %>
		
		<input type="hidden" id="typevalue" value="${type }"/>
		
		<div class="bannertop">
					<div class="swiper-slide"><img draggable="false" class="banner-img" src="/ybl4.0/resources/images/home/aboutUS_banner.jpg" /></div>
			</div>
		</div>
		
		<div class="Breadnav">
			<div class="w1200"><a href="/loginV4Controller/index.htm">首页 </a>> <a href="/gatewayController/toAboutUs.htm">关于我们</a>> <a href="javascript:;" id="titleChange">公司简介</a></div>
		</div>
		<div class="w1200 pore">
			<div id="wrapper">
  <div id="left-side">
	<ul>
	  <li class="choose active leftlist">
	  <div class="bgimg bgimg1"></div>
		公司介绍
	  </li>
	  <li class="pay leftlist">
	  <div class="bgimg bgimg2"></div>
		新闻资讯
	  </li>
	  <li class="wrap leftlist">
	  <div class="bgimg bgimg3"></div>
		平台公告
	  </li>
	  <li class="ship leftlist">
	  <div class="bgimg bgimg4"></div>
		人才招聘
	  </li>
	</ul>
  </div>

  <div id="border">
	<div id="line" class="one"></div>
  </div>

  <div id="right-side">
	<div id="first" class="active">
	 <div class="clearfix">
			
		  <p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />公司简介</p>
		 
			<img src="/ybl4.0/resources/images/comIntr_img.png" class="fr" />
			
			<p class="gsjj">深圳市长亮国信互联网科技有限公司是深圳市国信股权投资基金管理有限公司控股子公司，国信基金是行业领先的综合金融资讯平台，专注于私募基金、股权投资、财富管理等金融信息服务。坚持诚信运营，持续创新，在个人与企业或政府机构之间构筑了完善的资金流通解决方案优势。，帮助个人、家庭、企业乃至国家实现资产的保值增值和传承。 资理念，以独立研究为基础，保持开放视野，强调全球经济独立研究为基础，保持开放视野，强调全球经济</p>
		
		</div>
		
		<div>
			<p class="Noticetitlt mt30"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />公司发展</p>
			<div class="clearfix fals">
				<div class="fl">2009年</div>
				<div class="fl">国信基金作为天津崇石股权投资基金管理有限公司的子公司正式起航</div>
			</div>
			<div class="clearfix fals">
				<div class="fl">2013年</div>
				<div class="fl">国信基金独立运营，成为私募基金行业的新秀</div>
			</div>
			<div class="clearfix fals">
				<div class="fl">2014年</div>
				<div class="fl">国信基金投资成立深圳前海汇通盛达家族资产管理有限公司</div>
			</div>
			<div class="clearfix fals">
				<div class="fl">2015年</div>
				<div class="fl">
					国信基金与中青宝、发改委、财政部共同设立鹏德创投基金（规模2.5亿），投资易停车3000万元<br />
					国信基金完成沈阳大君瓷业有限公司股权变更（间接成为辽宁葫芦岛银行第一大股东）<br />
					国信基金启动海外布局，国信海外金融事业部-“国信利是”正式起航
				</div>
			</div>
			<div class="clearfix fals">
				<div class="fl">2016年</div>
				<div class="fl">
					国信基金入股嘟嘟巴士，此轮融资额达1亿元。<br />
					国信票据权益私募投资基金成为国内首支备案成功的契约型票据基金<br />
					国信基金携手长亮科技（股票代码：300348）成立长亮国信互联网科技有限公司<br />
					中城国信成立，由国信基金、中城创投及汇金顺心投资咨询企业共同出资2亿组建<br />
				</div>
			</div>
			<div class="clearfix fals">
				<div class="fl">2017年</div>
				<div class="fl">
					信美矿业成立，预计将中美能源370亿资产中150亿优质资产重组，打造上市矿产企业<br />
					国信基金控股看门狗财富平台，打造国内一流财富管理中心。<br />
					国信基金与中铁十一局共同投资江苏盐城市滨海医院PPP项目，正式进军PPP产业投资<br />
				</div>
			</div>
		</div>
	
	</div>
	<!-- <div id="second">
	  <p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />新闻资讯</p>
	  <ul>
	  	<li class="clearfix newslist">
	  		<div class="fl"><img class="newsimg" src="/ybl4.0/resources/images/home/mh_news_img.png" /></div>
	  		<div class="fl newsright">
	  			<p class="newstitle"><a href="javascript:;">长亮科技荣获“2015接触频抛形象将”</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></p>
	  			<div class="newscont">7月长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”</div>
	  		</div>
	  	</li>
	  	<li class="clearfix newslist">
	  		<div class="fl"><img class="newsimg" src="/ybl4.0/resources/images/home/mh_news_img.png" /></div>
	  		<div class="fl newsright">
	  			<p class="newstitle"><a href="javascript:;">长亮科技荣获“2015接触频抛形象将”</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></p>
	  			<div class="newscont">7月长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”</div>
	  		</div>
	  	</li>
	  	<li class="clearfix newslist">
	  		<div class="fl"><img class="newsimg" src="/ybl4.0/resources/images/home/mh_news_img.png" /></div>
	  		<div class="fl newsright">
	  			<p class="newstitle"><a href="javascript:;">长亮科技荣获“2015接触频抛形象将”</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></p>
	  			<div class="newscont">7月长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”长亮科技荣获“2015接触频抛形象将”</div>
	  		</div>
	  	</li>
	  </ul>
	  
	</div> -->
	<!-- <div id="third">
	  <p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />平台公告</p>
	  
	  <ul>
	  	<li class="Noticelist"><a href="javascript:;">7月2日志，第六届中国财经峰会在北京如期举行，这是新时沏紧急与金融撒旦</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></li>
	  	<li class="Noticelist"><a href="javascript:;">7月2日志，第六届中国财经峰会在北京如期举行，这是新时沏紧急与金融撒旦</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></li>
	  	<li class="Noticelist"><a href="javascript:;">7月2日志，第六届中国财经峰会在北京如期举行，这是新时沏紧急与金融撒旦</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></li>
	  	<li class="Noticelist"><a href="javascript:;">7月2日志，第六届中国财经峰会在北京如期举行，这是新时沏紧急与金融撒旦</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" />2017-8-8</span></li>
	  </ul>
	</div> -->
	<!-- <div id="fourth">
		<p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />平台公告</p>
		
		<ul class="recruitUl">
			<li class="recruitList">Java开发工程师<span style="font-size: 14px;margin-left: 5px;">[ 工作地点：深圳 ]</span>
				<a href="javascript:;" class="read fr">查看</a>
				<ul>
					<li class="color-black">·&nbsp;&nbsp;职位描述：</li>
					<li>1、参与金融后台服务的设计和开发;</li>
					<li>2、能够独立完成模块的设计和编码，单元测试;</li>
					<li>3、维护和优化现有运行的产品。</li>
					<li class="color-black">·&nbsp;&nbsp;职位要求：</li>
					<li>1、有3年以上的JAVA开发经验;</li>
					<li>2、精通Java语言，熟悉Java EE ;</li>
					<li>3、熟悉HTML、Javascript、AJAX等前端技术，知道如何处理各种浏览器兼容问题;</li>
					<li>4、熟悉Spring/Mybatis等常用开源框架;</li>
					<li>5、熟悉数据库，了解SQL的执行效率及优化;</li>
					<li>6、拥有良好的代码习惯，逻辑思维清晰，良好分析和解决问题的技巧；</li>
					<li>7、能承受工作压力，并能独立完成任务；</li>
					<li>8、有金融行业软件开发经验优先。</li>
				</ul>
			</li>
			<li class="recruitList">Java开发工程师<span style="font-size: 14px;margin-left: 5px;">[ 工作地点：深圳 ]</span>
				<a href="javascript:;" class="read fr">查看</a>
				<ul>
					<li class="color-black">·&nbsp;&nbsp;职位描述：</li>
					<li>1、参与金融后台服务的设计和开发;</li>
					<li>2、能够独立完成模块的设计和编码，单元测试;</li>
					<li>3、维护和优化现有运行的产品。</li>
					<li class="color-black">·&nbsp;&nbsp;职位要求：</li>
					<li>1、有3年以上的JAVA开发经验;</li>
					<li>2、精通Java语言，熟悉Java EE ;</li>
					<li>3、熟悉HTML、Javascript、AJAX等前端技术，知道如何处理各种浏览器兼容问题;</li>
					<li>4、熟悉Spring/Mybatis等常用开源框架;</li>
					<li>5、熟悉数据库，了解SQL的执行效率及优化;</li>
					<li>6、拥有良好的代码习惯，逻辑思维清晰，良好分析和解决问题的技巧；</li>
					<li>7、能承受工作压力，并能独立完成任务；</li>
					<li>8、有金融行业软件开发经验优先。</li>
				</ul>
			</li>
			<li class="recruitList">Java开发工程师<span style="font-size: 14px;margin-left: 5px;">[ 工作地点：深圳 ]</span>
				<a href="javascript:;" class="read fr">查看</a>
				<ul>
					<li class="color-black">·&nbsp;&nbsp;职位描述：</li>
					<li>1、参与金融后台服务的设计和开发;</li>
					<li>2、能够独立完成模块的设计和编码，单元测试;</li>
					<li>3、维护和优化现有运行的产品。</li>
					<li class="color-black">·&nbsp;&nbsp;职位要求：</li>
					<li>1、有3年以上的JAVA开发经验;</li>
					<li>2、精通Java语言，熟悉Java EE ;</li>
					<li>3、熟悉HTML、Javascript、AJAX等前端技术，知道如何处理各种浏览器兼容问题;</li>
					<li>4、熟悉Spring/Mybatis等常用开源框架;</li>
					<li>5、熟悉数据库，了解SQL的执行效率及优化;</li>
					<li>6、拥有良好的代码习惯，逻辑思维清晰，良好分析和解决问题的技巧；</li>
					<li>7、能承受工作压力，并能独立完成任务；</li>
					<li>8、有金融行业软件开发经验优先。</li>
				</ul>
			</li>
		</ul>
		
	</div> -->
  </div>
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
		<script type="text/javascript" src="/ybl4.0/resources/js/swiper/swiper.min.js" ></script>
		<script type="text/javascript" src="/ybl4.0/resources/js/aboutUs.js" ></script>

		

<script type="text/javascript">
     /* $(function () {
         //tab切换
         $('.tab dl dd').click(function () {
             var index = $(this).index();
             $('.v2_content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
             $('.tab dl dd').eq(index).addClass('now').siblings().removeClass('now');
             
             var index = $(this).index();
             if(index == 0){
     	        $.ajax({
     	        	url : "/gatewayController/companyIntroduction",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 1){
     	        $.ajax({
     	        	url : "/gatewayController/news?currentPage=1&pageSize=10",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 2){
     	        $.ajax({
     	        	url : "/gatewayController/notices?currentPage=1&pageSize=10",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             if(index == 3){
     	        $.ajax({
     	        	url : "/gatewayController/contact",
     	        	dataType     : "html",
     	        	success      :  function(data){
     	        		$(".v2_content").html(data);
     	        	}
     	        });
             }
             
         });
     }); */
</script>
</body>
</html>
