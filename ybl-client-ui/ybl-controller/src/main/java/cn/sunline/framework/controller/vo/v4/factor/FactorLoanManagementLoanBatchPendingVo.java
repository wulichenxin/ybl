package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方放款管理待付款批次
 */
public class FactorLoanManagementLoanBatchPendingVo {
	/*所属业务id*/
	@JSONField(name="business_id")
	private Integer businessId;
	/*放款批次id*/
	@JSONField(name="batch_id")
	private Integer batchId;
	/*付款批次*/	
	@JSONField(name="batch_no")
	private String batchNo;
	/*融资方*/
	@JSONField(name="financier_name")
	private String financierName;
	/*合计申请金额*/
	@JSONField(name="total_apply_amount")
	private BigDecimal totalApplyAmount;
	/*合计结算金额*/
	@JSONField(name="total_settlement_amount")
	private BigDecimal totalSettlementAmount;
	/*合计融资费用*/
	@JSONField(name="total_financing_fee")
	private BigDecimal totalFinancingFee;
	public Integer getBatchId() {
		return batchId;
	}
	public Integer getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}
	public void setBatchId(Integer batchId) {
		this.batchId = batchId;
	}
	public String getBatchNo() {
		return batchNo;
	}
	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}
	public String getFinancierName() {
		return financierName;
	}
	public void setFinancierName(String financierName) {
		this.financierName = financierName;
	}
	public BigDecimal getTotalApplyAmount() {
		return totalApplyAmount;
	}
	public void setTotalApplyAmount(BigDecimal totalApplyAmount) {
		this.totalApplyAmount = totalApplyAmount;
	}
	public BigDecimal getTotalSettlementAmount() {
		return totalSettlementAmount;
	}
	public void setTotalSettlementAmount(BigDecimal totalSettlementAmount) {
		this.totalSettlementAmount = totalSettlementAmount;
	}
	public BigDecimal getTotalFinancingFee() {
		return totalFinancingFee;
	}
	public void setTotalFinancingFee(BigDecimal totalFinancingFee) {
		this.totalFinancingFee = totalFinancingFee;
	}
	
	
}
