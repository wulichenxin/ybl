package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;


import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 资金方放款审核
 */
public class FactorLoanAuditVo extends AbstractEntity {

	private static final long serialVersionUID = 4402943542853793519L;
	
	//融资申请id
	@JSONField(name="financing_apply_id")
	private Integer financingApplyId;
	//融资母订单的融资状态
	@JSONField(name="financing_status")
	private Integer financingStatus;
	//子融资申请id
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	//付款批次id
	@JSONField(name="payment_batch_id")
	private Integer paymentBatchId;
	//放款申请单号
	@JSONField(name="order_no")
	private String orderNo;
	//融资方名称
	@JSONField(name="financier")
	private String financier;
	//资产类型
	@JSONField(name="assets_type")
	private Integer assetsType;
	//申请放款金额
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;	
	//融资期限
	@JSONField(name="financing_term")
	private Integer financingTerm;
	//融资利率
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	//关联融资申请单号
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	//放款状态
	@JSONField(name="status")
	private Integer status;
	//放款申请时间-起始时间
	@JSONField(name="start_apply_date")
	private String startApplyDate;
	//放款申请时间-截止时间
	@JSONField(name="end_apply_date")
	private String endApplyDate;
	//业务id线下确权为资金方线上确权为核心企业
	@JSONField(name="right_business_id")
	private Long rightBusinessId;
	@JSONField(name="business_id")
	private Long businessId;
	
	public Long getRightBusinessId() {
		return rightBusinessId;
	}
	public void setRightBusinessId(Long rightBusinessId) {
		this.rightBusinessId = rightBusinessId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getFinancier() {
		return financier;
	}
	public Long getBusinessId() {
		return businessId;
	}
	public Integer getPaymentBatchId() {
		return paymentBatchId;
	}
	public void setPaymentBatchId(Integer paymentBatchId) {
		this.paymentBatchId = paymentBatchId;
	}
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	public void setFinancier(String financier) {
		this.financier = financier;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}
	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}
	public void setFinancingAmount(BigDecimal financingAmount) {
		this.financingAmount = financingAmount;
	}
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStartApplyDate() {
		return startApplyDate;
	}
	public void setStartApplyDate(String startApplyDate) {
		this.startApplyDate = startApplyDate;
	}
	public String getEndApplyDate() {
		return endApplyDate;
	}
	public void setEndApplyDate(String endApplyDate) {
		this.endApplyDate = endApplyDate;
	}
	
	
	
}
