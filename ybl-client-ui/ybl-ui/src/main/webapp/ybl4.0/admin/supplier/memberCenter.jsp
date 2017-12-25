<%-- <%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" href="/ybl4.0/resources/css/index.css" />
<link rel="stylesheet" href="/ybl4.0/resources/jquery.datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="/ybl4.0/resources/css/bootstrap.min.css" />
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/htmleaf-demo.css">
<link rel="stylesheet" type="text/css" href="/ybl4.0/resources/css/bootsnav.css">
<link rel="stylesheet" href="/ybl4.0/resources/calendar/index.css" />
<script type="text/javascript" src="/ybl4.0/resources/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/index.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/calendar/index.js" ></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ybl4.0/resources/js/bootsnav.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#accountOverview").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/selectTotalFinancingFeeAndActualAmount");
	});
	$("#receivingacount").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/receivingacount.htm");
	});
	
	$("#supplierreceiving").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplierreceiving.htm");
	});
	
	$("#supplieroverdue").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplieroverdue.htm");
	});
	
	$("#supplierpayoff").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplierpayoff.htm");
	});
	
	$("#supplierrepayments").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplierrepayments.htm");
	});
	$("#supplierloanfail").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplierloanfail.htm");
	});
	
	$("#supplierfinancingfail").click(function(){
		$("#iframe1").attr("src","/supplierAccountCenterController/supplierfinancingfail.htm");
	});
	$("#serviceAuth").click(function(){
		$("#iframe1").attr("src","/serviceAuthenticationController/authHtml");
	});
	$("#memberInfo").click(function(){
		$("#iframe1").attr("src","/accountInfoController/accountInfo");
	});
	$("#cardAuth").click(function(){
		$("#iframe1").attr("src","/accountInfoController/authLook.htm");
	});
	
	
	$('.userlist span').click(function() {
		$('.userlist span').removeClass('listcur');
		$('.userlist span').find('img').attr('src', '/ybl4.0/resources/images/my/list_icon.png');
		$(this).find('img').attr('src', '/ybl4.0/resources/images/my/list_icon_choose.png');
		$(this).addClass('listcur');
		$(this).next('ul').stop().slideToggle(500).parent().siblings().find('ul').slideUp();
	})
	$('.tzjl li').click(function() {
		var index = $(this).index() + 1;
		$('.tzjl li span').removeClass('tzcur');
		$(this).find('span').addClass('tzcur');
		clickShow('.tzjltab', '.tz' + index);
	})
	
	function clickShow(item1, item2) {
		$(item1).hide();
		$(item2).show();
	}
	$('.xinxilist a').click(function() {
	
		if($(this).html() == '保存') {
			$(this).parent().find('input').attr('disabled', true).blur();
			$(this).html('修改');
		} else {
			$(this).parent().find('input').removeAttr('disabled').focus();
			$(this).html('保存');
		}
	})
	$('.showpwd').click(function() {
		if($(this).attr('src') == 'images/my/closeEye_icon.png') {
			$(this).parent().find('input').attr('type', 'text');
			$(this).attr('src', 'images/my/eye_icon.png')
		} else {
			$(this).parent().find('input').attr('type', 'password');
			$(this).attr('src', 'images/my/closeEye_icon.png')
		}
	})
	
})	
</script>
</head>

	<%@ include file="/ybl4.0/admin/common/top.jsp" %>
	<body>
		<div class="person clearfix">
			<div class="per_l fl">
				<div class="userinfo">
					<img class="userimg1" src="/ybl4.0/resources/images/my/photo_icon.png" />
					<p class="usern">${user_session.userName }</p>
					<div class="imgbox"><img src="/ybl4.0/resources/images/my/sfrzPass_icon.png" /><img src="/ybl4.0/resources/images/my/ywrzPass_icon.png" /></div>
				</div>
				<div class="usermenu">
					<ul>
						<li class="userlist">
							<span class="listcur"><img src="/ybl4.0/resources/images/my/list_icon_choose.png" />我的账户</span>
							<ul style="display: block;">
								<li class="mylist">
									<a href="javascript:void(0);" id="accountOverview">账户总览</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="memberInfo">账户信息</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="cardAuth">身份认证</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="serviceAuth">业务认证</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" url="/myMessageV4Controller/messageList.htm">我的消息</a>
								</li>
							</ul>
						</li>
						<li class="userlist">
							<span><img src="/ybl4.0/resources/images/my/list_icon.png" />融资管理</span>
							<ul>
								<li class="rzlist">
									<a href="javascript:void(0);" id="receivingacount">待收款项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplierreceiving">待还款项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplieroverdue">逾期项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplierrepayments">已还款项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplierpayoff">已还清项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplierloanfail">放款失败项目</a>
								</li>
								<li class="rzlist">
									<a href="javascript:void(0);" id="supplierfinancingfail">融资失败项目</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div class="per_r fl">


				<div class="myAccount myAccount1">
					<iframe id="iframe1" onload="resizeIndexIFrame2(this)" src="/supplierAccountCenterController/selectTotalFinancingFeeAndActualAmount" width="100%" height="1500px"></iframe>

				</div>
				
				</div>

		<div class="mb80"></div>
	</body>

</html>