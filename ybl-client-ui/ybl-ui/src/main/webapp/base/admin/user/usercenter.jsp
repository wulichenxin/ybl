<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title>催收宝</title>
<meta name="Keywords" content="催收宝">
<meta name="Description" content="催收宝">
<meta name="Copyright" content="催收宝" />
<link href="css/page.css" rel="stylesheet" type="text/css"/>
<jsp:include page="/fw/admin/common/link.jsp" />
<script type="text/javascript">
	
	$(function(){
		$("#btn-recharge").click(function(){
			window.location.href="/rechargeController/pay.htm"
		});
		$(function(){
			//查询账户余额
			$.ajax({
				url:"/indexController/getEnterpriseAmount",
				success:function(data){
					$("#btn-amount").text(data.object);
				},
				error:function(){
				}
			});
			//查询账户资金配置信息
			
		});
	})
	
</script>

</head>
<body> 

<div class="cont"> 


	<!--搜索条件-->
	<div class="table_box basic">
        <div class="basic_l">
            <ul>
            	<li class="bline"><h1>当前可用余额（元）</h1><p><b class="yellow f48" id="btn-amount">0.00</b><span class="cz_but"><a id="btn-recharge">充值</a></span></p></li>
                <li><h1><i>当前实际支出（元）</i><em></em></h1><p><b class="gay_9 f36">0.00</b><span><a href="充值明细.html" class="lan">查看账单</a></span></p></li>
            </ul>
        </div>
        <div class="basic_r">
        	<div class="basic_tb">
            	<div class="prel2">
					<script type="text/javascript">
                        $(document).ready(function() {
                            var has_borrow = 18111.00;
                            var need = 81889;
                            var report = {
                                "section_412": [{
                                    "label": "",
                                    "data": has_borrow
                                }, {
                                    "label": "",
                                    "data": need
                                }]
                            }
                            customizeHighcharts();
                            initDistribution_small(report.section_412, 'maturity_412', '');
                        });
                    </script>
        
                    <div data-highcharts-chart="1" style="height: 200px; width:200px;" class="maturity_412">  </div>
                    <div class="progress_div2">
                        <div class="tjd2">
                            <div class="round"><span>当月消耗</span><p>60条</p></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="basic_ul">
            	<ul>
                	<li><span><em class="dx"></em>短信</span><b>1条短信=0.0.08元钱</b></li>
                    <li><span><em class="yy"></em>语音</span><b>1条语音=0.1元钱</b></li>
                    <li><span><em class="ly"></em>录音</span><b>1条录音=0.1元钱</b></li>
                </ul>
            </div>
        </div>
    </div>
</div> 


<script type="text/javascript" src="js/yuangong.js"></script>



</script>
<script src="/fw/resources/js/navlist.js" type="text/javascript"></script><!-- 进度条 -->
<script src="/fw/resources/js/underscore.js" type="text/javascript"></script><!-- 进度条 -->
<script src="/fw/resources/js/highcharts.js" type="text/javascript"></script><!-- 进度条 -->
</body>


</html>
