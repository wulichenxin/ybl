package cn.sunline.framework.controller.vo.v4;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ContractTemplateVO extends AbstractEntity{

	private static final long serialVersionUID = -327795095349561522L;
	/**
	 * 模板名称
	 */
	@JSONField(name="template_name")
	private String templateName;

	/**
	 * 模板类型：1、单笔合同，2、额度合同
	 */
	@JSONField(name="template_type")
    private String templateType;

    /**
     * 模板内容
     */
	@JSONField(name="template_content")
    private String templateContent;
	
	/**
     * 备注
     */
	@JSONField(name="remark")
    private String remark;
	
	/**
     * 开始时间
     */
	@JSONField(format = "yyyy-MM-dd HH:mm:ss", name="start_time")
    private Date startTime;
	
	/**
     * 结束时间
     */
	@JSONField(format = "yyyy-MM-dd HH:mm:ss", name="end_time")
    private Date endTime;
	
	/**
     * 因为父类的enable不满足查询的要求
     */
	@JSONField(name="enable_child")
    private String enableChild;

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName == null ? null : templateName.trim();
    }

    public String getTemplateType() {
        return templateType;
    }

    public void setTemplateType(String templateType) {
        this.templateType = templateType;
    }
    
    public String getTemplateContent() {
        return templateContent;
    }

    public void setTemplateContent(String templateContent) {
        this.templateContent = templateContent == null ? null : templateContent.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
    
    public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getEnableChild() {
		return enableChild;
	}

	public void setEnableChild(String enableChild) {
		this.enableChild = enableChild;
	}
}
