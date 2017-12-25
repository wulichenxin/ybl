package cn.sunline.framework.controller.vo;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 
 * @author 新
 *
 */
public class OperateRoleMenuVo extends AbstractEntity{
	
	private static final long serialVersionUID = -5821683722704747056L;
	
	private Long roleId;
	
	private List<Long> menuId;
	
	private Long enterpriseId;
	
	@JSONField(name="role_id")
	public Long getRoleId() {
		return roleId;
	}
	
	@JSONField(name="role_id")
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	@JSONField(name="menu_id")
	public List<Long> getMenuId() {
		return menuId;
	}
	@JSONField(name="menu_id")
	public void setMenuId(List<Long> menuId) {
		this.menuId = menuId;
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
		return "OperateRoleMenuVo [roleId=" + roleId + ", menuId=" + menuId + ", enterpriseId=" + enterpriseId + ", id="
				+ id + ", createdTime=" + createdTime + ", createdBy=" + createdBy + ", lastUpdateTime="
				+ lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable + ", sign=" + sign
				+ ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3=" + attribute3
				+ ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6=" + attribute6
				+ ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9=" + attribute9
				+ ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
	}
	
}
