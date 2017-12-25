package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

public class QuotaRecordVo extends AbstractEntity {

	private static final long serialVersionUID = 1015650557658210494L;
	/**
	 * 合同id
	 */
	@JSONField(name = "contract_id")
	private String contractId;
	/**
	 * 增加额度
	 */
	@JSONField(name = "quota_")
	private String quota;
	/**
	 * 生效日期
	 */
	@JSONField(name = "effective_time",format="yyyy-MM-dd")
	private Date effectiveTime;
	/**
	 * 类型
	 */
	@JSONField(name = "type_")
	private String type;
	/**
	 * 备注
	 */
	@JSONField(name = "remark_")
	private String remark;
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private String enterpriseId;

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getQuota() {
		return quota;
	}

	public void setQuota(String quota) {
		this.quota = quota;
	}

	public Date getEffectiveTime() {
		return effectiveTime;
	}

	public void setEffectiveTime(Date effectiveTime) {
		this.effectiveTime = effectiveTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}
