<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/ybl/v2/admin/common/link.jsp"%>
<div class="v2_about_box">
			<h1><span></span>公司简介</h1>
			<div class="v2_about_lr">
				${companyProfile.content}
			</div>
		</div>
		<div class="v2_about_bg">
		<div class="v2_about_box">
			<h2><span></span>团队介绍</h2>
			<div class="v2_about_td">
				<ul>
				<c:forEach items="${teamIntroductionList}" var="entity">
					<li>
						<div class="v2_td_pic"><img class="teamImg" src="${entity.url}"/></div>
						<div class="v2_td_xx">
							<h2>${entity.name}</h2>
							<h3>${entity.position}</h3>
							<div style="width:800px; height:40px;text-overflow:ellipsis;white-space: nowrap; overflow:hidden; font-size:14px; color:#999;">
								${entity.desc}
							</div>
							<div class="v2_team_more">
								<a href="/gatewayController/teamDetail.htm/${entity.id }">更多</a>
							</div>
<%-- 							<c:if test="${fn:length(entity.desc) > 100 }"> --%>
<%-- 								${entity.desc} --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${fn:length(entity.desc) <= 100 }"> --%>
<%-- 								${entity.desc} --%>
<%-- 							</c:if> --%>
						</div>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
			</div>
		<div class="v2_about_box">
			<h1><span></span>背景介绍</h1>
			<div class="v2_about_lr">
			${companyProfile.background}
<!-- 				<p>深圳市国信股权投资基金管理有限公司是一家以私募基金、股权投资、财富管理为核心业务的综合金融服务机构。</p> -->
<!-- 				<p>国信基金管理团队拥有十余年国内私募股权投融资和海外资本市场的运作经验。我们不断吸纳来自于基金、法律、银行、证券等金融领域的精英人士加入我们，致力于打造优秀的基金项目管理团队和稳健的风险控制管理团队。我们拥有强大的项目资源平台、完善的风控法务平台、权威的项目评估系统、专业的财富管理系统以及卓越的客户服务体系。信赖我们，让财富不再“奢侈”。</p> -->
<!-- 				<p>国信基金牢牢把握当下金融形势，投资方向侧重于“新能源”、“新兴农业”、“工业4.0”、“一带一路基建”四个领域。结合当今金融界最先进金融理念，以“并购投资”、“融资租赁”、“商业保理”、“商业银行”为主要经营方式，为市场提供“财富管理”、“资产管理”、“投资银行”、“家族信托”等业务。国信基金目前管理着多支国信系母基金，并成功完成对新天域资本、联想投资、松禾资本、同创伟业、九鼎投资、青云创投、德同资本、君丰资本、启明创投、达晨创投、天图创投、长江国泓、达泰资本、钟鼎创投等多只基金的投融资工作。</p> -->
			</div>
		</div>
		<div class="v2_about_bg2">
		<div class="v2_about_box">
			<h2><span></span>发展历程</h2>
			<div class="v2_about_lr2">
				${developHistory.content }
			</div>
		</div>
			</div>