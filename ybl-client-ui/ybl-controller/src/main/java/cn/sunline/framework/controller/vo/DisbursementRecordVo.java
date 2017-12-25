package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class DisbursementRecordVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6585550419197838437L;

	//融资申请id
	private Long financeApplyId;
	
	//结算金额=融资申请金额*融资申请比例
	private BigDecimal balanceAmount;
	
	//贷款费用=(贷款年利率*融资申请金额)/360)*贷款天数
	private BigDecimal loanFee;
	
	//服务费用
	private BigDecimal manageFee;
	
	//放款总金额
	private BigDecimal disbursementAmount;
	
	//累计放款金额
	private BigDecimal disbursedAmount;
	
	
	//企业id
	private Long enterpriseId;
	
	/*
	 * 未放款：waiting
            部分放款：processing
            放款完成 ：done'
	 * */
	private String status;

	@JSONField(name = "finance_apply_id")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}

	@JSONField(name = "finance_apply_id")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}

	@JSONField(name = "balance_amount")
	public BigDecimal getBalanceAmount() {
		return balanceAmount;
	}

	@JSONField(name = "balance_amount")
	public void setBalanceAmount(BigDecimal balanceAmount) {
		this.balanceAmount = balanceAmount;
	}

	@JSONField(name = "loan_fee")
	public BigDecimal getLoanFee() {
		return loanFee;
	}

	@JSONField(name = "loan_fee")
	public void setLoanFee(BigDecimal loanFee) {
		this.loanFee = loanFee;
	}

	@JSONField(name = "manage_fee")
	public BigDecimal getManageFee() {
		return manageFee;
	}

	@JSONField(name = "manage_fee")
	public void setManageFee(BigDecimal manageFee) {
		this.manageFee = manageFee;
	}

	@JSONField(name = "disbursement_amount")
	public BigDecimal getDisbursementAmount() {
		return disbursementAmount;
	}

	@JSONField(name = "disbursement_amount")
	public void setDisbursementAmount(BigDecimal disbursementAmount) {
		this.disbursementAmount = disbursementAmount;
	}

	@JSONField(name = "disbursed_amount")
	public BigDecimal getDisbursedAmount() {
		return disbursedAmount;
	}

	@JSONField(name = "disbursed_amount")
	public void setDisbursedAmount(BigDecimal disbursedAmount) {
		this.disbursedAmount = disbursedAmount;
	}


	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}

}
