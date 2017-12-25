package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class RepaymentFinanceVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2072530813021847681L;

	
	//借款人
	private Long memberId;
	//还款日期
	private Date repaymentDate;
	//应还金额
	private BigDecimal amount;
	//实际还款金额
	private BigDecimal actualAmount;
	//还款状态
	private String status;
	//本金
	private BigDecimal originalAmount2;
	//利息
	private BigDecimal interest;
	//提前违约金
	private BigDecimal advancePenalty;
	//预期违约金
	private BigDecimal overduePenalty;
	//企业id
	private Long enterpriseId;
	//融资申请id
	private Long financeApplyId;
	
	@JSONField(name="number_")
	public String getNumber() {
		return number;
	}
	@JSONField(name="number_")
	public void setNumber(String number) {
		this.number = number;
	}
	//融资申请编号
	private String number;
	//保理商名称
	private String enterpriseName;
	//保理类型
	private String factorType;
	//管理费年利率
	private BigDecimal manageRate;
	//贷款年利率
	private BigDecimal rate;
	//贷款期限
	private int loanPeriod;
	//期限类型
	private String periodType;
	//违约利率
	private BigDecimal penaltyRate;
	//预期日利率
	private BigDecimal overdueRate;
	//项目名称
	private String name;
	
	
	@JSONField(name="member_id")
	public Long getMemberId() {
		return memberId;
	}
	@JSONField(name="member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	@JSONField(name="repayment_date")
	public Date getRepaymentDate() {
		return repaymentDate;
	}
	@JSONField(name="repayment_date")
	public void setRepaymentDate(Date repaymentDate) {
		this.repaymentDate = repaymentDate;
	}
	@JSONField(name="amount_")
	public BigDecimal getAmount() {
		return amount;
	}
	@JSONField(name="amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	@JSONField(name="actual_amount")
	public BigDecimal getActualAmount() {
		return actualAmount;
	}
	@JSONField(name="actual_amount")
	public void setActualAmount(BigDecimal actualAmount) {
		this.actualAmount = actualAmount;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="original_amount2")
	public BigDecimal getOriginalAmount2() {
		return originalAmount2;
	}
	@JSONField(name="original_amount2")
	public void setOriginalAmount2(BigDecimal originalAmount2) {
		this.originalAmount2 = originalAmount2;
	}
	@JSONField(name="interest_")
	public BigDecimal getInterest() {
		return interest;
	}
	@JSONField(name="interest_")
	public void setInterest(BigDecimal interest) {
		this.interest = interest;
	}
	@JSONField(name="advance_penalty")
	public BigDecimal getAdvancePenalty() {
		return advancePenalty;
	}
	@JSONField(name="advance_penalty")
	public void setAdvancePenalty(BigDecimal advancePenalty) {
		this.advancePenalty = advancePenalty;
	}
	@JSONField(name="overdue_penalty")
	public BigDecimal getOverduePenalty() {
		return overduePenalty;
	}
	@JSONField(name="overdue_penalty")
	public void setOverduePenalty(BigDecimal overduePenalty) {
		this.overduePenalty = overduePenalty;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="finance_apply_id")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}
	@JSONField(name="finance_apply_id")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="factor_type")
	public String getFactorType() {
		return factorType;
	}
	@JSONField(name="factor_type")
	public void setFactorType(String factorType) {
		this.factorType = factorType;
	}
	@JSONField(name="manage_rate")
	public BigDecimal getManageRate() {
		return manageRate;
	}
	@JSONField(name="manage_rate")
	public void setManageRate(BigDecimal manageRate) {
		this.manageRate = manageRate;
	}
	@JSONField(name="rate_")
	public BigDecimal getRate() {
		return rate;
	}
	@JSONField(name="rate_")
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	@JSONField(name="loan_period")
	public int getLoanPeriod() {
		return loanPeriod;
	}
	@JSONField(name="loan_period")
	public void setLoanPeriod(int loanPeriod) {
		this.loanPeriod = loanPeriod;
	}
	@JSONField(name="period_type")
	public String getPeriodType() {
		return periodType;
	}
	@JSONField(name="period_type")
	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}
	@JSONField(name="penalty_rate")
	public BigDecimal getPenaltyRate() {
		return penaltyRate;
	}
	@JSONField(name="penalty_rate")
	public void setPenaltyRate(BigDecimal penaltyRate) {
		this.penaltyRate = penaltyRate;
	}
	@JSONField(name="overdue_rate")
	public BigDecimal getOverdueRate() {
		return overdueRate;
	}
	@JSONField(name="overdue_rate")
	public void setOverdueRate(BigDecimal overdueRate) {
		this.overdueRate = overdueRate;
	}
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	
	
 	
	
	
	
	
	
	
	
}
