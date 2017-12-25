package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class RoleMenuVo extends AbstractEntity{
	
	private static final long serialVersionUID = -5821683722704747056L;
	
	private Long roleId;
	private Long menuId;
	private String menulist;
	
	
	public String getMenulist() {
		return menulist;
	}
	
	public void setMenulist(String menulist) {
		this.menulist = menulist;
	}
	
	@JSONField(name="role_id")
	public Long getRoleId() {
		return roleId;
	}
	
	@JSONField(name="role_id")
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	@JSONField(name="menu_id")
	public Long getMenuId() {
		return menuId;
	}
	@JSONField(name="menu_id")
	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}
	
}
