package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class RepaymentPlanVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5743907446562836487L;

	//会员id（借款人）
	private Long memberId;

	//还款日期
	private Date repaymentDate;

	//应还金额
	private BigDecimal amount;

	//已还款金额
	private BigDecimal actualAmount;

	//本金
	private BigDecimal originalAmount;

	//利息
	private BigDecimal interest;

	//提前违约金
	private BigDecimal advancePenalty;

	//逾期违约金
	private BigDecimal overduePenalty;

	//企业id
	private Long enterpriseId;

	//融资申请id
	private Long financeApplyId;

	//还款状态
	private String status;

	
	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	
	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="repayment_date")
	public Date getRepaymentDate() {
		return repaymentDate;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="repayment_date")
	public void setRepaymentDate(Date repaymentDate) {
		this.repaymentDate = repaymentDate;
	}

	@JSONField(name = "amount_")
	public BigDecimal getAmount() {
		return amount;
	}

	@JSONField(name = "amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@JSONField(name = "actual_amount")
	public BigDecimal getActualAmount() {
		return actualAmount;
	}

	@JSONField(name = "actual_amount")
	public void setActualAmount(BigDecimal actualAmount) {
		this.actualAmount = actualAmount;
	}

	@JSONField(name = "original_amount")
	public BigDecimal getOriginalAmount() {
		return originalAmount;
	}

	@JSONField(name = "original_amount")
	public void setOriginalAmount(BigDecimal originalAmount) {
		this.originalAmount = originalAmount;
	}

	@JSONField(name = "interest_")
	public BigDecimal getInterest() {
		return interest;
	}

	@JSONField(name = "interest_")
	public void setInterest(BigDecimal interest) {
		this.interest = interest;
	}

	@JSONField(name = "advance_penalty")
	public BigDecimal getAdvancePenalty() {
		return advancePenalty;
	}

	@JSONField(name = "advance_penalty")
	public void setAdvancePenalty(BigDecimal advancePenalty) {
		this.advancePenalty = advancePenalty;
	}

	@JSONField(name = "overdue_penalty")
	public BigDecimal getOverduePenalty() {
		return overduePenalty;
	}

	@JSONField(name = "overdue_penalty")
	public void setOverduePenalty(BigDecimal overduePenalty) {
		this.overduePenalty = overduePenalty;
	}

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "finance_applyId")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}

	@JSONField(name = "finance_applyId")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
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
