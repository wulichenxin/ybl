package cn.sunline.framework.controller.vo.v4;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class LoanProjectVO extends AbstractEntity{

	private static final long serialVersionUID = 1L;

	@JSONField(name = "order_no")
	private String OrderNo; //放款订单号
	@JSONField(name = "financing_name")
	private String financingName; //资金方名称
	@JSONField(name = "core_enterprise_name")
	private String coreEnterpriseName; //核心企业
	@JSONField(name = "period")
	private String period; //期数
	@JSONField(name = "repayment_date")
	private Date repaymentDate; //还款日期
	@JSONField(name = "repayment_principal")
	private BigDecimal repaymentPrincipal; //应还本金
	@JSONField(name = "repayment_interest")
	private BigDecimal repaymentInterest; //应还利息
	@JSONField(name = "overdue_days")
	private Integer overdueDays; //逾期天数
	@JSONField(name = "overdue_interest_rate")
	private BigDecimal overdueInterestRate; //逾期利率
	@JSONField(name = "repayment_status")
	private Integer repaymentStatus; //还款状态
	@JSONField(name = "confirm_repayment_date")
	private Date confirmRepaymentDate; //确认还款日期
	@JSONField(name = "financing_amount")
	private BigDecimal financingAmount; //融资金额
	@JSONField(name = "financing_term")
	private Date financingTerm; //融资期限
	@JSONField(name = "financing_rate")
	private BigDecimal financingRate; //融资利率
	@JSONField(name="actual_loan_date")
	private Date actualLoanDate; //实际放款时间
	@JSONField(name="actual_loan_amount")
	private BigDecimal actualLoanAmount; //实际放款金额
	@JSONField(name="assets_type")
	private Integer assetsType; //资产类型1-应收账款2-应付账款3-票据
	@JSONField(name="master_contract_no")
	private String masterContractNo; //主合同号
	@JSONField(name="factoring_mode")
	private Integer factoringMode; //保理类型1-明保理2-暗保理
	@JSONField(name="financing_mode")
	private Integer financingMode; //融资方式1-签约资方2-平台推荐3-竞标
	@JSONField(name="financing_status")
	private Integer financingStatus; //1-待提交2-待平台初审3-待资方初审4-待选择资方5-待资方终审6-待确定资方7-待平台复核8-待签署合同9-融资完成99-融资失败
	@JSONField(name="financing_order_number")
	private String financingOrderNumber; //融资订单号
	@JSONField(name="business_id")
	private long businessId; //业务id
	@JSONField(name="status")
	private Integer status; //放款申请状态
	@JSONField(name="total_settlement_amount")
	private BigDecimal totalSettlementAmount; //结算金额
	@JSONField(name="total_financing_fee")
	private BigDecimal totalFinancingFee; //融资费用
	
	public String getOrderNo() {
		return OrderNo;
	}
	public void setOrderNo(String orderNo) {
		OrderNo = orderNo;
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
	public Integer getRepaymentStatus() {
		return repaymentStatus;
	}
	public void setRepaymentStatus(Integer repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}
	public Date getConfirmRepaymentDate() {
		return confirmRepaymentDate;
	}
	public void setConfirmRepaymentDate(Date confirmRepaymentDate) {
		this.confirmRepaymentDate = confirmRepaymentDate;
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
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public Date getActualLoanDate() {
		return actualLoanDate;
	}
	public void setActualLoanDate(Date actualLoanDate) {
		this.actualLoanDate = actualLoanDate;
	}
	public BigDecimal getActualLoanAmount() {
		return actualLoanAmount;
	}
	public void setActualLoanAmount(BigDecimal actualLoanAmount) {
		this.actualLoanAmount = actualLoanAmount;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public Integer getFinancingMode() {
		return financingMode;
	}
	public void setFinancingMode(Integer financingMode) {
		this.financingMode = financingMode;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	public long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
