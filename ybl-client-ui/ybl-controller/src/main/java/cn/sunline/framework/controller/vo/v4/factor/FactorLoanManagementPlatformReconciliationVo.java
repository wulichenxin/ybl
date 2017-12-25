package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方放款管理平台对账
 */
public class FactorLoanManagementPlatformReconciliationVo {

	/*放款申请id*/
	@JSONField(name="loan_apply_id")
	private Integer loanApplyId;
	/*放款申请订单号*/	
	@JSONField(name="loan_apply_order_number")
	private String loanApplyOrderNumber;
	/*融资方*/
	@JSONField(name="financier")
	private String financier;
	/*资产类型*/
	@JSONField(name="assets_type")
	private Integer assetsType;
	/*融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*融资期限*/
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/*融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*申请日期*/
	@JSONField(name = "created_time")
	private Date createdTime;
	/*开始日期*/
	@JSONField(name = "start_date")
	private String startDate;
	/*结束日期*/
	@JSONField(name = "end_date")
	private String endDate;
	/*关联融资申请订单号*/	
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	/*放款状态*/
	@JSONField(name="status")
	private Integer status;
	public Integer getLoanApplyId() {
		return loanApplyId;
	}
	public void setLoanApplyId(Integer loanApplyId) {
		this.loanApplyId = loanApplyId;
	}
	public String getLoanApplyOrderNumber() {
		return loanApplyOrderNumber;
	}
	public void setLoanApplyOrderNumber(String loanApplyOrderNumber) {
		this.loanApplyOrderNumber = loanApplyOrderNumber;
	}
	public String getFinancier() {
		return financier;
	}
	public void setFinancier(String financier) {
		this.financier = financier;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
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
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
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
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
