<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><spring:message code="sys.v2.client.factor.index" /></title>
<link href="/ybl/resources/v2/css/vip_page_v2.css" rel="stylesheet" type="text/css" />
<link href="/ybl/resources/plugins/messagebox/messagebox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/ybl/resources/js/jquery-1.8.0.min.js"></script>
<script src="/ybl/resources/plugins/messagebox/messagebox.js" type="text/javascript" ></script>
<script type="text/javascript">
function quotaUpdateSave(){
	var earlyWarningAmount = $("#earlyWarningAmount").val();
	var contractIds = parent.$("#contractIds").val();
	if(earlyWarningAmount == "") {
		alert('<spring:message code="sys.v2.client.contract.warning.amount.empty" />');
		return;
	}
	if(!$.isNumeric(earlyWarningAmount)){
		alert('<spring:message code="sys.v2.client.contract.quota.warning" />');
		return;
	}
	$.ajax({
        url:'/contract/contractQuotaEditSave',
        type:'POST',
        data: {earlyWarningAmount : earlyWarningAmount, contractIds : contractIds}, 
        dataType:'text',
        success:function(data,textStatus,jqXHR){
        	if(data == "S"){
        		alert('<spring:message code="sys.v2.client.operationSuccess" />',function(){
        			parent.$(".v2_msgbox_close").mousedown();
        			parent.location.reload();
        		});
        	} else {
        		alert('<spring:message code="sys.v2.client.contract.add.error" />');
        	}
        },
        error:function(xhr,textStatus){
            console.log('错误');
        },
        complete:function(){
            console.log('结束');
        }
    })
}

</script>
</head>
<body class="v2_no_minwidth bg_w">
	<div class="v2_window v2_w1">
		<div class="v2_window_con">
			<ul>
				<li>
					<div class="v2_input_box">
						<span><spring:message code="sys.v2.client.contract.warning.amount" />：</span><input id="earlyWarningAmount" name="earlyWarningAmount" value="" type="text" class= "w200 v2_text fl"/><b><spring:message code="sys.v2.client.contract.yuan" /></b>
					</div>
				</li>
			</ul>
		</div>
		<div class="v2_but_list">
			<a class="bg_l" onclick="quotaUpdateSave();"><spring:message code="sys.v2.client.save" /></a>
		</div>
	</div>
</body>
</html>