<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>保理咨询</title>
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/home.css" />
 <link rel="stylesheet" href="/ybl4.0/resources/css/reset.css" />
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/css/common.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script language='javascript' src="/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<!-- <script type="text/javascript" src="/ybl4.0/resources/js/common.js" ></script> -->
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript">
$(function() {
	$("#search").click(function(){
		if(!$("#minAmount").validationEngine('validate')) {
 			return;
 		}
		if(!$("#minTerm").validationEngine('validate')) {
 			return;
 		}
		if(!$("#minRate").validationEngine('validate')) {
 			return;
 		}
		$("#pageForm").submit();
	});
})
function jumpPost(url,args) {
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
<body>
	<!-- <div class="ybl-head">
		<div class="w1200 clearfix">
			<div class="fl">
				欢迎您！<span class="username">15814435455</span><span class="notice-sp"><img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span>
			</div>
			<div class="fr">
				<img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" />
				<a class="dropOut" href="/loginV4Controller/index.htm">退出</a><img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-12345678
			</div>
		</div>
	</div> -->

	<%@ include file="/ybl4.0/admin/doorl/common/top-blzx.jsp" %>
		
		
		<div class="bl-cont">
			<img src="/ybl4.0/resources/images/home/blzx_banner.png" />
			<div class="bl-info clearfix">
			<form action="/factorConsultationController/queryProductList.htm" id="pageForm" method="post">
				<div class="fl blcont-left">
					<div class="grounp">
						<label>贷款金额</label><input type="text" id="minAmount"  name="minAmount" class="validate[custom[number]]" /><span class="timeimg">万元</span>
					</div>
					<div class="grounp">
						<label>贷款期限</label><input type="text" id="minTerm" name="minTerm" class="validate[custom[number]]" /><span class="timeimg">月</span>
					</div>
					<div class="grounp">
						<label>贷款利率</label><input type="text" id="minRate" name="minRate" class="validate[custom[number]]" /><span class="timeimg">%</span>
					</div>
					<div class="grounp">
						<a class="foundbl" href="javascript:;" id="search">搜索保理</a>
					</div>
				</div>
			</form>	
				<div class="fl blcont-right mt20">
					<div><img src="/ybl4.0/resources/images/blzx/blcx_conputer_icon.png" /></div>
					<div class="clearfix mt40">
						<div class="fl ml60">
							<p>获批融资</p>
							<p class="bigfont">1180<span>亿</span></p>
						</div>
						<div class="fl ml30">
							<p>入驻平台</p>
							<p class="bigfont">1180<span>家</span></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="w1200">
			<p class="bl-title">热门保理<a href="/factorConsultationController/queryProductList.htm" class="more-a">更多>></a></p>
			<ul class="clearfix mt30">
				<li class="bllist">
					<c:if test="${empty v4productList0.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList0.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList0.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" >查询</a>
					</c:if>
					<c:if test="${!empty  v4productList0.url  }">
						<img src="${v4productList0.url}" width="338" height= "280"/>
						<p>${v4productList0.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList0.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer"  onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList0.id}})">查询</a>
					</c:if>
				</li>
				<li class="bllist">
					<c:if test="${empty v4productList1.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList1.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList1.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" >查询</a>
					</c:if>
					<c:if test="${!empty  v4productList1.url  }">
						<img src="${v4productList1.url}" width="338" height= "280"/>
						<p>${v4productList1.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList1.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList1.id}})">查询</a>
					</c:if>
				</li>
				<li class="bllist">
					<c:if test="${empty v4productList2.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList2.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList2.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" >查询</a>
					</c:if>
					<c:if test="${!empty  v4productList2.url  }">
						<img src="${v4productList2.url}" width="338" height= "280"/>
						<p>${v4productList2.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList2.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList2.id}})">查询</a>
					</c:if>
				</li>
				<li class="bllist">
					<c:if test="${empty v4productList3.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList3.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList3.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" >查询</a>
					</c:if>
					<c:if test="${!empty  v4productList3.url  }">
						<img src="${v4productList3.url}" width="338" height= "280"/>
						<p>${v4productList3.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList3.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList3.id}})">查询</a>
					</c:if>
				</li>
				<li class="bllist">
					<c:if test="${empty v4productList4.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList4.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList4.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer">查询</a>
					</c:if>
					<c:if test="${!empty  v4productList4.url  }">
						<img src="${v4productList4.url}" width="338" height= "280"/>
						<p>${v4productList4.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList4.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer"  onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList4.id}})">查询</a>
					</c:if>
				</li>
				<li class="bllist">
					<c:if test="${empty v4productList5.url }">
						<img class="cpimg" src="/ybl4.0/resources/images/blzx/blzx_noPicBig_img.png" />
						<p>${v4productList5.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList5.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer" >查询</a>
					</c:if>
					<c:if test="${!empty  v4productList5.url  }">
						<img src="${v4productList5.url}" width="338" height= "280"/>
						<p>${v4productList5.name}</p>
						<p>超低利率，低至年利率<fmt:formatNumber value="${v4productList5.rate}" type="percent"/></p>
						<a class="bl-btn" style="cursor:pointer"  onclick="jumpPost('/factorConsultationController/queryProductById.htm',{id:${v4productList5.id}})">查询</a>
					</c:if> 
				</li>
			</ul>
		</div>
	</body>
</html>
