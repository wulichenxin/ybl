package com.bpm.framework.controller.v4.supplier;

import java.io.Serializable;
import java.util.Date;

public class ChooseFundsVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4916980338740500586L;
	
	private Long business_id;
	
	private String financing_order_number;
	
	private Integer factoring_mode;
	
	private Integer financing_status;
	
	private Integer financing_mode;
	
	private String begin_date;
	
	private String end_date;

	public String getFinancing_order_number() {
		return financing_order_number;
	}

	public void setFinancing_order_number(String financing_order_number) {
		this.financing_order_number = financing_order_number;
	}

	public Integer getFactoring_mode() {
		return factoring_mode;
	}

	public void setFactoring_mode(Integer factoring_mode) {
		this.factoring_mode = factoring_mode;
	}

	public Integer getFinancing_status() {
		return financing_status;
	}

	public void setFinancing_status(Integer financing_status) {
		this.financing_status = financing_status;
	}


	public Integer getFinancing_mode() {
		return financing_mode;
	}

	public void setFinancing_mode(Integer financing_mode) {
		this.financing_mode = financing_mode;
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

	public Long getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(Long business_id) {
		this.business_id = business_id;
	}
	
	
	
	
	

}
