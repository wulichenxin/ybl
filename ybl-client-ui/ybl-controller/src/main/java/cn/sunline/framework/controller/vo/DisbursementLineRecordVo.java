package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//放款行表
public class DisbursementLineRecordVo extends AbstractEntity {

	private static final long serialVersionUID = -1707336569562050090L;

	@JSONField(name = "disbursement_id")
	private Long disbursementId;

	@JSONField(name = "amount_")
	private BigDecimal amount;

	@JSONField(name = "pay_time")
	private String payTime;

	@JSONField(name = "type_")
	private String type;

	@JSONField(name = "comment_")
	private String comment;

	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	

	public Long getDisbursementId() {
		return disbursementId;
	}

	public void setDisbursementId(Long disbursementId) {
		this.disbursementId = disbursementId;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getPayTime() {
		return payTime;
	}

	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}
