package com.bpm.framework.controller.v4.supplier.settlement;

import java.io.Serializable;
import java.util.Date;

public class LoanApplyParm implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1338643988074591771L;

	private Long business_id;
	
	private Integer status;
	
	private String order_no;
	
	private Integer factoring_mode;
	
	private String begin_date;
	
	private String end_date;
	
	public Long getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(Long business_id) {
		this.business_id = business_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public Integer getFactoring_mode() {
		return factoring_mode;
	}
	public void setFactoring_mode(Integer factoring_mode) {
		this.factoring_mode = factoring_mode;
	}
	public String getBegin_date() {
		return begin_date;
	}
	public void setBegin_date(String begin_date) {
		this.begin_date = begin_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

}
