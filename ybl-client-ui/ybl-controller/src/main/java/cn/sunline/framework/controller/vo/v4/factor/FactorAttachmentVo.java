
package cn.sunline.framework.controller.vo.v4.factor;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * attribute1 已启用，风控措施名称
 * @author pc
 *
 */
public class FactorAttachmentVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1460370126003291593L;

	@JSONField(name = "id_")
	protected Long id_; //主键id
	/**
	 * 业务数据id
	 */
	@JSONField(name = "resource_id")
	private Integer resource_id;
	
	
	/**
	 * 类型
	 */
	@JSONField(name = "type_")
	private String type_;
	
	/**
	 * 附件url
	 */
	@JSONField(name = "url_")
	private String url_;
	
	
	/**
	 * 原始名称（含扩展名）
	 */
	@JSONField(name = "old_name")
	private String old_name;
	
	
	/**
	 * 新名称（含扩展名）
	 */
	@JSONField(name = "new_name")
	private String new_name;
	
	
	/**
	 * 扩展名
	 */
	@JSONField(name = "ext_name")
	private String ext_name;
	
	
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterprise_id;

	@JSONField(name = "category_")
	private Long category_;//大类：0-企业认证1-业务认证2-资方风控初审3-资方风控终审4-合同5-放款申请
	
	@JSONField(name = "file_size")
	private Long file_size;//文件大小KB
	
	@JSONField(name="remark_")
	private String remark_;//备注
	

	public Long getCategory_() {
		return category_;
	}


	public void setCategory_(Long category_) {
		this.category_ = category_;
	}


	public Long getFile_size() {
		return file_size;
	}


	public void setFile_size(Long file_size) {
		this.file_size = file_size;
	}


	public Long getId_() {
		return id_;
	}


	public void setId_(Long id_) {
		this.id_ = id_;
	}


	public String getRemark_() {
		return remark_;
	}


	public void setRemark_(String remark_) {
		this.remark_ = remark_;
	}


	public Integer getResource_id() {
		return resource_id;
	}


	public void setBusiness_id(Integer resource_id) {
		this.resource_id = resource_id;
	}


	public String getType_() {
		return type_;
	}


	public void setType_(String type_) {
		this.type_ = type_;
	}


	public String getUrl_() {
		return url_;
	}


	public void setUrl_(String url_) {
		this.url_ = url_;
	}


	public String getOld_name() {
		return old_name;
	}


	public void setOld_name(String old_name) {
		this.old_name = old_name;
	}


	public String getNew_name() {
		return new_name;
	}


	public void setNew_name(String new_name) {
		this.new_name = new_name;
	}


	public String getExt_name() {
		return ext_name;
	}


	public void setExt_name(String ext_name) {
		this.ext_name = ext_name;
	}


	public Long getEnterprise_id() {
		return enterprise_id;
	}


	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
