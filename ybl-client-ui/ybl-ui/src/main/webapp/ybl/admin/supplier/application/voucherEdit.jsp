<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>凭证管理-添加/修改</title>
<jsp:include page="../../common/link.jsp" />
</head>
<body>
	<!--弹出窗登录-->
	<div class="vip_window_con">
		<div class="clear"></div>
		<div class="window_xx">
			<ul>
				<li><div class="input_box">
						<span>凭证编码：</span><input placeholder="请输入凭证编码" type="text"
							class="w300 text" />
					</div></li>
				<li><div class="input_box">
						<span>核心企业名称：</span><input placeholder="请输入核心企业名称" type="text"
							class="text w300" />
					</div></li>
				<li class="w472">
					<div class="input_box">
						<span>企业规模：</span>
						<div class="select_box">
							<select class="select w200">
								<option>请选择</option>
								<option>应收账款单</option>
								<option>商票</option>
								<option>银票</option>
							</select>
						</div>
					</div>
				</li>
				<li><div class="input_box">
						<span>凭证到期日期：</span><input placeholder="请选择到期日期" type="text"
							class="text w300" />
					</div></li>
				<li><div class="input_box">
						<span>凭证面额：</span><input placeholder="请选择凭证面额" type="text"
							class="text w300" />
					</div></li>
				<li><div class="input_box">
						<span>凭证登记日期：</span><input placeholder="请选择登记日期" type="text"
							class="text w300" />
					</div></li>
				<li><div class="input_box">
						<span>凭证起始日期：</span><input placeholder="请选择起始日期" type="text"
							class="text w300" />
					</div></li>

				<li class="clear"><div class="input_box">
						<span>备注说明：</span>
						<textarea class="text_tea w770 h100"></textarea>
					</div></li>

				<li>
					<div class="input_box">
						<span>凭证附件上传：</span>
						<div class="vip_phone">
							<dl>
								<dd>
									<a><img src="${app.staticResourceUrl}/ybl/resources/images/login_bg_01.jpg" /><i></i></a>
								</dd>
								<dd>
									<a></a>
								</dd>
							</dl>
						</div>
					</div>
				</li>

			</ul>
			<div class="clear"></div>
			<div class="w_bottom">
				<ul>
					<li><a class="now">提交</a></li>
					<li><a id="anqu_close" onclick="add_close();">取消</a></li>
				</ul>
			</div>

		</div>
	</div>

</body>
</html>