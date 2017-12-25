<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>员工管理-添加/修改</title>
<jsp:include page="../../common/link.jsp" />
<!-- 树 -->
<link href="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.ztree.3.5/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/userManagement/employeeEdit.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script language='javascript' src="${app.staticResourceUrl}/ybl/resources/plugins/jquery-validation-1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/jquery.form.3.51/jquery.form.js"></script>
<!-- 部门树js -->
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/department/fw-department-edit.js"></script>
</head>
<body>
<!-- 部门树弹框开始-->
<ul id="selTree" class="ztree deptTree" 
	style="display: none;position: absolute;background: #fff;border: 1px solid #ccc;padding: 
	10px;z-index:10;height: 220px;overflow: auto;margin:90px -122px;">
</ul>
<!-- 部门树弹框结束-->
<form action="/UserController/addOrUpdateUser" id="userForm" method="post">
<input type='hidden' value='${memberInfo.id }' id='user_id' name="id"/><!-- 用户id -->
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
			<ul>

				<li class="clear">
					<div class="input_box">
						<span>用户名：</span> <input name="userName" type="text" placeholder="登录名" value="${memberInfo.userName }"
							class="text w300" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span>姓名：</span> <input name="realName" type="text" placeholder="姓名"  value="${memberInfo.realName }"
							class="text w300" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span>姓别：</span>
						<div class="radio mb10 fl">
							<input class="radio_input" name="gender" <c:if test="${memberInfo.gender eq 'M' }"> checked</c:if>  type="radio" name="RadioGroup1"
								value="M" />男
						</div>
						<div class="radio mb10 fl">
							<input class="radio_input" name="gender"<c:if test="${memberInfo.gender eq 'F' }"> checked</c:if> type="radio" name="RadioGroup1"
								value="F" />女
						</div>
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span>手机号码：</span> <input name="telephone" type="text" placeholder="手机号"
							class="text w300" value="${memberInfo.telephone }" />
					</div>
				</li>
				<li class="clear">
					<div class="input_box">
						<span>所属部门：</span> 
<%-- 						<input name="departmentName" class="text w300" name="parentDepartmentName" placeholder="请选择所属部门" id="parentDepartmentName" readonly="readonly" style="cursor: pointer;" type="text" value='${dept.name}'/> --%>
<%-- 	                    <input id="parentId" name="deptId" value="${memberInfo.deptId}" type="hidden" name="departmentId" />                       --%>
							<input name="parentDepartmentName" placeholder="请选择所属部门" id="parentDepartmentName" readonly="readonly" style="cursor: pointer;" type="text" class="w_text" value='${dept.name}'/>
	                    	<input id="parentId" value="${memberInfo.deptId}" type="hidden" name="deptId" />
                    <%-- <input type="text" placeholder=""
							class="text w300" value="${memberInfo.attribute1 }" /> --%>
					</div>
				</li>
<!-- 				<li class="clear"> -->
<!-- 					<div class="input_box"> -->
<!-- 						<span>岗位：</span> <input name="attribute2" type="text" placeholder="岗位" -->
<%-- 							class="text w300" value="${memberInfo.attribute2 }" /> --%>
<!-- 					</div> -->
<!-- 				</li> -->
				<li class="clear">
					<div class="input_box">
						<span>在职情况：</span>
						<div class="radio mb10 fl">
							<input class="radio_input" name="status" type="radio" name="RadioGroup1"
								value="normal" <c:if test="${memberInfo.status eq 'normal' }"> checked</c:if> />正常
						</div>
						<div class="radio mb10 fl">
							<input class="radio_input" name="status" type="radio" name="RadioGroup1"
								value="freeze" <c:if test="${memberInfo.status ne 'normal' }"> checked</c:if> />冻结
						</div>
						<div class="radio mb10 fl">
							<input class="radio_input" name="status" type="radio" name="RadioGroup1"
								value="logout" <c:if test="${memberInfo.status ne 'normal' }"> checked</c:if> />注销
						</div>
					</div>
				</li>
			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
					<li><a id="saveUserBtn" class="now">保存</a></li>
					<li><a id="anqu_close" onclick="add_close();">取消</a></li>
				</ul>
			</div>
		</div>
	</div>
</form>
</body>
</html>