package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 融资申请综合查询VO
 * @author ZSW
 *
 */
public class ContractMangementVO extends AbstractEntity{
	private static final long serialVersionUID = 1L;
	
	//企业id
	private Long enterprise_id;
	
	private Long appid;
	
	private Long applid;

	private  Long id_; //主键id
	
	//资金方名称
	private String funder_name;
	
	
	/*保理类型0-明保理1-暗保理*/
	private Integer factoring_mode;
	
	
	
	/*融资订单号*/
	private String financing_order_number;
	
	/*融资方式0-签约资方1-平台推荐2-竞标*/
	private Integer   financing_mode;
	
	
	private Date create_time;
	
	/*资产类型0-应收账款1-应付账款2-票据*/
	private Integer assets_type;
	
	/*融资状态0-待提交1-待平台初审2-待资方初审3-待选择资方4-待资方终审5-待确定资方6-待平台复核7-待签署合同8-融资完成9-融资失败*/
	private Integer financing_status;
	

	
	/*融资金额*/
	private String financing_amount;
	
	/*融资期限*/
	private int financing_term;
	
	
	
	/*申请开始时间*/
	private String begin_date;
	
	/*申请结束时间*/
	private String end_date;
	
	
	/*
	 * 批复额度
	 */
	private BigDecimal credit_amount;

	/*
	 * 保理服务费
	 */
	
	private BigDecimal   handlingcharge;
	
	/*
	 * 资金方名称
	 */
	
	private String enterprise_name;
	
	
	private String master_contract_no;
	
	/*
	 * 合同状态
	 */
	private Integer status;

	public Long getId_() {
		return id_;
	}

	public void setId_(Long id_) {
		this.id_ = id_;
	}

	public Integer getFactoring_mode() {
		return factoring_mode;
	}

	public void setFactoring_mode(Integer factoring_mode) {
		this.factoring_mode = factoring_mode;
	}

	public String getFinancing_order_number() {
		return financing_order_number;
	}

	public void setFinancing_order_number(String financing_order_number) {
		this.financing_order_number = financing_order_number;
	}

	public Integer getFinancing_mode() {
		return financing_mode;
	}

	public void setFinancing_mode(Integer financing_mode) {
		this.financing_mode = financing_mode;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getAssets_type() {
		return assets_type;
	}

	public void setAssets_type(Integer assets_type) {
		this.assets_type = assets_type;
	}

	public Integer getFinancing_status() {
		return financing_status;
	}

	public void setFinancing_status(Integer financing_status) {
		this.financing_status = financing_status;
	}

	public String getFinancing_amount() {
		return financing_amount;
	}

	public void setFinancing_amount(String financing_amount) {
		this.financing_amount = financing_amount;
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

	public BigDecimal getCredit_amount() {
		return credit_amount;
	}

	public void setCredit_amount(BigDecimal credit_amount) {
		this.credit_amount = credit_amount;
	}

	public BigDecimal getHandlingcharge() {
		return handlingcharge;
	}

	public void setHandlingcharge(BigDecimal handlingcharge) {
		this.handlingcharge = handlingcharge;
	}

	public String getEnterprise_name() {
		return enterprise_name;
	}

	public void setEnterprise_name(String enterprise_name) {
		this.enterprise_name = enterprise_name;
	}

	public String getMaster_contract_no() {
		return master_contract_no;
	}

	public void setMaster_contract_no(String master_contract_no) {
		this.master_contract_no = master_contract_no;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getAppid() {
		return appid;
	}

	public void setAppid(Long appid) {
		this.appid = appid;
	}

	public Long getApplid() {
		return applid;
	}

	public void setApplid(Long applid) {
		this.applid = applid;
	}

	public int getFinancing_term() {
		return financing_term;
	}

	public void setFinancing_term(int financing_term) {
		this.financing_term = financing_term;
	}

	public String getFunder_name() {
		return funder_name;
	}

	public void setFunder_name(String funder_name) {
		this.funder_name = funder_name;
	}


	public Long getEnterprise_id() {
		return enterprise_id;
	}

	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}


	

}
