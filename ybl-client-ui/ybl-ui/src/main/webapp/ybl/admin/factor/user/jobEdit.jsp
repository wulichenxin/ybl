<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>岗位管理-添加/修改</title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
<!--弹出窗登录-->
<div class="vip_window_con">
            <div class="clear"></div>
            <div class="window_xx">
            	<ul>
            		
                    <li class="clear">
                    	<div class="input_box"><span>岗位名称：</span>
                    		<input type="text" placeholder="" class="text w300" />
                   		</div>
                   	</li>
                   	<li class="clear">
                    	<div class="input_box"><span>岗位描述：</span>
                    		<input type="text" placeholder="" class="text w300" />
                   		</div>
                   	</li>
                    <!--<li class="clear">
                    	<div class="input_box"><span>所属权限组：</span>
                    		<div class="select_box">
										<select class="select w200">
											<option>请选择</option>
											<option>通过</option>
											<option>不通过</option>
											<option>终结</option>
										</select>
									</div>
                   		</div>
                   	</li>-->
                    <li class="clear"><div class="input_box"><span>备注：</span><textarea class="text_tea w400 h100"></textarea></div></li>
           	
            	</ul>
            	<div class="clear"></div>
                <div class="w_bottom">
                	<ul>
                    	<li><a class="now">确定</a></li>
                		<li><a id="anqu_close" onclick="add_close();">取消</a></li>
                	</ul>
                </div>
                
            </div>
        </div>
</body>
</html>