<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<%@include file="/ybl/v2/admin/common/link.jsp" %>
<title>Insert title here</title>
	<link href="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine-zh_CN.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#userManage_save_btn").click(function(){
			/*数据校验*/
			if(!$("#dataForm").validationEngine('validate')){
				return ;
			}
			var formData = $("#dataForm").serialize();
			$('#userManage_save_btn').hide();
			$('#userManage_saving_btn').show();
			$.ajax({
				type:'post',
				dataType:'json',
				url:'/v2UserController/addOrUpdateUser',
				data:formData,
				success:function(data){
					if(data.responseTypeCode=='success'){
						alert(data.info,function(){
							parent.window.location.href="/v2UserController/list.htm";
						});
					}else{
						$('#userManage_save_btn').show();
						$('#userManage_saving_btn').hide();
						alert(data.info);
					}	
				},
				error:function(){
					$('#userManage_save_btn').show();
					$('#userManage_saving_btn').hide();
					alert($.i18n.prop('sys.v2.client.system.is.busy.try.later')); //系统繁忙，请稍后重试
				}
			})
		})
		
	})

</script>
</head>
<body>
<div class="v2_window">
  <div class="v2_window_con">
  <form id="dataForm">
   <ul>
       			  <input type="hidden" name="id" value="${user.id }">
       <li class="clear">
                  
                   	<li class="clear">
                    	<div class="v2_input_box"><span><i class="red">*</i><spring:message code="sys.v2.client.member.real.name" /><!-- 姓名 -->：</span>
                    		<input type="text" name="realName" value="${user.realName }"  class="v2_text w300 validate[required,maxSize[20]]" />
                   		</div>
                   	</li>
                   	<div class="v2_input_box"><span><i class="red">*</i><spring:message code="sys.v2.client.phone" /><!-- 用户名 -->：</span>
                    		<input type="text" placeholder="" <c:if test="${method=='editMember'}">readonly="readonly" </c:if>  name="telePhone" value="${user.telePhone }" class="v2_text w300 validate[required,custom[mobilePhone]]" />
                   		</div> 
                   	</li>
                   	<li class="clear">
                    	<div class="v2_input_box mt20"><span><i class="red">*</i><spring:message code="sys.v2.client.email" /><!-- 邮箱 -->：</span>
                    		<input type="text" name="email" value="${user.email }" class="v2_text w300 validate[required,custom[email]]" />
                   		</div>
                   	</li>
                   <!-- 	<li class="clear">
                    	<div class="v2_input_box"><span>所属岗位：</span>
                    		<div class="v2_i_seach"><input placeholder="" type="text" class= "w300 v2_text"/><a class="v2_i_seach_ico"></a></div>
                   		</div>
                   	</li> -->
                   	<li class="clear">
                    	<div class="v2_input_box"><span><i class="red">*</i><spring:message code="sys.v2.client.sex" /><!-- 性别 -->：</span>
                    		<div class="v2_radio mb10 fl"><input class="v2_radio_input validate[required]" type="radio" name="sex" <c:if test="${user.sex == 'M'}"> checked="checked" </c:if> value="M" /><spring:message code="sys.v2.client.male" /><!-- 男 --></div>
                    		<div class="v2_radio mb10 fl"><input class="v2_radio_input validate[required]" type="radio" name="sex" <c:if test="${user.sex == 'F'}"> checked="checked" </c:if> value="F" /><spring:message code="sys.v2.client.female" /><!-- 女 --></div>
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="v2_input_box"><span><i class="red">*</i><spring:message code="sys.v2.client.member.status" /><!-- 用户状态 -->：</span>
                    		<div class="radio mb10 fl"><input class="v2_radio_input validate[required]" type="radio" name="status" <c:if test="${user.status == 'normal'}"> checked="checked" </c:if>  value="normal" /><spring:message code="sys.v2.client.business.status.normal" /><!-- 正常 --></div>
                    		<div class="radio mb10 fl"><input class="v2_radio_input validate[required]" type="radio" name="status" <c:if test="${user.status == 'freeze'}"> checked="checked" </c:if>value="freeze" /><spring:message code="sys.v2.client.business.status.freeze" /><!-- 禁用 --></div>
                   		</div>
                   	</li>
    </ul>
    </form>
  </div>
	   <div class="v2_but_list">
			<a class="bg_l"  id="userManage_save_btn" ><span><spring:message code="sys.v2.client.save" /><!-- 保存 --></a>
			<a class="bg_l"  id="userManage_saving_btn" style="display:none" ><span><spring:message code="sys.v2.client.saving" /><!-- 保存中.. --></a>
	   </div>
</div>
	
</body>
</html>