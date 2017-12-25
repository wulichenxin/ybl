package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 资金方收款管理还款计划
 */
public class SecuredLoanRepaymentVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5975178824613751916L;
	
	/*放款申请订单号*/	
	@JSONField(name="order_no")
	private String orderNo;
	/*申请单位*/
	@JSONField(name="enterprise_name")
	private String enterpriseName;
	/*资产类型*/
	@JSONField(name="assets_type")
	private Integer assetsType;
	/*申请融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*实际放款金额*/
	@JSONField(name="actual_loan_amount")
	private BigDecimal actualloanAmount;
	/*融资期限*/
	@JSONField(name = "financing_term")
	private String financingTerm;
	/*融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*状态*/
	@JSONField(name="status")
	private Integer status;
	/*实际放款时间*/
	@JSONField(name = "actual_loan_date",format="yyyy-MM-dd")
	private Date actualloanDate;
	/*融资子订单号*/
	@JSONField(name="order_no_apply")
	private String orderNoApply;
	/*资金方ID*/
	@JSONField(name="business_id")
	private Long business_id;
	/*付款批次ID*/
	@JSONField(name="payment_batch_id")
	private Long paymentBatchId;
	/*融资子订单ID*/
	@JSONField(name="sub_financing_apply_id")
	private Long subFinancingApplyId;
	/*融资方收款确认时间*/
	@JSONField(name = "confirm_date",format="yyyy-MM-dd")
	private Date confirmDate;
	/*融资方收款确认状态*/
	@JSONField(name="repayment_status")
	private Integer repaymentStatus;
	
	//临时字段--付款开始时间，结束时间，确认开始时间、结束时间
	@JSONField(name="payStartDate")
	private String payStartDate;
	
	@JSONField(name="payEndDate")
	private String payEndDate;
	
	@JSONField(name="confirmStartDate")
	private String confirmStartDate;
	
	@JSONField(name="confirmEndDate")
	private String confirmEndDate;

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	
	public Integer getAssetsType() {
		return assetsType;
	}

	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}

	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}

	public void setFinancingAmount(BigDecimal financingAmount) {
		this.financingAmount = financingAmount;
	}

	public BigDecimal getActualloanAmount() {
		return actualloanAmount;
	}

	public void setActualloanAmount(BigDecimal actualloanAmount) {
		this.actualloanAmount = actualloanAmount;
	}

	public BigDecimal getFinancingRate() {
		return financingRate;
	}

	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public String getOrderNoApply() {
		return orderNoApply;
	}

	public void setOrderNoApply(String orderNoApply) {
		this.orderNoApply = orderNoApply;
	}

	public String getPayStartDate() {
		return payStartDate;
	}

	public void setPayStartDate(String payStartDate) {
		this.payStartDate = payStartDate;
	}

	public String getPayEndDate() {
		return payEndDate;
	}

	public void setPayEndDate(String payEndDate) {
		this.payEndDate = payEndDate;
	}

	public String getConfirmStartDate() {
		return confirmStartDate;
	}

	public void setConfirmStartDate(String confirmStartDate) {
		this.confirmStartDate = confirmStartDate;
	}

	public String getConfirmEndDate() {
		return confirmEndDate;
	}

	public void setConfirmEndDate(String confirmEndDate) {
		this.confirmEndDate = confirmEndDate;
	}

	public String getFinancingTerm() {
		return financingTerm;
	}

	public void setFinancingTerm(String financingTerm) {
		this.financingTerm = financingTerm;
	}

	public Date getActualloanDate() {
		return actualloanDate;
	}

	public void setActualloanDate(Date actualloanDate) {
		this.actualloanDate = actualloanDate;
	}

	public Long getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(Long business_id) {
		this.business_id = business_id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	public Integer getRepaymentStatus() {
		return repaymentStatus;
	}

	public void setRepaymentStatus(Integer repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}

	public Long getPaymentBatchId() {
		return paymentBatchId;
	}

	public void setPaymentBatchId(Long paymentBatchId) {
		this.paymentBatchId = paymentBatchId;
	}

	public Long getSubFinancingApplyId() {
		return subFinancingApplyId;
	}

	public void setSubFinancingApplyId(Long subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}

	
}
