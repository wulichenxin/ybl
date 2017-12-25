package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方放款管理批次结算
 */
public class FactorLoanManagementLoanBatchSettlementVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7817725849289277851L;
	/*实际放款金额*/
	@NotNull
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="actual_loan_amount")
	private BigDecimal actualLoanAmount;
	/*实际放款时间*/
	@Pattern(regexp="^[0-9]{4}-[0-9]{2}-[0-9]{2}$",message="日期格式不正确") 
	@JSONField(name="actual_loan_date")
	private String actualLoanDate;
	/*保理融资费*/
	@JSONField(name="factoring_fee")
	private BigDecimal factoringFee;
	/*交易流水号*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="transaction_order_no")
	private String transactionOrderNo;
	/*付款单位开户行*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="bank")
	private String bank;
	/*付款单位开户名称*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="bank_account_name")
	private String bankAccountName;
	/*付款单位账户银行账号*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="bank_account")
	private String bankAccount;
	/*备注*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="remark")
	private String remark;
	/*平台费率*/
	@JSONField(name="platform_rate")
	private BigDecimal platformRate;
	/*平台减免费率*/
	@JSONField(name="platform_reduction_rate")
	private BigDecimal platformReductionRate;
	/*平台费用*/
	@JSONField(name="platform_fee")
	private BigDecimal platformFee;
	
	//批次号
	private String batch_no;
	/*融资方业务id*/
	@JSONField(name="funder_business_id")
	private Long funderBusinessId;
	
	public Long getFunderBusinessId() {
		return funderBusinessId;
	}
	public void setFunderBusinessId(Long funderBusinessId) {
		this.funderBusinessId = funderBusinessId;
	}
	public BigDecimal getPlatformRate() {
		return platformRate;
	}
	public void setPlatformRate(BigDecimal platformRate) {
		this.platformRate = platformRate;
	}
	public BigDecimal getPlatformReductionRate() {
		return platformReductionRate;
	}
	public void setPlatformReductionRate(BigDecimal platformReductionRate) {
		this.platformReductionRate = platformReductionRate;
	}
	public BigDecimal getPlatformFee() {
		return platformFee;
	}
	public void setPlatformFee(BigDecimal platformFee) {
		this.platformFee = platformFee;
	}
	public BigDecimal getActualLoanAmount() {
		return actualLoanAmount;
	}
	public void setActualLoanAmount(BigDecimal actualLoanAmount) {
		this.actualLoanAmount = actualLoanAmount;
	}
	public String getActualLoanDate() {
		return actualLoanDate;
	}
	public void setActualLoanDate(String actualLoanDate) {
		this.actualLoanDate = actualLoanDate;
	}
	public BigDecimal getFactoringFee() {
		return factoringFee;
	}
	public void setFactoringFee(BigDecimal factoringFee) {
		this.factoringFee = factoringFee;
	}
	public String getTransactionOrderNo() {
		return transactionOrderNo;
	}
	public void setTransactionOrderNo(String transactionOrderNo) {
		this.transactionOrderNo = transactionOrderNo;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBankAccountName() {
		return bankAccountName;
	}
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getBatch_no() {
		return batch_no;
	}
	public void setBatch_no(String batch_no) {
		this.batch_no = batch_no;
	}
}
