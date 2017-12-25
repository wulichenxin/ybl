<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<title>催收宝平台</title>
		<!-- 公共js css -->
		<jsp:include page="/fw/admin/common/link.jsp" />
		<!-- 功能js css -->
		<script src="/fw/resources/js/admin-head.js" type="text/javascript" ></script>
		<link href="/fw/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/fw/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
		<script type="text/javascript" src="/fw/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/fw/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
		<script type="text/javascript" src="/fw/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
		<script type="text/javascript" src="/fw/resources/js/fw-user-edit.js"></script>
	</head>


<body>
<!--弹出窗登录-->
		<input type="hidden" id="def_gender" value="${userVo.gender }" />
		<input type="hidden" id="def_status" value="${userVo.status }" />
		<ul id="selTree" class="ztree deptTree" style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 10px;z-index:10;height: 220px;overflow: auto;"></ul>
        <div class="l_tittle">
        	<h1>添加员工</h1>
            <div class="t_window_close"><a id="add_close" ><img src="/fw/resources/images/w_close_ico.png"/></a></div>
        </div>
        <div class="wlogin_box">
            <div class="clear"></div>
            <div class="wlogin">
            	<form action="/userController/saveOrUpdate" method="post" id="dataForm">
            		<input type="hidden" name="id" value="${userVo.id }" />
	            	<ul>
	            		<li><div class="text_input"><span>用户名：<b>*</b></span><input placeholder="请输入用户名" required name="userName" value="${userVo.userName}" type="text" class="w_text"/></div></li>
	            		<li><div class="text_input"><span>姓名：<b>*</b></span><input placeholder="请输入姓名" required name="nick" value="${userVo.nick}" type="text" class="w_text"/></div></li>
	                    <li><div class="text_input"><span>编号：<b>*</b></span><input placeholder="请输入编号" required name="userCode" value="${userVo.userCode}" type="text" class="w_text"/></div></li>
	                    <li><div class="text_input"><span>电话：</span><input placeholder="请输入电话号码" name="tel" type="text" value="${userVo.tel}" class="w_text"/></div></li>
	                    <li><div class="text_input"><span>手机：<b>*</b></span><input placeholder="请输入手机号码" required name="mobile" type="text" value="${userVo.mobile}" class="w_text"/></div></li>
	                    <li><div class="text_input"><span>所属部门：<b>*</b></span>
	                    		<input name="departmentName" placeholder="请选择所属部门"  required id="departmentName" value="${userVo.departmentName}" readonly="readonly" style="cursor: pointer;" type="text" class="w_text"/>
	                    		<input id="departmentId" type="hidden" name="departmentId" value="${userVo.departmentId}" />
	                    </div></li>
	                    <li><div class="text_input"><span>岗位：<b>*</b></span>
	                    	<div class="select_text">
	                    		<select name="jobId" class="fw_comp_select" defaultValue="${userVo.jobId}" required ajaxurl="/jobController/getSelectList" valueField="id" textField="jobName" ></select>
	                    	</div>
	                    </div></li>
	                    <li>
	                    	<div class="text_input"><span>性别：</span>
	                            <div class="dxbq">
	                            <label>
	                            	<input type="radio" id="gender_male" name="gender" checked="checked" value="MALE"   />男
	                            </label>
	                            <label>
	                            	<input type="radio" id="gender_female" name="gender" value="FEMALE"   />女
	                            </label>
	                            </div>
	                    	</div>
	                    </li>
	                    <li>
	                    	<div class="text_input"><span>在职情况：</span>
	                    		<div class="dxbq">
	                            <label><input type="radio" id="status_on" name="status" checked="checked"  value="ON_JOB" />在职</label>
	                            <label><input type="radio" id="status_off" name="status" value="OFF_JOB" />离职</label>
	                            </div>
	                    	</div>
	                    </li>
	            	</ul>
            		<div class="clear"></div>
	                <div class="w_bottom">
	                	<ul>
	                    	<li>
	                    	<a id="btn-submit" class="now save_butico_now">保存</a>
	                    	<a id="btn-submiting" class="del_butico" style="display: none;">保存中...</a>
	                    	</li>
	                		<li><a class="del_butico" id="anqu_close">关闭</a></li>
	                	</ul>
	                </div>
                </form>
                </div>
            </div>
 </body>
</html>