package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 资金方风控审核意向资方
 */
public class FactorRiskManagementIntentionalCapitalVo {

	/*融资申请id*/
	@JSONField(name="financing_apply_id")
	private Integer financingApplyId;
	/*融资申请子订单id*/
	@JSONField(name="sub_financing_apply_id")
	private Integer subFinancingApplyId;
	/*融资申请子订单号*/
	@JSONField(name="order_no")
	private String orderNo;
	/*资金方*/
	@JSONField(name="funder_name")
	private String funderName;
	/*意向融资金额*/
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/*意向融资期限*/
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/*意向融资利率*/
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/*创建日期*/
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
	@JSONField(name = "created_time", format = "yyyy-MM-dd HH:mm:ss")
	private Date createdTime;
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public Integer getSubFinancingApplyId() {
		return subFinancingApplyId;
	}
	public void setSubFinancingApplyId(Integer subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getFunderName() {
		return funderName;
	}
	public void setFunderName(String funderName) {
		this.funderName = funderName;
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
	
	
}
