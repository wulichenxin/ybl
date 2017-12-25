package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 资金方放款管理付款批次
 */
public class FactorLoanManagementPaymentBatchVo extends AbstractEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 713598706677802287L;
	
	/*批次编号*/
	@JSONField(name="batch_no")
	private String batchNo;
	/*融资方名称*/
	@JSONField(name="financier_name")
	private String financierName;
	/*资金方名称*/
	@JSONField(name="funder_name")
	private String funderName;
	/*保理融资费*/
	@JSONField(name="factoring_fee")
	private BigDecimal factoringFee;
	/*合计申请金额*/
	@JSONField(name="total_apply_amount")
	private BigDecimal totalApplyAmount;
	/*合计结算金额*/
	@JSONField(name="total_settlement_amount")
	private BigDecimal totalSettlementAmount;
	
	public BigDecimal getTotalSettlementAmount() {
		return totalSettlementAmount;
	}
	public void setTotalSettlementAmount(BigDecimal totalSettlementAmount) {
		this.totalSettlementAmount = totalSettlementAmount;
	}
	public BigDecimal getTotalApplyAmount() {
		return totalApplyAmount;
	}
	public void setTotalApplyAmount(BigDecimal totalApplyAmount) {
		this.totalApplyAmount = totalApplyAmount;
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
	public BigDecimal getFactoringFee() {
		return factoringFee;
	}
	public String getFunderName() {
		return funderName;
	}
	public void setFunderName(String funderName) {
		this.funderName = funderName;
	}
	public void setFactoringFee(BigDecimal factoringFee) {
		this.factoringFee = factoringFee;
	}
	
	
}
