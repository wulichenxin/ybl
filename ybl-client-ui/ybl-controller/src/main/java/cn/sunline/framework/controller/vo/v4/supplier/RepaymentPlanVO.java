package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 放款综合综合还款计划VO
 * @author ZSW
 *
 */
public class RepaymentPlanVO extends AbstractEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id_;
	
	private String loan_apply_order_no ;
	
	private String  financing_name;
	
	private String core_enterprise_name;
	
	private String asset_number;
	
	private String period;
	
	private Date repayment_date;
	
	private BigDecimal repayment_principal;
	
	private BigDecimal repayment_interest;
	
	private int overdue_days;
	
	private BigDecimal over_money;
	
	private int repayment_status;

	private int confirm_status;
	
	private BigDecimal overdue_interest_rate;

	public String getLoan_apply_order_no() {
		return loan_apply_order_no;
	}

	public void setLoan_apply_order_no(String loan_apply_order_no) {
		this.loan_apply_order_no = loan_apply_order_no;
	}

	public String getAsset_number() {
		return asset_number;
	}

	public void setAsset_number(String asset_number) {
		this.asset_number = asset_number;
	}

	public String getFinancing_name() {
		return financing_name;
	}

	public void setFinancing_name(String financing_name) {
		this.financing_name = financing_name;
	}

	public String getCore_enterprise_name() {
		return core_enterprise_name;
	}

	public void setCore_enterprise_name(String core_enterprise_name) {
		this.core_enterprise_name = core_enterprise_name;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public Date getRepayment_date() {
		return repayment_date;
	}

	public void setRepayment_date(Date repayment_date) {
		this.repayment_date = repayment_date;
	}

	public BigDecimal getRepayment_principal() {
		return repayment_principal;
	}

	public void setRepayment_principal(BigDecimal repayment_principal) {
		this.repayment_principal = repayment_principal;
	}

	public BigDecimal getRepayment_interest() {
		return repayment_interest;
	}

	public void setRepayment_interest(BigDecimal repayment_interest) {
		this.repayment_interest = repayment_interest;
	}

	public int getOverdue_days() {
		return overdue_days;
	}

	public void setOverdue_days(int overdue_days) {
		this.overdue_days = overdue_days;
	}

	public BigDecimal getOver_money() {
		return over_money;
	}

	public void setOver_money(BigDecimal over_money) {
		this.over_money = over_money;
	}

	public int getRepayment_status() {
		return repayment_status;
	}

	public void setRepayment_status(int repayment_status) {
		this.repayment_status = repayment_status;
	}

	public Integer getId_() {
		return id_;
	}

	public void setId_(Integer id_) {
		this.id_ = id_;
	}
	
	public int getConfirm_status() {
		return confirm_status;
	}

	public void setConfirm_status(int confirm_status) {
		this.confirm_status = confirm_status;
	}

	public BigDecimal getOverdue_interest_rate() {
		return overdue_interest_rate;
	}

	public void setOverdue_interest_rate(BigDecimal overdue_interest_rate) {
		this.overdue_interest_rate = overdue_interest_rate;
	}
	

}
