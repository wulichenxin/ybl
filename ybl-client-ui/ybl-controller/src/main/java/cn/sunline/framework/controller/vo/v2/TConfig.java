package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 基础数据类型表实体类
 * 
 * @author jzx
 *
 */
public class TConfig extends AbstractEntity {

	private static final long serialVersionUID = 1828557644034137574L;

	/* 类型 */
	private String type;
	/* 相应代码的值 */
	private String value;
	/* 代码 */
	private String code;

	@JSONField(name = "type_")
	public String getType() {
		return type;
	}

	@JSONField(name = "type_")
	public void setType(String type) {
		this.type = type;
	}

	@JSONField(name = "value_")
	public String getValue() {
		return value;
	}

	@JSONField(name = "value_")
	public void setValue(String value) {
		this.value = value;
	}

	@JSONField(name = "code_")
	public String getCode() {
		return code;
	}

	@JSONField(name = "code_")
	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "TConfig [type=" + type + ", value=" + value + ", code=" + code + "]";
	}

}
