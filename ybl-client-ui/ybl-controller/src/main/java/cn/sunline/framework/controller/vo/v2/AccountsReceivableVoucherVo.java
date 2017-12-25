package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableVoucherVo extends AbstractEntity{

	/**
	 * 账款凭证商品表实体
	 */
	//账款id
	private Long accountsReceivableVoucherId;
	//凭证编号
	private String voucherNumber;
	//凭证金额
	private BigDecimal voucherAmount;
	//状态
	private String voucherStatus;
	//凭证开票日期
	private String voucherInvoiceDate;
	//预计回款日期
	private String returnDate;
	//开票负责人
	private String voucherRemark;
	//企业id
	private Long enterpriseId;
	
	@JSONField(name="accounts_receivable_id")
	public Long getAccountsReceivableVoucherId() {
		return accountsReceivableVoucherId;
	}
	@JSONField(name="accounts_receivable_id")
	public void setAccountsReceivableVoucherId(Long accountsReceivableVoucherId) {
		this.accountsReceivableVoucherId = accountsReceivableVoucherId;
	}
	@JSONField(name="number_")
	public String getVoucherNumber() {
		return voucherNumber;
	}
	@JSONField(name="number_")
	public void setVoucherNumber(String VoucherNumber) {
		this.voucherNumber = VoucherNumber;
	}
	@JSONField(name="amount_")
	public BigDecimal getVoucherAmount() {
		return voucherAmount;
	}
	@JSONField(name="amount_")
	public void setVoucherAmount(BigDecimal VoucherAmount) {
		this.voucherAmount = VoucherAmount;
	}
	@JSONField(name="status_")
	public String getVoucherStatus() {
		return voucherStatus;
	}
	@JSONField(name="status_")
	public void setVoucherStatus(String voucherStatus) {
		this.voucherStatus = voucherStatus;
	}
	@JSONField(name="remark_")
	public String getVoucherRemark() {
		return voucherRemark;
	}
	@JSONField(name="remark_")
	public void setVoucherRemark(String voucherRemark) {
		this.voucherRemark = voucherRemark;
	}
	@JSONField(name="invoice_date")
	public String getVoucherInvoiceDate() {
		return voucherInvoiceDate;
	}
	@JSONField(name="invoice_date")
	public void setVoucherInvoiceDate(String VoucherInvoiceDate) {
		this.voucherInvoiceDate = VoucherInvoiceDate;
	}
	@JSONField(name="return_date")
	public String getReturnDate() {
		return returnDate;
	}
	@JSONField(name="return_date")
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
}
