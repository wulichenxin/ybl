package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ReportVo extends AbstractEntity{

	private static final long serialVersionUID = 1L;
    /**
     * 编码
     */
	private String code;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 是否分页 0分页 1不分页
	 */
	private int isPage;
	/**
	 * groovy脚本
	 */
	private String groovyScript;
	/**
	 * 导出类型
	 */
	private String exportType;
	
	@JSONField(name="code_")
	public String getCode() {
		return code;
	}
	@JSONField(name="code_")
	public void setCode(String code) {
		this.code = code;
	}
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name="is_page")
	public int getIsPage() {
		return isPage;
	}
	@JSONField(name="is_page")
	public void setIsPage(int isPage) {
		this.isPage = isPage;
	}
	@JSONField(name="groovy_script")
	public String getGroovyScript() {
		return groovyScript;
	}
	@JSONField(name="groovy_script")
	public void setGroovyScript(String groovyScript) {
		this.groovyScript = groovyScript;
	}
	@JSONField(name="export_type")
	public String getExportType() {
		return exportType;
	}
	@JSONField(name="export_type")
	public void setExportType(String exportType) {
		this.exportType = exportType;
	}
}
