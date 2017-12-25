package cn.sunline.framework.controller.vo.v4.factor;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 合同模板表
 * @author DuanGuoJie
 *
 */
public class ContractTemplate extends AbstractEntity {
    
	private static final long serialVersionUID = -3479409097084383847L;

	/**
	 * 模板名称
	 */
	@JSONField(name = "template_name")
	private String templateName;

	/**
	 * 模板类型：
	 */
	@JSONField(name = "template_type")
    private String templateType;

    /**
     * 备注
     */
	@JSONField(name = "remark")
    private String remark;

    /**
     * 模板内容
     */
	@JSONField(name = "template_content")
    private String templateContent;

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getTemplateContent() {
        return templateContent;
    }

    public void setTemplateContent(String templateContent) {
        this.templateContent = templateContent == null ? null : templateContent.trim();
    }
}