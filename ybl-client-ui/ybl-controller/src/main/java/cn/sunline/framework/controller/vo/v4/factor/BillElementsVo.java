package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 票据保理要素vo
 */
public class BillElementsVo extends AbstractEntity {

	private static final long serialVersionUID = -3884302272788710911L;
	
	//放款申请id
	@JSONField(name="loan_apply_id")
	private int loanApplyId;
	//保理要素表编号
	@JSONField(name="order_no")
	private String orderNo;
	//持有人
	@JSONField(name="bill_holder")
	private String billHolder;
	//承兑人
	@JSONField(name="bill_acceptor")
	private String billAcceptor;
	//基础合同及编号
	@JSONField(name="base_contract_no")
	private String baseContractNo;
	//到期日期
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="expire_date", format = "yyyy-MM-dd")
	private Date expireDate;
	//开票日期
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="billing_date", format = "yyyy-MM-dd")
	private Date billingDate;
	//转让日期
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="transfer_dte", format = "yyyy-MM-dd")
	private Date transferDte;
	//票面金额
	@JSONField(name="bill_money")
	private BigDecimal billMoney;	
	//结算比例
	@JSONField(name="balance_scale")
	private BigDecimal balanceScale;
	//逾期利率
	@JSONField(name="overdue_interest_rate")
	private BigDecimal overdueInterestRate;
	//服务费
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	//收费方式1-融资利率2-服务费
	@JSONField(name="fee_mode")
	private Integer feeMode;
	//融资利率
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	//转让对价
	@JSONField(name="transfer_money")
	private BigDecimal transferMoney;
	//交易方式：1-回购2-买断
	@JSONField(name="transaction_mode")
	private Integer transactionMode;
	//确权方式1-线下确权2-线上确权
	@JSONField(name="right_mode")
	private Integer rightMode;
	//融资期限
	@JSONField(name="financing_term")
	private int financingTerm;
	//还款方式1-先息后本2-等额本息3-利息前置，到期还本
	@JSONField(name="repayment_mode")
	private Integer repaymentMode;
	//备注
	@JSONField(name="remark")
	private String remark;
	//收取费用
	@JSONField(name="fee")
	private BigDecimal fee;
	//保理类型1-明保理2-暗保理
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	
	public Integer getRepaymentMode() {
		return repaymentMode;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public void setRepaymentMode(Integer repaymentMode) {
		this.repaymentMode = repaymentMode;
	}
	public BigDecimal getFee() {
		return fee;
	}
	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}
	public int getLoanApplyId() {
		return loanApplyId;
	}
	public void setLoanApplyId(int loanApplyId) {
		this.loanApplyId = loanApplyId;
	}
	public BigDecimal getTransferMoney() {
		return transferMoney;
	}
	public void setTransferMoney(BigDecimal transferMoney) {
		this.transferMoney = transferMoney;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public BigDecimal getOverdueInterestRate() {
		return overdueInterestRate;
	}
	public void setOverdueInterestRate(BigDecimal overdueInterestRate) {
		this.overdueInterestRate = overdueInterestRate;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getBillHolder() {
		return billHolder;
	}
	public void setBillHolder(String billHolder) {
		this.billHolder = billHolder;
	}
	public String getBillAcceptor() {
		return billAcceptor;
	}
	public void setBillAcceptor(String billAcceptor) {
		this.billAcceptor = billAcceptor;
	}
	public String getBaseContractNo() {
		return baseContractNo;
	}
	public void setBaseContractNo(String baseContractNo) {
		this.baseContractNo = baseContractNo;
	}
	public Date getExpireDate() {
		return expireDate;
	}
	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}
	public Date getBillingDate() {
		return billingDate;
	}
	public void setBillingDate(Date billingDate) {
		this.billingDate = billingDate;
	}
	public Date getTransferDte() {
		return transferDte;
	}
	public void setTransferDte(Date transferDte) {
		this.transferDte = transferDte;
	}
	public BigDecimal getBillMoney() {
		return billMoney;
	}
	public void setBillMoney(BigDecimal billMoney) {
		this.billMoney = billMoney;
	}
	public BigDecimal getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(BigDecimal serviceFee) {
		this.serviceFee = serviceFee;
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
	public Integer getTransactionMode() {
		return transactionMode;
	}
	public void setTransactionMode(Integer transactionMode) {
		this.transactionMode = transactionMode;
	}
	public Integer getRightMode() {
		return rightMode;
	}
	public void setRightMode(Integer rightMode) {
		this.rightMode = rightMode;
	}
	public BigDecimal getBalanceScale() {
		return balanceScale;
	}
	public void setBalanceScale(BigDecimal balanceScale) {
		this.balanceScale = balanceScale;
	}
	public int getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(int financingTerm) {
		this.financingTerm = financingTerm;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
