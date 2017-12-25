package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方风控终审
 */
public class FactorRiskManagementFinalAuditVo {

	/*所属业务id*/
	@JSONField(name="business_id")
	private Integer businessId;
	/*融资申请id*/
	@JSONField(name="financing_apply_id")
	private Integer financingApplyId;
	/*融资申请子订单id*/
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	/*融资订单号*/	
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	/*核心企业*/	
	@JSONField(name="core_enterprise")
	private String coreEnterprise;
	/*融资方*/
	@JSONField(name="financier")
	private String financier;	
	/*保理类型*/
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	/*资产类型*/
	@JSONField(name="assets_type")
	private Integer assetsType;
	/*融资方式*/
	@JSONField(name="financing_mode")
	private Integer financingMode;
	/*融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*融资期限*/
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/*融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*融资状态*/
	@JSONField(name="financing_status")
	private Integer financingStatus;
	/*申请日期*/
	@JSONField(name = "created_time")
	private Date createdTime;
	/*开始日期*/
	@JSONField(name = "start_date")
	//@DateTimeFormat(pattern="yyyy-MM-dd")@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	private String startDate;
	/*结束日期*/
	@JSONField(name = "end_date")
	//@DateTimeFormat(pattern="yyyy-MM-dd")@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	private String endDate;
	
	public String getStartDate() {
		return startDate;
	}

	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}

	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}

	public Integer getBusinessId() {
		return businessId;
	}

	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
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
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	public String getCoreEnterprise() {
		return coreEnterprise;
	}
	public void setCoreEnterprise(String coreEnterprise) {
		this.coreEnterprise = coreEnterprise;
	}
	public String getFinancier() {
		return financier;
	}
	public void setFinancier(String financier) {
		this.financier = financier;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public Integer getFinancingMode() {
		return financingMode;
	}
	public void setFinancingMode(Integer financingMode) {
		this.financingMode = financingMode;
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

	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}
	
}
