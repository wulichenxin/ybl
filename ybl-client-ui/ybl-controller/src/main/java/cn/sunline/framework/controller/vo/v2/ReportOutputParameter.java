package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ReportOutputParameter extends AbstractEntity{

	private static final long serialVersionUID = 1L;
	/**
	 * 字段
	 */
    private String field;
    /**
     * 名称
     */
    private String name;
    /**
     * 对其方式
     */
    private String alineWay;
    /**
     * 报表id
     */
    private long reportId;
    /**
     * 类型
     */
    private String type;
    
    /**
	 * 数据字典key
	 */
	private String configKey;
	
    @JSONField(name="field_")
	public String getField() {
		return field;
	}
    @JSONField(name="field_")
	public void setField(String field) {
		this.field = field;
	}
    @JSONField(name="name_")
	public String getName() {
		return name;
	}
    @JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
    @JSONField(name="aline_way")
	public String getAlineWay() {
		return alineWay;
	}
    @JSONField(name="aline_way")
	public void setAlineWay(String alineWay) {
		this.alineWay = alineWay;
	}
    @JSONField(name="report_id")
	public long getReportId() {
		return reportId;
	}
    @JSONField(name="report_id")
	public void setReportId(long reportId) {
		this.reportId = reportId;
	}
    @JSONField(name="type_")
   	public String getType() {
   		return type;
   	}
       @JSONField(name="type_")
   	public void setType(String type) {
   		this.type = type;
   	}
       @JSONField(name="config_key")
   	public String getConfigKey() {
   		return configKey;
   	}
   	@JSONField(name="config_key")
   	public void setConfigKey(String configKey) {
   		this.configKey = configKey;
   	}
}
