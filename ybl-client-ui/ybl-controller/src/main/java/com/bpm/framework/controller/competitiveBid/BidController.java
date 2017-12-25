package com.bpm.framework.controller.competitiveBid;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.AddressRedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AreaVo;
import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.LoanSignBidVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/bidController"})
public class BidController extends AbstractController {

    /**
     *
     */
    private static final long serialVersionUID = -2809460978768158852L;

  //查询所有标的
    @RequestMapping({" /queryAllLoanSignBid "})
    public String queryAll(String name_,String amount_,String loan_period , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("status_", "biding");//查询竞标中的标的
		map.put("name_", name_);
		map.put("amount_", amount_);
		map.put("loan_period", loan_period);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryAllLoanSignBid");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("BidManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
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
				super.log.error("根据条件查询企业调用queryAllLoanSignBid服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询企业调用queryAllLoanSignBid服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name_", name_);
 		getRequest().setAttribute("loan_period", loan_period);
 		getRequest().setAttribute("amount_", amount_);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/bid/toBid";
    }
    
    //竞投管理
    @RequestMapping({"/investManage "})
    public String queryMyInvest(String name_,String contend_status , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
    	Map<String,String> map = new HashMap<String,String>();
		map.put("name_", name_);
		map.put("contend_status", contend_status);
		map.put("enterprise_id",user.getEnterpriseId().toString() );
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryAllLoanSignBidManage");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("BidManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
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
				super.log.error("根据条件查询企业调用queryAllLoanSignBid服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询企业调用queryAllLoanSignBid服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name_", name_);
 		getRequest().setAttribute("contend_status", contend_status);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/bid/bidManage";
    }
    
    
    /**
     *参与竞标
     * 
     */
    @RequestMapping({"/insertBid"})
    @ResponseBody
    public ControllerResponse insertProduct(LoanSignBidVo loanSignBid, String count){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("请登录后操作");
			return response;
		}
		if(Integer.parseInt(count) > 0){
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("不能重复竞投");
			return response;
		}

    	loanSignBid.setMemberId(user.getId());//投标会员取当前登录人id
    	loanSignBid.setEnterpriseId(user.getEnterpriseId());//投标企业取当前登录人的企业id
    	loanSignBid.setStatus("biding");
    	ControllerUtils.setWho(loanSignBid);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", loanSignBid);
		map.put("sign", "insertLoanSignBid");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("BidManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("新增竞标服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("新增竞标服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
  //查询核心企业信息
    @RequestMapping({"/queryEnterprise"})
    public String queryEnterprise(String id_ , PageVo pageVo){
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		
		Map<String, Object> paramter = new HashMap<String,Object>();
		//(1)判断必要参数
		if(id_.isEmpty()){			
			super.log.error("查询企业信息时，企业id为空！");
			return null;
		}
		paramter.put("id_", id_);
		//调用服务，进行企业认证表数据查询	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("sign", "queryEnterprise");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("CustomerManagement", map);	
		
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				
				Map<String,Object>	enterprise = JsonUtils.toMap(records);
				
				//获取省份名称
				ProvinceVo provinceEntry = null;
				List<ProvinceVo> list = AddressRedisCache.getProvinceList();
				if (CollectionUtils.isNotEmpty(list)) {
					for (ProvinceVo provice : list) {
						if (provice.getId().longValue()==Long.valueOf(enterprise.get("province_id").toString())) {
							provinceEntry = provice;
							getRequest().setAttribute("provinceName",provinceEntry.getName());
							break;
						}
					}
				}
				
				//获取城市名称
				CityVo cityEntry = null;
				List<CityVo> cityList = AddressRedisCache.getCityList();
				if (CollectionUtils.isNotEmpty(cityList)) {
					for (CityVo city : cityList) {
						if (city.getId().longValue()==Long.valueOf(enterprise.get("city_id").toString())) {
							cityEntry = city;
							getRequest().setAttribute("cityName",cityEntry.getName());
							break;
						}
					}
				}
				
				//获取区县名称
				AreaVo areaEntry = null;
				List<AreaVo> areaList = AddressRedisCache.getAreaList();
				if (CollectionUtils.isNotEmpty(areaList)) {
					for (AreaVo area : areaList) {
						if (area.getId().longValue()==Long.valueOf(enterprise.get("area_id").toString())) {
							areaEntry = area;
							getRequest().setAttribute("areaName",areaEntry.getName());
							break;
						}
							
					}
				}
				
				getRequest().setAttribute("enterprise", enterprise);
				super.log.error("根据条件查询企业调用queryEnterprise服务返回成功，信息："+records);
			}else{
				super.log.error("根据条件查询企业调用queryEnterprise服务返回失败，信息："+erortx);
				return null;
			}
		}
		
		return "ybl/admin/factor/bid/enterpriseIntroduction";
    }
}
