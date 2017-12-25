<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10.000">
<title>催收宝</title>
<meta name="Keywords" content="催收宝">
<meta name="Description" content="催收宝">
<meta name="Copyright" content="催收宝" />
<!-- 公共js css -->
<jsp:include page="/fw/admin/common/link.jsp" />

</head>
<body> 
<div class="cont"> 

	<!--搜索条件-->
	<div class="table_box czmx">
    	<h1><span>02月账单</span><a class="more_zd">更多账单</a></h1>
        <div class="table_con_cz mb20">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
              <tr>
                <th width="20%">收入</th>
                <th width="20%">上个结余</th>
                <th width="20%">当月支出</th>
              </tr>
              <tr>
                <td class="f24">258</td>
                <td class="f24">280.3</td>
                <td class="f24">0.00</td>
              </tr>
              
            </table>

        </div>
    </div>
    <!--搜索条件-->
    <!--table-->
    <div class="table_box">
    	<!--按钮top-->
        <div class="table_top">
            <div class="tab_nav">
                <ul>
                    <li class="rline"><a><span class="cznav_ico1"></span>语音</a></li>
                    <li class="rline"><a><span class="cznav_ico2"></span>短信</a></li>
                    <li><a><span class="cznav_ico3"></span>录音</a></li>
                </ul>
            </div>
            
        </div>
        <!--按钮top-->
        <div class="table_con_cz">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
              <tr>
                <th width="20%"></th>
                <th width="20%"></th>
                <th width="20%"></th>
                <th width="20%"></th>
                <th width="20%"></th>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
             <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr><tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            </table>

        </div>
        <div class="pages">
        	<div class="pages_l">共12条记录,每条显示<select name=""> <option>10</option><option>20</option><option>50</option></select>条</div>
            <div class="pages_r">
            	<ul>
                	<li><a class="now">上一页</a></li>
                    <li><a>首页</a></li>
                    <li><a>1</a></li>
                    <li><a>2</a></li>
                    <li><a>3</a></li>
                    <li><a>...</a></li>
                    <li><a>9</a></li>
                    <li><a>尾页</a></li>
                    <li><a class="now">下一页</a></li>
                </ul>
            </div>
        </div>
    </div>
	<!--table-->
</div>
 
<jsp:include page="/fw/admin/common/page.jsp"></jsp:include>
<!--弹出窗登录-->

<div id="add" style="display:none;">
    <div class="t_window"></div>
    <div class="window_box">
        <div class="l_tittle">
        	<h1>添加员工</h1>
            <div class="t_window_close"><a id="add_close" onclick="add_close();"><img src="images/w_close_ico.png"/></a></div>
        </div>
        <div class="wlogin_box">
            <div class="clear"></div>
            <div class="wlogin">
            	<ul>
            		<li><div class="text_input"><span>姓名：<b>*</b></span><input placeholder="请输入姓名" type="text" class="w_text"/><i class="ca_ico">请输入正确的姓名</i></div></li>
                    <li><div class="text_input"><span>编号：<b>*</b></span><input placeholder="请输入编号" type="text" class="w_text"/></div></li>
                    <li><div class="text_input"><span>电话：</span><input placeholder="请输入电话号码" type="text" class="w_text"/></div></li>
                    <li><div class="text_input"><span>手机：</span><input placeholder="请输入手机号码" type="text" class="w_text"/></div></li>
                    <li><div class="text_input"><span>所属部门：<b>*</b></span><input placeholder="请输入所属部门" type="text" class="w_text"/></div></li>
                    <li><div class="text_input"><span>岗位：<b>*</b></span>
                    	<div class="select_text">
                    		<select name="">
                            	<option>请选择</option>
                            </select>
                    	</div>
                    </div></li>
                    <li>
                    	<div class="text_input"><span>性别：</span>
                            <div class="dxbq">
                            <label>
                              <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_0" />
                              男</label>
                            <label>
                              <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_1" />
                              女</label>
                            </div>
                    	</div>
                    </li>
                    <li>
                    	<div class="text_input"><span>在职情况：</span>
                    		<div class="dxbq">
                            <label>
                              <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_0" />
                              在职</label>
                            <label>
                              <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_1" />
                              离职</label>
                            </div>
                    	</div>
                    </li>
            	</ul>
            	<div class="clear"></div>
                <div class="w_bottom">
                	<ul>
                    	<li><a class="now save_butico_now">保存信息</a></li>
                		<li><a class="del_butico" id="anqu_close" onclick="add_close();">删除信息</a></li>
                	</ul>
                </div>
                
            </div>
        </div>
    </div>
</div> 
<script type="text/javascript">
var index;
var timer;

// 添加
function add_start() {
	$('#add').show();
	$('t_window').css({overflow:'hidden'});
}
function add_close(){
	clearInterval(timer);
	$('#add').hide();
	$('body').css({overflow:''});
}



</script>
<script src="/fw/resources/js/navlist.js" type="text/javascript"></script><!-- 进度条 -->
<script src="/fw/resources/js/underscore.js" type="text/javascript"></script><!-- 进度条 -->
<script src="/fw/resources/js/highcharts.js" type="text/javascript"></script><!-- 进度条 -->
</body>


</html>
