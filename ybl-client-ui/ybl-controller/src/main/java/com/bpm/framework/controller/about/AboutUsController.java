package com.bpm.framework.controller.about;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.common.AddressRedisCache;
import com.bpm.framework.controller.common.BottomRedisCache;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.CompanyProfileVo;
import cn.sunline.framework.controller.vo.ContactVo;
import cn.sunline.framework.controller.vo.DevelopHistoryVo;
import cn.sunline.framework.controller.vo.FriendlyLinkVo;
import cn.sunline.framework.controller.vo.NewsVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PlatformNoticeVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.RecruitVo;
import cn.sunline.framework.controller.vo.ResponsibleVo;
import cn.sunline.framework.controller.vo.TeamIntroductionVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/aboutUsController"})
@ValidateSession(validate=false)
public class AboutUsController extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8795428817833154312L;
	
	@RequestMapping(value="/toAboutUs")
	public String toAboutUs(PageVo page){
/*		//公司简介信息
		CompanyProfileVo company = companProfile();
 		getRequest().setAttribute("companyProfile", company);
 		//团队成员信息
 		List<TeamIntroductionVo> teamIntroductionList = teamIntroductionList();
 		getRequest().setAttribute("teamIntroductionList", teamIntroductionList);
 		//发展历程信息
 		DevelopHistoryVo developHistory = developHistory();
 		getRequest().setAttribute("developHistory", developHistory);
 		//新闻资讯信息
 		PageVo<NewsVo> pageVo = newsList(page);
 		getRequest().setAttribute("page", pageVo);
 		List<NewsVo> newsList = pageVo.getRecords();
 		getRequest().setAttribute("newsList", newsList);
 		//免责声明信息
 		ResponsibleVo responsible = responsible();
 		getRequest().setAttribute("responsible", responsible);
 		//平台公告信息
 		PageVo<PlatformNoticeVo> platformPage = platformNoticeList(page);
 		List<PlatformNoticeVo> platformNoticeList = platformPage.getRecords();
 		getRequest().setAttribute("platformPage", platformPage);
 		getRequest().setAttribute("platformNoticeList", platformNoticeList);
 		//------------人才招聘start
 		PageVo<RecruitVo> recruitPage = recruitList();
 		List<RecruitVo> recruitReleaseList = recruitPage.getRecords();
 		getRequest().setAttribute("recruitPage", recruitPage);
 		getRequest().setAttribute("recruitList", recruitReleaseList);
 		//-------------人才招聘end
 		//-------------联系我们start
 		PageVo<ContactVo> contactPageVo = contactList();
 		List<ContactVo> contactList = contactPageVo.getRecords();
 		getRequest().setAttribute("contactPageVo", contactPageVo);
 		getRequest().setAttribute("contactList", contactList);
 		//-------------联系我们end
 		 */
		companyIntroduction("index");
		return "ybl/admin/index/about";
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
	public List<TeamIntroductionVo> teamIntroductionList(){
		Map<String,Object> teamMap = new HashMap<String,Object>();
 		teamMap.put("paramter", new TeamIntroductionVo());
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
 		newsMap.put("paramter", new NewsVo());
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
				//只显示已发布状态的新闻资讯
				List<NewsVo> list = new ArrayList<>();
				if(newsList.size() > 0){
					for (NewsVo newsVo : newsList) {
						if(("released").equals(newsVo.getStatus())){
							list.add(newsVo);
						}
					}
				}
				pageVo.setRecords(list);
				pageVo.setRecordCount(list.size());
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
		return "ybl/admin/news/newsTable";
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
		return "ybl/admin/notices/noticesTable";
	}
	
	/**
	 * 免责声明
	 * @return ResponsibleVo
	 * @throws
	 */
	@RequestMapping("responsible")
	@ResponseBody
	public ResponsibleVo responsible(){
		Map<String,Object> responsiblemap = new HashMap<String,Object>();
 		responsiblemap.put("paramter", new ResponsibleVo());
 		responsiblemap.put("page", new PageVo<>());
 		responsiblemap.put("sign", "queryResponsibleByCondition");//所调用的服务中的方法		
		ResBody responsibleResult = TradeInvokeUtils.invoke("ResponsibleManagement", responsiblemap);					
		ResponsibleVo responsible=null;
 		if(responsibleResult.getSys()!=null){
			String status = responsibleResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) responsibleResult.getOutput();
				String records = output.getString("result");
				List<ResponsibleVo> list = JsonUtils.toList(records,ResponsibleVo.class);
				if(list != null && list.size() > 0){
					responsible=list.get(0);
				}
			}			
		}
 		return responsible;
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
 		noticeMap.put("paramter", new PlatformNoticeVo());
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
				//只显示已发布状态的公告
				List<PlatformNoticeVo> list = new ArrayList<>();
				if(platformNoticeList.size() > 0){
					for (PlatformNoticeVo platformNoticeVo : platformNoticeList) {
						if(("released").equals(platformNoticeVo.getStatus())){
							list.add(platformNoticeVo);
						}
					}
				}
				pageVo.setRecords(list);
				pageVo.setRecordCount(list.size());
			}			
		}
 		return pageVo;
	}
	
	/**
	 * 人才招聘
	 * @return PageVo<RecruitVo>
	 * @throws
	 */
	@RequestMapping("recruitList")
	@ResponseBody
	public PageVo<RecruitVo> recruitList(){
		Map<String,Object> recruitMap = new HashMap<String,Object>();
 		recruitMap.put("sign", "queryRecruitByCondition");
 		PageVo<RecruitVo> recruitPage = new PageVo<RecruitVo>();
 		recruitMap.put("page", recruitPage);
 		recruitMap.put("paramter", new RecruitVo());
 		ResBody recruitResult = TradeInvokeUtils.invoke("RecruitManagement", recruitMap);
 		List<RecruitVo> recruitList = new ArrayList<RecruitVo>();
 		if(recruitResult.getSys()!=null){
			String status = recruitResult.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) recruitResult.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				recruitPage=JSONObject.parseObject(jsonPage, PageVo.class);
				recruitList=JsonUtils.toList(records,RecruitVo.class);
				List<RecruitVo> recruitReleaseList = new ArrayList<RecruitVo>();
				for (RecruitVo recruitVo : recruitList) {
					//选择已发布的职位信息
					if (recruitVo.getReleaseDate() != null) {
						Long provinceId = recruitVo.getProvinceId();
						Long cityId = recruitVo.getCityId();
						List<ProvinceVo> provinceList = AddressRedisCache.getProvinceList();
						for (ProvinceVo provinceVo : provinceList) {
							if(provinceVo.getId().equals(provinceId)){
								//把所在省份名称塞到attribute1中
								recruitVo.setAttribute1(provinceVo.getName());
							}
						}
						List<CityVo> cityList = AddressRedisCache.getCityList();
						for (CityVo cityVo : cityList) {
							if(cityVo.getId().equals(cityId)){
								//把所在省份名称塞到attribute2中
								recruitVo.setAttribute2(cityVo.getName());
							}
						}
						recruitReleaseList.add(recruitVo);
					}
				}
				recruitPage.setRecords(recruitReleaseList);
			}			
		}
 		return recruitPage;
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
		//公司简介信息
		CompanyProfileVo company = companProfile();
 		getRequest().setAttribute("companyProfile", company);
 		//团队成员信息
 		List<TeamIntroductionVo> teamIntroductionList = teamIntroductionList();
 		getRequest().setAttribute("teamIntroductionList", teamIntroductionList);
 		//发展历程信息
 		DevelopHistoryVo developHistory = developHistory();
 		getRequest().setAttribute("developHistory", developHistory);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/companyIntroduction";
	}
	
	@RequestMapping("news")
	public String news(@RequestParam(required=false) String position){
		PageVo<NewsVo> pageVo = new PageVo<>();
		pageVo = newsList(pageVo);
 		getRequest().setAttribute("page", pageVo);
 		List<NewsVo> newsList = pageVo.getRecords();
 		getRequest().setAttribute("newsList", newsList);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/news";
	}
	
	@RequestMapping("responsiblePage")
	public String responsiblePage(@RequestParam(required=false) String position){
		//免责声明信息
 		ResponsibleVo responsible = responsible();
 		getRequest().setAttribute("responsible", responsible);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/responsible";
	}
	
	@RequestMapping("notices")
	public String notices(@RequestParam(required=false) String position){
		PageVo<PlatformNoticeVo> pageVo = new PageVo<>();
		//平台公告信息
 		PageVo<PlatformNoticeVo> platformPage = platformNoticeList(pageVo);
 		List<PlatformNoticeVo> platformNoticeList = platformPage.getRecords();
 		getRequest().setAttribute("platformPage", platformPage);
 		getRequest().setAttribute("platformNoticeList", platformNoticeList);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/notices";
	}
	
	@RequestMapping("recruit")
	public String recruitPage(@RequestParam(required=false) String position){
		//平台公告信息
		//------------人才招聘start
 		PageVo<RecruitVo> recruitPage = recruitList();
 		List<RecruitVo> recruitReleaseList = recruitPage.getRecords();
 		getRequest().setAttribute("recruitPage", recruitPage);
 		getRequest().setAttribute("recruitList", recruitReleaseList);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/recruit";
	}
	
	@RequestMapping("contact")
	public String contactPage(@RequestParam(required=false) String position){
		//-------------联系我们start
 		PageVo<ContactVo> contactPageVo = contactList();
 		List<ContactVo> contactList = contactPageVo.getRecords();
 		getRequest().setAttribute("contactPageVo", contactPageVo);
 		getRequest().setAttribute("contactList", contactList);
		getRequest().setAttribute("position", position);
		return "ybl/admin/aboutUs/contactUs";
	}
	
	@RequestMapping("bottom")
	@ResponseBody
	public void getFriendLink(){
		List<FriendlyLinkVo> friendlyLinkList = BottomRedisCache.getFriendlyLinkList();
		List<ContactVo> contact = BottomRedisCache.getContact();
		getSession().setAttribute("friendLink", friendlyLinkList);
		getSession().setAttribute("contact", contact);
	}
	
}
