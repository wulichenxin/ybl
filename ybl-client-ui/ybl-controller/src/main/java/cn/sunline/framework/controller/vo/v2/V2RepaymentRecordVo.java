package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class V2RepaymentRecordVo extends AbstractEntity {

	//账款id
	@JSONField(name = "accounts_receivable_id")
	private Long accountsReceivableId;

	//还款日期
	@JSONField(name = "repayment_date")
	private Date repaymentDate;
	
	
	//应还金额
	@JSONField(name = "amount_")
	private BigDecimal amount;
	
	//已还款金额
	@JSONField(name = "actual_amount")
	private BigDecimal actualAmount;
	
	//状态
	@JSONField(name = "status_")
	private String status;
	
	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	//供应商名称
	@JSONField(name = "supplier_enterprise_name")
	private String supplierEnterpriseName;
	
	//核心企业名称
	@JSONField(name = "core_enterprise_name")
	private String coreEnterpriseName;
	
	//凭证编号
	@JSONField(name = "number_")
	private String number;
	
	//实际回款日
	@JSONField(name = "pay_time")
	private Date payTime;

	public Long getAccountsReceivableId() {
		return accountsReceivableId;
	}

	public void setAccountsReceivableId(Long accountsReceivableId) {
		this.accountsReceivableId = accountsReceivableId;
	}

	public Date getRepaymentDate() {
		return repaymentDate;
	}

	public void setRepaymentDate(Date repaymentDate) {
		this.repaymentDate = repaymentDate;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(BigDecimal actualAmount) {
		this.actualAmount = actualAmount;
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

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	
	
}
