<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/ybl/v2/admin/common/link.jsp" %> 
<title>云保理2.0</title>
<%-- <link href="${app.staticResourceUrl}/ybl/resources/v2/css/vip_page_v2.css"
	rel="stylesheet" type="text/css" /> --%>
<script type="text/javascript">
	$(function() {
		window.alert = function(msg) {
			window.wxc.xcConfirm(msg, window.wxc.xcConfirm.typeEnum.info);
		}
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
			  alert("融资金额应该在"+minAmount+"~"+maxAmount+"区间内");
			  return;
			 }
		 if(term < minTerm ||term > maxTerm )
			 {
			 alert("融资期限应该在"+minTerm+"~"+maxTerm+"区间内");
			 return;
			 }
		 var total = money * term * rate /100 / 12;
		 $("#totalMoney").html(parseFloat(total).toFixed(2));
	 }
	})
</script>
</head>
<body>
<div class="factoring_ban h165">
	<div class="v2_top_con">
		<div class="v2_head_top">
			 <%@ include file="/ybl/v2/admin/common/topV2.jsp" %>  
		</div>
		
	</div>	
</div>

<!---->
<div class="clear"></div>
<div class="factoring_details_box">
    <input type="hidden" value="${products.minAmount }" id="minAmount"/>
    <input type="hidden" value="${products.maxAmount }" id="maxAmount"/>
    <input type="hidden" value="${products.minTerm }" id="minTerm"/>
    <input type="hidden" value="${products.maxTerm }" id="maxTerm"/>
    <input type="hidden" value="${products.minRate }" id="rate"/>
	<div class="factoring_details_p">
		<h1>${products.name }</h1>
		<h2>${products.desc }</h2>
		<div class="factoring_d_top">
			<ul>
			<li><div class="factoring_rzje "><label>融资金额：</label><div class="position_hover fl"><input type="text" id="money" onblur="change()" /><span>万元</span>
			<div style="width:300px;">可选金额
							 <c:choose>
										<c:when test="${products.minAmount >= 10000}">
											<fmt:formatNumber type="number" value="${products.minAmount/10000 }" pattern="#,##0.0000" />亿 
					  					</c:when>
					  				 	<c:otherwise>
											<fmt:formatNumber type="number" value="${products.minAmount }" pattern="#,##0.0000" />万 
					 					</c:otherwise>
							 </c:choose>
							 ~
							 <c:choose>
										<c:when test="${products.maxAmount >= 10000}">
											<fmt:formatNumber type="number" value="${products.maxAmount/10000 }" pattern="#,##0.0000" />亿 
							  			</c:when>
										<c:otherwise>
											<fmt:formatNumber type="number" value="${products.maxAmount }" pattern="#,##0.0000" />万 
							  			</c:otherwise>
							</c:choose>
			</div>
			</div></div>
			<div class="factoring_rzje "><label>融资期限：</label><div class="position_hover fl"><input type="text" id="term" onblur="change()"/><span>个月</span><div>可选期限${products.minTerm }个月~${products.maxTerm }个月</div></div></div></li>
			<li>总费用：<font class="red f18" id="totalMoney"></font>万元</li>
			<li><span class="fl mr100">利率说明：年利率<fmt:formatNumber value="${products.minRate }" pattern="0.00"/>% </span><div class="position_hover fl w200"><a class="gay_9 unl ">提前还款说明</a>
			<div class="v2_input_box" style="height:auto; top:30px;">${products.rateDesc }
			  <!-- <textarea class="v2_text_tea h100 w300" name="voucherRemark" id="voucher_remark"></textarea> -->
			</div>
			</div></li>
			</ul>
			<div class="clear"></div>
			<div class="factoring_but d_p"><a href="javascript:view(${products.id });">朕要垂询</a></div>
		</div>
		<div class="comment_box">
			<label>顾问点评：</label>
			<div class="comment_xx">
			    ${products.comment }
				<!-- <p>小额贷款协会第二次荣誉副会长及理事单位、</p>
				<p>月利根据实际融资金额和利用天数另行计算，最高1%</p>
				<p> [深户或有社保，满足其一即可申请（社保需最近3个月缴费成功）]</p>
				<p>最快45分钟审批，当天可放款</p> -->
			</div>
		</div>
		<div class="process"></div>
		<div class="f_details_box">
			<div class="f_details_tab">
				<dl>
					<dd class="now"><a>贷款须知</a></dd>
					<dd><a>成功案例</a></dd>
				</dl>
			</div>
			<div>
			<div class="f_details_con">
				  ${products.content }
			</div>
				<!--2-->
				<div class="f_details_con" style="display: none;">
				    <div class="f_details_list">
<!--					<h3>成功案例</h3>-->
					<div class="f_details_case">
						<ul>
						 <c:forEach var="list" items="${list}" varStatus="index" >
							<li>
								<div class="details_case">
									<div class="case_left">
										<div class="case_left_pic"></div>
										<p><fmt:formatNumber value="${list.financeAmount }" pattern="#,#00.0#"/>万</p>
									</div>
									<div class="case_left">
										<h4 >${list.financeStatus }
									</h4>
										<h5>${list.financeName }</h5>
									</div>
									<div class="case_right">
									<fmt:formatDate value="${list.applyDate }" pattern="yyyy-MM-dd"/> 
										  申请
									</div>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
					
				   </div>
				  
				   
				</div>
			</div>
		</div>
	</div>
</div>
<div class="clear"></div>
 <%@ include file="/ybl/v2/admin/common/bottom.jsp" %> 
<%-- <%@include file="/ybl/admin/common/bottomV2.jsp" %> --%>

<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/yuangong_v2.js"></script>
<script type="text/javascript"
		src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox_v2.js"></script>
<script type="text/javascript">

        $(function () {

            //tab切换

			//tab切换

            $('.f_details_box dl dd').click(function () {

                var index = $(this).index();

                $('.f_details_con').eq(index).show().addClass('now').siblings().removeClass('now').hide();

                $('.f_details_box dl dd').eq(index).addClass('now').siblings().removeClass('now');
                
              	//bottom高度
				var min_height = $('.f_details_con').eq(index).height();
				$(window).scroll(function() {
					//获取窗口的滚动条的垂直位置      
					var s = $(window).height();
					//当窗口的滚动条的垂直位置大于页面的最小高度时 
					if (s < min_height) {
						$(".v2_foot_bottom").removeClass("v2_foot_pos");
					} else {
					   $(".v2_foot_bottom").addClass("v2_foot_pos");
					};
				});
				if($(".v2_foot_bottom")) {
					$('body').height(min_height + 60);// 60为bottom的高度
				}
            });

             

        });

        

    </script>
<script type="text/javascript">
$(function(){   
	var productId = 
	view = function(id) {
		$.msgbox({
			height:650,
			width:850,
			content:'/gatewayController/toOrder.htm?id='+id,
			type :'iframe',
			title: '预约'
		});
		$('body').css({overflow:'hidden'});
	}
	
});   

</script>
</body>
</html>
