package cn.sunline.framework.controller.vo.v4.supplier;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 首页待办
 */
public class IndexTodoVO {
	
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
	
	// 业务类型id(资金方：1.风控初审2.风控终审3.放款审核4.资产确权5.放款管理6.收款确认)
	@JSONField(name = "type")
	private Integer type;

	public Integer getResourceId() {
		return resourceId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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
