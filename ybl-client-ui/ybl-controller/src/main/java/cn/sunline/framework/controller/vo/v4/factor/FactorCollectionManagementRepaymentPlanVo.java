package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方收款管理还款计划
 */
public class FactorCollectionManagementRepaymentPlanVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5975178824613751916L;
	/*放款申请ID*/
	@JSONField(name="loan_id")
	private Integer loanId;
	/*付款批次ID*/
	@JSONField(name="payment_batch_id")
	private Integer paymentBatchId;
	/*融资子订单ID*/
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	/*放款申请订单号*/	
	@JSONField(name="loan_apply_order_no")
	private String loanApplyOrderNo;
	/*融资方*/
	@JSONField(name="financing_name")
	private String financingName;
	/*核心企业*/
	@JSONField(name="core_enterprise_name")
	private String coreEnterpriseName;
	/*期数*/
	@JSONField(name="period")
	private String period;
	/*还款日期*/
	@JSONField(name = "repayment_date", format = "yyyy-MM-dd")
	private Date repaymentDate;
	/*应还本金*/
	@JSONField(name="repayment_principal")
	private BigDecimal repaymentPrincipal;
	/*应还利息*/
	@JSONField(name="repayment_interest")
	private BigDecimal repaymentInterest;
	/*逾期天数*/
	@JSONField(name="overdue_days")
	private Integer overdueDays;
	/*逾期利率*/
	@JSONField(name="overdue_interest_rate")
	private BigDecimal overdueInterestRate;
	/*逾期费用*/
	@JSONField(name="overdue_fee")
	private BigDecimal overdueFee;
	/*还款状态*/
	@JSONField(name="repayment_status")
	private Integer repaymentStatus;
	/*实际还款金额*/
	@JSONField(name="actual_amount")
	private BigDecimal actualAmount;
	/*实际还款日期*/
	@JSONField(name="actual_repayment_date")
	private Date actualRepaymentDate;
	/*交易流水号*/
	@JSONField(name="transaction_order_no")
	private String transactionOrderNo;
	/*开户行*/
	@JSONField(name="bank")
	private String bank;
	/*开户名称*/
	@JSONField(name="bank_account_name")
	private String bankAccountName;
	/*银行账号*/
	@JSONField(name="bank_account")
	private String bankAccount;
	/*备注*/
	@JSONField(name="remark")
	private String remark;
	/*资金方ID*/
	@JSONField(name="factor")
	private Long factor;
	/*融资方简称*/
	@JSONField(name="enterprise_short_name")
	private String enterpriseShortName;
	/*交易方式为回购则由融资方还款，买断由核心企业还款*/
	@JSONField(name="business_id")
	private Long businessId;
	/*还款确认状态1-未确认2-已确认*/
	@JSONField(name="confirm_status")
	private Integer confirmStatus;
	
	//临时字段--开始时间，结束时间
	@JSONField(name="startDate")
	private String startDate;
	
	@JSONField(name="endDate")
	private String endDate;
	/*资金方业务id*/
	@JSONField(name="payee_business_id")
	private Long payeeBusinessId;
	/*资产编号*/
	@JSONField(name="asset_number")
	private String assetNumber;
	
	@JSONField(name="fa_id")
	/*融资申请id*/
	private Long faId;
	
	@JSONField(name="sfa_id")
	/*融资申请子id*/
	private Long sfaId;
	
	//融资订单号
	private	String financing_order_number;
	
	@JSONField(name="attachmentList")
	private List<AttachmentVo> attachmentList;
	
	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}
	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
	}
	public String getTransactionOrderNo() {
		return transactionOrderNo;
	}
	public void setTransactionOrderNo(String transactionOrderNo) {
		this.transactionOrderNo = transactionOrderNo;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBankAccountName() {
		return bankAccountName;
	}
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLoanApplyOrderNo() {
		return loanApplyOrderNo;
	}
	public void setLoanApplyOrderNo(String loanApplyOrderNo) {
		this.loanApplyOrderNo = loanApplyOrderNo;
	}
	public String getFinancingName() {
		return financingName;
	}
	public void setFinancingName(String financingName) {
		this.financingName = financingName;
	}
	public String getCoreEnterpriseName() {
		return coreEnterpriseName;
	}
	public void setCoreEnterpriseName(String coreEnterpriseName) {
		this.coreEnterpriseName = coreEnterpriseName;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public Date getRepaymentDate() {
		return repaymentDate;
	}
	public void setRepaymentDate(Date repaymentDate) {
		this.repaymentDate = repaymentDate;
	}
	public BigDecimal getRepaymentPrincipal() {
		return repaymentPrincipal;
	}
	public void setRepaymentPrincipal(BigDecimal repaymentPrincipal) {
		this.repaymentPrincipal = repaymentPrincipal;
	}
	public BigDecimal getRepaymentInterest() {
		return repaymentInterest;
	}
	public void setRepaymentInterest(BigDecimal repaymentInterest) {
		this.repaymentInterest = repaymentInterest;
	}
	public Integer getOverdueDays() {
		return overdueDays;
	}
	public void setOverdueDays(Integer overdueDays) {
		this.overdueDays = overdueDays;
	}
	public BigDecimal getOverdueInterestRate() {
		return overdueInterestRate;
	}
	public void setOverdueInterestRate(BigDecimal overdueInterestRate) {
		this.overdueInterestRate = overdueInterestRate;
	}
	public BigDecimal getOverdueFee() {
		return overdueFee;
	}
	public void setOverdueFee(BigDecimal overdueFee) {
		this.overdueFee = overdueFee;
	}
	public Integer getRepaymentStatus() {
		return repaymentStatus;
	}
	public void setRepaymentStatus(Integer repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}
	public BigDecimal getActualAmount() {
		return actualAmount;
	}
	public void setActualAmount(BigDecimal actualAmount) {
		this.actualAmount = actualAmount;
	}
	public Date getActualRepaymentDate() {
		return actualRepaymentDate;
	}
	public void setActualRepaymentDate(Date actualRepaymentDate) {
		this.actualRepaymentDate = actualRepaymentDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Long getFactor() {
		return factor;
	}
	public void setFactor(Long factor) {
		this.factor = factor;
	}
	public String getEnterpriseShortName() {
		return enterpriseShortName;
	}
	public void setEnterpriseShortName(String enterpriseShortName) {
		this.enterpriseShortName = enterpriseShortName;
	}
	public Long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	public String getFinancing_order_number() {
		return financing_order_number;
	}
	public void setFinancing_order_number(String financing_order_number) {
		this.financing_order_number = financing_order_number;
	}
	public Integer getConfirmStatus() {
		return confirmStatus;
	}
	public void setConfirmStatus(Integer confirmStatus) {
		this.confirmStatus = confirmStatus;
	}
	public Integer getLoanId() {
		return loanId;
	}
	public void setLoanId(Integer loanId) {
		this.loanId = loanId;
	}
	public Integer getPaymentBatchId() {
		return paymentBatchId;
	}
	public void setPaymentBatchId(Integer paymentBatchId) {
		this.paymentBatchId = paymentBatchId;
	}
	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}
	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}
	public Long getPayeeBusinessId() {
		return payeeBusinessId;
	}
	public void setPayeeBusinessId(Long payeeBusinessId) {
		this.payeeBusinessId = payeeBusinessId;
	}
	public String getAssetNumber() {
		return assetNumber;
	}
	public void setAssetNumber(String assetNumber) {
		this.assetNumber = assetNumber;
	}
	public Long getFaId() {
		return faId;
	}
	public void setFaId(Long faId) {
		this.faId = faId;
	}
	public Long getSfaId() {
		return sfaId;
	}
	public void setSfaId(Long sfaId) {
		this.sfaId = sfaId;
	}
	
	
}
