package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 合同额度信息
 * 
 * @author guang
 * 
 */
public class ContractQuotaVo extends AbstractEntity {
	private static final long serialVersionUID = -6830725473833197509L;
	/**
	 * 业务合同号
	 */
	@JSONField(name = "number_")
	private String number;
	/**
	 * 保理商企业id
	 */
	@JSONField(name = "enterprise_id")
	private String enterpriseId;
	/**
	 * 核心企业id
	 */
	@JSONField(name = "core_enterprise_id")
	private String coreEnterpriseId;
	/**
	 * 供应商商id
	 */
	@JSONField(name = "supplier_enterprise_id")
	private String supplierEnterpriseId;
	/**
	 * 保理商企业名称
	 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;
	/**
	 * 核心企业名称
	 */
	@JSONField(name = "core_enterprise_name")
	private String coreEnterpriseName;
	/**
	 * 供应商企业名称
	 */
	@JSONField(name = "supplier_enterprise_name")
	private String supplierEnterpriseName;

	/**
	 * 供应商授信额度
	 */
	@JSONField(name = "credit_amount")
	private BigDecimal creditAmount;
	/**
	 * 保证金
	 */
	@JSONField(name = "deposit_")
	private BigDecimal deposit;
	/**
	 * 临时额度
	 */
	@JSONField(name = "quota_")
	private BigDecimal quota;

	/**
	 * 已结算金额
	 */
	@JSONField(name = "disbursement_amount")
	private BigDecimal disbursementAmount;

	/**
	 * 核心企业回款金额
	 */
	@JSONField(name = "repayment_amount")
	private BigDecimal repaymentAmount;

	/**
	 * 退款金额
	 */
	@JSONField(name = "reimburse_amount")
	private BigDecimal reimburseAmount;

	/**
	 * 供应商回购金额
	 */
	@JSONField(name = "buyback_amount")
	private BigDecimal buybackAmount;

	/**
	 * 授信可用余额
	 */
	@JSONField(name = "available_amount")
	private BigDecimal availableAmount;
	
	@JSONField(name = "early_warning_amount")
	private BigDecimal earlyWarningAmount;

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getCoreEnterpriseId() {
		return coreEnterpriseId;
	}

	public void setCoreEnterpriseId(String coreEnterpriseId) {
		this.coreEnterpriseId = coreEnterpriseId;
	}

	public String getSupplierEnterpriseId() {
		return supplierEnterpriseId;
	}

	public void setSupplierEnterpriseId(String supplierEnterpriseId) {
		this.supplierEnterpriseId = supplierEnterpriseId;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getCoreEnterpriseName() {
		return coreEnterpriseName;
	}

	public void setCoreEnterpriseName(String coreEnterpriseName) {
		this.coreEnterpriseName = coreEnterpriseName;
	}

	public String getSupplierEnterpriseName() {
		return supplierEnterpriseName;
	}

	public void setSupplierEnterpriseName(String supplierEnterpriseName) {
		this.supplierEnterpriseName = supplierEnterpriseName;
	}

	public BigDecimal getCreditAmount() {
		return creditAmount;
	}

	public void setCreditAmount(BigDecimal creditAmount) {
		this.creditAmount = creditAmount;
	}

	public BigDecimal getDeposit() {
		return deposit;
	}

	public void setDeposit(BigDecimal deposit) {
		this.deposit = deposit;
	}

	public BigDecimal getQuota() {
		return quota;
	}

	public void setQuota(BigDecimal quota) {
		this.quota = quota;
	}

	public BigDecimal getDisbursementAmount() {
		return disbursementAmount;
	}

	public void setDisbursementAmount(BigDecimal disbursementAmount) {
		this.disbursementAmount = disbursementAmount;
	}

	public BigDecimal getRepaymentAmount() {
		return repaymentAmount;
	}

	public void setRepaymentAmount(BigDecimal repaymentAmount) {
		this.repaymentAmount = repaymentAmount;
	}

	public BigDecimal getReimburseAmount() {
		return reimburseAmount;
	}

	public void setReimburseAmount(BigDecimal reimburseAmount) {
		this.reimburseAmount = reimburseAmount;
	}

	public BigDecimal getBuybackAmount() {
		return buybackAmount;
	}

	public void setBuybackAmount(BigDecimal buybackAmount) {
		this.buybackAmount = buybackAmount;
	}

	public BigDecimal getAvailableAmount() {
		return availableAmount;
	}

	public void setAvailableAmount(BigDecimal availableAmount) {
		this.availableAmount = availableAmount;
	}

	public BigDecimal getEarlyWarningAmount() {
		return earlyWarningAmount;
	}

	public void setEarlyWarningAmount(BigDecimal earlyWarningAmount) {
		this.earlyWarningAmount = earlyWarningAmount;
	}

}
