<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<meta name="Keywords" content="云保理">
<meta name="Description" content="云保理">
<meta name="Copyright" content="云保理" />
<title>保理详情</title>
<link href="/ybl/resources/images/favicon.ico" rel="shortcut icon" mce_href="/ybl/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/css/common.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/common.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript">
$(function() {
	 change = function()
	 {
		 var money = $("#money").val();
		 var term = $("#term").val();
		 var rate = $("#rate").val();
		 var minAmount = $("#minAmount").val();
		 var maxAmount = $("#maxAmount").val();
		 var minTerm = $("#minTerm").val();
		 var maxTerm = $("#maxTerm").val();
		 if(!money)
		  {
		   $("#totalMoney").html();
		   return;
		  }
		 if(!term)
		 {
		  $("#totalMoney").html();
		  return;
		 }
		 money = parseFloat(money);
		 term = parseFloat(term);
		 rate = parseFloat(rate);
		 minAmount = parseFloat(minAmount);
		 maxAmount = parseFloat(maxAmount);
		 minTerm = parseFloat(minTerm);
		 maxTerm = parseFloat(maxTerm);
		 if(money < minAmount || money > maxAmount)
			 {
			  alert("融资金额应该在"+minAmount+"~"+maxAmount+"万元区间内");
			  return;
			 }
		 if(term < minTerm ||term > maxTerm )
			 {
			 alert("融资期限应该在"+minTerm+"~"+maxTerm+"月区间内");
			 return;
			 }
		 var total = money * term * rate /100 / 12;
		 $("#totalMoney").html(parseFloat(total).toFixed(2));
	 }
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
	<input type="hidden" value="${products.minAmount }" id="minAmount"/>
    <input type="hidden" value="${products.maxAmount }" id="maxAmount"/>
    <input type="hidden" value="${products.minTerm }" id="minTerm"/>
    <input type="hidden" value="${products.maxTerm }" id="maxTerm"/>
    <input type="hidden" value="${products.rate }" id="rate"/>
		<!-- <div class="ybl-head">
			<div class="w1200 clearfix">
				<div class="fl">
					欢迎您！<span class="username">15814435455</span><span class="notice-sp"><img class="notice-img" src="/ybl4.0/resources/images/site/mess_icon.png" /><i></i></span>
				</div>
				<div class="fr">
					<img class="userAvatar" src="/ybl4.0/resources/images/site/pic_icon.png" /><span class="mr10 ml10">已登录</span>
					<a class="dropOut" href="javascript:;">退出</a><img class="ml30 mr10" src="/ybl4.0/resources/images/site/tel_icon.png" />0755-12345678
				</div>
			</div>
		</div> -->

		<%@ include file="/ybl4.0/admin/doorl/common/top-blzx.jsp" %>
		
		<div class="w1200 mt40">
			<p class="bl-title smallfont">${products.name }<span>超低利率，低至年利率<fmt:formatNumber value="${products.rate}" type="percent"/></span></p>
			
			<div class="clearfix">
				<div class="fl mt30 ml50 blxq">
					<div class="ground-form mb20">
						<div class="form-grou">
							<label>融资金额：</label><input placeholder="可选金额<fmt:formatNumber type="number" value="${products.minAmount }" pattern="#,##0.00" />万  ~<fmt:formatNumber type="number" value="${products.maxAmount }" pattern="#,##0.00" />万 " 
							class="content-form2" id="money" onblur="change()"  /><span class="timeimg">万元</span>
						</div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou"><label>融资期限：</label><input placeholder="可选期限${products.minTerm }个月~${products.maxTerm }个月"  class="content-form2" id="term" onblur="change()" /><span class="timeimg">月</span>
						</div>
					</div>
					<!-- <div class="ground-form mb20">
						<div class="form-grou"><label>融资利率：</label><input placeholder="年利率" class="content-form2" /><span class="timeimg">2.1%</span></div>
					</div> -->
				</div>
				<div class="fl mt30 rightbtn">
					<p class="costP clearfix">总费用:<span><span id="totalMoney"></span>万元</span></p>
					<div class="clearfix">
						<div class="fr hksm mt30"><img src="/ybl4.0/resources/images/blzx/tips_icon.png" />提前还款说明
							<div class="hktoggle">${products.desc }</div>
						</div>
					</div>
					<a class="cx-btn mt30" style="cursor:pointer"  onclick="jumpPost('/factorConsultationController/toVisitor.htm',{id:${products.id }})">朕要垂询</a>
				</div>
			</div>
			
			<div class="consultant clearfix">
				<div class="fl">顾问点评：</div>
				<div class="fl consuright">${products.adviserComment }<!-- 小额贷款协会第二次月例根据实际融资金额和利用天数另行计算，最高1%深户或有社保，满足其一即可申请(社保徐最近3个月缴费最快40分钟审批，当天可放款) --></div>
			</div>
			
			<div class="mt30 mb30">
				<img src="/ybl4.0/resources/images/blzx/blzx_pro_img.png" />
			</div>
			
			<div class="promptBox">
				<ul class="clearfix navul">
					<li class="navlist nav_cur">贷款须知</li>
					<li class="navlist nav_scroll">成功案例</li>
				</ul>
				
				<div class="application clearfix">
					<p class="dkxztitle"><img src="/ybl4.0/resources/images/blzx/blzc_arr_icon.png" class="mr10" />申请条件</p>
					<div class="fl applileft">
						<p class="claim">深圳本地户籍</p>
						<p>年龄要求：18-60周岁</p>
						<p>居住要求：深圳市</p>
						<div class="clearfix">
							<div class="fl">工作要求：</div>
							<div class="fl w235">在现单位连续工作满3个月在现单位连续工作满3个月在现单位连续工作满3个月在现单位连续工作满3个月</div>
						</div>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
					</div>
					
					<div class="fr applileft">
						<p class="claim">其他异地户籍</p>
						<p>年龄要求：18-60周岁</p>
						<p>居住要求：深圳市</p>
						<div class="clearfix">
							<div class="fl">工作要求：</div>
							<div class="fl w235">在现单位连续工作满3个月在现单位连续工作满3个月在现单位连续工作满3个月在现单位连续工作满3个月</div>
						</div>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
					</div>
				</div>
				
				<div class="dashedline mt30 mb30"></div>
				
				
				<div class="clearfix application">
					<p class="dkxztitle mb20"><img src="/ybl4.0/resources/images/blzx/blzc_arr_icon.png" class="mr10" />所需材料</p>
					<div class="fl applileft">
						<p>年龄要求：18-60周岁</p>
						<p>居住要求：深圳市</p>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
						<p>收入要求：近3个月每月代发或者现金存入银行的金额大于2500元</p>
					</div>
				</div>
				
				<div class="border-b mt30 mb30"></div>
				
				<div>
					<p class="successtitle">成功案例</p>
					<ul class="successul">
						<c:forEach var="list" items="${list}" varStatus="index" begin="0" end="2" step="1" >
							<li class="successlist"><span>${list.financeName }</span><span>融资金额：￥<span>${list.financeAmount }</span>万元</span><span>申请时间：<fmt:formatDate value="${list.applyDate }" pattern="yyyy年MM月dd日"/></span></li>
						</c:forEach>
					</ul>
				</div>
			</div>
	
		</div>
</body>
</html>
