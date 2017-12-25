package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 银行基础信息
 * @author guang
 *
 */
public class BankVo {

	@JSONField(name = "id_")
	private Long id;
	
	/**
	 * 银行名称
	 */
	@JSONField(name = "name_")
	private String name;
	
	/**
	 * 银行编码
	 */
	@JSONField(name = "code_")
	private String code;
	
	/**
	 * 银行图片
	 */
	@JSONField(name = "image_url")
	private String imageUrl;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
}
