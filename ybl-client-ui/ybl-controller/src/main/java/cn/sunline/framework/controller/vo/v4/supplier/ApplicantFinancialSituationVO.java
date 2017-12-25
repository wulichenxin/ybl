package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;


/**
 * 申请人财务情况管理VO
 * @author jiangchangyuan
 *
 */
public class ApplicantFinancialSituationVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/*id,前端页面传值用*/
	private Integer financialSituationId;
	
	/*融资申请id*/
	private Integer financingApplyId;
	
	/*总资产最新一期*/
	private BigDecimal totalAssetsNewest;
	
	/*总资产n-1*/
	private BigDecimal totalAssetsN1;
	
	/*总资产n-2*/
	private BigDecimal totalAssetsN2;
	
	/*总负债最新一期*/
	private BigDecimal totalDebtsNewest;
	
	/*总负债n-1*/
	private BigDecimal totalDebtsN1;
	
	/*总负债n-2*/
	private BigDecimal totalDebtsN2;

	/*所有者权益最新一期*/
	private BigDecimal ownerEquityNewest;
	
	/*所有者权益n-1*/
	private BigDecimal ownerEquityN1;
	
	/*所有者权益n-2*/
	private BigDecimal ownerEquityN2;
	
	/*营业收入最新一期*/
	private BigDecimal businessIncomeNewest;
	
	/*营业收入n-1*/
	private BigDecimal businessIncomeN1;
	
	/*营业收入n-2*/
	private BigDecimal businessIncomeN2;
	
	/*营业成本最新一期*/
	private BigDecimal businessCostNewest;
	
	/*营业成本n-1*/
	private BigDecimal businessCostN1;
	
	/*营业成本n-2*/
	private BigDecimal businessCostN2;
	
	/*营业利润最新一期*/
	private BigDecimal businessProfitNewest;
	
	/*营业利润n-1*/
	private BigDecimal businessProfitN1;
	
	/*营业利润n-2*/
	private BigDecimal businessProfitN2;
	
	/*利润总额最新一期*/
	private BigDecimal profitAmountNewest;
	
	/*利润总额n-1*/
	private BigDecimal profitAmountN1;
	
	/*利润总额n-2*/
	private BigDecimal profitAmountN2;
	
	/*净利润最新一期*/
	private BigDecimal netProfitNewest;
	
	/*净利润n-1*/
	private BigDecimal netProfitN1;
	
	/*净利润最n-2*/
	private BigDecimal netProfitN2;
	
	/*经营活动现金流最新一期*/
	private BigDecimal cashFlowNewest;
	
	/*经营活动现金流n-1*/
	private BigDecimal cashFlowN1;
	
	/*经营活动现金流n-2*/
	private BigDecimal cashFlowN2;
	
	@JSONField(name = "financial_situation_id")
	public Integer getFinancialSituationId() {
		return financialSituationId;
	}

	@JSONField(name = "financial_situation_id")
	public void setFinancialSituationId(Integer financialSituationId) {
		this.financialSituationId = financialSituationId;
	}

	@JSONField(name = "financing_apply_id")
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}

	@JSONField(name = "financing_apply_id")
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}

	@JSONField(name = "total_assets_newest")
	public BigDecimal getTotalAssetsNewest() {
		return totalAssetsNewest;
	}

	@JSONField(name = "total_assets_newest")
	public void setTotalAssetsNewest(BigDecimal totalAssetsNewest) {
		this.totalAssetsNewest = totalAssetsNewest;
	}

	@JSONField(name = "total_assets_n1")
	public BigDecimal getTotalAssetsN1() {
		return totalAssetsN1;
	}

	@JSONField(name = "total_assets_n1")
	public void setTotalAssetsN1(BigDecimal totalAssetsN1) {
		this.totalAssetsN1 = totalAssetsN1;
	}

	@JSONField(name = "total_assets_n2")
	public BigDecimal getTotalAssetsN2() {
		return totalAssetsN2;
	}

	@JSONField(name = "total_assets_n2")
	public void setTotalAssetsN2(BigDecimal totalAssetsN2) {
		this.totalAssetsN2 = totalAssetsN2;
	}

	@JSONField(name = "total_debts_newest")
	public BigDecimal getTotalDebtsNewest() {
		return totalDebtsNewest;
	}

	@JSONField(name = "total_debts_newest")
	public void setTotalDebtsNewest(BigDecimal totalDebtsNewest) {
		this.totalDebtsNewest = totalDebtsNewest;
	}

	@JSONField(name = "total_debts_n1")
	public BigDecimal getTotalDebtsN1() {
		return totalDebtsN1;
	}

	@JSONField(name = "total_debts_n1")
	public void setTotalDebtsN1(BigDecimal totalDebtsN1) {
		this.totalDebtsN1 = totalDebtsN1;
	}

	@JSONField(name = "total_debts_n2")
	public BigDecimal getTotalDebtsN2() {
		return totalDebtsN2;
	}

	@JSONField(name = "total_debts_n2")
	public void setTotalDebtsN2(BigDecimal totalDebtsN2) {
		this.totalDebtsN2 = totalDebtsN2;
	}

	@JSONField(name = "owner_equity_newest")
	public BigDecimal getOwnerEquityNewest() {
		return ownerEquityNewest;
	}

	@JSONField(name = "owner_equity_newest")
	public void setOwnerEquityNewest(BigDecimal ownerEquityNewest) {
		this.ownerEquityNewest = ownerEquityNewest;
	}

	@JSONField(name = "owner_equity_n1")
	public BigDecimal getOwnerEquityN1() {
		return ownerEquityN1;
	}

	@JSONField(name = "owner_equity_n1")
	public void setOwnerEquityN1(BigDecimal ownerEquityN1) {
		this.ownerEquityN1 = ownerEquityN1;
	}

	@JSONField(name = "owner_equity_n2")
	public BigDecimal getOwnerEquityN2() {
		return ownerEquityN2;
	}

	@JSONField(name = "owner_equity_n2")
	public void setOwnerEquityN2(BigDecimal ownerEquityN2) {
		this.ownerEquityN2 = ownerEquityN2;
	}

	@JSONField(name = "business_income_newest")
	public BigDecimal getBusinessIncomeNewest() {
		return businessIncomeNewest;
	}

	@JSONField(name = "business_income_newest")
	public void setBusinessIncomeNewest(BigDecimal businessIncomeNewest) {
		this.businessIncomeNewest = businessIncomeNewest;
	}

	@JSONField(name = "business_income_n1")
	public BigDecimal getBusinessIncomeN1() {
		return businessIncomeN1;
	}

	@JSONField(name = "business_income_n1")
	public void setBusinessIncomeN1(BigDecimal businessIncomeN1) {
		this.businessIncomeN1 = businessIncomeN1;
	}

	@JSONField(name = "business_income_n2")
	public BigDecimal getBusinessIncomeN2() {
		return businessIncomeN2;
	}

	@JSONField(name = "business_income_n2")
	public void setBusinessIncomeN2(BigDecimal businessIncomeN2) {
		this.businessIncomeN2 = businessIncomeN2;
	}

	@JSONField(name = "business_cost_newest")
	public BigDecimal getBusinessCostNewest() {
		return businessCostNewest;
	}

	@JSONField(name = "business_cost_newest")
	public void setBusinessCostNewest(BigDecimal businessCostNewest) {
		this.businessCostNewest = businessCostNewest;
	}

	@JSONField(name = "business_cost_n1")
	public BigDecimal getBusinessCostN1() {
		return businessCostN1;
	}

	@JSONField(name = "business_cost_n1")
	public void setBusinessCostN1(BigDecimal businessCostN1) {
		this.businessCostN1 = businessCostN1;
	}

	@JSONField(name = "business_cost_n2")
	public BigDecimal getBusinessCostN2() {
		return businessCostN2;
	}

	@JSONField(name = "business_cost_n2")
	public void setBusinessCostN2(BigDecimal businessCostN2) {
		this.businessCostN2 = businessCostN2;
	}

	@JSONField(name = "business_profit_newest")
	public BigDecimal getBusinessProfitNewest() {
		return businessProfitNewest;
	}

	@JSONField(name = "business_profit_newest")
	public void setBusinessProfitNewest(BigDecimal businessProfitNewest) {
		this.businessProfitNewest = businessProfitNewest;
	}

	@JSONField(name = "business_profit_n1")
	public BigDecimal getBusinessProfitN1() {
		return businessProfitN1;
	}

	@JSONField(name = "business_profit_n1")
	public void setBusinessProfitN1(BigDecimal businessProfitN1) {
		this.businessProfitN1 = businessProfitN1;
	}

	@JSONField(name = "business_profit_n2")
	public BigDecimal getBusinessProfitN2() {
		return businessProfitN2;
	}

	@JSONField(name = "business_profit_n2")
	public void setBusinessProfitN2(BigDecimal businessProfitN2) {
		this.businessProfitN2 = businessProfitN2;
	}

	@JSONField(name = "profit_amount_newest")
	public BigDecimal getProfitAmountNewest() {
		return profitAmountNewest;
	}

	@JSONField(name = "profit_amount_newest")
	public void setProfitAmountNewest(BigDecimal profitAmountNewest) {
		this.profitAmountNewest = profitAmountNewest;
	}

	@JSONField(name = "profit_amount_n1")
	public BigDecimal getProfitAmountN1() {
		return profitAmountN1;
	}

	@JSONField(name = "profit_amount_n1")
	public void setProfitAmountN1(BigDecimal profitAmountN1) {
		this.profitAmountN1 = profitAmountN1;
	}

	@JSONField(name = "profit_amount_n2")
	public BigDecimal getProfitAmountN2() {
		return profitAmountN2;
	}

	@JSONField(name = "profit_amount_n2")
	public void setProfitAmountN2(BigDecimal profitAmountN2) {
		this.profitAmountN2 = profitAmountN2;
	}

	@JSONField(name = "net_profit_newest")
	public BigDecimal getNetProfitNewest() {
		return netProfitNewest;
	}

	@JSONField(name = "net_profit_newest")
	public void setNetProfitNewest(BigDecimal netProfitNewest) {
		this.netProfitNewest = netProfitNewest;
	}

	@JSONField(name = "net_profit_n1")
	public BigDecimal getNetProfitN1() {
		return netProfitN1;
	}

	@JSONField(name = "net_profit_n1")
	public void setNetProfitN1(BigDecimal netProfitN1) {
		this.netProfitN1 = netProfitN1;
	}

	@JSONField(name = "net_profit_n2")
	public BigDecimal getNetProfitN2() {
		return netProfitN2;
	}

	@JSONField(name = "net_profit_n2")
	public void setNetProfitN2(BigDecimal netProfitN2) {
		this.netProfitN2 = netProfitN2;
	}

	@JSONField(name = "cash_flow_newest")
	public BigDecimal getCashFlowNewest() {
		return cashFlowNewest;
	}

	@JSONField(name = "cash_flow_newest")
	public void setCashFlowNewest(BigDecimal cashFlowNewest) {
		this.cashFlowNewest = cashFlowNewest;
	}

	@JSONField(name = "cash_flow_n1")
	public BigDecimal getCashFlowN1() {
		return cashFlowN1;
	}

	@JSONField(name = "cash_flow_n1")
	public void setCashFlowN1(BigDecimal cashFlowN1) {
		this.cashFlowN1 = cashFlowN1;
	}

	@JSONField(name = "cash_flow_n2")
	public BigDecimal getCashFlowN2() {
		return cashFlowN2;
	}

	@JSONField(name = "cash_flow_n2")
	public void setCashFlowN2(BigDecimal cashFlowN2) {
		this.cashFlowN2 = cashFlowN2;
	}

}
