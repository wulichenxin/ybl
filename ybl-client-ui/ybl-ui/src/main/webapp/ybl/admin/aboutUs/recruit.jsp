<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top'}">
	<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
	<jsp:include page="/ybl/admin/common/link.jsp" />
	<jsp:include page="/ybl/admin/common/top.jsp?step=1" />
	<div class="body_con">
</c:if>
<c:if test="${position eq 'bottom' }">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>关于我们</title>
<link href="${app.staticResourceUrl}/ybl/resources/css/about.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery-1.8.0.min.js"></script>
</head>
<body >
	<div class="head_about">
		<div class="top_head">
			<div class="logo"><a href="javacript:void(0)"></a></div>
			<div class="login_nav">
		    	<ul>
		            <li><a href="/ybl/admin/index/login.jsp"><span>首页</span></a></li>
					<li><a href="javascript:void(0);">业务介绍</a></li>
		            <li class="now"><a href="/aboutUsController/toAboutUs">关于我们</a></li>       
		        </ul>
		    </div>
		</div>
	</div>
	<div class="about_banner">
		<div class="about_b_con">
			<!-- <h1>走进国信 让财富温暖人生</h1>
			<h1>是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</h1>
			<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p>
			<p>过互联网和技术手段打通金融服务中存在的痛点，在提高金融服务效率的同时降低服务成本，让更多用户享受到简单、规范、高效的金融服务。</p> -->
			<h1>${companyProfile.title }</h1>
			<%-- <p>${companyProfile.content }</p> --%>
		 </div>
	</div>
	<div id="content" class="body_con">
</c:if>
<div class="content">
	<div class="about_box">
		<h1><span></span>人才招聘</h1>
		<div class="help_about">
 			<ul>
     			<li class="zp_tittle">
	         		<span class="s1">职位</span>
	            	<span class="s2">人数</span>
	            	<span class="s3">工作地区</span>
	            	<span class="s4">发布日期</span>
         		</li>
         		<c:forEach items="${recruitList}" var="recruit">
	         		<li>
	         			<span class="s1">${recruit.roleName}</span>
	         			<span class="s2">${recruit.number}</span>
	         			<span class="s3">${recruit.attribute1}</span>
	         			<span class="s4"><fmt:formatDate value="${recruit.releaseDate}" pattern="yyyy-MM-dd" /></span>
	         			<div class="box" >
                			<div class="k1">
                				<table width="90%" border="0" align="center">
									<tr>
										<td width="27%">工作年限：
											<c:choose>
												<c:when test="${not empty recruit.jobYears}">
													${recruit.jobYears }
												</c:when>
												<c:otherwise>
													不限
												</c:otherwise>
											</c:choose>
										</td>
										<td width="73%">学历：
											<c:choose>
												<c:when test="${recruit.degree eq 'college'}">
													大专
												</c:when>
												<c:when test="${recruit.degree eq 'bachelor'}">
													本科
												</c:when>
												<c:when test="${recruit.degree eq 'master'}">
													硕士
												</c:when>
												<c:otherwise>
													不限
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
									    <td>工作地点：${recruit.attribute2} </td>
									    <td>月薪：${recruit.salary}</td>
									</tr>
								    <tr>
									    <td colspan="2">工作性质：
										    <c:choose>
										    	<c:when test="${recruit.jobCategory eq 'fulltime'}">
													全职
												</c:when>
												<c:when test="${recruit.jobCategory eq 'parttime'}">
													兼职
												</c:when>
												<c:otherwise>
													不限
												</c:otherwise>
										    </c:choose>
									    </td>
								  	</tr>
								</table>
                			</div>
                			<div class="k1">
                				<div class="azp_xx">
                					${recruit.desc}
                				</div>
                			</div>
                		</div>
	         		</li>
         		</c:forEach>
        	</ul>
   		</div>
	</div>
</div>
<%-- <c:if test="${not empty type && position ne 'bottom'}"> --%>
<!-- 	</div> -->
<%-- </c:if> --%>
<script type="text/javascript">
$(function(){
	$('.help_about ul li').click(function(){
		var nowshow = $(this).children(".box").css('display');
		var hasc = $(this).hasClass('c');
		$('.help_about ul li').children('.box').css('display','none');
		if(!hasc){
			if(nowshow == 'none'){
				$(this).children(".box").css('display','block');
				
			}else{
				$(this).children(".box").css('display','none');
			}
		}
		
	});
})
</script>
<c:if test="${position eq 'bottom' }">
		</div>
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
	</body>
</html>
</c:if>
<c:if test="${(position ne 'bottom' && not empty type) || position eq 'top' }">
		</div>
	<jsp:include page="/ybl/admin/common/bottom.jsp" />
</c:if>