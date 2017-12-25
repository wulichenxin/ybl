package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableBillCommoditiesVo extends AbstractEntity{

	/**
	 * 账款发票商品表实体
	 */
	//发票id
	private Long accountsReceivableBillId;
	//商品名称
	private String billCommoditiesName;
	//规格
	private String billCommoditiesStandard;
	//单位
	private String billCommoditiesUnit;
	//数量
	private String billCommoditiesQuantity;
	//单价
	private BigDecimal billCommoditiesPrice;
	//企业id
	private Long enterpriseId;
	
	
	@JSONField(name="accounts_receivable_bill_id")
	public Long getAccountsReceivableBillId() {
		return accountsReceivableBillId;
	}
	@JSONField(name="accounts_receivable_bill_id")
	public void setAccountsReceivableBillId(Long accountsReceivableBillId) {
		this.accountsReceivableBillId = accountsReceivableBillId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="name_")
	public String getBillCommoditiesName() {
		return billCommoditiesName;
	}
	@JSONField(name="name_")
	public void setBillCommoditiesName(String billCommoditiesName) {
		this.billCommoditiesName = billCommoditiesName;
	}
	@JSONField(name="standard_")
	public String getbillCommoditiesStandard() {
		return billCommoditiesStandard;
	}
	@JSONField(name="standard_")
	public void setBillCommoditiesStandard(String billCommoditiesStandard) {
		this.billCommoditiesStandard = billCommoditiesStandard;
	}
	@JSONField(name="unit_")
	public String getBillCommoditiesUnit() {
		return billCommoditiesUnit;
	}
	@JSONField(name="unit_")
	public void setBillCommoditiesUnit(String billCommoditiesUnit) {
		this.billCommoditiesUnit = billCommoditiesUnit;
	}
	@JSONField(name="quantity_")
	public String getBillCommoditiesQuantity() {
		return billCommoditiesQuantity;
	}
	@JSONField(name="quantity_")
	public void setBillCommoditiesQuantity(String billCommoditiesQuantity) {
		this.billCommoditiesQuantity = billCommoditiesQuantity;
	}
	@JSONField(name="price_")
	public BigDecimal getBillCommoditiesPrice() {
		return billCommoditiesPrice;
	}
	@JSONField(name="price_")
	public void setBillCommoditiesPrice(BigDecimal billCommoditiesPrice) {
		this.billCommoditiesPrice = billCommoditiesPrice;
	}
	
}
