package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//放款批次表
public class V2DisbursementBatchVo extends AbstractEntity {

	

	//平台交易流水号
	@JSONField(name = "trx_number_plat")
	private String trxNumberPlat;
	

	//供应商交易流水号
	@JSONField(name = "trx_number_supplier")
	private String trxNumberSupplier;
	
	//供应商id
	@JSONField(name = "supplier_enterprise_id")
	private Long supplierEnterpriseId;
	
	//付款批次
	@JSONField(name = "batch_number")
	private String batchNumber;
	
	
	//批次金额
	@JSONField(name = "batch_amount")
	private BigDecimal batchAmount;
	
	
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
	private BigDecimal otheFfee;
	
	//放款金额
	@JSONField(name = "disbursement_amount")
	private BigDecimal disbursementAmount;
	
	//累计放款金额
	@JSONField(name = "disbursed_amount")
	private BigDecimal disbursedAmount;
	
	//状态
	@JSONField(name = "status_")
	private String status;
	
	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	//供应商企业名称
	@JSONField(name = "supplier_enterprise_name")
	private String supplierEnterpriseName;
	
	//平台使用费率
	@JSONField(name = "manage_ratio")
	private BigDecimal manageRatio;

	//保理商企业名称
	@JSONField(name = "factor_enterprise_name")
	private String factorEnterpriseName;
	
	public String getFactorEnterpriseName() {
		return factorEnterpriseName;
	}

	public void setFactorEnterpriseName(String factorEnterpriseName) {
		this.factorEnterpriseName = factorEnterpriseName;
	}

	public String getTrxNumberPlat() {
		return trxNumberPlat;
	}

	public void setTrxNumberPlat(String trxNumberPlat) {
		this.trxNumberPlat = trxNumberPlat;
	}

	public String getTrxNumberSupplier() {
		return trxNumberSupplier;
	}

	public void setTrxNumberSupplier(String trxNumberSupplier) {
		this.trxNumberSupplier = trxNumberSupplier;
	}

	public Long getSupplierEnterpriseId() {
		return supplierEnterpriseId;
	}

	public void setSupplierEnterpriseId(Long supplierEnterpriseId) {
		this.supplierEnterpriseId = supplierEnterpriseId;
	}

	public String getBatchNumber() {
		return batchNumber;
	}

	public void setBatchNumber(String batchNumber) {
		this.batchNumber = batchNumber;
	}

	public BigDecimal getBatchAmount() {
		return batchAmount;
	}

	public void setBatchAmount(BigDecimal batchAmount) {
		this.batchAmount = batchAmount;
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

	public BigDecimal getOtheFfee() {
		return otheFfee;
	}

	public void setOtheFfee(BigDecimal otheFfee) {
		this.otheFfee = otheFfee;
	}

	public BigDecimal getDisbursementAmount() {
		return disbursementAmount;
	}

	public void setDisbursementAmount(BigDecimal disbursementAmount) {
		this.disbursementAmount = disbursementAmount;
	}

	public BigDecimal getDisbursedAmount() {
		return disbursedAmount;
	}

	public void setDisbursedAmount(BigDecimal disbursedAmount) {
		this.disbursedAmount = disbursedAmount;
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

	public BigDecimal getManageRatio() {
		return manageRatio;
	}

	public void setManageRatio(BigDecimal manageRatio) {
		this.manageRatio = manageRatio;
	}
	

}
