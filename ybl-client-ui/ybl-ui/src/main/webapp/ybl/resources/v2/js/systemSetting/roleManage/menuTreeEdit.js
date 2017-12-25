
$(function(){
	/**
	 * 弹窗+底部按钮关闭事件  dialog.js 中dialog.close函数,参数dialogId为打开时传递的
	 */
	$("#anqu_close").click(function(){
		parent.$(".v2_msgbox_close").mousedown();
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
		/* if(liLength == 0){
			 alert("没有菜单信息，无法保存");
			 return;
		 }*/
//		 if(!treeNode){
//			 alert("没有菜单信息，无法保存");
//			 return;
//		 }
			$.ajax({
				url:'/v2RoleController/accreditRole',
				dataType:'json',
				type:'post',
				data:formdata,
				success:function(value){
					if(value.responseType!="ERROR"){
						alert(value.info,function(){
							parent.$(".msgbox_close").mousedown();
							parent.location.href="/v2RoleController/list.htm";
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
		var roleId = document.getElementById("roleid").value;
		//定义ztree配置
		var setting = {
				check: {
					enable: true,
					chkStyle: "checkbox",
					chkboxType: { "Y": "ps", "N": "ps" }
				},
				data: {
					key: {
						name:"name_", 
						checked: "checked",
						children: "children",
						id:"id_",
					},
					simpleData: {
						enable: true,
						idKey: "id_",
						pIdKey: "parent_id",
						rootPId: 0						
					}
				},
				view: {
					dblClickExpand: false,
					showLine: true,
					selectedMulti: false
				},
				callback: {
					onCheck:onCheck
				}
			};
		
		function onCheck(event,treeId,treeNode){
			initCheckedData();
		}
		
		function initCheckedData() {
			nodes=treeObj.getCheckedNodes(true);
			var idListStr = "";  
			for (var i = 0; i < nodes.length; i++) {  
				idListStr+= (i == (nodes.length-1))?nodes[i].id_:nodes[i].id_+",";
			};  
			document.getElementById("meunlist").value=idListStr;
		}
		
		$.ajax({
            url:'/v2MenuController/meunTree1',
            type:'POST', //GET
            data:{
            	"parentId" : 0 , "roleId":roleId
            },
            dataType:'json', 
            success:function(data,textStatus,jqXHR){
                treeObj = $.fn.zTree.init($("#"+domid), setting, data);
                initCheckedData();
            },
            error:function(xhr,textStatus){
            },
            complete:function(){
            }
        });
		
	}
	
	/**
	 * 初始化部门树
	 */
	var dtree = new DeptTree("selTree");

	function eqChildNode(id,treeNode){
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
	
});

