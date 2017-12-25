package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;


//放款记录表
public class V2DisbursementRecordVo extends AbstractEntity {

	//应收账款id
	@JSONField(name = "accounts_receivable_id")
	private Long accountsReceivableId;
	
	//付款批次id
	@JSONField(name = "disbursement_batch_id")
	private Long disbursementBatchId;

	//结算金额
	@JSONField(name = "balance_amount")
	private BigDecimal balanceAmount;

	//保理费用
	@JSONField(name = "loan_fee")
	private BigDecimal loanFee;

	//平台使用费用
	@JSONField(name = "manage_fee")
	private BigDecimal manageFee;

	//贷款利息
	@JSONField(name = "loan_interest")
	private BigDecimal loanInterest;

	//其他费用
	@JSONField(name = "other_fee")
	private BigDecimal otherFee;

	//放款金额
	@JSONField(name = "disbursement_amount")
	private BigDecimal disbursementAmount;

	//状态
	@JSONField(name = "status_")
	private String status;

	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;

	//供应商企业
	@JSONField(name = "supplier_enterprise_name")
	private String supplierEnterpriseName;

	//核心企业
	@JSONField(name = "core_enterprise_name")
	private String coreEnterpriseName;

	//凭证面额
	@JSONField(name = "amount_")
	private BigDecimal amount;

	//开票日期
	@JSONField(name = "invoice_date")
	private Date invoiceDate;

	//预计回款日
	@JSONField(name = "return_date")
	private Date returnDate;
	
	//凭证编号
	@JSONField(name = "number_")
	private String number;
	

	public Long getAccountsReceivableId() {
		return accountsReceivableId;
	}

	public void setAccountsReceivableId(Long accountsReceivableId) {
		this.accountsReceivableId = accountsReceivableId;
	}

	public Long getDisbursementBatchId() {
		return disbursementBatchId;
	}

	public void setDisbursementBatchId(Long disbursementBatchId) {
		this.disbursementBatchId = disbursementBatchId;
	}

	public BigDecimal getBalanceAmount() {
		return balanceAmount;
	}

	public void setBalanceAmount(BigDecimal balanceAmount) {
		this.balanceAmount = balanceAmount;
	}

	public BigDecimal getLoanFee() {
		return loanFee;
	}

	public void setLoanFee(BigDecimal loanFee) {
		this.loanFee = loanFee;
	}

	public BigDecimal getManageFee() {
		return manageFee;
	}

	public void setManageFee(BigDecimal manageFee) {
		this.manageFee = manageFee;
	}

	public BigDecimal getLoanInterest() {
		return loanInterest;
	}

	public void setLoanInterest(BigDecimal loanInterest) {
		this.loanInterest = loanInterest;
	}

	public BigDecimal getOtherFee() {
		return otherFee;
	}

	public void setOtherFee(BigDecimal otherFee) {
		this.otherFee = otherFee;
	}

	public BigDecimal getDisbursementAmount() {
		return disbursementAmount;
	}

	public void setDisbursementAmount(BigDecimal disbursementAmount) {
		this.disbursementAmount = disbursementAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}



	public String getSupplierEnterpriseName() {
		return supplierEnterpriseName;
	}

	public void setSupplierEnterpriseName(String supplierEnterpriseName) {
		this.supplierEnterpriseName = supplierEnterpriseName;
	}

	public String getCoreEnterpriseName() {
		return coreEnterpriseName;
	}

	public void setCoreEnterpriseName(String coreEnterpriseName) {
		this.coreEnterpriseName = coreEnterpriseName;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	
	
}
