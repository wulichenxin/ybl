package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 合同信息
 * 
 * @author guang
 * 
 */
public class ContractVo extends AbstractEntity {
	private static final long serialVersionUID = -6830725473833197509L;
	/**
	 * 业务合同号
	 */
	@JSONField(name = "number_")
	private String number;
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
	 * 资金来源名称
	 */
	@JSONField(name = "fund_source_name")
	private String fundSourceName;

	/**
	 * 有效日期开始时间
	 */
	@JSONField(name = "begin_time",format="yyyy-MM-dd")
	private Date beginTime;

	/**
	 * 有效日期结束时间
	 */
	@JSONField(name = "end_time",format="yyyy-MM-dd")
	private Date endTime;
	/**
	 * 合同状态
	 */
	@JSONField(name = "status_")
	private String status;
	/**
	 * 合同负责人
	 */
	@JSONField(name = "contract_person")
	private String contractPerson;
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
	 * 资金来源方
	 */
	@JSONField(name = "funds_source_id")
	private String fundsSourceId;
	/**
	 * 供应商授信额度
	 */
	@JSONField(name = "credit_amount")
	private String creditAmount;
	/**
	 * 保证金
	 */
	@JSONField(name = "deposit_")
	private String deposit;
	/**
	 * 临时额度
	 */
	@JSONField(name = "quota_")
	private String quota;
	/**
	 * 最大固定额度
	 */
	@JSONField(name = "credit_amount_max")
	private String creditAmountMax;

	/**
	 * 结算比例
	 */
	@JSONField(name = "settlement_ratio")
	private String settlementRatio;
	/**
	 * 结算时间
	 */
	@JSONField(name = "settlement_time")
	private String settlementTime;

	/**
	 * 保理手续费率
	 */
	@JSONField(name = "factoring_fees")
	private String factoringFees;
	/**
	 * 手续期结算方式
	 */
	@JSONField(name = "settlement_type")
	private String settlementType;
	/**
	 * 贷款利率
	 */
	@JSONField(name = "lending_rates")
	private String lendingRates;

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
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

	public String getFundSourceName() {
		return fundSourceName;
	}

	public void setFundSourceName(String fundSourceName) {
		this.fundSourceName = fundSourceName;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getContractPerson() {
		return contractPerson;
	}

	public void setContractPerson(String contractPerson) {
		this.contractPerson = contractPerson;
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

	public String getCreditAmount() {
		return creditAmount;
	}

	public void setCreditAmount(String creditAmount) {
		this.creditAmount = creditAmount;
	}

	public String getDeposit() {
		return deposit;
	}

	public void setDeposit(String deposit) {
		this.deposit = deposit;
	}

	public String getQuota() {
		return quota;
	}

	public void setQuota(String quota) {
		this.quota = quota;
	}

	public String getCreditAmountMax() {
		return creditAmountMax;
	}

	public void setCreditAmountMax(String creditAmountMax) {
		this.creditAmountMax = creditAmountMax;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public String getSettlementRatio() {
		return settlementRatio;
	}

	public void setSettlementRatio(String settlementRatio) {
		this.settlementRatio = settlementRatio;
	}

	public String getSettlementTime() {
		return settlementTime;
	}

	public void setSettlementTime(String settlementTime) {
		this.settlementTime = settlementTime;
	}

	public String getFactoringFees() {
		return factoringFees;
	}

	public void setFactoringFees(String factoringFees) {
		this.factoringFees = factoringFees;
	}

	public String getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(String settlementType) {
		this.settlementType = settlementType;
	}

	public String getLendingRates() {
		return lendingRates;
	}

	public void setLendingRates(String lendingRates) {
		this.lendingRates = lendingRates;
	}

	public String getFundsSourceId() {
		return fundsSourceId;
	}

	public void setFundsSourceId(String fundsSourceId) {
		this.fundsSourceId = fundsSourceId;
	}

}
