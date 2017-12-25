package com.bpm.framework.controller.fileupload;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 附件表实体类
 * @author MaiBenBen
 *
 */
public class AttachmentVo extends AbstractEntity {
	
	private static final long serialVersionUID = 5994896924903112820L;
	
private Long resourceId;//业务数据id
	
	private String type;//类型

	private String url;//附件url
	
	private String oldName;// 文件原始名称
	
	private String newName;// 文件存在服务器上的名称
	
	private String extName;// 文件扩展名
	
	private Long enterpriseId;//企业id
	
	@JSONField(name="file_size")
	private Long fileSize;//文件大小
	
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	@JSONField(name="resource_id")
	public Long getResourceId() {
		return resourceId;
	}
	@JSONField(name="resource_id")
	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="url_")
	public String getUrl() {
		return url;
	}
	@JSONField(name="url_")
	public void setUrl(String url) {
		this.url = url;
	}
	@JSONField(name="old_name")
	public String getOldName() {
		return oldName;
	}
	@JSONField(name="old_name")
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	@JSONField(name="new_name")
	public String getNewName() {
		return newName;
	}
	@JSONField(name="new_name")
	public void setNewName(String newName) {
		this.newName = newName;
	}
	@JSONField(name="ext_name")
	public String getExtName() {
		return extName;
	}
	@JSONField(name="ext_name")
	public void setExtName(String extName) {
		this.extName = extName;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
}