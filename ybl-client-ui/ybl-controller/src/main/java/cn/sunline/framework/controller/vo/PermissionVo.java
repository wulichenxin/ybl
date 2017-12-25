package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 操作权限实体类
 * @author MaiBenBen
 *
 */
public class PermissionVo extends AbstractEntity {

	private static final long serialVersionUID = 3655906285203087726L;
	/*按钮id*/
	private String buttonId;
	/*按钮名称*/
	private String buttonName;
	/*企业id*/
	private Long enterpriseId;
	/*权限类型：base(基础类型)*/
	private String type;
	
	@JSONField(name="button_id")
	public String getButtonId() {
		return buttonId;
	}
	@JSONField(name="button_id")
	public void setButtonId(String buttonId) {
		this.buttonId = buttonId;
	}
	@JSONField(name="button_name")
	public String getButtonName() {
		return buttonName;
	}
	@JSONField(name="button_name")
	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	

}
