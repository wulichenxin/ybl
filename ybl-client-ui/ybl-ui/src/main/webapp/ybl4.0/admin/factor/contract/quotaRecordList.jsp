<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>长亮国信</title>
		<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
		<script type="text/javascript">
	function quotaUpdateSave() {
		 
		if(!$("#creditForm").validationEngine('validate')){
			return;
		}
		var str = $("#quota").val();
		 var reg = /^(\+|-)?([1-9]\d*|0)(\.\d{1,2})?$/;
		 if(!reg.test(str)){
		 		alert("请输入有效金额,授信额度金额只能小点后两位")
		 		return;
		 }
		var effictiveTime = $("#effectiveTime").val() + " 00:00:00";
		$("#effectiveTime").val(effictiveTime);
		$.ajax({
            type:'POST',
            dataType:'json',
            url:'/contractQuotaV4Controller/insertQuotaRecord',
            data: $("#creditForm").serialize(), 
            success:function(data){
            	if(data.responseTypeCode=='success'){
            		alert(data.info,function(){
            			location.href='/contractQuotaV4Controller/contractQuotaPage';
            		});
            	} else {
            		alert(data.info)
            	}
            },
       
        })
	}
</script>
	</head>

	<body>
		
		
		<div class="w1200">
		<p class="protitle"><span style="margin-left: 0;">当前额度信息</span></p>
			<div class="quotaTitle">
				<span>融资方名称：${contractQuota.enterpriseName }</span>
				<p class="symoney mt20"><span style="width: 360px;">初始授信额度: <fmt:formatNumber type="number" pattern="#,##0.##" value="${contractQuota.creditAmount }" />元</span> <span style="width: 360px;">当前最新授信额度：<fmt:formatNumber type="number" pattern="#,##0.##" value="${contractQuota.newCreditAmount }" />元</span> <span style="width: 360px;">剩余可用余额：<fmt:formatNumber type="number" pattern="#,##0.##" value="${contractQuota.allAmount }" />元</span></p>
				<a href="/contractQuotaV4Controller/contractQuotaPage" class="goback"><img src="/ybl4.0/resources/images/my/zjf_back_icon.png" /></a>
			</div>
			
			
			<div class="operating mb30">
				<c:if test="${status == '1' }">
				<p class="protitle"><span style="margin-left: 0;">调整额度</span></p>
				<form id="creditForm" action="">
				<input type="hidden" name="contractId" value="${contractQuota.id }">
				<div class="pd20">
					<div class="ground-form mb20">
						<div class="form-grou mr40"><label style="width: 120px;"><span style="color:red">*</span>增加授信额度：</label><input class="content-form2 w300 v2_text validate[required,custom[number]]" name = "quota" id="quota" type="text"/><span class="timeimg">元</span></div>
						<div class="form-grou"><label><span style="color:red">*</span>生效日期：</label><input id="effectiveTime" class="content-form2 w300 v2_text validate[required,custom[date]]" name = "effectiveTime"/><img src="${app.staticResourceUrl}/ybl4.0/resources/images/cal_icon.png" class="timeimg" /></div>
					</div>
					<div class="ground-form mb20">
						<div class="form-grou">
							<label style="width: 120px;">备注：</label><textarea class="protext validate[required,maxSize[127]]"  name="remark"></textarea>
						</div>
					</div>
					<div class="ground-form mb20" style="text-align:center">
						<a href="javascript:;" class="btn-save" onclick="quotaUpdateSave();">保存</a>
					</div>
				</div>
				</form>
				</c:if>
				<p class="protitle"><span style="margin-left: 0;">历史调整记录</span></p>
				<div class="tabD mt30">
				<form action="/contractQuotaV4Controller/quotaRecordList.htm" id="pageForm" method="post">
				<input type="hidden" name="contractId" value="${contractQuota.id }">
				<input type="hidden" name="status" value="${status }">
					<table>
						<tr>
							<th>时间</th>
							<th>操作人</th>
							<th>增加金额(元)</th>
							<th>备注</th>
							<th>生效日期</th>
						</tr>
						<c:if test="${empty quotaRecordList}">
								<tr><td colspan="15">暂无数据</td></tr>
						</c:if>
						<c:forEach var="obj" items="${quotaRecordList}" varStatus="index" >
						<tr>
							<td><fmt:formatDate value="${obj.createdTime }" pattern="yyyy-MM-dd"/></td>
							<td>${obj.realName }</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.##" value="${obj.quota }" /></td>
							<td>${obj.remark }</td>
							<td> <fmt:formatDate value="${obj.effectiveTime }" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
						
					</table>
				</div>
					<jsp:include page="/ybl4.0/admin/common/page.jsp"></jsp:include>
					</form>
				
			</div>
			
		</div>
		<script>
			$('#effectiveTime').datetimepicker({
				yearOffset: 0,
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
				minDate: '1970-01-01', // yesterday is minimum date
				maxDate: '2099-12-31' // and tommorow is maximum date calendar
			});
		</script>
	</body>

</html>