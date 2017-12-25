package cn.sunline.framework.controller.vo.v4.drools;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 保理产品参数对象V4
 * @author pc
 *
 */
public class V4ProductVO extends AbstractEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1052755679422617135L;
	/**
	 * 图片地址
	 */
	@JSONField(name = "url_")
	private String url;
	/**
	 * 产品名称
	 */
	@JSONField(name = "name_")
	private String name;
	/**
	 * 保理商名称
	 */
	@JSONField(name = "factor_name")
	private String factorName;
	/**
	 * 产品描述
	 */
	@JSONField(name = "desc_")
	private String desc;
	/**
	 * 保理类型1-池保理2-正向保理
	 */
	@JSONField(name = "type_")
	private Integer type;
	/**
	 * 是否热门1-是2-否
	 */
	@JSONField(name = "hot_")
	private Integer hot;
	/**
	 * 最小贷款金额
	 */
	@JSONField(name = "min_amount")
	private BigDecimal minAmount;
	/**
	 * 最大贷款金额
	 */
	@JSONField(name = "max_amount")
	private BigDecimal maxAmount;
	/**
	 * 最小贷款期限
	 */
	@JSONField(name = "min_term")
	private Integer minTerm;
	/**
	 * 最大贷款期限
	 */
	@JSONField(name = "max_term")
	private Integer maxTerm;
	/**
	 * 贷款年利率
	 */
	@JSONField(name = "rate")
	private BigDecimal rate;
	/**
	 * 提前还款说明
	 */
	@JSONField(name = "prepayment_")
	private String prepayment;
	/**
	 * 顾问点评
	 */
	@JSONField(name = "adviser_comment")
	private String adviserComment;
	/**
	 * 贷款须知
	 */
	@JSONField(name = "loan_notice")
	private String loanNotice;
	/**
	 *状态 1,上架 2，下架
	 */
	@JSONField(name = "status_")
	private Integer status;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFactorName() {
		return factorName;
	}
	public void setFactorName(String factorName) {
		this.factorName = factorName;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getHot() {
		return hot;
	}
	public void setHot(Integer hot) {
		this.hot = hot;
	}
	public BigDecimal getMinAmount() {
		return minAmount;
	}
	public void setMinAmount(BigDecimal minAmount) {
		this.minAmount = minAmount;
	}
	public BigDecimal getMaxAmount() {
		return maxAmount;
	}
	public void setMaxAmount(BigDecimal maxAmount) {
		this.maxAmount = maxAmount;
	}
	public Integer getMinTerm() {
		return minTerm;
	}
	public void setMinTerm(Integer minTerm) {
		this.minTerm = minTerm;
	}
	public Integer getMaxTerm() {
		return maxTerm;
	}
	public void setMaxTerm(Integer maxTerm) {
		this.maxTerm = maxTerm;
	}
	public BigDecimal getRate() {
		return rate;
	}
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	public String getPrepayment() {
		return prepayment;
	}
	public void setPrepayment(String prepayment) {
		this.prepayment = prepayment;
	}
	public String getAdviserComment() {
		return adviserComment;
	}
	public void setAdviserComment(String adviserComment) {
		this.adviserComment = adviserComment;
	}
	public String getLoanNotice() {
		return loanNotice;
	}
	public void setLoanNotice(String loanNotice) {
		this.loanNotice = loanNotice;
	}
}
