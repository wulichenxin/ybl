<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8"
	deferredSyntaxAllowedAsLiteral="true"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String step = request.getParameter("step");
request.setAttribute("step", step);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@include file="/ybl4.0/admin/common/link.jsp" %>
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/font-awesome.min.css" />
<script type="text/javascript">
	  $(function(){
		  $("#logout").click(function(){
			  confirm("确定退出登录？",function(){
				  window.location.href='/loginV4Controller/logout';
			  });
		  });
		  
		  
		 function ajaxLoadMenu(){
				var $menuUL = $("#navbar-menu");
				var data =${user_menu}; 
				var len = data&&data.length;
				if(len){
					var htmlArray = [];
					htmlArray.push("<ul class='nav navbar-nav' data-in='fadeInDown' data-out='fadeOutUp'>");
						for(var i=0;i<len;i++){
							var top = data[i];
							if(!top.parent_id||top.parent_id==""||top.parent_id==0){//parentId为空
								if(top.is_leaf == 1){
									htmlArray.push("<li class='dropdown'>"+"<a  href='"+top.url_ +"'class='dropdown-toggle'"+"'data-toggle='dropdown'>"+top.name_+"</a>");
								}else{
									htmlArray.push("<li class='dropdown'>"+"<a  href='"+top.url_ +"'data-toggle='dropdown'>"+top.name_+"</a>");
								}
							htmlArray.push("<ul class='dropdown-menu'>");
							for(var j=0;j<len;j++){
								var child = data[j];
								if(child.parent_id==top.id_){
									htmlArray.push("<li class='dropdown'>"+"<a  href="+child.url_ +">"+child.name_+"</a>");
								}
								htmlArray.push("<ul class='dropdown-menu'>");
								for(var t=0;t<len;t++){
									var childtwo = data[t];
									if(childtwo.parent_id==child.id_){
										htmlArray.push("<li>"+"<a  href="+childtwo.url_ +">"+childtwo.name_+"</a>");
									}
								}
								htmlArray.push("</ul>");
								htmlArray.push("</li>");
							}
							htmlArray.push("</ul>");
							htmlArray.push("</li>");
						}
						htmlArray.push("</li>");
					}
					htmlArray.push("</ul>");
					$menuUL.html(htmlArray.join(""));
					aa();
				}
			}
			//加载菜单
			ajaxLoadMenu();
	  });
	</script>
</head>
<body>
	<div class="ybl-head">
			<div class="w1200 clearfix">
				<div class="fl">
					<img class="ml30 mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/tel_icon.png" />0755-86726640
					<%-- <span class="notice-sp"><img class="notice-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span> --%>
				</div>
				<div class="fr">
					欢迎您！<span class="username">${user_session.userName }</span>
					<img class="userAvatar" src="${app.staticResourceUrl}/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span>
					<a class="dropOut" href="javascript:;" id="logout">退出</a>
				</div>
			</div>
		</div>
 <div class="ybl-nav">
			<div class="w1200">
				<a href="/loginV4Controller/index.htm"><img src="/ybl4.0/resources/images/com-logo.png" class="logo" style="margin-top: 14px;vertical-align: unset;"/></a>
				<nav class="navbar navbar-default navbar-mobile bootsnav fr">
					<div class="collapse navbar-collapse" id="navbar-menu">
					</div>
				</nav>
			</div>
		</div>
		
		<script>
		$(function(){
			$('.dropdown').on('click','a',function(){
				  var href = $(this).attr('href');
				  window.location.href = href;
			  })
		})
		</script>
</body>
</html>
