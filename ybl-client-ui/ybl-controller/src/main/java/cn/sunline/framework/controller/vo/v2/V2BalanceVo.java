package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//结算管理
public class V2BalanceVo extends AbstractEntity {

	// 标题
	@JSONField(name = "title_")
	private String title;

	// 内容
	@JSONField(name = "content_")
	private String content;

	// 供应商会员id
	@JSONField(name = "supplier_member_id")
	private Long supplierMemberId;

	// 供应商id
	@JSONField(name = "supplier_enterprise_id")
	private Long supplierEnterpriseId;

	// 保理商id
	@JSONField(name = "factoring_enterprise_id")
	private Long factoringEnterpriseId;

	// 核心企业id
	@JSONField(name = "core_enterprise_id")
	private Long coreEnterpriseId;

	// 合同id
	@JSONField(name = "contract_id")
	private Long contractId;

	// 状态
	@JSONField(name = "status_")
	private String status;

	// 单号
	@JSONField(name = "number_")
	private String number;

	// 企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;

	// 供应商名称
	@JSONField(name = "supplier_enterprise_name")
	private String supplierEnterpriseName;

	// 核心企业名称
	@JSONField(name = "core_enterprise_name")
	private String coreEnterpriseName;

	// 凭证号
	@JSONField(name = "voucher_number")
	private String voucherNumber;

	// 计划回款日
	@JSONField(name = "return_date")
	private Date returnDate;

	// 实际回款日
	@JSONField(name = "real_repayment_date")
	private Date realRepaymentDate;

	// 结算日期
	@JSONField(name = "disbursement_date")
	private Date disbursementDate;

	// 实际回购日
	@JSONField(name = "real_buyback_date")
	private Date realBuybackDate;

	// 凭证面额
	@JSONField(name = "voucher_amount")
	private BigDecimal voucherAmount;

	// 实际回款金额
	@JSONField(name = "actual_repayment_amount")
	private BigDecimal actualRepaymentAmount;

	// 结算比例
	@JSONField(name = "settlement_ratio")
	private BigDecimal settlementRatio;

	// 已退款金额
	@JSONField(name = "reimbursed_amount")
	private BigDecimal reimbursedAmount;

	// 已回购金额
	@JSONField(name = "actual_buyback_amount")
	private BigDecimal actualBuybackAmount;

	// 待退款金额
	@JSONField(name = "reimbursement_amount")
	private BigDecimal reimbursementAmount;

	// 回款状态
	@JSONField(name = "repayment_status")
	private String repaymentStatus;

	// 回购状态
	@JSONField(name = "buyback_status")
	private String buybackStatus;

	// 退款状态
	@JSONField(name = "reimbursed_status")
	private String reimbursedStatus;

	// 平台使用费
	@JSONField(name = "manage_fee")
	private BigDecimal manageFee;

	//回购表主表id
	@JSONField(name = "buyback_id")
	private Long buybackId;
	
	//退款主表id
	@JSONField(name = "reimburse_id")
	private Long reimburseId;
	
	//回款主表id
	@JSONField(name = "repayment_id")
	private Long repaymentId;
	
	//待回购金额
	@JSONField(name="to_buyback_amount")
	private BigDecimal toBuybackAmount;
	
	//退款时间
	@JSONField(name="reimburse_time")
	private Date reimburseTime;
	
	public Date getReimburseTime() {
		return reimburseTime;
	}

	public void setReimburseTime(Date reimburseTime) {
		this.reimburseTime = reimburseTime;
	}

	public BigDecimal getToBuybackAmount() {
		return toBuybackAmount;
	}

	public void setToBuybackAmount(BigDecimal toBuybackAmount) {
		this.toBuybackAmount = toBuybackAmount;
	}

	public Date getDisbursementDate() {
		return disbursementDate;
	}

	public void setDisbursementDate(Date disbursementDate) {
		this.disbursementDate = disbursementDate;
	}

	public BigDecimal getManageFee() {
		return manageFee;
	}

	public void setManageFee(BigDecimal manageFee) {
		this.manageFee = manageFee;
	}

	public Long getBuybackId() {
		return buybackId;
	}

	public void setBuybackId(Long buybackId) {
		this.buybackId = buybackId;
	}

	public Long getReimburseId() {
		return reimburseId;
	}

	public void setReimburseId(Long reimburseId) {
		this.reimburseId = reimburseId;
	}

	public Long getRepaymentId() {
		return repaymentId;
	}

	public void setRepaymentId(Long repaymentId) {
		this.repaymentId = repaymentId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getSupplierMemberId() {
		return supplierMemberId;
	}

	public void setSupplierMemberId(Long supplierMemberId) {
		this.supplierMemberId = supplierMemberId;
	}

	public Long getSupplierEnterpriseId() {
		return supplierEnterpriseId;
	}

	public void setSupplierEnterpriseId(Long supplierEnterpriseId) {
		this.supplierEnterpriseId = supplierEnterpriseId;
	}

	public Long getFactoringEnterpriseId() {
		return factoringEnterpriseId;
	}

	public void setFactoringEnterpriseId(Long factoringEnterpriseId) {
		this.factoringEnterpriseId = factoringEnterpriseId;
	}

	public Long getCoreEnterpriseId() {
		return coreEnterpriseId;
	}

	public void setCoreEnterpriseId(Long coreEnterpriseId) {
		this.coreEnterpriseId = coreEnterpriseId;
	}

	public Long getContractId() {
		return contractId;
	}

	public void setContractId(Long contractId) {
		this.contractId = contractId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getSupplierEnterpriseName() {
		return supplierEnterpriseName;
	}

	public void setSupplierEnterpriseName(String supplierEnterpriseName) {
		this.supplierEnterpriseName = supplierEnterpriseName;
	}

	public String getCoreEnterpriseName() {
		return coreEnterpriseName;
	}

	public void setCoreEnterpriseName(String coreEnterpriseName) {
		this.coreEnterpriseName = coreEnterpriseName;
	}

	public String getVoucherNumber() {
		return voucherNumber;
	}

	public void setVoucherNumber(String voucherNumber) {
		this.voucherNumber = voucherNumber;
	}

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public Date getRealRepaymentDate() {
		return realRepaymentDate;
	}

	public void setRealRepaymentDate(Date realRepaymentDate) {
		this.realRepaymentDate = realRepaymentDate;
	}

	public Date getRealBuybackDate() {
		return realBuybackDate;
	}

	public void setRealBuybackDate(Date realBuybackDate) {
		this.realBuybackDate = realBuybackDate;
	}

	public BigDecimal getVoucherAmount() {
		return voucherAmount;
	}

	public void setVoucherAmount(BigDecimal voucherAmount) {
		this.voucherAmount = voucherAmount;
	}

	public BigDecimal getActualRepaymentAmount() {
		return actualRepaymentAmount;
	}

	public void setActualRepaymentAmount(BigDecimal actualRepaymentAmount) {
		this.actualRepaymentAmount = actualRepaymentAmount;
	}

	public BigDecimal getSettlementRatio() {
		return settlementRatio;
	}

	public void setSettlementRatio(BigDecimal settlementRatio) {
		this.settlementRatio = settlementRatio;
	}

	public BigDecimal getReimbursedAmount() {
		return reimbursedAmount;
	}

	public void setReimbursedAmount(BigDecimal reimbursedAmount) {
		this.reimbursedAmount = reimbursedAmount;
	}

	public BigDecimal getActualBuybackAmount() {
		return actualBuybackAmount;
	}

	public void setActualBuybackAmount(BigDecimal actualBuybackAmount) {
		this.actualBuybackAmount = actualBuybackAmount;
	}

	public BigDecimal getReimbursementAmount() {
		return reimbursementAmount;
	}

	public void setReimbursementAmount(BigDecimal reimbursementAmount) {
		this.reimbursementAmount = reimbursementAmount;
	}

	public String getRepaymentStatus() {
		return repaymentStatus;
	}

	public void setRepaymentStatus(String repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}

	public String getBuybackStatus() {
		return buybackStatus;
	}

	public void setBuybackStatus(String buybackStatus) {
		this.buybackStatus = buybackStatus;
	}

	public String getReimbursedStatus() {
		return reimbursedStatus;
	}

	public void setReimbursedStatus(String reimbursedStatus) {
		this.reimbursedStatus = reimbursedStatus;
	}

}
