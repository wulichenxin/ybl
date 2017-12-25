package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 2.0用户端角色实体类
 * @author lenovo
 *
 */
public class V2RoleVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 494029505400803692L;
	/*角色码（唯一索引）*/	
	private String code;
	/*角色名*/	
	private String name;
	/*角色功能描述*/	
	private String description;
	/*角色类型*/
	private String type;
	/*角色-用户类型：类型-融资方-financing;资金方-fund;核心企业-enterprise;*/
	private String roleType;
	
	/**
	 *企业id
	 */
	private Long enterpriseId;
	
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
	@JSONField(name="description_")
	public String getDescription() {
		return description;
	}
	@JSONField(name="description_")
	public void setDescription(String description) {
		this.description = description;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="role_type")
	public String getRoleType() {
		return roleType;
	}
	@JSONField(name="role_type")
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	@Override
	public String toString() {
		return "RoleVo [code=" + code + ", name=" + name + ", description=" + description + ", enterpriseId="
				+ enterpriseId + ", id=" + id + ", createdTime=" + createdTime + ", createdBy=" + createdBy
				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo +"roleType="+roleType+ "]";
	}
}
