package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 省份实体类
 * @author MaiBenBen
 *
 */
public class ProvinceVo extends AbstractEntity {
	
	private static final long serialVersionUID = -8550556964723563766L;
	/*代码*/
	private String code;
	/*名称*/	
	private String name;
	/*企业id*/
	private String enterpriseId;
	
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
	@JSONField(name="enterprise_id")
	public String getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}	
}
