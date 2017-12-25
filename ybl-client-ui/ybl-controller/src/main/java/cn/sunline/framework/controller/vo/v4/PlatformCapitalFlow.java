package cn.sunline.framework.controller.vo.v4;


import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 平台资金流水表
 * @author lyy
 *
 */
public class PlatformCapitalFlow extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2679063192545385837L;
	/**
	 * 企业id
	 */
	private Long enterpriseId;
	/**
	 * 社会统一信用证号码
	 */
	private String socialCreditCode;
	/**
	 * 放款批次编号
	 */
	private String paymentBatchNo;
	/**
	 * 融资订单号
	 */
	private String financingOrderNo;
	/**
	 * 放款订单号
	 */
	private String loanOrderNo;
	/**
	 * 平台费率
	 */
	private BigDecimal platformRate;
	/**
	 * 减免费率
	 */
	private BigDecimal reductionRate;
	/**
	 * 实付平台费用
	 */
	private BigDecimal paidPlatformFee;
	/**
	 * 流水状态：1-平台费用未确认2-平台费用已确认
	 */
	private int status;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 企业名称
	 */
	private String enterpriseName;
	/**
	 * 开始时间
	 */
	private String startTime;
	/**
	 * 结束时间
	 */
	private String endTime;
	/**
	 * 融资费用
	 */
	private BigDecimal totalFinancingFee;
	/**
	 * 实际费用
	 */
	private BigDecimal actualLoanAmount;
	/**
	 * 实际放款时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date actualLoanDate;
	
	/**
	 * 交易流水号
	 */
	private String transactionOrderNo;
	/**
	 * 付款单位开户行
	 */
	private String bank;
	/**
	 * 付款单位开户行名称
	 */
	private String bankAccountName;
	/**
	 * 付款单位账户银行账号
	 */
	private String bankAccount;
	/**
	 * 批次备注
	 */
	private String pbRemark;
	
	
	@JSONField(name="transaction_order_no")
	public String getTransactionOrderNo() {
		return transactionOrderNo;
	}
	@JSONField(name="transaction_order_no")
	public void setTransactionOrderNo(String transactionOrderNo) {
		this.transactionOrderNo = transactionOrderNo;
	}
	@JSONField(name="bank")
	public String getBank() {
		return bank;
	}
	@JSONField(name="bank")
	public void setBank(String bank) {
		this.bank = bank;
	}
	@JSONField(name="bank_account_name")
	public String getBankAccountName() {
		return bankAccountName;
	}
	@JSONField(name="bank_account_name")
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	@JSONField(name="bank_account")
	public String getBankAccount() {
		return bankAccount;
	}
	@JSONField(name="bank_account")
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	@JSONField(name="pb_remark")
	public String getPbRemark() {
		return pbRemark;
	}
	@JSONField(name="pb_remark")
	public void setPbRemark(String pbRemark) {
		this.pbRemark = pbRemark;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="social_credit_code")
	public String getSocialCreditCode() {
		return socialCreditCode;
	}
	@JSONField(name="social_credit_code")
	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}
	@JSONField(name="payment_batch_no")
	public String getPaymentBatchNo() {
		return paymentBatchNo;
	}
	@JSONField(name="payment_batch_no")
	public void setPaymentBatchNo(String paymentBatchNo) {
		this.paymentBatchNo = paymentBatchNo;
	}
	@JSONField(name="financing_order_no")
	public String getFinancingOrderNo() {
		return financingOrderNo;
	}
	@JSONField(name="financing_order_no")
	public void setFinancingOrderNo(String financingOrderNo) {
		this.financingOrderNo = financingOrderNo;
	}
	@JSONField(name="loan_order_no")
	public String getLoanOrderNo() {
		return loanOrderNo;
	}
	@JSONField(name="loan_order_no")
	public void setLoanOrderNo(String loanOrderNo) {
		this.loanOrderNo = loanOrderNo;
	}
	@JSONField(name="platform_rate")
	public BigDecimal getPlatformRate() {
		return platformRate;
	}
	@JSONField(name="platform_rate")
	public void setPlatformRate(BigDecimal platformRate) {
		this.platformRate = platformRate;
	}
	@JSONField(name="reduction_rate")
	public BigDecimal getReductionRate() {
		return reductionRate;
	}
	@JSONField(name="reduction_rate")
	public void setReductionRate(BigDecimal reductionRate) {
		this.reductionRate = reductionRate;
	}
	@JSONField(name="paid_platform_fee")
	public BigDecimal getPaidPlatformFee() {
		return paidPlatformFee;
	}
	@JSONField(name="paid_platform_fee")
	public void setPaidPlatformFee(BigDecimal paidPlatformFee) {
		this.paidPlatformFee = paidPlatformFee;
	}
	@JSONField(name="status")
	public int getStatus() {
		return status;
	}
	@JSONField(name="status")
	public void setStatus(int status) {
		this.status = status;
	}
	@JSONField(name="remark")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="start_time")
	public String getStartTime() {
		return startTime;
	}
	@JSONField(name="start_time")
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	@JSONField(name="end_time")
	public String getEndTime() {
		return endTime;
	}
	@JSONField(name="end_time")
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	@JSONField(name="total_financing_fee")
	public BigDecimal getTotalFinancingFee() {
		return totalFinancingFee;
	}
	@JSONField(name="total_financing_fee")
	public void setTotalFinancingFee(BigDecimal totalFinancingFee) {
		this.totalFinancingFee = totalFinancingFee;
	}
	@JSONField(name="actual_loan_amount")
	public BigDecimal getActualLoanAmount() {
		return actualLoanAmount;
	}
	@JSONField(name="actual_loan_amount")
	public void setActualLoanAmount(BigDecimal actualLoanAmount) {
		this.actualLoanAmount = actualLoanAmount;
	}
	@JSONField(name="actual_loan_date")
	public Date getActualLoanDate() {
		return actualLoanDate;
	}
	@JSONField(name="actual_loan_date")
	public void setActualLoanDate(Date actualLoanDate) {
		this.actualLoanDate = actualLoanDate;
	}
	
	
	
}