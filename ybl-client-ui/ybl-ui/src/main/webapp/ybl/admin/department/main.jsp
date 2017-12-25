<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>部门管理</title>
 	<jsp:include page="/ybl/admin/common/link.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.css" />
   	<!--  -->
   	<link href="${app.staticResourceUrl}/ybl/resources/css/page.css" rel="stylesheet" type="text/css" />
   	<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
    <!-- 表单验证 -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
	<!-- 国际化js -->	
	<script language='javascript' src='${app.staticResourceUrl}/ybl/resources/js/i18n/i18n.js'></script>	
	<!-- 部门js -->
	<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/js/department/fw-department.js"></script>
</head>
<body>
<!--  head -->
<!-- content begin -->
<!--公告-->
<div class="cont">	
	<!--lefttree-->
	<ul id="treeDemo" class="ztree" style="height: 450px;position: absolute;    top: 70px;left: 80px;">
    </ul>
	<div class="left_box">
    	<div class="tree">
        <div class="xtree_tittle">
        	<span class="tree_zl_ico tree_title_span"></span>
        	<span class="tittle bottom_line" id="txt_enterprise">深圳市长亮科技有限公司</span>
        	<div class="clear"></div>
            </div>
        </div>
    </div>
    <!--right-->
    <div class="right_box">
    	<h1><spring:message code="sys.admin.dept.message"/></h1><!-- 部门信息 -->
        <div class="right_con">
        	<input type="hidden" id="deptId" />
        	<div class="bmxx" id="viewDept">
        		<ul class="bmxxul">
                	<li class="bm_ico1 bmxxli"><span class="bmxxspan"><spring:message code="sys.admin.dept.no"/>：</span><label id="labelDeptCode"></label></li><!-- 部门编码 -->
                    <li class="bm_ico2 bmxxli"><span class="bmxxspan"><spring:message code="sys.admin.dept.name"/>：</span><label id="labelDeptName"></label></li><!-- 部门名称 -->
                    <li class="bm_ico3 bmxxli"><span class="bmxxspan"><spring:message code="sys.admin.dept.super.no"/>：</span><label id="labelParentId"></label></li><!-- 上级部门 -->
                </ul>
            </div>
            <div class="bm_but">
            	<ul>
                	<li>
                		 <sun:button id="btnAddDept" tag='a' clazz="bm_butico1" i18nValue="sys.admin.add" /><!-- 添加 -->
                	</li>
                    <li>
                     	<sun:button id="btnModifyDept" tag='a' clazz="bm_butico2" i18nValue="sys.admin.edit" /><!-- 修改 -->
                    </li>
                    <li>
                    	<sun:button id="btnDeleteDept" tag='a' clazz="bm_butico3" i18nValue="sys.admin.delete" /><!-- 删除 -->
                    </li>                 
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- content end -->

<!-- footer -->

</body>
</html>