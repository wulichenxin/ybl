$(function(){
	$("#anqu_close").click(function(){
		parent.$(".v2_msgbox_close").mousedown();
	});
	//保存按钮事件
	$("#saveMenuBtn").click(function(){
		if(!$("#menuForm").validationEngine('validate')){
			return ;
		}
		 var formdata=$('#menuForm').serialize();//序列化表单
		 
		 $("#saveMenuBtn").hide();
		 $("#saveMenuingBtn").show();
			$.ajax({
				url:'/v2MenuController/addOrUpdateMenu',
				dataType:'json',
				type:'post',
				data:formdata,
				success:function(value){
					if(value.responseTypeCode == "success"){
						alert(value.info,function(){
							parent.$(".msgbox_close").mousedown();
							parent.window.location.reload();
						})
					}else{
						alert(value.info);
						$("#saveMenuBtn").show();
						$("#saveMenuingBtn").hide();
					}					
				},
				error:function(){
					$("#saveMenuBtn").show();
					$("#saveMenuingBtn").hide();
					alert($.i18n.prop("sys.v2.client.system.is.busy.try.later"));/*"系统繁忙，请联系管理员！"*/
				}
			}); 
	});
	//取消
	$("#anqu_close").click(function(){
		parent.$(".msgbox_close").mousedown();
	});
	
	/**
	 * 菜单树控件
	 */
	function DeptTree(domid,clickCallback){
		var treeObj = null;
		//定义ztree配置
		var setting = {
				async: {
					enable: true,
					url: getAsyncAjaxUrl,	//ajax请求url
					dataFilter:asyncDataFilter//数据过滤函数					
				},
				check: {
					enable: false
				},
				data: {
					key: {
						name: "name_",
						id:"id_"
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
					onClick:leftTreeOnClick
				}
			};
		//获取ajax的url,并设置参数
		function getAsyncAjaxUrl(treeId, treeNode){	
			var parentId = treeNode&&treeNode.id_;
			if(!parentId){
				parentId = 0;
			}
			return "/v2MenuController/getMenuList?parentId="+parentId;		
		}
		//过滤数据
		function asyncDataFilter(treeId, treeNode, data){
			if(!data||data.length==0){
				return;
			}
			for(var i=0;i<data.length;i++){
				data[i].isParent = true;
				if(data[i].parentId==0){
					data[i].open = true;
				}
			}
			return data;
		}
		
		function onAsyncSuccess(event, treeId, treeNode, data) {
			/*if (!data || data.length == 0||data=='[]') {
				treeNode.isParent = false;
				treeObj.updateNode(treeNode);
				return;
			}*/
		}
		
		/**
		 * 左树点击事件,ajax加载数据到右侧菜单
		 */
		function leftTreeOnClick(event, treeId, treeNode, clickFlag){
			if(clickCallback){
				clickCallback(event,treeId,treeNode,clickFlag);
				return;
			}
		}
		var list = [];
		//根据节点一层一层往上找,用于快速定位树节点 返回格式 从根节点开始返回 1,101,1001
		this.expendNode = function(nodeId){
			$.ajax({
				url:"/departmentController/queryUpDept?id="+nodeId,
				dataType:"json",
				success:function(data){
					var len = data&&data.length;
					if(len){						
						var _expindex = len-2;
						var _expInterval = setInterval(function(){
							var nid = data[_expindex];
							var treeNode = treeObj.getNodeByParam("id",nid);
							if(treeNode){
								treeObj.expandNode(treeNode,true)
								_expindex--
								if(_expindex<0){
									clearInterval(_expInterval);
									treeObj.selectNode(treeNode,true);
								}
							}
						},300);
						
					}
				}
			});
		}
		
		treeObj = $.fn.zTree.init($("#"+domid), setting, null);
		this.tree = treeObj;
	}
	
	/**
	 * 初始化部门树
	 */
	var dtree = new DeptTree("selTree",deptTreeClick);
	var departId = $("#parentDepartmentId").val();
	if(departId){
		ajaxLoadDeptById(departId,function(data){
			if(data){
				$("#parentDepartmentName").val(data.name_);
			}
		});
		dtree.expendNode(departId);
	}
	/**
	 * 部门树单击事件,选中数据回填到input中
	 */
	function deptTreeClick(event,treeId,treeNode,clickFlag){
		var deptId = $("#departmentId").val();
		if(deptId){
			if(treeNode.id_==deptId){
				alert($.i18n.prop("no.choose.own"));//不能选择自己
				return;
			}
			if(eqChildNode(deptId,treeNode)){
				alert($.i18n.prop("no.choose.own.child"));//不能选择自己的子节点
				return;
			}
		}
		$("#parentId").val(treeNode.id_);
		$("#parentDepartmentName").val(treeNode.name_);
		$("#selTree").hide();
	}

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

	/**
	 * 部门树弹窗事件
	 */
	$("#parentDepartmentName").click(function(){
		if($("#selTree").css("display")=="none"){
			$("#selTree").show().css("top","178px").css("left","272px").css("width","300px");
		}else{
			$("#selTree").hide();
		}
	});
	//根据id查询单个部门信息
	function ajaxLoadDeptById(id,callback){
		$.ajax({
			url:"/v2MenuController/getMenu?id="+id,
			dataType:"json",
			success:function(data){
				callback(data);
			}
		});
	}
	
});

