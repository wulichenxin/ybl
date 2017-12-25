package cn.sunline.framework.controller.vo.v4.supplier;



import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方终审复合类型
 */
public class SupplierRiskManagementAuditVO extends AbstractEntity {

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
	@JSONField(name="financing_enterprise")
	private String financingEnterprise;
	/*审核人*/
	@JSONField(name="auditor")
	private String auditor;
	/*意见编号*/
	@JSONField(name="opinion_number")
	private String opinionNumber;
	/*融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*融资期限*/
	@JSONField(name="financing_term", format = "yyyy-MM-dd")
	private Integer financingTerm;
	/*收费方式1-融资利率2-服务费*/
	@JSONField(name="fee_mode")
	private Integer feeMode;
	/*融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*服务费*/
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	
	/*
	 * 转让金额
	 */
	@JSONField(name="transfer_money")
	private BigDecimal transferMoney;
	
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
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JSONField(name = "audit_date", format = "yyyy-MM-dd")
	private Date auditDate;
	/*备注*/
	@JSONField(name = "remark")
	private String remark;
	/*审核结果：1-通过2-不通过3-驳回*/
	@JSONField(name = "audit_result")
	private Integer auditResult;
	
	@JSONField(name = "inver_name")
	private String inverName;
	
	/*附件id*/
	@JSONField(name = "attachment_id")
	private Integer attachmentId;
	/*附件备注*/
	@JSONField(name = "attachment_remark")
	private Integer attachmentRemark;
	/*合作要素表编号*/
	@JSONField(name = "elements_order_no")
	private String elementsOrderNo;
	/*合作要素融资企业*/
	@JSONField(name = "elements_financing_enterprise")
	private String elementsFinancingEnterprise;
	
	/*合作要素批复额度*/
	@JSONField(name = "elements_give_quota")
	private BigDecimal elementsGiveQuota;
	/*合作要素融资期限*/
	@JSONField(name = "elements_financing_term")
	private Integer elementsFinancingTerm;
	/*合作要素收费方式*/
	@JSONField(name = "elements_fee_mode")
	private Integer elementsFeeMode;
	
	/*合作要素融资利率*/
	@JSONField(name = "elements_financing_rate")
	private BigDecimal elementsFinancingRate;
	/*合作要素服务费*/
	@JSONField(name = "elements_service_fee")
	private BigDecimal elementsServiceFee;
	
	/*合作要素资产类型*/
	@JSONField(name = "elements_assets_type")
	private Integer elementsAssetsType;
	/*合作要素还款方式*/
	@JSONField(name = "elements_repayment_mode")
	private Integer elementsRepaymentMode;
	/*合作要素放款条件*/
	@JSONField(name = "elements_loan_terms")
	private String elementsLoanTerms;
	/*合作要素备注*/
	@JSONField(name = "elements_remark")
	private String elementsRemark;
	/*融资申请id*/
	@JSONField(name = "financing_apply_id")
	private Integer financingApplyId;
	/*合作要素id*/
	@JSONField(name = "elements_id")
	private Integer elementsId;
	/*合作要素日期*/
	@JSONField(name = "elements_audit_date")
	private Date elementsAuditDate;
	
	/*
	 * 合作要素表转让金额
	 */
	@JSONField(name = "elements_transfer_money")
	private BigDecimal elementsTransferMoney;
	
	
	
	
	
	
	public BigDecimal getElementsTransferMoney() {
		return elementsTransferMoney;
	}
	public void setElementsTransferMoney(BigDecimal elementsTransferMoney) {
		this.elementsTransferMoney = elementsTransferMoney;
	}
	public BigDecimal getTransferMoney() {
		return transferMoney;
	}
	public void setTransferMoney(BigDecimal transferMoney) {
		this.transferMoney = transferMoney;
	}
	public String getInverName() {
		return inverName;
	}
	public void setInverName(String inverName) {
		this.inverName = inverName;
	}
	public Date getElementsAuditDate() {
		return elementsAuditDate;
	}
	public void setElementsAuditDate(Date elementsAuditDate) {
		this.elementsAuditDate = elementsAuditDate;
	}
	public Integer getAttachmentId() {
		return attachmentId;
	}
	public void setAttachmentId(Integer attachmentId) {
		this.attachmentId = attachmentId;
	}
	public Integer getAttachmentRemark() {
		return attachmentRemark;
	}
	public void setAttachmentRemark(Integer attachmentRemark) {
		this.attachmentRemark = attachmentRemark;
	}
	public String getElementsOrderNo() {
		return elementsOrderNo;
	}
	public void setElementsOrderNo(String elementsOrderNo) {
		this.elementsOrderNo = elementsOrderNo;
	}
	
	public String getElementsFinancingEnterprise() {
		return elementsFinancingEnterprise;
	}
	public void setElementsFinancingEnterprise(String elementsFinancingEnterprise) {
		this.elementsFinancingEnterprise = elementsFinancingEnterprise;
	}
	public BigDecimal getElementsGiveQuota() {
		return elementsGiveQuota;
	}
	public void setElementsGiveQuota(BigDecimal elementsGiveQuota) {
		this.elementsGiveQuota = elementsGiveQuota;
	}
	public Integer getElementsFinancingTerm() {
		return elementsFinancingTerm;
	}
	public void setElementsFinancingTerm(Integer elementsFinancingTerm) {
		this.elementsFinancingTerm = elementsFinancingTerm;
	}
	public Integer getElementsFeeMode() {
		return elementsFeeMode;
	}
	public void setElementsFeeMode(Integer elementsFeeMode) {
		this.elementsFeeMode = elementsFeeMode;
	}
	public BigDecimal getElementsFinancingRate() {
		return elementsFinancingRate;
	}
	public void setElementsFinancingRate(BigDecimal elementsFinancingRate) {
		this.elementsFinancingRate = elementsFinancingRate;
	}
	public BigDecimal getElementsServiceFee() {
		return elementsServiceFee;
	}
	public void setElementsServiceFee(BigDecimal elementsServiceFee) {
		this.elementsServiceFee = elementsServiceFee;
	}
	public Integer getElementsAssetsType() {
		return elementsAssetsType;
	}
	public void setElementsAssetsType(Integer elementsAssetsType) {
		this.elementsAssetsType = elementsAssetsType;
	}
	public Integer getElementsRepaymentMode() {
		return elementsRepaymentMode;
	}
	public void setElementsRepaymentMode(Integer elementsRepaymentMode) {
		this.elementsRepaymentMode = elementsRepaymentMode;
	}
	public String getElementsLoanTerms() {
		return elementsLoanTerms;
	}
	public void setElementsLoanTerms(String elementsLoanTerms) {
		this.elementsLoanTerms = elementsLoanTerms;
	}
	public String getElementsRemark() {
		return elementsRemark;
	}
	public void setElementsRemark(String elementsRemark) {
		this.elementsRemark = elementsRemark;
	}
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public Integer getElementsId() {
		return elementsId;
	}
	public void setElementsId(Integer elementsId) {
		this.elementsId = elementsId;
	}
	public String getOpinionNumber() {
		return opinionNumber;
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

