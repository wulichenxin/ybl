package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 资金方风控审核记录
 */
public class FactorRiskManagementAuditHistoryVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7008648377787058350L;
	/*融资申请子订单id*/	
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	/*审核类型：1-资方风控初审2-资方风控终审*/
	@JSONField(name="audit_type")
	private Integer auditType;
	/*融资企业*/
	@NotBlank
	@Length(min=2,max=25)
	@JSONField(name="financing_enterprise")
	private String financingEnterprise;
	/*审核人*/
	@JSONField(name="auditor")
	private String auditor;
	/*意见编号*/
	@NotBlank
	@Length(min=1,max=25)
	@JSONField(name="opinion_number")
	private String opinionNumber;
	/*融资金额*/
	@NotNull
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*融资期限*/
	@NotNull
	@Min(value = 1)
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/*融资期限单位*/
	@JSONField(name="financing_term_unit")
	private Integer financingTermUnit;
	/*收费方式1-融资利率2-服务费3-折后转让*/
	@NotNull
	@Min(value = 1)
	@Max(value = 3)
	@JSONField(name="fee_mode")
	private Integer feeMode;
	/*融资利率*/
	@Min(value = 0)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*服务费*/
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	/*折后转让金额*/
	@Min(value = 1)
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name="transfer_money")
	private BigDecimal transferMoney;
	/*融资说明*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="financing_explain")
	private String financingExplain;
	/*交易结构*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="transaction_structure")
	private String transactionStructure;
	/*增信措施*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="trust_measure")
	private String trustMeasure;
	/*审核意见*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name="audit_opinion")
	private String auditOpinion;
	/*审核日期*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name = "audit_date", format = "yyyy-MM-dd")
	private Date auditDate;
	/*备注*/
	@NotBlank
	@Length(min=1,max=127)
	@JSONField(name = "remark")
	private String remark;
	/*审核结果：1-通过2-不通过3-驳回*/
	@JSONField(name = "audit_result")
	@NotNull
	@Min(value = 1)
	@Max(value = 3)
	private Integer auditResult;
	
	public String getOpinionNumber() {
		return opinionNumber;
	}
	public Integer getFinancingTermUnit() {
		return financingTermUnit;
	}
	public void setFinancingTermUnit(Integer financingTermUnit) {
		this.financingTermUnit = financingTermUnit;
	}
	public BigDecimal getTransferMoney() {
		return transferMoney;
	}
	public void setTransferMoney(BigDecimal transferMoney) {
		this.transferMoney = transferMoney;
	}
	public void setOpinionNumber(String opinionNumber) {
		this.opinionNumber = opinionNumber;
	}
	public String getAuditor() {
		return auditor;
	}
	public void setAuditor(String auditor) {
		this.auditor = auditor;
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
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Integer financingTerm) {
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
