package cn.sunline.framework.controller.vo.v2;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金来源
 * 
 * @author guang
 * 
 */
public class FundSourceVo extends AbstractEntity {

	private static final long serialVersionUID = 6877279398797958780L;
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private String enterpriseId;
	/**
	 * 名称
	 */
	@JSONField(name = "name_")
	private String name;

	/**
	 * 描述
	 */
	@JSONField(name = "description_")
	private String description;

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
