
package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AttachmentVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1460370126003291593L;

	
	/**
	 * 业务数据id
	 */
	@JSONField(name = "resource_id")
	private Integer resourceId;
	
	
	/**
	 * 类型
	 */
	@JSONField(name = "type_")
	private String type;
	
	/**
	 * 附件url
	 */
	@JSONField(name = "url_")
	private String url;
	
	
	/**
	 * 原始名称（含扩展名）
	 */
	@JSONField(name = "old_name")
	private String oldName;
	
	
	/**
	 * 新名称（含扩展名）
	 */
	@JSONField(name = "new_name")
	private String newName;
	
	
	/**
	 * 扩展名
	 */
	@JSONField(name = "ext_name")
	private String extName;
	
	
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;

	@JSONField(name = "category_")
	private Long category;//大类：0-企业认证1-业务认证2-资方风控初审3-资方风控终审4-合同5-放款申请
	
	@JSONField(name = "file_size")
	private Long fileSize;//文件大小KB
	
	@JSONField(name="remark_")
	private String remark;//备注
	
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Long getCategory() {
		return category;
	}


	public void setCategory(Long category) {
		this.category = category;
	}


	public Long getFileSize() {
		return fileSize;
	}


	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}


	public Integer getResourceId() {
		return resourceId;
	}
	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public String getExtName() {
		return extName;
	}
	public void setExtName(String extName) {
		this.extName = extName;
	}
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
