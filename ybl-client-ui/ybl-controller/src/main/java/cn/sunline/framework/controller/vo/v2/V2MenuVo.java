package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 
 * @author lpp
 *
 */
public class V2MenuVo  extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8753166618349105505L;
	/*菜单名称*/
	private String menuName;
	/*菜单编号*/
	private String menuCode;
	/*上级菜单编号*/
	private Long parentId;
	/*是否叶子节点*/
	private Integer isLeaf;
	/*菜单图标*/
	private String menuIcon;
	/*链接*/
	private String link;
	/*所属子系统*/
	private String subStystemCode;
	/*排序*/
	private Long sortNo;
	/*备注*/
	private String remark;
	/* 企业表id */
	private Long enterpriseId;
	
	private boolean checked;
	/**
	 * 菜单所属角色端口 1.融资方：financing 2.资金方：fund 3.核心企业：enterprise
	 */
	private String roleType;
	
	@JSONField(name = "role_type")
	public String getRoleType() {
		return roleType;
	}
	@JSONField(name = "role_type")
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
	@JSONField(name="name_")
	public String getMenuName() {
		return menuName;
	}
	@JSONField(name="name_")
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	@JSONField(name="code_")
	public String getMenuCode() {
		return menuCode;
	}
	@JSONField(name="code_")
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	@JSONField(name="parent_id")
	public Long getParentId() {
		return parentId;
	}
	@JSONField(name="parent_id")
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	@JSONField(name="is_leaf")
	public Integer getIsLeaf() {
		return isLeaf;
	}
	@JSONField(name="is_leaf")
	public void setIsLeaf(Integer isLeaf) {
		this.isLeaf = isLeaf;
	}
	@JSONField(name="icon_")
	public String getMenuIcon() {
		return menuIcon;
	}
	@JSONField(name="icon_")
	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}
	@JSONField(name="url_")
	public String getLink() {
		return link;
	}
	@JSONField(name="url_")
	public void setLink(String link) {
		this.link = link;
	}
	@JSONField(name="sub_system_code")
	public String getSubStystemCode() {
		return subStystemCode;
	}
	@JSONField(name="sub_system_code")
	public void setSubStystemCode(String subStystemCode) {
		this.subStystemCode = subStystemCode;
	}
	@JSONField(name="sort_")
	public Long getSortNo() {
		return sortNo;
	}
	@JSONField(name="sort_")
	public void setSortNo(Long sortNo) {
		this.sortNo = sortNo;
	}
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "MenuVo [menuName=" + menuName + ", menuCode=" + menuCode + ", parentId=" + parentId + ", isLeaf="
				+ isLeaf + ", menuIcon=" + menuIcon + ", link=" + link + ", subStystemCode=" + subStystemCode
				+ ", sortNo=" + sortNo + ", remark=" + remark + ", enterpriseId=" + enterpriseId + ", id=" + id
				+ ", createdTime=" + createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime
				+ ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1="
				+ attribute1 + ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4="
				+ attribute4 + ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7="
				+ attribute7 + ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10="
				+ attribute10 + ", rowNo=" + rowNo + "]";
	}
	
}
