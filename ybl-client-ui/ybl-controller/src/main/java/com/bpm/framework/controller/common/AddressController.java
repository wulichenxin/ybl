package com.bpm.framework.controller.common;

import java.util.ArrayList;
import java.util.List;

import org.apache.xmlbeans.impl.xb.ltgfmt.Code;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;

import cn.sunline.framework.controller.vo.AreaVo;
import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.ProvinceVo;

/**
 * 省市区controller
 * 
 * @author MaiBenBen
 *
 */
@Controller
@RequestMapping({ "/address" })
public class AddressController extends AbstractController {

	private static final long serialVersionUID = -3847866205322102085L;

	/**
	 * 获取所有省份数据
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/province/queryAllProvince")
	@ResponseBody
	public List<ProvinceVo> queryAllProvince() {
		List<ProvinceVo> provinceList = AddressRedisCache.getProvinceList();
		if (CollectionUtils.isEmpty(provinceList)) {
			return null;
		} else {
			return provinceList;
		}
	}

	/**
	 * 根据省份code获取省份信息
	 */
	@RequestMapping(value = "/province/findProvinceByCode")
	@ResponseBody
	public ProvinceVo findProvinceByCode(Long provinceId) {
		ProvinceVo provinceEntry = null;
		List<ProvinceVo> list = queryAllProvince();
		if (CollectionUtils.isEmpty(list)) {
			return null;
		} else {
			for (ProvinceVo provice : list) {
				if (provice.getId().longValue()==provinceId) {
					provinceEntry = provice;
					break;
				}
			}
			return provinceEntry;
		}
	}

	/**
	 * 依据省份id获取地市集合.
	 */
	@RequestMapping(value = "/city/queryCityByProvinceId")
	@ResponseBody
	public List<CityVo> queryCityByProvinceId(Long provinceId) {
		List<CityVo> allCityList = AddressRedisCache.getCityList();
		List<CityVo> cityList = new ArrayList<CityVo>();
		if (CollectionUtils.isEmpty(allCityList)) {
			return null;
		} else {
			for (CityVo city : allCityList) {
				if (city.getProvinceId().longValue()==provinceId.longValue()) {
					cityList.add(city);
				}
			}
			return cityList;
		}
	}

	/**
	 * 依据地市ID获取区县信息.
	 */
	@RequestMapping(value = "/area/queryAreaBycityId")
	@ResponseBody
	public List<AreaVo> queryAreaBycityId(Long cityId) {
		List<AreaVo> allAreaList = AddressRedisCache.getAreaList();
		List<AreaVo> areaList = new ArrayList<AreaVo>();
		if (CollectionUtils.isEmpty(allAreaList)) {
			return null;
		} else {
			for (AreaVo area : allAreaList) {
				if (area.getCityId().longValue()==cityId.longValue()) {
					areaList.add(area);
				}
			}
			return areaList;
		}
	}

	/**
	 * 根据省ID和市id查询市信息
	 */
	@RequestMapping(value = "/city/queryCityBycityCode")
	@ResponseBody
	public CityVo queryCityBycityCode(Long provinceId, Long id) {
		CityVo CityVo = new CityVo();
		List<CityVo> listCity = queryCityByProvinceId(provinceId);
		if (CollectionUtils.isEmpty(listCity)) {
			return null;
		}
		for (CityVo city : listCity) {
			if (city.getId().longValue()==id.longValue()) {
				CityVo = city;
			}
		}
		return CityVo;
	}

	/**
	 * 依据市ID和区id获区信息.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/area/queryAreaByAreaCode")
	@ResponseBody
	public AreaVo queryAreaByAreaCode(Long cityId, Long id) {
		AreaVo areaEntry = new AreaVo();
		List<AreaVo> areaList = queryAreaBycityId(cityId);
		if (CollectionUtils.isEmpty(areaList)) {
			return null;
		}
		for (AreaVo area : areaList) {
			if (area.getId().longValue()==id.longValue()) {
				areaEntry = area;
			}
		}
		return areaEntry;
	}

	/**
	 * 获取拼接后的全路径地址
	 */
	@RequestMapping(value = "/splitAddress")
	@ResponseBody
	public String splitAddress(Long provinceCode, Long cityCode, Long areaCode, String address) {
		String provinceName = "";
		String cityName = "";
		String regionName = "";

		if (provinceCode!=null && provinceCode>0) {
			ProvinceVo provinceEntry = findProvinceByCode(provinceCode);
			if (null != provinceEntry) {
				provinceName = provinceEntry.getName();
			}
		}

		if (provinceCode!=null && provinceCode>0 && cityCode!=null && cityCode>0) {
			CityVo CityVo = queryCityBycityCode(provinceCode, cityCode);
			if (null != CityVo) {
				cityName = CityVo.getName();
			}
		}

		if (cityCode!=null && cityCode>0 && areaCode!=null && areaCode>0) {
			AreaVo districtEntry = queryAreaByAreaCode(cityCode, areaCode);
			if (null != districtEntry) {
				regionName = districtEntry.getName();
			}
		}

		String fullAddress = provinceName +"-" + cityName +"-" + regionName  +"-"+ address;
		return fullAddress;
	}
}
