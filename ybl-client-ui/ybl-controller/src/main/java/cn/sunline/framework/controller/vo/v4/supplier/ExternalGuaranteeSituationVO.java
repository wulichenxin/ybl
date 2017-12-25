package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 对外担保信息管理VO
 * @author jiangchangyuan
 *
 */
public class ExternalGuaranteeSituationVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/*融资申请id*/
	private Integer financingApplyId;
	
	/*担保金额*/
	private BigDecimal guaranteeAmount;
	
	/*期限*/
	private String term;
	
	/*被担保人*/
	private String guarantor;
	
	/*担保方式*/
	private String guaranteeMode;
	
	/*到期日期*/
	private Date expireDate;
	
	/*余额*/
	private BigDecimal balance;
	
	/*备注*/
	private String remark;

	@JSONField(name = "financing_apply_id")
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}

	@JSONField(name = "financing_apply_id")
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}

	@JSONField(name = "guarantee_amount")
	public BigDecimal getGuaranteeAmount() {
		return guaranteeAmount;
	}

	@JSONField(name = "guarantee_amount")
	public void setGuaranteeAmount(BigDecimal guaranteeAmount) {
		this.guaranteeAmount = guaranteeAmount;
	}

	@JSONField(name = "term")
	public String getTerm() {
		return term;
	}

	@JSONField(name = "term")
	public void setTerm(String term) {
		this.term = term;
	}

	@JSONField(name = "guarantor")
	public String getGuarantor() {
		return guarantor;
	}

	@JSONField(name = "guarantor")
	public void setGuarantor(String guarantor) {
		this.guarantor = guarantor;
	}

	@JSONField(name = "guarantee_mode")
	public String getGuaranteeMode() {
		return guaranteeMode;
	}

	@JSONField(name = "guarantee_mode")
	public void setGuaranteeMode(String guaranteeMode) {
		this.guaranteeMode = guaranteeMode;
	}

    @DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "expire_date",format="yyyy-MM-dd")
	public Date getExpireDate() {
		return expireDate;
	}

    @DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "expire_date",format="yyyy-MM-dd")
	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	@JSONField(name = "balance")
	public BigDecimal getBalance() {
		return balance;
	}

	@JSONField(name = "balance")
	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	@JSONField(name = "remark")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
