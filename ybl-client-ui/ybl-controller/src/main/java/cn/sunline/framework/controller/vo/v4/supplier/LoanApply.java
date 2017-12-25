package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 放款申请实体
 * @author xxx
 *
 */
public class LoanApply extends AbstractEntity{

	private static final long serialVersionUID = 1L;

	@JSONField(name = "order_no")
	private String orderNo; //放款订单号
	@JSONField(name = "sub_financing_apply_id")
	private Integer subFinancingApplyId; //融资申请子订单id
	@JSONField(name = "right_business_id")
	private Integer rightBusinessId; //业务id线下确权为资金方线上确权为核心企业，与子融资订单的business_id不是同一个
	@JSONField(name = "payment_batch_id")
	private Integer paymentBatchId; //付款批次id
	@JSONField(name = "enterprise_name")
	private String enterpriseName; //申请单位
	@JSONField(name="master_contract_no")
	private String masterContractNo; //主合同号
	@JSONField(name="status")
	private Integer status; //放款申请状态 1-待提交2-待资方办理3-待确权4-待平台审核5-待放款未生成放款批次6-待放款确认7-放款完成8-待放款已生成放款批次99-放款失败
	@JSONField(name="right_remark")
	private String rightRemark; //确权备注
	@JSONField(name="platform_audit")
	private Integer platformAudit; //平台审核结果：1-通过2-不通过
	@JSONField(name="platform_remark")
	private String platformRemark; // 平台审核备注
	@JSONField(name="financier")
	private String financier; //融资方
	@JSONField(name="financing_amount")
	private BigDecimal financing_amount; // 融资金额
	@JSONField(name = "financing_term")
	private Integer financingTerm; //融资期限
	@JSONField(name = "financing_rate")
	private BigDecimal financingRate; //融资利率
	@JSONField(name = "trust_measure")
	private String trustMeasure; //增信措施
	@JSONField(name = "financing_demand_remark")
	private String financingDemandRemark; //融资需求备注
	@JSONField(name = "assets_type")
	private Integer assetsType;// 资产类型
	@JSONField(name = "financier_business_id")
	private Integer financierBusinessId;
	@JSONField(name = "financing_order_number")
	private String financingOrderNumber;
	@JSONField(name = "funder_name")
	private String funderName;
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}
	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}
	public Integer getRightBusinessId() {
		return rightBusinessId;
	}
	public void setRightBusinessId(Integer rightBusinessId) {
		this.rightBusinessId = rightBusinessId;
	}
	public Integer getPaymentBatchId() {
		return paymentBatchId;
	}
	public void setPaymentBatchId(Integer paymentBatchId) {
		this.paymentBatchId = paymentBatchId;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRightRemark() {
		return rightRemark;
	}
	public void setRightRemark(String rightRemark) {
		this.rightRemark = rightRemark;
	}
	public Integer getPlatformAudit() {
		return platformAudit;
	}
	public void setPlatformAudit(Integer platformAudit) {
		this.platformAudit = platformAudit;
	}
	public String getPlatformRemark() {
		return platformRemark;
	}
	public void setPlatformRemark(String platformRemark) {
		this.platformRemark = platformRemark;
	}
	public String getFinancier() {
		return financier;
	}
	public void setFinancier(String financier) {
		this.financier = financier;
	}
	public BigDecimal getFinancing_amount() {
		return financing_amount;
	}
	public void setFinancing_amount(BigDecimal financing_amount) {
		this.financing_amount = financing_amount;
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
	public String getTrustMeasure() {
		return trustMeasure;
	}
	public void setTrustMeasure(String trustMeasure) {
		this.trustMeasure = trustMeasure;
	}
	public String getFinancingDemandRemark() {
		return financingDemandRemark;
	}
	public void setFinancingDemandRemark(String financingDemandRemark) {
		this.financingDemandRemark = financingDemandRemark;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public Integer getFinancierBusinessId() {
		return financierBusinessId;
	}
	public void setFinancierBusinessId(Integer financierBusinessId) {
		this.financierBusinessId = financierBusinessId;
	}
	public String getFunderName() {
		return funderName;
	}
	public void setFunderName(String funderName) {
		this.funderName = funderName;
	}
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	
}
