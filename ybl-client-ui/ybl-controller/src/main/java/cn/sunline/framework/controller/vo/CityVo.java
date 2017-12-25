package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 地市实体类
 * @author MaiBenBen
 *
 */
public class CityVo extends AbstractEntity {

	private static final long serialVersionUID = -5176029846357559197L;

	/*代码*/
	private String code;
	/*名称*/	
	private String name;
	/*所属省份*/
	private Long provinceId;
	/*企业id*/
	private Long enterpriseId;
	
	@JSONField(name="code_")
	public String getCode() {
		return code;
	}
	@JSONField(name="code_")
	public void setCode(String code) {
		this.code = code;
	}
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name="province_id")
	public Long getProvinceId() {
		return provinceId;
	}
	@JSONField(name="province_id")
	public void setProvinceId(Long provinceId) {
		this.provinceId = provinceId;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}	
}
