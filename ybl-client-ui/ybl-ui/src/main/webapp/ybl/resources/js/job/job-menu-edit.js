
$(function(){
	/**
	 * 弹窗+底部按钮关闭事件  dialog.js 中dialog.close函数,参数dialogId为打开时传递的
	 */
	$("#add_close,#anqu_close").click(function(){
		dialog.close("edit_dept_dialog");
	});
	//菜单表单校验回显
	$("#menuForm").validate({
		submitHandler:function(form){  
       	 	$(form).ajaxSubmit({
        		success:function(resp){         		
        			if(resp.responseType == 'ERROR'){
        				alert($.i18n.prop("sys.admin.save.error"));/* 服务器繁忙请稍候重试 */
        			}else{
        				alert($.i18n.prop("sys.admin.save.success"));/* 数据保存/更新成功 */            
        			}         		
        		},
        		error:function(){
        			alert($.i18n.prop("sys.admin.save.error"));/* 服务器繁忙请稍候重试 */
        		}
        	});
   	 	}    
	});
	//保存按钮事件
	$("#saveRoleBtn").click(function(){
		 var formdata=$('#roleMenuForm').serialize();//序列化表单
		 var liLength = $("#selTree:has(li)").length
		 if(liLength == 0){
			 alert("没有菜单信息，无法保存");
			 return;
		 }
		 console.log(dtree);
//		 if(!treeNode){
//			 alert("没有菜单信息，无法保存");
//			 return;
//		 }
			$.ajax({
				url:'/roleController/accreditRole',
				dataType:'json',
				type:'post',
				data:formdata,
				success:function(value){
					if(value.responseType!="ERROR"){
						alert(value.info,function(){
							parent.$(".msgbox_close").mousedown();
							parent.location.href="/roleController/list.htm";
						})
					}else{
						alert(value.info)
					}
					
//				location.href="/roleController/list.htm";
				}
			}); 
	});
	//返回列表按钮
	$("#returnRoleListBtn").click(function(){
		parent.$(".msgbox_close").mousedown();
	});
	/**
	 * 菜单树控件
	 */
	function DeptTree(domid){
		var treeObj = null;
		var roleid = document.getElementById("roleid").value;
		//定义ztree配置
		var setting = {
				async: {
					enable: true,
					url: getAsyncAjaxUrl,	//ajax请求url
					otherParam: {"roleId":roleid},
					dataFilter:asyncDataFilter//数据过滤函数					
				},
				check: {
					enable: true,
					chkStyle: "checkbox",
					chkboxType: { "Y": "s", "N": "s" }
				},
				data: {
					key: {
						name:"name_",  
						id:"id_",
					},
					simpleData: {
						enable:true,						
					}
				},
				view: {
					dblClickExpand: false,
					showLine: true,
					selectedMulti: false
				},
				callback: {
					onAsyncSuccess:onAsyncSuccess,
					onClick:OnClick,
					onCheck:onCheck
				}
			};
		//获取ajax的url,并设置参数
		function getAsyncAjaxUrl(treeId, treeNode){
			var parentId = treeNode&&treeNode.id_;
			if(!parentId){
				parentId = 0;
			}
			return "/menuController/meunTree1?parentId="+parentId;		
		}
		//过滤数据
		function asyncDataFilter(treeId, treeNode, data){
			if(!data||data.length==0){
				return;
			}
			var idListStr="";
			for(var i=0;i<data.length;i++){
				data[i].isParent = true;
				if(data[i].parentId==0){
					data[i].open = true;
				}
				if(data[i].attribute1_==1){
					data[i].checked=true;
					idListStr+= (i == (data.length-1))?data[i].id_:data[i].id_+",";
				}
			}
			document.getElementById("meunlist").value=idListStr;
			return data;
		}
		
		function onAsyncSuccess(event, treeId, treeNode, data) {
			if (!data || data.length == 0||data=='[]') {
				treeNode.isParent = false;
				treeObj.updateNode(treeNode);
				return;
			}
		}
		function onCheck(event,treeId,treeNode){
			var zTreeO =  $.fn.zTree.getZTreeObj("selTree");
			 nodes=treeObj.getCheckedNodes(true);
			   var idListStr = "";  
			   for (var i = 0; i < nodes.length; i++) {  
				 idListStr+= (i == (nodes.length-1))?nodes[i].id_:nodes[i].id_+",";
			   };  
			   
			   document.getElementById("meunlist").value=idListStr;
		}
		/**
		 * 左树点击事件,ajax加载数据到右侧菜单
		 */
		function OnClick(event, treeId, treeNode){
			
		}
		treeObj = $.fn.zTree.init($("#"+domid), setting, null);
		
	}
	
	/**
	 * 初始化部门树
	 */
	var dtree = new DeptTree("selTree");

	function eqChildNode(id,treeNode){
		console.log(treeNode);
		if(id==treeNode.parentId){
			return true;
		}else{
			var _dtree = $.fn.zTree.getZTreeObj("selTree");
			var node = _dtree.getNodeByParam("id",treeNode.parent_id);
			if(!node){
				return false;
			}else if(node&&node.level==0){
				return false;
			}else{
				return eqChildNode(id,node);
			}
		}
	}
	//根据id查询单个部门信息
	function ajaxLoadDeptById(id,callback){
		$.ajax({
			url:"/menuController/getMenu?id="+id,
			dataType:"json",
			success:function(data){
				callback(data);
			}
		});
	}
	
});

