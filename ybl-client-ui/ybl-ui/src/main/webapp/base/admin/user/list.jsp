<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000" />
<title>催收宝</title>
<meta name="Keywords" content="催收宝" />
<meta name="Description" content="催收宝" />
<meta name="Copyright" content="催收宝" />

<!-- 公共js css -->
<jsp:include page="/fw/admin/common/link.jsp" />
<link href="/fw/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/fw/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="/fw/resources/js/fw-user.js"></script>

</head>
<body>
<div class="cont">
<!-- 部门树 -->
<ul id="selTree" class="ztree deptTree" style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 10px;z-index:10;height: 220px;overflow: auto;"></ul>
<form action="/userController/list.htm" id="pageForm" method="post">
<!--公告-->
<!--公告完-->

	<!--搜索条件-->
	<div class="seach_box" id="submit_box" >
    	<div class="switcht_1" id="switch_query"><a></a></div>
    	<ul class="mb20" >
            <li class="mr25"><label>编号:</label><input name="userCode" type="text" /></li>
            <li class="mr25"><label>姓名:</label><input name="nick" type="text" /></li>
            <li class="mr25"><label>性别:</label>
            	<select name="gender" style="width: 162px;">
            		<option value="">全部</option>
            		<option value="MALE" >男</option>
            		<option value="FEMALE" >女</option>
            	</select>
            </li>
            <li class="mr25"><label>电话:</label><input name="tel" type="text"/></li>
            <li><div class="button_yellow"><a id="btn-query">查询</a></div></li>
            <li><div class="button_gary"><a id="btn-reset">重置</a></div></li>
        </ul>
        <ul class="more_xx" style="display:none;"> 
       <!--      <li class="mr25"><label>类型:</label><input type="text" class="mr45" /></li> -->
            <li class="mr25"><label>岗位:</label>
            	<select name="jobId" style="width: 162px;" class="fw_comp_select"  ajaxurl="/jobController/getSelectList" valueField="id" textField="jobName" ></select>
            </li>
            <li class="mr25"><label>部门:</label>
            	<input type="hidden" class="mr45" name="departmentId" id="departmentId" />
            	<input type="text" class="mr45" name="departmentName" style="cursor:pointer;" id="departmentName" />
            </li>
            
        </ul>
    </div>
    <!--搜索条件-->
    <!--table-->
    <div class="table_box">
    	<!--按钮top-->
        <div class="table_top">
            <div class="table_nav">
                <ul>
                    <li><a id="btn-delAll"><span class="but_ico1"></span></a></li>
                    <!--<li><a><span class="but_ico2"></span>催收管理</a></li>
                    <li><a><span class="but_ico3"></span>智能催收</a></li>
                    <li><a><span class="but_ico4"></span>坐席催收</a></li>-->
                </ul>
            </div>
            <div class="table_nav_r">
            	<ul>
                    <li><a id="btn_add_user" ><span class="but_add"></span>添加</a></li>
                </ul>
            </div>
        </div>
        <!--按钮top-->
        <div class="table_con">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
              <tr>
                <th width="50"><input type="checkbox" id="checkAll" /></th>
                <th width="100">序号</th>
                <th width="50">用户名</th>
                <th width="100"><span class="pxbox">编号<span class="px"></span></span></th>
                <th width="100">姓名</th>
                <th width="100">性别</th>
                <th width="120">办公电话</th>
                <th width="120">手机号码</th>
                <th width="100">岗位</th>
               <!--  <th width="100"><span class="pxbox">员工类型<span class="px2"></span></span></th> -->
                <th width="100">所属部门</th>
                <th width="100">状态</th>
                <th width="260">操作</th>
              </tr>
               
              <c:forEach items="${page.data}" var="entity" varStatus="status">
	              <tr >
	                <td><input name="checkbox" type="checkbox" value="${entity.id}" /></td>
	                <td>${entity.rowNo}</td>
	                <td>${entity.userName}</td>
	                <td>${entity.userCode}</td>
	                <td>${entity.nick}</td>
	                <td>
	                	<c:if test="${entity.gender=='MALE'}">男</c:if>
	                	<c:if test="${entity.gender=='FEMALE'}">女</c:if>
	                </td>
	                <td>${entity.tel}</td>
	                <td>${entity.mobile}</td>
	                <td>${entity.jobName}</td>
	              <%--   <td>${entity.userType}</td> --%>
	                <td>${entity.departmentName}</td>
	                <td>
	                	<c:if test="${entity.status=='ON_JOB'}">在职</c:if>
	                	<c:if test="${entity.status=='OFF_JOB'}">离职</c:if>
	                </td>
	                <td>
	                	<div class="table_cz">
			                <a class="paw_ico oper-respwd-user" uid="${entity.id}">密码重置</a> 
	                		<a class="bj_ico oper-edit-user" uid="${entity.id}">编缉</a>
	                		<a class="del_ico oper-delete-user" uid="${entity.id}">删除</a>
	                	</div>
	                </td>
	              </tr>
              </c:forEach>
              
              
            </table>

        </div>
        <jsp:include page="/fw/admin/common/page.jsp"></jsp:include>
    </div>
	<!--table-->
</form>	
</div>
 
</body>


</html>
