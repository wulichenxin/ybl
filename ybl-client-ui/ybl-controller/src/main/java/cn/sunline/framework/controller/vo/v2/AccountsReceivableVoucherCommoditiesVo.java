package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableVoucherCommoditiesVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 账款凭证表实体
	 */
	//凭证id
	private Long accountsReceivableVoucherId;
	//商品名称
	private String voucherCommoditiesName;
	//规格
	private String voucherCommoditiesStandard;
	//单位
	private String voucherCommoditiesUnit;
	//数量
	private String voucherCommoditiesQuantity;
	//单价
	private BigDecimal voucherCommoditiesPrice;
	//企业id
	private Long enterpriseId;
	
	@JSONField(name="accounts_receivable_voucher_id")
	public Long getAccountsReceivableVoucherId() {
		return accountsReceivableVoucherId;
	}
	@JSONField(name="accounts_receivable_voucher_id")
	public void setAccountsReceivableVoucherId(Long accountsReceivableVoucherId) {
		this.accountsReceivableVoucherId = accountsReceivableVoucherId;
	}
	@JSONField(name="name_")
	public String getVoucherCommoditiesName() {
		return voucherCommoditiesName;
	}
	@JSONField(name="name_")
	public void setVoucherCommoditiesName(String voucherCommoditiesName) {
		this.voucherCommoditiesName = voucherCommoditiesName;
	}
	@JSONField(name="standard_")
	public String getVoucherCommoditiesStandard() {
		return voucherCommoditiesStandard;
	}
	@JSONField(name="standard_")
	public void setVoucherCommoditiesStandard(String voucherCommoditiesStandard) {
		this.voucherCommoditiesStandard = voucherCommoditiesStandard;
	}
	@JSONField(name="unit_")
	public String getVoucherCommoditiesUnit() {
		return voucherCommoditiesUnit;
	}
	@JSONField(name="unit_")
	public void setVoucherCommoditiesUnit(String voucherCommoditiesUnit) {
		this.voucherCommoditiesUnit = voucherCommoditiesUnit;
	}
	@JSONField(name="quantity_")
	public String getVoucherCommoditiesQuantity() {
		return voucherCommoditiesQuantity;
	}
	@JSONField(name="quantity_")
	public void setVoucherCommoditiesQuantity(String voucherCommoditiesQuantity) {
		this.voucherCommoditiesQuantity = voucherCommoditiesQuantity;
	}
	@JSONField(name="price_")
	public BigDecimal getVoucherCommoditiesPrice() {
		return voucherCommoditiesPrice;
	}
	@JSONField(name="price_")
	public void setVoucherCommoditiesPrice(BigDecimal voucherCommoditiesPrice) {
		this.voucherCommoditiesPrice = voucherCommoditiesPrice;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
}
