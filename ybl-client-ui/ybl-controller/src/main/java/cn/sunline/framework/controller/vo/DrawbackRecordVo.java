package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class DrawbackRecordVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6585550419197838437L;

	//融资申请id
	private Long financeApplyId;
	
	
	//累计还款金额
	private BigDecimal amount;
	
	
	//企业id
	private Long enterpriseId;
	
	

	@JSONField(name = "finance_apply_id")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}

	@JSONField(name = "finance_apply_id")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}



	@JSONField(name = "amount_")
	public BigDecimal getAmount() {
		return amount;
	}

	@JSONField(name = "amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
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
