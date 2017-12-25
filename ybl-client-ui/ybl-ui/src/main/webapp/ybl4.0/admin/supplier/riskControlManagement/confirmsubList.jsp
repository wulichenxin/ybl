<%@page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="lzq" uri="/WEB-INF/META-INF/datetag.tld"%>
<html>

<head>
<title>确定资金方</title>
</head>
<jsp:include page="/ybl4.0/admin/common/top.jsp?step=7" />
<body>
	<div class="Bread-nav">
		<div class="w1200">
			<img class="mr10"
				src="${app.staticResourceUrl}/ybl4.0/resources/images/rzf_bre_icon.png" />业务办理<span
				class="mr10 ml10">-</span>确定资金方
		</div>
	</div>

<div class="w1200 mt40">
	<div id="select">
		<p class="protitle">
			<span>确定资方</span>
		</p>
		<div class="tabD">
			<input id="financing_id" type="hidden" value="${financing_id}">
			<table style="font-size: 14px">
				<thead>
					<tr>
						<th>序号</th>
						<th>融资订单号</th>
						<th>资方名称</th>
						<th>意向投资金额(元)</th>
						<th>意向融资期限(天)</th>
						<th>意向投资利率(%)</th>
						<th>竞标时间</th>
						<th>终审意见表</th>
						<th>备注说明</th>
						<th>是否合作</th>
					</tr>
				</thead>
				<tbody id="subFincancingList">
				</tbody>

				<c:forEach items="${page.records}" var="sub" varStatus="xh">
					<tr>
						<td class="toggletr">${xh.count}</td>
						<td class="width"><a param="${sub.financing_apply_id} ${sub.id_}" href="#" class="order-a appApi">${sub.order_no}</a></td>
						<td>${sub.funder_name}</td>
						<td><fmt:formatNumber value="${sub.financing_amount}"
								pattern="##0.##" maxFractionDigits="2" /></td>
						<td>${sub.financing_term}</td>
						<td>${sub.financing_rate}</td>
						<td><lzq:date value="${sub.audit_date}" parttern="yyyy-MM-dd" /></td>
						<td><c:if test="${(not empty sub.attachment_id) && sub.attachment_id ne 0}">
						<a href="/fileDownloadController/downloadftp?id=${sub.attachment_id}"
							class="order-a">${sub.old_name}</a></c:if></td>
						<td>${sub.remark}</td>
						<td><input name='confirmid' type='radio' value='${sub.id_}-${sub.funder_name}'/></td>
					</tr>
				</c:forEach>
			</table>

		</div>




		<div class="btn2 mt40 clearfix">
			<a id="submit" href="javascript:;" class="btn-add btn-center">提交</a>
			<a id="cancel" href="javascript:;" class="btn-add btn-center">取消</a>
		</div>
	</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {
		$("#submit").click(function(){
			var financing_status = 7
			var ids=new Array();
			var financing_apply_id = $("#financing_id").val();
			$("input:radio:checked").each(function(index,element){
				ids[index] = $(element).val()
			});
			
			if(ids.length <= 0){
				alert("必须确定一个资方");
				return false;
			}
			
			if(ids.length > 1){
				alert("资方确认不可多选");
				return false;
			}
			b = ids.join(",");
			$.ajax({
				url:'/chooseFundsController/updateSubFundsList',
			    type:'POST', //GET
			    async:true,    //或false,是否异步
			    data:{
			        ids:b,
			        financing_apply_id:financing_apply_id,
			        financing_status:financing_status,
			        selection_status:2
			    },
			    timeout:5000,    //超时时间
			    dataType:'json',
			    success:function(data){
		    		alert(data.info,function(){
		    			if(data.responseType == "SUCCESS"){
		    				window.location.href="/chooseFundsController/confirmFundsList";
		    			}else{
		    				return false;
		    			}
		    		});	
			    	
			    }
				
			});
		});
		
		$(".appApi").click(function() {
			var paramString = $(this).attr("param");
			var formDateArry = paramString.split(/\s+|,|-/g);
			$.createFormAndSubmit({
				formDate : {
					id : formDateArry[0],
					childrenId : formDateArry[1],
					statue: 6,
					url: "/chooseFundsController/confirmFundsList"
				},
				formAttrbute : {
					action : "/financingApplyCommonApi/view.htm",
					method : "POST"
				}
			});

		});
		
		$("#cancel").click(function(){
			window.history.back(-1); 
		});
	});
	//关闭弹出窗
	window.close = function(item) {
		var clo = window.parent.document.getElementsByClassName(item);
		$(clo).click(function() {
			dialog.close();
		});
	}
</script>

</html>