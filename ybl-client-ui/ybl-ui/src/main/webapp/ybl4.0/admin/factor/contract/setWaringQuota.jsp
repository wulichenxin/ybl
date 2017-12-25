<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
	 <%@include file="/ybl4.0/admin/common/link.jsp" %> 
	</head>

	<body>
	<div class="ajcont">

				
				<p class="mt30">融资方名称 : ${contractQuota.enterpriseName }</p>
				<p class="symoney mt30"><span>剩余可用余额 : <fmt:formatNumber type="number" pattern="#,##0.##" value="${contractQuota.allAmount }" />元</span><span class="fr">当前预警伐值 : <fmt:formatNumber type="number" pattern="#,##0.##" value="${contractQuota.earlyWarningAmount }" />元</span></p>
				<input class="content-form2" id="contractId"  value=${contractQuota.id } type="hidden" />
				<div class="ground-form mb30 mt30">
					<div class="form-grou"><span style="color:red">*</span>调整预警伐值 : <input class="content-form2" id="earlyWarningAmount" name="earlyWarningAmount" value="" type="text"/><span class="timeimg">元</span></div>
				</div>
				<div class="small-btn2">
					<a href="javascript:;" class="btn-add"  onclick="quotaUpdateSave();" style="width:130px;margin-right: 70px" >保存</a>
					<a href="javascript:;" class="btn-add close-out" style="width:130px;margin-left: 70px">取消</a>
				</div>
				
		
				</div>
		<script type="text/javascript">
		function quotaUpdateSave(){
			
			var earlyWarningAmount = $("#earlyWarningAmount").val();
			if(earlyWarningAmount == "") {
				alert('预警额度不能为空');
				return;
			}
			if(!$.isNumeric(earlyWarningAmount)){
				alert('预警额度必须为数字，请输入有效的预警额度');
				return;
			}
			 var reg = /^([1-9]\d*|0)(\.\d{1,2})?$/;
			 if(!reg.test(earlyWarningAmount)){
			 		alert("请输入有效的预警额度,预警额度金额只能小点后两位");
			 		return
			 } 
			var contractId = $("#contractId").val();
			$.ajax({
		        url:'/contractQuotaV4Controller/warningAmountEdit',
		        type:'POST',
		        data: {earlyWarningAmount : earlyWarningAmount , id : contractId}, 
		        dataType:'json',
		        success:function(data,textStatus,jqXHR){
		        	if(data.responseTypeCode == "success"){
		        		alert(data.info,function(){

		        			parent.location.href='/contractQuotaV4Controller/contractQuotaPage?path=1';
		        		
		        		});
		        	} else {
		        		alert(data.info);
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

		$('.close-out').click(function(){
			dialog.close();
		})
		</script>
	</body>

</html>