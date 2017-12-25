package com.bpm.framework.controller.login;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 产品实体类
 * @author DingMk
 *
 */
public class V2ProductVo extends AbstractEntity{

	private static final long serialVersionUID = 1L;

	private String name;
	
	private String factorName;
	
	private String type;
	
	private String desc;
	
	private BigDecimal minAmount;
	
	private BigDecimal maxAmount;
	
	private Integer minTerm;
	
	private Integer maxTerm;
	
	private BigDecimal minRate;
	
	private BigDecimal maxRate;
	
	private String rateDesc;
	
	private String introduce;
	
	private String status;

    private String url;
	
	/**
	 * 1 热门,0 不热门
	 */
	private String hot;
	
	/**
	 * 顾问点评
	 */
	private String comment;

	/**
	 * 贷款须知
	 */
	private String content;
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name="factor_name")
	public String getFactorName() {
		return factorName;
	}
	@JSONField(name="factor_name")
	public void setFactorName(String factorName) {
		this.factorName = factorName;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="desc_")
	public String getDesc() {
		return desc;
	}
	@JSONField(name="desc_")
	public void setDesc(String desc) {
		this.desc = desc;
	}
	@JSONField(name="min_amount")
	public BigDecimal getMinAmount() {
		return minAmount;
	}
	@JSONField(name="min_amount")
	public void setMinAmount(BigDecimal minAmount) {
		this.minAmount = minAmount;
	}
	@JSONField(name="max_amount")
	public BigDecimal getMaxAmount() {
		return maxAmount;
	}
	@JSONField(name="max_amount")
	public void setMaxAmount(BigDecimal maxAmount) {
		this.maxAmount = maxAmount;
	}
	@JSONField(name="min_term")
	public Integer getMinTerm() {
		return minTerm;
	}
	@JSONField(name="min_term")
	public void setMinTerm(Integer minTerm) {
		this.minTerm = minTerm;
	}
	@JSONField(name="max_term")
	public Integer getMaxTerm() {
		return maxTerm;
	}
	@JSONField(name="max_term")
	public void setMaxTerm(Integer maxTerm) {
		this.maxTerm = maxTerm;
	}
	@JSONField(name="min_rate")
	public BigDecimal getMinRate() {
		return minRate;
	}
	@JSONField(name="min_rate")
	public void setMinRate(BigDecimal minRate) {
		this.minRate = minRate;
	}
	@JSONField(name="max_rate")
	public BigDecimal getMaxRate() {
		return maxRate;
	}
	@JSONField(name="max_rate")
	public void setMaxRate(BigDecimal maxRate) {
		this.maxRate = maxRate;
	}
	@JSONField(name="rate_desc")
	public String getRateDesc() {
		return rateDesc;
	}
	@JSONField(name="rate_desc")
	public void setRateDesc(String rateDesc) {
		this.rateDesc = rateDesc;
	}
	@JSONField(name="introduce_")
	public String getIntroduce() {
		return introduce;
	}
	@JSONField(name="introduce_")
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="url_")
	public String getUrl() {
		return url;
	}

	@JSONField(name="url_")
	public void setUrl(String url) {
		this.url = url;
	}
	
	@JSONField(name="hot_")
	public String getHot() {
		return hot;
	}

	@JSONField(name="hot_")
	public void setHot(String hot) {
		this.hot = hot;
	}
	
	@JSONField(name="comment_")
	public String getComment() {
		return comment;
	}

	@JSONField(name="comment_")
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@JSONField(name="content_")
	public String getContent() {
		return content;
	}

	@JSONField(name="content_")
	public void setContent(String content) {
		this.content = content;
	}
}
