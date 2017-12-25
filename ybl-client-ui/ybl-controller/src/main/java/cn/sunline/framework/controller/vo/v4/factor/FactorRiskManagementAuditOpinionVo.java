package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 资金方风控审核记录
 */
public class FactorRiskManagementAuditOpinionVo {

	/*会员id*/
	@JSONField(name="member_id")
	private Integer memberId;
	/*融资申请子订单id*/	
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	/*审核类型：1-资方风控初审2-资方风控终审*/
	@JSONField(name="audit_type")
	private Integer auditType;
	/*融资企业*/
	@JSONField(name="financing_enterprise")
	private String financingEnterprise;
	/*融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*融资期限*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="financing_term", format = "yyyy-MM-dd")
	private Date financingTerm;
	/*收费方式1-融资利率2-服务费*/
	@JSONField(name="fee_mode")
	private Integer feeMode;
	/*融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*服务费*/
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	/*融资说明*/
	@JSONField(name="financing_explain")
	private String financingExplain;
	/*交易结构*/
	@JSONField(name="transaction_structure")
	private String transactionStructure;
	/*增信措施*/
	@JSONField(name="trust_measure")
	private String trustMeasure;
	/*审核意见*/
	@JSONField(name="audit_opinion")
	private String auditOpinion;
	/*审核日期*/
	@JSONField(name = "audit_date")
	private Date auditDate;
	/*备注*/
	@JSONField(name = "remark")
	private String remark;
	/*审核结果：1-通过2-不通过3-驳回*/
	@JSONField(name = "audit_result")
	private Integer auditResult;
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}
	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}
	public Integer getAuditType() {
		return auditType;
	}
	public void setAuditType(Integer auditType) {
		this.auditType = auditType;
	}
	public String getFinancingEnterprise() {
		return financingEnterprise;
	}
	public void setFinancingEnterprise(String financingEnterprise) {
		this.financingEnterprise = financingEnterprise;
	}
	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}
	public void setFinancingAmount(BigDecimal financingAmount) {
		this.financingAmount = financingAmount;
	}
	public Date getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Date financingTerm) {
		this.financingTerm = financingTerm;
	}
	public Integer getFeeMode() {
		return feeMode;
	}
	public void setFeeMode(Integer feeMode) {
		this.feeMode = feeMode;
	}
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public BigDecimal getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(BigDecimal serviceFee) {
		this.serviceFee = serviceFee;
	}
	public String getFinancingExplain() {
		return financingExplain;
	}
	public void setFinancingExplain(String financingExplain) {
		this.financingExplain = financingExplain;
	}
	public String getTransactionStructure() {
		return transactionStructure;
	}
	public void setTransactionStructure(String transactionStructure) {
		this.transactionStructure = transactionStructure;
	}
	public String getTrustMeasure() {
		return trustMeasure;
	}
	public void setTrustMeasure(String trustMeasure) {
		this.trustMeasure = trustMeasure;
	}
	public String getAuditOpinion() {
		return auditOpinion;
	}
	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}
	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getAuditResult() {
		return auditResult;
	}
	public void setAuditResult(Integer auditResult) {
		this.auditResult = auditResult;
	}
	
}
