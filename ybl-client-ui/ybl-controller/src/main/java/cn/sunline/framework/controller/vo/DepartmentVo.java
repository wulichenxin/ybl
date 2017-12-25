package cn.sunline.framework.controller.vo;

import org.codehaus.jackson.annotate.JsonProperty;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 部门实体类
 * @author MaiBenBen
 *
 */
public class DepartmentVo extends AbstractEntity{
	
	private static final long serialVersionUID = 1L;
	
	/*父组织id*/	
	private Long parentId = -1L;
	/*部门编码*/	
	private String code;
	/*部门名称*/	
	private String name;
	/*是否叶子节点 。0 表示 非叶子节点,1 表示叶子节点*/	
	private int isLeaf;
	/*层级*/	
	private String hierarchy;
	
	private Long enterpriseId;
	
	@JSONField(name="parent_id")
	public Long getParentId() {
		return parentId;
	}
	@JSONField(name="parent_id")
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	@JSONField(name="code_")
	@JsonProperty("code")
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
	@JSONField(name="is_leaf")
	public int getIsLeaf() {
		return isLeaf;
	}
	@JSONField(name="is_leaf")
	public void setIsLeaf(int isLeaf) {
		this.isLeaf = isLeaf;
	}
	@JSONField(name="hierarchy_")
	public String getHierarchy() {
		return hierarchy;
	}
	@JSONField(name="hierarchy_")
	public void setHierarchy(String hierarchy) {
		this.hierarchy = hierarchy;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@Override
	public String toString() {
		return "DepartmentVo [parentId=" + parentId + ", code=" + code + ", name=" + name + ", isLeaf=" + isLeaf
				+ ", hierarchy=" + hierarchy + ", enterpriseId=" + enterpriseId + ", id=" + id + ", createdTime="
				+ createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy="
				+ lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1=" + attribute1
				+ ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4=" + attribute4
				+ ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7=" + attribute7
				+ ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10=" + attribute10
				+ ", rowNo=" + rowNo + "]";
	}
}
