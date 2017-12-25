package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 应收账款综合信息
 * 
 * @author guang
 * 
 */
public class ReceivableVo extends AbstractEntity {
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
	 * 预计回款日期
	 */
	@JSONField(name = "return_date",format="yyyy-MM-dd")
	private Date returnDate;
	/**
	 * 最大查询预计回款日期
	 */
	@JSONField(name = "return_max_date",format="yyyy-MM-dd")
	private Date returnMaxDate;
	/**
	 * 申请日期
	 */
	@JSONField(name = "apply_date",format="yyyy-MM-dd")
	private Date applyDate;

	/**
	 * 确认日期
	 */
	@JSONField(name = "confirm_date",format="yyyy-MM-dd")
	private Date confirmDate;

	/**
	 * 审核日期
	 */
	@JSONField(name = "audit_date",format="yyyy-MM-dd")
	private Date auditDate;

	/**
	 * 结算放款日期
	 */
	@JSONField(name = "disbursement_date",format="yyyy-MM-dd")
	private Date disbursementDate;

	/**
	 * 最大查询结算放款日期
	 */
	@JSONField(name = "disbursement_max_date",format="yyyy-MM-dd")
	private Date disbursementMaxDate;

	/**
	 * 融资状态
	 */
	@JSONField(name = "status_")
	private String status;
	/**
	 * 回款状态
	 */
	@JSONField(name = "repayment_status")
	private String repaymentStatus;
	/**
	 * 回购状态
	 */
	@JSONField(name = "buyback_status")
	private String buybackStatus;
	/**
	 * 金额
	 */
	@JSONField(name = "amount_")
	private String amount;
	/**
	 * 已结算金额
	 */
	@JSONField(name = "disbursement_amount")
	private String disbursementAmount;
	/**
	 * 核心企业回款金额
	 */
	@JSONField(name = "repayment_amount")
	private String repaymentAmount;
	/**
	 * 退款金额
	 */
	@JSONField(name = "reimbursed_amount")
	private String reimburseAmount;
	/**
	 * 待退款金额
	 */
	@JSONField(name = "reimbursement_amount")
	private String reimbursementAmount;
	/**
	 * 供应商回购金额
	 */
	@JSONField(name = "buyback_amount")
	private String buybackAmount;

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

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public Date getReturnMaxDate() {
		return returnMaxDate;
	}

	public void setReturnMaxDate(Date returnMaxDate) {
		this.returnMaxDate = returnMaxDate;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public Date getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	public Date getDisbursementDate() {
		return disbursementDate;
	}

	public void setDisbursementDate(Date disbursementDate) {
		this.disbursementDate = disbursementDate;
	}

	public Date getDisbursementMaxDate() {
		return disbursementMaxDate;
	}

	public void setDisbursementMaxDate(Date disbursementMaxDate) {
		this.disbursementMaxDate = disbursementMaxDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRepaymentStatus() {
		return repaymentStatus;
	}

	public void setRepaymentStatus(String repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}

	public String getBuybackStatus() {
		return buybackStatus;
	}

	public void setBuybackStatus(String buybackStatus) {
		this.buybackStatus = buybackStatus;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getDisbursementAmount() {
		return disbursementAmount;
	}

	public void setDisbursementAmount(String disbursementAmount) {
		this.disbursementAmount = disbursementAmount;
	}

	public String getRepaymentAmount() {
		return repaymentAmount;
	}

	public void setRepaymentAmount(String repaymentAmount) {
		this.repaymentAmount = repaymentAmount;
	}

	public String getReimburseAmount() {
		return reimburseAmount;
	}

	public void setReimburseAmount(String reimburseAmount) {
		this.reimburseAmount = reimburseAmount;
	}

	public String getBuybackAmount() {
		return buybackAmount;
	}

	public void setBuybackAmount(String buybackAmount) {
		this.buybackAmount = buybackAmount;
	}

	public String getReimbursementAmount() {
		return reimbursementAmount;
	}

	public void setReimbursementAmount(String reimbursementAmount) {
		this.reimbursementAmount = reimbursementAmount;
	}

}
