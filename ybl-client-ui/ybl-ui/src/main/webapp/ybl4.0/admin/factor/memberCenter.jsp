<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>长亮国信</title>
</head>
	<jsp:include page="/ybl4.0/admin/common/top.jsp" />
	<body>
		<div class="person clearfix">
			<div class="per_l fl">
				<div class="userinfo">
					<img class="userimg1" src="/ybl4.0/resources/images/my/photo_icon.png" />
					<p class="usern">${user_session.userName }</p>
					<div class="imgbox"><img src="/ybl4.0/resources/images/my/sfrzPass_icon.png" /><img src="/ybl4.0/resources/images/my/ywrzPass_icon.png" /></div>
				</div>
				<div class="usermenu" style="overflow:auto;">
					<ul>
						<li class="userlist">
							<span class="listcur"><img src="/ybl4.0/resources/images/my/list_icon_choose.png" />我的账户</span>
							<ul style="display: block;">
								<li class="mylist">
									<a style="color:#D5B46B;"  href="javascript:void(0);" url="/factorAccountCenterController/myAccount.htm">账户总览</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="memberInfo">账户信息</a>
								</li>
								<li class="mylist">
									<a href="javascript:void(0);" id="cardAuth">身份认证</a>
								</li>
								<li class="mylist">
									<a  href="javascript:void(0);" url="/serviceAuthenticationController/authHtml">业务认证</a>
								</li>
								<li class="mylist">
									<a  href="javascript:void(0);" url="/myMessageV4Controller/messageList.htm">我的消息</a>
								</li>
							</ul>
						</li>
					</ul>
					<ul>
						<li class="userlist">
							<span class="listcur"><img src="/ybl4.0/resources/images/my/list_icon_choose.png" />投资管理</span>
							<ul style="display: block;">
								<li class="mylist setUrl">
									<a href="javascript:void(0);" url="/factorInvestManagementController/getSecuredLoanRepaymentList.htm">已放款项目</a>
								</li>
								<li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorRepaymentPlanController/pendingPayment.htm">待回款项目</a>
                                </li>
                                <li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorRepaymentPlanController/overdue.htm">已逾期项目</a>
                                </li>
                                <li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorRepaymentPlanController/finish.htm">已回款明细</a>
                                </li>
                                <li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorInvestManagementController/getSecuredLoanRepaymentFinishedList.htm">已完成项目</a>
                                </li>
                                <li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorInvestManagementController/getFailedSubApplyList.htm">投资失败项目</a>
                                </li>
                                <li class="mylist setUrl">
                                    <a href="javascript:void(0);" url="/factorInvestManagementController/getFailedLoanApplyList.htm">放款失败项目</a>
                                </li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div class="per_r fl">
				<div class="myAccount myAccount1">
					<iframe id="iframe1" onload="resizeIndexIFrame2(this)" src="/factorAccountCenterController/myAccount.htm" width="100%" height="1000px"></iframe>
				</div>
				</div>

		<div class="mb80"></div>
	</body>
	<script type="text/javascript">
	$(function(){
		//iframe跳转
		$(".setUrl").click(function(){
			var url = $(this).attr("url");
			$(window.parent.document).find("#iframe1").attr("src",url); 
		});
	})
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
				if($(this).attr('src') == '/ybl4.0/resources/images/my/closeEye_icon.png') {
					$(this).parent().find('input').attr('type', 'text');
					$(this).attr('src', '/ybl4.0/resources/images/my/eye_icon.png')
				} else {
					$(this).parent().find('input').attr('type', 'password');
					$(this).attr('src', '/ybl4.0/resources/images/my/closeEye_icon.png')
				}
			})
			//点击添加color属性
			$(".mylist").click(function(){
				$(".mylist").removeAttr("style");
				$(this).attr('style', 'color:#D5B46B;');
			})
			//账户信息
			$("#memberInfo").click(function(){
				$("#iframe1").attr("src","/accountInfoController/accountInfo");
			});
			//身份认证
			$("#cardAuth").click(function(){
				$("#iframe1").attr("src","/accountInfoController/authLook.htm");
			});
			
		</script>

</html>