package com.bpm.framework.controller.v4.supplier.settlement;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class RePaymentVo implements Serializable {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = -4806613610351560610L;
	
	//确认返款日期
	private Long confirm_repayment_date;
	
	//逾期费用
	private BigDecimal overdue_fee;
	
	//流水单号
     private String transaction_order_no;
     //备注
     private String remark;
     private String enterprise_short_name;
     
     //核心企业名称
     private String core_enterprise_name;
     
     //实际返款金额
     private BigDecimal actual_amount;
     
     //应还利息
     private BigDecimal repayment_interest;
     
     //还款状态
     private Integer repayment_status;
     
     //业务id 融资方或者核心企业
     private Integer business_id;
     
     //逾期利率
     private BigDecimal overdue_interest_rate;
     
     //付款单位开户行
     private String bank;
     
     //付款单位账户银行账号
     private String bank_account;
     
     //融资申请总金额
     private BigDecimal total_money;
     
     //实际还款时间
     private Long actual_repayment_date;
     
     //放款申请订单号
     private String loan_apply_order_no;
     
     //还款时间
     private Long repayment_date;
     
     //资金方名称
     private String factor;
     
     //期数
     private String period;
     
     //融资方名称
     private String financing_name;
     
    //逾期天数
     private Integer overdue_days;
     private String real_name;
     private Integer id_;
     private BigDecimal repayment_principal;
     private String bank_account_name;
     private String confirm_status;
     private Long member_id; //操纵返款人id
     private BigDecimal repayment_count;

     public BigDecimal getRepayment_count() {
		return repayment_count;
	}

	public void setRepayment_count(BigDecimal repayment_count) {
		this.repayment_count = repayment_count;
	}
	protected Date createdTime; // 对象的创建时间

 	protected Long createdBy; // 持久化对象的创建人

 	protected Date lastUpdateTime; // 该对象最后更新时间

 	protected Long lastUpdateBy; // 该对象最后更新人

 	protected int enable = 1; // 该对象的有效标识

 	protected String sign;//标识字段
 	
 	protected String attribute1; // 备用字段
 	protected String attribute2;
 	protected String attribute3;
 	protected String attribute4;
 	protected String attribute5;
 	protected String attribute6;
 	protected String attribute7;
 	protected String attribute8;
 	protected String attribute9;
 	protected String attribute10;
 	
 	@JSONField(serialize=false)
 	protected long rowNo;// 用于显示在界面上“序号”

 	@JSONField(name="attribute1_")
 	public String getAttribute1() {
 		return attribute1;
 	}

 	@JSONField(name="attribute10_")
 	public String getAttribute10() {
 		return attribute10;
 	}
 	@JSONField(name="attribute2_")
 	public String getAttribute2() {
 		return attribute2;
 	}
 	@JSONField(name="attribute3_")
 	public String getAttribute3() {
 		return attribute3;
 	}
 	@JSONField(name="attribute4_")
 	public String getAttribute4() {
 		return attribute4;
 	}
 	@JSONField(name="attribute5_")
 	public String getAttribute5() {
 		return attribute5;
 	}
 	@JSONField(name="attribute6_")
 	public String getAttribute6() {
 		return attribute6;
 	}
 	@JSONField(name="attribute7_")
 	public String getAttribute7() {
 		return attribute7;
 	}
 	@JSONField(name="attribute8_")
 	public String getAttribute8() {
 		return attribute8;
 	}
 	@JSONField(name="attribute9_")
 	public String getAttribute9() {
 		return attribute9;
 	}
 	@JSONField(name="created_by")
 	public Long getCreatedBy() {
 		return createdBy;
 	}

 	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="created_time")
 	public Date getCreatedTime() {
 		return createdTime;
 	}
 	@JSONField(name="enable_")
 	public int getEnable() {
 		return enable;
 	}

 	@JSONField(name="last_update_by")
 	public Long getLastUpdateBy() {
 		return lastUpdateBy;
 	}

 	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="last_update_time")
 	public Date getLastUpdateTime() {
 		return lastUpdateTime;
 	}
 	@JSONField(name="attribute1_")
 	public void setAttribute1(String attribute1) {
 		this.attribute1 = attribute1;
 	}
 	@JSONField(name="attribute10_")
 	public void setAttribute10(String attribute10) {
 		this.attribute10 = attribute10;
 	}
 	@JSONField(name="attribute2_")
 	public void setAttribute2(String attribute2) {
 		this.attribute2 = attribute2;
 	}
 	@JSONField(name="attribute3_")
 	public void setAttribute3(String attribute3) {
 		this.attribute3 = attribute3;
 	}
 	@JSONField(name="attribute4_")
 	public void setAttribute4(String attribute4) {
 		this.attribute4 = attribute4;
 	}
 	@JSONField(name="attribute5_")
 	public void setAttribute5(String attribute5) {
 		this.attribute5 = attribute5;
 	}
 	@JSONField(name="attribute6_")
 	public void setAttribute6(String attribute6) {
 		this.attribute6 = attribute6;
 	}
 	@JSONField(name="attribute7_")
 	public void setAttribute7(String attribute7) {
 		this.attribute7 = attribute7;
 	}
 	@JSONField(name="attribute8_")
 	public void setAttribute8(String attribute8) {
 		this.attribute8 = attribute8;
 	}
 	@JSONField(name="attribute9_")
 	public void setAttribute9(String attribute9) {
 		this.attribute9 = attribute9;
 	}
 	@JSONField(name="created_by")
 	public void setCreatedBy(Long createdBy) {
 		this.createdBy = createdBy;
 	}
 	@JSONField(name="created_time")
 	public void setCreatedTime(Date createdTime) {
 		this.createdTime = createdTime;
 	}
 	@JSONField(name="enable_")
 	public void setEnable(int enable) {
 		this.enable = enable;
 	}
 	@JSONField(name="last_update_by")
 	public void setLastUpdateBy(Long lastUpdateBy) {
 		this.lastUpdateBy = lastUpdateBy;
 	}
 	@JSONField(name="last_update_time")
 	public void setLastUpdateTime(Date lastUpdateTime) {
 		this.lastUpdateTime = lastUpdateTime;
 	}

 	public long getRowNo() {
 		return rowNo;
 	}

 	public void setRowNo(long rowNo) {
 		this.rowNo = rowNo;
 	}
 	@JSONField(name="sign_")
 	public String getSign() {
 		return sign;
 	}
 	@JSONField(name="sign_")
 	public void setSign(String sign) {
 		this.sign = sign;
 	}

 	@Override
 	public String toString() {
 		return "AbstractEntity [id=" + id_ + ", createdTime=" + createdTime + ", createdBy=" + createdBy
 				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
 				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
 				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
 				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
 				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
 	}
     
     public Long getMember_id() {
		return member_id;
	}
	public void setMember_id(Long member_id) {
		this.member_id = member_id;
	}
	/**
      * 附件的id
      */
     private Long attractId;
     
	public Long getConfirm_repayment_date() {
		return confirm_repayment_date;
	}
	public void setConfirm_repayment_date(Long confirm_repayment_date) {
		this.confirm_repayment_date = confirm_repayment_date;
	}
	public String getTransaction_order_no() {
		return transaction_order_no;
	}
	public void setTransaction_order_no(String transaction_order_no) {
		this.transaction_order_no = transaction_order_no;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getEnterprise_short_name() {
		return enterprise_short_name;
	}
	public void setEnterprise_short_name(String enterprise_short_name) {
		this.enterprise_short_name = enterprise_short_name;
	}
	public String getCore_enterprise_name() {
		return core_enterprise_name;
	}
	public void setCore_enterprise_name(String core_enterprise_name) {
		this.core_enterprise_name = core_enterprise_name;
	}
	
	public void setRepayment_status(Integer repayment_status) {
		this.repayment_status = repayment_status;
	}
	public Integer getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(Integer business_id) {
		this.business_id = business_id;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBank_account() {
		return bank_account;
	}
	public void setBank_account(String bank_account) {
		this.bank_account = bank_account;
	}
	public Long getActual_repayment_date() {
		return actual_repayment_date;
	}
	public void setActual_repayment_date(Long actual_repayment_date) {
		this.actual_repayment_date = actual_repayment_date;
	}
	public String getLoan_apply_order_no() {
		return loan_apply_order_no;
	}
	public void setLoan_apply_order_no(String loan_apply_order_no) {
		this.loan_apply_order_no = loan_apply_order_no;
	}
	public Long getRepayment_date() {
		return repayment_date;
	}
	public void setRepayment_date(Long repayment_date) {
		this.repayment_date = repayment_date;
	}
	public String getFactor() {
		return factor;
	}
	public void setFactor(String factor) {
		this.factor = factor;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getFinancing_name() {
		return financing_name;
	}
	public void setFinancing_name(String financing_name) {
		this.financing_name = financing_name;
	}
	public Integer getOverdue_days() {
		return overdue_days;
	}
	public void setOverdue_days(Integer overdue_days) {
		this.overdue_days = overdue_days;
	}
	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}
	public Integer getId_() {
		return id_;
	}
	public void setId_(Integer id_) {
		this.id_ = id_;
	}
	public BigDecimal getOverdue_interest_rate() {
		return overdue_interest_rate;
	}

	public void setOverdue_interest_rate(BigDecimal overdue_interest_rate) {
		this.overdue_interest_rate = overdue_interest_rate;
	}

	public BigDecimal getRepayment_principal() {
		return repayment_principal;
	}

	public void setRepayment_principal(BigDecimal repayment_principal) {
		this.repayment_principal = repayment_principal;
	}

	public String getBank_account_name() {
		return bank_account_name;
	}
	public void setBank_account_name(String bank_account_name) {
		this.bank_account_name = bank_account_name;
	}
	public String getConfirm_status() {
		return confirm_status;
	}
	public void setConfirm_status(String confirm_status) {
		this.confirm_status = confirm_status;
	}
	public Long getAttractId() {
		return attractId;
	}
	public void setAttractId(Long attractId) {
		this.attractId = attractId;
	}

	public BigDecimal getActual_amount() {
		return actual_amount;
	}

	public void setActual_amount(BigDecimal actual_amount) {
		this.actual_amount = actual_amount;
	}

	public BigDecimal getRepayment_interest() {
		return repayment_interest;
	}

	public void setRepayment_interest(BigDecimal repayment_interest) {
		this.repayment_interest = repayment_interest;
	}

	public BigDecimal getTotal_money() {
		return total_money;
	}

	public void setTotal_money(BigDecimal total_money) {
		this.total_money = total_money;
	}

	public Integer getRepayment_status() {
		return repayment_status;
	}

	public BigDecimal getOverdue_fee() {
		return overdue_fee;
	}

	public void setOverdue_fee(BigDecimal overdue_fee) {
		this.overdue_fee = overdue_fee;
	}
     

}
