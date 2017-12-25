$(function(){
	//待办处理
	$(".handle_btn").click(function(){
		var id = $(this).attr("uid");
		var type = $(this).attr("utype");
		var orderNo = $(this).attr("orderNo");
		if(type == 5){//待还款
			 var form = $("<form method='post'></form>");
		        form.attr({"action":"/rePayMentController/RepaymentInfo.htm"});
		            var input = $("<input type='hidden'>");
		            input.attr({"name":"id"});
		            input.val(id);
		            form.append(input);
		            var input1 = $("<input type='hidden'>");
		            input1.attr({"name":"returnPage"});
		            input1.val("enterpriseIndex");
		            form.append(input1);
		           var input2 = $("<input type='hidden'>");
		            input2.attr({"name":"order_no"});
		            input2.val(orderNo);
		            form.append(input2);
		        $(document.body).append(form);
		        form.submit();
			/*$.ajax({url : "/enterpriseIndexV4Controller/queryRepaymentInfo",
				dataType : "json",
				type : "post",
				data : {repaymentPlanId:id,orderNo:orderNo},
				success : function(data) {
						   if(data.responseType != 'ERROR'){
							   var loanApply = data.object;
							   var loanApplyId = loanApply.id_;
							   var form = $("<form method='post'></form>");
						        form.attr({"action":"/rePayMentController/view.htm"});
						            var input = $("<input type='hidden'>");
						            input.attr({"name":"id"});
						            input.val(loanApplyId);
						            form.append(input);
						            var input1 = $("<input type='hidden'>");
						            input1.attr({"name":"iframeChange"});
						            input1.val("iframeChange");
						            form.append(input1);
						           var input2 = $("<input type='hidden'>");
						            input2.attr({"name":"orderNo"});
						            input2.val(orderNo);
						            form.append(input2);
						            var input3 = $("<input type='hidden'>");
						            input3.attr({"name":"repayMentPlanId"});
						            input3.val(id);
						            form.append(input3);
						        $(document.body).append(form);
						        form.submit();
							}
						},
						error : function() {
							//alert("数据加载失败");
						}
					});*/
			
		}else{//确权
			var form = $("<form method='post'></form>");
	        form.attr({"action":"/enterpriseAssetOwnership/assetTransfer.htm"});
	            var input = $("<input type='hidden'>");
	            input.attr({"name":"loanApplyId"});
	            input.val(id);
	            form.append(input);
	            var input1 = $("<input type='hidden'>");
	            input1.attr({"name":"assetsType"});
	            input1.val(type);
	            form.append(input1);
	            var input2 = $("<input type='hidden'>");
	            input2.attr({"name":"returnPage"});
	            input2.val("enterpriseIndex");
	            form.append(input2);
	        $(document.body).append(form);
	        form.submit();
		}
	});
	
	//待办更多点击事件
	$("#more_todo_btn").click(function(){
		window.location.href = "/enterpriseIndexV4Controller/moreTodo.htm";
	});
	
	//预警提醒更多点击事件
	$("#more_warning_reminder").click(function(){
		window.location.href = "/enterpriseIndexV4Controller/moreWarningreminder.htm";
	});
	//返回按钮
	$("#go_to_back").click(function(){
		window.location.href = "/enterpriseIndexV4Controller/enterpriseIndex.htm";
	});
});