package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 区县实体类
 * @author MaiBenBen
 *
 */
public class AreaVo extends AbstractEntity {

	private static final long serialVersionUID = -5272652736292694728L;

	/*代码*/
	private String code;
	/*名称*/	
	private String name;
	/*所属地市*/
	private Long cityId;	
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
	@JSONField(name="city_id")
	public Long getCityId() {
		return cityId;
	}
	@JSONField(name="city_id")
	public void setCityId(Long cityId) {
		this.cityId = cityId;
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
