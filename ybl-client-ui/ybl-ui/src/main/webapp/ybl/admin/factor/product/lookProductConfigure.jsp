<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sun" uri="http://www.sunline.cn/framework"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>产品配置</title>
<jsp:include page="../../common/link.jsp" />
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
$(function(){
	$("input").attr("disabled",true);
	$("select").attr("disabled",true);
	$("textarea").attr("disabled",true);
});   
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../common/top.jsp?step=2" />
	<!--top end -->
	<div class="path">当前位置->产品工厂 -> 产品管理 -> 产品配置</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
            	<div class="v_tittle"><h1><i class="v_tittle_2"></i>产品详情</h1></div>
            	<div class="rzsq_box">
					<h1>产品概述</h1>
					<input type="hidden" value="${product.id_ }" id="product_id">
					<input type="hidden" value="${product.enterprise_id }" id="enterprise_id">
					<div class="rzzt">
						<ul>
						<li><div class="input_box"><span>产品名称：</span><input value="${product.name_ }" type="text" disabled="disabled" class= "w770 text_gary"/></div></li>
						<li><div class="input_box"><span>保理类型：</span>
							<c:if test="${product.type_ == 'online_factor' }">
								<input value="线上明保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							<c:if test="${product.type_ == 'offline_factor' }">
								<input value="线下明保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							<c:if test="${product.type_ == 'dark_factor' }">
								<input value="暗保理" type="text" disabled="disabled" class= "w770 text_gary"/>
							</c:if>
							
							</div>
						</li>
									<!-- <div class="select_box">
										<select class="select w200">
											<option>请选择</option>
											<option>线上明保理</option>
											<option>线下明保理</option>
											<option>暗保理</option>
										</select>
									</div></div> -->
						<li><div class="input_box"><span>产品描述：</span><textarea class="text_tea w770 h200" >${product.desc_ }</textarea></div></li>
						
					</ul>
					</div>
				</div>
           		<div class="rzsq_box">
					<h1>产品详情</h1>
					<div class="rzzt">
						<ul>
						<li class="clear w472">
								<div class="input_box">
									<span>产品logo：</span>
									<div class="vip_phone" style="width:300px;">
										<dl>
											<dd>
												<a id="addBtn">
													<c:if test="${empty attachment.url_ }">
						                    			<i>+</i>
						                    		</c:if>
						                    		<c:if test="${not empty attachment.url_ }">
						                    			<img src="${attachment.url_ }"/>
						                    		</c:if>
												</a>
											</dd>
										</dl>
									</div>
								</div>
							</li>
							<li class=" clear w472">
						      <div class="input_box"><span>还款方式：</span>
							      到期一次性还本付息
							  </div>
							 </li>
							<%-- <li class="clear w472">
								<div class="input_box"><span>还款日规则：</span>
									<div class="select_box">
										<c:if test="${product.repayment_date_rule=='greater_than' }">&nbsp;>&nbsp;</c:if>
										<c:if test="${product.repayment_date_rule=='less_than' }">&nbsp;< &nbsp;</c:if>
										<c:if test="${product.repayment_date_rule=='equal_to' }">&nbsp;=&nbsp;</c:if>
									</div>贷款凭证最早到期日
								</div>
							</li> --%>
							<li class=" w472"><div class="input_box"><span>贷款利率：</span><div>年利率<input name="rate_" value="<fmt:formatNumber value="${product.rate_ }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10" disabled="disabled"/>%</div></div></li>
							<li class="clear w472"><div class="input_box"><span>逾期利率：</span><div>日利率<input name="overdue_rate" value="<fmt:formatNumber value="${product.overdue_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10" disabled="disabled"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>管理费百分比：</span><div>年利率<input name="manage_rate" value="<fmt:formatNumber value="${product.manage_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10" disabled="disabled"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>违约利率：</span><div>日利率<input name="penalty_rate" value="<fmt:formatNumber value="${product.penalty_rate }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10 ml10" disabled="disabled"/>%</div></div></li>
							<li class="w472"><div class="input_box"><span>融资比例：</span><input name="finance_ratio" value="<fmt:formatNumber value="${product.finance_ratio }" pattern="#,##0.00" maxFractionDigits="2"/>" type="text" class="text w50 mr10" disabled="disabled"/>%</div></li>
							<li class="w472">
								<div class="input_box"><span>贷款期限：</span>
								<input  value="${product.term_ }" type="text" class="text w50 mr10 fl" disabled="disabled"/>
								<c:if test="${product.loan_type=='day' }">日</c:if>
								<c:if test="${product.loan_type=='month' }">月</c:if>
								<c:if test="${product.loan_type=='year' }">年</c:if>
								</div>
							</li>
						</ul>
					</div>
				</div>
           		
          		<div class="rzsq_box">
					<h1>贷款材料配置</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
							  <tr>
							   <th width="50"><input name="" type="checkbox" value="" /></th>
								<th>序号</th>
								<th>贷款材料名称</th>
								<th>备注</th>
							  </tr>
							  <c:forEach var="mat" items="${matList}" varStatus="index">
							  <tr>
							   <td><input name="checkMat" type="checkbox" value="${mat.id_}" /></td>
								<td>${index.count}</td>
								<td>${mat.name_}</td>
								<td>${mat.remark_}</td>
							  </tr>
							  </c:forEach>
							  
							</table>

						</div>
				</div>
          		<%-- <div class="rzsq_box">
					<h1>贷款归档材料配置</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb">
							  <tr>
							   <th width="50"><input name="" type="checkbox" value="" /></th>
								<th>序号</th>
								<th>归档材料名称</th>
								<th>备注</th>
							  </tr>
							  <c:forEach var="arc" items="${arcList}" varStatus="index">
							  <tr>
							   <td><input name="checkArc" type="checkbox" value="${arc.id_}" /></td>
								<td>${index.count}</td>
								<td>${arc.name_}</td>
								<td>${arc.remark_}</td>
							  </tr>
							  </c:forEach>
							</table>
						</div>
				</div>   --%>         		          		
            </div>        
    </div>
    
<!-- 底部jsp -->
	<jsp:include page="../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>