$(function(){
	/**
	 * 事件监听
	 */
	function registerEventListener(){		
		//添加按钮事件
		$("#btnAddDept").click(function(){	
			$.msgbox({
				height:375,
				width:640,
				content:"/departmentController/edit.htm",
				type :'iframe',
				title: '新增部门'
			});
		});
		//编辑按钮事件
		$("#btnModifyDept").click(function(){			
			var departId = $("#deptId").val();
			if(!departId){
				alert($.i18n.prop("sys.client.please.select.depart.toedit"));//请先选择一个部门，再进行编辑。
				return;
			}
			$.msgbox({
				height:375,
				width:640,
				content:"/departmentController/edit.htm?id="+departId,
				type :'iframe',
				title: '编辑部门'
			});
		});
		//删除按钮事件
		$("#btnDeleteDept").click(function(){
			var deptId = $("#deptId").val();
			if(!deptId){
				alert($.i18n.prop("please.select.depart.todelete"));//请先选择一个部门，再进行删除。
				return;
			}
			var node = leftTree.tree.getSelectedNodes();
			var nodeId = node&&node[0]&&node[0].id_;
			if(nodeId){
				confirm($.i18n.prop("ybl.web.sure.to.delete"),function(){
					$.ajax({
						url:"/departmentController/deleteById?id="+nodeId,
						success:function(data){						
							if(data.responseType=="SUCCESS_DELETE"){
								alert(data.info,function(){
									window.location.href='/departmentController/depetManage';
								});
								/*alert(data.info,function(){
									leftTree = new DeptTree("treeDemo");
									leftTree.expendNode(node[0].parentId);
								});*/
							}else{
								alert(data.info);
							}
						},
						error:function(){
							alert($.i18n.prop("ybl.web.delete.error"));//删除失败
						}
					});	
				})
			}
		});
		//
		$("#parentName").click(function(){
			$("#selTree").show();
		});
	}	
	var leftTree = new DeptTree("treeDemo");
	registerEventListener();	
	//案例一下：http://www.runoob.com/jquery/jquery-plugin-validate.html
});

function DeptTree(domid,clickCallback){
	var treeObj = null;
	//定义ztree配置
	var setting = {
			async: {
				enable: true,//启用异步加载
				url:getAsyncAjaxUrl,//ajax请求url
				dataFilter:asyncDataFilter	//数据过滤函数
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
					enable:true
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
			if(data[i].parent_id==0){
				data[i].open = true;
			}else{
				data[i].open = false;
			}
		}
		return data;
	}
	
	function onAsyncSuccess(event, treeId, treeNode, data) {
		if (!data || data.length == 0||data=='[]') {
			if(!treeNode){
				return;
			}
			console.log(treeNode)
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
		var deptId = treeNode&&treeNode.id_;
		if(deptId){
			ajaxLoadDeptById(deptId,function(data){
				$("#labelDeptCode").text(data.code_);
				$("#labelDeptName").text(data.name_);								
				$("#parentId").val(data.parent_id);
				$("#parentName").val("");
				ajaxLoadDeptById(data.parent_id,function(parent){
					if(parent&&parent.name_){
						$("#labelParentId").text(parent.name_);
						$("#parentName").val(parent.name_);
					}else{
						$("#parentId").val("");
						$("#labelParentId").text("");
					}
				});				
				$("#deptId").val(data.id_);
				$("#viewDept").show();
			});
		}
	}
	var list = [];
	 //展开当前节点的父节点下的所有节点
	this.expendNode = function(nodeId){
		$.ajax({
			url:"/departmentController/queryUpDept?id="+nodeId,
			dataType:"json",
			success:function(data){
				console.log(data);
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
								leftTreeOnClick(null,domid,treeNode);
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

function deptTreeClick(event,treeId,treeNode,clickFlag){
	var deptId = $("#deptId").val();
	if(treeNode.id==deptId){
		alert($.i18n.prop("no.choose.own"));//不能选择自己
		return;
	}
	if(eqChildNode(deptId,treeNode)){
		alert($.i18n.prop("no.choose.own.child"));//不能选择自己的子节点
		return;
	}
	$("#parentId").val(treeNode.id);
	$("#parentName").val(treeNode.deptName);
	$("#selTree").hide();
}

function eqChildNode(id,treeNode){
	console.log("eqChildNode="+treeNode);
	if(id==treeNode.parentId){
		return true;
	}else{
		var _dtree = $.fn.zTree.getZTreeObj("selTree");
		var node = _dtree.getNodeByParam("id",treeNode.parentId);
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
 * 根据id获取部门信息
 * @param id
 * @param callback
 */
function ajaxLoadDeptById(id,callback){
	$.ajax({
		url:"/departmentController/getOne?id="+id,
		dataType:"json",
		success:function(data){
			callback(data);
		}
	});
}