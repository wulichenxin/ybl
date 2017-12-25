package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 合同合作要素信息
 * @author WIN
 *
 */
public class ContractCooperationElementsVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -9161053733979352864L;
	/**
	 * 融资子订单号
	 */
	@JSONField(name="order_no")
	private String orderNo;
	/**
	 * 合同类型：1-额度合同2-单笔合同'
	 */
	@JSONField(name="contract_type")
	private Integer contractType;
	/**
	 * 合同额度
	 */
	@JSONField(name="give_quota")
	private BigDecimal giveQuota;
	/**
	 * 收费方式1-融资利率2-服务费3-折价转让
	 */
	@JSONField(name="fee_mode")
	private Integer feeMode;
	/**
	 * 融资利率
	 */
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/**
	 * 服务费
	 */
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	/**
	 * 折价转让
	 */
	@JSONField(name="transfer_money")
	private BigDecimal transferMoney;
	/**
	 * 资方单位开户行
	 */
	private String bank;
	/**
	 * 资方单位开户名称
	 */
	@JSONField(name="bank_account_name")
	private String bankAccountName;
	/**
	 * 资方单位账户银行账号
	 */
	@JSONField(name="bank_account")
	private String bankAccount;
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Integer getContractType() {
		return contractType;
	}
	public void setContractType(Integer contractType) {
		this.contractType = contractType;
	}
	public BigDecimal getGiveQuota() {
		return giveQuota;
	}
	public void setGiveQuota(BigDecimal giveQuota) {
		this.giveQuota = giveQuota;
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
	public BigDecimal getTransferMoney() {
		return transferMoney;
	}
	public void setTransferMoney(BigDecimal transferMoney) {
		this.transferMoney = transferMoney;
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
	
}
