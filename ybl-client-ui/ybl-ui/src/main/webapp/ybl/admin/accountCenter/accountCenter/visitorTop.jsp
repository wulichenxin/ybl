<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 未认证用户头部 -->
	<div class="head">
		<div class="top_head">
			<div class="logo">
				<a href="/loginController/login.htm"></a>
			</div>
			<div class="nav">
				<ul>
					<c:if test="${empty type}">
					
					</c:if>
					<li <c:if test="${step== 3 }"> class="now" </c:if>>
						<div class="navmenu">
							<a href="/indexController/login.htm">
								<span><spring:message code="sys.client.index"/><b></b></span><!-- 首页 -->
							</a>
						</div>
					</li>
					<li <c:if test="${step== 2 }"> class="now" </c:if>>
						<div class="navmenu">
							<a href="javascript:void(0);">
								<span><spring:message code="sys.client.business.introduce"/><b></b></span><!-- 业务介绍 -->
							</a>
						</div>
					</li>

					<li  <c:if test="${step== 1 }"> class="now" </c:if>>
						<div class="navmenu" >
							<a href="javascript:void(0);" >
								<span><spring:message code="sys.client.about.our"/><b></b></span> <!-- 关于我们 -->
							</a>
							<div class="navmenu-list none">
								<ul>
									<li><a href="/aboutUsController/companyIntroduction?position=top"><spring:message code="sys.client.company.intrduction"/><!-- 公司介绍 --></a></li>
									<li><a href="/aboutUsController/news?position=top"><spring:message code="sys.client.news"/><!-- 新闻资讯 --></a></li>
									<li><a href="/aboutUsController/notices?position=top"><spring:message code="sys.client.notice"/><!-- 公告 --></a></li>
									<li><a href="/aboutUsController/responsiblePage?position=top"><spring:message code="sys.client.disclaime"/><!-- 免责申明 --></a></li>
									<li><a href="/aboutUsController/recruit?position=top"><spring:message code="sys.client.talent.recruit"/><!-- 人才招聘 --></a></li>
									<li><a href="/aboutUsController/contact?position=top"><spring:message code="sys.client.link.us"/><!-- 联系我们 --></a></li>
								</ul>
							</div>
						</div>
					</li>
					<c:if test="${not empty user_session}">
						<li <c:if test="${step == 0 }">class="now"</c:if>>
							<div class="navmenu">
								<a href="/accountOverview/queryAccountOverview">
									<span><spring:message code="sys.client.account.center"/><b></b></span><!-- 账户中心 -->
								</a>
							</div>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			/* ABGIN我的菜单 */
			$('.navmenu').mouseover(function() {
				$(this).find('.navmenu-list').slideDown();
			}).mouseleave(function() {
				$(this).find('.navmenu-list').slideUp();
			});
			/* END我的菜单 */
		});
	</script>