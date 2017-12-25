package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ProductConfigLoanMaterialVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1479831780038710293L;
	
	//主表id
	private Long businessId;
	//业务类型
	private String type;
	//代码
	private String code;
	//名称
	private String name;
	//备注
	private String remark;
	//企业id
	private Long enterpriseid;
	
	@JSONField(name="business_id")
	public Long getBusinessId() {
		return businessId;
	}
	@JSONField(name="business_id")
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
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
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseid() {
		return enterpriseid;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseid(Long enterpriseid) {
		this.enterpriseid = enterpriseid;
	}
	
	
	
	
}
