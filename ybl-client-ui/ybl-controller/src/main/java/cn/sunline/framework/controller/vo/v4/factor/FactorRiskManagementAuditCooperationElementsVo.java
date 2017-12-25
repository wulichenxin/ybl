package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方风控审核合作要素
 */
public class FactorRiskManagementAuditCooperationElementsVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1705319978897951206L;
	/*合作要素编号*/	
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="order_no")
	private String orderNo;
	/*融资企业*/
	@NotBlank
	@Length(min=2,max=25)
	@JSONField(name="financing_enterprise")
	private String financingEnterprise;
	/*批复额度*/
	@NotNull
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28)
	@JSONField(name="give_quota")
	private BigDecimal giveQuota;
	/*融资期限*/
	@NotNull
	@Min(value = 1)
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/*收费方式1-融资利率2-服务费3-折后转让*/
	@NotNull
	@Min(value = 1)
	@Max(value = 3)
	@JSONField(name="fee_mode")
	private Integer feeMode;
	/*融资利率*/
	@Min(value = 0)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*服务费*/
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	/*折后转让金额*/
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="transfer_money")
	private BigDecimal transferMoney;
	/*资产类型1-应收账款2-应付账款3-票据*/
	@NotNull
	@Min(value = 1)
	@Max(value = 3)
	@JSONField(name="assets_type")
	private Integer assetsType;
	/*合同类型*/
	@JSONField(name="contract_type")
	private Integer contractType;
	/*还款方式1-先息后本2-等额本息3-利息前置，到期还本*/
	@NotNull
	@Min(value = 1)
	@Max(value = 3)
	@JSONField(name="repayment_mode")
	private Integer repaymentMode;
	/*放款条件*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="loan_terms")
	private String loanTerms;
	/*日期*/
	@JSONField(name = "audit_date")
	private Date auditDate;
	/*备注*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name = "remark")
	private String remark;
	/*账户名*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name = "bank_account_name")
	private String bankAccountName;
	/*账户号*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name = "bank_account")
	private String bankAccount;
	/*开户行*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name = "bank")
	private String bank;
	
	public BigDecimal getTransferMoney() {
		return transferMoney;
	}
	public void setTransferMoney(BigDecimal transferMoney) {
		this.transferMoney = transferMoney;
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
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public Integer getContractType() {
		return contractType;
	}
	public void setContractType(Integer contractType) {
		this.contractType = contractType;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getFinancingEnterprise() {
		return financingEnterprise;
	}
	public void setFinancingEnterprise(String financingEnterprise) {
		this.financingEnterprise = financingEnterprise;
	}
	public BigDecimal getGiveQuota() {
		return giveQuota;
	}
	public void setGiveQuota(BigDecimal giveQuota) {
		this.giveQuota = giveQuota;
	}
	
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}
	public Integer getFeeMode() {
		return feeMode;
	}
	public void setFeeMode(Integer feeMode) {
		this.feeMode = feeMode;
	}
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public BigDecimal getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(BigDecimal serviceFee) {
		this.serviceFee = serviceFee;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public Integer getRepaymentMode() {
		return repaymentMode;
	}
	public void setRepaymentMode(Integer repaymentMode) {
		this.repaymentMode = repaymentMode;
	}
	public String getLoanTerms() {
		return loanTerms;
	}
	public void setLoanTerms(String loanTerms) {
		this.loanTerms = loanTerms;
	}
	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
