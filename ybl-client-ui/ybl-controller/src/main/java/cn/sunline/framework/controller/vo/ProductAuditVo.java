package cn.sunline.framework.controller.vo;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class ProductAuditVo {

	private static final long serialVersionUID = -3417796848841897451L;

	/**
	 * 融资申请id
	 */
	@JSONField(name="id_")
	private Long id;
	
	/**
	 * 融资编号
	 */
	@JSONField(name="number_")
	private String number_;
	
	/**
	 * 产品名称
	 */
	@JSONField(name="name_")
	private String name_;
	
	

	/**
	 * 用户名称
	 */
	@JSONField(name="user_name")
	private String user_name;
	
	
	
	/**
	 * 客户名称
	 */
	@JSONField(name="enterprise_name")
	private String enterprise_name;
	
	
	/**
	 * 客户手机号
	 */
	@JSONField(name="telephone_")
	private String telephone_;
	
	/**
	 * 贷款金额
	 */
	@JSONField(name="apply_amount")
	private Double apply_amount;
	
	/**
	 * 年利率
	 */
	@JSONField(name="rate_")
	private Double rate_;
	
	/**
	 * 贷款期限
	 */
	@JSONField(name="loan_period")
	private String loan_period;
	
	/**
	 * 期限类型
	 */
	@JSONField(name="period_type")
	private String period_type;
	
	/**
	 * 创建时间
	 */
	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="created_time")
	private Date created_time;
	
	/**
	 * 出账时间
	 */
	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="pay_time")
	private Date pay_time;
	
	
	/**
	 * 保理类型
	 */
	@JSONField(name="factor_type")
	private String factor_type;
	
	
	/**
	 * 审核状态
	 */
	@JSONField(name="status_")
	private String status_;
	
	
	/**
	 * 操作
	 */
	@JSONField(name="operation_")
	private String operation_;
	
	
	/**
	 * 银行账号
	 */
	@JSONField(name="account_no")
	private String account_no;
	
	
	/**
	 * 开户行 
	 */
	@JSONField(name="open_name")
	private String open_name;
	
	
	/**
	 * 法人名称
	 */
	@JSONField(name="legal_name")
	private String legal_name;
	
	
	/**
	 * 营业执照号
	 */
	@JSONField(name="license_no")
	private String license_no;
	
	
	

	public String getEnterprise_name() {
		return enterprise_name;
	}


	public void setEnterprise_name(String enterprise_name) {
		this.enterprise_name = enterprise_name;
	}


	public String getPeriod_type() {
		return period_type;
	}


	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getNumber_() {
		return number_;
	}


	public void setNumber_(String number_) {
		this.number_ = number_;
	}


	public String getName_() {
		return name_;
	}


	public void setName_(String name_) {
		this.name_ = name_;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getTelephone_() {
		return telephone_;
	}


	public void setTelephone_(String telephone_) {
		this.telephone_ = telephone_;
	}


	public Double getApply_amount() {
		return apply_amount;
	}


	public void setApply_amount(Double apply_amount) {
		this.apply_amount = apply_amount;
	}


	public Double getRate_() {
		return rate_;
	}


	public void setRate_(Double rate_) {
		this.rate_ = rate_;
	}




	public Date getCreated_time() {
		return created_time;
	}


	public void setCreated_time(Date created_time) {
		this.created_time = created_time;
	}




	public String getStatus_() {
		return status_;
	}


	public void setStatus_(String status_) {
		this.status_ = status_;
	}


	public String getOperation_() {
		return operation_;
	}


	public void setOperation_(String operation_) {
		this.operation_ = operation_;
	}


	public String getAccount_no() {
		return account_no;
	}


	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}


	public String getOpen_name() {
		return open_name;
	}


	public void setOpen_name(String open_name) {
		this.open_name = open_name;
	}


	public String getLegal_name() {
		return legal_name;
	}


	public void setLegal_name(String legal_name) {
		this.legal_name = legal_name;
	}


	public String getLicense_no() {
		return license_no;
	}


	public void setLicense_no(String license_no) {
		this.license_no = license_no;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getLoan_period() {
		return loan_period;
	}


	public void setLoan_period(String loan_period) {
		this.loan_period = loan_period;
	}


	public String getFactor_type() {
		return factor_type;
	}


	public void setFactor_type(String factor_type) {
		this.factor_type = factor_type;
	}


	public Date getPay_time() {
		return pay_time;
	}


	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}
	
	

}
