package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ProductVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7646212644648218883L;

	/**
	 * 产品名称
	 */
	@JSONField(name = "name_")
	private String name_;

	/**
	 * 保理类型
	 * 线上明保理：online_factor;线下明保理：offline_factor;暗保理：dark_factor。
	 */
	@JSONField(name = "type_")
	private String type_;

	/**
	 * 描述
	 */
	@JSONField(name = "desc_")
	private String desc_;

	/**
	 * 还款方式
	 */
	@JSONField(name = "repayment_type")
	private String repayment_type;

	/**
	 * 还款日规则
	 */
	@JSONField(name = "repayment_date_rule")
	private String repayment_date_rule;

	/**
	 * 贷款方式
	 */
	@JSONField(name = "loan_type")
	private String loan_type;
	
	/**
	 * 产品发起方：平台（terrace）；保理商（factor）
	 */
	@JSONField(name = "initiator_")
	private String initiator_;
	
	
	/**
	 * 产品审核状态：待审核（authstr）；审核通过（pass_the_audit）;审核不通过（audit_not_through）
	 */
	@JSONField(name = "audit_status")
	private String audit_status;

	/**
	 * 期限
	 */
	@JSONField(name = "term_")
	private Integer term_;

	/**
	 * 贷款年利率
	 */
	@JSONField(name = "rate_")
	private BigDecimal rate_;

	/**
	 * 逾期日利率
	 */
	@JSONField(name = "overdue_rate")
	private BigDecimal overdue_rate;

	/**
	 * 管理费年利率
	 */
	@JSONField(name = "manage_rate")
	private BigDecimal manage_rate;

	/**
	 * 违约利率
	 */
	@JSONField(name = "penalty_rate")
	private BigDecimal penalty_rate;

	/**
	 * 融资比例
	 */
	@JSONField(name = "finance_ratio")
	private BigDecimal finance_ratio;

	/**
	 * 状态
	 * 上线：online;下线：offline
	 */
	@JSONField(name = "status_")
	private String status_;

	/**
	 * 预计放款天数
	 */
	@JSONField(name = "prepare_lending_daily")
	private Integer prepare_lending_daily;

	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterprise_id;
	/**
	 * 后台发布产品关联id(关联到ybl_product_relevance表id)
	 */
	@JSONField(name = "product_relevance_id")
	private Long product_relevance_id;
	
	
	/**
	 * 产品图片
	 * @return
	 */
	@JSONField(name = "url_")
	private String url_;
	
	

	public String getUrl_() {
		return url_;
	}

	public void setUrl_(String url_) {
		this.url_ = url_;
	}

	public String getName_() {
		return name_;
	}

	public void setName_(String name_) {
		this.name_ = name_;
	}

	public String getType_() {
		return type_;
	}

	public void setType_(String type_) {
		this.type_ = type_;
	}

	public String getDesc_() {
		return desc_;
	}

	public void setDesc_(String desc_) {
		this.desc_ = desc_;
	}

	public String getRepayment_type() {
		return repayment_type;
	}

	public void setRepayment_type(String repayment_type) {
		this.repayment_type = repayment_type;
	}

	public String getRepayment_date_rule() {
		return repayment_date_rule;
	}

	public void setRepayment_date_rule(String repayment_date_rule) {
		this.repayment_date_rule = repayment_date_rule;
	}

	public String getLoan_type() {
		return loan_type;
	}

	public void setLoan_type(String loan_type) {
		this.loan_type = loan_type;
	}

	public Integer getTerm_() {
		return term_;
	}

	public void setTerm_(Integer term_) {
		this.term_ = term_;
	}

	public BigDecimal getRate_() {
		return rate_;
	}

	public void setRate_(BigDecimal rate_) {
		this.rate_ = rate_;
	}

	public BigDecimal getOverdue_rate() {
		return overdue_rate;
	}

	public void setOverdue_rate(BigDecimal overdue_rate) {
		this.overdue_rate = overdue_rate;
	}

	public BigDecimal getManage_rate() {
		return manage_rate;
	}

	public void setManage_rate(BigDecimal manage_rate) {
		this.manage_rate = manage_rate;
	}

	public BigDecimal getPenalty_rate() {
		return penalty_rate;
	}

	public void setPenalty_rate(BigDecimal penalty_rate) {
		this.penalty_rate = penalty_rate;
	}

	public BigDecimal getFinance_ratio() {
		return finance_ratio;
	}

	public void setFinance_ratio(BigDecimal finance_ratio) {
		this.finance_ratio = finance_ratio;
	}

	public String getStatus_() {
		return status_;
	}

	public void setStatus_(String status_) {
		this.status_ = status_;
	}

	public Integer getPrepare_lending_daily() {
		return prepare_lending_daily;
	}

	public void setPrepare_lending_daily(Integer prepare_lending_daily) {
		this.prepare_lending_daily = prepare_lending_daily;
	}

	public Long getEnterprise_id() {
		return enterprise_id;
	}

	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getInitiator_() {
		return initiator_;
	}

	public void setInitiator_(String initiator_) {
		this.initiator_ = initiator_;
	}

	public String getAudit_status() {
		return audit_status;
	}

	public void setAudit_status(String audit_status) {
		this.audit_status = audit_status;
	}
	

	public Long getProduct_relevance_id() {
		return product_relevance_id;
	}

	public void setProduct_relevance_id(Long product_relevance_id) {
		this.product_relevance_id = product_relevance_id;
	}

	@Override
	public String toString() {
		return "ProductVo [name_=" + name_ + ", type_=" + type_ + ", desc_=" + desc_ + ", repayment_type="
				+ repayment_type + ", repayment_date_rule=" + repayment_date_rule + ", loan_type=" + loan_type
				+ ", initiator_=" + initiator_ + ", audit_status=" + audit_status + ", term_=" + term_ + ", rate_="
				+ rate_ + ", overdue_rate=" + overdue_rate + ", manage_rate=" + manage_rate + ", penalty_rate="
				+ penalty_rate + ", finance_ratio=" + finance_ratio + ", status_=" + status_
				+ ", prepare_lending_daily=" + prepare_lending_daily + ", enterprise_id=" + enterprise_id + ", id=" + id
				+ ", createdTime=" + createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime
				+ ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1="
				+ attribute1 + ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4="
				+ attribute4 + ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7="
				+ attribute7 + ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10="
				+ attribute10 + ", rowNo=" + rowNo + "]";
	}

}
