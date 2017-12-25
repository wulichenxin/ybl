package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 *融资申请
 *
 */
public class FinanceApplyVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7617123273489557443L;

	/**
	 * 项目名称
	 */
	@JSONField(name = "name_")
	private String name_;
	
	/**
	 * 保理类型
	 */
	@JSONField(name = "factor_type")
	private String factor_type;
	
	/**
	 * 出账时间
	 */
	@JSONField(name ="pay_time")
	private String pay_time;
	
	/**
	 * 贷款年利率
	 */
	@JSONField(name = "rate_")
	private BigDecimal rate_;
	
	/**
	 * 逾期日利率
	 */
	@JSONField(name = "overdue_rate")
	private BigDecimal overdue_rate;
	
	/**
	 * 管理费年利率
	 */
	@JSONField(name = "manage_rate")
	private BigDecimal manage_rate;
	
	/**
	 * 融资比例
	 */
	@JSONField(name = "finance_ratio")
	private BigDecimal finance_ratio;
	
	/**
	 * 违约利率
	 */
	@JSONField(name = "penalty_rate")
	private BigDecimal penalty_rate;
	
	/**
	 * 融资产品id（标的/产品）
	 */
	@JSONField(name = "business_id")
	private Long business_id;
	
	/**
	 * 融资主体
	 */
	@JSONField(name = "finance_body")
	private String finance_body;
	
	/**
	 * 供应商id
	 */
	@JSONField(name = "supplier_member_id")
	private Long supplier_member_id;
	
	/**
	 * 保理商id
	 */
	@JSONField(name ="factoring_member_id")
	private Long factoring_member_id;
	
	/**
	 * 编号
	 */
	@JSONField(name = "number_")
	private String number_;
	
	/**
	 * 申请金额
	 */
	@JSONField(name = "apply_amount")
	private BigDecimal apply_amount;
	
	/**
	 * 还款日期
	 */
	
	private String repayment_date;
	
	/**
	 * 贷款期限
	 */
	@JSONField(name = "loan_period")
	private Integer loan_period;
	
	/**
	 * 期限类型
	 */
	@JSONField(name = "period_type")
	private String period_type;
	
	/**
	 * 申请说明
	 */
	@JSONField(name = "remark_")
	private String remark_;
	
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterprise_id;
	
	/**
	 * 融资状态
	 */
	@JSONField(name = "status_")
	private String status_;
	
	
	/**
	 * 还款方式
	 */
	@JSONField(name = "repayment_type")
	private String repayment_type;
	
	
	/**
	 * 还款日规则
	 */
	@JSONField(name = "repayment_date_rule")
	private String repayment_date_rule;
	
	
	
	
	public String getRepayment_type() {
		return repayment_type;
	}
	public void setRepayment_type(String repayment_type) {
		this.repayment_type = repayment_type;
	}
	public String getRepayment_date_rule() {
		return repayment_date_rule;
	}
	public void setRepayment_date_rule(String repayment_date_rule) {
		this.repayment_date_rule = repayment_date_rule;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getFactor_type() {
		return factor_type;
	}
	public void setFactor_type(String factor_type) {
		this.factor_type = factor_type;
	}
	public String getPay_time() {
		return pay_time;
	}
	public void setPay_time(String pay_time) {
		this.pay_time = pay_time;
	}
	public BigDecimal getRate_() {
		return rate_;
	}
	public void setRate_(BigDecimal rate_) {
		this.rate_ = rate_;
	}
	public BigDecimal getOverdue_rate() {
		return overdue_rate;
	}
	public void setOverdue_rate(BigDecimal overdue_rate) {
		this.overdue_rate = overdue_rate;
	}
	public BigDecimal getManage_rate() {
		return manage_rate;
	}
	public void setManage_rate(BigDecimal manage_rate) {
		this.manage_rate = manage_rate;
	}
	public BigDecimal getFinance_ratio() {
		return finance_ratio;
	}
	public void setFinance_ratio(BigDecimal finance_ratio) {
		this.finance_ratio = finance_ratio;
	}
	public BigDecimal getPenalty_rate() {
		return penalty_rate;
	}
	public void setPenalty_rate(BigDecimal penalty_rate) {
		this.penalty_rate = penalty_rate;
	}
	public Long getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(Long business_id) {
		this.business_id = business_id;
	}
	public String getFinance_body() {
		return finance_body;
	}
	public void setFinance_body(String finance_body) {
		this.finance_body = finance_body;
	}

	public Long getFactoring_member_id() {
		return factoring_member_id;
	}
	public void setFactoring_member_id(Long factoring_member_id) {
		this.factoring_member_id = factoring_member_id;
	}
	public String getNumber_() {
		return number_;
	}
	public void setNumber_(String number_) {
		this.number_ = number_;
	}
	public BigDecimal getApply_amount() {
		return apply_amount;
	}
	public void setApply_amount(BigDecimal apply_amount) {
		this.apply_amount = apply_amount;
	}
	@JSONField(name="repayment_date" ,format="yyyy-MM-dd")
	public String getRepayment_date() {
		return repayment_date;
	}
	@JSONField(name="repayment_date" ,format="yyyy-MM-dd")
	public void setRepayment_date(String repayment_date) {
		this.repayment_date = repayment_date;
	}
	public Integer getLoan_period() {
		return loan_period;
	}
	public void setLoan_period(Integer loan_period) {
		this.loan_period = loan_period;
	}
	public String getPeriod_type() {
		return period_type;
	}
	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
	}
	public String getRemark_() {
		return remark_;
	}
	public void setRemark_(String remark_) {
		this.remark_ = remark_;
	}
	public Long getEnterprise_id() {
		return enterprise_id;
	}
	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}
	public String getStatus_() {
		return status_;
	}
	public void setStatus_(String status_) {
		this.status_ = status_;
	}

	public Long getSupplier_member_id() {
		return supplier_member_id;
	}
	public void setSupplier_member_id(Long supplier_member_id) {
		this.supplier_member_id = supplier_member_id;
	}
	
	

	
}
