package com.bpm.framework.controller.v2;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.CompanyProfileVo;
import cn.sunline.framework.controller.vo.ContactVo;
import cn.sunline.framework.controller.vo.DevelopHistoryVo;
import cn.sunline.framework.controller.vo.FriendlyLinkVo;
import cn.sunline.framework.controller.vo.NewsVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PlatformNoticeVo;
import cn.sunline.framework.controller.vo.TeamIntroductionVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.BottomRedisCache;
import com.bpm.framework.controller.login.ProductSuccessCaseVo;
import com.bpm.framework.controller.login.V2ProductVo;
import com.bpm.framework.controller.login.V2VisitorVo;
import com.bpm.framework.controller.validcode.ValidCodeUtil;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * @Description:门户端controller,不开启session验证
 * @author:guotai
 * @time:2017年7月3日
 * @version:2.0.0
 */
@Controller
@RequestMapping({"/gatewayController"})
@ValidateSession(validate=false)
public class GatewayController extends AbstractController{
	
	private static final long serialVersionUID = -8795428817833154312L;
	
	/**
	 * @Description:关于我们页面（包括公司简介、发展历程、团队介绍）
	 * @param page
	 * @return 2.0关于我们页面
	 * @author: guotai
	 * @time:2017年7月3日
	 */
	@RequestMapping(value="/toAboutUs.htm")
	public String toAboutUs(PageVo page){
		companyIntroduction("index");
		//设置step为了控制页面导航时菜单样式问题
		ControllerUtils.getRequest().getParameter("step");
		ControllerUtils.getRequest().setAttribute("step", 3);
		//return "ybl/v2/admin/index/aboutUs";
		return "ybl4.0/admin/aboutUs/aboutUs";
	}
	
	/**
	 * 首页底部点击跳转
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/bottomToAboutUs.htm")
	public String bottomToAboutUs(String type){
		ControllerUtils.getRequest().setAttribute("type", type);
		return "ybl4.0/admin/aboutUs/aboutUs";
	}
	
	@RequestMapping("/error.htm")
	public String error(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String msg = super.getParameter("msg");
		request.setAttribute("msg", msg);
		return "ybl/v2/admin/index/error";
	}
	
	/**
	 * @Description:门户端首页
	 * @return 返回门户端首页地址
	 * @author: guotai
	 * @time:2017年7月4日
	 */
	@RequestMapping(value="/index.htm")
	public String toIndex(){
		//设置step为了控制页面导航时菜单样式问题
		ControllerUtils.getRequest().getParameter("step");
		ControllerUtils.getRequest().setAttribute("step", 0);
		return "ybl/v2/admin/index/index";
	}
	
	/**
	 * @Description:门户端页面业务介绍页面
	 * @return 门户端页面业务介绍页面
	 * @author: guotai
	 * @time:2017年7月4日
	 */
	@RequestMapping(value="/businessIntroduction.htm")
	public String toBusinessIntroduction(){
		//设置step为了控制页面导航时菜单样式问题
		ControllerUtils.getRequest().getParameter("step");
		ControllerUtils.getRequest().setAttribute("step", 2);
		return "ybl/v2/admin/index/BusinessIntroduction";
	}
	
	/**
	 * 跳转忘记密码页面 v2版本
	 * @return
	 */
	@RequestMapping(value = "/toForgetPasswordV2.htm")
	public String toForgetPasswordV2(){
		return "ybl/v2/admin/index/forgetPasswordV2";
		
	}
	/**
	 * 跳转登录页面
	 * @return
	 */
	@RequestMapping(value = "/toLogin.htm")
	public String toLogin(){
		return "ybl/v2/admin/index/login";
		
	}
	
	/**
	 * 跳转注册页面
	 * @return
	 */
	@RequestMapping(value = "/toRegister.htm")
	public String toRegister(){
		return "ybl/admin/index/register";
		
	}
	
	/**
	 * 跳转预约页面
	 * @return
	 */
	@RequestMapping(value = "/toOrder.htm")
	public String toOrder(String id){
		getRequest().setAttribute("id", id);
		return "ybl/v2/admin/index/order";
		
	}
	
	/**
	 * 公司信息简介
	 * @return CompanyProfileVo
	 * @throws
	 */
	@RequestMapping("companProfile")
	@ResponseBody
	public CompanyProfileVo companProfile(){
		Map<String,Object> companymap = new HashMap<String,Object>();
		CompanyProfileVo companyProfileVo=new CompanyProfileVo();
		companymap.put("paramter", companyProfileVo);
		companymap.put("page", new PageVo<>());
		companymap.put("sign", "queryCompanyProfileByCondition");//所调用的服务中的方法		
		ResBody resultCompany = TradeInvokeUtils.invoke("CompanyProfileManagement", companymap);					
		CompanyProfileVo company=null;
 		if(resultCompany.getSys()!=null){
			String status = resultCompany.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) resultCompany.getOutput();
				String records = output.getString("result");
				List<CompanyProfileVo> list = JsonUtils.toList(records,CompanyProfileVo.class);
				if (list != null && list.size() > 0) {
					company = list.get(0);
				}
			}			
		}
 		
 		return company;
	}
	
	/**
	 * 团队介绍
	 * @return List<TeamIntroductionVo>
	 * @throws
	 */
	@RequestMapping("teamIntroductionList")
	@ResponseBody
	public List<TeamIntroductionVo> teamIntroductionList(TeamIntroductionVo teamIntroductionVo){
		Map<String,Object> teamMap = new HashMap<String,Object>();
 		teamMap.put("paramter", teamIntroductionVo);
 		teamMap.put("page", new PageVo<>());
 		teamMap.put("sign", "queryTeamIntroductionByCondition");//所调用的服务中的方法		
		ResBody teamResult = TradeInvokeUtils.invoke("TeamIntroductionManagement", teamMap);										 
		List<TeamIntroductionVo> teamIntroductionList=null;
 		if(teamResult.getSys()!=null){
			String status = teamResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) teamResult.getOutput();
				String records = output.getString("result");
				teamIntroductionList=JsonUtils.toList(records,TeamIntroductionVo.class);
			}			
		}
 		return teamIntroductionList;
	}
	
	/**
	 * 发展历程
	 * @return DevelopHistoryVo
	 * @throws
	 */
	@RequestMapping("developHistory")
	@ResponseBody
	public DevelopHistoryVo developHistory(){
		Map<String,Object> developMap = new HashMap<String,Object>();
 		developMap.put("paramter", new DevelopHistoryVo());
 		developMap.put("page", new PageVo<>());
 		developMap.put("sign", "queryDevelopHistoryByCondition");//所调用的服务中的方法		
		ResBody developResult = TradeInvokeUtils.invoke("DevelopHistoryManagement", developMap);					
		DevelopHistoryVo developHistory=null;
 		if(developResult.getSys()!=null){
			String status = developResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) developResult.getOutput();
				String records = output.getString("result");
				List<DevelopHistoryVo> list = JsonUtils.toList(records,DevelopHistoryVo.class);
				if(list != null && list.size() > 0){
					developHistory=list.get(0);
				}
					
			}			
		}
 		return developHistory;
	}
	
	/**
	 * 新闻资讯
	 * @return PageVo<NewsVo>
	 * @throws
	 */
	@RequestMapping("newsList")
	@ResponseBody
	public PageVo<NewsVo> newsList(PageVo<NewsVo> pageVo){
		Map<String,Object> newsMap = new HashMap<String,Object>();
		NewsVo newsVo2 = new NewsVo();
		//只显示已发布的新闻资讯,并且是以推荐的
		newsVo2.setRecommend(1);
		newsVo2.setStatus("released");
 		newsMap.put("paramter", newsVo2);
 		newsMap.put("page", pageVo);
 		newsMap.put("sign", "queryNewsByCondition");//所调用的服务中的方法		
		ResBody newsResult = TradeInvokeUtils.invoke("NewsManagement", newsMap);					
		List<NewsVo> newsList=null;
 		if(newsResult.getSys()!=null){
			String status = newsResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) newsResult.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				pageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				newsList=JsonUtils.toList(records,NewsVo.class);
				pageVo.setRecords(newsList);
			}			
		}
		return pageVo;
	}
	
	/**
	 * 新闻资讯
	 * @return PageVo<NewsVo>
	 * @throws
	 */
	@RequestMapping("loadnewsListByAsync")
	public String loadnewsListByAsync(PageVo<NewsVo> pageVo){
		pageVo = newsList(pageVo);
		List<NewsVo> newslist = pageVo.getRecords();
		getRequest().setAttribute("newsList", newslist);
		getRequest().setAttribute("page", pageVo);
		return "ybl4.0/admin/aboutUs/newsTable";
	}
	
	/**
	 * 新闻资讯
	 * @return PageVo<NewsVo>
	 * @throws
	 */
	@RequestMapping("loadnoticesListByAsync")
	public String loadnoticesListByAsync(PageVo<PlatformNoticeVo> pageVo){
		pageVo = platformNoticeList(pageVo);
		List<PlatformNoticeVo> platformNoticeList = pageVo.getRecords();
		getRequest().setAttribute("platformNoticeList", platformNoticeList);
		getRequest().setAttribute("platformPage", pageVo);
		return "ybl4.0/admin/aboutUs/noticesTable";
	}
	
	/**
	 * 平台公告
	 * @return PageVo<PlatformNoticeVo>
	 * @throws
	 */
	@RequestMapping("platformNoticeList")
	@ResponseBody
	public PageVo<PlatformNoticeVo> platformNoticeList(PageVo<PlatformNoticeVo> pageVo){
		Map<String,Object> noticeMap = new HashMap<String,Object>();
		//只选择发布状态的通知公告
		PlatformNoticeVo platformNoticeVo2 = new PlatformNoticeVo();
		platformNoticeVo2.setStatus("released");
 		noticeMap.put("paramter", platformNoticeVo2);
 		noticeMap.put("page", pageVo);
 		noticeMap.put("sign", "queryPlatformNoticeByCondition");//所调用的服务中的方法		
		ResBody noticeResult = TradeInvokeUtils.invoke("PlatformNoticeManagement", noticeMap);					
		List<PlatformNoticeVo> platformNoticeList=null;
 		if(noticeResult.getSys()!=null){
			String status = noticeResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) noticeResult.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				pageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				platformNoticeList=JsonUtils.toList(records,PlatformNoticeVo.class);
				pageVo.setRecords(platformNoticeList);
			}			
		}
 		return pageVo;
	}
	
	/**
	 * 联系我们
	 * @return PageVo<ContactVo>
	 * @throws
	 */
	@RequestMapping("contactList")
	@ResponseBody
	public static PageVo<ContactVo> contactList(){
		Map<String,Object> contactMap = new HashMap<String,Object>();
 		contactMap.put("paramter", new ContactVo());
 		PageVo<ContactVo> contactPageVo = new PageVo<ContactVo>();
 		contactMap.put("page", contactPageVo);
 		contactMap.put("sign", "queryContactByCondition");//所调用的服务中的方法		
		ResBody contactResult = TradeInvokeUtils.invoke("ContactManagement", contactMap);					
		List<ContactVo> contactList=null;
 		if(contactResult.getSys()!=null){
			String status = contactResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) contactResult.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				contactPageVo=JSONObject.parseObject(jsonPage, PageVo.class);
				contactList=JsonUtils.toList(records,ContactVo.class);
				contactPageVo.setRecords(contactList);
			}			
		}
 		return contactPageVo;
	}
	
	@RequestMapping("companyIntroduction")
	public String companyIntroduction(@RequestParam(required=false) String position){
//		//公司简介信息
//		CompanyProfileVo company = companProfile();
// 		getRequest().setAttribute("companyProfile", company);
// 		//团队成员信息
// 		TeamIntroductionVo teamIntroductionVo = new TeamIntroductionVo();
// 		List<TeamIntroductionVo> teamIntroductionList = teamIntroductionList(teamIntroductionVo);
// 		getRequest().setAttribute("teamIntroductionList", teamIntroductionList);
// 		//发展历程信息
// 		DevelopHistoryVo developHistory = developHistory();
// 		getRequest().setAttribute("developHistory", developHistory);
//		getRequest().setAttribute("position", position);
//		return "ybl/v2/admin/index/companyIntroduction";
		return "ybl4.0/admin/aboutUs/companyIntroduction";
	}
	
	@RequestMapping("recruitment")
	public String recruitment(@RequestParam(required=false) String position){
		return "ybl4.0/admin/aboutUs/recruitment";
	}
	@RequestMapping("news")
	public String news(PageVo<NewsVo> pageVo,@RequestParam(required=false) String position){
		pageVo = newsList(pageVo);
 		getRequest().setAttribute("page", pageVo);
 		List<NewsVo> newsList = pageVo.getRecords();
 		getRequest().setAttribute("newsList", newsList);
		getRequest().setAttribute("position", position);
		//return "ybl/v2/admin/index/news";
		return "ybl4.0/admin/aboutUs/news";
	}
	
	@RequestMapping("notices")
	public String notices(PageVo<PlatformNoticeVo> pageVo,@RequestParam(required=false) String position){
		//平台公告信息
		pageVo = platformNoticeList(pageVo);
 		List<PlatformNoticeVo> platformNoticeList = pageVo.getRecords();
 		getRequest().setAttribute("platformPage", pageVo);
 		getRequest().setAttribute("platformNoticeList", platformNoticeList);
		getRequest().setAttribute("position", position);
		return "ybl4.0/admin/aboutUs/notices";
	}
	
	@RequestMapping("contact")
	public String contactPage(@RequestParam(required=false) String position){
		//-------------联系我们start
 		PageVo<ContactVo> contactPageVo = contactList();
 		List<ContactVo> contactList = contactPageVo.getRecords();
 		getRequest().setAttribute("contactPageVo", contactPageVo);
 		getRequest().setAttribute("contactList", contactList);
		getRequest().setAttribute("position", position);
		return "ybl/v2/admin/index/contactUs";
	}
	
	@RequestMapping("bottom")
	@ResponseBody
	public void getFriendLink(){
		List<FriendlyLinkVo> friendlyLinkList = BottomRedisCache.getFriendlyLinkList();
		List<ContactVo> contact = BottomRedisCache.getContact();
		getSession().setAttribute("friendLink", friendlyLinkList);
		getSession().setAttribute("contact", contact);
	}
	
	/**
	 * @Description:查看团队详情
	 * @return 团队详情页地址
	 * @author: guotai
	 * @time:2017年7月4日
	 */
	@RequestMapping("/teamDetail.htm/{id}")
	public String toTeamDetail(@PathVariable(value = "id")String id){
		HttpServletRequest request = ControllerUtils.getRequest();
		//根据成员id查询成员信息
		TeamIntroductionVo teamIntroductionVo = new TeamIntroductionVo();
		teamIntroductionVo.setId(Long.valueOf(id));
		List<TeamIntroductionVo> introductionList = teamIntroductionList(teamIntroductionVo);
		if(introductionList != null && introductionList.size() > 0){
			teamIntroductionVo = introductionList.get(0);
		}else{
			return "500";
		}
		request.setAttribute("memberDetail", teamIntroductionVo);
		return "ybl/v2/admin/index/memberDetail";
	}
	
	/**
	 * @Description:查看新闻详情
	 * @return 新闻详情页地址
	 * @author: guotai
	 * @time:2017年7月4日
	 */
	@RequestMapping("/newDetail.htm")
	public String toNewDetail(String id){
		HttpServletRequest request = ControllerUtils.getRequest();
		//根据新闻id查询新闻信息
		NewsVo currentNewsVo = new NewsVo();
		//上一篇新闻信息
		NewsVo prevNewsVo = null;
		//下一篇新闻信息
		NewsVo nextNewsVo = null;
		if(null == id) {
			return "ybl4.0/admin/doorl/index";
		}
		currentNewsVo.setId(Long.valueOf(id));
		//获取当前id的新闻信息
		Map<String,Object> newsMap = new HashMap<String,Object>();
		newsMap.put("paramter", id);
		newsMap.put("sign", "queryNewsDetailById");//所调用的服务中的方法		
		ResBody newsResult = TradeInvokeUtils.invoke("NewsManagement", newsMap);					
 		if(newsResult.getSys()!=null){
			String status = newsResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) newsResult.getOutput();
				JSONObject result = output.getJSONObject("result");
				currentNewsVo = JsonUtils.toObject(result.getString("currentNews"), NewsVo.class);
				if(currentNewsVo!=null){
					//增加浏览次数
					int viewed= currentNewsVo.getViewed();
					viewed++;
					currentNewsVo.setViewed(viewed);
					//通过id修改增加浏览次数后的新闻咨询
					Map<String,Object> newsUpdateMap = new HashMap<String,Object>();
					newsUpdateMap.put("paramter", currentNewsVo);
					newsUpdateMap.put("sign", "updateNewsById");//所调用的服务中的方法		
					TradeInvokeUtils.invoke("NewsManagement", newsUpdateMap);
				}
				if(result.getString("prevNews") != null){
					prevNewsVo = JsonUtils.toObject(result.getString("prevNews"), NewsVo.class);
				}
				if(result.getString("nextNews") != null){
					nextNewsVo = JsonUtils.toObject(result.getString("nextNews"), NewsVo.class);
				}
			}			
		}
		request.setAttribute("currentNews", currentNewsVo);
		request.setAttribute("prevNews", prevNewsVo);
		request.setAttribute("nextNews", nextNewsVo);
		return "ybl4.0/admin/aboutUs/newDetail";
	}
	
	/**
	 * @Description:查看公告详情
	 * @return 公告详情页地址
	 * @author: guotai
	 * @time:2017年7月4日
	 */
	@RequestMapping("/noticeDetail.htm")
	public String toNoticeDetail(String id){
		HttpServletRequest request = ControllerUtils.getRequest();
		//根据公告id查询公告信息
		PlatformNoticeVo currentNoticeVo = new PlatformNoticeVo();
		//上一篇公告信息
		PlatformNoticeVo prevNoticeVo = null;
		//下一篇公告信息
		PlatformNoticeVo nextNoticeVo = null;
		currentNoticeVo.setId(Long.valueOf(id));
		
		Map<String,Object> noticeMap = new HashMap<String,Object>();
 		noticeMap.put("paramter", id);
 		noticeMap.put("sign", "queryPlatformNoticeDetailById");//所调用的服务中的方法		
		ResBody noticeResult = TradeInvokeUtils.invoke("PlatformNoticeManagement", noticeMap);					
 		if(noticeResult.getSys()!=null){
			String status = noticeResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) noticeResult.getOutput();
				JSONObject result = output.getJSONObject("result");
				currentNoticeVo = JsonUtils.toObject(result.getString("currentNotice"), PlatformNoticeVo.class);
				if(currentNoticeVo!=null){
					//增加浏览次数
					int viewed= currentNoticeVo.getViewed();
					viewed++;
					currentNoticeVo.setViewed(viewed);
					//通过id修改增加浏览次数后的公告
					Map<String,Object> noticeUpdateMap = new HashMap<String,Object>();
					noticeUpdateMap.put("paramter", currentNoticeVo);
					noticeUpdateMap.put("sign", "updatePlatformNoticeById");//所调用的服务中的方法		
					TradeInvokeUtils.invoke("PlatformNoticeManagement", noticeUpdateMap);
				}
				if(result.getString("prevNotice") != null){
					prevNoticeVo = JsonUtils.toObject(result.getString("prevNotice"), PlatformNoticeVo.class);
				}
				if(result.getString("nextNotice") != null){
					nextNoticeVo = JsonUtils.toObject(result.getString("nextNotice"), PlatformNoticeVo.class);
				}
			}			
		}
 		request.setAttribute("currentNotice", currentNoticeVo);
		request.setAttribute("prevNotice", prevNoticeVo);
		request.setAttribute("nextNotice", nextNoticeVo);
		return "ybl4.0/admin/aboutUs/noticeDetail";
	}
	
	/**
	 * 查询产品信息
	 * @param pageVo
	 * @param map
	 */
	@RequestMapping(value = "/queryProduct.htm")
	public String queryProduct(V2ProductVo product,PageVo pageVo)
	{
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", product);
		product.setStatus("online");
		product.setHot("1");
		maps.put("page", pageVo);
		maps.put("sign", "queryProductByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ProductManage", maps);
		PageVo page=null;
		pageVo.setPageSize(5);
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		/*getRequest().setAttribute("name_",name_);
 		getRequest().setAttribute("type_",type_);
 		getRequest().setAttribute("status_",status_);
 		getRequest().setAttribute("product", product);*/
		//设置step为了控制页面导航时菜单样式问题
		ControllerUtils.getRequest().getParameter("step");
		ControllerUtils.getRequest().setAttribute("step", 1);
		getRequest().setAttribute("page", page);
        return "ybl/v2/admin/index/blzx";
	}
	
	/**
	 * 查询产品信息
	 * @param pageVo
	 * @param map
	 */
	@RequestMapping(value = "/queryProductList.htm")
	public String queryProductList(V2ProductVo product,PageVo pageVo)
	{
		Map<String, Object> maps = new HashMap<String, Object>();
		String webType = "";
		//产品类型
		if(null != product.getType())
		{
			//池保理
			if("pool".equals(product.getType()))
			{
				webType = "pool";
			}else if("just".equals(product.getType()))//正向保理
			{
				webType = "just";
			}
		}
		//融资金额
		if(null != product.getMinAmount())
		{
			if(product.getMinAmount().compareTo(new BigDecimal(100))==0)
			{
				webType = "100";
			}else if(product.getMinAmount().compareTo(new BigDecimal(500))==0)
			{
				webType = "500";
			}else if(product.getMinAmount().compareTo(new BigDecimal(1000))==0)
			{
				webType = "1000";
			}
		}
		//融资利率
		if(null != product.getMinRate())
		{
			if(product.getMinRate().compareTo(new BigDecimal(5))==0)
			{
				webType = "5";
			}else if(product.getMinRate().compareTo(new BigDecimal(10))==0)
			{
				webType = "10";
			}else if(product.getMinRate().compareTo(new BigDecimal(20))==0)
			{
				webType = "20";
			}
		}
		product.setStatus("online");
		maps.put("paramter", product);
		maps.put("page", pageVo);
		maps.put("sign", "queryProductByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ProductManage", maps);
		PageVo page=null;
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		/*getRequest().setAttribute("name_",name_);
 		getRequest().setAttribute("type_",type_);*/
		//页面样式回显
 		getRequest().setAttribute("queryParam", product);
        getRequest().setAttribute("webType", webType);
		getRequest().setAttribute("page", page);
        return "ybl/v2/admin/index/blzxList";
	}
	
	
	/**
	 * 查询产品信息
	 * @param pageVo
	 * @param map
	 */
	@RequestMapping(value = "/queryProductById.htm")
	public String queryProductById(V2ProductVo product,PageVo pageVo)
	{
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", product);
		maps.put("sign", "queryProductById");// 所调用的服务中的方法
		V2ProductVo productVo = new V2ProductVo();
		ResBody resultBody = TradeInvokeUtils.invoke("ProductManage", maps);
		PageVo page=null;
		if(resultBody.getSys()!=null){
			String status = resultBody.getSys().getStatus();
			String erortx = resultBody.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) resultBody.getOutput();
				JSONObject result = output.getJSONObject("result");
				// 1 融资主体
				if (StringUtils.isNotEmpty(result.getString("product"))) {
					productVo = JsonUtils.toObject(result.getString("product"), V2ProductVo.class);
				}
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+productVo);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
		//查询成功案例
		List<ProductSuccessCaseVo> list = queryProductSuccessCase(Integer.parseInt(product.getId().toString()));
 		getRequest().setAttribute("products", productVo);
 		getRequest().setAttribute("list", list);
		getRequest().setAttribute("page", page);
        return "ybl/v2/admin/index/blzxListDetaile";
	}
	@SuppressWarnings("unused")
	private List<ProductSuccessCaseVo> queryProductSuccessCase(Integer id)
	{
		List<ProductSuccessCaseVo> list = null;
		ProductSuccessCaseVo product = new ProductSuccessCaseVo();
		product.setProductId(id);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("parameter", product);
		maps.put("sign", "queryAllCase");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ProductSuccessCaseManagement", maps);
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				list= new ArrayList<>();
				list = JsonUtils.toList(records, ProductSuccessCaseVo.class);
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
		List<Map> list1 = null;
		return list;
	}
	/**
	 * 新增预约信息
	 * @return 
	 */
	@RequestMapping(value = "/insertVisitor")
	@ResponseBody
	public ControllerResponse insertVisitor(String productId,String name,String phone, String smsCode)
	{
		// 调用服务，进行数据查询
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if(!"S".equals(ValidCodeUtil.checkedValidCode(phone, smsCode))) {
			response.setInfo("验证码错误");
			return response;
		}
		V2VisitorVo parameters = new V2VisitorVo();
		parameters.setproductId(Long.parseLong(productId));
		parameters.setName(name);
		parameters.setCreatedTime(new Date());
		parameters.setLastUpdateTime(new Date());
		parameters.setRegisterTime(new Date());
		parameters.setOperationTime(new Date());
		parameters.setCreatedTime(new Date());
		parameters.setStatus("pending");
		parameters.setTelephone(phone);
		parameters.setLastUpdateTime(new Date());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("sign", "insertVisitorInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2VisitorsManagement", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setResponseType(ResponseType.SUCCESS);
					super.log.info("新增产品预约信息，调用insertVisitorInfo服务成功：" + erortx);
					return response;
				} else {
					response.setResponseType(ResponseType.ERROR);
					super.log.error("新增产品预约信息，调用insertVisitorInfo服务失败：" + erortx);
				}
			}
		} else {
			super.log.error("调用服务失败！");
		}
	return response;	
	}
}
