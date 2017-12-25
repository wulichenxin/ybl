package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 放款失败项目实体
 * @author xxx
 *
 */
public class LoanFailProjectVO extends AbstractEntity{

	private static final long serialVersionUID = 1L;

	@JSONField(name = "order_no")
	private String orderNo; //放款订单号
	@JSONField(name="assets_type")
	private Integer assetsType; //资产类型1-应收账款2-应付账款3-票据
	@JSONField(name = "investor_name") 
	private String investorName; //资金方
	@JSONField(name = "financing_amount")
	private BigDecimal financingAmount; //融资金额
	@JSONField(name = "financing_term")
	private Integer financingTerm; //融资期限
	@JSONField(name = "financing_rate")
	private BigDecimal financingRate; //融资利率
	@JSONField(name="master_contract_no")
	private String masterContractNo; //主合同号
	@JSONField(name="status")
	private Integer status; //放款申请状态
	@JSONField(name="factoring_mode")
	private Integer factoringMode; //保理类型1-明保理2-暗保理
	@JSONField(name="business_id")
	private long businessId; //业务id
	
	
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public String getInvestorName() {
		return investorName;
	}
	public void setInvestorName(String investorName) {
		this.investorName = investorName;
	}
	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}
	public void setFinancingAmount(BigDecimal financingAmount) {
		this.financingAmount = financingAmount;
	}
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}
	
}
