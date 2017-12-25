<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>合同签署</title>
	</head>
<!--top start -->
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<!--top end -->
	<body>
	
		<input type="hidden" value="${statue}" id="finstatue"/>
		<script type="text/javascript">
		//通过比对状态，给tab页签加载样式
		$(function () {
		var statue=$("#finstatue").val();
            $('.proicon').each(function (index, obj) {
               if(index+1<statue){            	      	   
            	   $(this).addClass('statusTwo');  
            	   
               }else if(statue==index+1){
            	   $(this).addClass('statusThree');
            	 
               }else if(index+1>statue){
            	   $(this).addClass('statusOne');
               }
            });
        });
		
		
		</script>
		<div class="Bread-nav">
			<div class="w1200"><img class="mr10" src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />融资合同签署<span class="mr10 ml10">-</span>详情展示<span class="mr10 ml10"></span></div>
		</div>
		<input type="hidden" value="${statue}" id="finstatue"/>
		<div class="w1200">
			<ul class="clearfix iconul">
				<li class="iconlist" id="one" url="/IntegratedQueryController/projectDetails.htm?id=${id}&childrenId=${childrenId}"><div class="proicon bg1" ></div>项目详情</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="two" url="/IntegratedQueryController/preliminarytrialPlatform?id=${id}&audittype=1"> <div class="proicon bg2"></div>平台初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="three" url="/IntegratedQueryController/capitalTrial?id=${id}&childrenId=${childrenId}"><div class="proicon bg3 "></div>资方初审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="four" url="/IntegratedQueryController/chooseIntentionalCapital.htm?id=${id}&childrenId=${childrenId}"><div class="proicon bg4 "></div>选择意向资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="five" url="/IntegratedQueryController/capitalTrialLast?id=${id}&childrenId=${childrenId}"><div class="proicon bg5"></div>资方终审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="six" url="/IntegratedQueryController/cooperativeCapital?id=${id}&childrenId=${childrenId}"><div class="proicon bg6 "></div>合作资方</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist" id="seven" url="/IntegratedQueryController/platformreview?id=${id}&childrenId=${childrenId}"><div class="proicon bg7"></div>平台复审</li>
				<li class="iconlist linelist"><img src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/arr_icon.png" /></li>
				<li class="iconlist pro_li_cur" id='contract' url="" clickTrue="clickTrue"><div class="proicon bg8 statusThree"></div>签署主合同</li>
			</ul>	
			
		</div>
			<div id='contractsign'>
		<div class="pd20 mt40">
		<div class="w1200">
			<div class="process process1">
				${contractContnent }
			</div>
			
		</div>
		
		<div class="w1200">
		<div class="ground-form mb20">
				<!-- <div class="form-grou">
					<label class="label-long2">上传合同附件：</label>
				</div> -->
				<p class="protitleWhite">
				<span></span>上传合同附件
			</p>
			</div>
			<div class="ground-form mb20">
				<div class="form-grou">
					<label class="label-long2">合同模板下载：</label><a id="downcontract" href="/contractQuotaV4Controller/exportWord?id=${childrenId }">保理融资主合同</a>
				</div>
			</div>
		<!-- 	<td>合同模板下载</td><td><a class="" href="/contractQuotaV4Controller/exportWord?id=1">保理融资主合同</a></td> -->
		<div style="width:175px;height:200px;text-align: center;">
			<img id="upfile" class="uploadimg" width="175px" height="175px"
						src="${app.staticResourceUrl}/ybl4.0/resources/images/pro/dczc_add_img.png" />
						<div id="contractname" style="width:175px;text-align: center;word-break: break-all;word-wrap: break-word;" ></div>
		</div>
			
						</div>
						</div>
			<iframe id="common_iframe" name="common_iframe" style="display: none;"></iframe>
		<form style="display: none;" id="common_upload_form"
			enctype="multipart/form-data" method="post" target="common_iframe">
			<input id="common_upload_btn" type="file" name="file"
				style="display: none;" />
		</form>
		<div class="btn2 mb80 mt20 clearfix">
		<a id="submit" href="javascript:;" class="btn-add mt30">签署</a>
		<a id="cancel" href="javascript:;" style="background:#DDDDDD;" class="btn-add mt30">取消</a>
		</div>
		<div id="upfile_div"></div>
		</div>
	
		
		<div class="w1200" id="other" style="display:none">
			<iframe id="iframe1" onload="resizeIndexIFrame(this)" width="100%" height="1000px" src=""></iframe>
			
		</div>
		
		<input type="hidden"  id="jumpurl" value="${url}">
		
		<div class="mb80"></div>
		
		
	</body>
	<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl4.0/resources/js/factor/accounCenter/contractSign.js"></script> 
	
	<script type="text/javascript">
	
	$(".iconlist").click(function(){
		var clickTrue=$(this).attr("clickTrue");
		if(clickTrue=="clickTrue"){
			$('.iconlist').removeClass('pro_li_cur');
			$(this).addClass('pro_li_cur');
		}
		var div1 = $("#other");
	    var div = $("#contractsign");
	    div1.show();
	        div.hide();
	   
	});
	$("#contract").click(function(){
		var div1 = $("#other");
	    var div = $("#contractsign");
	    div1.hide();
	    div.show();
	   
	});
	$("#cancel").click(function(){
		window.location.href="/contractQuotaV4Controller/contractQuery/list.htm?type=1";
	});
	$("#submit").click(function(){
		var data = new Object;
		if($("#datas").find("input,textarea").length >=1){
			$("#datas").find("input,textarea").each(function(){
				data[""+$(this).attr("name")] = $(this).val();
			});
		}
		if($("#upfile_div").find("input").length >=1){
			$("#upfile_div").find("input").each(function(){
				data[""+$(this).attr("name")] = $(this).val();
			});
		}
		/* if(/[%]/.test(data.oldName)){
			alert("文件名不能含特殊字符");
			return;
		} */
		$.ajax({
			url : '/contractQuotaV4Controller/contractsign?appid=${childrenId}',
			type : 'POST', //GET
			async : true, //或false,是否异步
			data : data,
			timeout : 5000, //超时时间
			dataType : 'json',
			success : function(data) {
				if(data.responseType == "SUCCESS"){
					alert(data.info,function(){
	        			location.href='/contractQuotaV4Controller/contractQuery/list.htm?type=1';
	        		
	        		});
				}else{
					
				alert(data.info);
				}
			},
			 error:function(xhr,textStatus){
				 alert("网络不佳,稍后重试");
		        },
		});
	});
	
	//表单提交
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
</html>