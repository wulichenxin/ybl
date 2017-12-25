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
<title>云保理</title>
<link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/swiper/swiper.min.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/icon.css" />
</head>
<script type="text/javascript">
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
<body style="background-color: white;">

	<div id="second" class="active">
	<form method="post" id="newPageForm">
	  <p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />新闻资讯</p>
	  <ul>
	  	<c:forEach items="${newsList}" var="entity">
	  	<li class="clearfix newslist">
	  		<div class="fl"><img class="newsimg" src="${entity.url}" /></div>
	  		<div class="fl newsright">
	  			<p class="newstitle"><a  onclick="jumpPost('/gatewayController/newDetail.htm',{id:${entity.id}})">${entity.title}</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" /><fmt:formatDate value="${entity.releaseDate}" pattern="yyyy-MM-dd" /></span></p>
	  			<div class="newscont">${entity.introduction}</div>
	  		</div>
	  	</li>
	  	</c:forEach>
	  </ul>
	  <div class="v2_pages2">
				<%@include file="/ybl/v2/admin/common/newsPageV4.jsp" %>
			</div>
		</form>
	</div>
</body>
</html>
