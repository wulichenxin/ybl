<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<title>${app.appName }</title>
		<!-- 公共js css -->
		<jsp:include page="/fw/admin/common/link.jsp" />
		<!-- 功能js css -->
		<script src="/fw/resources/js/admin-head.js" type="text/javascript" ></script>
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url:"/indexController/queryCaseInfo",
					success:function(response){
						var obj = response.object;
						$("#b_case_all").html(obj.caseAllCount);
						$("#b_case_exec").html(obj.caseExecCount);
					},
					error:function(){
						console.log("Error");
					}
				});
			});
		</script>
	</head>
<script type="text/javascript">
</script>
<body style="overflow:hidden;">
	<div class="cont">
		<!-- 业务指引 -->
		<div class="main_tittle">
			<ul>
				<li><span>案件总数:</span><b id="b_case_all">0</b></li>
				<li><span>在催案件数:</span><b id="b_case_exec">0</b></li>
				<li><span>回款总数:</span><b style="color:#f8b600;">0,00</b></li>
			</ul>
		</div>
		<div class="table_box">
			<div class="main_lc">
				<div class="lc_menu">
					<ul>
						<li class="active"><a class="nowhover">步骤<span>1</span><b></b></a><div class="lc_line"><i></i></div></li>
						<li class=""><a class="nowhover">步骤<span>2</span><b></b></a><div class="lc_line"><i></i></div></li>
						<li class=""><a class="nowhover">步骤<span>3</span><b></b></a></li>
					</ul>
				</div>
				<div class="lc_rxx">
				<!-- 初始化流程 -->
					<div class="lc_pic">
						<h1>初始化流程</h1>
						<img src="/fw/resources/images/lc_pic_01.png" class="mt50"/>
					</div>
				<!-- 充值流程-->
					<div class="lc_pic" style=" display:none;">
						<h1>充值流程</h1>
						<img src="/fw/resources/images/lc_pic_02.png" class="mt50"/>
					</div>
				<!-- 催收业务流程 -->
					<div class="lc_pic" style=" display:none;">
						<h1>催收业务流程</h1>
						<img src="/fw/resources/images/lc_pic_03.png"/>
					</div>
				</div>
			</div>
		</div>
		<!-- 业务指引完 -->
		<!-- 报表 -->
		<div class="table_box">
			<div class="main_tubiao">
				<h1>统计报表</h1>
				<div class="main_left">
					<h2>案件状态分布</h2>
					<div class="tubiao1_bz">
					<div class="tubiao1"><img src="/fw/resources/images/main_tubiao1.png"/></div>
						<div class="tubiao1_pos1">
							<p><span class="tb_ico1"></span>催收中</p>
							<p><b>25%</b><i>(50件)</i></p>
						</div>
						<div class="tubiao1_pos2">
							<p><span class="tb_ico2"></span>已退案</p>
							<p><b>25%</b><i>(50件)</i></p>
						</div>
						<div class="tubiao1_pos3">
							<p><span class="tb_ico3"></span>已结案</p>
							<p><b>40%</b><i>(80件)</i></p>
						</div>
						<div class="tubiao1_pos4">
							<p><span class="tb_ico4"></span>已停催</p>
							<p><b>10%</b><i>(20件)</i></p>
						</div>
						<!--  <ul>
							<li><span class="tb_ico1"></span>催收中</li>
							<li><span class="tb_ico2"></span>已退案</li>
							<li><span class="tb_ico3"></span>已结案</li>
							<li><span class="tb_ico4"></span>已停催</li>
						</ul>-->
					</div>
				</div>
				<div class="main_right">
					<h2>支出/回款比率图</h2>
					<div class="tubiao2_bz">
						<ul>
							<li><span class="tb2_ico1"></span>支出</li>
							<li><span class="tb2_ico2"></span>回款</li>
							<li><span class="tb2_ico3" style="width:30px;"></span>每回款100元所得花费的金额</li>
						</ul>
					</div>
					<div class="tubiao2"><img src="/fw/resources/images/main_tubiao2.png"/></div>
					
				</div>
			</div>
		</div>
		<!-- 报表完 -->
		<!-- 坐席监控 -->
			<div class="main_zxbox">
				<h1>坐席监控</h1>
				<div class="main_zx">
					<ul id="seat_monitor">
					<!-- 1 -->
						<li>
							<div class="zx_nb"><span>1</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>13613897076</dd>
									<dd><b><em class="ls2">催收</em>员：</b>五岚军</dd>
								</dl>
							</div>
							<div class="zx_zt"><span></span><p class="">在线</p></div>
						</li>
					<!-- 1 -->
					<!-- 1 -->
						<li>
							<div class="zx_nb_l"><span>2</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>18801287663</dd>
									<dd><b><em class="ls2">催收</em>员：</b>柯南一</dd>
								</dl>
							</div>
							<div class="zx_zt_l"><span></span><p class="">离线</p></div>
						</li>
					<!-- 1 -->
					<!-- 1 -->
						<li>
							<div class="zx_nb"><span>3</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>13632501236</dd>
									<dd><b><em class="ls2">催收</em>员：</b>伍晓艳</dd>
								</dl>
							</div>
							<div class="zx_zt"><span></span><p class="">在线</p></div>
						</li>
					<!-- 1 -->
					<!-- 1 -->
						<li>
							<div class="zx_nb_l"><span>4</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>15889623252</dd>
									<dd><b><em class="ls2">催收</em>员：</b>周海艳</dd>
								</dl>
							</div>
							<div class="zx_zt_l"><span></span><p class="">离线</p></div>
						</li>
					<!-- 1 -->
					<!-- 1 -->
						<li>
							<div class="zx_nb"><span>5</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>13670028807</dd>
									<dd><b><em class="ls2">催收</em>员：</b>刘云岚</dd>
								</dl>
							</div>
							<div class="zx_zt"><span></span><p class="">在线</p></div>
						</li>
					<!-- 1 -->
					<!-- 1 -->
						<li>
							<div class="zx_nb"><span>6</span></div>
							<div class="zx_xx">
								<dl>
									<dd><b><em class="ls1">电</em>话：</b>18001287212</dd>
									<dd><b><em class="ls2">催收</em>员：</b>冬韵</dd>
								</dl>
							</div>
							<div class="zx_zt"><span></span><p class="">在线</p></div>
						</li>
					<!-- 1 -->
					</ul>
				</div>
			</div>
		<!-- 坐席监控完 -->
		
	</div>
	<script type="text/template" id="seatTemplateOnline">
		<li id="seat#{seatId}" class="seat_online" seatId="#{seatId}">
			<div class="zx_nb"><span>#{index}</span></div>
			<div class="zx_xx">
				<dl>
					<dd><b><em class="ls1">电</em>话：</b>#{callNumber}</dd>
					<dd><b><em class="ls2">催收</em>员：</b>#{callUser}</dd>
				</dl>
			</div>
			<div class="zx_zt"><span></span><p class="">在线</p></div>
		</li>
	</script>
	<script type="text/template" id="seatTemplateOffline">
		<li id="seat#{seatId}" class="seat_offline" seatId="#{seatId}">
			<div class="zx_nb_l"><span>#{index}</span></div>
			<div class="zx_xx">
				<dl>
					<dd><b><em class="ls1">电</em>话：</b>#{callNumber}</dd>
					<dd><b><em class="ls2">催收</em>员：</b>#{callUser}</dd>
				</dl>
			</div>
			<div class="zx_zt_l"><span></span><p class="">离线</p></div>
		</li>
	</script>
	<script type="text/javascript">
        $(function () {

            //tab切换
            $('.lc_menu ul li').click(function () {
                var index = $(this).index();
                $('.lc_pic').eq(index).show().addClass('active').siblings().removeClass('active').hide();
                $('.lc_menu ul li').eq(index).addClass('active').siblings().removeClass('active');
            });
            
            function refreshSeatEmpty(seatId,isOnline,callUser){
            	var seat = $("#seat_"+seatId);
            	if(isOnline){
            		seat.find(".callUser").text(callUser);
            		seat.find(".callStatus").text("在线").parent().removeClass("zx_zt_l").addClass("zx_zt");
            	}else{
            		seat.find(".callUser").text("");
            		seat.find(".callStatus").text("离线").parent().removeClass("zx_zt").addClass("zx_zt_l");
            	}
            }
            
            /**
             * 注册坐席单击事件,签到/签退
             */
            function registerSeatClickEvent(){
            	$("#seat_monitor .seat_offline").unbind("click").bind("click",function(){
            		var seatId = $(this).attr("seatId");
            		confirm("是否签到?",function(){
            			window.loading();
						$.ajax({
            				url:"/seatController/ajaxOnlineSeat",
            				data:{seatId:seatId},
            				dataType:"json",
            				success:function(response){
            					window.closeLoading();
            					if(response.responseTypeCode=="success"){
            						alert("签到成功!")
            						loadSeatList();
            					}else{
            						alert(response.info)
            					}
            				},
            				error:function(data){
            					window.closeLoading();
            					alert("签到失败,请重试!")
            				}
            			});
            		});
            	});
				$("#seat_monitor .seat_online").unbind("click").bind("click",function(){
					var seatId = $(this).attr("seatId");
					confirm("是否签退?",function(){
						window.loading();
            			$.ajax({
            				url:"/seatController/ajaxOfflineSeat",
            				data:{seatId:seatId},
            				dataType:"json",
            				success:function(response){
            					window.closeLoading();
            					if(response.responseTypeCode=="success"){
            						alert("签退成功!")
            						loadSeatList();
            					}else{
            						alert(response.info)
            					}
            				},
            				error:function(data){
            					window.closeLoading();
            					alert("签退失败,请重试!")
            				}
            			});
            		});
            	});
            }
            
            function loadSeatList(){
            	$.ajax({
                	url:"/seatController/ajaxLoadSeatList",
                	dataType:"json",
                	success:function(resp){
                		if(resp){
    	           			var datas = resp.object;
    	           			$("#seat_monitor").html("");
    	            		var len = datas&&datas.length;
    	            		if(len&&len>0){
    	            			var offTemplate = $("#seatTemplateOffline").html();
    	            			var onTemplate = $("#seatTemplateOnline").html();
    	            			var appendContent = "";
    	            			for(var i=0;i<len;i++){
    	            				var data = datas[i];
    	            				var seatId = data.id;
    	            				var callNumber = data.callNumber;
    	            				var nick = data.nick;
    	            				if(data.isOnline){//在线
    	            					appendContent = onTemplate.replace("#{seatId}",seatId).replace("#{seatId}",seatId).replace("#{callNumber}",callNumber).replace("#{callUser}",nick).replace("#{index}",(i+1));
    	            				}else{//离线
    	            					appendContent = offTemplate.replace("#{seatId}",seatId).replace("#{seatId}",seatId).replace("#{callNumber}",callNumber).replace("#{callUser}","").replace("#{index}",(i+1));
    	            				}
    	            				$("#seat_monitor").append(appendContent);
    	            			}
    	            			registerSeatClickEvent();
    	            		}
                		}
                	},
                	error:function(data){
                		console.log("加载催收坐席异常");
                	}
                });
            }
            loadSeatList();
            window.loadSeatList = function(){loadSeatList()}
        });
    </script>
</body>
</html>