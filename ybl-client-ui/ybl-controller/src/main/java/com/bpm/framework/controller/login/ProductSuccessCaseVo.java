package com.bpm.framework.controller.login;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 产品成功案例实体表
 * @author DingMk
 *
 */
public class ProductSuccessCaseVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/*产品融资机构*/
	private String financeName;
	//融资金额
	private String financeAmount;
	//产品id
	private Integer productId;
	//融资状态
	private String financeStatus;
	//申请时间
	private Date applyDate;
	
	/**
	 * @return the financeName
	 */
	@JSONField(name="finance_name")
	public String getFinanceName() {
		return financeName;
	}
	/**
	 * @param financeName the financeName to set
	 */
	@JSONField(name="finance_name")
	public void setFinanceName(String financeName) {
		this.financeName = financeName;
	}
	/**
	 * @return the financeAmount
	 */
	@JSONField(name="finance_amount")
	public String getFinanceAmount() {
		return financeAmount;
	}
	/**
	 * @param financeAmount the financeAmount to set
	 */
	@JSONField(name="finance_amount")
	public void setFinanceAmount(String financeAmount) {
		this.financeAmount = financeAmount;
	}
	/**
	 * @return the productId
	 */
	@JSONField(name="product_id")
	public Integer getProductId() {
		return productId;
	}
	/**
	 * @param productId the productId to set
	 */
	@JSONField(name="product_id")
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	/**
	 * @return the financeStatus
	 */
	@JSONField(name="finance_status")
	public String getFinanceStatus() {
		return financeStatus;
	}
	/**
	 * @param financeStatus the financeStatus to set
	 */
	@JSONField(name="finance_status")
	public void setFinanceStatus(String financeStatus) {
		this.financeStatus = financeStatus;
	}
	/**
	 * @return the applyDate
	 */
	@JSONField(name="apply_date")
	public Date getApplyDate() {
		return applyDate;
	}
	/**
	 * @param applyDate the applyDate to set
	 */
	@JSONField(name="apply_date")
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	
	public String toString() {
		return "ProductSuccessCaseVo [financeName=" + financeName + ", financeAmount=" + financeAmount + ", productId="
				+ productId + ", financeStatus=" + financeStatus + ", applyDate=" + applyDate + ", id=" + id
				+ ", createdTime=" + createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime
				+ ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1="
				+ attribute1 + ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4="
				+ attribute4 + ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7="
				+ attribute7 + ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10="
				+ attribute10 + ", rowNo=" + rowNo + "]";
	}
	
}
