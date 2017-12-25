package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class LoanSignBidVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7646212644648218883L;

	/**
	 * 标的竞标表id
	 */
	@JSONField(name = "loan_sign_id")
	private long loanSignId;
	
	/**
	 * 会员id
	 */
	@JSONField(name = "member_id")
	private long memberId;

	/**
	 * 年利率
	 */
	@JSONField(name = "rate_")
	private Double rate;

	/**
	 * 管理费年利率
	 */
	@JSONField(name = "manager_rate")
	private Double managerRate;

	/**
	 * 融资比例
	 */
	@JSONField(name = "ratio_")
	private Double ratio;

	/**
	 * 最大可贷金额
	 */
	@JSONField(name = "max_amount")
	private Double maxAmount;

	/**
	 * 逾期违约金比率
	 */
	@JSONField(name = "overdue_rate")
	private Double overdueRate;

	/**
	 * 提前还款违约金比率
	 */
	@JSONField(name = "advence_rate")
	private Double advenceRate;

	/**
	 * 备注
	 */
	@JSONField(name = "remark_")
	private String remark;

	/**
	 * '状态:未中标：unbid\r\n            已中标：bided\r\n            竞标中：biding'
	 */
	@JSONField(name = "status_")
	private String status;

	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private long enterpriseId;
	
	/**
	 * 还款方式
	 */
	@JSONField(name = "repayment_type")
	private String repaymentType;
	
	/**
	 * 还款日规则
	 */
	@JSONField(name = "repayment_date_rule")
	private String repaymentDateRule;

	public long getLoanSignId() {
		return loanSignId;
	}

	public void setLoanSignId(long loanSignId) {
		this.loanSignId = loanSignId;
	}

	public long getMemberId() {
		return memberId;
	}

	public void setMemberId(long memberId) {
		this.memberId = memberId;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	public Double getManagerRate() {
		return managerRate;
	}

	public void setManagerRate(Double managerRate) {
		this.managerRate = managerRate;
	}

	public Double getRatio() {
		return ratio;
	}

	public void setRatio(Double ratio) {
		this.ratio = ratio;
	}

	public Double getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(Double maxAmount) {
		this.maxAmount = maxAmount;
	}

	public Double getOverdueRate() {
		return overdueRate;
	}

	public void setOverdueRate(Double overdueRate) {
		this.overdueRate = overdueRate;
	}

	public Double getAdvenceRate() {
		return advenceRate;
	}

	public void setAdvenceRate(Double advenceRate) {
		this.advenceRate = advenceRate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRepaymentType() {
		return repaymentType;
	}

	public void setRepaymentType(String repaymentType) {
		this.repaymentType = repaymentType;
	}

	public String getRepaymentDateRule() {
		return repaymentDateRule;
	}

	public void setRepaymentDateRule(String repaymentDateRule) {
		this.repaymentDateRule = repaymentDateRule;
	}

	

	
}
