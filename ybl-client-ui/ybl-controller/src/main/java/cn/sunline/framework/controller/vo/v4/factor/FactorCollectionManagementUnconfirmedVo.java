package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方收款管理待确认
 */
public class FactorCollectionManagementUnconfirmedVo {

	/*收款人业务id*/
	@JSONField(name="payee_business_id")
	private Integer payeeBusinessId;
	/*还款id*/
	@JSONField(name="repayment_id")
	private Integer repaymentId;
	/*放款申请id*/
	@JSONField(name="loan_apply_id")
	private Integer loanApplyId;
	/*放款申请订单号*/	
	@JSONField(name="loan_apply_order_no")
	private String loanApplyOrderNo;
	/*保理类型*/
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	/*融资方*/
	@JSONField(name="financing_name")
	private String financingName;
	/*核心企业*/
	@JSONField(name="core_enterprise_name")
	private String coreEnterpriseName;
	/*资产编号*/
	@JSONField(name="asset_number")
	private String assetNumber;
	/*期数*/
	@JSONField(name="period")
	private String period;
	/*还款日期*/
	@JSONField(name = "repayment_date")
	private Date repaymentDate;
	/*应还本金*/
	@JSONField(name="repayment_principal")
	private BigDecimal repaymentPrincipal;
	/*应还利息*/
	@JSONField(name="repayment_interest")
	private BigDecimal repaymentInterest;
	/*还款状态*/
	@JSONField(name="repayment_status")
	private Integer repaymentStatus;
	/*还款确认状态*/
	@JSONField(name="confirm_status")
	private Integer confirmStatus;
	/*实际还款金额*/
	@JSONField(name="actual_amount")
	private BigDecimal actualAmount;
	/*实际还款日期*/
	@JSONField(name="actual_repayment_date")
	private Date actualRepaymentDate;
	/*开始日期*/
	@JSONField(name = "start_date")
	private String startDate;
	/*结束日期*/
	@JSONField(name = "end_date")
	private String endDate;
	
	public Integer getPayeeBusinessId() {
		return payeeBusinessId;
	}
	public String getAssetNumber() {
		return assetNumber;
	}
	public void setAssetNumber(String assetNumber) {
		this.assetNumber = assetNumber;
	}
	public void setPayeeBusinessId(Integer payeeBusinessId) {
		this.payeeBusinessId = payeeBusinessId;
	}
	public Integer getLoanApplyId() {
		return loanApplyId;
	}
	public void setLoanApplyId(Integer loanApplyId) {
		this.loanApplyId = loanApplyId;
	}
	public String getStartDate() {
		return startDate;
	}
	public Integer getConfirmStatus() {
		return confirmStatus;
	}
	public void setConfirmStatus(Integer confirmStatus) {
		this.confirmStatus = confirmStatus;
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
	public Integer getRepaymentId() {
		return repaymentId;
	}
	public void setRepaymentId(Integer repaymentId) {
		this.repaymentId = repaymentId;
	}
	public String getLoanApplyOrderNo() {
		return loanApplyOrderNo;
	}
	public void setLoanApplyOrderNo(String loanApplyOrderNo) {
		this.loanApplyOrderNo = loanApplyOrderNo;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
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
	
	
}
