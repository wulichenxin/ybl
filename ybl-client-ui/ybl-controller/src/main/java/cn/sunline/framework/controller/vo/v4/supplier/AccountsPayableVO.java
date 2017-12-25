package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 应付账款信息管理VO
 * @author liuls
 *
 */
public class AccountsPayableVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//放款申请id
	private Integer loanApplyId;
	
	/*融资申请id*/
	private Integer financingApplyId;
	
	/*业务id 对应核心企业，与融资订单的business_id不是同一个*/
	private Integer businessId;
	
	/*资产编号*/
	private String assetNumber;
	
	/*供应商名称*/
	private String supplierName;
	
	/*订单信息*/
	private String orderInfo;
	
	/*订单金额*/
	private BigDecimal orderAmount;
	
	/*订单单价*/
	private BigDecimal orderUnitPrice;
	
	/*订单数量*/
	private Integer orderNumber;
	
	/*应付账款金额*/
	private BigDecimal amountsPayableMoney;
	
	/*签署日期*/
	private Date signDate;
	
	/*预计支付日期*/
	private Date expectedPaymentDate;
	
	/*预计支付日期*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="expected_payment_date_actual", format = "yyyy-MM-dd")
	private Date expectedPaymentDateActual;
	
	/*融资期限*/
	private Integer financingTerm;
	
	/*发票信息*/
	private String invoiceInfo;
	
	/*备注*/
	private String remark;
	
	/*转让日期*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="transfer_date", format = "yyyy-MM-dd")
	private Date transferDate;

	/*是否使用1-已使用2-未使用3-占用*/
	private Integer isUse;
	
	/*是否选中,放款申请选择资产时用*/
	private Boolean isCheck;

	/*用于传递修改是否使用状态*/
	private String selectIds;
	
	/*关联资产主id*/
	private Integer pid;
	

	@JSONField(name = "loan_apply_id")
	public Integer getLoanApplyId() {
		return loanApplyId;
	}

	@JSONField(name = "loan_apply_id")
	public void setLoanApplyId(Integer loanApplyId) {
		this.loanApplyId = loanApplyId;
	}

	@JSONField(name = "financing_apply_id")
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}

	public Date getTransferDate() {
		return transferDate;
	}

	public void setTransferDate(Date transferDate) {
		this.transferDate = transferDate;
	}

	@JSONField(name = "financing_apply_id")
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}

	@JSONField(name = "business_id")
	public Integer getBusinessId() {
		return businessId;
	}

	@JSONField(name = "business_id")
	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}
	
	@JSONField(name = "asset_number")
	public String getAssetNumber() {
		return assetNumber;
	}

	@JSONField(name = "asset_number")
	public void setAssetNumber(String assetNumber) {
		this.assetNumber = assetNumber;
	}

	@JSONField(name = "supplier_name")
	public String getSupplierName() {
		return supplierName;
	}

	@JSONField(name = "supplier_name")
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	@JSONField(name = "order_info")
	public String getOrderInfo() {
		return orderInfo;
	}

	@JSONField(name = "order_info")
	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}

	@JSONField(name = "order_amount")
	public BigDecimal getOrderAmount() {
		return orderAmount;
	}

	@JSONField(name = "order_amount")
	public void setOrderAmount(BigDecimal orderAmount) {
		this.orderAmount = orderAmount;
	}

	@JSONField(name = "order_unit_price")
	public BigDecimal getOrderUnitPrice() {
		return orderUnitPrice;
	}

	@JSONField(name = "order_unit_price")
	public void setOrderUnitPrice(BigDecimal orderUnitPrice) {
		this.orderUnitPrice = orderUnitPrice;
	}

	@JSONField(name = "order_number")
	public Integer getOrderNumber() {
		return orderNumber;
	}

	@JSONField(name = "order_number")
	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}

	@JSONField(name = "amounts_payable_money")
	public BigDecimal getAmountsPayableMoney() {
		return amountsPayableMoney;
	}

	@JSONField(name = "amounts_payable_money")
	public void setAmountsPayableMoney(BigDecimal amountsPayableMoney) {
		this.amountsPayableMoney = amountsPayableMoney;
	}

	@JSONField(name = "sign_date",format="yyyy-MM-dd")
	public Date getSignDate() {
		return signDate;
	}

	@JSONField(name = "sign_date",format="yyyy-MM-dd")
	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}

	@JSONField(name = "expected_payment_date",format="yyyy-MM-dd")
	public Date getExpectedPaymentDate() {
		return expectedPaymentDate;
	}

	@JSONField(name = "expected_payment_date",format="yyyy-MM-dd")
	public void setExpectedPaymentDate(Date expectedPaymentDate) {
		this.expectedPaymentDate = expectedPaymentDate;
	}
	
	@JSONField(name = "expected_payment_date_actual",format="yyyy-MM-dd")
	public Date getExpectedPaymentDateActual() {
		return expectedPaymentDateActual;
	}
	
	@JSONField(name = "expected_payment_date_actual",format="yyyy-MM-dd")
	public void setExpectedPaymentDateActual(Date expectedPaymentDateActual) {
		this.expectedPaymentDateActual = expectedPaymentDateActual;
	}
	
	@JSONField(name = "financing_term")
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	
	@JSONField(name = "financing_term")
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}

	@JSONField(name = "invoice_info")
	public String getInvoiceInfo() {
		return invoiceInfo;
	}

	@JSONField(name = "invoice_info")
	public void setInvoiceInfo(String invoiceInfo) {
		this.invoiceInfo = invoiceInfo;
	}

	@JSONField(name = "remark")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "is_use")
	public Integer getIsUse() {
		return isUse;
	}

	@JSONField(name = "is_use")
	public void setIsUse(Integer isUse) {
		this.isUse = isUse;
	}

	public Boolean getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}
	

	@JSONField(name = "selectIds")
	public String getSelectIds() {
		return selectIds;
	}

	@JSONField(name = "selectIds")
	public void setSelectIds(String selectIds) {
		this.selectIds = selectIds;
	}

	@JSONField(name = "p_id")
	public Integer getPid() {
		return pid;
	}

	@JSONField(name = "p_id")
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	
}
