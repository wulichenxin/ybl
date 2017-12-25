package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;



import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 资金方放款申请综合查询vo
 * @author pc
 *
 */
public class FactorLoanQueryVo extends AbstractEntity {

	private static final long serialVersionUID = -6717785981399628318L;
	
	//融资母订单id
	@JSONField(name="financing_apply_id")
	private Integer financingApplyId;
	//融资母订单的融资状态
	@JSONField(name="financing_status")
	private Integer financingStatus;
	//放款申请单号
	@JSONField(name="order_no")
	private String orderNo;
	//融资方
	@JSONField(name="financier")
	private String financier;
	//保理类型
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	//资产类型
	@JSONField(name="assets_type")
	private Integer assetsType;
	//放款申请金额
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	//融资期限
	@JSONField(name="financing_term")
	private Integer financingTerm;
	//融资利率
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	//申请日期
	@JSONField(name="created_time")
	private Date createdTime;
	//实际放款金额
	@JSONField(name="actual_loan_amount")
	private BigDecimal actualLoanAmount;
	//平台管理费
	@JSONField(name="factoring_platform_fee")
	private BigDecimal factoringPlatformFee;
	//累计还款本息
	@JSONField(name="actual_amount_count")
	private BigDecimal actualAmountCount;
	//最后一次还款时间
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	@JSONField(name="actual_repayment_date", format = "yyyy-MM-dd")
	private Date actualRepaymentDate;
	//关联融资申请单号
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	//放款状态
	@JSONField(name="status")
	private Integer status;
	//还款状态
	@JSONField(name="repayment_status")
	private Integer repaymentStatus;
	//放款申请时间-开始时间
	@JSONField(name="start_apply_date")
	private String startApplyDate;
	//放款申请时间-截止时间
	@JSONField(name="end_apply_date")
	private String endApplyDate;
	//业务id对应资金方
	@JSONField(name="business_id")
	private Long businessId;
	
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
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
	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
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
	public BigDecimal getActualLoanAmount() {
		return actualLoanAmount;
	}
	public void setActualLoanAmount(BigDecimal actualLoanAmount) {
		this.actualLoanAmount = actualLoanAmount;
	}
	public BigDecimal getFactoringPlatformFee() {
		return factoringPlatformFee;
	}
	public void setFactoringPlatformFee(BigDecimal factoringPlatformFee) {
		this.factoringPlatformFee = factoringPlatformFee;
	}
	public BigDecimal getActualAmountCount() {
		return actualAmountCount;
	}
	public void setActualAmountCount(BigDecimal actualAmountCount) {
		this.actualAmountCount = actualAmountCount;
	}
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
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
	public Integer getRepaymentStatus() {
		return repaymentStatus;
	}
	public void setRepaymentStatus(Integer repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}
	public String getStartApplyDate() {
		return startApplyDate;
	}
	public void setStartApplyDate(String startApplyDate) {
		this.startApplyDate = startApplyDate;
	}
	public String getEndApplyDate() {
		return endApplyDate;
	}
	public void setEndApplyDate(String endApplyDate) {
		this.endApplyDate = endApplyDate;
	}
	public Long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	public Date getActualRepaymentDate() {
		return actualRepaymentDate;
	}
	public void setActualRepaymentDate(Date actualRepaymentDate) {
		this.actualRepaymentDate = actualRepaymentDate;
	}
	
	
}
