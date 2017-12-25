package cn.sunline.framework.controller.vo.v4.supplier;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 首页预警
 */
public class IndexEarlyWarningVO {
	
	// 资源id
	@JSONField(name = "resource_id")
	private Integer resourceId;
	
	// 类别
	@JSONField(name = "category")
	private String category;
	
	// 内容
	@JSONField(name = "content")
	private String content;
	
	// 时间
	@JSONField(name = "date_time")
	private Date dateTime;
	
	// 业务id（融资方）
	@JSONField(name = "business_id")
	private Integer businessId;

	public Integer getResourceId() {
		return resourceId;
	}

	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public Integer getBusinessId() {
		return businessId;
	}

	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}

	
}
