package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableBillVo extends AbstractEntity{

	/**
	 * 账款发票表
	 */
	private static final long serialVersionUID = 5784066131697003047L;
	
	//账款id
	private Long accountsReceivableBillId;
	//发票编号
	private String billNumber;
	//发票金额
	private BigDecimal billAmount;
	//联次
	private String billType;
	//开票日期
	private String billInvoiceDate;
	//开发单位
	private String invoiceIssuingEntity;
	//开票负责人
	private String invoicePrincipal;
	//企业id
	private Long enterpriseId;
	
	
	
	@JSONField(name="number_")
	public String getBillNumber() {
		return billNumber;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="accounts_receivable_id")
	public Long getAccountsReceivableBillId() {
		return accountsReceivableBillId;
	}
	@JSONField(name="accounts_receivable_id")
	public void setAccountsReceivableBillId(Long accountsReceivableBillId) {
		this.accountsReceivableBillId = accountsReceivableBillId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@JSONField(name="number_")
	public void setBillNumber(String billNumber) {
		this.billNumber = billNumber;
	}
	@JSONField(name="amount_")
	public BigDecimal getBillAmount() {
		return billAmount;
	}
	@JSONField(name="amount_")
	public void setBillAmount(BigDecimal billAmount) {
		this.billAmount = billAmount;
	}
	@JSONField(name="type_")
	public String getBillType() {
		return billType;
	}
	@JSONField(name="type_")
	public void setBillType(String billType) {
		this.billType = billType;
	}
	@JSONField(name="invoice_date")
	public String getBillInvoiceDate() {
		return billInvoiceDate;
	}
	@JSONField(name="invoice_date")
	public void setBillInvoiceDate(String billInvoiceDate) {
		this.billInvoiceDate = billInvoiceDate;
	}
	@JSONField(name="invoice_issuing_entity")
	public String getInvoiceIssuingEntity() {
		return invoiceIssuingEntity;
	}
	@JSONField(name="invoice_issuing_entity")
	public void setInvoiceIssuingEntity(String invoiceIssuingEntity) {
		this.invoiceIssuingEntity = invoiceIssuingEntity;
	}
	@JSONField(name="invoice_principal")
	public String getInvoicePrincipal() {
		return invoicePrincipal;
	}
	@JSONField(name="invoice_principal")
	public void setInvoicePrincipal(String invoicePrincipal) {
		this.invoicePrincipal = invoicePrincipal;
	}
	
}
