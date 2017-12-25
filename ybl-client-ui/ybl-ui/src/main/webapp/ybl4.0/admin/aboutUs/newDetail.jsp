<!-- 新闻详情页 -->
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>云保理</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${app.staticResourceUrl}/ybl/resources/css/xcConfirm.css" />
<!-- 提示框 -->
<script language='javascript'
	src='${app.staticResourceUrl}/ybl/resources/js/jquery-1.9.1.js'></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/xcConfirm.js"></script>
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
	})
	function jumpPost(url,args) {
	if(null == args) {
		return;
	}
 	var form = $("<form method='post'></form>");
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
<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/swiper/swiper.min.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/icon.css" />
</head>
<body style="background-color: white;">
		<%@ include file="/ybl4.0/admin/doorl/common/top-business.jsp" %>
		<div class="Breadnav" style="margin-top: 100px;">
			<div class="w1200"><a href="/loginV4Controller/index.htm">首页 </a>> <a href="/gatewayController/toAboutUs.htm">关于我们</a> > 新闻资讯</div>
		</div>
		<div class="w1200" style="min-height: 500px;">
			<p class="detail_title">${currentNews.title }</p>
			<p class="detail_date"><img src="/ybl4.0/resources/images/time.png" /><fmt:formatDate value="${currentNews.releaseDate }" pattern="yyyy-MM-dd"/></p>
			<div class="detailCont">
				<!-- <img src="images/home/new_img2.png" /> -->
				<p>
				${currentNews.content}
				</p>
			</div>
			<div class="clearfix" style="text-align: right;margin: 50px 0;">
			<c:if test="${not empty prevNews }">
				<a onclick="jumpPost('/gatewayController/newDetail.htm',{id:${prevNews.id }})" class="propnews">上一篇</a>
			</c:if>
			<c:if test="${not empty nextNews }">
				<a onclick="jumpPost('/gatewayController/newDetail.htm',{id:${nextNews.id }})" class="nextnews">下一篇</a>
				</c:if>
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
		<script type="text/javascript" src="/ybl4.0/resources/js/home.js" ></script>

		<script>
			var mySwiper = new Swiper('.swiper-container', {
				autoplay: 3000, //可选选项，自动滑动
				loop: true,
				pagination: '.swiper-pagination',
				autoplayDisableOnInteraction: false,
				paginationClickable: true,
				simulateTouch: false,
				observer:true,//修改swiper自己或子元素时，自动初始化swiper
    		observeParents:true,//修改swiper的父元素时，自动初始化swiper
			});
		</script>
</body>
</html>
