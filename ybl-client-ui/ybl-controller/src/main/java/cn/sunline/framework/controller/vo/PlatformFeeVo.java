package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年4月19日
 * @version 1.0.0
 * @Description 平台费用表实体类
 */
public class PlatformFeeVo extends AbstractEntity {

	private static final long serialVersionUID = -1190294959513568291L;
	
	/**
	 * 费用项
	 */
	private String code;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 企业id
	 */
	private long enterpriseId;
	/**
	 * 费用值
	 */
	private String value;
	
	/**
	 * @return the code
	 */
	@JSONField(name="code_")
	public String getCode() {
		return code;
	}
	/**
	 * @param code the code to set
	 */
	@JSONField(name="code_")
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return the remark
	 */
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	/**
	 * @param remark the remark to set
	 */
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * @return the enterpriseId
	 */
	@JSONField(name="enterprise_id")
	public long getEnterpriseId() {
		return enterpriseId;
	}
	/**
	 * @param enterpriseId the enterpriseId to set
	 */
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	/**
	 * @return the value
	 */
	@JSONField(name="value_")
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	@JSONField(name="value_")
	public void setValue(String value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return "PlatformFeeVo [code=" + code + ", remark=" + remark + ", enterpriseId=" + enterpriseId + ", value="
				+ value + ", id=" + id + ", createdTime=" + createdTime + ", createdBy=" + createdBy
				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
	}
	
	

}
