$(function(){
	/**
	 * 弹窗+底部按钮关闭事件  dialog.js 中dialog.close函数,参数dialogId为打开时传递的
	 */
	$("#add_close,#anqu_close").click(function(){
		dialog.close("edit_dept_dialog");
	});
	/**
	 * 部门树控件
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
			return "/departmentController/queryListByParentId?parentId="+parentId;		
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
			if (!data || data.length == 0||data=='[]') {
				treeNode.isParent = false;
				treeObj.updateNode(treeNode);
				return;
			}
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
			url:"/departmentController/getOne?id="+id,
			dataType:"json",
			success:function(data){
				callback(data);
			}
		});
	}
	
	//校验多次点击
	var clickEnable = true;
	/**
	 * 保存按钮事件
	 */
	$("#saveDepartBtn").click(function(){
		if(!$("#dataForm").valid()){
			return;
		}
		var deptCode = $("#deptCode").val();
		var deptName = $("#deptName").val();
		var parentId = $("#parentId").val();
		var id = $("#departmentId").val();
		if(!deptCode){
			alert($.i18n.prop("depart.code.is.not.null"));//部门编码不能为空			
			return;
		}
		if(!deptName){
			alert($.i18n.prop("depart.name.is.not.null"));//部门名称不能为空			
			return;
		}
		if(!clickEnable){
			return;
		}
		$("#btn-save-department").hide();
		$("#btn-save-departmenting").show();
		clickEnable = false;
		$.ajax({
			url:"/departmentController/saveOrUpdate",
			type:"post",
			data:{
				id:id,
				code:deptCode,
				name:deptName,
				parentId:parentId
			},
			success:function(data){
				clickEnable = true;
				if(data.responseType!="ERROR"){//操作成功closewindow
					alert(data.info,function(){
						clickEnable = false;	//关闭了窗口禁止再次操作
						parent.$(".msgbox_close").mousedown();
						parent.location.href="/departmentController/depetManage";
					});
				}else{
					alert(data.info,function(){
						
//						parent.$(".msgbox_close").mousedown();
//						parent.location.href="/departmentController/depetManage";
					});
				}
				$("#btn-save-department").show();
				$("#btn-save-departmenting").hide();
			},
			error:function(a,b,c){
				clickEnable = true;
				alert("<spring:message code='sys.admin.save.error'/>");/* 服务器繁忙请稍候重试 */
				$("#btn-save-department").show();
				$("#btn-save-departmenting").hide();
			}
		});
	});
	
	//返回列表
	$("#returnDapartBtn").click(function(){
		location.href='/departmentController/depetManage';
	})
});

