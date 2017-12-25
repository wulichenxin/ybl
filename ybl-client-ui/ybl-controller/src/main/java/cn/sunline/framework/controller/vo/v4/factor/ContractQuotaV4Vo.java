package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 合同额度信息
 * @author WIN
 *
 */
public class ContractQuotaV4Vo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5659574983624055652L;
	/**
	 * 主合同号
	 */
	@JSONField(name = "master_contract_no")
	private String masterContractNo;
	/**
	 * 资金方id
	 */
	private	Long factor;
	/**
	 * 融资方id
	 */
	private	Long supplier;
	/**
	 * 融资方公司名称
	 */
	@JSONField(name = "enterprise_name")
	private	String enterpriseName;
	/**
	 * 初始授信额度
	 */
	@JSONField(name = "credit_amount")
	private	BigDecimal creditAmount;
	/**
	 * 最新授信额度
	 */
	@JSONField(name = "new_credit_amount")
	private	BigDecimal	newCreditAmount;
	/**
	 * 预警额度
	 */
	@JSONField(name = "early_warning_amount")
	private	BigDecimal	earlyWarningAmount;
	/**
	 * 临时授信额度
	 */
	@JSONField(name = "quota_amount")
	private	BigDecimal	quotaAmount;
	/**
	 * 累计放款金额
	 */
	@JSONField(name = "disbursement_amount")
	private	BigDecimal	disbursementAmount;
	/**
	 * 累计还款本金
	 */
	@JSONField(name = "repayment_amount")
	private	BigDecimal	repaymentAmount;
	/**
	 * 剩余可用余额
	 */
	@JSONField(name = "all_amount")
	private	BigDecimal	allAmount;
	
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public Long getFactor() {
		return factor;
	}
	public void setFactor(Long factor) {
		this.factor = factor;
	}
	public Long getSupplier() {
		return supplier;
	}
	public void setSupplier(Long supplier) {
		this.supplier = supplier;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public BigDecimal getCreditAmount() {
		return creditAmount;
	}
	public void setCreditAmount(BigDecimal creditAmount) {
		this.creditAmount = creditAmount;
	}
	public BigDecimal getNewCreditAmount() {
		return newCreditAmount;
	}
	public void setNewCreditAmount(BigDecimal newCreditAmount) {
		this.newCreditAmount = newCreditAmount;
	}
	public BigDecimal getEarlyWarningAmount() {
		return earlyWarningAmount;
	}
	public void setEarlyWarningAmount(BigDecimal earlyWarningAmount) {
		this.earlyWarningAmount = earlyWarningAmount;
	}
	public BigDecimal getQuotaAmount() {
		return quotaAmount;
	}
	public void setQuotaAmount(BigDecimal quotaAmount) {
		this.quotaAmount = quotaAmount;
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
	public BigDecimal getAllAmount() {
		return allAmount;
	}
	public void setAllAmount(BigDecimal allAmount) {
		this.allAmount = allAmount;
	}
	
}
