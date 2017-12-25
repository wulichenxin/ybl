package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 放款综合综合查询子查询VO
 * @author ZSW
 *
 */
public class LoanapplyChildrenQueryVO extends AbstractEntity{
	/*
	 * 放款申请id
	 */
	private Long id_;
	/*
	 * 放款申请，融资子定单的id
	 */
	private Integer subid;
	
	private Long payment_batch_id;
	
	private BigDecimal paid_platform_fee ;
	
	private Long  financing_apply_id;
	
	private String order_no;
	

	
	private String enterprise_name;
	
	
	private int assets_type;
	
	private BigDecimal financing_amount;
	
	private Integer financing_term;
	
	private String  financing_status;
	
	private BigDecimal financing_rate;
	
	private Date created_time;
	
	private BigDecimal actual_loan_amount;
	
	private BigDecimal totalrepaymoney;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date lasttime;
	
	private String order_nos;
	
	private int status;
	
	private int repayment_status;
	
	
	

	public Long getId_() {
		return id_;
	}

	public void setId_(Long id_) {
		this.id_ = id_;
	}

	public Long getFinancing_apply_id() {
		return financing_apply_id;
	}

	public void setFinancing_apply_id(Long financing_apply_id) {
		this.financing_apply_id = financing_apply_id;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}



	public int getAssets_type() {
		return assets_type;
	}

	public void setAssets_type(int assets_type) {
		this.assets_type = assets_type;
	}

	public BigDecimal getFinancing_amount() {
		return financing_amount;
	}

	public void setFinancing_amount(BigDecimal financing_amount) {
		this.financing_amount = financing_amount;
	}



	public BigDecimal getFinancing_rate() {
		return financing_rate;
	}

	public void setFinancing_rate(BigDecimal financing_rate) {
		this.financing_rate = financing_rate;
	}

	public Date getCreated_time() {
		return created_time;
	}

	public void setCreated_time(Date created_time) {
		this.created_time = created_time;
	}

	public BigDecimal getActual_loan_amount() {
		return actual_loan_amount;
	}

	public void setActual_loan_amount(BigDecimal actual_loan_amount) {
		this.actual_loan_amount = actual_loan_amount;
	}

	public BigDecimal getTotalrepaymoney() {
		return totalrepaymoney;
	}

	public void setTotalrepaymoney(BigDecimal totalrepaymoney) {
		this.totalrepaymoney = totalrepaymoney;
	}

	public Date getLasttime() {
		return lasttime;
	}

	public void setLasttime(Date lasttime) {
		this.lasttime = lasttime;
	}

	public String getOrder_nos() {
		return order_nos;
	}

	public void setOrder_nos(String order_nos) {
		this.order_nos = order_nos;
	}



	public int getRepayment_status() {
		return repayment_status;
	}

	public void setRepayment_status(int repayment_status) {
		this.repayment_status = repayment_status;
	}

	public BigDecimal getPaid_platform_fee() {
		return paid_platform_fee;
	}

	public void setPaid_platform_fee(BigDecimal paid_platform_fee) {
		this.paid_platform_fee = paid_platform_fee;
	}

	public Long getPayment_batch_id() {
		return payment_batch_id;
	}

	public void setPayment_batch_id(Long payment_batch_id) {
		this.payment_batch_id = payment_batch_id;
	}

	public Integer getFinancing_term() {
		return financing_term;
	}

	public void setFinancing_term(Integer financing_term) {
		this.financing_term = financing_term;
	}

	public Integer getSubid() {
		return subid;
	}

	public void setSubid(Integer subid) {
		this.subid = subid;
	}

	public String getEnterprise_name() {
		return enterprise_name;
	}

	public void setEnterprise_name(String enterprise_name) {
		this.enterprise_name = enterprise_name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getFinancing_status() {
		return financing_status;
	}

	public void setFinancing_status(String financing_status) {
		this.financing_status = financing_status;
	}

	
	
	
	
	
	



}
