<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<%@include file="/ybl/v2/admin/common/link.jsp" %> 
<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/swiper/swiper.min.css" />
		<link rel="stylesheet" href="/ybl4.0/resources/css/icon.css" />
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
</head>
	  <p class="Noticetitlt"><img src="/ybl4.0/resources/images/home/aboutUs_arr_icon.png" />新闻资讯</p>
	  <ul>
	  	<c:forEach items="${newsList}" var="entity">
	  	<li class="clearfix newslist">
	  		<div class="fl"><img class="newsimg" src="${entity.url}" /></div>
	  		<div class="fl newsright">
	  			<p class="newstitle"><a onclick="jumpPost('/gatewayController/newDetail.htm',{id:${entity.id}})">${entity.title}</a><span class="noticetime fr"><img src="/ybl4.0/resources/images/home/active_time_icon01.png" /><fmt:formatDate value="${entity.releaseDate}" pattern="yyyy-MM-dd" /></span></p>
	  			<div class="newscont">${entity.introduction}</div>
	  		</div>
	  	</li>
	  	</c:forEach>
	  </ul>
	  <div class="v2_pages2">
				<%@include file="/ybl/v2/admin/common/newsPageV4.jsp" %>
			</div>
