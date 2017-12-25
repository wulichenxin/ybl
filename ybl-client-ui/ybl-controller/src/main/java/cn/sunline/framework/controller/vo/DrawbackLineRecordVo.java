package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//放款行表
public class DrawbackLineRecordVo extends AbstractEntity {

	private static final long serialVersionUID = -1707336569562050090L;

	
	private Long drawbackId;

	//还款金额
	private BigDecimal amount;

	//还款时间
	private String payTime;

	private String comment;

	
	private Long enterpriseId;
	




	@JSONField(name = "drawback_id")
	public Long getDrawbackId() {
		return drawbackId;
	}

	@JSONField(name = "drawback_id")
	public void setDrawbackId(Long drawbackId) {
		this.drawbackId = drawbackId;
	}

	@JSONField(name = "amount_")
	public BigDecimal getAmount() {
		return amount;
	}

	@JSONField(name = "amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@JSONField(name = "pay_time")
	public String getPayTime() {
		return payTime;
	}

	@JSONField(name = "pay_time")
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}



	@JSONField(name = "comment_")
	public String getComment() {
		return comment;
	}

	@JSONField(name = "comment_")
	public void setComment(String comment) {
		this.comment = comment;
	}

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}
