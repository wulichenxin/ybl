package com.bpm.framework.controller.customermanage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.AddressRedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AreaVo;
import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/myCustomerController"})
public class MyCustomerController extends AbstractController {

    /**
     *保理端我的客户管理controller
     */
    private static final long serialVersionUID = -2809460978768158852L;

  //查询所有签约客户
    @RequestMapping({" /myCustomer "})
    public String queryAll(String enterprise_name,String status_ ,String license_no, PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise2_id", user.getEnterpriseId().toString());
		map.put("license_no", license_no);
		map.put("enterprise_name", enterprise_name);
		map.put("status_", status_);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryAllEnterprise");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("CustomerManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				String[] record=records.split(",");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				if(record.length > 0){
					list = JsonUtils.toList(records, Map.class);
					getRequest().setAttribute("list", list);
				}
				super.log.error("根据条件查询企业调用queryAllEnterprise服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询企业调用queryAllEnterprise服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("enterprise_name", enterprise_name);
 		getRequest().setAttribute("license_no", license_no);
 		getRequest().setAttribute("status_", status_);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/customer/myCustomer";
    }
    
    //查询单个客户信息
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
				getRequest().setAttribute("enterprise", enterprise);
				
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
				
				super.log.error("根据条件查询企业调用queryEnterprise服务返回成功，信息："+records);
			}else{
				super.log.error("根据条件查询企业调用queryEnterprise服务返回失败，信息："+erortx);
				return null;
			}
		}
		
		//查询客户融资记录
		PageVo page=null;
		Map<String, Object> paramters = new HashMap<String,Object>();
		paramters.put("enterprise_id", id_);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", paramters);
		maps.put("page", pageVo);
		maps.put("sign", "queryFiancingByMemberId");//所调用的服务中的方法		
		ResBody results = TradeInvokeUtils.invoke("CustomerManagement", maps);	
		if(results.getSys()!=null){
			String statuss = results.getSys().getStatus();
			String erortxs = results.getSys().getErortx();//错误信息	
			if("S".equals(statuss)){//交易成功
				JSONObject outputs = (JSONObject) results.getOutput();
				String jsonPage=outputs.getString("page");
				String recordss = outputs.getString("result");
				String[] records=recordss.split(",");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				if(records.length > 0){
					list = JsonUtils.toList(recordss, Map.class);
					getRequest().setAttribute("list", list);
				}
				super.log.error("根据条件查询企业调用queryFiancingByMemberId服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询企业调用queryFiancingByMemberId服务返回失败，信息："+erortxs);
				return null;
			}			
		}
		
		
		return "ybl/admin/factor/customer/supplierDetails";
    
    }
    
    
    
    
}
