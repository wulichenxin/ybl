package cn.sunline.framework.controller.vo.v2;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 企业表实体类
 * 
 * @author guang
 * 
 */
public class ContractEnterpriseVo extends AbstractEntity {

	private static final long serialVersionUID = 70581823017359150L;
	/**
	 * 企业全称
	 */
	@JSONField(name = "enterprise_full_name")
	private String enterpriseFullName;
	/**
	 * 企业名简称
	 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;

	public String getEnterpriseFullName() {
		return enterpriseFullName;
	}

	public void setEnterpriseFullName(String enterpriseFullName) {
		this.enterpriseFullName = enterpriseFullName;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

}
