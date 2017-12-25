package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 账款信息
 * 
 * @author guang
 * 
 */
public class AccountVo extends AbstractEntity {
	private static final long serialVersionUID = -6830725473833197509L;
	/**
	 * 账款编号
	 */
	@JSONField(name = "number_")
	private String number_;
	/**
	 * 核心企业id
	 */
	@JSONField(name = "enterprise_id")
	private String enterprise_id;
	/**
	 * 保理商企业id
	 */
	@JSONField(name = "factor_enterprise_id")
	private String factor_enterprise_id;
	/**
	 * 供应商商id
	 */
	@JSONField(name = "supplier_enterprise_id")
	private String supplier_enterprise_id;

	/**
	 * 核心企业名称
	 */
	@JSONField(name = "enterprise_name")
	private String enterprise_name;
	/**
	 * 保理商企业名称
	 */
	@JSONField(name = "factor_enterprise_name")
	private String factor_enterprise_name;
	/**
	 * 供应商企业名称
	 */
	@JSONField(name = "supplier_enterprise_name")
	private String supplier_enterprise_name;

	/**
	 * 最小日期
	 */
	@JSONField(name = "min_invoice_date",format="yyyy-MM-dd")
	private Date min_invoice_date;
	/**
	 * 最大查询日期
	 */
	@JSONField(name = "max_invoice_date",format="yyyy-MM-dd")
	private Date max_invoice_date;
	
	/**
	 * 最小申请日期
	 */
	@JSONField(name = "min_apply_date",format="yyyy-MM-dd")
	private Date min_apply_date;
	/**
	 * 最大申请日期
	 */
	@JSONField(name = "max_apply_date",format="yyyy-MM-dd")
	private Date max_apply_date;
	
	/**
	 * 最小确认日期
	 */
	@JSONField(name = "min_affirm_date",format="yyyy-MM-dd")
	private Date min_affirm_date;

	/**
	 * 最大确认日期
	 */
	@JSONField(name = "max_affirm_date",format="yyyy-MM-dd")
	private Date max_affirm_date;

	/**
	 * 审核日期
	 */
	@JSONField(name = "audit_date",format="yyyy-MM-dd")
	private Date audit_date;

	/**
	 * 结算放款日期
	 */
	@JSONField(name = "disbursement_date",format="yyyy-MM-dd")
	private Date disbursement_date;

	/**
	 * 最大查询结算放款日期
	 */
	@JSONField(name = "disbursement_max_date",format="yyyy-MM-dd")
	private Date disbursement_max_date;

	/**
	 * 账款状态
	 */
	@JSONField(name = "status_")
	private String status_;
	
	/**
	 * 审核状态
	 */
	@JSONField(name = "audit_status")
	private String audit_status;
	
	/**
	 * 审核结果
	 */
	@JSONField(name = "operation_")
	private String operation_;
	
	/**
	 * 金额
	 */
	@JSONField(name = "amount_")
	private String amount_;

	public String getNumber_() {
		return number_;
	}

	public void setNumber_(String number_) {
		this.number_ = number_;
	}

	public String getEnterprise_id() {
		return enterprise_id;
	}

	public void setEnterprise_id(String enterprise_id) {
		this.enterprise_id = enterprise_id;
	}

	
	
	public String getFactor_enterprise_id() {
		return factor_enterprise_id;
	}

	public void setFactor_enterprise_id(String factor_enterprise_id) {
		this.factor_enterprise_id = factor_enterprise_id;
	}

	public String getEnterprise_name() {
		return enterprise_name;
	}

	public void setEnterprise_name(String enterprise_name) {
		this.enterprise_name = enterprise_name;
	}
	
	public String getFactor_enterprise_name() {
		return factor_enterprise_name;
	}

	public void setFactor_enterprise_name(String factor_enterprise_name) {
		this.factor_enterprise_name = factor_enterprise_name;
	}

	public String getSupplier_enterprise_name() {
		return supplier_enterprise_name;
	}

	public void setSupplier_enterprise_name(String supplier_enterprise_name) {
		this.supplier_enterprise_name = supplier_enterprise_name;
	}

	public Date getMin_invoice_date() {
		return min_invoice_date;
	}

	public void setMin_invoice_date(Date min_invoice_date) {
		this.min_invoice_date = min_invoice_date;
	}

	public Date getMax_invoice_date() {
		return max_invoice_date;
	}

	public void setMax_invoice_date(Date max_invoice_date) {
		this.max_invoice_date = max_invoice_date;
	}

	public Date getMin_affirm_date() {
		return min_affirm_date;
	}

	public void setMin_affirm_date(Date min_affirm_date) {
		this.min_affirm_date = min_affirm_date;
	}

	public Date getMax_affirm_date() {
		return max_affirm_date;
	}

	public void setMax_affirm_date(Date max_affirm_date) {
		this.max_affirm_date = max_affirm_date;
	}

	public Date getAudit_date() {
		return audit_date;
	}

	public void setAudit_date(Date audit_date) {
		this.audit_date = audit_date;
	}

	public Date getDisbursement_date() {
		return disbursement_date;
	}

	public void setDisbursement_date(Date disbursement_date) {
		this.disbursement_date = disbursement_date;
	}

	public Date getDisbursement_max_date() {
		return disbursement_max_date;
	}

	public void setDisbursement_max_date(Date disbursement_max_date) {
		this.disbursement_max_date = disbursement_max_date;
	}

	public String getStatus_() {
		return status_;
	}

	public void setStatus_(String status_) {
		this.status_ = status_;
	}

	public String getAmount_() {
		return amount_;
	}

	public void setAmount_(String amount_) {
		this.amount_ = amount_;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getSupplier_enterprise_id() {
		return supplier_enterprise_id;
	}

	public void setSupplier_enterprise_id(String supplier_enterprise_id) {
		this.supplier_enterprise_id = supplier_enterprise_id;
	}

	public Date getMin_apply_date() {
		return min_apply_date;
	}

	public void setMin_apply_date(Date min_apply_date) {
		this.min_apply_date = min_apply_date;
	}

	public Date getMax_apply_date() {
		return max_apply_date;
	}

	public void setMax_apply_date(Date max_apply_date) {
		this.max_apply_date = max_apply_date;
	}

	public String getAudit_status() {
		return audit_status;
	}

	public void setAudit_status(String audit_status) {
		this.audit_status = audit_status;
	}

	public String getOperation_() {
		return operation_;
	}

	public void setOperation_(String operation_) {
		this.operation_ = operation_;
	}
	

}
