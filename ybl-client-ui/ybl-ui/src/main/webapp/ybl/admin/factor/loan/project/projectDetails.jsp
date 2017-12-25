<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入spring标签库 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>项目详情</title>
<jsp:include page="../../../common/link.jsp" />
<!--弹出框-->
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.dragndrop.js"></script>
<script type="text/javascript"
	src="${app.staticResourceUrl}/ybl/resources/js/jquery.msgbox.js"></script>
<script type="text/javascript">
	$(function() {
		//tab切换
		$('.tabnav dl dd').click(function() {
			var index = $(this).index();
			$('.content').eq(index).show().addClass('now').siblings().removeClass('now').hide();
			$('.tabnav dl dd').eq(index).addClass('now').siblings().removeClass('now');
		});
		view = function(id) {
			$.msgbox({
				height : 520,
				width : 800,
				content : '${app.staticResourceUrl}/ybl/admin/common/preview.jsp',
				type : 'iframe',
				title : '正面身份证'
			});
		}
	});
</script>
</head>
<body>
	<!--top start -->
	<jsp:include page="../../../common/top.jsp?step=6" />
	<!--top end -->
	<div class="path">当前位置->竞标管理 -> 我要竞投 -> 项目详情</div>
	<div class="p_detail_con ">
		<div class="p_details_l body_cbox">
			<h1>材料供应商A类贷款</h1>
			<div class="p_detail_sj">
				<ul>
					<li>
						<h2>
							<span class="yellow">500</span>万元
						</h2>
						<p>贷款金额</p>
					</li>
					<li>
						<h2>
							<span>3</span>个月
						</h2>
						<p>贷款期限</p>
					</li>
					<li>
						<h2>
							<span>3</span>家
						</h2>
						<p>竞标企业</p>
					</li>
				</ul>
			</div>
			<div class="p_detail_xx">
				<ul>
					<li><span>贷款企业：</span><a class="lan">材料供应商</a></li>
					<li><span>还款方式：</span>到期一次还本付息</li>
					<li><span>担保方式：</span>招商银票</li>
					<li><span>竞投截止时间：</span>2016年12月30日</li>
					<li><span>联系电话：</span>0755-123456</li>
					<li><span>核心企业：</span>阿里巴巴</li>
				</ul>
			</div>
			<div class="jbs">
				竞标剩余时长<span class="yellow">1天2小时</span>
			</div>
		</div>
		<div class="p_details_r body_cbox">
			<h1>竞投数据</h1>
			<div class="rzzt1">
				<ul>


					<li class="w400"><div class="p_input_box">
							<span class="w100">费用计息规则：</span>
							<div class="radio mb10">
								<input class="radio_input" type="radio" name="RadioGroup1"
									value="单选" />按贷款金额百分比： <input placeholder="10" type="text"
									class="text_30 w50 mr10 ml10" />%
							</div>
							<div class="radio ml100">
								<input class="radio_input" type="radio" name="RadioGroup1"
									value="单选" />按贷款金额百分比： <input placeholder="10" type="text"
									class="text_30 w50 mr10 ml10" />%
							</div>
						</div></li>
					<li class=" w400 clear"><div class="p_input_box">
							<span>贷款利率：</span>
							<div>
								年利率<input placeholder="10" type="text"
									class="text_30 w50 mr10 ml10" />%
							</div>
						</div></li>
					<li class="w400 clear"><div class="p_input_box">
							<span>管理费百分比：</span>
							<div>
								年利率<input placeholder="10" type="text"
									class="text_30 w50 mr10 ml10" />%
							</div>
						</div></li>
					<li><div class="p_input_box">
							<span>融资比例：</span><input placeholder="10" type="text"
								class="text_30 w30 mr10 " />%
						</div></li>
					<li><div class="p_input_box">
							<span>最大可贷金额：</span><input placeholder="10" type="text"
								class="text_30 w30 mr10 " />万元
						</div></li>
					<li><div class="p_input_box">
							<span>提前还款违约金：</span><input placeholder="20" type="text"
								class="text_30 w30 mr10" />%
						</div></li>
					<li><div class="p_input_box">
							<span>逾期违约金：</span><input placeholder="20" type="text"
								class="text_30 w30 mr10" />%
						</div></li>

				</ul>
				<div class="w_agreen">
					<input name="" type="checkbox" value="" />同意签署保理贷款合同合约
				</div>
				<div class="but_left">
					<a>参与竞投</a>
				</div>
			</div>
		</div>
	</div>
	<div class="vip_conbody body_cbox">
		<div class="tabnav">
			<div class="v_tit_tab">
				<dl>
					<dd class="now">
						<a>项目信息</a>
					</dd>
					<dd>
						<a>融资公司简介</a>
					</dd>
					<dd>
						<a>安全保障</a>
					</dd>
				</dl>
			</div>
			<div>
				<div class="text_box content">
					<div class="rzsq_box">
						<h1>融资主体</h1>
						<div class="rzzt">
							<ul>
								<li><div class="input_box">
										<span>贷款公司名称：</span><input placeholder="电子供应商" type="text"
											class="w300 text_gary" />
									</div></li>
								<li><div class="input_box">
										<span>营业执照号码：</span><input placeholder="0755-123456"
											type="text" class="text_gary w300" />
									</div></li>
								<li><div class="input_box">
										<span>法人代表名称：</span><input placeholder="张小明" type="text"
											class="text_gary w300" />
									</div></li>
								<li><div class="input_box">
										<span>法人身份证号码：</span><input placeholder="345678987654323456"
											type="text" class="text_gary w300" />
									</div></li>
								<li><div class="input_box">
										<span>开户银行：</span><input placeholder="请输入开户银行账号" type="text"
											class="text w300" />
									</div></li>
								<li><div class="input_box">
										<span>开户银行账号：</span><input placeholder="请输入开户银行账号" type="text"
											class="text w300" />
									</div></li>
								<li><div class="input_box">
										<span>支行名称：</span><input placeholder="请输入支行名称" type="text"
											class="text w770" />
									</div></li>
								<li><div class="input_box">
										<span>竞标截止时间：</span><input placeholder="2016/12/10  18:00"
											type="text" class="text_gary w300" />
									</div></li>
							</ul>
						</div>
					</div>
					<div class="rzsq_box">
						<h1>融资申请</h1>
						<div class="rzzt">
							<ul>
								<li><div class="input_box">
										<span>融资编号：</span><input placeholder="电子供应商" type="text"
											class="w300 text_gary" />
									</div></li>
								<li><div class="input_box">
										<span>项目名称：</span><input placeholder="请输入项目名称" type="text"
											class="text w300" />
									</div></li>
								<li class="w472"><div class="input_box">
										<span>融资金额：</span><input placeholder="324345465465"
											type="text" class="text w200 mr10" />万元
									</div></li>
								<li><div class="input_box">
										<span>贷款期限：</span>
										<div class="select_box">
											<select class="select w200">
												<option>请选择</option>
												<option>1</option>
												<option>2</option>
												<option>3</option>
											</select>
										</div>
									</div></li>
								<li class="clear w472"><div class="input_box">
										<span>还款方式：</span>
										<div class="select_box">
											<select class="select w200">
												<option>请选择</option>
												<option>一次性还付本息</option>
												<option>一次性还付本息</option>
												<option>一次性还付本息</option>
											</select>
										</div>
									</div></li>
								<li class="w472"><div class="input_box">
										<span>保理类型：</span>
										<div class="select_box">
											<select class="select w200">
												<option>请选择</option>
												<option>线上明保理</option>
												<option>线下明保理</option>
												<option>暗保理</option>
											</select>
										</div>
									</div></li>
								<li><div class="input_box">
										<span>还款日期：</span><input placeholder="2016-12-10" type="text"
											class="text w300" />
									</div></li>
								<li><div class="input_box">
										<span>预计放款审批时间：</span><input placeholder="请输入企业名称" type="text"
											class="text w300 mr10" />天
									</div></li>
								<li><div class="input_box">
										<span>融资用途：</span>
										<textarea class="text_tea w770 h100"></textarea>
									</div></li>
							</ul>
						</div>
					</div>

					<div class="rzsq_box">
						<h1>融资凭证</h1>
						<!--按钮top-->
						<div class="table_top mt20 table_border">
							<div class="table_nav">
								<ul>
									<li><a class="but_ico2">添加</a></li>
									<li><a class="but_ico1">删除</a></li>
								</ul>
							</div>
						</div>
						<div class="table_con table_border ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb">
								<tr>
									<th width="50">序号</th>
									<th>凭证编码</th>
									<th>核心企业名称</th>
									<th>凭证面额（万元）</th>
									<th>凭证类型</th>
									<th>凭证起始日期</th>
									<th>凭证到期日</th>
									<th>上传时间</th>
									<th>操作</th>
								</tr>
								<tr>
									<td>1</td>
									<td>0001</td>
									<td>京东</td>
									<td>¥5000.00</td>
									<td>应收账款凭证</td>
									<td>2016/12/30</td>
									<td>2016/12/30</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>

							</table>

						</div>
					</div>

					<div class="rzsq_box">
						<h1>贷款材料</h1>

						<div class="table_con table_border mt20">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="tb1">
								<tr>
									<th width="50">序号</th>
									<th>材料名称</th>
									<th>备注</th>
									<th>上传时间</th>
									<th>操作</th>
								</tr>
								<tr>
									<td>1</td>
									<td>法人身份证</td>
									<td>身份证正面</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>
								<tr class="bg_l">
									<td>2</td>
									<td>法人身份证</td>
									<td>身份证正面</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>
								<tr>
									<td>3</td>
									<td>组织机构</td>
									<td>身份证正面</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>
								<tr class="bg_l">
									<td>4</td>
									<td>法人个人征信报告</td>
									<td>身份证正面</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>
								<tr>
									<td>5</td>
									<td>企业征信报告</td>
									<td>身份证正面</td>
									<td>2016/11/29 20:36</td>
									<td><div class="qy">
											<a href="javascript:view(1);">预览</a>
										</div></td>
								</tr>


							</table>

						</div>
					</div>

				</div>

				<div class="text_box content" style="display: none;">
					<div class="blsjj">
						<h1>公司简介</h1>
						<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p>
						<p>国信基金管理团队拥有十余年国内私募股权投融资和海外资本市场的运作经验。我们不断吸纳来自于基金、法律、银行、证券等金融领域的精英人士加入我们，致力于打造优秀的基金项目管理团队和稳健的风险控制管理团队。我们拥有强大的项目资源平台、完善的风控法务平台、权威的项目评估系统、专业的财富管理系统以及卓越的客户服务体系。信赖我们，让财富不再“奢侈”。</p>
						<p>国信基金牢牢把握当下金融形势，投资方向侧重于“新能源”、“新兴农业”、“工业4.0”、“一带一路基建”四个领域。结合当今金融界最先进金融理念，以“并购投资”、“融资租赁”、“商业保理”、“商业银行”为主要经营方式，为市场提供“财富管理”、“资产管理”、“投资银行”、“家族信托”等业务。国信基金目前管理着多支国信系母基金，并成功完成对新天域资本、联想投资、松禾资本、同创伟业、九鼎投资、青云创投、德同资本、君丰资本、启明创投、达晨创投、天图创投、长江国泓、达泰资本、钟鼎创投等多只基金的投融资工作。</p>
					</div>
					<div class="blsjj">
						<h1>基本信息</h1>
						<ul>
							<li><div class="input_box">
									<span>企业名称：</span><input placeholder="酷乐吧有限公司" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>企业固定电话：</span><input placeholder="0755-87898899"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>法定代表人：</span><input placeholder="张小萌" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>营业执照注册号：</span><input placeholder="0995495493543545444"
										type="text" class="text_gary w300 fl" />
									<div class="checkbox">
										<input type="checkbox" />我是三证合一企业
									</div>
									<i></i>
								</div></li>
							<li><div class="input_box">
									<span>机构代码证号：</span><input placeholder="999343434" type="text"
										class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>税务登记号：</span><input placeholder="243254365787978677"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>财务登记证：</span><input placeholder="5656456465465"
										type="text" class="text_gary w600" />
								</div></li>
							<li>
								<div class="input_box">
									<span>注册省份地区：</span> <input placeholder="广东省" type="text"
										class="text_gary w160" /> <input placeholder="深圳市" type="text"
										class="text_gary w160" /> <input placeholder="南山区" type="text"
										class="text_gary w160" />
								</div>
							</li>

							<li><div class="input_box">
									<span>注册地址：</span><input placeholder="广东省深圳市南山区深态科技园"
										type="text" class="text_gary w600" />
								</div></li>
							<li><div class="input_box">
									<span>经营范围：</span><input placeholder="男装，女装，童装" type="text"
										class="text_gary w600" />
								</div></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- 底部jsp -->
	<jsp:include page="../../../common/bottom.jsp"/>
	<!-- 底部jsp -->
</body>
</html>