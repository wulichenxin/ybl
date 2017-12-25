<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 <link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/bootstrap.min.css" />
 <link rel="stylesheet" type="text/css" href="${app.staticResourceUrl}/ybl4.0/resources/css/index.css" />
		<div class="ybl-info box box1">
			<div class="process">
				<div class="chebox chebox1">
					<p class="protitle"><span>申请人信息</span></p>
					
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr30"><label>企业全称：</label><input value="${businessAuth.enterpriseName }" name="enterpriseName" readonly="readonly" class="content-form2 contentOnlyread" /></div>
							<div class="form-grou"><label class="w140">所属行业：</label><input name="industry" value="${businessAuth.industry }" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="content-form2 <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if> validate[maxSize[25]]" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr30"><label>注册地址：</label><input name="registerAddress" value="${businessAuth.registerAddress }" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="content-form2 validate[maxSize[127]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label class="w140">注册日期：</label><input name="registerDateString" value="<fmt:formatDate value='${businessAuth.registerDate }' pattern='yyyy-MM-dd' />" id="register_date" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="content-form2 <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr30"><label>注册资本：</label><input name="registerCapital" <c:if test="${not empty businessAuth.registerCapital and businessAuth.registerCapital ne '0.00' }">value="<fmt:formatNumber value="${businessAuth.registerCapital }" pattern="##.##" maxFractionDigits="2"/>"</c:if> <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if>  class="content-form2 <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if> validate[custom[number], maxSize[28]] " /><span class="timeimg">元</span></div>
							<div class="form-grou"><label class="w140">实缴资本：</label><input name="paidCapital" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> <c:if test="${not empty businessAuth.paidCapital and businessAuth.paidCapital ne '0.00' }">value="<fmt:formatNumber value="${businessAuth.paidCapital }" pattern="##.##" maxFractionDigits="2"/>"</c:if> class="content-form2 validate[custom[number],maxSize[28]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /><span class="timeimg">元</span></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr30"><label>办公地址：</label><input name="officeAddress" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> value="${businessAuth.officeAddress }" class="content-form2 validate[maxSize[127]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou"><label class="w140">统一社会信用代码：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="socialCreditCode" value="${businessAuth.socialCreditCode }" class="content-form2 validate[maxSize[50],custom[social_credit_code]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr30"><label>年检情况：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="annualSurveySituation" value="${businessAuth.annualSurveySituation }" class="content-form2 validate[maxSize[127]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou"><label class="w140">联系人：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="contacts" value="${businessAuth.contacts }" class="content-form2 validate[maxSize[25]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form">
							
							<div class="form-grou mr30"><label>电话：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="contactsPhone" value="${businessAuth.contactsPhone }" class="content-form2 validate[maxSize[20],custom[isTel]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou"><label class="w140">邮箱：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="contactsEmail" value="${businessAuth.contactsEmail }" class="content-form2 validate[maxSize[50],custom[email]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
					</div>
					
					<p class="protitle"><span>实际控制人信息</span></p>
					
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label><span style="color:red">*</span>姓名：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerName" value="${businessAuth.controllerName }" class="content-form2 validate[required,maxSize[25]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>性别：</label><select <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerGender" class="content-form2 <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" >
								<option value="1" <c:if test="${businessAuth.controllerGender eq '1'}">selected = "selected"</c:if> >男</option>
								<option value="2" <c:if test="${businessAuth.controllerGender eq '2'}">selected = "selected"</c:if> >女</option></select></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>国籍：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerNationality" value="${businessAuth.controllerNationality }" class="content-form2 validate[maxSize[25]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>身份证号码：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerCardId" value="${businessAuth.controllerCardId }" class="content-form2 validate[maxSize[50],custom[cardid]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>年龄：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerAgeStr" <c:if test="${not empty businessAuth.controllerAge and businessAuth.controllerAge ne '0' }">value="${businessAuth.controllerAge }"</c:if>  class="content-form2 validate[custom[number],min[0],max[150]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /><span class="timeimg">岁</span></div>
							<div class="form-grou"><label>从业年限：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerWorkYearStr" <c:if test="${not empty businessAuth.controllerWorkYear and businessAuth.controllerWorkYear ne '0' }">value="${businessAuth.controllerWorkYear }"</c:if>  class="content-form2 validate[custom[number],min[0],max[100]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /><span class="timeimg">年</span></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>办公电话：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerOfficePhone" value="${businessAuth.controllerOfficePhone }" class="content-form2 validate[maxSize[20],custom[isTel]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>婚姻状况：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerMaritalStatus" value="${businessAuth.controllerMaritalStatus }" class="content-form2 validate[maxSize[10]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou"><label>家庭住址：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="controllerHomeAddress" value="${businessAuth.controllerHomeAddress }" class="content-form2 validate[maxSize[127]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
					</div>
					
					<p class="protitle"><span>法定代表人情况</span></p>
					
					<div class="grounpinfo">
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label><span style="color:red">*</span>姓名：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalName" value="${businessAuth.legalName }" class="content-form2 validate[required,maxSize[25]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>性别：</label><select <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalGender" class="content-form2 <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>">
								<option value="1" <c:if test="${businessAuth.legalGender eq '1'}">selected = "selected"</c:if> >男</option>
								<option value="2" <c:if test="${businessAuth.legalGender eq '2'}">selected = "selected"</c:if> >女</option>
							</select></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>国籍：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalNationality" value="${businessAuth.legalNationality }" class="content-form2 validate[maxSize[25]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>身份证号码：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalCardId" value="${businessAuth.legalCardId }" class="content-form2 validate[maxSize[50],custom[cardid]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>年龄：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalAgeStr" <c:if test="${not empty businessAuth.legalAge and businessAuth.legalAge ne '0' }">value="${businessAuth.legalAge }"</c:if> class="content-form2 validate[custom[number],min[0],max[150]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /><span class="timeimg">岁</span></div>
							<div class="form-grou"><label>从业年限：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalWorkYearStr" <c:if test="${not empty businessAuth.legalWorkYear and businessAuth.legalWorkYear ne '0' }">value="${businessAuth.legalWorkYear }"</c:if>  class="content-form2 validate[custom[number],min[0],max[100]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /><span class="timeimg">年</span></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou mr50"><label>办公电话：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalOfficePhone" value="${businessAuth.legalOfficePhone }" class="content-form2 validate[maxSize[20],custom[isTel]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
							<div class="form-grou mr50"><label>婚姻状况：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalMaritalStatus" value="${businessAuth.legalMaritalStatus }" class="content-form2 validate[maxSize[10]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
						<div class="ground-form mb20">
							<div class="form-grou"><label>家庭住址：</label><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="legalHomeAddress" value="${businessAuth.legalHomeAddress }" class="content-form2 validate[maxSize[127]] <c:if test="${not empty looktype and looktype eq 'look' }">contentOnlyread</c:if>" /></div>
						</div>
					</div>
					
					
					<p class="protitle"><span>经营范围</span></p>
					<div class="pd20">
						企业经营范围：<textarea style="width:86%" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> name="businessScope" class="protext validate[maxSize[127]]<c:if test="${not empty looktype and looktype eq 'look' }">protextOnlyread</c:if>">${businessAuth.businessScope }</textarea>
					</div>
					
					<p class="protitle"><span>股东情况</span></p>
					<div class="pd20">
						<div class="tabD">
							<table>
								<tr>
									<th>股东名称</th>
									<th>股权比例(%)</th>
									<th>注资方式</th>
									<th>法人代表</th>
									<th>注册资本(元)</th>
									<th>实收资本(元)</th>
									<th>注册日期</th>
								</tr>
								<c:if test="${empty stockholerList }">
								<tr>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[127]]" name="StockHolderList[0].name" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[0].investmentRatio"  type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[127]]" name="StockHolderList[0].investmentMode" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[25]]" name="StockHolderList[0].legalName" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[0].investmentAmount" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[0].receivedAmount" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput registerDate" name="StockHolderList[0].registerDateTemp" id="registerDate" type="text" /><c:if test="${empty looktype}"><img class="add-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_add_icon.png" /><span class="sp-delete">---</span></c:if></td>
								</tr>
								</c:if>
								<c:if test="${not empty stockholerList }">
								<c:forEach var="stockholerData" items="${stockholerList }" varStatus="status">
								<tr>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[127]]" name="StockHolderList[${status.index }].name" value="${stockholerData.name}" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[${status.index }].investmentRatio" <c:if test="${not empty stockholerData.investmentRatio and stockholerData.investmentRatio ne '0.0000' }">value="<fmt:formatNumber value="${stockholerData.investmentRatio }" pattern="##0.####" maxFractionDigits="4"/>"</c:if> type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[127]]" name="StockHolderList[${status.index }].investmentMode" value="${stockholerData.investmentMode}" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[maxSize[25]]" name="StockHolderList[${status.index }].legalName" value="${stockholerData.legalName}" type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[${status.index }].investmentAmount" <c:if test="${not empty stockholerData.investmentAmount and stockholerData.investmentAmount ne '0.0000' }">value="<fmt:formatNumber value="${stockholerData.investmentAmount }" pattern="##0.##" maxFractionDigits="2"/>"</c:if> type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput validate[custom[number], maxSize[28]]" name="StockHolderList[${status.index }].receivedAmount" <c:if test="${not empty stockholerData.receivedAmount and stockholerData.receivedAmount ne '0.0000' }">value="<fmt:formatNumber value="${stockholerData.receivedAmount }" pattern="##0.##" maxFractionDigits="2"/>"</c:if> type="text" /></td>
									<td><input <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="tdinput registerDate" name="StockHolderList[${status.index }].registerDateTemp" id="registerDate" value="<fmt:formatDate value='${stockholerData.registerDate }' pattern='yyyy-MM-dd' />" type="text" /><c:if test="${empty looktype}"><img class="add-img" src="${app.staticResourceUrl}/ybl4.0/resources/images/mbl_add_icon.png" /><span class="sp-delete">---</span></c:if></td>
								</tr>
								</c:forEach>
								</c:if>
							</table>

					</div>
				</div>
					
					
				<p class="protitle"><span>历史沿革</span></p>
				<div class="pd20">
					历史沿革：<textarea style="width:86%" name="history" <c:if test="${not empty looktype and looktype eq 'look' }">readonly="readonly"</c:if> class="protext validate[maxSize[127]]<c:if test="${not empty looktype and looktype eq 'look' }">protextOnlyread</c:if>">${businessAuth.history }</textarea>
				</div>	
			</div>
			
			</div>
		</div>
<script>
//时间控件
 $('#register_date,#registerDate').datetimepicker({
		yearOffset: 0,
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
		minDate: '1970-01-01', // yesterday is minimum date
		maxDate: '2099-12-31' // and tommorow is maximum date calendar
}); 
//股东列表增加
 $('.add-img').click(function(){
		var htmlArray = [];
		var len = $(this).parents('table').find('tr').length-1;
		if(document.getElementsByName("StockHolderList[" + len + "].name").length > 0){
			len ++;
		}
		htmlArray.push("<tr>")
		htmlArray.push("<td><input class='tdinput validate[maxSize[255]]' name='StockHolderList["+len+"].name' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput validate[custom[number], maxSize[28]]' name='StockHolderList["+len+"].investmentRatio' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput validate[maxSize[255]]' name='StockHolderList["+len+"].investmentMode' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput validate[maxSize[50]]' name='StockHolderList["+len+"].legalName' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput validate[custom[number], maxSize[28]]' name='StockHolderList["+len+"].investmentAmount' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput validate[custom[number], maxSize[28]]' name='StockHolderList["+len+"].receivedAmount' type='text' /></td>");
		htmlArray.push("<td><input class='tdinput registerDate' name='StockHolderList["+len+"].registerDateTemp' type='text' /><img class='add-img' src='${app.staticResourceUrl}/ybl4.0/resources/images/mbl_add_icon.png' /><span class='sp-delete'>---</span></td>");
		htmlArray.push("</tr>");
		$(this).parents('table').append(htmlArray.join(""));
		$('.registerDate').datetimepicker({
			yearOffset: 0,
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
			minDate: '1970-01-01', // yesterday is minimum date
			maxDate: '2099-12-31' // and tommorow is maximum date calendar
	}); 
	});
//删除当前股东信息		
$(document).on('click','.sp-delete',function(){
		$(this).parents('tr').remove()
}); 
		</script>