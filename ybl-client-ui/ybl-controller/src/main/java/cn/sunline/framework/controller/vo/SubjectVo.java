package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 标的表实体类
 * @author MaiBenBen
 *
 */
public class SubjectVo extends AbstractEntity {

	private static final long serialVersionUID = -5939446865827397820L;

	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 所属会员id */
	private Long memberId=-1L;
	/*截止日期 */
	private String endDate;
	/*标的编号 */
	private String number;
	/*标的名称 */
	private String name;
	/*标的金额 */
	private BigDecimal amount;
	/*贷款期限*/
	private Integer loanPeriod;
	/*期限类型:按天：day  按月：month  按年：year */
	private String periodType;
	/*还款方式 */
	private String repaymentType;
	/*保理类型 */
	private String factoringType;
	/*预计还款日期 */
	private String repaymentDate;
	/*备注*/
	private String remark;
	/*项目说明 */
	private String desc;
	/*标的状态:草稿：draft  已发布/竞标中：biding 回款中：paymenting 流标：fail_subject 已完成：end*/
	private String status;
	/*是否放款:未放款：N 已放款：Y*/
	private String isLoan;	

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	@JSONField(name = "end_date")
	public String getEndDate() {
		return endDate;
	}

	@JSONField(name = "end_date")
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@JSONField(name = "number_")
	public String getNumber() {
		return number;
	}

	@JSONField(name = "number_")
	public void setNumber(String number) {
		this.number = number;
	}

	@JSONField(name = "name_")
	public String getName() {
		return name;
	}

	@JSONField(name = "name_")
	public void setName(String name) {
		this.name = name;
	}

	@JSONField(name = "amount_")
	public BigDecimal getAmount() {
		return amount;
	}
	
	@JSONField(name = "amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@JSONField(name = "loan_period")
	public Integer getLoanPeriod() {
		return loanPeriod;
	}

	@JSONField(name = "loan_period")
	public void setLoanPeriod(Integer loanPeriod) {
		this.loanPeriod = loanPeriod;
	}

	@JSONField(name = "period_type")
	public String getPeriodType() {
		return periodType;
	}

	@JSONField(name = "period_type")
	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}

	@JSONField(name = "repayment_type")
	public String getRepaymentType() {
		return repaymentType;
	}

	@JSONField(name = "repayment_type")
	public void setRepaymentType(String repaymentType) {
		this.repaymentType = repaymentType;
	}

	@JSONField(name = "factoring_type")
	public String getFactoringType() {
		return factoringType;
	}

	@JSONField(name = "factoring_type")
	public void setFactoringType(String factoringType) {
		this.factoringType = factoringType;
	}

	@JSONField(name = "repayment_date")
	public String getRepaymentDate() {
		return repaymentDate;
	}

	@JSONField(name = "repayment_date")
	public void setRepaymentDate(String repaymentDate) {
		this.repaymentDate = repaymentDate;
	}

	@JSONField(name = "remark_")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "desc_")
	public String getDesc() {
		return desc;
	}

	@JSONField(name = "desc_")
	public void setDesc(String desc) {
		this.desc = desc;
	}

	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}

	@JSONField(name = "is_loan")
	public String getIsLoan() {
		return isLoan;
	}

	@JSONField(name = "is_loan")
	public void setIsLoan(String isLoan) {
		this.isLoan = isLoan;
	}
	
}
